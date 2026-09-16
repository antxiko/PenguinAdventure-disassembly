#!/usr/bin/env python3
"""Declara los bloques de datos que el codigo LEE, recorriendolos como el cartucho.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion que lo lee. Aqui la instruccion es una llamada a uno de los
lectores del banco 0, y el trazador de cartucho entero (tools/bancos.py) ya
sabe, para cada llamada, que valen HL y DE y que bancos hay puestos en cada
ranura. Con eso:

  1. se coge el puntero que el lector va a leer (HL o DE, segun el lector);
  2. el banco al que cae sale del reparto de ese momento, no de suponerlo;
  3. y el final del bloque sale de RECORRER el formato como lo recorre el
     lector, byte a byte, hasta su marca de fin. No hay longitudes a ojo.

Los formatos, leidos en el listado del banco 0:

  mandos  (descomprime 0x418C, pinta_sin_color 0x4381, pinta 0x4386,
           pinta_en_los_tres 0x42A4/0x42A8)
          [destino, solo si el lector lo lee] y una tira de mandos:
          0x00 acaba; 0x80 da otro destino (dos bytes); bit 7 puesto, los siete
          de abajo son cuantos bytes van tal cual; bit 7 claro, cuantas veces
          se repite el byte que viene.
  fffe    (copia_bloques 0x41BF, rellena_de_unos 0x41AD,
           pinta_guion_con_mascara 0x42BC/0x42BE)
          destino y bytes sueltos: 0xFF acaba y 0xFE da otro destino.

Lo que sale se escribe, pagina a pagina, en una seccion delimitada de
src/pNN.notes que esta herramienta reescribe entera; lo de fuera no lo toca.
Un bloque que pise codigo trazado o una D escrita a mano NO se escribe: se
avisa, porque o el trazado o la nota estan mal y hay que mirarlo.

Uso: bloques.py              informa de lo que encontraria
     bloques.py --escribe    y lo escribe en las notas
"""
import json
import os
import re
import sys
from collections import defaultdict

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from bancos import traza_completa                            # noqa: E402
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre        # noqa: E402

ROM = os.path.join(RAIZ, "penguinadventure.rom")
SRC = os.path.join(RAIZ, "src")
WORK = os.path.join(RAIZ, "work")

INI = "# --- BLOQUES QUE LEE EL CODIGO (seccion que reescribe tools/bloques.py; no editar a mano) ---"
FIN = "# --- fin de los bloques de bloques.py ---"

# lector: (nombre, registro con el puntero, formato, lee el destino del guion)
LECTORES = {
    0x418C: ("descomprime", "hl", "mandos", True),
    0x41AD: ("rellena_de_unos", "hl", "fffe", True),
    0x41BF: ("copia_bloques", "hl", "fffe", True),
    0x42BC: ("pinta_guion_con_mascara", "de", "fffe", True),
    0x42BE: ("pinta_guion_lee_destino", "de", "fffe", True),
    0x4381: ("pinta_sin_color", "de", "mandos", True),
    0x4386: ("pinta", "de", "mandos", False),
    0x42A4: ("pinta_en_los_tres_con_color", "de", "mandos", False),
    0x42A8: ("pinta_en_los_tres", "de", "mandos", False),
    # Destino y B columnas de 16 bytes, o de 32 si el bit 0 de C pide espejo:
    # 0x43BF empuja DE, pinta la columna y la vuelve a pintar del reves desde
    # el mismo DE; con espejo pinta dos y salta 16 mas (0x43DD).
    0x43B3: ("pinta_bloque", "de", "bloque", True),
}
TRAZ = object()     # "lo que diga el trazador"
TRAZA = None        # la traza completa, para los recorridos que la necesitan
AVISOS_RECORRIDOS = []
# Los lectores se llaman entre ellos y saltan dentro de si mismos con DE a
# mitad de guion: esas llamadas no son un puntero nuevo.
DENTRO_DE_LOS_LECTORES = (0x418C, 0x4448)


class FueraDelBanco(Exception):
    pass


def leer(rom, s, a):
    """El byte de `a` con el reparto `s` puesto: un guion puede seguir en la ranura de al lado."""
    b = banco_de(a, s)
    if b is None or b >= N_PAGINAS or not ORG[b] <= a < ORG[b] + TAM_PAGINA:
        raise FueraDelBanco("%04X no cae en ningun banco con el reparto %s" % (a, s))
    return rom[b * TAM_PAGINA + (a - ORG[b])]


def trozos(s, a, f):
    """El rango [a, f) partido por bancos: [(banco, ini, fin)]."""
    fuera = []
    while a < f:
        b = banco_de(a, s)
        tope = min(f, (a & 0xE000) + 0x2000)
        fuera.append((b, a, tope))
        a = tope
    return fuera


def fin_mandos(rom, b, a, con_destino):
    """Recorre un guion de mandos. Devuelve (fin, bytes que produce)."""
    if con_destino:
        leer(rom, b, a + 1)
        a += 2
    n_out = 0
    while True:
        m = leer(rom, b, a)
        a += 1
        if m == 0x00:
            return a, n_out
        n = m & 0x7F
        if n == m:                  # repetir el byte siguiente
            leer(rom, b, a)
            a += 1
            n_out += n
        elif n == 0:                # otro destino
            leer(rom, b, a + 1)
            a += 2
        else:                       # n literales
            leer(rom, b, a + n - 1)
            a += n
            n_out += n
        if n_out > 0x10000:
            raise FueraDelBanco("guion sin fin")


def fin_fffe(rom, b, a):
    leer(rom, b, a + 1)
    a += 2
    n_out = 0
    while True:
        v = leer(rom, b, a)
        a += 1
        if v == 0xFF:
            return a, n_out
        if v == 0xFE:
            leer(rom, b, a + 1)
            a += 2
        else:
            n_out += 1


