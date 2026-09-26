#!/usr/bin/env python3
"""La pelea con el dinosaurio (estado 7), montada desde las tablas.

Al acabar una fase cuyo 1-2-3 vale 3, el dinosaurio que se acercaba (el corte
0 de p01:65CF, tools/pantalla.py) se queda en la carretera y empieza la pelea.
Los subestados de p02:83A9, en el orden en que corren:

  7.0  p02:84B5  el pinguino de negro (color 1 en los sprites 0 a 3), el
                 blanco a cero (p03:AE0F: los ocho bytes de 0xAE1B a 0xE530),
                 los cuatro bloques (p03:AE23: 0xAE3A a 0xE550 y 0xAE5A a los
                 sprites 10-13) y los patrones de 0x823A del banco 8 en los
                 sprites 0xA0-0xB7 (p00:57C2).
  7.1  p02:83AB  espera a que el pinguino llegue a su sitio (0xE203 = 0x0C).
  7.2  p02:83C2  CAEN LOS BLOQUES: p03:B12B los baja de tres en tres, cada uno
                 tras su freno (el cuarto byte del registro: 0x41, 1, 0x21 y
                 0x61), hasta la fila 0xA0; alli pasan al tipo 2 y p01:7CF8
                 los pinta en el espejo con la tira 0 de 0xAD62, cada uno en
                 su base de 0x7D6C.
  7.3  p02:83E6  LA PELEA. El blanco va por cinco columnas (0x7CEE, la base en
                 el espejo; 0xAF4B, su X) y p01:7C01 lo pinta cada cuadro con
                 uno de los nueve dibujos de 0xA842: tres pasos (0xE531: 0
                 quieto, 1 y 2 andando) por tres lados (0xE532: 0 si el
                 pinguino esta enfrente, 1 a la izquierda, 2 a la derecha).
                 Lo que lanza (p03:B184) sale de la fila 0x7C, parpadea con
                 0xA4 y 0xA8, apunta con uno de los tres pasos de su lado
                 (0xB212) y baja en tres tramos, 0xAC, 0xB0 y 0xB4; en el
                 ultimo, si da al pinguino, se pierde la vida (p01:76F3).
                 VEINTE aciertos (p01:7799): los bloques pasan al tipo 5 (la
                 tira 3 de 0xAD62) y 0xE530 a 2.
  7.4  p02:8445  EL HIELO SE ROMPE. Con 0xE530 = 2, p01:7D74 hace una de las
                 cuarenta escrituras de 0xAE0A cada dos cuadros -la grieta-
                 mientras el blanco se queda en su dibujo 0. Con 3, el borde
                 parpadea y p03:AFD4 cambia los caracteres 0xB3 y 0xD0 del
                 tercio de en medio (las burbujas; los colores, por decorado).
                 p01:7C3E pinta el agujero (el guion comprimido 0xADA2) y
                 encima el blanco con la tira de 0xAB60 que diga 0xE531. Con
                 4, cada ocho cuadros la base baja una fila y 0xE531 sube uno:
                 el blanco se hunde, y a los diez se acabo.

Uso:  pelea.py            dibuja docs/imagenes/pelea.png
      pelea.py coteja     la coteja con los volcados de tools/lanza_pelea.sh
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, IMAGENES, guarda_png, descomprime,  # noqa: E402
                      poses_de_lo_que_se_maneja, _texto)
from pantalla import monta_la_pantalla, final_de_fase, sube_el_mapa  # noqa: E402
from sprites import pinta_sin_color, TRIO  # noqa: E402

B = (1, 10, 11)
COLUMNAS = 0x7CEE          # p01:7C18, la base del blanco en el espejo
X_DE_LAS_COLUMNAS = 0xAF4B  # p03:AE9F, la X del blanco (0xE536)
DIBUJOS = 0xA842           # p01:7C32, (0xE531) * 6 + (0xE532) * 2
BASES_DE_LOS_BLOQUES = 0x7D6C  # p01:7D1C, con B - 1 (el registro 0 va con B = 4)
TIRAS_DE_LOS_BLOQUES = 0xAD62  # p01:7D28, con el tipo menos 2
REGISTROS_DE_LOS_BLOQUES = 0xAE3A  # banco 3, cuatro de ocho bytes
GRIETA = 0xAE0A            # p01:7D74, cuarenta escrituras de tres bytes
AGUJERO = 0xADA2           # p01:7C5F
HUNDIMIENTO = 0xAB60       # p01:7C6A, con (0xE531) * 2
PASOS_DE_LO_QUE_LANZA = 0xB212  # p03:B1D0, doce bytes por lado
DESVIO_AL_APARECER = (-6, -28, 16)   # p03:B19D, por lado
BURBUJAS = {               # p03:AFD4: (patrones, colores decorado < 2, colores >= 2)
    1: ((0xB0CB, 0xB0D3), (0xB10B, 0xB113), (0xB0EB, 0xB0F3)),
    0: ((0xB0DB, 0xB0E3), (0xB11B, 0xB123), (0xB0FB, 0xB103)),
}
DESTINO_DE_LAS_BURBUJAS = ((0x2D98, 0x0D98), (0x2E80, 0x0E80))
SPRITES_DE_LA_PELEA = 0x823A    # p00:57DB, banco 8


def palabra(cart, a, bancos=B):
    return cart.leer(a, bancos) | (cart.leer(a + 1, bancos) << 8)


def tira(p, hl, de, tocadas=None, con_unos=False):
    """p01:7C74: un byte que se suma a DE, bytes que se copian, 0xFE otro
    salto y 0xFF se acabo. Con unos es p01:7CD7: las mismas celdas, con el
    caracter 1."""
    cart = p.cart
    while True:
        de = (de + cart.leer(hl, B)) & 0xFFFF
        hl += 1
        while True:
            v = cart.leer(hl, B)
            if v == 0xFF:
                return
            if v == 0xFE:
                hl += 1
                break
            p.ram[de] = 1 if con_unos else v
            if tocadas is not None:
                tocadas.add(de)
            de += 1
            hl += 1


def tira_larga(p, hl, de, tocadas=None):
    """p01:7D35: igual, pero el salto es de dieciseis bits."""
    cart = p.cart
    while True:
        de = (de + palabra(cart, hl)) & 0xFFFF
        hl += 2
        while True:
            v = cart.leer(hl, B)
            if v == 0xFF:
                return
            if v == 0xFE:
                hl += 1
                break
            p.ram[de] = v
            if tocadas is not None:
                tocadas.add(de)
            de += 1
            hl += 1


def base_del_blanco(cart, columna):
    return palabra(cart, COLUMNAS + 2 * columna)


def x_del_blanco(cart, columna):
    return cart.leer(X_DE_LAS_COLUMNAS + columna, (1, 2, 3))


def pinta_el_blanco(p, columna, paso, lado, tocadas=None):
    """p01:7C01."""
    t = palabra(p.cart, DIBUJOS + 6 * paso + 2 * lado)
    tira(p, t, base_del_blanco(p.cart, columna), tocadas)


def borra_el_blanco(p, columna, paso, lado):
    """p01:7C9F: el dibujo de antes, con el caracter 1 (la carretera)."""
    t = palabra(p.cart, DIBUJOS + 6 * paso + 2 * lado)
    tira(p, t, base_del_blanco(p.cart, columna), con_unos=True)


def anda_el_blanco(p, estados):
    """Cuadro a cuadro, como p02:83E6: p01:7C9F borra el dibujo de antes y
    p01:7C01 pinta el nuevo. El primero borra el del arranque (columna 2,
    paso 0, lado 0: los ocho bytes de 0xAE1B)."""
    antes = (COLUMNA_DEL_CENTRO, 0, 0)
    for e in estados:
        borra_el_blanco(p, *antes)
        pinta_el_blanco(p, *e)
        antes = e


def pinta_los_bloques(p, tipos, tocadas=None):
    """p01:7CF8, los registros de tipo 2 en adelante (el 1 es un sprite)."""
    for k, t in enumerate(tipos):
        if t >= 2:
            base = palabra(p.cart, BASES_DE_LOS_BLOQUES + 2 * (3 - k))
            tira_larga(p, palabra(p.cart, TIRAS_DE_LOS_BLOQUES + 2 * (t - 2)), base, tocadas)


def pinta_la_grieta(p, n, tocadas=None):
    """p01:7D74, las n primeras escrituras de 0xAE0A."""
    for i in range(n):
        a = GRIETA + 3 * i
        v = p.cart.leer(a + 2, B)
        if v == 0xFF:
            return
        d = palabra(p.cart, a)
        p.ram[d] = v
        if tocadas is not None:
            tocadas.add(d)


def pinta_el_agujero(p, columna, paso, tocadas=None):
    """p01:7C3E con 0xE530 >= 3: el agujero y el blanco, que baja una fila
    por paso (p03:B0AF le suma 0x20 a la base)."""
    ram = bytearray(p.ram)
    tramos = descomprime(p.cart, B, AGUJERO, p.ram)
    if tocadas is not None:
        for ini, fin in tramos:
            tocadas.update(range(ini, fin))
    del ram
    t = palabra(p.cart, HUNDIMIENTO + 2 * paso)
    base = base_del_blanco(p.cart, columna) + 0x20 * paso
    tira(p, t, base, tocadas)
    return base


def pinta_las_burbujas(p, bit4):
    """p03:AFD4: los caracteres 0xB3 y 0xD0 del tercio de en medio."""
    pats, col_bajo, col_alto = BURBUJAS[bit4]
    cols = col_alto if p.ram[0xE0A1] >= 2 else col_bajo
    for (dp, dc), a, c in zip(DESTINO_DE_LAS_BURBUJAS, pats, cols):
        for i in range(8):
            p.li.escribe(dp + i, p.cart.leer(a + i, (1, 2, 3)))
            p.li.escribe(dc + i, p.cart.leer(c + i, (1, 2, 3)))


def el_escenario(cart, fase):
    """La pantalla con el dinosaurio ya encima (el corte 0) y los sprites de
    la pelea cargados."""
    p = monta_la_pantalla(cart, fase, 1)
    final_de_fase(p, fase, 0)
    pinta_sin_color(cart, TRIO, SPRITES_DE_LA_PELEA, p.li)
    return p


def el_hielo_roto(p):
    """p00:5561, al vigesimo acierto: los caracteres de la grieta y del
    agujero (tercio de en medio, 0x8D-0x9E; el de abajo, 0x57-0x5E) y sus
    colores, con la tabla de cambio de 0x982E en los decorados 0 y 1 y la de
    0x96F6 en los demas."""
    p.pinta(TRIO, 0x91A3)
    p.pinta(TRIO, 0x91BA, 0x2CC0, 1)
    p.pinta(TRIO, 0x9209)
    p.pinta(TRIO, 0x920B, 0x32D8, 1)
    p.tabla_de_color(TRIO, 0x982E if p.ram[0xE0A1] < 2 else 0x96F6)
    for de, dest in ((0x91EE, 0x0C68), (0x91FC, 0x0CC0), (0x9226, 0x12B8), (0x9226, 0x12D8)):
        p.pinta(TRIO, de, dest, 0x80)


def registros_de_los_bloques(cart):
    """(tipo, fila, columna, freno) de cada uno, como los deja p03:AE23."""
    fuera = []
    for k in range(4):
        a = REGISTROS_DE_LOS_BLOQUES + 8 * k
        fuera.append(tuple(cart.leer(a + i, (1, 2, 3)) for i in range(4)))
    return fuera


def el_bloque_a_los(freno, cuadros):
    """p03:B12B: (tipo, fila) tras tantos cuadros de caida. Parado en la fila
    0xFF mientras dura el freno, y luego tres filas por cuadro; al pasar de
    la 0xA0 se posa (el tipo 2)."""
    n = max(0, cuadros - freno)
    for k in range(1, n + 1):
        if (0xFF + 3 * k) & 0xFF >= 0xA0 and k > 1:
            return 2, None
    return 1, (0xFF + 3 * n) & 0xFF


def pasos_de_lo_que_lanza(cart, lado, hacia):
    """p03:B1C8: los cuatro bytes del paso (fila y columna, 8.8). hacia: 0
    a un lado, 1 recto, 2 al otro."""
    a = PASOS_DE_LO_QUE_LANZA + 12 * lado + 4 * hacia
    return [cart.leer(a + i, (1, 2, 3)) for i in range(4)]


def vuelo(cart, columna, lado, hacia):
    """La bajada de lo que lanza, cuadro a cuadro (p03:B236, B260, B28A):
    [(fila, columna, dibujo)] hasta la fila 0xA8 o hasta salirse."""
    dy_lo, dy_hi, dx_lo, dx_hi = pasos_de_lo_que_lanza(cart, lado, hacia)
    dy = dy_lo | (dy_hi << 8)
    dx = dx_lo | (dx_hi << 8)
    y = 0x7C00
    x = ((x_del_blanco(cart, columna) + DESVIO_AL_APARECER[lado]) & 0xFF) << 8
    tiempo, dibujo = 2, 0xAC
    fuera = []
    while True:
        y = (y + dy) & 0xFFFF
        x = (x + dx) & 0xFFFF
        if tiempo == 2 and (y >> 8) >= 0x88:
            tiempo, dibujo = 3, 0xB0
        elif tiempo == 3 and (y >> 8) >= 0x90:
            tiempo, dibujo = 4, 0xB4
        elif tiempo == 4:
            if not 0x10 <= (x >> 8) < 0xE0 or (y >> 8) >= 0xA8:
                return fuera
        fuera.append((y >> 8, x >> 8, dibujo))


# ------------------------------------------------------------ la lamina
RECORTE_Y = (7 * 8, 24 * 8)       # de la fila 7 a la 23: la carretera entera
FASE_DE_LA_LAMINA = 3
COLUMNA_DEL_CENTRO = 2
Y_DEL_PINGUINO, X_DEL_PINGUINO = 0x92, 0x7A   # donde lo dejan los volcados
# a la columna 1 y de vuelta al dibujo 1: la carretera queda como en el
# volcado f03_n0_pelea_a0252 (el cotejo lo comprueba celda a celda)
ANDADAS_DE_LA_LAMINA = ((COLUMNA_DEL_CENTRO, 0, 1), (COLUMNA_DEL_CENTRO, 1, 1), (1, 2, 1), (1, 1, 1))
VOLCADO_DE_LA_LAMINA = "f03_n0_pelea_a0252.ram"   # el de work/pelea/n0/f03
X_A_LA_IZQUIERDA = 0x30   # su centro, a mas de 0x20 del blanco de la columna 1: el lado 1


def _foto(p, sprites=()):
    from vram import fondo
    from figuras import pinta_sprites
    sube_el_mapa(p)
    img = fondo(p.li.v)
    pinta_sprites(img, p.li, 0, 1, list(sprites))
    y0, y1 = RECORTE_Y
    return [fila[:] for fila in img[y0:y1]]


def _pinguino(cart, pose=0, x=X_DEL_PINGUINO):
    from figuras import en_cuadro
    poses = poses_de_lo_que_se_maneja(cart)
    return [(n, Y_DEL_PINGUINO + dy, x + dx, pt, 1)
            for n, dy, dx, pt, _c in en_cuadro(poses[pose])]


def _sprites(lista):
    """(n, y, x, patron, color) -> lo que quiere pinta_sprites (dy, dx)."""
    return [(n, y, x, pt, c) for n, y, x, pt, c in lista]


def escenas_de_la_pelea(cart, fase=FASE_DE_LA_LAMINA):
    """Las cuatro fotos: caen los bloques, la pelea, la grieta y el hundimiento."""
    fotos = []
    regs = registros_de_los_bloques(cart)
    # 1. caen: a los 0x70 cuadros de la caida, dos posados y uno en el aire
    p = el_escenario(cart, fase)
    spr = _pinguino(cart)
    tipos = []
    for k, (_t, _y, x, freno) in enumerate(regs):
        t, y = el_bloque_a_los(freno, 0x70)
        tipos.append(t)
        if t == 1 and y != 0xFF:
            spr.append((10 + k, y, x, 0xA0, 4))
    pinta_los_bloques(p, tipos)
    fotos.append(_foto(p, _sprites(spr)))
    # 2. la pelea: el blanco una columna a la izquierda, andando y mirando al
    # pinguino, que esta a su izquierda; lo que lanza, en su bajada hacia el.
    # Como en el juego, el paso se da por sus dibujos (p03:AEAA) y cada uno
    # borra el anterior: ANDADAS_DE_LA_LAMINA
    p = el_escenario(cart, fase)
    anda_el_blanco(p, ANDADAS_DE_LA_LAMINA)
    pinta_los_bloques(p, (2, 2, 2, 2))
    spr = _pinguino(cart, 1, X_A_LA_IZQUIERDA)
    for i, (y, x, dib) in enumerate(vuelo(cart, 1, 1, 0)[::12]):
        spr.append((20 + i, y, x, dib, 0x0A))
    fotos.append(_foto(p, _sprites(spr)))
    # 3. veinte aciertos: bloques del tipo 5, la grieta entera y el blanco quieto
    p = el_escenario(cart, fase)
    el_hielo_roto(p)
    pinta_el_blanco(p, COLUMNA_DEL_CENTRO, 0, 0)
    pinta_los_bloques(p, (5, 5, 5, 5))
    pinta_la_grieta(p, 40)
    pinta_el_blanco(p, COLUMNA_DEL_CENTRO, 0, 0)
    fotos.append(_foto(p, _sprites(_pinguino(cart))))
    # 4. el agujero, con el blanco a mitad de hundirse
    p = el_escenario(cart, fase)
    el_hielo_roto(p)
    pinta_los_bloques(p, (5, 5, 5, 5))
    pinta_la_grieta(p, 40)
    pinta_las_burbujas(p, 0)
    pinta_el_agujero(p, COLUMNA_DEL_CENTRO, 4)
    fotos.append(_foto(p))
    return fotos


def dibujos_del_blanco(cart, fase=FASE_DE_LA_LAMINA):
    """Los nueve dibujos de 0xA842, cada uno recortado a lo que pinta."""
    fuera = []
    for paso in range(3):
        for lado in range(3):
            p = el_escenario(cart, fase)
            toc = set()
            pinta_el_blanco(p, COLUMNA_DEL_CENTRO, paso, lado, toc)
            fuera.append((paso, lado, p, toc))
    return fuera


def lamina_de_la_pelea(cart):
    from vram import fondo
    fotos = escenas_de_la_pelea(cart)
    w, h = 256, RECORTE_Y[1] - RECORTE_Y[0]
    hueco = 6
    ancho = 2 * w + hueco
    # abajo, los nueve dibujos: la caja comun de todos
    nueve = dibujos_del_blanco(cart)
    todas = set().union(*(t for *_x, t in nueve))
    cols = sorted({(a - 0xEBE0) % 32 for a in todas})
    filas = sorted({(a - 0xEBE0) // 32 for a in todas})
    c0, c1, f0, f1 = cols[0], cols[-1] + 1, filas[0] + 3, filas[-1] + 1 + 3
    dw, dh = (c1 - c0) * 8, (f1 - f0) * 8
    alto_nueve = 3 * (dh + 12)
    alto = 2 * h + hueco + 8 + alto_nueve
    img = [[1] * ancho for _ in range(alto)]
    for i, foto in enumerate(fotos):
        x0, y0 = (i % 2) * (w + hueco), (i // 2) * (h + hueco)
        for y in range(h):
            img[y0 + y][x0:x0 + w] = foto[y]
    y_nueve = 2 * (h + hueco) + 8
    sep = (ancho - 3 * dw) // 4
    for paso, lado, p, _t in nueve:
        sube_el_mapa(p)
        pan = fondo(p.li.v)
        x0 = sep + lado * (dw + sep)
        y0 = y_nueve + paso * (dh + 12)
        for y in range(dh):
            img[y0 + y][x0:x0 + dw] = pan[f0 * 8 + y][c0 * 8:c1 * 8]
        _texto(img, x0 + dw + 3, y0 + dh - 8, "%d%d" % (paso, lado), 15)
    return img


# ------------------------------------------------------------ el cotejo
def _volcados(patron):
    import glob
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    return sorted(glob.glob(os.path.join(raiz, "work", "pelea", "n0", "f*", patron)))


def _lee(ruta):
    with open(ruta, "rb") as f:
        return f.read()


def _copia(p):
    import copy
    return copy.deepcopy(p, {id(p.cart): p.cart})


def _caracteres_en_pantalla(p, v):
    """Los caracteres que usa la tabla de nombres del volcado de la fila 7 a
    la 23: los que no tienen el mismo patron y color."""
    malos = set()
    for fila in range(7, 24):
        for col in range(32):
            a = (fila // 8) * 0x800 + v[0x3800 + fila * 32 + col] * 8
            if (p.li.v[0x2000 + a:0x2008 + a] != v[0x2000 + a:0x2008 + a]
                    or p.li.v[a:a + 8] != v[a:a + 8]):
                malos.add(a)
    return len(malos)


def _sprites_en_pantalla(p, v):
    """Los patrones de los sprites que salen en el volcado."""
    from graficos import SPRITES_ATR, SPRITES_PAT
    malos = 0
    for n in range(32):
        y, _x, pt, co = v[SPRITES_ATR + 4 * n:SPRITES_ATR + 4 * n + 4]
        if y == 0xD0:
            break
        if y >= 0xC0 or not co & 0x0F:
            continue
        a = SPRITES_PAT + (pt & 0xFC) * 8
        malos += p.li.v[a:a + 32] != v[a:a + 32]
    return malos


def _espejo(p, r, celdas, fuera):
    """Cuenta las celdas del espejo que no coinciden con la RAM del volcado."""
    malas = [a for a in sorted(celdas) if p.ram[a] != r[a - 0xE000]]
    fuera.extend(malas)
    return len(malas)


def coteja(cart):
    """Los volcados de tools/lanza_pelea.sh (work/pelea) contra lo de aqui:

      caen    la fila de cada bloque desde su freno (la cuenta la da el
              bloque que aun esta frenado), su sprite y, los posados, su tira.
      pelea   el blanco en su base y con su dibujo (0xE531, 0xE532), su X
              (0xAF4B), los bloques posados, y lo que lanza: donde aparece,
              su dibujo en cada tiempo, su paso (0xB212) y su sprite (29).
      grieta  las escrituras de 0xAE0A que lleva 0xE53A, los bloques del
              tipo 5 y el blanco quieto.
      hunde   el agujero de 0xADA2, el blanco de 0xAB60 en su base y fila, y
              las burbujas (patrones y colores de 0xB3 y 0xD0).
    """
    cuentas = {}
    mal = 0
    todos = []
    escenarios = {}
    for ruta in _volcados("*_pelea_[abg]*.ram"):
        r = _lee(ruta)
        v = _lee(ruta[:-4] + ".vram")
        fase = int(os.path.basename(ruta)[1:3])
        sub, e530 = r[0x001], r[0x530]
        regs = [tuple(r[0x550 + 8 * k:0x554 + 8 * k]) for k in range(4)]
        tipos = tuple(t for t, *_x in regs)
        if fase not in escenarios:
            escenarios[fase] = el_escenario(cart, fase)
        p = _copia(escenarios[fase])
        errores = []
        if sub == 2:
            clase = "caen"
            frenado = [k for k in range(4) if regs[k][0] == 1 and regs[k][3] > 0]
            inicial = registros_de_los_bloques(cart)
            if frenado:
                k0 = max(frenado, key=lambda k: regs[k][3])
                e = inicial[k0][3] - regs[k0][3]
                for k in range(4):
                    t, y = el_bloque_a_los(inicial[k][3], e)
                    if (regs[k][0], regs[k][1] if t == 1 else None) != (t, y):
                        errores.append("bloque %d: tipo %d fila %02X y no %d %s"
                                       % (k, regs[k][0], regs[k][1], t, y))
            for k in range(4):
                if regs[k][0] == 1 and tuple(r[0xEA8 + 4 * k:0xEAA + 4 * k]) != regs[k][1:3]:
                    errores.append("sprite del bloque %d" % k)
            toc = set()
            pinta_los_bloques(p, tipos, toc)
            n = _espejo(p, r, toc, todos)
            if n:
                errores.append("%d celdas de los bloques" % n)
        elif e530 == 1:
            clase = "pelea"
            col, paso, lado = r[0x537], r[0x531], r[0x532]
            if r[0x536] != x_del_blanco(cart, col):
                errores.append("X del blanco %02X" % r[0x536])
            if r[0x538] | (r[0x539] << 8) != base_del_blanco(cart, col):
                errores.append("base del blanco")
            dino, bloq = set(), set()
            pinta_el_blanco(p, col, paso, lado, dino)
            pinta_los_bloques(p, tipos, bloq)
            n = _espejo(p, r, dino | bloq, todos)
            if n:
                errores.append("%d celdas del blanco y los bloques" % n)
            t = r[0x540]
            y, x, dib = r[0x547], r[0x549], r[0x54A]
            if t == 1:
                if (y, x) != (0x7C, (r[0x536] + DESVIO_AL_APARECER[min(lado, 2)]) & 0xFF):
                    errores.append("aparece en %02X,%02X" % (y, x))
                if dib != (0xA4 if r[0x54C] & 8 else 0xA8):
                    errores.append("parpadeo %02X" % dib)
            elif t in (2, 3, 4):
                if dib != (0xAC, 0xB0, 0xB4)[t - 2]:
                    errores.append("tiempo %d con el dibujo %02X" % (t, dib))
                paso4 = list(r[0x542:0x546])
                todos_los_pasos = [pasos_de_lo_que_lanza(cart, l, h)
                                   for l in range(3) for h in range(3)]
                if paso4 not in todos_los_pasos:
                    errores.append("paso %s" % paso4)
                else:
                    dy = paso4[0] | (paso4[1] << 8)
                    dx = paso4[2] | (paso4[3] << 8)
                    yy = r[0x546] | (r[0x547] << 8)
                    k = (yy - 0x7C00) // dy
                    x0 = ((r[0x548] | (r[0x549] << 8)) - k * dx) & 0xFFFF
                    salidas = {((x_del_blanco(cart, c) + d) & 0xFF) << 8
                               for c in range(5) for d in DESVIO_AL_APARECER}
                    if (yy - 0x7C00) % dy or x0 not in salidas:
                        errores.append("vuelo fuera de su recta")
            if t and tuple(r[0xEF4:0xEF8]) != (y, x, dib, r[0x54B]):
                errores.append("sprite 29")
        elif e530 == 2:
            clase = "grieta"
            el_hielo_roto(p)
            col = r[0x537]
            n_grieta = ((r[0x53A] | (r[0x53B] << 8)) - GRIETA) // 3
            if tipos != (5, 5, 5, 5):
                errores.append("bloques %s" % (tipos,))
            bloq, grieta, dino = set(), set(), set()
            pinta_los_bloques(p, tipos, bloq)
            pinta_la_grieta(p, n_grieta, grieta)
            pinta_el_blanco(p, col, 0, 0, dino)
            nueve = set()
            for pa in range(3):
                for la in range(3):
                    q = _copia(escenarios[fase])
                    pinta_el_blanco(q, col, pa, la, nueve)
            n = _espejo(p, r, dino | (grieta - dino) | (bloq - grieta - dino - nueve), todos)
            if n:
                errores.append("%d celdas" % n)
        elif e530 in (3, 4):
            clase = "hunde"
            el_hielo_roto(p)
            col, paso = r[0x537], r[0x531]
            toc = set()
            base = pinta_el_agujero(p, col, paso, toc)
            if r[0x538] | (r[0x539] << 8) != base:
                errores.append("base %04X y no %04X" % (r[0x538] | (r[0x539] << 8), base))
            n = _espejo(p, r, toc, todos)
            if n:
                errores.append("%d celdas del agujero" % n)
            bit4 = (r[0x533] >> 4) & 1 if e530 == 3 else 0
            pinta_las_burbujas(p, bit4)
            for dp, dc in DESTINO_DE_LAS_BURBUJAS:
                for a in (dp, dc):
                    if bytes(p.li.v[a:a + 8]) != v[a:a + 8]:
                        errores.append("burbujas en %04X" % a)
        else:
            continue
        n = _caracteres_en_pantalla(p, v) + _sprites_en_pantalla(p, v)
        if n:
            errores.append("%d caracteres o sprites en pantalla" % n)
        c = cuentas.setdefault(clase, [0, 0])
        c[0] += 1
        if errores:
            c[1] += 1
            mal += 1
            if mal <= 12:
                print("  %s (%s): %s" % (os.path.basename(ruta), clase, "; ".join(errores)))
    for clase in ("caen", "pelea", "grieta", "hunde"):
        n, m = cuentas.get(clase, (0, 0))
        print("pelea %-6s %4d volcados, %d con diferencias" % (clase, n, m))
    # y la foto de la pelea de la lamina, la carretera entera
    rutas = _volcados(VOLCADO_DE_LA_LAMINA)
    if not rutas:
        print("pelea: falta %s" % VOLCADO_DE_LA_LAMINA)
        return False
    r = _lee(rutas[0])
    p = el_escenario(cart, FASE_DE_LA_LAMINA)
    anda_el_blanco(p, ANDADAS_DE_LA_LAMINA)
    pinta_los_bloques(p, (2, 2, 2, 2))
    n = sum(1 for a in range(0xEBE0 + 4 * 32, 0xEE80) if p.ram[a] != r[a - 0xE000])
    print("pelea lamina: la carretera contra %s, %d celdas distintas" % (VOLCADO_DE_LA_LAMINA, n))
    mal += n
    if todos:
        print("  primeras celdas malas: %s" % " ".join("%04X" % a for a in todos[:12]))
    return mal == 0 and all(clase in cuentas for clase in ("caen", "pelea", "grieta", "hunde"))


def main():
    cart = Cartucho()
    if sys.argv[1:] == ["coteja"]:
        sys.exit(0 if coteja(cart) else 1)
    print(guarda_png(lamina_de_la_pelea(cart), os.path.join(IMAGENES, "pelea.png"), escala=2))


if __name__ == "__main__":
    main()
