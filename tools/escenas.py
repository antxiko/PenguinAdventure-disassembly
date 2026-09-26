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
from sprites import carga_del_decorado, carga_de_la_fase, TRIO  # noqa: E402

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


# Los patrones de sprite que la escena no recarga son los de la fase de la
# que se viene: la 12 para el arbol y la 24 para los finales. OJO: la sonda
# (tools/omsx_escenas.tcl) salta a la escena desde la fase 1, y sus volcados
# llevan los de la 1 (decorado 3); el cotejo los monta asi.
FASE_DE_LA_ESCENA = {"arbol": 12, "bueno": 24, "malo": 24}
FASE_DE_LA_SONDA = 1


def monta_la_escena(cart, cual, con_mensajes=True, p=None, heredada=None):
    """cual: "arbol", "bueno" o "malo"; heredada: la fase de la que se viene."""
    p = p or Pantalla(cart)
    lo_que_se_hereda(p)
    if heredada:
        carga_de_la_fase(cart, heredada, p.li)
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
        if cual == "bueno":                            # p03:AB69; el malo no
            carga_del_decorado(cart, 0, p.li)          # p00:57FB, el decorado 0
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
        p = monta_la_escena(cart, cual, heredada=FASE_DE_LA_ESCENA[cual])
        if cual == "bueno":
            figura_del_final_bueno(p)
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


# ------------------------------------------------- lo que se mueve en ellas
# El paso de la escena es 0xE0B7 y el contador de dentro 0xE0B8 (p03:AA80).
#   todas  el pinguino entra por abajo (0xE204 = 0xBF) y sube una fila cada
#          cuatro cuadros (p03:ACE6) con la pose que dicen los dos bits de
#          abajo de la fila: 0 si el bit 0 es 0, y si no, 1 o 2 segun el bit 1.
#          Hasta la 0x82 en el arbol (paso 4, X 0x6D) y la 0x7A en los
#          finales (paso 5, X 0x70: sigue mientras no baje de la 0x7B).
#   arbol  paso 5: la figura de nueve de 0xA432, subida 0x21 filas (p03:AD14),
#          que sigue en el 6 hasta que 0xE012 lo deja pasar; al salir del 6,
#          la de 0xA456; paso 7: lo que cae del arbol, los sprites 28
#          a 31 (la plantilla de 0xADAA) por las diecisiete parejas de 0xAD88,
#          el 28 en la fila de la pareja y los otros tres cinco mas arriba.
#   bueno  paso 6: el salto, las veintinueve filas de 0xADBA (p03:AD2F), con
#          la pose 3 en las pares y la 4 en las impares.
#   malo   paso 6: cada ocho cuadros, los seis sprites de 0xADD7 o de 0xADEF
#          (p03:ACB5), uno y otro.
B123 = (1, 2, 3)
PAREJAS_DE_LO_QUE_CAE = 0xAD88
PLANTILLA_DE_LO_QUE_CAE = 0xADAA
ARCO_DEL_SALTO = 0xADBA
FIGURAS = {"a432": 0xA432, "a456": 0xA456}
LLANTO = (0xADD7, 0xADEF)
DONDE_ANDA = {"arbol": (4, 0x6D, 0x82), "bueno": (5, 0x70, 0x7A), "malo": (5, 0x70, 0x7A)}
SUBIDA_DE_LA_FIGURA = {"arbol": 0x21, "bueno": 0x21, "malo": 0x2C}   # p03:AD14


def pose_al_andar(y):
    """p03:ACF6."""
    if not y & 1:
        return 0
    return 1 if not y & 2 else 2


def el_que_anda(cart, y, x, pose=None):
    """Los sprites 0 a 3 como los deja p03:A8DB: (n, fila, columna, patron, color)."""
    from graficos import poses_de_lo_que_se_maneja
    from figuras import en_cuadro
    pose = pose_al_andar(y) if pose is None else pose
    return [(n, y + dy, x + dx, pt, c)
            for n, dy, dx, pt, c in en_cuadro(poses_de_lo_que_se_maneja(cart)[pose])]


def figura(cart, cual, subida=0):
    """Los nueve sprites de 0xA432 o 0xA456 (p03:AD0B), con la subida de
    p03:AD14 si la lleva."""
    t = FIGURAS[cual]
    fuera = []
    for k in range(9):
        y, x, pt, co = (cart.leer(t + 4 * k + i, B123) for i in range(4))
        fuera.append((k, (y - subida) & 0xFF, x, pt, co & 0x0F))
    return fuera


