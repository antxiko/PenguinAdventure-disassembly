#!/usr/bin/env python3
"""Propone las directivas D de un banco, partiendo por donde apunta el codigo.

No decide nada: PROPONE, y la propuesta hay que mirarla y ponerle nombre. Lo
que hace es el trabajo mecanico de cerrar el presupuesto:

  - coge los huecos que quedan (ni codigo trazado ni rango D ya declarado);
  - los parte por cada direccion a la que apunte una instruccion del codigo
    trazado, contando solo las instrucciones que se ejecutan CON ESE BANCO
    PUESTO (en 0x8000 hay cinco bancos distintos segun el momento, y un
    puntero de otro reparto no prueba nada);
  - parte tambien por las fronteras de los bloques comprimidos, cuando el
    trozo es una cadena RLE que encaja sin holgura (tools/rle.py);
  - y separa la cola de 0xFF, que es relleno hasta los 8 KB.

Cada linea sale con el apuntador que la justifica escrito al lado. Un rango sin
apuntador no es un fallo: puede ser la continuacion de una tabla que se recorre
seguida. Pero hay que decirlo, no callarlo.

Uso: propone_datos.py <rom> <dir_work> <dir_src> pNN [pNN ...]
"""
import json
import os
import sys

from bancos import traza_completa
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre
from rle import cadena

RANURA = {0x4000: 0, 0x6000: 0, 0x8000: 1, 0xA000: 2}   # el 0x4000 no tiene registro


def marcas(rom, work, src, p):
    """0 = sin explicar, 1 = codigo trazado, 2 = ya declarado como datos."""
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(work, nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - o, b - o):
                    m[i] = 1
    notas = os.path.join(src, nombre(p) + ".notes")
    if os.path.exists(notas):
        for ln in open(notas, encoding="utf-8"):
            if ln.startswith("D "):
                q = ln.split(None, 3)
                for i in range(max(0, int(q[1], 0) - o),
                               min(TAM_PAGINA, int(q[2], 0) - o)):
                    m[i] = 2
    return m


def apuntadores(rom, t, p):
    """{direccion: [texto del apuntador]} con el banco p puesto de verdad."""
    o = ORG[p]
    ranura = RANURA[o]
    fuera = {}
    for b, pc in sorted(t.arranques):
        off = b * TAM_PAGINA + (pc & 0x1FFF)
        op = rom[off]
        w = None
        if op in (0x01, 0x11, 0x21, 0x31, 0x22, 0x2A, 0x32, 0x3A) \
                and (pc & 0x1FFF) + 3 <= TAM_PAGINA:
            w = rom[off + 1] | (rom[off + 2] << 8)
        elif op in (0xDD, 0xFD) and (pc & 0x1FFF) + 4 <= TAM_PAGINA \
                and rom[off + 1] in (0x21, 0x22, 0x2A):
            w = rom[off + 2] | (rom[off + 3] << 8)
        if op == 0x32 and w in (0x6000, 0x8000, 0xA000):
            continue          # es una escritura al mapper, no un puntero
        if w is None or not (o <= w < o + TAM_PAGINA):
            continue
        # El banco 0 esta SIEMPRE en 0x4000: no hay reparto que comprobar.
        if p and p not in {c[ranura] for c in t.config_de[(b, pc)]}:
            continue
        fuera.setdefault(w, []).append("%s:%04X" % (nombre(b), pc))
    return fuera


def cola_ff(rom, p):
    """Donde empieza la cola de 0xFF del banco (o None si no la hay)."""
    base = p * TAM_PAGINA
    i = TAM_PAGINA - 1
    while i >= 0 and rom[base + i] == 0xFF:
        i -= 1
    return ORG[p] + i + 1 if i < TAM_PAGINA - 1 else None


def main(rom_path, work, src, *cuales):
    rom = open(rom_path, "rb").read()
    t, _ = traza_completa(rom, src)
    pags = [int(c[1:], 10) for c in cuales] if cuales else list(range(N_PAGINAS))
    for p in pags:
        o = ORG[p]
        m = marcas(rom, work, src, p)
        ap = apuntadores(rom, t, p)
        ff = cola_ff(rom, p)
        cortes = {a - o for a in ap if 0 <= a - o < TAM_PAGINA}
        if ff is not None:
            cortes.add(ff - o)
        huecos, ini = [], None
        for i in range(TAM_PAGINA + 1):
            v = m[i] if i < TAM_PAGINA else 1
            if not v and ini is None:
                ini = i
            elif v and ini is not None:
                huecos.append((ini, i))
                ini = None
        print("# ---- %s (org %#06x): %d bytes sin explicar ----"
              % (nombre(p), o, sum(b - a for a, b in huecos)))
        for a, b in huecos:
            puntos = sorted({a, b} | {c for c in cortes if a < c < b})
            for x, y in zip(puntos, puntos[1:]):
                quien = ap.get(o + x)
                trozo = rom[p * TAM_PAGINA + x:p * TAM_PAGINA + y]
                if set(trozo) == {0xFF}:
                    que = "relleno 0xFF hasta los 8 KB del banco"
                    nom = "relleno"
                elif quien:
                    que = "lo apunta " + " ".join(quien[:4])
                    nom = "datos_%04X" % (o + x)
                else:
                    que = "NADIE lo apunta directamente"
                    nom = "datos_%04X" % (o + x)
                print("D 0x%04X 0x%04X %s   %s   (%d bytes)"
                      % (o + x, o + y, nom, que, y - x))
                bloques, fin = cadena(rom, p, o + x, o + y)
                if fin == o + y and len(bloques) > 1 and (y - x) > 32:
                    print("#   cadena RLE que encaja: %d bloques -> %s"
                          % (len(bloques),
                             " ".join("%04X" % q[0] for q in bloques[:12])))
    return 0


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
