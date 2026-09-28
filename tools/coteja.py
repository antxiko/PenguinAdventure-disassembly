#!/usr/bin/env python3
"""Coteja lo que se dibuja desde las tablas con los volcados de openMSX.

Los volcados los sacan tools/omsx_fases.tcl y los dos lanzadores de tools/ (openMSX con la maquina C-BIOS_MSX1_EU):

    sh tools/lanza_fases.sh 0 "1 2 ... 24" 7000 150   -> work/fases/n0/fNN/
    sh tools/lanza_fines.sh 0 "1 2 ... 24"            -> work/fines/n0/fNN/

Doce comprobaciones, y todas tienen que dar cero:

  pantalla  la pantalla de cada fase (tools/pantalla.py) contra el primer
            cuadro de juego: tablas de patrones, de colores, de patrones de
            sprite y la tabla de nombres de las filas 3 a 23.
  final     los cortes del final (la meta o el dinosaurio) contra los volcados
            de cada corte: las tablas enteras y las casillas que pone la tira.
            OJO: en el punto de volcado (p00:451C) la tabla de nombres de la
            VRAM va un cuadro por detras del espejo de RAM, asi que las
            casillas se miran en el espejo (0xEBE0).
  jugador   en todo cuadro de juego, los sprites 0 a 3 llevan una pose de la
            tabla de 0xA91D (o la de nadar de p02:9A1D) y estan colocados como
            dice la rutina de cada terreno.
  bichos    cada objeto de las clases que van por distancia lleva el dibujo de
            su clase y su banda (tools/figuras.py).
  espacio   la pantalla del bonus contra sus volcados, cada pez con alas (las
            cosas de sprite 0x1A-0x1F) en el paso que toca de su trayectoria y
            cada meteorito (0x15-0x19) con las casillas de su tira.
  warp      la pantalla del decorado 9 contra la escena del WARP (una
            partida con PA_GRIETA en work/grieta).
  escenas   el arbol y los dos finales (tools/omsx_escenas.tcl, en
            work/escenas): tablas, espejo con los mensajes y sprites fijos.
  cosas     cada cosa que sale en la carretera (el registro de p01:6852 que
            deja la sonda, LEVEL 1 y LEVEL 2) a la distancia y del tipo que
            dice tools/carretera.py. En las que apuntan al jugador vale
            cualquiera de sus variantes: la escoge su columna.
  carretera el espejo de pantalla del motor contra los volcados de cada fase,
            con las variantes que escogio el emulador y sin las casillas de lo
            que pasa por los lados (p01:6AA8 va por cuadros, no por distancia).
  andando   lo que se mueve en las escenas (el pinguino que entra, el salto,
            lo que cae del arbol y el llanto) contra los volcados de
            tools/lanza_escenas.sh, un cuadro de cada dos: sprites y patrones.
  mapa      el mapa de antes de cada fase (tools/mapa.py) contra los volcados
            de tools/lanza_mapas.sh: las 24 fases y siete con atajos.
  pelea     la pelea con el dinosaurio (tools/pelea.py) contra los volcados
            de tools/lanza_pelea.sh (work/pelea): la caida de los bloques, el
            blanco y lo que lanza, la grieta, el agujero y el hundimiento.

Uso:  coteja.py [pantalla|final|jugador|bichos|espacio|cosas|carretera|pelea|andando|mapa ...]
"""
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from graficos import Cartucho, poses_de_lo_que_se_maneja  # noqa: E402
from pantalla import (monta_la_pantalla, monta_el_espacio, final_de_fase,  # noqa: E402
                      anima_el_fondo, compara, que_final, Pantalla)
from figuras import CLASES_POR_DISTANCIA, trayectorias  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORK = os.path.join(RAIZ, "work")


def _lee(ruta):
    with open(ruta, "rb") as f:
        return f.read()


def _volcados(patron):
    return sorted(glob.glob(os.path.join(WORK, patron)))