def lo_que_cae(cart, paso):
    """Los sprites 28 a 31 en la pareja `paso` de 0xAD88 (p03:AD58)."""
    y = cart.leer(PAREJAS_DE_LO_QUE_CAE + 2 * paso, B123)
    x = cart.leer(PAREJAS_DE_LO_QUE_CAE + 2 * paso + 1, B123)
    fuera = []
    for k in range(4):
        pt = cart.leer(PLANTILLA_DE_LO_QUE_CAE + 4 * k + 2, B123)
        co = cart.leer(PLANTILLA_DE_LO_QUE_CAE + 4 * k + 3, B123)
        fuera.append((28 + k, y if k == 0 else y - 5, x, pt, co & 0x0F))
    return fuera


def fila_del_salto(cart, i):
    return cart.leer(ARCO_DEL_SALTO + i, B123)


def llanto(cart, cual):
    t = LLANTO[cual]
    return [(k, *(cart.leer(t + 4 * k + i, B123) for i in range(3)),
             cart.leer(t + 4 * k + 3, B123) & 0x0F) for k in range(6)]


def figura_del_final_bueno(p):
    """Paso 7 del final bueno: p00:5667 y p00:56D9, los sprites de la figura."""
    p.pinta(TRIO, 0x7FBC)
    p.pinta(TRIO, 0x7E3C, 0x1CA0, 0)


def _foto(cart, cual, sprites, con_figura=False):
    from vram import fondo
    from figuras import pinta_sprites
    p = monta_la_escena(cart, cual, con_mensajes=False, heredada=FASE_DE_LA_ESCENA[cual])
    if con_figura:
        figura_del_final_bueno(p)
    img = fondo(p.li.v)
    pinta_sprites(img, p.li, 0, 1, list(sprites))
    return img


# Las fotos de cada fila de la lamina: (escena, sprites) y el recorte, que es
# el trozo de pantalla donde pasa todo.
RECORTE_ANDANDO = (0x48, 0xC0, 0x40, 0xC0)      # filas y columnas en pixeles


def fotos_andando(cart):
    filas = []
    fijos = {"malo": sprites_de_la_escena(cart, "malo")}
    for cual in ("arbol", "bueno", "malo"):
        _paso, x, hasta = DONDE_ANDA[cual]
        fila = []
        for y in (0xBF, 0xAB, 0x97, hasta):
            spr = el_que_anda(cart, y, x)
            if cual == "malo":
                spr += fijos["malo"]
            fila.append(_foto(cart, cual, spr))
        if cual == "arbol":
            fila.append(_foto(cart, cual, figura(cart, "a432", SUBIDA_DE_LA_FIGURA[cual])))
            for paso in (4, 8, 12):
                fila.append(_foto(cart, cual, figura(cart, "a456") + lo_que_cae(cart, paso)))
        elif cual == "bueno":
            for i in (7, 14, 21):
                fila.append(_foto(cart, cual, el_que_anda(cart, fila_del_salto(cart, i), x,
                                                          3 if i % 2 == 0 else 4)))
            fila.append(_foto(cart, cual, figura(cart, "a456"), con_figura=True))
        else:
            for k in (0, 1):
                fila.append(_foto(cart, cual, llanto(cart, k) + fijos["malo"]))
        filas.append(fila)
    return filas


def lamina_andando(cart):
    y0, y1, x0, x1 = RECORTE_ANDANDO
    w, h, hueco = x1 - x0, y1 - y0, 4
    filas = fotos_andando(cart)
    n = max(len(f) for f in filas)
    img = [[1] * (n * (w + hueco)) for _ in range(len(filas) * (h + hueco))]
    for i, fila in enumerate(filas):
        for j, foto in enumerate(fila):
            for y in range(h):
                img[i * (h + hueco) + y][j * (w + hueco):j * (w + hueco) + w] = foto[y0 + y][x0:x1]
    return img


