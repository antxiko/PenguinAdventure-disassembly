#!/usr/bin/env python3
"""Las escenas de p03:AA80: el arbol de la mitad y los dos finales.

p02:82C3, al acabar una fase cuyo 1-2-3 vale 3, deja en 0xE0B9 que escena
toca: 2 tras la fase 12 -el arbol-, y tras la 24 el final: 0 el bueno y 1 el
malo (las veces que se ha pausado, ver HALLAZGOS). Las tres se montan igual:

  - los caracteres: p00:48C3 (el guion 0x8AFB del banco 5, el jardin) para el
    arbol, y p00:48FC (doce guiones de los bancos 5 y 6, el palacio) para los
    finales;
  - los sprites: p00:5667, p00:56D9 y p00:5789 para el arbol; p00:57FB y, en
    el final malo, p00:5717;
  - la pantalla: 32 columnas de 21 filas (0xB2EC el jardin, 0xB5F1 el palacio,
    banco 13) que p01:7B85 pinta de una en una DEL CENTRO HACIA FUERA: con
    0xE0B8 bajando desde 0x20, la columna es la mitad del contador y, si el bit
    que sale es 0, la de enfrente (xor 0x1F). La 0 va a la 15, la 1 a la 16, la
    2 a la 14...;
  - en el final malo, mientras se pintan las diez columnas del centro
    (0xE0B8 de 0x1F a 0x16), p01:7BC4 copia cinco bytes de 0xB963 en las filas
    8 a 12 de cada una: lo que tapa el sitio de la princesa;
  - y los mensajes, guiones comprimidos que p01:7BE7 descomprime encima: 0xB58C
    en el arbol; 0xB90D, 0xB930, 0xB93C y 0xB891 en el final bueno, y 0xB995
    -justo detras de la pieza- en el malo.
Y lo que se hereda de la fase: los bloques de color y la letra de p02:9325 y
p00:5B91, y el color del caracter 1 de su decorado (p00:4995), el 0 en las
fases 12 y 24.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import COLOR_DEL_FONDO, descomprime  # noqa: E402
from pantalla import Pantalla, lo_que_se_hereda, sube_el_mapa  # noqa: E402
from sprites import carga_del_decorado, TRIO  # noqa: E402

B456 = (4, 5, 6)
B13 = (1, 12, 13)
PANTALLAS = {"arbol": 0xB2EC, "palacio": 0xB5F1}


def columna_de(j):
    """p01:7BAE: la columna de pantalla de la columna j de la tabla."""
    e = 0x20 - (j + 1)
    a = e >> 1
    return a if e & 1 else a ^ 0x1F


def pinta_columnas(p, base):
    """p01:7B85, las 32 columnas: 21 bytes cada una, un byte por fila."""
    for j in range(32):
        col = columna_de(j)
        for f in range(21):
            p.ram[0xEB80 + (3 + f) * 32 + col] = p.cart.leer(base + j * 21 + f, B13)


CARGA_DEL_PALACIO = (           # p00:48FC: (guion, destino o None, C)
    (0x9BB6, None, 0), (0x9D25, 0x2478, 1), (0x9DFA, None, 0), (0xA1E1, 0x2E40, 1),
    (0xA52C, None, 0), (0xA575, 0x31D0, 1), (0x9DE5, None, 0), (0x9DF1, 0x0478, 0),
    (0xA387, None, 0), (0xA4F6, 0x0E40, 0), (0xA6B7, None, 0), (0xA6ED, 0x11D0, 0),
)


MENSAJES = {"arbol": (0xB58C,), "bueno": (0xB90D, 0xB930, 0xB93C, 0xB891),
            "malo": (0xB995,)}
PIEZA_DEL_FINAL_MALO = 0xB963


def monta_la_escena(cart, cual, con_mensajes=True, p=None):
    """cual: "arbol", "bueno" o "malo"."""
    p = p or Pantalla(cart)
    lo_que_se_hereda(p)
    v = cart.leer(COLOR_DEL_FONDO + 0, B456)          # el decorado 0 de la 12 y la 24
    for i in range(8):
        p.li.escribe(0x0008 + i, v)
    if cual == "arbol":
        p.pinta(B456, 0x8AFB)                          # p00:48C3
        p.pinta(TRIO, 0x7FBC)                          # p00:5667
        p.pinta(TRIO, 0x7E3C, 0x1CA0, 0)               # p00:56D9
        p.pinta(TRIO, 0x82AD)                          # p00:5789
        pinta_columnas(p, PANTALLAS["arbol"])
    else:
        carga_del_decorado(cart, 0, p.li)              # p00:57FB, en la fase 24
        for de, dest, c in CARGA_DEL_PALACIO:
            p.pinta(B456, de, dest, c)
        if cual == "malo":
            p.pinta(TRIO, 0x852C)                      # p00:5717
        pinta_columnas(p, PANTALLAS["palacio"])
        if cual == "malo":                             # p01:7BC4
            for j in range(10):
                col = columna_de(j)
                for f in range(5):
                    p.ram[0xEB80 + (8 + f) * 32 + col] = cart.leer(
                        PIEZA_DEL_FINAL_MALO + j * 5 + f, B13)
    if con_mensajes:
        for m in MENSAJES[cual]:
            descomprime(cart, B13, m, p.ram)           # p01:7BE7
    sube_el_mapa(p, 0xEBE0, 0xEE80)
    return p


# Los sprites fijos de cada escena: la figura de nueve de 0xA456 (p03:AD0B la
# copia a los sprites 0 a 8) en el arbol y en el final bueno, y en el malo los
# ocho bytes de 0xAE07 que p03:AC59 lleva a los sprites 6 y 7.
SPRITES_DE_LA_ESCENA = {"arbol": (0xA456, 9, 0), "bueno": (0xA456, 9, 0),
                        "malo": (0xAE07, 2, 6)}


def sprites_de_la_escena(cart, cual):
    tabla, n, primero = SPRITES_DE_LA_ESCENA[cual]
    fuera = []
    for k in range(n):
        y, x, pt, co = (cart.leer(tabla + 4 * k + i, (1, 2, 3)) for i in range(4))
        fuera.append((primero + k, y + 1, x, pt, co & 0x0F))
    return fuera


def lamina_de_las_escenas(cart):
    from vram import fondo
    from figuras import pinta_sprites
    paneles = []
    for cual in ("arbol", "bueno", "malo"):
        p = monta_la_escena(cart, cual)
        img = fondo(p.li.v)
        spr = [(n, y, x, pt, co) for n, y, x, pt, co in sprites_de_la_escena(cart, cual)]
        pinta_sprites(img, p.li, 0, 0, [(n, y, x, pt, co) for n, y, x, pt, co in spr])
        paneles.append([fila[:] for fila in img[24:]])
    alto, ancho = len(paneles[0]), 256
    img = [[1] * (3 * ancho + 16) for _ in range(alto)]
    for i, pan in enumerate(paneles):
        for y in range(alto):
            img[y][i * (ancho + 8):i * (ancho + 8) + ancho] = pan[y]
    return img


def main():
    from graficos import Cartucho, IMAGENES, guarda_png
    cart = Cartucho()
    print(guarda_png(lamina_de_las_escenas(cart), os.path.join(IMAGENES, "escenas.png"), escala=2))


if __name__ == "__main__":
    main()