def pantalla(cart):
    malas = vistas = 0
    for v_ruta in _volcados("fases/n0/f*/*_c00001_e5.vram"):
        v = _lee(v_ruta)
        r = _lee(v_ruta[:-5] + ".ram")
        fase = r[0x92]
        p = monta_la_pantalla(cart, fase, r[0x4C2] & 3)
        toc, dis, _m = compara(p, v, ((0x0000, 0x1800), (0x1800, 0x2000),
                                      (0x2000, 0x3800), (0x3860, 0x3B00)))
        vistas += 1
        if dis:
            malas += 1
            print("  fase %d: %d de %d bytes distintos" % (fase, dis, toc))
    print("pantalla: %d fases, %d con diferencias" % (vistas, malas))
    return malas == 0 and vistas > 0


def final(cart):
    malos = vistos = 0
    for v_ruta in _volcados("fines/n0/f*/f*_fin*.vram"):
        m = re.search(r"f(\d\d)_n0_fin([0-9A-F]{2})_", v_ruta)
        fase, corte = int(m.group(1)), int(m.group(2), 16)
        v = _lee(v_ruta)
        r = _lee(v_ruta[:-5] + ".ram")
        if r[0x92] != fase:
            continue
        paso = r[0x4C2] & 3
        p = monta_la_pantalla(cart, fase, paso)
        # las casillas que ponen las tiras: se sabe mirando que cambia al
        # copiarlas sobre un espejo vacio
        vacio = Pantalla(cart)
        vacio.ram[0xE0A1] = p.ram[0xE0A1]
        antes = bytes(vacio.ram[0xEBE0:0xEE80])
        final_de_fase(vacio, fase, corte)
        tiras = {0xEBE0 + i for i, (a, b) in enumerate(zip(antes, vacio.ram[0xEBE0:0xEE80]))
                 if a != b}
        final_de_fase(p, fase, corte)
        anima_el_fondo(p, p.ram[0xE0A1], paso)
        dt = sum(1 for a in list(range(0, 0x1800)) + list(range(0x2000, 0x3800))
                 if p.li.tocado[a] and p.li.v[a] != v[a])
        de = sum(1 for a in tiras if p.ram[a] != r[a - 0xE000])
        vistos += 1
        if dt or de:
            malos += 1
            print("  fase %d (%s) corte %02X: tablas %d, casillas de la tira %d de %d"
                  % (fase, que_final(fase), corte, dt, de, len(tiras)))
    print("final: %d cortes, %d con diferencias" % (vistos, malos))
    return malos == 0 and vistos > 0


def jugador(cart):
    poses = poses_de_lo_que_se_maneja(cart)
    por_patron = {tuple(pt for pt, _c in p): i for i, p in enumerate(poses)}
    bien = mal = 0
    for r_ruta in _volcados("fases/n0/f*/*.ram"):
        r = _lee(r_ruta)
        if r[0] != 5:
            continue
        at = r[0xE80:0xE90]
        pats = tuple(at[4 * k + 2] for k in range(4))
        if pats == (0, 0, 0, 0):
            continue                          # aun sin pose: el primer cuadro
        y, x = r[0x204], r[0x205]
        pos = [(at[4 * k], at[4 * k + 1]) for k in range(4)]
        d, estado = r[0xA1], r[0x203]
        if estado == 5 and d in (4, 5):       # nadando, p02:9A1D
            ok = (pats[2:] == (0x18, 0x1C) and pats[:2] in ((0x00, 0x04), (0x08, 0x0C))
                  and pos[2][1] == x and pos[3][1] == x + 16
                  and pos[0] == (pos[2][0] - (pos[2][0] - y) + 8, x))
        elif d == 7:                          # bajo el mar, p02:9C3A
            ok = (pats in por_patron and pos[1] == (y, x) and pos[2] == (y, x + 16)
                  and pos[3] == (y + 13, x + 8) and pos[0] == (y + 16, x + 8))
        elif pats in por_patron and estado != 0x19:   # en cuadro, p03:A8DB
            ok = (pos[0] == (y, x) and pos[1] == (y, x + 16)
                  and pos[2] == (y + 16, x) and pos[3] == (y + 16, x + 16))
        else:
            continue                          # otras escenas (la caida en el bonus)
        if ok:
            bien += 1
        else:
            mal += 1
            if mal <= 5:
                print("  %s: d %d estado %02X patrones %s posiciones %s (0x%02X, 0x%02X)"
                      % (os.path.basename(r_ruta), d, estado,
                         " ".join("%02X" % q for q in pats), pos, y, x))
    print("jugador: %d cuadros bien, %d mal" % (bien, mal))
    return mal == 0 and bien > 0


