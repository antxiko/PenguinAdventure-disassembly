#!/usr/bin/env python3
"""Lo que el VDP sacaria por pantalla con una VRAM dada: modo 2 y sprites.

Sirve para mirar los volcados de openMSX (tools/omsx_fases.tcl) y para
cotejar contra ellos lo que se dibuja desde las tablas. El mapa de la VRAM es
el de este cartucho (p00:44AE, ver tools/graficos.py): colores en 0x0000,
patrones de sprite en 0x1800, patrones en 0x2000, nombres en 0x3800 y
atributos de sprite en 0x3B00. Sprites de 16x16 sin ampliar (R1 = 0xE2).

El VDP pinta como mucho CUATRO sprites por linea: el quinto y los siguientes,
por orden de tabla, no salen. Y una Y de 0xD0 corta la tabla ahi mismo.

Uso:  vram.py <volcado.vram> [salida.png]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (COLORES, NOMBRES, PATRONES, SPRITES_ATR,  # noqa: E402
                      SPRITES_PAT, guarda_png)


def fondo(v, borde=0):
    """Los 256x192 del modo 2, sin sprites. El color 0 deja ver el borde."""
    img = [[borde] * 256 for _ in range(192)]
    for fila in range(24):
        for col in range(32):
            idx = v[NOMBRES + fila * 32 + col]
            base = (fila // 8) * 0x800 + idx * 8
            for y in range(8):
                pat = v[PATRONES + base + y]
                c8 = v[COLORES + base + y]
                tinta, papel = c8 >> 4, c8 & 0x0F
                fy = fila * 8 + y
                for x in range(8):
                    c = tinta if (pat >> (7 - x)) & 1 else papel
                    if c:
                        img[fy][col * 8 + x] = c
    return img


def sprites_de(v, atr=SPRITES_ATR):
    """Los 32 sprites de la tabla, hasta el primer 0xD0: (n, y, x, patron, color)."""
    fuera = []
    for n in range(32):
        y, x, p, c = v[atr + 4 * n: atr + 4 * n + 4]
        if y == 0xD0:
            break
        fy = y + 1 if y < 0xE0 else y - 255
        fx = x - 32 if c & 0x80 else x
        fuera.append((n, fy, fx, p & 0xFC, c & 0x0F))
    return fuera


def pon_sprites(img, v, lista=None, limite=True):
    """Encima del fondo, con el limite de cuatro por linea si se pide."""
    lista = sprites_de(v) if lista is None else lista
    alto = len(img)
    por_linea = [0] * alto
    # el de numero MAS BAJO queda encima: se pinta del ultimo al primero, pero
    # el limite de cuatro se cuenta en orden de tabla
    visibles = []
    for n, fy, fx, p, c in lista:
        filas = []
        for y in range(16):
            ly = fy + y
            if 0 <= ly < alto:
                if limite and por_linea[ly] >= 4:
                    continue
                por_linea[ly] += 1
                filas.append(y)
        visibles.append((n, fy, fx, p, c, filas))
    for n, fy, fx, p, c, filas in reversed(visibles):
        if not c:
            continue
        base = SPRITES_PAT + p * 8
        for y in filas:
            izq, der = v[base + y], v[base + 16 + y]
            fila = img[fy + y]
            for x in range(16):
                b = izq if x < 8 else der
                if (b >> (7 - (x & 7))) & 1:
                    px = fx + x
                    if 0 <= px < 256:
                        fila[px] = c
    return img


def pantalla(v, borde=0, limite=True):
    return pon_sprites(fondo(v, borde), v, limite=limite)


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    with open(sys.argv[1], "rb") as f:
        v = f.read()
    sal = sys.argv[2] if len(sys.argv) > 2 else os.path.splitext(sys.argv[1])[0] + ".png"
    guarda_png(pantalla(v), sal, escala=2)
    print(sal)


if __name__ == "__main__":
    main()
