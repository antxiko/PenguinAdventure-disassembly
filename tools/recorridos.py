#!/usr/bin/env python3
"""El recorrido de cada fase, dibujado desde sus tablas.

Una fila por fase y, en cada fila, ocho vistas de la carretera repartidas
entre la salida y la meta. Cada vista la monta tools/carretera.py andando la
fase paso a paso: el decorado, la animacion del suelo y la de las curvas del
segundo guion, las cosas del guion del terreno en el dibujo que tengan a esa
distancia y, al final, la meta o el dinosaurio. Debajo de cada vista, los
bichos que el guion de 0xA8FB suelta desde la vista anterior, con el mayor de
sus cuatro dibujos y su color (tools/figuras.py).

Lo que NO sale, dicho: lo que pasa por los lados (p01:6AA8 va por cuadros, no
por distancia), los bichos en movimiento (su recorrido depende del registro
R) y, en las cosas que apuntan al jugador, la otra variante: aqui el jugador
va por el centro.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import Cartucho, IMAGENES, guarda_png, _texto  # noqa: E402
from carretera import Carretera, bcd_a_int  # noqa: E402
from figuras import (pinta_sprites, color_de_la_clase,  # noqa: E402
                     dibujos_de_la_clase, CLASES_POR_DISTANCIA, CLASES_FIJAS)
from sprites import carga_de_la_fase  # noqa: E402
from vram import fondo  # noqa: E402

VISTAS = 8
FILA_0, FILA_1 = 3 * 8, 24 * 8          # la zona de juego: filas 3 a 23


def a_bcd(n):
    return int(str(n), 16)


def distancias(largo):
    """Las ocho: repartidas de la salida a la meta, la ultima en la meta."""
    n = bcd_a_int(largo)
    return [a_bcd(n * (VISTAS - 1 - i) // VISTAS) for i in range(VISTAS)]


def recorrido(cart, fase, nivel):
    k = Carretera(cart, fase, nivel)
    vistas = []
    antes = 0
    for q in distancias(k.largo):
        k.anda_hasta(q)
        img = fondo(k.p.li.v)
        bichos = [c for _q, c in k.bichos[antes:]]
        antes = len(k.bichos)
        vistas.append(([fila[:] for fila in img[FILA_0:FILA_1]], bichos))
    return vistas


def lamina_de_recorridos(cart, nivel):
    ancho_vista, alto_vista = 256, FILA_1 - FILA_0
    esc = 2                                        # a la mitad
    w, h = ancho_vista // esc, alto_vista // esc
    alto_fila = h + 22
    ancho = 20 + VISTAS * (w + 4)
    img = [[1] * ancho for _ in range(24 * alto_fila)]
    for fase in range(1, 25):
        y0 = (fase - 1) * alto_fila
        _texto(img, 2, y0 + h // 2, "%2d" % fase, 15)
        li = carga_de_la_fase(cart, fase)
        for i, (vista, bichos) in enumerate(recorrido(cart, fase, nivel)):
            x0 = 20 + i * (w + 4)
            for y in range(h):
                for x in range(w):
                    img[y0 + y][x0 + x] = vista[y * esc][x * esc]
            for j, clase in enumerate(sorted(set(bichos))[:7]):
                if clase in CLASES_POR_DISTANCIA or clase in CLASES_FIJAS:
                    p = dibujos_de_la_clase(clase)[-1][0]      # el mas grande
                    pinta_sprites(img, li, x0 + j * 18, y0 + h + 3,
                                  [(0, 0, 0, p, color_de_la_clase(cart, clase))])
    return img


def main():
    cart = Cartucho()
    for nivel in (0, 1):
        print(guarda_png(lamina_de_recorridos(cart, nivel),
                         os.path.join(IMAGENES, "recorridos_level_%d.png" % (nivel + 1)),
                         escala=1))


if __name__ == "__main__":
    main()