def bichos(cart):
    def banda(x):
        for b, tope in enumerate((0x78, 0x90, 0xA8)):
            if 0x60 <= x < tope:
                return b
        return 3 if x >= 0xA8 else None
    bien = mal = 0
    for r_ruta in _volcados("fases/n0/f*/*.ram") + _volcados("fines/n0/f*/*.ram"):
        r = _lee(r_ruta)
        if r[0] != 5:
            continue
        for k in range(3):
            s = r[0x310 + 0x20 * k:0x330 + 0x20 * k]
            if s[0] not in CLASES_POR_DISTANCIA:
                continue
            x = s[6] | (s[7] << 8)
            if s[0x12]:                   # el dibujo se escogio antes de moverlo
                x = (x - (s[0xC] | (s[0xD] << 8))) & 0xFFFF
            b = banda(x >> 8)
            if b is None:
                continue
            c, aleteo, _pl = CLASES_POR_DISTANCIA[s[0]]
            buenos = ({(c + 2 * b) * 4, (c + 2 * b + 1) * 4} if aleteo
                      else {(c + b) * 4})
            if s[4] in buenos:
                bien += 1
            else:
                mal += 1
    print("bichos: %d objetos bien, %d mal" % (bien, mal))
    return mal == 0 and bien > 0


def espacio(cart):
    tr = trayectorias(cart)
    malas = vistas = bien = mal = 0
    for r_ruta in _volcados("fases/n0/f*/*.ram"):
        r = _lee(r_ruta)
        if r[0xA1] != 8 or r[0] != 5:
            continue
        v = _lee(r_ruta[:-4] + ".vram")
        p = monta_el_espacio(cart, r[0x4C2] & 3)
        _toc, dis, _m = compara(p, v, ((0, 0x1800), (0x1800, 0x2000), (0x2000, 0x3800)))
        vistas += 1
        malas += dis != 0
        for k in range(5):
            ran = r[0x440 + 16 * k:0x450 + 16 * k]
            if not ran[0] or not 0x1A <= ran[1] <= 0x1F or not ran[2]:
                continue
            y0, x0, p0, _c0 = tr[(ran[1] - 0x1A) % 3][ran[2] - 1]
            for base in (0xE80, 0xEA4):
                y, x, pt = r[base + 4 * k:base + 4 * k + 3]
                if y < 0xD0:
                    if (y, x, pt) == (y0, x0, p0):
                        bien += 1
                    else:
                        mal += 1
    b10 = (1, 10, 11)
    met_bien = met_mal = 0
    for r_ruta in _volcados("fases/n0/f*/*.ram") + _volcados("fines/n*/f*/*.ram"):
        r = _lee(r_ruta)
        if r[0xA1] != 8:
            continue
        for k in range(5):
            ran = r[0x440 + 16 * k:0x450 + 16 * k]
            if not (ran[0] and 0x15 <= ran[1] <= 0x19 and ran[2]):
                continue
            q = 0x8682 + 2 * (ran[1] - 1)
            tabla = cart.leer(q, b10) | (cart.leer(q + 1, b10) << 8)
            a = tabla + 2 * (ran[2] - 1)
            vacio = Pantalla(cart)
            vacio.copia_bloques(b10, cart.leer(a, b10) | (cart.leer(a + 1, b10) << 8))
            celdas = [x for x in range(0xEBE0, 0xEE80) if vacio.ram[x]]
            if all(vacio.ram[x] == r[x - 0xE000] for x in celdas):
                met_bien += 1
            else:
                met_mal += 1
    mal += met_mal
    print("espacio: %d pantallas (%d con diferencias), %d peces bien, %d meteoritos bien, %d mal"
          % (vistas, malas, bien, met_bien, mal))
    return malas == 0 and mal == 0 and vistas > 0


