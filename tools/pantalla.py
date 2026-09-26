#!/usr/bin/env python3
"""La pantalla de una fase, montada como la monta p02:816D.

Leyendo el montaje del cartucho paso a paso, con las mismas condiciones por
decorado, y sin ejecutar ni una instruccion suya:

  p02:9325  lo primero de p00:5B91: los caracteres 0 a 15 de cada tercio, con
            el patron vacio y el color k en el caracter k -dieciseis bloques
            macizos, uno por color-. De ahi sale el cielo del 7 en los bosques.
  p00:5B91  la letra: 0xB423 en los patrones y 0xB597 en los colores, desde el
            caracter 0x0B y en los tres tercios. La carga p02:8202 al empezar
            cada fase; de ahi sale tambien el 0x0C macizo con el que se rellena
            el bosque.
  p00:51CD  el marcador: dos guiones del banco 6, en los tres tercios.
  p00:4995  los caracteres de cada tercio (tambien 49FC y 49D2), de las tres
  ...49D2   tablas de diez bytes por decorado de 0x4A93, 0x4AF7 y 0x4B5B, y el
            color del caracter 1 de 0x4A89.
  p02:966B  las diez piezas de la pantalla (0x4CD1 ... 0x5166), cada una con su
            condicion sobre el decorado. Las que llevan color cargan antes, en
            0xE4E0, una de las tablas de 24 bytes del banco 8 (0x96F6...) y
            pintan con C = 0x80: cada byte de color pasa por el cambio de
            p00:440D, seis parejas para la tinta y seis para el fondo.
  p00:57FB  los sprites (tools/sprites.py).
  p01:6000  el mapa del decorado: 672 bytes descomprimidos en 0xEBE0 y, en los
            decorados 0, 2 y 4, la fila del horizonte de 0xAC16 en 0xECA0.
  p01:6539  el primer paso de la animacion del fondo: la tabla de dos niveles
            de 0x8000 del banco 12, por decorado y por paso (0xE4C2 & 3), que
            p00:41BF copia sobre el mapa.
  p00:4265  y el mapa sube a la VRAM: 0xEBA0 es 0x3820.

Uso:  pantalla.py <fase> [volcado.vram volcado.ram]   compara con openMSX
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, Lienzo, TERCIOS, COLOR_DEL_FONDO,  # noqa: E402
                      GUION_DE_NOMBRES, da_la_vuelta, descomprime)
from sprites import carga_de_la_fase, decorado_de, TRIO  # noqa: E402


class Pantalla:
    """La VRAM y la RAM del juego, lo justo para montar la pantalla."""

    def __init__(self, cart):
        self.cart = cart
        self.li = Lienzo()
        self.ram = bytearray(0x10000)

    # --- p00:43F9 y p00:440D, al pie de la letra
    def prepara(self, v, c):
        if c & 0x80:
            return self.cambia_colores(v)
        if c & 0x01:
            return da_la_vuelta(v)
        return v

    def cambia_colores(self, v):
        alto = self.ram[0xE4E0:0xE4EC]
        bajo = self.ram[0xE4EC:0xE4F8]
        h = v
        a = h & 0x0F
        for k in range(0, 12, 2):
            if a == bajo[k]:
                h = (h & 0xF0) | bajo[k + 1]
                break
        a = h & 0xF0
        for k in range(0, 12, 2):
            if a == alto[k]:
                return (h & 0x0F) | alto[k + 1]
        return h

    def pinta(self, bancos, de, dest=None, c=0):
        """p00:4381 (dest None) y p00:4386."""
        cart = self.cart
        if dest is None:
            dest = cart.leer(de, bancos) | (cart.leer(de + 1, bancos) << 8)
            de += 2
            c = 0
        while True:
            mando = cart.leer(de, bancos)
            if mando == 0:
                return de
            de += 1
            n = mando & 0x7F
            if n == mando:
                v = self.prepara(cart.leer(de, bancos), c)
                de += 1
                for _ in range(n):
                    self.li.escribe(dest, v)
                    dest += 1
            elif n == 0:
                dest = cart.leer(de, bancos) | (cart.leer(de + 1, bancos) << 8)
                de += 2
                c = 0
            else:
                for _ in range(n):
                    self.li.escribe(dest, self.prepara(cart.leer(de, bancos), c))
                    de += 1
                    dest += 1

    def pinta_en_los_tres(self, bancos, de, dest, c=0):
        for k in range(3):
            self.pinta(bancos, de, dest + k * 0x800, c)

    def copia_bloques(self, bancos, hl):
        """p00:41BF: destino, bytes; 0xFE otro destino, 0xFF se acabo."""
        cart = self.cart
        de = cart.leer(hl, bancos) | (cart.leer(hl + 1, bancos) << 8)
        hl += 2
        while True:
            b = cart.leer(hl, bancos)
            if b == 0xFF:
                return
            if b == 0xFE:
                de = cart.leer(hl + 1, bancos) | (cart.leer(hl + 2, bancos) << 8)
                hl += 3
                continue
            self.ram[de & 0xFFFF] = b
            de += 1
            hl += 1

    def tabla_de_color(self, bancos, hl):
        """El `ld de,0E4E0h / ld bc,18h / ldir` de cada pieza."""
        for k in range(24):
            self.ram[0xE4E0 + k] = self.cart.leer(hl + k, bancos)


# --- p02:966B: las diez piezas, con la condicion de cada una sobre el decorado.
# Cada orden es (de, destino o None, C); None en el destino es pinta_sin_color.
# La tabla de color va por decorado: (lista de decorados, direccion) y la
# ultima entrada, sin lista, es la de los demas.
PIEZAS = (
    ("4CD1", lambda d: d != 8,
     ((0x6000, None, 0), (0x6089, 0x2FD8, 1), (0x60E8, None, 0), (0x6230, 0x36F0, 1)),
     (((0, 1), 0x970E), ((4, 5), 0x973E), ((7,), 0x9726), (None, 0x96F6)),
     ((0x6095, 0x0F00, 0x80), (0x60E3, 0x0FD8, 0x80), (0x6237, 0x1570, 0x80), (0x62FE, 0x16F0, 0x80))),
    ("4D7F", lambda d: d != 8,
     ((0x6304, None, 0), (0x6360, 0x2ED0, 1), (0x63B9, None, 0)),
     (((0, 1), 0x9756), ((4,), 0x976E), ((5,), 0x979E), ((7,), 0x9786), (None, 0x96F6)),
     ((0x6386, 0x0E38, 0x80), (0x63A0, 0x0ED0, 0x80), (0x6473, 0x1718, 0x80))),
    ("4E1A", lambda d: d < 4,
     ((0x6496, None, 0), (0x649C, 0x2CE0, 1), (0x64E4, None, 0), (0x6538, 0x3378, 1)),
     (((0, 1), 0x97B6), (None, 0x96F6)),
     ((0x64D9, 0x0C68, 0x80), (0x64DE, 0x0CE0, 0x80), (0x6562, 0x12B8, 0x80), (0x6586, 0x1378, 0x80))),
    ("4EB6", lambda d: d not in (4, 5, 7, 8),
     ((0x6591, None, 0), (0x65B1, 0x2DE0, 1), (0x6630, None, 0), (0x665A, 0x3470, 1)),
     (((0, 1), 0x97CE), (None, 0x96F6)),
     ((0x65F2, 0x0D58, 0x80), (0x6606, 0x0DE0, 0x80), (0x66DA, 0x13B0, 0x80), (0x66F5, 0x1470, 0x80))),
    ("4F5B", lambda d: d == 7,
     ((0x6714, None, 0), (0x682F, None, 0), (0x67CB, None, 0), (0x68EA, None, 0)),
     None, ()),
    ("4FAC", lambda d: d in (4, 5),
     ((0x6932, None, 0), (0x6965, 0x2DE8, 1), (0x69F5, None, 0), (0x6AAF, 0x3460, 1),
      (0x69A0, None, 0), (0x69CF, 0x0DE8, 0), (0x6AD6, None, 0), (0x6B48, 0x1460, 0)),
     None, ()),
    ("502D", lambda d: d == 7,
     ((0x6B64, None, 0), (0x6B82, 0x2DD8, 1), (0x6C11, None, 0), (0x6C13, 0x3420, 1),
      (0x6BDB, None, 0), (0x6BE9, 0x0DD8, 0), (0x6C7A, None, 0), (0x6C7C, 0x1420, 0)),
     None, ()),
    ("50AA", lambda d: d == 8,
     ((0x6C9C, None, 0), (0x6FB9, 0x2570, 1), (0x6FDB, None, 0), (0x7640, 0x2FC8, 1),
      (0x6FC3, None, 0), (0x6FD8, 0x0570, 0), (0x7655, None, 0), (0x7683, 0x0FC8, 0)),
     None, ()),
    ("5127", lambda d: d == 8, ((0x7686, None, 0),), None, ()),
    ("5166", lambda d: d not in (5, 6, 7, 8, 9),
     ((0x7806, None, 0), (0x7857, 0x24F0, 1), (0x7891, None, 0), (0x78C8, 0x04F0, 0)),
     None, ()),
)

# p01:6000: los decorados 0, 2 y 4 copian ademas la fila del horizonte (p01:61DD)
CON_HORIZONTE = (0, 2, 4)
HORIZONTES = 0xAC16          # banco 13, un puntero por decorado
ANIMACION_DEL_FONDO = 0x8000  # banco 12, dos niveles: decorado y paso


def monta_la_pantalla(cart, fase, paso=1, p=None):
    """Lo que hay en la VRAM (y en el espejo de 0xEBA0) al empezar la fase."""
    p = p or Pantalla(cart)
    d = decorado_de(cart, fase)
    p.ram[0xE0A1] = d
    # p02:9325, los dieciseis bloques de color, y p00:5B91, la letra
    lo_que_se_hereda(p)
    # p00:51CD, el marcador
    p.pinta_en_los_tres((4, 5, 6), 0xB71B, 0x2590)
    p.pinta_en_los_tres((4, 5, 6), 0xB96A, 0x0590)
    # p00:4995, 49FC y 49D2: los tres tercios y el color del caracter 1
    v = cart.leer(COLOR_DEL_FONDO + d, (4, 5, 6))
    for i in range(8):
        p.li.escribe(0x0008 + i, v)
    for tabla, pat, col in TERCIOS:
        e = tabla + d * 10
        pal = [cart.leer(e + 2 * k, (4, 5, 6)) | (cart.leer(e + 2 * k + 1, (4, 5, 6)) << 8)
               for k in range(5)]
        a, b, dest, c, dd = pal
        p.pinta((4, 5, 6), a, pat, 0)
        p.pinta((4, 5, 6), b, dest, 1)
        p.pinta((4, 5, 6), c, col, 0)
        p.pinta((4, 5, 6), dd, dest - 0x2000, 0)
    # p02:966B: las diez piezas
    for _nombre, vale, patrones, tablas, colores in PIEZAS:
        if not vale(d):
            continue
        for de, dest, c in patrones:
            p.pinta(TRIO, de, dest, c)
        if tablas:
            for cuales, hl in tablas:
                if cuales is None or d in cuales:
                    p.tabla_de_color(TRIO, hl)
                    break
            for de, dest, c in colores:
                p.pinta(TRIO, de, dest, c)
    # los sprites
    carga_de_la_fase(cart, fase, p.li)
    # p01:6000: el mapa del decorado, y el horizonte
    descomprime(cart, (1, 12, 13), GUION_DE_NOMBRES[d], p.ram)
    if d in CON_HORIZONTE:
        b = (1, 12, 13)
        q = HORIZONTES + 2 * d
        hl = cart.leer(q, b) | (cart.leer(q + 1, b) << 8)
        for k in range(32):
            p.ram[0xE510 + k] = cart.leer(hl + k, b)
            p.ram[0xECA0 + k] = p.ram[0xE510 + k]
    # p01:6539: un paso de la animacion del fondo
    anima_el_fondo(p, d, paso)
    # p00:4265: el espejo sube a la VRAM
    sube_el_mapa(p)
    return p


# --- p01:65CF: el final de la fase. Nueve cortes, a 0x30, 0x25, 0x20, 0x15,
# 0x10, 8, 5, 2 y 0 de la meta (en BCD). Los de 0x30, 0x25, 0x15 y 8 cargan
# caracteres; los otros cinco copian con p00:41BF una de las cinco tiras de
# p01:66B8 sobre el mapa, cada una mas grande que la anterior. Si el 1-2-3 de
# la fase (0xE093) vale 3 -las fases 3, 6, 9...- lo que se acerca es el
# DINOSAURIO; si no, la meta de siempre.
def _tabla_por_decorado(d, tablas):
    for cuales, hl in tablas:
        if cuales is None or d in cuales:
            return hl


CORTES = (0x30, 0x25, 0x20, 0x15, 0x10, 0x08, 0x05, 0x02, 0x00)
FINALES = {
    # p00:5212, p00:529A, p00:5256 y p00:530A; tiras de 0xA605 del banco 11
    "meta": {
        0x30: (((0x9229, None, 0), (0x9234, 0x2EA0, 1)), None, ()),
        0x25: ((), (((0, 1), 0x9816), ((4, 5), 0x97E6), ((7,), 0x97FE), (None, 0x96F6)),
               ((0x9373, 0x0D50, 0x80), (0x937A, 0x0EA0, 0x80))),
        0x15: (((0x9457, None, 0), (0x9473, 0x3488, 1)), None, ()),
        0x08: ((), (((0, 1), 0x9816), ((4, 5), 0x97E6), ((7,), 0x97FE), (None, 0x96F6)),
               ((0x95FB, 0x12B8, 0x80), (0x960D, 0x1488, 0x80))),
        "tiras": 0xA605,
    },
    # p00:537A, p00:5424, p00:53CF y p00:5498; tiras de 0xA76B del banco 11
    "dinosaurio": {
        0x30: (((0x8B7D, None, 0), (0x8C2C, 0x2E00, 1), (0x8D0E, None, 0), (0x8D31, 0x2F80, 1)), None, ()),
        0x25: ((), (((0, 1), 0x982E), (None, 0x96F6)),
               ((0x8DA3, 0x0C68, 0x80), (0x8DB5, 0x0E00, 0x80), (0x8E13, 0x0EE8, 0x80), (0x8E19, 0x0F80, 0x80))),
        0x15: (((0x8E52, None, 0), (0x8EF1, 0x33E0, 1), (0x8F56, None, 0), (0x8FFC, 0x3600, 1)), None, ()),
        0x08: ((), (((0, 1), 0x982E), (None, 0x96F6)),
               ((0x90E7, 0x12B8, 0x80), (0x9105, 0x13E0, 0x80), (0x9138, 0x1450, 0x80), (0x9150, 0x1600, 0x80))),
        "tiras": 0xA76B,
    },
}
TIRA_DE_CADA_CORTE = {0x20: 0, 0x10: 2, 0x05: 4, 0x02: 6, 0x00: 8}


def que_final(fase):
    """El 1-2-3 de la fase es ((fase - 1) % 3) + 1 (p02:831D); con 3, dinosaurio."""
    return "dinosaurio" if (fase - 1) % 3 == 2 else "meta"


def aplica_el_corte(p, fase, corte):
    """Un solo corte del final: la carga de caracteres o la tira que toque."""
    d = p.ram[0xE0A1]
    f = FINALES[que_final(fase)]
    if corte in TIRA_DE_CADA_CORTE:
        b = (1, 10, 11)
        q = f["tiras"] + TIRA_DE_CADA_CORTE[corte]
        p.copia_bloques(b, p.cart.leer(q, b) | (p.cart.leer(q + 1, b) << 8))
        return
    patrones, tablas, colores = f[corte]
    for de, dest, c in patrones:
        p.pinta(TRIO, de, dest, c)
    if tablas:
        p.tabla_de_color(TRIO, _tabla_por_decorado(d, tablas))
        for de, dest, c in colores:
            p.pinta(TRIO, de, dest, c)


def final_de_fase(p, fase, hasta=0x00):
    """Los cortes del final, de 0x30 hasta `hasta` incluido, sobre la pantalla."""
    d = p.ram[0xE0A1]
    f = FINALES[que_final(fase)]
    for corte in CORTES:
        if corte in TIRA_DE_CADA_CORTE:
            b = (1, 10, 11)
            q = f["tiras"] + TIRA_DE_CADA_CORTE[corte]
            hl = p.cart.leer(q, b) | (p.cart.leer(q + 1, b) << 8)
            p.copia_bloques(b, hl)
        else:
            patrones, tablas, colores = f[corte]
            for de, dest, c in patrones:
                p.pinta(TRIO, de, dest, c)
            if tablas:
                p.tabla_de_color(TRIO, _tabla_por_decorado(d, tablas))
                for de, dest, c in colores:
                    p.pinta(TRIO, de, dest, c)
        if corte == hasta:
            break
    return p


# --- el espacio: p02:84FA (estado 8) monta el bonus con el decorado 8 y NO
# recarga ni la letra ni el marcador ni los dieciseis bloques de color de
# p02:9325: los hereda de la fase de la que se viene, y los meteoritos los usan
# (el relleno rojo es el caracter 8). Lo demas, igual que una fase, con las
# piezas que valen para el 8 (0x50AA, la Tierra, y 0x5127, los sprites de
# 0x7686) y el mapa de 0xA314.
def lo_que_se_hereda(p):
    """p02:9325 y p00:5B91, que se cargaron al empezar la fase."""
    for t in range(3):
        for k in range(0x80):
            p.li.escribe(0x2000 + t * 0x800 + k, 0)
        for ch in range(16):
            for k in range(8):
                p.li.escribe(t * 0x800 + ch * 8 + k, ch)
    p.pinta_en_los_tres((4, 5, 6), 0xB423, 0x2058)
    p.pinta_en_los_tres((4, 5, 6), 0xB597, 0x0058)


def monta_el_espacio(cart, paso=1, p=None):
    return monta_la_escena(cart, 8, paso, p)


# --- el warp: p02:85E5 (estado 10) hace lo mismo con el decorado 9 que pone
# p03:B8DD: la cueva del decorado 6 con los colores de su fila de 0x4A89 y de
# sus tercios, y un recorrido de 0x150 pasos.
def monta_el_warp(cart, paso=1, p=None):
    return monta_la_escena(cart, 9, paso, p)


def monta_la_escena(cart, d, paso=1, p=None):
    """Los montajes que no son de una fase (estados 8 y 10)."""
    from sprites import carga_del_decorado
    p = p or Pantalla(cart)
    lo_que_se_hereda(p)
    p.ram[0xE0A1] = d
    v = cart.leer(COLOR_DEL_FONDO + d, (4, 5, 6))
    for i in range(8):
        p.li.escribe(0x0008 + i, v)
    for tabla, pat, col in TERCIOS:
        e = tabla + d * 10
        a, b, dest, c, dd = [cart.leer(e + 2 * k, (4, 5, 6)) | (cart.leer(e + 2 * k + 1, (4, 5, 6)) << 8)
                             for k in range(5)]
        p.pinta((4, 5, 6), a, pat, 0)
        p.pinta((4, 5, 6), b, dest, 1)
        p.pinta((4, 5, 6), c, col, 0)
        p.pinta((4, 5, 6), dd, dest - 0x2000, 0)
    carga_del_decorado(cart, d, p.li)
    for _nombre, vale, patrones, tablas, colores in PIEZAS:
        if vale(d):
            for de, dest, c in patrones:
                p.pinta(TRIO, de, dest, c)
    descomprime(cart, (1, 12, 13), GUION_DE_NOMBRES[d], p.ram)
    anima_el_fondo(p, d, paso)
    sube_el_mapa(p)
    return p


def anima_el_fondo(p, d, paso):
    b = (1, 12, 13)
    cart = p.cart
    q = ANIMACION_DEL_FONDO + 2 * d
    t = cart.leer(q, b) | (cart.leer(q + 1, b) << 8)
    q = t + 2 * (paso & 3)
    hl = cart.leer(q, b) | (cart.leer(q + 1, b) << 8)
    p.copia_bloques(b, hl)


def sube_el_mapa(p, desde=0xEBE0, hasta=0xEE80):
    for a in range(desde, hasta):
        p.li.escribe(a - 0xEBA0 + 0x3820, p.ram[a])


def compara(p, v, zonas=((0x0000, 0x1800), (0x2000, 0x3800), (0x3860, 0x3B00))):
    """Solo los bytes que el montaje pone: (tocados, distintos, primeros)."""
    toc = dis = 0
    malos = []
    for ini, fin in zonas:
        for a in range(ini, fin):
            if p.li.tocado[a]:
                toc += 1
                if p.li.v[a] != v[a]:
                    dis += 1
                    if len(malos) < 10:
                        malos.append((a, p.li.v[a], v[a]))
    return toc, dis, malos


def main():
    cart = Cartucho()
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    fase = int(sys.argv[1])
    paso = 1
    if len(sys.argv) > 3:
        with open(sys.argv[3], "rb") as f:
            ram = f.read()
        paso = ram[0x4C2] & 3
    p = monta_la_pantalla(cart, fase, paso)
    print("fase %d, decorado %d, paso %d" % (fase, decorado_de(cart, fase), paso))
    if len(sys.argv) > 2:
        with open(sys.argv[2], "rb") as f:
            v = f.read()
        toc, dis, malos = compara(p, v)
        print("tocados %d  distintos %d  %s" % (toc, dis, " ".join(
            "%04X:%02X/%02X" % m for m in malos)))


if __name__ == "__main__":
    main()
