#!/usr/bin/env python3
"""Las figuras del juego compuestas desde la ROM: el jugador y los bichos.

Nada de esto sale del emulador. Los patrones son los que carga la fase
(tools/sprites.py), las parejas de patron y color salen de las tablas del
cartucho y la colocacion de cada sprite, de la rutina que la hace:

  p03:A8DB   el cuadro de dos por dos de siempre: 0 y 1 arriba, 2 y 3 debajo.
  p02:9A1D   nadando en la superficie (decorados 4 y 5): 2 y 3 arriba, 0 y 1
             ocho filas mas abajo, con la pose 10 y la espuma de 0x00/0x04 o
             0x08/0x0C segun el bit 4 del contador de cuadros.
  p02:9C3A   bajo el mar (decorado 7): 1 y 2 arriba, el 3 trece filas mas
             abajo y el 0 dieciseis, los dos ocho columnas metidos.
  p03:A742   la misma figura en los sprites 5 a 8 -la del bonus del espacio-,
             con los colores pisados por p03:A778: 4 a los dos de arriba, 0x0F
             al 8 y 0x0A al 5.

La sombra son los sprites 18 y 19 (patron 0x30) en la fila 0xAE, cuatro y doce
columnas a la derecha de la X del jugador (p03:A9C3). Su color sale de la
plantilla de 0xAD68 (4, azul) salvo en los decorados 2, 3 y 6, donde p01:6353
la pone a 6.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, Lienzo, IMAGENES, SPRITES_PAT,  # noqa: E402
                      decorado, guarda_png, pinta_pantalla,
                      poses_de_lo_que_se_maneja, _texto)
from sprites import carga_del_decorado  # noqa: E402

FONDO = 1


def pinta_sprites(img, li, x0, y0, sprites):
    """sprites: [(n, dy, dx, patron, color)]; el de numero mas bajo, encima."""
    for n, dy, dx, p, c in sorted(sprites, key=lambda s: -s[0]):
        if not c:
            continue
        base = SPRITES_PAT + (p & 0xFC) * 8
        for y in range(16):
            izq, der = li.v[base + y], li.v[base + 16 + y]
            for x in range(16):
                b = izq if x < 8 else der
                if (b >> (7 - (x & 7))) & 1:
                    yy, xx = y0 + dy + y, x0 + dx + x
                    if 0 <= yy < len(img) and 0 <= xx < len(img[0]):
                        img[yy][xx] = c


def en_cuadro(pose):
    """p03:A8DB + p03:A8F5."""
    (p0, c0), (p1, c1), (p2, c2), (p3, c3) = pose
    return [(0, 0, 0, p0, c0), (1, 0, 16, p1, c1),
            (2, 16, 0, p2, c2), (3, 16, 16, p3, c3)]


def nadando(pose10, espuma, cabeceo):
    """p02:9A1D. espuma 0 -> 0x00/0x04, 1 -> 0x08/0x0C; cabeceo baja 2 filas."""
    (_p0, c0), (_p1, c1), (p2, c2), (p3, c3) = pose10
    a, b = (0x00, 0x04) if espuma == 0 else (0x08, 0x0C)
    d = 2 if cabeceo else 0
    return [(2, d, 0, p2, c2), (3, d, 16, p3, c3),
            (0, 8, 0, a, c0), (1, 8, 16, b, c1)]


def bajo_el_mar(pose):
    """p02:9C3A."""
    (p0, c0), (p1, c1), (p2, c2), (p3, c3) = pose
    return [(1, 0, 0, p1, c1), (2, 0, 16, p2, c2),
            (3, 13, 8, p3, c3), (0, 16, 8, p0, c0)]


def en_el_espacio(pose):
    """p03:A742 y p03:A778: la pareja k va al sprite 5+k, y los colores se pisan."""
    (p0, _c0), (p1, _c1), (p2, _c2), (p3, _c3) = pose
    return [(6, 0, 0, p1, 4), (7, 0, 16, p2, 4),
            (8, 13, 8, p3, 0x0F), (5, 16, 8, p0, 0x0A)]


def sombra(color, en_el_aire=False):
    """p03:A9C3; en el aire las dos mitades se juntan en la columna +8."""
    if en_el_aire:
        return [(18, 0, 8, 0x30, color), (19, 0, 8, 0x30, color)]
    return [(18, 0, 4, 0x30, color), (19, 0, 12, 0x30, color)]


# Las filas de la lamina: que carga de sprites, que poses y como se colocan.
# La fila de la sombra es la 0xAE y la del jugador la 0x90 (0xE204 en
# carrera, p03:AD1A), asi que la sombra va 0x1E filas por debajo.
FILAS_DEL_JUGADOR = (
    ("EN TIERRA", 3, "cuadro", (0, 1, 2, 3, 5, 6, 4), 6),
    ("EN EL HIELO", 0, "cuadro", (0, 1, 2, 3, 5, 6, 4), 4),
    ("NADANDO", 4, "nadando", ((0, 0), (0, 1), (1, 0), (1, 1)), None),
    ("BAJO EL MAR", 7, "mar", (7, 8, 9), 4),
    ("EN EL ESPACIO", 8, "espacio", (7, 8, 9), None),
)


def color_del_suelo(cart, d):
    """El color de la pantalla del decorado en la columna del centro, abajo:
    el suelo por el que se corre (o el negro del espacio)."""
    return pinta_pantalla(decorado(cart, d))[180][128]


def lamina_del_jugador(cart):
    poses = poses_de_lo_que_se_maneja(cart)
    ancho, alto_fila = 8 + 7 * 40, 60
    img = [[FONDO] * ancho for _ in range(len(FILAS_DEL_JUGADOR) * alto_fila)]
    for f, (rotulo, d, forma, cuales, c_sombra) in enumerate(FILAS_DEL_JUGADOR):
        li = Lienzo()
        carga_del_decorado(cart, d, li)
        y0 = f * alto_fila
        suelo = color_del_suelo(cart, d) if d != 8 else 1
        for y in range(y0, y0 + alto_fila - 2):
            for x in range(ancho):
                img[y][x] = suelo
        for i, cual in enumerate(cuales):
            x0 = 6 + i * 40
            if isinstance(cual, int):
                _texto(img, x0 + 12, y0 + 52, "%2d" % cual, 1 if suelo == 15 else 15)
            if forma == "cuadro":
                spr = en_cuadro(poses[cual])
            elif forma == "nadando":
                spr = nadando(poses[10], *cual)
            elif forma == "mar":
                spr = bajo_el_mar(poses[cual])
            else:
                spr = en_el_espacio(poses[cual])
            if c_sombra is not None:
                spr += [(n, dy + 0x1E, dx, p, c) for n, dy, dx, p, c in sombra(c_sombra)]
            pinta_sprites(img, li, x0, y0 + 4, spr)
    return img


# ------------------------------------------------------------- los bichos
# Cada clase de objeto (p09:A8D1 monta, p09:A98A atiende) escoge su dibujo por
# la distancia (el byte alto de ix+6, ix+7): menos de 0x60 no se dibuja, y
# luego cuatro bandas -0x60, 0x78, 0x90 y 0xA8-, cada una con su tamano: en
# la lamina, de izquierda a derecha, del dibujo mas pequeno al mas grande. Con aleteo
# (p09:AA86) cada banda son dos dibujos que se turnan con el bit 2 del contador
# de cuadros; sin aleteo (p09:AAAD), uno. El dibujo es C + banda (x2 con
# aleteo), por cuatro. Y el color sale del segundo byte de la plantilla que
# copia la rutina de montar.
#   clase: (C, aleteo, plantilla de montar)
CLASES_POR_DISTANCIA = {
    1: (0x30, True, 0xB59C),
    6: (0x30, True, 0xB704),
    7: (0x2C, False, 0xB89F),
    9: (0x2C, False, None),
    10: (0x38, True, 0xBB05),
    12: (0x30, True, 0xBCEC),
}
# Las que no van por distancia: sus dibujos, tal como los escribe el codigo, y
# su color.
#   5   p09:B681 sale con 0xB0 y p09:B6DF le cambia a 0xB4, 0xB8 o 0xBC segun la
#       altura; color 0x0A (p09:B685).
#   11  p09:BC11 sale con 0xA4 y p09:BC6B alterna 0xA4 y 0xA8; color 0x0F.
#   13  p09:BD3A alterna 0xA4 y 0xA8; color 0x0A (su plantilla, 0xBD24).
#   14  0xBC y color 0x0A (su plantilla).
#   15  p09:BE83 alterna 0xA4 y 0xA8; color 0x0F (p09:BE52).
CLASES_FIJAS = {
    5: ((0xB0, 0xB4, 0xB8, 0xBC), 0x0A),
    11: ((0xA4, 0xA8), 0x0F),
    13: ((0xA4, 0xA8), 0x0A),
    14: ((0xBC,), 0x0A),
    15: ((0xA4, 0xA8), 0x0F),
}


# La clase 7 no usa el color de su plantilla (0x0E): p09:B8B3 le pone el 0
# -transparente, no se ve- salvo que se lleve 0xE16A, y entonces el 5.
COLOR_SI_SE_LLEVA_E16A = {7: 0x05}


def color_de_la_clase(cart, clase):
    if clase in COLOR_SI_SE_LLEVA_E16A:
        return COLOR_SI_SE_LLEVA_E16A[clase]
    if clase in CLASES_FIJAS:
        return CLASES_FIJAS[clase][1]
    plantilla = CLASES_POR_DISTANCIA[clase][2]
    if plantilla is None:
        return 0x0A
    return cart.leer(plantilla + 1, (7, 8, 9))


def dibujos_de_la_clase(clase):
    """Los patrones de la clase, banda a banda (0x60, 0x78, 0x90 y 0xA8); una
    columna por banda, y en cada columna el dibujo de cada paso."""
    if clase in CLASES_FIJAS:
        return [[p] for p in CLASES_FIJAS[clase][0]]
    c, aleteo, _ = CLASES_POR_DISTANCIA[clase]
    if aleteo:
        return [[(c + 2 * b) * 4, (c + 2 * b + 1) * 4] for b in range(4)]
    return [[(c + b) * 4] for b in range(4)]


FONDO_DE_BICHOS = 12   # verde oscuro: se ven encima el negro, el blanco y el resto


def lamina_de_bichos(cart):
    """Una fila por BICHO DISTINTO: la misma clase con los mismos dibujos y el
    mismo color es el mismo bicho aunque salga en muchas fases (el guion
    0x8A7E se carga en todas, p02:9689), asi que cada uno sale una vez y a su
    lado las fases en que su guion lo saca."""
    from graficos import enemigos_de_las_fases
    from sprites import carga_de_la_fase
    guiones = enemigos_de_las_fases(cart)
    bichos = {}                      # firma -> [clases, fases, lienzo]
    for f in range(1, 25):
        li = carga_de_la_fase(cart, f)
        for cl in sorted({c for c, _d in guiones[f - 1]} - {0}):
            pats = [p for banda in dibujos_de_la_clase(cl) for p in banda]
            firma = (tuple(bytes(li.v[SPRITES_PAT + p * 8:SPRITES_PAT + p * 8 + 32])
                           for p in pats),
                     color_de_la_clase(cart, cl),
                     tuple(len(b) for b in dibujos_de_la_clase(cl)))
            e = bichos.setdefault(firma, [set(), set(), li, cl])
            e[0].add(cl)
            e[1].add(f)
    filas = sorted(bichos.values(), key=lambda e: (min(e[1]), min(e[0])))
    alto_fila = 44
    ancho = 4 + 4 * 18 + 8 + 6 * 22
    img = [[FONDO_DE_BICHOS] * ancho for _ in range(alto_fila * len(filas))]
    for i, (clases, fases, li, cl) in enumerate(filas):
        y0 = i * alto_fila
        col = color_de_la_clase(cart, cl)
        x = 4
        for banda in dibujos_de_la_clase(cl):
            for k, p in enumerate(banda):
                pinta_sprites(img, li, x, y0 + 4 + k * 18, [(0, 0, 0, p, col)])
            x += 18
        x = 4 + 4 * 18 + 8
        _texto(img, x, y0 + 4, "CLASE " if False else " ".join("%d" % c for c in sorted(clases)), 1)
        fs = sorted(fases)
        for j in range(0, len(fs), 6):
            _texto(img, x, y0 + 14 + (j // 6) * 8, " ".join("%d" % q for q in fs[j:j + 6]), 15)
    return img


# ------------------------------------------------------------ el espacio
# En el bonus (modo 1) las cosas salen de las listas de 0x81F2 (banco 10) y son
# de dos clases:
#   0x15-0x19  de CARACTERES: los METEORITOS. Cinco trayectorias de dieciseis
#              dibujos (0x8682, como las cosas de la carretera) pintadas con los
#              caracteres del decorado 8, que crecen y se salen por los lados.
#   0x1A-0x1F  de SPRITE: los PECES CON ALAS, los que se cogen (p01:69D0). Tres
#              listas de dieciseis pasos de cuatro bytes -Y, X, patron y color-
#              (0xA545, 0xA585 y 0xA5C5, por 0xA539); las 0x1D-0x1F repiten
#              trayectoria pero su color salta entre 6 y 0x0A cuadro a cuadro
#              (p01:6A04): son las que dan una vida.
LISTAS_DE_SPRITE = 0xA539
# cada meteorito en un paso distinto, como pueden coincidir en pantalla (hay
# cinco ranuras): la 0x15 en el 11, la 0x16 en el 9...
METEORITOS = {0x15: 11, 0x16: 9, 0x17: 7, 0x18: 5, 0x19: 12}


def trayectorias(cart):
    b = (1, 10, 11)
    fuera = []
    for k in range(3):
        q = LISTAS_DE_SPRITE + 2 * k
        a = cart.leer(q, b) | (cart.leer(q + 1, b) << 8)
        fuera.append([tuple(cart.leer(a + 4 * i + j, b) for j in range(4))
                      for i in range(16)])
    return fuera


def lamina_del_espacio(cart):
    """La Tierra, los cinco meteoritos -cada uno en uno de sus pasos- y el
    pinguino."""
    from pantalla import monta_el_espacio, sube_el_mapa
    from vram import fondo
    b = (1, 10, 11)
    p = monta_el_espacio(cart)
    for t, paso in METEORITOS.items():
        q = 0x8682 + 2 * (t - 1)
        tabla = cart.leer(q, b) | (cart.leer(q + 1, b) << 8)
        a = tabla + 2 * paso
        p.copia_bloques(b, cart.leer(a, b) | (cart.leer(a + 1, b) << 8))
    sube_el_mapa(p)
    img = fondo(p.li.v)
    poses = poses_de_lo_que_se_maneja(cart)
    # el pinguino donde lo tiene un volcado del bonus (0xE204 = 0x51, 0xE205 =
    # 0x70): en el espacio se mueve arriba y abajo, no solo de lado
    pinta_sprites(img, p.li, 0x70, 0x52, en_el_espacio(poses[7]))
    return [fila[:] for fila in img[16:]]


def lamina_de_items(cart):
    """Los peces con alas del espacio, paso a paso: arriba en su color (9) y
    abajo en los dos de los que dan vida (6 y 0x0A)."""
    from sprites import carga_del_decorado, pinta_sin_color, TRIO
    li = Lienzo()
    pinta_sin_color(cart, TRIO, 0x7686, li)
    carga_del_decorado(cart, 8, li)
    pasos = trayectorias(cart)[0]
    img = [[FONDO_DE_BICHOS] * (4 + 16 * 18) for _ in range(3 * 20 + 4)]
    for i, (_y, _x, pt, co) in enumerate(pasos):
        pinta_sprites(img, li, 2 + i * 18, 2, [(0, 0, 0, pt, co)])
        pinta_sprites(img, li, 2 + i * 18, 22, [(0, 0, 0, pt, 0x06)])
        pinta_sprites(img, li, 2 + i * 18, 42, [(0, 0, 0, pt, 0x0A)])
    return img


# ------------------------------------------------------ el final de la fase
# Los cinco tamanos (cortes 0x20, 0x10, 5, 2 y 0 de p01:65CF) sobre la pantalla
# de la fase, recortados a la carretera. Una fila por decorado distinto: el
# color lo pone la tabla que escogen p00:5424/5498 (dinosaurio) o p00:529A/530A
# (meta) segun el decorado.
FILAS_DEL_DINOSAURIO = (3, 9, 6, 18)          # decorados 0, 1, 2 y 3
FILAS_DE_LA_META = (7, 8, 5, 1)               # decorados 0, 4, 7 y 3
RECORTE = (6 * 8, 7 * 8, 26 * 8, 21 * 8)      # columnas 6-25, filas 7-20


def lamina_del_final(cart, fases):
    from pantalla import monta_la_pantalla, final_de_fase, anima_el_fondo, sube_el_mapa
    from vram import fondo
    x0, y0, x1, y1 = RECORTE
    w, h = x1 - x0, y1 - y0
    img = [[1] * (5 * (w + 4)) for _ in range(len(fases) * (h + 4))]
    for i, fase in enumerate(fases):
        for j, corte in enumerate((0x20, 0x10, 0x05, 0x02, 0x00)):
            p = monta_la_pantalla(cart, fase, 1)
            final_de_fase(p, fase, corte)
            anima_el_fondo(p, p.ram[0xE0A1], 1)
            sube_el_mapa(p)
            pan = fondo(p.li.v)
            for y in range(h):
                for x in range(w):
                    img[i * (h + 4) + y][j * (w + 4) + x] = pan[y0 + y][x0 + x]
    return img


def main():
    cart = Cartucho()
    print(guarda_png(lamina_del_espacio(cart), os.path.join(IMAGENES, "espacio.png"), escala=2))
    print(guarda_png(lamina_de_items(cart), os.path.join(IMAGENES, "items.png"), escala=3))
    print(guarda_png(lamina_del_final(cart, FILAS_DEL_DINOSAURIO),
                     os.path.join(IMAGENES, "dinosaurio.png"), escala=2))
    print(guarda_png(lamina_del_final(cart, FILAS_DE_LA_META),
                     os.path.join(IMAGENES, "meta.png"), escala=2))
    for nombre, img, escala in (("jugador.png", lamina_del_jugador(cart), 3),
                                ("bichos.png", lamina_de_bichos(cart), 3)):
        print(guarda_png(img, os.path.join(IMAGENES, nombre), escala=escala))


if __name__ == "__main__":
    main()