def _registro_de_cosas(nivel, fase):
    """[(queda, tipo)] hasta la primera vuelta atras o el primer bonus."""
    fuera = []
    for ruta in _volcados("fines/n%d/f%02d/cosas_*.log" % (nivel, fase)):
        ult = 0x9999
        for linea in open(ruta):
            q, t, _b, _i, modo = linea.split()
            q = int(q, 16)
            if modo != "0" or q > ult:
                break
            ult = q
            fuera.append((q, int(t, 16)))
    return fuera


def cosas(cart):
    from carretera import Carretera
    total = malas = 0
    for nivel in (0, 1):
        for fase in range(1, 25):
            emu = _registro_de_cosas(nivel, fase)
            if not emu:
                continue
            k = Carretera(cart, fase, nivel)
            while k.queda > 0x50 and len(k.salidas) < len(emu):
                k.paso()
            for (q, t), (mq, mt, _s, variantes) in zip(emu, k.salidas):
                total += 1
                if not (q == mq and (t == mt or (variantes and t in variantes))):
                    malas += 1
    print("cosas: %d comparadas, %d distintas" % (total, malas))
    return malas == 0 and total > 0


def carretera(cart):
    from carretera import Carretera
    vistos = malos = 0
    for nivel in (0, 1):
        for fase in range(1, 25):
            elegidas = {}
            for q, t in _registro_de_cosas(nivel, fase):
                elegidas.setdefault(q, []).append(t)
            # por el orden en que se escribieron, y hasta la primera vuelta
            # atras -en las fases 12, 18 y 24, p01:6476 devuelve a una
            # distancia anterior a 0x50 de la meta y lo que sigue es otra
            # pasada- o hasta el primer bonus
            volcados, ult = [], 0x9999
            rutas = sorted(_volcados("fines/n%d/f%02d/*.ram" % (nivel, fase)),
                           key=os.path.getmtime)
            for r_ruta in rutas:
                # las fases 12, 18 y 24 no se acaban sin el objeto de 0xE16C:
                # a 0x50 de la meta el registro de once bytes de p01:6476 las
                # devuelve atras con los indices tal cual, pero no las ranuras
                # ni el ritmo de 0xE401. El volcado del tope de cuadros va por
                # la enesima pasada y no vale para la primera.
                if fase in (12, 18, 24) and "_c60000" in r_ruta:
                    continue
                r = _lee(r_ruta)
                if r[0xA2] or r[0xA1] == 8:
                    break                   # el bonus borra las ranuras (p03:B5E1)
                if r[0] == 5 and r[0x92] == fase:
                    q = r[0x8D] | (r[0x8E] << 8)
                    if q > ult:
                        break
                    ult = q
                    volcados.append((q, r))
            if not volcados:
                continue
            k = Carretera(cart, fase, nivel, elegidas=elegidas)
            lados = k.casillas_de_los_lados()
            for q, r in sorted(volcados, key=lambda t: -t[0]):
                while k.queda > q:
                    k.paso()
                if k.queda != q:
                    continue
                vistos += 1
                dif = sum(1 for a in range(0xEBE0, 0xEE80)
                          if a not in lados and k.p.ram[a] != r[a - 0xE000])
                if dif:
                    malos += 1
                    print("  n%d fase %d a %04X: %d casillas" % (nivel, fase, q, dif))
    print("carretera: %d volcados, %d con diferencias" % (vistos, malos))
    return vistos > 0 and malos == 0


