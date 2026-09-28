#!/usr/bin/env python3
"""El mapa de antes de cada fase (estado 4), montado desde las tablas.

  p02:81A0  el estado 4.0: p00:481B carga los caracteres del mapa (banco 6:
            0xA77A y 0xAABB en el tercio de en medio, 0xABA5 y 0xAF15 en el
            de abajo, sus colores 0xAADB, 0xAB93, 0xAF34 y 0xB003) y los
            sprites del pinguino (p00:43B3 con 0xB006); p02:9409 y 93FB
            pintan STAGE y LIVES (0x8DC1) con la fase (0xE091, BCD) y las
            vidas (0xE090).
  p02:8AEC  el guion de la escena, un paso por cuadro (0xE0B5):
    paso 5  las catorce lineas de 26 caracteres de 0x8E7C, desde la fila 9
            columna 3 (0x3923).
    paso 2  el guion de 0x8FE7, registros de cuatro bytes: una fase, una
            entrada y una direccion de la tabla de colores. Mientras la fase
            del registro no sea la de ahora, los ocho bytes de esa direccion
            con tinta 1 (negro) pasan a 9 (rojo): el camino andado.
    paso 1  la entrada, si no es cero, es uno de los seis ATAJOS (0x8D85,
            siete bytes: cuenta, texto, guion y bandera 0xE0C6-0xE0CB). Si
            su bandera esta puesta, el guion salta al de la entrada -el que
            se salta las fases del atajo- y el paso 4 escribe su texto: la
            cuenta de parejas direccion-caracter que dibujan el atajo.
    paso 3  y al llegar a la fase de ahora, el pinguino: la columna y la
            fila de 0x917B (por fase) mas las de su juego de sprites (0x8D09,
            el primero de la primera pareja). De la fase 15 en adelante mira
            al otro lado (0xE139): la columna, restada, y el dibujo, cuatro
            mas alla.

Uso:  mapa.py           dibuja docs/imagenes/mapa.png
      mapa.py coteja    lo coteja con los volcados de tools/lanza_mapas.sh
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, IMAGENES, guarda_png, pinta_con_mascara,  # noqa: E402
                      _texto)
from pantalla import Pantalla, lo_que_se_hereda  # noqa: E402
from sprites import pinta_bloque  # noqa: E402

B456 = (4, 5, 6)
B123 = (1, 2, 3)
LINEAS = 0x8E7C
PRIMERA_LINEA = 0x3923
GUION_DEL_CAMINO = 0x8FE7
ATAJOS = 0x8D85
POSICIONES = 0x917B
JUEGO_DEL_PINGUINO = 0x8D09
ROTULOS = 0x8DC1


def _p(cart, a, b=B123):
    return cart.leer(a, b) | (cart.leer(a + 1, b) << 8)


def monta_el_mapa(cart, fase, atajos=0, vidas=2):
    """La pantalla del mapa de la fase `fase` con los atajos del bitmask."""
    p = Pantalla(cart)
    lo_que_se_hereda(p)
    # p00:481B
    p.pinta(B456, 0xA77A)
    p.pinta(B456, 0xAABB, 0x2E70, 1)
    p.pinta(B456, 0xABA5)
    p.pinta(B456, 0xAF15, 0x3680, 1)
    p.pinta(B456, 0xAADB)
    p.pinta(B456, 0xAB93, 0x0E70, 0)
    p.pinta(B456, 0xAF34)
    p.pinta(B456, 0xB003, 0x1680, 0)
    pinta_bloque(cart, B456, 0xB006, p.li, 6, 1)
    # p02:9409 y 93FB
    pinta_con_mascara(cart, B123, ROTULOS, p.li)
    bcd = (fase // 10) * 16 + fase % 10
    for dest, v in ((0x3891, bcd), (0x38B1, vidas)):
        p.li.escribe(dest, 0x10 + (v >> 4))
        p.li.escribe(dest + 1, 0x10 + (v & 15))
    # paso 5: las catorce lineas
    for i in range(14):
        for k in range(26):
            p.li.escribe(PRIMERA_LINEA + 32 * i + k, cart.leer(LINEAS + 26 * i + k, B123))
    # pasos 2 y 1: el camino y los atajos
    g = GUION_DEL_CAMINO
    while True:
        g += 1
        if cart.leer(g, B123) == fase:
            break
        g += 1
        e = cart.leer(g, B123)
        if 1 <= e <= 6 and atajos >> (e - 1) & 1:
            q = ATAJOS + 7 * (e - 1)
            cuenta, texto, g = cart.leer(q, B123), _p(cart, q + 1), _p(cart, q + 3)
            for k in range(cuenta):
                p.li.escribe(_p(cart, texto + 3 * k), cart.leer(texto + 3 * k + 2, B123))
            continue
        g += 1
        dest = _p(cart, g)
        g += 1
        for k in range(8):
            v = p.li.v[dest + k]
            p.li.escribe(dest + k, (0x90 | v) if v & 0xF0 == 0x10 else v)
    # paso 3: el pinguino
    x0 = cart.leer(POSICIONES + 2 * (fase - 1), B123)
    y0 = cart.leer(POSICIONES + 2 * (fase - 1) + 1, B123)
    al_reves = fase - 1 >= 0x0E
    n = cart.leer(JUEGO_DEL_PINGUINO, B123)
    sprites = []
    for k in range(n):
        dx, dy, pt, co = (cart.leer(JUEGO_DEL_PINGUINO + 1 + 4 * k + i, B123) for i in range(4))
        if al_reves:
            dx = -dx if dx < 0x80 else 0x100 - dx
        x = (x0 + dx) & 0xFF
        y = (y0 + dy) & 0xFF
        sprites.append((k, y, x, (pt + 4) & 0xFF if al_reves else pt, co))
    return p, sprites


def _foto(p, sprites):
    from vram import fondo
    from figuras import pinta_sprites
    img = fondo(p.li.v)
    pinta_sprites(img, p.li, 0, 1, list(sprites))
    return [fila[:] for fila in img[3 * 8:]]


LAMINA = ((1, 0), (13, 0), (24, 0), (7, 1), (16, 15), (24, 63))


def lamina_del_mapa(cart):
    fotos = [_foto(*monta_el_mapa(cart, f, a)) for f, a in LAMINA]
    w, h, hueco = 256, len(fotos[0]), 6
    img = [[1] * (3 * w + 2 * hueco) for _ in range(2 * h + hueco)]
    for i, foto in enumerate(fotos):
        x0, y0 = (i % 3) * (w + hueco), (i // 3) * (h + hueco)
        for y in range(h):
            img[y0 + y][x0:x0 + w] = foto[y]
    return img


def coteja(cart):
    """Los volcados de tools/lanza_mapas.sh (work/mapas): las celdas y los
    patrones y colores que pone el mapa, y los sprites del pinguino, cuando el
    guion ya esta en el paso 3."""
    import glob
    from graficos import SPRITES_ATR
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    vistos = malos = con_sprites = 0
    for ruta in sorted(glob.glob(os.path.join(raiz, "work", "mapas", "mapa_f*_a*.vram"))):
        base = os.path.basename(ruta)
        fase, atajos = int(base[6:8]), int(base[10:12])
        with open(ruta, "rb") as f:
            v = f.read()
        with open(ruta[:-5] + ".ram", "rb") as f:
            r = f.read()
        p, sprites = monta_el_mapa(cart, fase, atajos, r[0x090])
        dis = [a for a in range(0x4000) if p.li.tocado[a] and p.li.v[a] != v[a]
               and not SPRITES_ATR <= a < SPRITES_ATR + 0x80]
        spr = 0
        if r[0x143] == 0 and not r[0x141] & 0x10:      # el primer juego de la primera pareja
            spr = sum(1 for n, y, x, pt, co in sprites
                      if tuple(v[SPRITES_ATR + 4 * n:SPRITES_ATR + 4 * n + 4]) != (y, x, pt, co))
            con_sprites += 1
        else:
            spr = -1
        vistos += 1
        if dis or spr > 0:
            malos += 1
            print("  %s: %d bytes distintos %s, sprites %d" % (
                base, len(dis), " ".join("%04X" % a for a in dis[:6]), spr))
    print("mapa: %d volcados, %d con diferencias (%d con los sprites del pinguino)"
          % (vistos, malos, con_sprites))
    return vistos > 0 and malos == 0 and con_sprites > 0


def main():
    cart = Cartucho()
    if sys.argv[1:] == ["coteja"]:
        sys.exit(0 if coteja(cart) else 1)
    print(guarda_png(lamina_del_mapa(cart), os.path.join(IMAGENES, "mapa.png"), escala=2))


if __name__ == "__main__":
    main()