def coteja_andando(cart):
    """Los volcados de tools/lanza_escenas.sh (work/escenas_en_marcha), un
    cuadro de cada dos por p03:AA80: los sprites del espejo (0xEE80) contra
    lo de aqui, paso a paso."""
    import glob
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    cuentas, mal = {}, 0

    from graficos import SPRITES_ATR, SPRITES_PAT
    montadas = {}

    def patrones(cual, paso, v):
        """Los patrones de los sprites que salen en el volcado."""
        clave = (cual, cual == "bueno" and paso >= 8)
        if clave not in montadas:
            q = monta_la_escena(cart, cual, con_mensajes=False, heredada=FASE_DE_LA_SONDA)
            if clave[1]:
                figura_del_final_bueno(q)
            montadas[clave] = q
        li = montadas[clave].li
        malos = 0
        for k in range(32):
            y, _x, pt, co = v[SPRITES_ATR + 4 * k:SPRITES_ATR + 4 * k + 4]
            if y == 0xD0:
                break
            if y >= 0xC0 or not co & 0x0F:
                continue
            a = SPRITES_PAT + (pt & 0xFC) * 8
            malos += li.v[a:a + 32] != v[a:a + 32]
        return malos

    def espejo(r, sprites):
        return sum(1 for n, y, x, pt, co in sprites
                   if tuple(r[0xE80 + 4 * n:0xE84 + 4 * n]) != (y, x, pt, co)
                   and tuple(r[0xE80 + 4 * n:0xE83 + 4 * n]) + (r[0xE83 + 4 * n] & 0x0F,)
                   != (y, x, pt, co))

    for cual, b9 in (("arbol", 2), ("bueno", 0), ("malo", 1)):
        paso_anda, x_anda, _hasta = DONDE_ANDA[cual]
        for ruta in sorted(glob.glob(os.path.join(raiz, "work", "escenas_en_marcha", cual,
                                                  "s*_b%d_p*.ram" % b9))):
            with open(ruta, "rb") as f:
                r = f.read()
            paso, e8, y = r[0x0B7], r[0x0B8], r[0x204]
            que = None
            if paso == paso_anda and y != 0xBF:
                que, n = "anda", espejo(r, el_que_anda(cart, y, r[0x205]))
                if r[0x205] != x_anda:
                    n += 1
            elif cual == "arbol" and paso == 7 and 0 < e8 <= 17:
                que, n = "cae", espejo(r, figura(cart, "a456") + lo_que_cae(cart, e8 - 1))
            elif cual == "arbol" and paso == 6:
                que, n = "figura", espejo(r, figura(cart, "a432", SUBIDA_DE_LA_FIGURA[cual]))
            elif cual == "bueno" and paso == 6 and e8 < 29:
                buenos = [min(espejo(r, el_que_anda(cart, fila_del_salto(cart, i), x_anda,
                                                     3 if i % 2 == 0 else 4)), 1)
                          for i in (e8, e8 - 1) if 0 <= i < 29]
                if e8 == 0 and y == _hasta:
                    # el primer cuadro del paso: aun no ha pasado por p03:AD2F
                    buenos.append(min(espejo(r, el_que_anda(cart, y, x_anda)), 1))
                que, n = "salta", min(buenos)
            elif cual == "malo" and paso == 6 and e8 > 0:
                que, n = "llora", espejo(r, llanto(cart, (e8 - 1) & 1))
            if que is None:
                continue
            with open(ruta[:-4] + ".vram", "rb") as f:
                n += patrones(cual, paso, f.read())
            c = cuentas.setdefault((cual, que), [0, 0])
            c[0] += 1
            if n:
                c[1] += 1
                mal += 1
                if mal <= 8:
                    print("  %s: %s, %d sprites distintos" % (os.path.basename(ruta), que, n))
    for (cual, que), (n, m) in sorted(cuentas.items()):
        print("escenas %-5s %-6s %4d volcados, %d con diferencias" % (cual, que, n, m))
    esperadas = {("arbol", "anda"), ("arbol", "figura"), ("arbol", "cae"), ("bueno", "anda"),
                 ("bueno", "salta"), ("malo", "anda"), ("malo", "llora")}
    return mal == 0 and esperadas <= set(cuentas)


def main():
    from graficos import Cartucho, IMAGENES, guarda_png
    cart = Cartucho()
    if sys.argv[1:] == ["coteja"]:
        sys.exit(0 if coteja_andando(cart) else 1)
    print(guarda_png(lamina_de_las_escenas(cart), os.path.join(IMAGENES, "escenas.png"), escala=2))
    print(guarda_png(lamina_andando(cart), os.path.join(IMAGENES, "escenas_andando.png"), escala=2))


if __name__ == "__main__":
    main()