def banco_de(ptr, s):
    if 0x4000 <= ptr < 0x6000:
        return 0
    if 0x6000 <= ptr < 0xC000:
        return s[(ptr - 0x6000) // 0x2000]
    return None


# ------------------------------------------------ lo que el trazador no ve
# El trazador sigue el reparto de bancos instruccion a instruccion, pero una
# llamada la da por neutra: si la subrutina cambia de banco y vuelve, sigue
# creyendo que estan los de antes. Y este cartucho tiene muchas subrutinas que
# no hacen OTRA cosa que cambiar de banco (p01:6F71 pone el 10 y el 11 y
# vuelve). Con eso un puntero cae en el banco que no es. Aqui se corrige
# mirando el listado: se simula el tramo lineal que lleva hasta la lectura,
# aplicando las escrituras al mapper y el efecto de esas subrutinas.
REG_MAPPER = {0x6000: 0, 0x8000: 1, 0xA000: 2}
INOCUAS = re.compile(r"^(di|ei|inc a|inc hl|push hl|pop hl|ld hl,0f0f[123]h|"
                     r"ld \(hl\),a|ld \(0f0f[123]h\),a|ld a,0[0-9a-f]{2}h|"
                     r"ld \(0[68a]000h\),a|nop)$")


def lee_listado(p):
    """[(dir, instruccion)] en orden y {etiqueta: dir} del listado de un banco."""
    ruta = os.path.join(SRC, "penguinadventure_%s.asm" % nombre(p))
    ins, etiq, pend = [], {}, []
    if not os.path.exists(ruta):
        return ins, etiq
    for ln in open(ruta, encoding="utf-8", errors="replace"):
        m = re.match(r"^([A-Za-z_][\w]*):", ln)
        if m:
            pend.append(m.group(1))
            continue
        m = re.match(r"^\s+([^;]+?)\s*;([0-9a-f]{4})\b", ln)
        if m:
            a = int(m.group(2), 16)
            for x in pend:
                etiq[x] = a
            pend = []
            ins.append((a, m.group(1).strip().lower()))
    return ins, etiq


def valor(txt):
    m = re.fullmatch(r"0?([0-9a-f]+)h", txt)
    return int(m.group(1), 16) if m else None


class Listados:
    def __init__(self):
        self.ins, self.etiq, self.idx = {}, {}, {}
        for p in range(N_PAGINAS):
            i, e = lee_listado(p)
            self.ins[p], self.etiq[p] = i, {k.lower(): v for k, v in e.items()}
            self.idx[p] = {a: k for k, (a, _) in enumerate(i)}
        self._efecto = {}

    def destino(self, p, txt):
        v = valor(txt)
        if v is not None:
            return (0 if 0x4000 <= v < 0x6000 else p), v
        if txt in self.etiq[p]:
            return p, self.etiq[p][txt]
        if txt in self.etiq[0]:
            return 0, self.etiq[0][txt]
        return None, None

    def efecto(self, p, a):
        """Si la rutina de p:a solo cambia de banco y vuelve: {ranura: banco}. Si no, None."""
        k = (p, a)
        if k in self._efecto:
            return self._efecto[k]
        self._efecto[k] = None
        if a not in self.idx.get(p, {}):
            return None
        acc, ef = None, {}
        for _, t in self.ins[p][self.idx[p][a]:self.idx[p][a] + 30]:
            if t == "ret":
                self._efecto[k] = ef
                return ef
            if not INOCUAS.match(t):
                return None
            v = re.fullmatch(r"ld a,(0[0-9a-f]{2}h)", t)
            if v:
                acc = valor(v.group(1))
            elif t == "inc a" and acc is not None:
                acc += 1
            m = re.fullmatch(r"ld \((0[68a]000h)\),a", t)
            if m:
                if acc is None:
                    return None
                ef[REG_MAPPER[valor(m.group(1))]] = acc
        return None

    def puentes(self):
        """Rutinas que solo cambian de banco y caen en un lector: {(banco, dir): (lector, efecto)}.

        p01:7DF7 pone el 10 y el 11 y llama a pinta_guion_con_mascara con el DE
        que le traigan. Para el trazador, dentro de ella DE ya no es constante
        -llega de muchos sitios-, pero en cada llamada a p01:7DF7 si lo es.
        """
        fuera = {}
        for p in range(N_PAGINAS):
            for et, a in self.etiq[p].items():
                if a not in self.idx[p]:
                    continue
                acc, ef = None, {}
                for _, t in self.ins[p][self.idx[p][a]:self.idx[p][a] + 30]:
                    # `_` es la direccion de la instruccion: la del salto final
                    # se guarda para no contarla dos veces
                    m = re.fullmatch(r"(call|jp) ([^,]+)", t)
                    if m:
                        bp, da = self.destino(p, m.group(2))
                        if bp == 0 and da in LECTORES and ef:
                            fuera[(p, a)] = (da, dict(ef), _)
                        break
                    if re.fullmatch(r"ld c,0[0-9a-f]{2}h", t):
                        continue
                    if not INOCUAS.match(t):
                        break
                    v = re.fullmatch(r"ld a,(0[0-9a-f]{2}h)", t)
                    if v:
                        acc = valor(v.group(1))
                    elif t == "inc a" and acc is not None:
                        acc += 1
                    mm = re.fullmatch(r"ld \((0[68a]000h)\),a", t)
                    if mm:
                        if acc is None:
                            break
                        ef[REG_MAPPER[valor(mm.group(1))]] = acc
        return fuera

    def toca_hl(self, p, a):
        """Una rutina de cambiar de banco, deja HL como estaba?"""
        ts = [t for _, t in self.ins[p][self.idx[p][a]:self.idx[p][a] + 30]]
        ts = ts[:ts.index("ret") + 1] if "ret" in ts else ts
        if "push hl" in ts and "pop hl" in ts:
            return False
        return any(t.startswith("ld hl,") or t == "inc hl" for t in ts)

    def simula(self, rom, p, pc, s):
        """Simula el tramo lineal que lleva a p:pc.

        Devuelve (reparto, {"hl", "de", "b", "c"}, aviso). Un registro vale
        TRAZ si en el tramo nadie lo toca -entonces manda lo que dice el
        trazador- y None si lo ha tocado algo que no se sabe que hace.
        """
        reg = {"hl": TRAZ, "de": TRAZ, "b": None, "c": None}
        if pc not in self.idx.get(p, {}):
            return s, reg, None
        k = self.idx[p][pc]
        ini = k
        while ini > 0 and k - ini < 60:
            t = self.ins[p][ini - 1][1]
            if t in ("ret", "reti", "retn") or re.fullmatch(r"(jp|jr) [^,]+", t) or t.startswith("jp ("):
                break
            ini -= 1
        acc, puesto = None, {}
        s_vivo = list(s)

        def reparto():
            s2 = list(s)
            for r, v in puesto.items():
                s2[r] = v
            return tuple(s2)

        for j in range(ini, k):
            a, t = self.ins[p][j]
            m = re.fullmatch(r"ld (hl|de|bc),(0?[0-9a-f]+h)", t)
            if m:
                v = valor(m.group(2))
                if m.group(1) == "bc":
                    reg["b"], reg["c"] = v >> 8, v & 0xFF
                else:
                    reg[m.group(1)] = v
                continue
            m = re.fullmatch(r"ld (b|c),(0?[0-9a-f]+h)", t)
            if m:
                reg[m.group(1)] = valor(m.group(2))
                continue
            if t == "ex de,hl":
                reg["hl"], reg["de"] = reg["de"], reg["hl"]
                continue
            m = re.fullmatch(r"(inc|dec) (hl|de)", t)
            if m:
                if isinstance(reg[m.group(2)], int):
                    reg[m.group(2)] += 1 if m.group(1) == "inc" else -1
                continue
            m = re.fullmatch(r"pop (hl|de|bc)", t)
            if m:
                if m.group(1) == "bc":
                    reg["b"] = reg["c"] = None
                else:
                    reg[m.group(1)] = None
                continue
            v = re.fullmatch(r"ld a,(0[0-9a-f]{2}h)", t)
            if v:
                acc = valor(v.group(1))
                continue
            if t == "inc a" and acc is not None:
                acc += 1
                continue
            if t == "xor a":
                acc = 0
                continue
            m = re.fullmatch(r"ld \((0[68a]000h)\),a", t)
            if m:
                if acc is None:
                    return s, reg, "cambio de banco con A desconocida antes de la lectura"
                puesto[REG_MAPPER[valor(m.group(1))]] = acc
                continue
            m = re.fullmatch(r"call ([^,]+)", t)
            if not m:
                continue
            bp, da = self.destino(p, m.group(1))
            if bp == 0 and da == 0x43B3:                     # pinta_bloque
                if isinstance(reg["de"], int) and reg["b"] is not None and reg["c"] is not None:
                    reg["de"] += 2 + reg["b"] * (32 if reg["c"] & 1 else 16)
                else:
                    reg["de"] = None
                reg["hl"] = reg["b"] = reg["c"] = None
                continue
            if bp == 0 and da in (0x42BC, 0x42BE):             # con mascara: DE acaba tras el 0xFF
                if isinstance(reg["de"], int):
                    try:
                        reg["de"], _ = fin_fffe(rom, reparto(), reg["de"])
                    except FueraDelBanco:
                        reg["de"] = None
                reg["hl"] = reg["b"] = reg["c"] = None
                continue
            ef = self.efecto(bp, da) if bp is not None else None
            if ef is None:
                reg = {"hl": None, "de": None, "b": None, "c": None}
            else:
                puesto.update(ef)
                if self.toca_hl(bp, da):
                    reg["hl"] = None
        return reparto(), reg, None


def palabra(rom, s, a):
    return leer(rom, s, a) | (leer(rom, s, a + 1) << 8)


def anota(rom, bloques, s, ptr, fmt, con_destino, nom, quien, extra=None, fin_dado=None):
    """Recorre el guion de `ptr` con el reparto `s` y lo apunta, partido por bancos."""
    if fin_dado is not None:
        leer(rom, s, fin_dado - 1)
        fin, n = fin_dado, 0
    elif fmt == "mandos":
        fin, n = fin_mandos(rom, s, ptr, con_destino)
    else:
        fin, n = fin_fffe(rom, s, ptr)
    partes = trozos(s, ptr, fin)
    for i, (bb, a, f) in enumerate(partes):
        e = bloques[bb].setdefault((a, f), {"lector": set(), "fmt": fmt, "desde": set(),
                                             "bytes": n, "sigue": None, "viene": None,
                                             "extra": set()})
        e["lector"].add(nom)
        e["desde"].add(quien)
        if extra:
            e["extra"].add(extra)
        if i + 1 < len(partes):
            e["sigue"] = partes[i + 1][0]
        if i:
            e["viene"] = (partes[i - 1][0], ptr)
    return fin


# ------------------------------------------------------- las tablas de punteros
# Lo que el codigo no carga con un inmediato sino sacando el puntero de una
# tabla. Cada recorrido esta escrito despues de leer la rutina que la usa, y
# lleva al lado la direccion para ir a mirarla. Devuelven las D de las propias
# tablas (banco, ini, fin, nombre, texto, anchura) y apuntan los guiones.
PINTA = 0x4386
DECORADOS = 10          # (0xE0A1), de 0 a 9


def tabla_decorados(rom, bloques):
    """p00:4995, 49D2 y 49FC ponen el trio 4-5-6 y cargan un tercio de pantalla.

    p00:49B1 lee el color del fondo de 0x4A89 + (0xE0A1). Luego p00:4A24 salta
    a la entrada (0xE0A1) * 10 de la tabla del tercio y saca, en este orden: el
    guion de patrones (lo pinta 4A39 con C=0 en el destino de 0xE4E0), el de
    patrones con espejo (4A4B, C=1, en el destino que viene en la entrada), ese
    destino, el de colores (4A5A, C=0, destino de 0xE4E2) y el de colores con
    espejo (4A6C, en el destino menos 0x2000).
    """
    s = (4, 5, 6)
    fijas = [(0, 0x4A89, 0x4A93, "color_del_fondo_por_decorado",
              "un byte por decorado (0xE0A1, de 0 a 9): el color con que p00:49BE llena los ocho primeros de la tabla de colores (FILVRM en 0x0008)", 1)]
    for tabla, tercio, quien in ((0x4A93, "de arriba", "p00:49CD"),
                                 (0x4AF7, "del medio", "p00:4A21"),
                                 (0x4B5B, "de abajo", "p00:49F7")):
        fijas.append((0, tabla, tabla + DECORADOS * 10, "tercio_%s_por_decorado" % tercio.split()[-1],
                      "diez entradas de 10 bytes, una por decorado (0xE0A1), para el tercio %s de la "
                      "pantalla: guion de patrones, guion de patrones con espejo, destino de ese espejo, "
                      "guion de colores y guion de colores con espejo, todos del trio 4-5-6. La carga "
                      "%s y la recorre p00:4A24" % (tercio, quien), 10))
        for n in range(DECORADOS):
            e = tabla + 10 * n
            for off, que in ((0, "patrones"), (2, "patrones con espejo"),
                             (6, "colores"), (8, "colores con espejo")):
                ptr = palabra(rom, (4, 5, 6), e + off)
                anota(rom, bloques, s, ptr, "mandos", False, "pinta",
                      "tercio %s[%d]" % (tercio, n),
                      extra="%s del tercio %s" % (que, tercio))
    return fijas


def tabla_565F(rom, bloques):
    """p00:5630 `ld a,r / rra / rra / and 3`: uno de cuatro guiones al azar.

    Con el trio 7-8-9 puesto (p00:55FC), el puntero (0xE0E2 = 0..3) de la
    tabla va a pinta_sin_color en p00:5642.
    """
    s = (7, 8, 9)
    for i in range(4):
        anota(rom, bloques, s, palabra(rom, s, 0x565F + 2 * i), "mandos", True,
              "pinta_sin_color", "p00:5642 por 0x565F[%d]" % i,
              extra="uno de los cuatro que se eligen al azar con el registro R")
    return [(0, 0x565F, 0x5667, "cuatro_guiones_al_azar",
             "cuatro punteros a guiones de pinta_sin_color del trio 7-8-9; p00:5630 elige uno con "
             "`ld a,r / rra / rra / and 3`, lo apunta en 0xE0E2 y lo pinta en p00:5642", 2)]


def texto_que_sube(rom, bloques):
    """El texto del final de la presentacion (p00:5E6E).

    Tres listas de lineas: p00:5F1C deja en 0xE149 la de 0x5F35 y en 0xE147
    la de 0x5F63 o la de 0x5F6D. p00:5E95 cuenta con (0xE140): 6 en el primer
    tramo (p00:5F01) y 0x18 en el segundo (p00:5ECB), y lee la entrada
    (0xE140) - 1 tras decrementarlo, asi que usa 5 y 23 entradas. Cada linea,
    con los bancos 10 y 11 puestos: un byte de duracion (0xE13E) y detras un
    guion que p01:7E2D manda a descomprime.
    """
    s = (1, 10, 11)
    fijas = []
    for ini, n, que in ((0x5F35, 23, "las 23 del tramo largo (0xE149, p00:5ED5)"),
                        (0x5F63, 5, "las 5 de un tramo corto (0xE147 si (0xE0B9) es cero, p00:5F1F)"),
                        (0x5F6D, 5, "las 5 del otro tramo corto (p00:5F25)")):
        fijas.append((0, ini, ini + 2 * n, "lineas_que_suben_%04X" % ini,
                      "punteros a las lineas del texto que sube: %s. Cada una apunta a un byte de "
                      "duracion y un guion de descomprime de los bancos 10/11" % que, 2))
        for i in range(n):
            ptr = palabra(rom, s, ini + 2 * i)
            fin, _ = fin_mandos(rom, s, ptr + 1, True)
            anota(rom, bloques, s, ptr, "mandos", True, "descomprime",
                  "p00:5E9E por 0x%04X[%d]" % (ini, i), fin_dado=fin,
                  extra="linea del texto que sube: un byte de duracion delante")
    return fijas


def barra_de_nueve(rom, bloques):
    """p00:5F77: una barra de nueve niveles en 0x381A de la tabla de nombres.

    DE = 0x5F99 si (0xE4C0) es cero; si no, 0x5FA0 mas un desplazamiento, que
    es cero por debajo de 4 y, de 4 en adelante, el de la tabla de 0x5FD8
    indexada por (0xE4C0) - 4. Los nueve guiones son de siete bytes (destino
    0x381A, cuatro caracteres y el 0xFF) y los pinta pinta_guion_con_mascara.
    """
    s = (1, 2, 3)
    for k in range(9):
        a = 0x5F99 + 7 * k
        anota(rom, bloques, s, a, "fffe", True, "pinta_guion_con_mascara",
              "p00:5F96", extra="nivel %d de la barra de 0x381A" % k)
    return [(0, 0x5FD8, 0x5FEE, "escalera_de_la_barra",
             "22 desplazamientos (0x00 a 0x31, de siete en siete) sobre 0x5FA0: p00:5F8C los indexa "
             "con (0xE4C0) - 4 para elegir cual de los ocho guiones llenos pinta. Cada escalon dura mas "
             "que el anterior", 11),
            (0, 0x5FEE, 0x6000, "relleno_del_banco_0",
             "18 bytes a 0xFF hasta el final del banco 0", 16)]


def _dos_niveles(rom, bloques, s, banco, base, n1, n2, lector, quien, que):
    """Tabla de n1 punteros a tablas de n2 punteros a guiones de bytes sueltos."""
    fijas, internas = [], set()
    for i in range(n1):
        internas.add(palabra(rom, s, base + 2 * i))
    ini, fin = min(internas), max(internas) + 2 * n2
    if ini != base + 2 * n1 or (fin - ini) != 2 * n2 * len(internas):
        raise FueraDelBanco("la tabla de %04X no tiene sus tablas internas seguidas detras" % base)
    fijas.append((banco, base, base + 2 * n1, "tabla_de_tablas_%04X" % base,
                  "%d punteros a tablas de %d palabras (%s)%s. La indexa %s con el primer byte de "
                  "la ranura menos uno" % (n1, n2, que,
                                           ", con repetidas" if len(internas) < n1 else "", quien), 2))
    if banco_de(ini, s) != banco_de(fin - 1, s):
        raise FueraDelBanco("las tablas internas de %04X cruzan de banco" % base)
    fijas.append((banco_de(ini, s), ini, fin, "tablas_internas_%04X" % base,
                  "las %d tablas de %d palabras de tabla_de_tablas_%04X, seguidas: cada palabra apunta "
                  "a un guion de bytes sueltos; %s las indexa con el segundo byte menos uno"
                  % (len(internas), n2, base, quien), 2 * n2))
    for t_ in sorted(internas):
        for j in range(n2):
            anota(rom, bloques, s, palabra(rom, s, t_ + 2 * j), "fffe", True, lector,
                  "%s por 0x%04X[%d]" % (quien, t_, j), extra=que)
    return fijas


def tablas_de_marcas(rom, bloques):
    """Las dos tablas de dos niveles de los bancos 10/11.

    0x8682 (banco 10): p00:4760, p01:6910 y p01:6985 recorren las cinco
    ranuras de 0xE440 (dos bytes cada una) y con el primer byte menos uno
    sacan una tabla interna, y con el segundo menos uno el guion, que va a
    rellena_de_unos (p00:4774, p01:692D) o a copia_bloques (p01:699A). Las 38
    entradas llevan a 32 tablas internas distintas de 16 palabras, pegadas de
    0x86CE a 0x8ACE, y detras empiezan los guiones.

    0xA420 (banco 11): p01:6B02 y p01:6B5E, con B = (0xE4E0) vueltas, sacan
    una de 4 tablas de 9 palabras (0xA428-0xA470); el contador de (0xE409 + k)
    da la vuelta al llegar a 10 (p01:6B0F) y se usa menos uno.
    """
    s = (1, 10, 11)
    fijas = _dos_niveles(rom, bloques, s, 10, 0x8682, 38, 16,
                         "rellena_de_unos y copia_bloques", "p00:4760, p01:6910 y p01:6985",
                         "de las ranuras de 0xE440")
    fijas += _dos_niveles(rom, bloques, s, 11, 0xA420, 4, 9,
                          "rellena_de_unos y copia_bloques", "p01:6B02 y p01:6B5E",
                          "de las ranuras de 0xE409")
    return fijas


def animacion_del_fondo(rom, bloques):
    """p01:6539: los bancos 12 y 13 y un cuadro de cuatro ((0xE4C2) & 3).

    0x8000 (banco 12) lleva un puntero por decorado a una tabla de cuatro
    guiones de copia_bloques (p01:655A). Si (0xE0A6) es 1 o 2, lo mismo con la
    tabla de 0xA613 o la de 0xA627 (banco 13, p01:6576).
    """
    s = (1, 12, 13)
    fijas = []
    for banco, base, que in ((12, 0x8000, "p01:655A"), (13, 0xA613, "p01:6576 con (0xE0A6) = 1"),
                             (13, 0xA627, "p01:6576 con (0xE0A6) = 2")):
        internas = sorted({palabra(rom, s, base + 2 * i) for i in range(DECORADOS)})
        fijas.append((banco, base, base + 2 * DECORADOS, "animacion_por_decorado_%04X" % base,
                      "un puntero por decorado (0xE0A1) a una tabla de cuatro cuadros de animacion; la "
                      "lee %s y el cuadro lo da (0xE4C2) & 3" % que, 2))
        for t_ in internas:
            fijas.append((banco_de(t_, s), t_, t_ + 8, "cuadros_%04X" % t_,
                          "los cuatro guiones de copia_bloques de un decorado, uno por cuadro", 2))
            for j in range(4):
                anota(rom, bloques, s, palabra(rom, s, t_ + 2 * j), "fffe", True, "copia_bloques",
                      "%s por 0x%04X[%d]" % (que, t_, j), extra="cuadro %d de la animacion del fondo" % j)
    return fijas


def tabla_A605(rom, bloques):
    """p01:6697 con C = 0, 2, 4, 6 u 8 (p01:6651, 666C, 6687, 668F y 660D).

    Con los bancos 10/11, la tabla de 0xA605 -o la de 0xA76B si el valor de la
    fase (0xE093) es 3- y la palabra de (tabla + C) va a copia_bloques.
    """
    s = (1, 10, 11)
    fijas = []
    for base, que in ((0xA605, "(0xE093) distinto de 3"), (0xA76B, "(0xE093) igual a 3")):
        fijas.append((11, base, base + 10, "cinco_guiones_%04X" % base,
                      "cinco punteros a guiones de copia_bloques que p01:66B8 indexa con C = 0, 2, 4, 6 u 8; "
                      "se usa con %s" % que, 2))
        for c in range(0, 10, 2):
            anota(rom, bloques, s, palabra(rom, s, base + c), "fffe", True, "copia_bloques",
                  "p01:66C0 con C=%d" % c)
    return fijas


def tabla_BA0B(rom, bloques):
    """p01:7B72 `ld a,r / and 7`: uno de ocho guiones al azar, bancos 12/13."""
    s = (1, 12, 13)
    for i in range(8):
        anota(rom, bloques, s, palabra(rom, s, 0xBA0B + 2 * i), "fffe", True,
              "pinta_guion_con_mascara", "p01:7B7F por 0xBA0B[%d]" % i,
              extra="uno de ocho elegidos con el registro R")
    return [(13, 0xBA0B, 0xBA1B, "ocho_guiones_al_azar",
             "ocho punteros a guiones de pinta_guion_con_mascara; p01:7B72 elige uno con "
             "`ld a,r / and 7` (p01:7B7F)", 2)]


N_FASES = 24            # (0xE092), de 1 a 24


def _seguido(rom, s, a, b):
    """Comprueba que [a, b) cae entero en un solo banco."""
    leer(rom, s, a)
    leer(rom, s, b - 1)
    if banco_de(a, s) != banco_de(b - 1, s):
        raise FueraDelBanco("%04X-%04X cruza de banco" % (a, b))


def banco_10_terreno(rom, bloques):
    """El banco 10 entero de 0x8000 a 0x8682: el terreno y lo que sale de el.

    p01:6737 (el_guion_del_terreno), con 10/11 puestos: en el modo 0, DE =
    0x8000 con un jugador o 0x80F9 con dos (0xE08F), y la palabra (0xE092)-1
    es la tira de la fase; en otro modo, DE = 0x8490 directamente. La tira se
    lee con el contador (0xE404) de uno en uno y NO lleva marca de fin: acaba
    donde empieza la siguiente, y los 24 punteros van en orden con la primera
    tira pegada a la tabla.

    p01:67C1: en el modo 1 la tabla de 0x81F2 da, con (0xE0A3), una lista que
    se lee con (0xE403) hasta un 0xFF. En el juego, p01:67EA lee de la tabla de
    TRAMOS de 0x84EA: ocho cosas por byte de terreno (0xE402), por (0xE403).
    p01:6888 y p01:68BB indexan 0x84A0 con A - 0x27 (dos bytes: C y E) y 0x84B2
    con A - 0x30 (una palabra). Las cuatro zonas van seguidas y cada una llega
    hasta la siguiente: 16 + 18 + 56 + 408 = 498 bytes, hasta 0x8682.
    """
    s = (1, 10, 11)
    fijas = []
    for base, fin_bloque, jug in ((0x8000, 0x80F9, "un jugador"), (0x80F9, 0x81F2, "dos jugadores")):
        ps = [palabra(rom, s, base + 2 * i) for i in range(N_FASES)]
        if ps[0] != base + 2 * N_FASES or any(ps[i] > ps[i + 1] for i in range(N_FASES - 1)):
            raise FueraDelBanco("las tiras de %04X no van seguidas" % base)
        fijas.append((10, base, base + 2 * N_FASES, "tiras_de_terreno_%s" % jug.split()[0],
                      "24 punteros, uno por fase (0xE092 - 1), a las tiras de terreno con %s; los lee "
                      "p01:6767. Van en orden y la primera tira empieza donde acaba la tabla" % jug, 2))
        for i in range(N_FASES):
            fin = ps[i + 1] if i + 1 < N_FASES else fin_bloque
            if fin > ps[i]:
                _seguido(rom, s, ps[i], fin)
                fijas.append((10, ps[i], fin, "terreno_fase_%d_%s" % (i + 1, jug.split()[0]),
                              "la tira de terreno de la fase %d con %s: un byte por tramo, que p01:6773 va "
                              "gastando con (0xE404). No lleva fin: acaba donde empieza %s"
                              % (i + 1, jug, "la de la fase siguiente" if i + 1 < N_FASES else
                                 "la tabla de 0x%04X" % fin_bloque), 16))
    ps = []
    a = 0x81F2
    while a < (min(ps) if ps else 0x10000):
        ps.append(palabra(rom, s, a))
        a += 2
    fijas.append((10, 0x81F2, a, "listas_del_modo_1",
                  "%d punteros a las listas de lo que sale en el modo 1 (0xE0A2 = 1); p01:67C5 escoge una "
                  "con (0xE0A3)" % len(ps), 2))
    orden = sorted(set(ps))
    for i, p in enumerate(orden):
        q = p
        while leer(rom, s, q) != 0xFF:
            q += 1
        fin = orden[i + 1] if i + 1 < len(orden) else 0x8490
        if q + 1 != fin:
            raise FueraDelBanco("la lista de %04X no acaba pegada a la siguiente" % p)
        fijas.append((10, p, fin, "lista_del_modo_1_%d" % ps.index(p),
                      "lo que sale en el modo 1 con (0xE0A3) = %d: %d bytes que p01:67D3 lee con (0xE403) "
                      "y un 0xFF que la cierra y la hace empezar otra vez (p01:67E0)"
                      % (ps.index(p), fin - p - 1), 16))
    for a, f, nom, txt, ancho in (
            (0x8490, 0x84A0, "tira_de_terreno_fuera_del_juego",
             "la tira que p01:6756 usa cuando el modo (0xE0A2) no es cero, en vez de la de la fase: 16 bytes, "
             "hasta la tabla de 0x84A0", 16),
            (0x84A0, 0x84B2, "parejas_27",
             "nueve parejas de bytes (C, E) que p01:6888 indexa con A - 0x27; si C no es 4 ni 0x0F, "
             "la Y de lo que se maneja (0xE205) decide cual de los dos va", 2),
            (0x84B2, 0x84EA, "palabras_30",
             "28 palabras que p01:68BB indexa con A - 0x30 y manda a busca_ranura_libre en DE", 2),
            (0x84EA, 0x8682, "tramos_de_terreno",
             "51 tramos de ocho cosas cada uno: p01:67EA salta a (0xE402) * 8 y lee la cosa (0xE403), que "
             "da la vuelta a las ocho (p01:67FE). Llega hasta la tabla de tablas de 0x8682", 8)):
        _seguido(rom, s, a, f)
        fijas.append((10, a, f, nom, txt, ancho))
    return fijas


def _encadenadas(rom, s, ptrs, fin_ultima, ancho=None):
    """Tiras seguidas: cada una acaba donde empieza la siguiente. Devuelve [(ini, fin)]."""
    orden = sorted(set(ptrs))
    fuera = []
    for i, p in enumerate(orden):
        fin = orden[i + 1] if i + 1 < len(orden) else fin_ultima
        _seguido(rom, s, p, fin)
        if ancho and (fin - p) % ancho:
            raise FueraDelBanco("la tira de %04X no mide un numero entero de entradas de %d" % (p, ancho))
        fuera.append((p, fin))
    return fuera


def banco_13_fases(rom, bloques):
    """El banco 13 de 0xAC16 a 0xB2EC: tablas por decorado y por fase.

    Todas las lee el banco 1 con 12/13 puestos. L_64E7 (p01:64E7) deja
    HL = ((0xE092) - 1) * 2, y cada tabla por fase se indexa con eso. Cada
    tabla acaba justo donde empieza la siguiente que carga el codigo, y se
    comprueba aqui.
    """
    s = (1, 12, 13)
    f = []

    def fija(a, b, nom, txt, ancho):
        _seguido(rom, s, a, b)
        f.append((13, a, b, nom, txt, ancho))

    # p01:61DD: (0xE0A1) * 2 en 0xAC16 y 32 bytes con ldir a 0xE510 y luego a 0xECA0
    ps = [palabra(rom, s, 0xAC16 + 2 * i) for i in range(DECORADOS)]
    fija(0xAC16, 0xAC2A, "fila_por_decorado",
         "diez punteros, uno por decorado (0xE0A1), a una fila de 32 bytes que p01:61E1 copia con ldir a "
         "0xE510 y de ahi a 0xECA0. Los decorados 5 a 9 apuntan a 0xAC8A, que es la tabla de distancias de "
         "las fases: esos 32 bytes los leen las dos rutinas", 2)
    for a in sorted(set(p for p in ps if p < 0xAC8A)):
        fija(a, a + 32, "fila_de_decorado_%04X" % a,
             "32 bytes que p01:61F1 copia a 0xE510 para los decorados %s"
             % ", ".join(str(i) for i, p in enumerate(ps) if p == a), 16)
    fija(0xAC8A, 0xACBA, "distancia_de_salida_por_fase",
         "24 palabras, una por fase: p01:6456 la pone en 0xE301 (lo andado en la fase). Sus primeros 32 "
         "bytes son tambien la fila que p01:61E1 copia para los decorados 5 a 9", 2)
    fija(0xACBA, 0xAD1A, "largo_de_cada_fase",
         "24 entradas de 4 bytes, una por fase: el byte bajo y el nibble bajo del siguiente son los doce bits "
         "del largo de la fase (0xE08B), y el nibble alto va aparte; la leen p00:47BA y p01:6217", 4)
    fija(0xAD1A, 0xAD38, "salida_por_decorado",
         "diez entradas de 3 bytes, una por decorado (o la 9 a partir de la segunda vuelta, p01:6273): la X "
         "en pantalla de lo que se maneja (0xE204) y por donde va la rotacion de sus sprites (0xE203), p01:627A", 3)
    fija(0xAD38, 0xAD68, "copia_a_E570",
         "48 bytes que p01:6303 copia de un tiron con ldir a 0xE570", 16)
    fija(0xAD68, 0xADE8, "atributos_de_sprite_iniciales",
         "los atributos de los 32 sprites (Y, X, patron, color): p01:6337 copia los 128 bytes con ldir a "
         "0xEE80, la tabla de atributos en RAM", 4)
    # p01:66DA / 6702: el segundo guion
    ps = [palabra(rom, s, 0xADE8 + 2 * i) for i in range(N_FASES)]
    if ps[0] != 0xAE18:
        raise FueraDelBanco("el segundo guion no empieza pegado a su tabla")
    fija(0xADE8, 0xAE18, "segundo_guion_por_fase",
         "24 punteros, uno por fase, al segundo guion (el_segundo_guion, p01:66DA): lo que pasa a cada "
         "distancia", 2)
    for i, (a, b) in enumerate(_encadenadas(rom, s, ps, 0xB046, 3)):
        if leer(rom, s, b - 3) != 0xFF or leer(rom, s, b - 2) != 0xFF:
            raise FueraDelBanco("el segundo guion de %04X no acaba en FF FF" % a)
        fases = [k + 1 for k, p in enumerate(ps) if p == a]
        fija(a, b, "segundo_guion_fase_%d" % fases[0],
             "el segundo guion de la fase %s: entradas de 3 bytes -la distancia en BCD (0xE0A7) y el byte que "
             "dice que pasa (0xE0A6)- que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega"
             % " y ".join(map(str, fases)), 3)
    # p01:6387: una palabra por fase y detras entradas de 4 bytes por (0xE0B6)
    ps = [palabra(rom, s, 0xB046 + 2 * i) for i in range(N_FASES)]
    fija(0xB046, 0xB076, "tabla_por_fase_B046",
         "24 punteros, uno por fase, a listas de entradas de 4 bytes que p01:638F indexa con (0xE0B6): una "
         "palabra a 0xE0AF y dos bytes a 0xE0B1 y 0xE0B2", 2)
    for a, b in _encadenadas(rom, s, ps, 0xB192, 4):
        fija(a, b, "lista_B046_%04X" % a,
             "entradas de 4 bytes de la fase %s (tabla_por_fase_B046)"
             % " y ".join(str(k + 1) for k, p in enumerate(ps) if p == a), 4)
    ps = [palabra(rom, s, 0xB192 + 2 * i) for i in range(N_FASES)]
    fija(0xB192, 0xB1C2, "tabla_por_fase_B192",
         "24 punteros, uno por fase, a listas de palabras que p01:63DB indexa con (0xE0D4) y lleva a 0xE0D5", 2)
    for a, b in _encadenadas(rom, s, ps, 0xB28C, 2):
        fija(a, b, "lista_B192_%04X" % a,
             "palabras de la fase %s (tabla_por_fase_B192)"
             % " y ".join(str(k + 1) for k, p in enumerate(ps) if p == a), 2)
    fija(0xB28C, 0xB2EC, "tabla_por_fase_B28C",
         "24 entradas de 4 bytes, una por fase, que p01:6414 reparte: una palabra a 0xE0AB y dos bytes a "
         "0xE0AD y 0xE0AE", 4)
    return f


def sueltos_del_banco_13(rom, bloques):
    """Copias con ldir y los guiones que llegan por caminos que se juntan.

    p01:6C4E, 6C58 y 6C5E cargan DE con 0xA563, 0xA59D o 0xA5D7 segun el modo
    (0xE0A2) y los tres caminos se juntan en el pintor con mascara de 6C61:
    el trazador solo se queda con uno.
    """
    s = (1, 12, 13)
    for ptr, que in ((0xA563, "modo 3"), (0xA59D, "modo 4"), (0xA5D7, "otro modo")):
        anota(rom, bloques, s, ptr, "fffe", True, "pinta_guion_con_mascara", "p01:6C61",
              extra="el rotulo del %s (0xE0A2)" % que)
    f = []
    for a, b, nom, txt in (
            (0xBA9E, 0xBAB2, "sprites_de_la_presentacion",
             "cinco atributos de sprite (Y, X, patron, color) que p00:5C88 copia con ldir a 0xEE80 al montar el "
             "rotulo de la presentacion"),
            (0xBC99, 0xBCB9, "ocho_sprites_BC99",
             "ocho atributos de sprite que p01:7DC7 copia con ldir a 0xEEE0, los sprites 24 a 31"),
            (0xBCB9, 0xBCD9, "ocho_sprites_BCB9",
             "los otros ocho que p01:7DE9 copia al mismo sitio, 0xEEE0")):
        _seguido(rom, s, a, b)
        f.append((13, a, b, nom, txt, 4))
    return f


def _tabla_hasta_el_primer_destino(rom, s, a):
    ps = []
    while a < (min(ps) if ps else 0x10000):
        ps.append(palabra(rom, s, a))
        a += 2
    return ps, a


def _tira_de_huecos(rom, s, a, ancho_desplazamiento):
    """p01:7C74 / 7D35: [desplazamiento] bytes..., 0xFE [desplazamiento] bytes..., 0xFF."""
    a += ancho_desplazamiento
    while True:
        b = leer(rom, s, a)
        a += 1
        if b == 0xFF:
            return a
        if b == 0xFE:
            a += ancho_desplazamiento


def banco_11(rom, bloques):
    """El banco 11 de 0xA539 a 0xADA2 y las tres tablas de 0xAED0.

    p01:69D0: A - 0x1A indexa 0xA539, que da la base de una lista de 16
    entradas de 4 bytes; el contador de (DE) va de 1 a 16 (p01:69E2) y se
    copian las cuatro con ldi.
    p01:7C74 (y p01:7CD7, que en vez de copiar pone unos): una TIRA de un byte
    de desplazamiento sobre DE = (0xE538) y bytes que se copian, 0xFE da otro
    desplazamiento y 0xFF acaba. Las tiras salen de 0xA842, indexada con
    (0xE531)*6 + (0xE532)*2 (p01:7C25), de 0xAB60 con (0xE531)*2 (p01:7C65), y
    0xA854 la carga tal cual p01:7C5A.
    p01:7D35: la misma tira con el desplazamiento en una PALABRA, de 0xAD62
    indexada con el byte de 0xE550 menos dos.
    p01:6BD8: 16 entradas de 4 bytes (el contador de (HL) da la vuelta a los
    16) desde BC = 0xAED0, 0xAF10 y 0xAF50 (p01:6BB1).
    """
    s = (1, 10, 11)
    f = []

    def fija(a, b, nom, txt, ancho):
        _seguido(rom, s, a, b)
        f.append((11, a, b, nom, txt, ancho))

    ps, fin = _tabla_hasta_el_primer_destino(rom, s, 0xA539)
    fija(0xA539, fin, "listas_de_cuatro_A539",
         "%d punteros que p01:69D5 indexa con A - 0x1A; llevan a listas de 16 entradas de 4 bytes" % len(ps), 2)
    for a in sorted(set(ps)):
        fija(a, a + 64, "lista_de_cuatro_%04X" % a,
             "16 entradas de 4 bytes que p01:69F5 copia con cuatro ldi, una por vuelta del contador de (DE)", 4)
    if max(ps) + 64 != 0xA605:
        raise FueraDelBanco("las listas de 0xA539 no llegan a 0xA605")
    for base, fin_ultima, quien in ((0xA842, 0xAB60, "p01:7C32 y p01:7CCC con (0xE531)*6 + (0xE532)*2"),
                                    (0xAB60, 0xAD62, "p01:7C6A con (0xE531)*2")):
        ps, fin = _tabla_hasta_el_primer_destino(rom, s, base)
        fija(base, fin, "tiras_%04X" % base,
             "%d punteros a tiras de bytes para la RAM; la indexa %s" % (len(ps), quien), 2)
        for a, b in _encadenadas(rom, s, ps, fin_ultima):
            if _tira_de_huecos(rom, s, a, 1) != b:
                raise FueraDelBanco("la tira de %04X no acaba pegada a la siguiente" % a)
            fija(a, b, "tira_%04X" % a,
                 "una tira que copia p01:7C74 (o marca con unos p01:7CD7): un byte de desplazamiento sobre "
                 "(0xE538), bytes, 0xFE y otro desplazamiento, y 0xFF al final%s"
                 % (". La carga tambien tal cual p01:7C5A" if a == 0xA854 else ""), 16)
    ps, fin = _tabla_hasta_el_primer_destino(rom, s, 0xAD62)
    fija(0xAD62, fin, "tiras_AD62",
         "%d punteros que p01:7D28 indexa con el byte de 0xE550 menos dos" % len(ps), 2)
    for a, b in _encadenadas(rom, s, ps, 0xADA2):
        if _tira_de_huecos(rom, s, a, 2) != b:
            raise FueraDelBanco("la tira de %04X no acaba pegada a la siguiente" % a)
        fija(a, b, "tira_larga_%04X" % a,
             "una tira que copia p01:7D35 sobre DE (de 0x7D6C): una palabra de desplazamiento, bytes, 0xFE y "
             "otra palabra, y 0xFF al final", 16)
    for a in (0xAED0, 0xAF10, 0xAF50):
        fija(a, a + 64, "cuadros_de_cuatro_%04X" % a,
             "16 entradas de 4 bytes que p01:6BD8 copia con ldir segun su contador, que da la vuelta a los 16; "
             "BC la pone p01:6BB1, 6BB7 o 6BBD", 4)
    return f


def banco_11_resto(rom, bloques):
    """Lo del banco 11 que llega por punteros guardados en RAM o en tablas de otros bancos.

    Todos con 10/11 puestos (p01:6F71, p01:7DF7, p01:7E11, p01:7D74).
    """
    s = (1, 10, 11)
    f = []
    # p01:7D88: (0xE53A) apunta a entradas de 3 bytes; la palabra es una
    # direccion de RAM y el tercer byte lo que se escribe en ella; un 0xFF en
    # el tercero corta sin avanzar. La cargan p01:77E8 y p03:B4CB.
    a = 0xAE0A
    while leer(rom, s, a + 2) != 0xFF:
        a += 3
    fin = a + 3
    _seguido(rom, s, 0xAE0A, fin)
    f.append((11, 0xAE0A, fin, "escrituras_a_la_ram_AE0A",
              "%d entradas de 3 bytes -una direccion de RAM y el byte que se escribe en ella- que p01:7D88 va "
              "sacando de una en una con (0xE53A), y una ultima con 0xFF en el tercer byte que la corta. La "
              "cargan p01:77E8 y p03:B4CB" % ((fin - 0xAE0A) // 3 - 1), 3))
    # p01:6CDF: (0xE092 - 1) * 7 sobre 0xAF90, leida hasta un cero (p01:6CF5)
    for k in range(N_FASES):
        e = 0xAF90 + 7 * k
        if 0 not in [leer(rom, s, e + i) for i in range(7)]:
            raise FueraDelBanco("la entrada %d de 0xAF90 no lleva su cero" % k)
    _seguido(rom, s, 0xAF90, 0xAF90 + 7 * N_FASES)
    f.append((11, 0xAF90, 0xAF90 + 7 * N_FASES, "listas_por_fase_AF90",
              "24 entradas de 7 bytes, una por fase: p01:6CE9 salta a (0xE092 - 1) * 7 y lee bytes hasta un cero, "
              "cada uno un indice en la tabla de 0xE160 y en la de IX (0x6FD5, 0x6FE5 o 0x6FF5 segun el modo). "
              "Estaba mal atribuida al banco 13: p01:6CC6 pone antes el 10 y el 11", 7))
    # p01:6E2F-6E49: tres parejas segun el modo, que p01:6F2E y 6F35 pintan
    for de, hl, que in ((0xB038, 0xB094, "modo 3"), (0xB065, 0xB0BE, "modo 4"), (0xB0DD, 0xB105, "otro modo")):
        anota(rom, bloques, s, de, "fffe", True, "pinta_guion_lee_destino (p01:6F32)", "p01:6E4E",
              extra="la primera mitad del rotulo del %s (0xE119)" % que)
        anota(rom, bloques, s, hl, "fffe", True, "pinta_guion_con_mascara (p01:6F39)", "p01:6E52",
              extra="la segunda mitad (0xE11B)")
    # p01:79EA y 7A00 dejan en 0xE137 uno de dos guiones que pinta p01:7A49
    for ptr in (0xB1DD, 0xB1E5):
        anota(rom, bloques, s, ptr, "fffe", True, "pinta_guion_con_mascara (p01:7A49)", "0xE137")
    # p00:5DB3 recorre los diez punteros de p00:5E3C y se los pasa a p01:7DF7
    for i in range(10):
        anota(rom, bloques, s, palabra(rom, s, 0x5E3C + 2 * i), "fffe", True,
              "pinta_guion_con_mascara (p01:7DF7)", "p00:5DB3 por 0x5E3C[%d]" % i,
              extra="dibujo %d de la presentacion" % i)
    return f


def demo_y_tiras_de_p03(rom, bloques):
    """Las partidas grabadas de la demo y las cinco tiras que carga el banco 3.

    p01:7E89: (0xF0F6) & 7 elige una de las ocho entradas de 3 bytes de
    p01:0x7EF6 -la fase, que va a 0xE092, y un puntero, que va a 0xE13A- y
    monta esa fase. p01:7F26, con 10/11 puestos, avanza dos bytes antes de
    leer y va sacando parejas (mandos, cuadros) hasta un 0xFF. Las ocho van
    seguidas en el banco 11 y cada una acaba en su 0xFF.

    p03:A5F8, A651, A699, A69E y A6EE cargan en HL una de las cinco tiras de
    0xAE85 y llaman a p01:7D9C, que pone 10/11 y salta a la tira de p01:7C78;
    p03:A5EF saca el desplazamiento DE de las ocho palabras de p03:0xA623.
    """
    s = (1, 10, 11)
    f = []
    fases, ptrs = [], []
    for k in range(8):
        e = 0x7EF6 + 3 * k
        fases.append(leer(rom, s, e))
        ptrs.append(palabra(rom, s, e + 1))
    f.append((1, 0x7EF6, 0x7F0E, "escenas_de_la_demo",
              "ocho entradas de 3 bytes que p01:7E93 elige con (0xF0F6) & 7: la fase (0xE092) y el puntero a su "
              "partida grabada (0xE13A). Las fases son %s" % ", ".join(str(x) for x in fases), 3))
    for k, (a, b) in enumerate(_encadenadas(rom, s, ptrs, 0xBAC0)):
        if leer(rom, s, b - 1) != 0xFF:
            raise FueraDelBanco("la grabacion de %04X no acaba en 0xFF" % a)
        n = [i for i, p in enumerate(ptrs) if p == a]
        f.append((11, a, b, "partida_grabada_fase_%d" % fases[n[0]],
                  "la partida grabada de la demo en la fase %d: parejas (mandos, cuadros que duran) que p01:7F26 "
                  "lee desde el tercer byte -avanza dos antes de leer- hasta el 0xFF del final (%d bytes)"
                  % (fases[n[0]], b - a), 2))
    tiras = [0xAE85, 0xAE94, 0xAEA3, 0xAEB2, 0xAEC1]
    for a, b in _encadenadas(rom, s, tiras, 0xAED0):
        if _tira_de_huecos(rom, s, a, 1) != b:
            raise FueraDelBanco("la tira de %04X no acaba pegada a la siguiente" % a)
        f.append((11, a, b, "tira_de_p03_%04X" % a,
                  "una tira de p01:7C78 (un byte de desplazamiento, bytes, 0xFE y otro desplazamiento, 0xFF): "
                  "la carga en HL el banco 3 (p03:A5F8, A651, A699, A69E o A6EE) para p01:7D9C", 16))
    f.append((3, 0xA623, 0xA633, "destinos_de_la_tira_AE85",
              "ocho direcciones de RAM (0xEDED, 0xEDF0...) que p03:A5EF indexa con (0xE0DD) - 1 y pasa en DE a "
              "p01:7D9C junto con la tira de 0xAE85", 2))
    return f


def enemigos(rom, bloques):
    """p09:A83F (saca_lo_que_toque): el guion de enemigos de cada fase.

    Con el trio 7-8-9, (0xE092) - 1 indexa los 24 punteros de 0xA8FB y (0xE300)
    la pareja: el primer byte es QUE objeto y el segundo cuanto hay que andar
    hasta el siguiente, en BCD; un 0xFF en el segundo cierra el guion
    (p09:A881). Un guion que empieza por 0xFF no saca nada: asi son las fases
    1, 2 y 4, y las dos ultimas apuntan al 0xFF final de la de al lado.
    """
    s = (7, 8, 9)
    ps = [palabra(rom, s, 0xA8FB + 2 * i) for i in range(N_FASES)]
    f = [(9, 0xA8FB, 0xA92B, "guion_de_enemigos_por_fase",
          "24 punteros, uno por fase (0xE092 - 1), a los guiones de enemigos que lee p09:A854", 2)]
    trozos_ = []
    for i, p in enumerate(ps):
        if leer(rom, s, p) == 0xFF and leer(rom, s, p + 1) != 0xFF:
            continue                            # apunta al 0xFF de otro: se declara con el otro
        a = p
        while leer(rom, s, a + 1) != 0xFF:
            a += 2
        trozos_.append((p, a + 2))
    trozos_.sort()
    for (a, b), sig in zip(trozos_, trozos_[1:] + [(None, None)]):
        fases = [k + 1 for k, p in enumerate(ps) if a <= p < b]
        if sig[0] is not None and sig[0] > b:
            if sig[0] - b != 1 or leer(rom, s, b) != 0xFF:
                raise FueraDelBanco("entre los guiones de %04X y %04X hay %d bytes" % (a, sig[0], sig[0] - b))
            b += 1                              # el 0xFF suelto de la fase que no saca nada
            fases = [k + 1 for k, p in enumerate(ps) if a <= p < b]
        _seguido(rom, s, a, b)
        f.append((9, a, b, "enemigos_fase_%d" % fases[0],
                  "el guion de enemigos de la fase %s: parejas (objeto, distancia en BCD hasta el siguiente) "
                  "cerradas con 0xFF en el segundo byte%s"
                  % (" y ".join(map(str, fases)),
                     "; las fases que apuntan a un 0xFF no sacan nada" if len(fases) > 1 else ""), 2))
    f.append((9, 0xA8EF, 0xA8FB, "codigo_muerto_A8EF",
              "doce bytes que se leen limpios como codigo -`ld hl,0E30Fh / ld a,(hl) / and a / ret z / "
              "ld (hl),0 / ld c,a / jp 0A86Ah`, la mitad de meter un objeto- pero a los que no salta nadie", 12))
    return f


def banco_13_final(rom, bloques):
    """Las columnas del final (p01:7B85 y 7BC4) y los guiones vacios sin puntero.

    p01:7B85, con 12/13 puestos, baja (0xE0B8) y copia B = 21 bytes de (DE) a
    una columna del bufer de nombres, uno por fila (+0x20). El contador empieza
    en 0x20 (p03:AB51): 32 columnas por 21 bytes = 672. Los punteros los deja
    el banco 3 en 0xE4E0: 0xB2EC (p03:AA96) y 0xB5F1 (p03:AB6F). p03:AC7D
    llama ademas a p01:7BC4, cinco bytes por columna de (0xE4E2) = 0xB963
    (p03:AC4E), pero solo mientras (0xE0B8) >= 0x16: diez columnas, 50 bytes.
    """
    s = (1, 12, 13)
    f = []
    for a, n, ancho, nom, quien in ((0xB2EC, 32, 21, "columnas_B2EC", "p03:AA96"),
                                   (0xB5F1, 32, 21, "columnas_B5F1", "p03:AB6F"),
                                   (0xB963, 10, 5, "columnas_B963", "p03:AC4E")):
        _seguido(rom, s, a, a + n * ancho)
        f.append((13, a, a + n * ancho, nom,
                  "%d columnas de %d bytes que p01:%s copia de una en una a la tabla de nombres en RAM, un byte "
                  "por fila; el puntero lo deja %s en 0x%s" % (n, ancho, "7B85" if ancho == 21 else "7BC4",
                                                             quien, "E4E0" if ancho == 21 else "E4E2"), ancho))
    for a in (0xA863, 0xA877):
        for k in range(4):
            if [leer(rom, s, a + 3 * k + i) for i in range(3)] != [0x80, 0xEB, 0xFF]:
                raise FueraDelBanco("en %04X no hay cuatro guiones vacios" % a)
        f.append((13, a, a + 12, "guiones_vacios_%04X" % a,
                  "cuatro guiones de copia_bloques vacios, `80 EB FF` -el destino 0xEB80 y el 0xFF que acaba- "
                  "detras de la tabla de cuadros de al lado. Ninguna palabra de la ROM apunta a ellos", 3))
    return f


def bancos_6_y_8(rom, bloques):
    """Lo que falta de los bancos 6 y 8.

    p00:5BAD, con el trio 4-5-6, pasa DE = 0xB423 a pinta_en_los_tres (por
    L_5BF3). trae_un_caracter_del_banco_6 (p00:41CD) copia ocho bytes de
    patrones de 0xBD89 + 8*C y ocho de colores de 0xBDA9 + 8*C, con C de 0 a 3
    (p03:A6C1 `ld a,(0E003h) / and 6 / rra`). p00:562B carga DE = 0x8416 para
    pinta_sin_color con el trio 7-8-9 en un camino que se junta con otro. Y el
    banco 0 copia con ldir 24 bytes a 0xE4E0 desde tablas del banco 8 (7-8-9).
    """
    f = []
    anota(rom, bloques, (4, 5, 6), 0xB423, "mandos", False, "pinta_en_los_tres", "p00:5BAD")
    # p00:5BCF `ld de,0B597h / jr L_5BF0`: el mismo pinta_en_los_tres de p00:5BF3
    anota(rom, bloques, (4, 5, 6), 0xB597, "mandos", False, "pinta_en_los_tres", "p00:5BCF")
    anota(rom, bloques, (7, 8, 9), 0x8416, "mandos", True, "pinta_sin_color", "p00:562B")
    s = (4, 5, 6)
    _seguido(rom, s, 0xBD89, 0xBDC9)
    f.append((6, 0xBD89, 0xBDA9, "patrones_de_cuatro_caracteres",
              "ocho bytes de patrones por caracter, cuatro caracteres: trae_un_caracter_del_banco_6 (p00:41EB) "
              "coge los de 0xBD89 + 8*C y los manda a 0x3718, con C = ((0xE003) & 6) / 2 (p03:A6C1)", 8))
    f.append((6, 0xBDA9, 0xBDC9, "colores_de_cuatro_caracteres",
              "los ocho bytes de colores de los mismos cuatro caracteres, 0x20 bytes mas abajo; p00:41FB los manda "
              "a 0x1718", 8))
    s = (7, 8, 9)
    b0 = rom[0:0x2000]
    for k in range(14):
        a = 0x96F6 + 24 * k
        cargas = ["p00:%04X" % (0x4000 + i) for i in range(len(b0) - 2)
                  if b0[i] == 0x21 and b0[i + 1] == a & 0xFF and b0[i + 2] == a >> 8]
        _seguido(rom, s, a, a + 24)
        f.append((8, a, a + 24, "tabla_de_24_%04X" % a,
                  "24 bytes que el banco 0 copia con ldir a 0xE4E0 (con el trio 7-8-9)%s"
                  % ("; la cargan %s" % ", ".join(cargas) if cargas else
                     "; NINGUN `ld hl` del banco 0 la carga directamente: va entre dos que si"), 8))
    return f


def tablas_del_despachador(rom, bloques):
    """Las tablas que van pegadas detras de un `call despacha` (p00:4060).

    El despachador salta con A a la palabra A de la tabla que sigue a la
    llamada. El trazador ya las recorre (tools/bancos.py, `tablas`) y sabe
    cuantas entradas tienen; aqui solo se declaran como datos.
    """
    f = []
    for (b, pc), v in sorted(TRAZA.tablas.items()):
        tab, n = v[0], v[1]
        f.append((b, tab, tab + 2 * n, "despacho_de_%04X" % pc,
                  "%d punteros pegados detras del `call despacha` de p%02d:%04X: la rutina a la que se salta con A"
                  % (n, b, pc), 2))
    return f


def rellenos(rom, bloques):
    """La cola de 0xFF de cada banco, hasta los 8 KB. Solo si nada de lo ya
    declarado la pisa: si un guion empezara ahi, el choque se avisaria."""
    f = []
    for p in range(1, N_PAGINAS):
        base = p * TAM_PAGINA
        i = TAM_PAGINA - 1
        while i >= 0 and rom[base + i] == 0xFF:
            i -= 1
        n = TAM_PAGINA - 1 - i
        if n >= 1:
            a = ORG[p] + i + 1
            f.append((p, a, ORG[p] + TAM_PAGINA, "relleno_del_banco_%d" % p,
                      "%d bytes a 0xFF hasta el final de los 8 KB del banco: espacio libre" % n, 16))
    return f


# ------------------------------------------------------------------- el sonido
# Todo lo que suena desde la ROM entra por pide_un_efecto (p14:86BA) con el
# numero en A: DE = 0x8738 + 2*A y B voces (1 por debajo de 0x3B, 3 por encima,
# 4 el 0xCB), cada una con la palabra siguiente. Las voces arrancan con la
# marca de efecto (+0x0E = 1, p14:872A), asi que su partitura se lee con
# mando_de_efecto (p14:820C). Cuando una nota pide un sub-efecto (+0x10, del 1
# al 6), p14:8287 saca de 0x8358 + 2*(+0x10) una tabla y de ella, con el nibble
# alto de la nota, el guion que se sigue con mando_de_musica hasta un 0xFF
# (p14:8335).

def partitura_de_efecto(rom, s, a):
    """Recorre una partitura. Devuelve (fin, {(sub, nota)} pedidos, destinos de 0xFE).

    `FE 00` NO es una vuelta sin fin: p14:8039 le da la vuelta a la marca
    +0x0E de la voz y sigue en el byte de detras. Con la marca puesta la
    partitura se lee con mando_de_efecto y sin ella con mando_de_musica (p14:
    80F0), asi que una misma partitura pasa de un lenguaje al otro. `FE n dir`
    con n distinto de cero si repite: n vueltas volviendo a dir (p14:800B).
    """
    subs, destinos = set(), set()
    sub = 0
    efecto = True                               # p14:872A la arranca puesta
    for _ in range(20000):
        b = leer(rom, s, a)
        if b == 0xFE:
            n = leer(rom, s, a + 1)
            if n == 0:                          # p14:8039: cambio de lenguaje
                efecto = not efecto
                a += 2
                continue
            destinos.add(palabra(rom, s, a + 2))
            a += 4
            continue
        if b == 0xFF:                           # p14:80ED callar
            return a + 1, subs, destinos
        if not efecto:
            a = _paso_de_musica(rom, s, a)
            continue
        while True:                             # p14:820C
            if b & 0xF0 == 0xD0:
                a += 1
                b = leer(rom, s, a)
            if b >= 0xF0:                       # el barrido: dos bytes
                a += 2
                b = leer(rom, s, a)
            if b >= 0xE0:
                low = b & 0x0F
                a += 1
                if low in (8, 0x0F):            # banderas: vuelta a empezar el mando
                    if low == 0x0F:
                        sub = 0
                    b = leer(rom, s, a)
                    continue
                if 9 <= low <= 0x0E:
                    sub = low - 8
                b = leer(rom, s, a)
            break
        if sub:                                 # la nota: un byte
            subs.add((sub, b >> 4))
        a += 1
    raise FueraDelBanco("partitura de %04X sin fin" % a)


def _paso_de_musica(rom, s, a):
    """Un paso de mando_de_musica (p14:80F8). Devuelve donde empieza el siguiente."""
    b = leer(rom, s, a)
    if b & 0xF0 == 0x20:                        # instrumento y volumen
        a += 2
        if b == 0x20:                           # el 0x20 pelado: un silencio de dos bytes
            return a
        if b & 0x08:                            # con envolvente: dos bytes mas
            a += 2
        b = leer(rom, s, a)
    if b & 0xF0 == 0x10:                        # el ruido
        a += 1
    leer(rom, s, a + 1)                         # la nota, dos bytes
    return a + 2


def guion_de_musica(rom, s, a):
    """Recorre un sub-guion (mando_de_musica hasta un 0xFF, p14:8335). Devuelve el fin."""
    for _ in range(20000):
        if leer(rom, s, a) == 0xFF:
            return a + 1
        a = _paso_de_musica(rom, s, a)
    raise FueraDelBanco("guion de musica de %04X sin fin" % a)


def sonido(rom, bloques):
    s = (1, 14, 15)
    f = []
    ptrs, a = [], 0x873A                        # la entrada 0 son bytes del djnz de 0x8737
    while a < (min(ptrs) if ptrs else 0x10000):
        ptrs.append(palabra(rom, s, a))
        a += 2
    fin_tabla = a
    _seguido(rom, s, 0x873A, fin_tabla)
    f.append((14, 0x873A, fin_tabla, "partituras_de_cada_sonido",
              "%d punteros, desde el sonido 1: p14:8706 hace DE = 0x8738 + 2*A y cada voz del sonido coge la "
              "palabra siguiente (una voz por debajo de 0x3B, tres por encima y cuatro el 0xCB). La tabla acaba "
              "donde empieza la primera partitura" % len(ptrs), 2))
    subs = set()
    pendientes = [(p, "voz del sonido 0x%02X" % (i + 1), "0x873A[%d]" % i) for i, p in enumerate(ptrs)]
    vistas = set()
    while pendientes:
        p, que, quien = pendientes.pop()
        if p in vistas:
            continue
        vistas.add(p)
        try:
            fin, pedidos, destinos = partitura_de_efecto(rom, s, p)
        except FueraDelBanco as e:
            if quien.startswith("0xFE"):
                AVISOS_RECORRIDOS.append("sonido: el %s lleva a %04X, que no se puede leer: %s" % (quien, p, e))
                continue
            raise
        subs |= pedidos
        anota(rom, bloques, s, p, "partitura", True, "pide_un_efecto", quien, extra=que, fin_dado=fin)
        # Los destinos de 0xFE NO se siguen: probado el 2026-09-15, salen
        # direcciones imposibles (0x0228, 0xFEC8) y hasta codigo del banco 1,
        # asi que el lenguaje de efecto no esta entendido del todo.
    if leer(rom, s, 0xB80F) == 0xFF and leer(rom, s, 0xB810) == 0xFF:
        f.append((15, 0xB810, 0xB811, "ff_de_mas_B810",
                  "un 0xFF de mas: la partitura de 0xB7DD (sonido 0xB5) ya se cierra con el de 0xB80F y la del "
                  "sonido 0xB6 empieza en 0xB811. A este no llega nadie", 1))
    # Las tres tablas de sub-efectos (0x835A: 0x8360, 0x84DD, 0x85D6). Cada una
    # llega hasta su primer guion, y se recorren enteras: el nibble de la nota
    # que la indexa puede valer cualquiera de sus entradas.
    usados = {x for x, _ in subs}
    for k in (1, 2, 3):
        t_ = palabra(rom, s, 0x8358 + 2 * k)
        gs, a = [], t_
        while a < (min(gs) if gs else 0x10000):
            gs.append(palabra(rom, s, a))
            a += 2
        _seguido(rom, s, t_, a)
        f.append((14, t_, a, "sub_efecto_%d" % k,
                  "%d punteros a los guiones de musica del sub-efecto %d: p14:8287 la saca de 0x8358 + 2*%d y la "
                  "indexa con el nibble alto de la nota%s. Acaba donde empieza su primer guion"
                  % (len(gs), k, k, "" if k in usados else " (ninguna partitura de la tabla de sonidos lo pide)"),
                  2))
        for n, g in enumerate(gs):
            anota(rom, bloques, s, g, "musica", True, "p14:8287", "sub-efecto %d nota %d" % (k, n),
                  extra="sub-efecto %d, nota %d" % (k, n), fin_dado=guion_de_musica(rom, s, g))
    return f


RECORRIDOS = (tabla_decorados, tabla_565F, texto_que_sube, barra_de_nueve,
              tablas_de_marcas, animacion_del_fondo, tabla_A605, tabla_BA0B,
              banco_10_terreno, banco_13_fases, sueltos_del_banco_13, banco_11, banco_11_resto, demo_y_tiras_de_p03, enemigos, banco_13_final, bancos_6_y_8,
              tablas_del_despachador, rellenos, sonido)


def recoge(rom, t):
    """{banco: {(ini, fin): {"lector", "fmt", "desde": set, "bytes"}}}, las D fijas y los avisos."""
    bloques = defaultdict(dict)
    avisos = []
    lis = Listados()
    fijas = []
    global TRAZA
    TRAZA = t
    for r in RECORRIDOS:
        try:
            fijas += r(rom, bloques)
        except FueraDelBanco as e:
            avisos.append("%s: %s" % (r.__name__, e))
    avisos += AVISOS_RECORRIDOS
    puentes = lis.puentes()
    # la llamada de dentro de cada puente: su puntero llega de fuera
    dentro_de_puentes = {(pb, x[2]) for (pb, _pa), x in puentes.items()}
    for dest, b, pc, s, hl, de in t.llamadas:
        efecto_puente = None
        if dest not in LECTORES:
            bd = banco_de(dest, s)
            if (bd, dest) not in puentes:
                continue
            dest, efecto_puente, _ = puentes[(bd, dest)]
        elif (b, pc) in dentro_de_puentes:
            continue
        if b == 0 and DENTRO_DE_LOS_LECTORES[0] <= pc < DENTRO_DE_LOS_LECTORES[1]:
            continue
        nom, reg, fmt, con_destino = LECTORES[dest]
        quien = "%s:%04X" % (nombre(b), pc)
        s, sim, duda = lis.simula(rom, b, pc, s)
        if efecto_puente:
            s = tuple(efecto_puente.get(i, s[i]) for i in range(3))
            nom += " (por el puente de %s)" % "%04X" % pc
        if duda:
            avisos.append("%s -> %s: %s" % (quien, nom, duda))
            continue
        ptr = sim[reg]
        if ptr is TRAZ:
            ptr = hl if reg == "hl" else de
        if ptr is None:
            avisos.append("sin puntero constante: %s -> %s" % (quien, nom))
            continue
        ptr &= 0xFFFF
        try:
            if fmt == "bloque":
                if sim["b"] is None or sim["c"] is None:
                    avisos.append("%s -> %s con DE=%04X: B y C sin saber" % (quien, nom, ptr))
                    continue
                anota(rom, bloques, s, ptr, fmt, True, nom, quien,
                      extra="%d columnas%s" % (sim["b"], " con espejo" if sim["c"] & 1 else ""),
                      fin_dado=ptr + 2 + sim["b"] * (32 if sim["c"] & 1 else 16))
            else:
                anota(rom, bloques, s, ptr, fmt, con_destino, nom, quien)
        except FueraDelBanco as e:
            avisos.append("%s -> %s con %s=%04X: %s" % (quien, nom, reg.upper(), ptr, e))
            continue
    return bloques, fijas, avisos


def ocupado(src, work, p):
    """bytearray del banco: 1 = codigo trazado, 2 = D escrita fuera de la seccion."""
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(work, nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - o, b - o):
                    m[i] = 1
    notas = os.path.join(src, nombre(p) + ".notes")
    dentro = False
    if os.path.exists(notas):
        for ln in open(notas, encoding="utf-8"):
            if ln.startswith(INI):
                dentro = True
            elif ln.startswith(FIN):
                dentro = False
            elif not dentro and ln.startswith("D "):
                q = ln.split(None, 3)
                for i in range(max(0, int(q[1], 0) - o), min(TAM_PAGINA, int(q[2], 0) - o)):
                    m[i] = 2
    return m


def une(bloques_banco):
    """Los bloques que se solapan se unen: un puntero a mitad de otro guion."""
    orden = sorted(bloques_banco.items())
    fuera = []
    for (a, f), e in orden:
        if fuera and a < fuera[-1][1]:
            pa, pf, pe = fuera[-1]
            pe = dict(pe)
            pe["entradas"] = pe["entradas"] + [(a, e)]
            fuera[-1] = (pa, max(pf, f), pe)
        else:
            fuera.append((a, f, {"entradas": [(a, e)]}))
    return fuera


def linea_d(p, a, f, info):
    ents = info["entradas"]
    lectores = sorted({l for _, e in ents for l in e["lector"]})
    fmt = ents[0][1]["fmt"]
    desde = sorted({d for _, e in ents for d in e["desde"]})
    extra = sorted({x for _, e in ents for x in e.get("extra", ())})
    que = {"mandos": "guion comprimido",
           "fffe": "guion de bytes sueltos (0xFF acaba, 0xFE otro destino)",
           "bloque": "bloque sin comprimir de columnas de 16 bytes",
           "partitura": "partitura de sonido",
           "musica": "guion de musica de un sub-efecto (hasta un 0xFF)"}[fmt]
    if extra:
        que += " (%s)" % "; ".join(extra[:4] + (["..."] if len(extra) > 4 else []))
    viene = next((e["viene"] for _, e in ents if e.get("viene")), None)
    sigue = next((e["sigue"] for _, e in ents if e.get("sigue") is not None), None)
    if viene:
        txt = "la cola del %s de 0x%04X del banco %d, que pasa de ranura sin cambiar de banco" % (
            que, viene[1], viene[0])
        nom = "cola_%04X" % viene[1]
    else:
        txt = "%s que lee %s" % (que, " y ".join(lectores))
        nom = ("guion_%04X" if fmt == "mandos" else "tira_%04X") % a
    if len(ents) > 1:
        txt += "; se entra por %s" % ", ".join("0x%04X" % x for x, _ in ents)
    txt += "; lo cargan %s" % ", ".join(desde[:6])
    if len(desde) > 6:
        txt += " y %d sitios mas" % (len(desde) - 6)
    if sigue is not None:
        txt += "; sigue en el banco %d, en la ranura de al lado" % sigue
    txt += " (%d bytes)" % (f - a)
    return ["D 0x%04X 0x%04X %s  %s" % (a, f, nom, txt), "F 0x%04X 16" % a]


def escribe(p, lineas):
    ruta = os.path.join(SRC, nombre(p) + ".notes")
    viejas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else []
    nuevas, dentro, puesto = [], False, False
    for ln in viejas:
        if ln.startswith(INI):
            dentro = True
            if lineas:
                nuevas += [INI] + lineas + [FIN]
            puesto = True
            continue
        if ln.startswith(FIN):
            dentro = False
            continue
        if not dentro:
            nuevas.append(ln)
    if not puesto and lineas:
        while nuevas and not nuevas[-1].strip():
            nuevas.pop()
        nuevas += ["", INI] + lineas + [FIN, ""]
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas).rstrip("\n") + "\n")


def main(argv):
    rom = open(ROM, "rb").read()
    t, _ = traza_completa(rom, SRC)
    bloques, fijas, avisos = recoge(rom, t)
    total = 0
    for p in range(N_PAGINAS):
        m = ocupado(SRC, WORK, p)
        buenas, conflictos = [], []
        candidatos = [(a, f, ("guion", info)) for a, f, info in une(bloques.get(p, {}))]
        candidatos += [(a, f, ("fija", (nom, txt, ancho))) for bb, a, f, nom, txt, ancho in fijas if bb == p]
        candidatos.sort(key=lambda x: (x[0], x[1]))
        for a, f, info in candidatos:
            marcas = [m[i - ORG[p]] for i in range(a, f)]
            if all(x == 2 for x in marcas):
                continue            # ya lo explica una D escrita a mano
            if buenas and a < buenas[-1][1] and info[0] == "fija" and info[1][0].startswith("relleno_") \
                    and buenas[-1][1] < f:
                # el 0xFF que cierra el ultimo guion no es relleno: el relleno empieza detras
                a = buenas[-1][1]
                info = ("fija", (info[1][0], "%d bytes a 0xFF hasta el final de los 8 KB del banco, detras "
                                 "del 0xFF que cierra el ultimo guion: espacio libre" % (f - a), info[1][2]))
                marcas = [m[i - ORG[p]] for i in range(a, f)]
            pisa = set(marcas) - {0}
            if buenas and a < buenas[-1][1]:
                conflictos.append("  %s 0x%04X-0x%04X se solapa con el bloque de 0x%04X-0x%04X"
                                  % (nombre(p), a, f, buenas[-1][0], buenas[-1][1]))
                continue
            if pisa:
                conflictos.append("  %s 0x%04X-0x%04X pisa %s" % (
                    nombre(p), a, f, " y ".join({1: "codigo trazado", 2: "una D escrita a mano"}[x] for x in sorted(pisa))))
                continue
            buenas.append((a, f, info))
        n = sum(f - a for a, f, _ in buenas)
        total += n
        if buenas or conflictos:
            print("%s: %d bloques, %d bytes%s" % (nombre(p), len(buenas), n,
                                                  ", %d en conflicto" % len(conflictos) if conflictos else ""))
            for c in conflictos:
                print(c)
        if "--escribe" in argv:
            lineas = []
            for a, f, (clase, info) in buenas:
                if clase == "guion":
                    lineas += linea_d(p, a, f, info)
                else:
                    nom, txt, ancho = info
                    lineas += ["D 0x%04X 0x%04X %s  %s" % (a, f, nom, txt), "F 0x%04X %d" % (a, ancho)]
            escribe(p, lineas)
    print("en total: %d bytes en bloques que lee el codigo" % total)
    if avisos:
        print("%d avisos:" % len(avisos))
        for x in sorted(set(avisos))[:60]:
            print("  " + x)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
