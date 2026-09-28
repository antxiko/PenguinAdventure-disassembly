#!/usr/bin/env python3
"""La tienda escondida (el estado 12), montada desde las tablas.

  p01:72F2  caer en el centro de una grieta de modo 3, 4 o 5 pone el estado
            0x12 en lo que se maneja, el modo en 0xE0A2 y el aviso 0x20: el
            estado 12 (p02:86C6), la escena larga, es la tienda.
  p02:86D7  el subestado 1 esconde los sprites, borra las filas 3 a 23
            (p00:4232), pinta TIME, DIST y los puntos (0x8E4F y p02:9417) y
            llama a p01:6BEF, que lo monta todo de golpe:
    p00:5B91   los dieciseis bloques de color y la letra (lo que se hereda);
    p00:4BBF   los caracteres de la tienda: 0x88CA y 0x898A del banco 5 en
               los tres tercios (patrones 0x40-0x7B, el segundo con espejo)
               con sus colores 0x89FD y 0x8A6C; y en el modo 4, los colores
               de 0x8ABB y 0x8AF0 encima, que es lo que le cambia la cara al
               tendero;
    p00:51CD   los caracteres del marcador (0xB71B y 0xB96A del banco 6), que
               son tambien los dibujos de los articulos: cuatro por articulo
               desde el 0xB2 (p01:6D43);
    p01:6C4E   el rotulo del modo, con mascara y del banco 13 (0xA563, 0xA59D
               o 0xA5D7): ---BARTER---, el tendero en las filas 6 a 9 y END;
    p01:6CC3   las seis casillas de 0xE100: la lista de siete de la fase
               (0xAF90, banco 11) menos lo que ya se lleva (0xE160), cada una
               con su precio en la tabla del modo (0x6FD5, 0x6FE5 o 0x6FF5);
    p01:6C6A   y el repintado: el dibujo de cada casilla (p01:6D2A) en las
               direcciones de 0x6DC5, el precio dos filas mas abajo (a cero
               no se pinta, p01:6DEF), la bolsa de apostar (0xB124) solo con
               puntos (0xE134) y el cursor (0x44 0x45) en la primera casilla
               llena, por las direcciones de 0x7005.
  p02:86ED  el subestado 2: el pinguino entra por arriba (p02:9FC9, tres
            filas por cuadro hasta la 0x90; en el mar, la 0xA0 y nadando) y
            al llegar p03:A8DB lo pone en cuadro con la pose 0 y el color 4.
  p01:6E1E  el subestado 3, la tienda: cada cuadro pinta el saludo del modo
            (0xB038, 0xB065 o 0xB0DD, banco 11) dentro del bocadillo de
            0xB12E. Izquierda y derecha mueven el cursor y el disparo compra
            (p01:6EC4): resta el precio del marcador en BCD y p03:BA2F apunta
            el articulo en 0xE160 + k. La casilla 6 es la bolsa: aviso 2, a
            la maquina de apostar (p01:7809). La 7 es END: p01:6F29 borra el
            saludo con el mismo guion y la mascara a cero, pinta la despedida
            (0xB094, 0xB0BE o 0xB105), espera 0x80 cuadros y deja el aviso 1,
            que es salir. Con Santa Claus (modo 5) la primera compra cierra
            la tienda (p01:6F09).

Uso:  tienda.py           dibuja docs/imagenes/tienda.png y articulos.png
      tienda.py coteja    los coteja con los volcados de tools/lanza_tiendas.sh
      tienda.py tabla     las 41 tiendas y los precios, en markdown
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import (Cartucho, IMAGENES, PATRONES, COLORES, guarda_png,  # noqa: E402
                      pinta, pinta_con_mascara, poses_de_lo_que_se_maneja, _texto)
from pantalla import Pantalla, monta_la_pantalla, lo_que_se_hereda  # noqa: E402
from sprites import DATOS_DE_FASE  # noqa: E402
from figuras import pinta_sprites, en_cuadro, sombra  # noqa: E402

B123, B456, B1011, B1213 = (1, 2, 3), (4, 5, 6), (1, 10, 11), (1, 12, 13)
MARCADOR_DE_LA_ESCENA = 0x8E4F               # banco 2: TIME, DIST, el pez y SP
ROTULO_DEL_MODO = {3: 0xA563, 4: 0xA59D, 5: 0xA5D7}    # banco 13, p01:6C4E
SALUDO = {3: 0xB038, 4: 0xB065, 5: 0xB0DD}             # banco 11, p01:6E2F
DESPEDIDA = {3: 0xB094, 4: 0xB0BE, 5: 0xB105}          # banco 11, p01:6E32
BOCADILLO = 0xB12E                           # banco 11, p01:6E5F
BOLSA = 0xB124                               # banco 11, p01:6E06
CASILLAS = 0x6DC5                            # seis direcciones de pantalla
CURSOR = 0x7005                              # ocho: las seis, la bolsa y END
PRECIOS = {3: 0x6FD5, 4: 0x6FE5, 5: 0x6FF5}  # p01:6CC9, 6CD4 y 6CDB
LISTAS = 0xAF90                              # banco 11, siete por fase
AVISOS = 0xB046                              # banco 13, p03:B8AB
VALORES = 0xBABB                             # p03:BA35: lo que va a 0xE160 + k
SPRITES_FIJOS = 0xBC99                       # banco 13 -> 0xEEE0, p01:7DB3
PRIMER_DIBUJO = 0xB2
ARTICULOS = 16
CASILLA_EMPEZAR = 0x39C3                     # p01:6C79: donde "estaba" el cursor


def _p(cart, a, b):
    return cart.leer(a, b) | (cart.leer(a + 1, b) << 8)


def tiempo_de_la_fase(cart, fase):
    """p00:47B1: los doce bits de abajo de la entrada de 0xACBA, en BCD."""
    q = DATOS_DE_FASE + 4 * (fase - 1)
    return ((cart.leer(q + 1, B1213) & 0x0F) << 8) | cart.leer(q, B1213)


def precios(cart, modo):
    return [cart.leer(PRECIOS[modo] + k, B123) for k in range(ARTICULOS)]


def lista_de_la_fase(cart, fase):
    """p01:6CE9: los siete bytes de la fase, hasta el primer cero."""
    fuera = []
    for i in range(7):
        a = cart.leer(LISTAS + 7 * (fase - 1) + i, B1011)
        if not a:
            break
        fuera.append(a)
    return fuera


def casillas_de(cart, fase, modo, llevados=()):
    """p01:6CC3: [(articulo, precio)] de lo que se ofrece, sin lo que se lleva."""
    pr = precios(cart, modo)
    return [(a, pr[a - 1]) for a in lista_de_la_fase(cart, fase)
            if not (a - 1 < len(llevados) and llevados[a - 1])]


def tiendas(cart):
    """p03:B8AB sobre 0xB046: [(fase, distancia, modo)] de las grietas que no
    son de modo 2 (esas son los atajos)."""
    fuera = []
    for f in range(1, 25):
        t = _p(cart, AVISOS + 2 * (f - 1), B1213)
        for i in range(8):
            d = _p(cart, t + 4 * i, B1213)
            if d == 0xFFFF:
                break
            modo = cart.leer(t + 4 * i + 3, B1213) & 0x0F
            if modo != 2:
                fuera.append((f, d, modo))
    return fuera


def _cifras(li, dest, nibbles):
    """p02:9417: cada cifra es 0x10 mas el nibble."""
    for k, n in enumerate(nibbles):
        li.escribe(dest + k, 0x10 + n)


def _primera_casilla(casillas, con_puntos):
    """p01:6C84: la primera llena; si no hay ninguna, la bolsa o END."""
    for k in range(6):
        if k < len(casillas):
            return k
    return 6 if con_puntos else 7


def monta_la_tienda(cart, fase, modo, llevados=(), tiempo=None, queda=0,
                    puntos=0, cierre=False):
    """La pantalla de la tienda de `fase` con el tendero `modo`, con el
    pinguino ya en su sitio. Con `cierre`, tras pulsar END: la despedida en
    el bocadillo y el cursor en END. Devuelve (Pantalla, sprites)."""
    p = monta_la_pantalla(cart, fase)
    li, ram = p.li, p.ram
    d = ram[0xE0A1]
    modo = modo if modo in ROTULO_DEL_MODO else 5
    if tiempo is None:
        tiempo = tiempo_de_la_fase(cart, fase)
    # p02:86D9: esconder los sprites y borrar las filas 3 a 23
    for n in range(32):
        ram[0xEE80 + 4 * n] = 0xE0
    for a in range(0x3860, 0x3B00):
        li.escribe(a, 0)
    # p02:9431: TIME, DIST y los puntos, con las cifras de p02:9417
    pinta_con_mascara(cart, B123, MARCADOR_DE_LA_ESCENA, li)
    _cifras(li, 0x3806, [(tiempo >> 8) & 15, (tiempo >> 4) & 15, tiempo & 15])
    _cifras(li, 0x380E, [(queda >> 12) & 15, (queda >> 8) & 15, (queda >> 4) & 15, queda & 15])
    _cifras(li, 0x3815, [(puntos >> 8) & 15, (puntos >> 4) & 15, puntos & 15])
    # p01:6BEF: los sprites de la escena y el color 4 en los del pinguino
    for a in (0xEE83, 0xEE87, 0xEE8B, 0xEE8F):
        ram[a] = 4
    for k in range(32):
        ram[0xEEE0 + k] = cart.leer(SPRITES_FIJOS + k, B1213)
    ram[0xEECB] = ram[0xEECF] = 5
    lo_que_se_hereda(p)                                    # p00:5B91
    p.pinta_en_los_tres(B456, 0x88CA, 0x2200)              # p00:4BBF
    p.pinta_en_los_tres(B456, 0x898A, 0x2368, 1)
    p.pinta_en_los_tres(B456, 0x89FD, 0x0200)
    p.pinta_en_los_tres(B456, 0x8A6C, 0x0368)
    if modo == 4:
        p.pinta_en_los_tres(B456, 0x8ABB, 0x0248)
        p.pinta_en_los_tres(B456, 0x8AF0, 0x0318)
        p.pinta_en_los_tres(B456, 0x8AF0, 0x0390)
    p.pinta_en_los_tres(B456, 0xB71B, 0x2590)              # p00:51CD
    p.pinta_en_los_tres(B456, 0xB96A, 0x0590)
    pinta_con_mascara(cart, B1213, ROTULO_DEL_MODO[modo], li)   # p01:6C4E
    casillas = casillas_de(cart, fase, modo, llevados)[:6]      # p01:6CC3
    con_puntos = puntos != 0                                    # p01:6E13
    # p01:6C6A: el repintado entero
    for b in range(6):                                          # p01:6D2A
        dest = _p(cart, CASILLAS + 2 * b, B123)
        if b < len(casillas):
            c = PRIMER_DIBUJO + 4 * (casillas[b][0] - 1)
            for a, v in ((dest, c), (dest + 1, c + 1), (dest + 32, c + 2), (dest + 33, c + 3)):
                li.escribe(a, v)
        else:
            for a in (dest, dest + 1, dest + 32, dest + 33):
                li.escribe(a, 0)
    pinta_con_mascara(cart, B1011, BOLSA, li, 0xFF if con_puntos else 0x00)  # p01:6E06
    for b in range(6):                                          # p01:6DD1
        dest = _p(cart, CASILLAS + 2 * b, B123) + 0x40
        precio = casillas[b][1] if b < len(casillas) else 0
        if precio:
            _cifras(li, dest, [precio >> 4, precio & 15])
        else:
            li.escribe(dest, 0)
            li.escribe(dest + 1, 0)
    k = _primera_casilla(casillas, con_puntos)                  # p01:6C84
    li.escribe(CASILLA_EMPEZAR, 0)
    li.escribe(CASILLA_EMPEZAR + 1, 0)
    pos = _p(cart, CURSOR + 2 * k, B123)
    li.escribe(pos, 0x44)
    li.escribe(pos + 1, 0x45)
    # p02:9FC9 y p03:A8DB: el pinguino en cuadro, pose 0, color 4, y su sombra
    y, x = (0xA0 if d in (4, 5) else 0x90), 0x70
    pose = poses_de_lo_que_se_maneja(cart)[0]
    sprites = [(n, y + dy, x + dx, pt, 4) for n, dy, dx, pt, _c in en_cuadro(pose)]
    sprites += [(n, 0xAE, x + dx, pt, 5) for n, _dy, dx, pt, _c in sombra(5)]
    # p01:6E1E, cada cuadro: el saludo dentro del bocadillo
    pinta(cart, B1011, BOCADILLO, li)
    if cierre:
        # p01:6E8D: izquierda desde la primera casilla lleva el cursor a END
        li.escribe(pos, 0)
        li.escribe(pos + 1, 0)
        pos = _p(cart, CURSOR + 2 * 7, B123)
        li.escribe(pos, 0x44)
        li.escribe(pos + 1, 0x45)
        # p01:6F29: el saludo se borra con la mascara a cero y entra la despedida
        pinta_con_mascara(cart, B1011, SALUDO[modo], li, 0x00)
        pinta_con_mascara(cart, B1011, DESPEDIDA[modo], li)
    else:
        pinta_con_mascara(cart, B1011, SALUDO[modo], li)
    return p, sprites


def _foto(p, sprites):
    from vram import fondo
    img = fondo(p.li.v)
    pinta_sprites(img, p.li, 0, 1, list(sprites))
    return img


# Las seis fotos de la lamina: la tienda de cada tendero, con los puntos que
# hacen falta para que salga la bolsa; arriba el saludo y abajo la despedida.
LAMINA = ((1, 3, 0x0500), (1, 4, 0x0200), (6, 5, 0x0315))


def lamina_de_la_tienda(cart):
    fotos = []
    for cierre in (False, True):
        for fase, modo, queda in LAMINA:
            fotos.append(_foto(*monta_la_tienda(cart, fase, modo, queda=queda,
                                                puntos=0x0250, cierre=cierre)))
    w, h, hueco = 256, 192, 6
    img = [[1] * (3 * w + 2 * hueco) for _ in range(2 * h + hueco)]
    for i, foto in enumerate(fotos):
        x0, y0 = (i % 3) * (w + hueco), (i // 3) * (h + hueco)
        for y in range(h):
            img[y0 + y][x0:x0 + w] = foto[y]
    return img


def lamina_de_articulos(cart):
    """Los dieciseis dibujos de 0xB71B, con su numero y su precio normal/caro."""
    p = Pantalla(cart)
    p.pinta_en_los_tres(B456, 0xB71B, 0x2590)
    p.pinta_en_los_tres(B456, 0xB96A, 0x0590)
    pn, pc = precios(cart, 3), precios(cart, 4)
    ancho = 24
    img = [[1] * (ARTICULOS * ancho) for _ in range(32)]
    for k in range(ARTICULOS):
        x0 = k * ancho + 4
        c = PRIMER_DIBUJO + 4 * k
        for i, (dy, dx) in enumerate(((0, 0), (0, 8), (8, 0), (8, 8))):
            base = 0x800 + (c + i) * 8                     # el tercio de en medio
            for y in range(8):
                pat = p.li.v[PATRONES + base + y]
                col = p.li.v[COLORES + base + y]
                tinta, fondo = col >> 4, col & 0x0F
                for x in range(8):
                    v = tinta if (pat >> (7 - x)) & 1 else fondo
                    img[dy + y][x0 + dx + x] = v or 1
        _texto(img, x0 + (4 if k < 9 else 2), 18, "%d" % (k + 1), 15)
        _texto(img, x0 - 2, 25, "%X/%X" % (pn[k], pc[k]) if pn[k] else "-", 7)
    return img


def tabla(cart):
    """Las 41 tiendas y los precios, tal como van en la web (ES y EN)."""
    pr = {m: precios(cart, m) for m in (3, 4, 5)}
    filas = ["| %d | %X | %X | %X |" % (k + 1, pr[3][k], pr[4][k], pr[5][k])
             for k in range(ARTICULOS) if pr[3][k]]
    nombre = {3: ("normal", "normal"), 4: ("**caro**, el doble", "**expensive**, double"),
              5: ("**Santa Claus: gratis**", "**Santa Claus: free**")}
    cuantas = {m: 0 for m in (3, 4, 5)}
    es, en = [], []
    for f, d, m in tiendas(cart):
        cuantas[m] += 1
        arts = " ".join("%d" % a for a in lista_de_la_fase(cart, f))
        es.append("| %d | 0x%04X | %s | %s |" % (f, d, nombre[m][0], arts))
        en.append("| %d | 0x%04X | %s | %s |" % (f, d, nombre[m][1], arts))
    return {"precios": "\n".join(filas), "cuantas": cuantas, "es": "\n".join(es),
            "en": "\n".join(en), "total": sum(cuantas.values())}


def coteja(cart):
    """Los volcados de tools/lanza_tiendas.sh (work/tiendas): la tienda abierta
    con el pinguino en su sitio, y tras END, con la despedida. Se comparan las
    tablas de patrones, colores y nombres que pone el montaje, y los sprites a
    la vista del espejo de 0xEE80."""
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    vistos = malos = 0
    for ruta in sorted(glob.glob(os.path.join(raiz, "work", "tiendas", "tienda_f*_m*_*.vram"))):
        with open(ruta, "rb") as f:
            v = f.read()
        with open(ruta[:-5] + ".ram", "rb") as f:
            r = f.read()
        base = os.path.basename(ruta)
        cierre = base.endswith("_cierre.vram")
        p, sprites = monta_la_tienda(
            cart, r[0x92], r[0xA2], r[0x160:0x173],
            tiempo=((r[0x8C] & 15) << 8) | r[0x8B], queda=(r[0x8E] << 8) | r[0x8D],
            puntos=(r[0x8A] << 8) | r[0x89], cierre=cierre)
        dis = [a for a in list(range(0x0000, 0x1800)) + list(range(0x2000, 0x3B00))
               if p.li.tocado[a] and p.li.v[a] != v[a]]
        a_la_vista = {(n, r[0xE80 + 4 * n], r[0xE81 + 4 * n], r[0xE82 + 4 * n], r[0xE83 + 4 * n])
                      for n in range(32) if r[0xE80 + 4 * n] != 0xE0 and r[0xE83 + 4 * n] & 15}
        spr = set(sprites) ^ a_la_vista
        vistos += 1
        if dis or spr:
            malos += 1
            print("  %s: %d bytes distintos %s, sprites %d" % (
                base, len(dis), " ".join("%04X" % a for a in dis[:8]), len(spr)))
    print("tienda: %d volcados, %d con diferencias" % (vistos, malos))
    return vistos > 0 and malos == 0


def main():
    cart = Cartucho()
    if sys.argv[1:] == ["coteja"]:
        sys.exit(0 if coteja(cart) else 1)
    if sys.argv[1:] == ["tabla"]:
        t = tabla(cart)
        print("tiendas %d %s\n\nprecios:\n%s\n\nES:\n%s\n\nEN:\n%s"
              % (t["total"], t["cuantas"], t["precios"], t["es"], t["en"]))
        return
    print(guarda_png(lamina_de_la_tienda(cart), os.path.join(IMAGENES, "tienda.png"), escala=2))
    print(guarda_png(lamina_de_articulos(cart), os.path.join(IMAGENES, "articulos.png"), escala=2))


if __name__ == "__main__":
    main()
