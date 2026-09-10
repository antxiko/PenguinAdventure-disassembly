#!/usr/bin/env python3
"""Pone nombre a las llamadas que cruzan de banco.

Dos cosas distintas:

  - LAS QUE VAN AL BANCO 0, que esta FIJO en 0x4000-0x5FFF: un `call 0x4265`
    quiere decir lo mismo se haga desde donde se haga, asi que se le pone el
    NOMBRE de la rutina.
  - LAS QUE VAN A OTRA RANURA (0x6000-0xBFFF): ahi la misma direccion puede ser
    seis bancos distintos, asi que lo unico que se puede decir con seguridad es
    a que banco cae, y eso se sabe siguiendo las escrituras al mapper desde el
    principio del listado. Es justo el dato que al leer falta: `call 0xB616` no
    dice nada, `call 0xB616 -> banco 9` si.

Los nombres NO estan escritos aqui: se leen de las directivas `L` de
src/p00.notes, que es donde se bautizan las rutinas. Asi no pueden desincronizarse:
si una rutina se renombra, esto cambia solo la proxima vez que se corre.

Uso:  anota_llamadas.py <banco> [--anexa]
      anota_llamadas.py --todos --anexa
"""
import io
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import nombre                                   # noqa: E402

BANCOS_CON_CODIGO = (1, 2, 3, 9, 14)

CABECERA = """
# --- Las llamadas al banco 0, que esta fijo en 0x4000-0x5FFF. Los nombres los
# saca tools/anota_llamadas.py de las directivas L de src/p00.notes.
"""


def nombres_del_banco_0():
    fuera = {}
    ruta = os.path.join(RAIZ, "src", "p00.notes")
    for ln in io.open(ruta, encoding="utf-8"):
        m = re.match(r"^L 0x([0-9A-Fa-f]{4})\s+(\S+)", ln)
        if m:
            fuera[int(m.group(1), 16)] = m.group(2)
    return fuera


# Con que trio se ejecuta cada banco cuando nadie ha tocado el mapper todavia.
TRIO = {1: (1, 2, 3), 2: (1, 2, 3), 3: (1, 2, 3), 9: (7, 8, 9), 14: (1, 14, 15)}


def anota(banco, mapa):
    asm = os.path.join(RAIZ, "src", "penguinadventure_%s.asm" % nombre(banco))
    notas = os.path.join(RAIZ, "src", "%s.notes" % nombre(banco))
    ya = set()
    if os.path.exists(notas):
        for ln in io.open(notas, encoding="utf-8"):
            m = re.match(r"^C 0x([0-9A-Fa-f]{4})\s", ln)
            if m:
                ya.add(int(m.group(1), 16))
    salida = []
    bancos = TRIO.get(banco, (1, 2, 3))
    val = None
    for l in io.open(asm, encoding="utf-8"):
        m = re.search(r"^\s*(.*?)\s*;\s?([0-9a-f]{4})(?:\s|$)", l)
        if not m or not m.group(1):
            continue
        dir_, ins = int(m.group(2), 16), m.group(1).strip()
        # seguir el mapper para saber que banco hay en cada ranura
        mm = re.match(r"ld a,0([0-9a-f]{2})h$", ins)
        if mm:
            val = int(mm.group(1), 16)
        elif ins == "inc a" and val is not None:
            val += 1
        else:
            mm = re.match(r"ld \(0(6000|8000|a000)h\),a$", ins)
            if mm and val is not None and val < 16:
                k = {"6000": 0, "8000": 1, "a000": 2}[mm.group(1)]
                bancos = tuple(val if j == k else bancos[j] for j in range(3))
        if dir_ in ya:
            continue
        mm = re.match(r"(?:call|jp)(?: [a-z]{1,2},)? 0([0-9a-f]{4})h$", ins)
        if not mm:
            continue
        destino = int(mm.group(1), 16)
        if 0x4000 <= destino < 0x6000:
            if destino not in mapa:
                continue
            ya.add(dir_)
            salida.append("C 0x%04X banco 0: %s" % (dir_, mapa[destino]))
        elif 0x6000 <= destino < 0xC000:
            b = bancos[(destino >> 13) - 3]
            if b == banco:
                continue                     # dentro del propio banco: ya lo
                                             # resuelve la etiqueta del listado
            ya.add(dir_)
            salida.append("C 0x%04X banco %d" % (dir_, b))
    return salida, notas


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    mapa = nombres_del_banco_0()
    if not mapa:
        sys.exit("src/p00.notes no bautiza ninguna rutina")
    bancos = BANCOS_CON_CODIGO if "--todos" in sys.argv else [int(sys.argv[1], 10)]
    for b in bancos:
        salida, notas = anota(b, mapa)
        if "--anexa" in sys.argv:
            if salida:
                with io.open(notas, "a", encoding="utf-8", newline="\n") as f:
                    f.write(CABECERA + "\n".join(salida) + "\n")
            print("%s: %d comentarios" % (os.path.basename(notas), len(salida)))
        else:
            print("\n".join(salida))


if __name__ == "__main__":
    main()