def warp(cart):
    """El decorado 9 contra los volcados de la escena del WARP (una partida
    de tools/omsx_fases.tcl con PA_GRIETA, en work/grieta)."""
    from pantalla import monta_el_warp
    vistas = malas = 0
    for r_ruta in _volcados("grieta/*.ram"):
        r = _lee(r_ruta)
        if r[0xA1] != 9 or r[0] != 5:
            continue
        v = _lee(r_ruta[:-4] + ".vram")
        p = monta_el_warp(cart, r[0x4C2] & 3)
        _t, dis, _m = compara(p, v, ((0, 0x1800), (0x1800, 0x2000), (0x2000, 0x3800)))
        vistas += 1
        malas += dis != 0
    print("warp: %d pantallas, %d con diferencias" % (vistas, malas))
    return vistas > 0 and malas == 0


def _sprites_a_la_vista(r):
    """Los sprites del espejo 0xEE80 que se ven: {numero: (Y, X, patron)}."""
    vistos = {}
    for n in range(32):
        y, x, pt, co = r[0xE80 + 4 * n:0xE84 + 4 * n]
        if y == 0xD0:
            break
        if co & 0x0F and (y < 0xBF or y >= 0xF0):
            vistos[n] = (y, x, pt)
    return vistos


def escenas(cart):
    """El arbol y los dos finales (tools/escenas.py) contra los volcados de
    tools/omsx_escenas.tcl (work/escenas/arbol, bueno y malo): las tablas, el
    espejo de pantalla con los mensajes, y los sprites del panel, que han de
    ser los de un cuadro de verdad del ultimo paso: ni uno de mas ni uno de
    menos a la vista."""
    from escenas import monta_la_escena, sprites_del_panel
    vistas = malas = 0
    for cual, b9 in (("arbol", 2), ("bueno", 0), ("malo", 1)):
        rutas = [r for r in _volcados("escenas/%s/*_6_6_b%d.ram" % (cual, b9))]
        if not rutas:
            continue
        r = _lee(rutas[-1])                      # el ultimo: todo pintado
        v = _lee(rutas[-1][:-4] + ".vram")
        p = monta_la_escena(cart, cual)
        _t, dis, _m = compara(p, v, ((0, 0x1800), (0x2000, 0x3800)))
        esp = sum(1 for a in range(0xEBE0, 0xEE80) if p.ram[a] != r[a - 0xE000])
        panel = {(n, (y - 1, x, pt)) for n, y, x, pt, co in sprites_del_panel(cart, cual) if co}
        del_paso = [f for f in map(_lee, rutas) if f[0xB7] == r[0xB7]]
        spr = min(len(panel ^ set(_sprites_a_la_vista(f).items())) for f in del_paso)
        vistas += 1
        if dis or esp or spr:
            malas += 1
            print("  %s: tablas %d, espejo %d, sprites %d" % (cual, dis, esp, spr))
    print("escenas: %d, %d con diferencias" % (vistas, malas))
    return vistas == 3 and malas == 0


def andando(cart):
    """Lo que se mueve en las escenas: tools/escenas.py contra
    work/escenas_en_marcha (tools/lanza_escenas.sh)."""
    from escenas import coteja_andando
    return coteja_andando(cart)


def mapa(cart):
    """El mapa de antes de cada fase: tools/mapa.py contra work/mapas."""
    from mapa import coteja
    return coteja(cart)


def pelea(cart):
    """La pelea con el dinosaurio: tools/pelea.py contra work/pelea."""
    from pelea import coteja
    return coteja(cart)


PRUEBAS = {"pantalla": pantalla, "warp": warp, "escenas": escenas, "final": final, "jugador": jugador,
           "bichos": bichos, "espacio": espacio, "cosas": cosas,
           "carretera": carretera, "pelea": pelea, "andando": andando, "mapa": mapa}


def main():
    cart = Cartucho()
    cuales = sys.argv[1:] or list(PRUEBAS)
    todo = True
    for c in cuales:
        todo &= PRUEBAS[c](cart)
    print("VERDE" if todo else "ROJO")
    sys.exit(0 if todo else 1)


if __name__ == "__main__":
    main()
