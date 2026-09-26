#!/usr/bin/env python3
"""Los sprites de una fase, cargados como los carga el cartucho.

Lo que hay en la tabla de patrones de sprite (0x1800-0x1FFF) mientras se juega
lo ponen tres cosas, por este orden, desde el montaje de p02:817C:

  p00:5127  solo con el decorado 8 (el espacio): el guion 0x7686.
  p00:57FB  segun el DECORADO (0xE0A1): el jugador y lo comun. Aqui entra el
            OTRO pintor, `pinta_bloque` (p00:43B3), que no esta comprimido y
            sube columnas de dieciseis bytes; con el bit 0 de C cada columna
            sale dos veces, la segunda espejada. De ahi salen los patrones
            0x00-0x14 del jugador, que no los carga ningun guion comprimido.
  p02:9689  segun la FASE: el guion 0x8A7E (p00:5B1F) siempre, y luego lo que
            diga el despacho de 24 de p02:9693 -los bichos de esa fase-.

Uso:  sprites.py <fase> [volcado.vram]    compara con un volcado de openMSX
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import Cartucho, Lienzo, SPRITES_PAT, da_la_vuelta, pinta  # noqa: E402

TRIO = (7, 8, 9)


def _palabra(cart, bancos, a):
    return cart.leer(a, bancos) | (cart.leer(a + 1, bancos) << 8)


def pinta_bloque(cart, bancos, de, lienzo, b, c):
    """p00:43B3. Devuelve DE como lo deja la rutina: detras del bloque.

    Sin espejo, cada columna son 16 bytes y sale una figura simetrica: la
    mitad izquierda tal cual y la derecha, la misma dada la vuelta. Con
    espejo (bit 0 de C) cada columna son 32 bytes y salen DOS figuras: la de
    la ROM y su espejo, con las mitades cambiadas y cada byte del reves.
    """
    dest = _palabra(cart, bancos, de)
    de += 2

    def columna(origen, espejo):
        nonlocal dest
        for k in range(16):
            v = cart.leer(origen + k, bancos)
            lienzo.escribe(dest, da_la_vuelta(v) if espejo else v)
            dest += 1

    for _ in range(b):
        columna(de, False)
        if c & 1:
            columna(de + 16, False)
            columna(de + 16, True)
        columna(de, True)
        de += 32 if c & 1 else 16
    return de


def pinta_sin_color(cart, bancos, de, lienzo):
    """p00:4381: el destino lo trae el guion. Devuelve DE en el 0x00 final."""
    return pinta(cart, bancos, de, lienzo) - 1


# p13:ACBA, cuatro bytes por fase: el nibble alto del segundo es el decorado
# (p01:6226 lo baja a 0xE0A1) y los doce bits de abajo, el tiempo (p00:47C4).
DATOS_DE_FASE = 0xACBA


def decorado_de(cart, fase):
    return cart.leer(DATOS_DE_FASE + (fase - 1) * 4 + 1, (1, 12, 13)) >> 4


def carga_del_decorado(cart, d, li):
    """p00:57FB."""
    if d in (7, 8):
        de = pinta_bloque(cart, TRIO, 0x79C7, li, 2, 0)
        de = pinta_bloque(cart, TRIO, de, li, 1, 1)
        pinta_sin_color(cart, TRIO, de, li)
    else:
        de = 0x8600 if d in (2, 3, 6) else 0x78F1
        de = pinta_bloque(cart, TRIO, de, li, 3, 1)
        pinta_sin_color(cart, TRIO, de, li)
        if d in (4, 5):
            pinta_bloque(cart, TRIO, 0x7AF2, li, 2, 1)
    de = pinta_bloque(cart, TRIO, 0x7B34, li, 8, 0)
    de = pinta_bloque(cart, TRIO, de, li, 3, 1)
    pinta_sin_color(cart, TRIO, de, li)
    if d in (2, 3, 6):
        pinta_bloque(cart, TRIO, 0x86D3, li, 1, 1)


# p02:9693: a que rutina salta cada fase, y que guiones pinta cada una.
DESPACHO_POR_FASE = 0x9693
RUTINAS_DE_BICHOS = {
    0x96C3: (),
    0x96C4: (0x888D, 0x88E8),
    0x96C9: (0x8757, 0x888D, 0x89B8),
    0x96D2: (0x86F5, 0x87B8, 0x88E8),
    0x96D7: (0x8B3A, 0x87B8, 0x88E8),
    0x96DF: (0x86F5, 0x888D),
    0x96E5: (0x882E, 0x89B8),
    0x96EB: (0x8B3A, 0x882E, 0x88E8),
    0x96F0: (0x86F5, 0x882E, 0x88E8),
}


def guiones_de_la_fase(cart, fase):
    r = _palabra(cart, (1, 2, 3), DESPACHO_POR_FASE + 2 * (fase - 1))
    return (0x8A7E,) + RUTINAS_DE_BICHOS[r]


def carga_de_la_fase(cart, fase, li=None):
    """Los patrones de sprite tal como quedan al montar la fase."""
    li = li or Lienzo()
    d = decorado_de(cart, fase)
    if d == 8:
        pinta_sin_color(cart, TRIO, 0x7686, li)
    carga_del_decorado(cart, d, li)
    for g in guiones_de_la_fase(cart, fase):
        pinta_sin_color(cart, TRIO, g, li)
    return li


def compara(li, v, ini=SPRITES_PAT, fin=0x2000):
    """(tocados, distintos, lista de los primeros distintos)."""
    toc = dis = 0
    malos = []
    for a in range(ini, fin):
        if li.tocado[a]:
            toc += 1
            if li.v[a] != v[a]:
                dis += 1
                if len(malos) < 8:
                    malos.append((a, li.v[a], v[a]))
    return toc, dis, malos


def main():
    cart = Cartucho()
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    fase = int(sys.argv[1])
    li = carga_de_la_fase(cart, fase)
    print("fase %d, decorado %d, guiones %s" % (
        fase, decorado_de(cart, fase),
        " ".join("%04X" % g for g in guiones_de_la_fase(cart, fase))))
    if len(sys.argv) > 2:
        with open(sys.argv[2], "rb") as f:
            v = f.read()
        toc, dis, malos = compara(li, v)
        print("tocados %d  distintos %d  %s" % (toc, dis, " ".join(
            "%04X:%02X/%02X" % m for m in malos)))
        sin = [a for a in range(SPRITES_PAT, 0x2000) if not li.tocado[a] and v[a]]
        print("bytes no nulos del volcado que no pone la carga: %d" % len(sin))


if __name__ == "__main__":
    main()
