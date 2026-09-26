#!/usr/bin/env python3
"""La carretera de una fase, paso a paso, desde sus tablas.

Todo lo que sale en la carretera sale de tablas y va al paso: 0xE08D baja uno
(en BCD) cada vez que se anda, y con cada paso, por este orden -el del cuadro
de p00:4557-:

  p01:66DA  el segundo guion, las CURVAS: entradas de tres bytes (distancia
            y valor de 0xE0A6) desde 0xADE8 (banco 13), una lista por fase.
  p01:6507  el paso: si el byte bajo de 0xE08D llega a 00, byte de terreno
            nuevo (p01:6737: 0x8000 o 0x80F9 segun el LEVEL, una tira por
            fase); y 0xE401 baja uno.
  p01:6539  la animacion del fondo (0xE4C2), y la de la curva si la hay
            (0xA613 o 0xA627 del banco 13).
  p01:6799  si 0xE401 ha llegado a cero, sale una COSA: la siguiente de las
            ocho del tramo (0x84EA + 8 x byte), y 0xE401 vuelve a 6. Desde 0x50
            de la meta (0xE0A5) ya no sale nada.
  p01:68CA  las cinco ranuras de 0xE440: cada cosa de caracteres (tipos 1 a
            0x19) tiene dieciseis dibujos (0x8682, banco 10) y en cada paso se
            borra el anterior con unos (p00:41AD) y se pinta el siguiente
            (p00:41BF). Al decimosexto, la ranura se libera.
  p01:6AA8  lo que pasa por los lados de la carretera: dos o cuatro tiras de
            diez pasos (0xA420, banco 11) segun el decorado, una de cada dos
            veces.

Y un cuarto guion, el de los AVISOS (0xB046, banco 13: distancia, 0xE0B1 y
0xE0B2 por entrada; p01:6370): al llegar a su distancia, p03:B8AB marca la
siguiente cosa que salga (0xE0B3) y esa sale como grieta -0x0A, 0x0B o, con
un 2, la 0x2F que apunta al jugador- y se lleva los dos bytes: son las grietas
que llevan a otro sitio (p01:734B, y p02:99A2 si se pulsa abajo dentro).

Las cosas 0x27-0x2F apuntan al jugador (p01:6888: la de un lado o la del otro
segun su columna) y las de 0x30 en adelante son dos a la vez (p01:68BB).
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from pantalla import monta_la_pantalla, sube_el_mapa  # noqa: E402

B10 = (1, 10, 11)
B13 = (1, 12, 13)
DATOS_DE_FASE = 0xACBA
TERRENO = {0: 0x8000, 1: 0x80F9}
TRAMOS = 0x84EA
APUNTAN = 0x84A0
DOBLES = 0x84B2
DIBUJOS_DE_COSA = 0x8682
SEGUNDO_GUION = 0xADE8
LADOS = 0xA420
AVISOS = 0xB046
PRIMER_BICHO = 0xAC8A        # banco 13, la distancia del primero de cada fase
GUION_DE_BICHOS = 0xA8FB     # banco 9: (clase, cuanto andar hasta el siguiente)
B9 = (7, 8, 9)
ANIMACION = 0x8000
CURVAS = {1: 0xA613, 2: 0xA627}


def bcd_menos_uno(v):
    lo, hi = v & 0xFF, v >> 8
    lo -= 1
    if lo & 0x0F == 0x0F:
        lo -= 6
    if lo < 0:
        lo = 0x99
        hi -= 1
        if hi & 0x0F == 0x0F:
            hi -= 6
        hi &= 0xFF
    return (hi << 8) | (lo & 0xFF)


def bcd_resta(v, d):
    """p09:A886: v - d en BCD, con el acarreo al byte alto."""
    r = bcd_a_int(v) - bcd_a_int(d)
    return int(str(r), 16) if r >= 0 else 0


def bcd_a_int(v):
    return int("%X" % v)


class Carretera:
    def __init__(self, cart, fase, nivel=0, x_jugador=0x70, elegidas=None):
        """`elegidas`, para cotejar: {queda: [tipos]} con lo que salio de
        verdad donde la cosa depende de la columna del jugador."""
        self.elegidas = elegidas or {}
        self.cart = cart
        self.fase = fase
        self.x = x_jugador
        self.p = monta_la_pantalla(cart, fase, paso=1)
        self.d = self.p.ram[0xE0A1]
        e = DATOS_DE_FASE + (fase - 1) * 4
        self.largo = cart.leer(e + 2, B13) | (cart.leer(e + 3, B13) << 8)
        self.queda = self.largo
        # p01:6737 al montar: el primer byte de terreno
        self.tira = self._palabra(TERRENO[nivel] + 2 * (fase - 1), B10)
        self.e404 = 0
        self._byte_de_terreno()
        self.e401, self.e400 = 0x20, 6          # p01:62BC
        self.e4c2 = 1                           # el paso de p01:6539 al montar
        self.e0a5 = 0
        self.ranuras = [None] * 5               # [tipo, paso]
        self.salidas = []                       # (queda, tipo, secreto, variantes)
        self._posibles = None
        # p01:66ED con A = 0: la primera curva
        self.guion2 = self._palabra(SEGUNDO_GUION + 2 * (fase - 1), B13)
        self.e0a9 = 0
        self._curva(0)
        # p01:6370: el primer aviso
        self.e0b6 = 0
        self.e0b3 = self.e0ba = 0
        self._aviso()
        # p01:643F y p09:A83F: el guion de los bichos
        self.e301 = self._palabra(PRIMER_BICHO + 2 * (fase - 1), B13)
        self.guion_b = self._palabra(GUION_DE_BICHOS + 2 * (fase - 1), B9)
        self.e300 = 0
        self.bichos = []                        # (queda, clase) de cada uno
        # los cortes del final (pantalla.final_de_fase, de uno en uno)
        self.cortes_hechos = []
        # p01:6AA8: los lados
        self.n_lados = {0: 4, 2: 4, 4: 4, 1: 2, 3: 2}.get(self.d, 0)
        self.con_lados = False
        self.e405 = 0
        self.e409 = [0] * 4

    def _palabra(self, a, b):
        return self.cart.leer(a, b) | (self.cart.leer(a + 1, b) << 8)

    def _byte_de_terreno(self):
        self.e402 = self.cart.leer(self.tira + self.e404, B10)
        self.e404 += 1
        self.e403 = 0

    def _aviso(self):
        t = self._palabra(AVISOS + 2 * (self.fase - 1), B13)
        a = t + 4 * self.e0b6
        self.e0af = self._palabra(a, B13)
        self.e0b1 = self.cart.leer(a + 2, B13)
        self.e0b2 = self.cart.leer(a + 3, B13)

    def _curva(self, n):
        a = self.guion2 + 3 * n
        self.e0a7 = self._palabra(a, B13)
        self.e0a6 = self.cart.leer(a + 2, B13)

    def paso(self):
        p = self.p
        # p01:66DA: la curva, con lo que quedaba antes de andar
        if self.queda == self.e0a7:
            self.e0a9 += 1
            self._curva(self.e0a9)
        # p01:6507
        self.queda = bcd_menos_uno(self.queda)
        if self.queda & 0xFF == 0:
            self._byte_de_terreno()
        self.e401 = (self.e401 - 1) & 0xFF
        if self.queda == 0x50:
            self.e0a5 = 1
        # p01:6539
        self.e4c2 = (self.e4c2 + 1) & 0xFF
        t = self._palabra(ANIMACION + 2 * self.d, B13)
        p.copia_bloques(B13, self._palabra(t + 2 * (self.e4c2 & 3), B13))
        if self.e0a6:
            t = self._palabra(CURVAS[1 if self.e0a6 == 1 else 2] + 2 * self.d, B13)
            p.copia_bloques(B13, self._palabra(t + 2 * (self.e4c2 & 3), B13))
        # p01:6799
        if not self.e0a5 and self.e401 == 0:
            self.e401 = self.e400
            c = self.cart.leer(TRAMOS + 8 * self.e402 + self.e403, B10)
            self.e403 = (self.e403 + 1) & 7
            if c:
                if self.e0b3:                       # p01:680E: el aviso manda
                    c = 0x2F if self.e0b3 == 2 else (0x0A if not self.e0b3 & 0xF0 else 0x0B)
                self._posibles = self._alternativas(c)
                tipos = self._resuelve(c)
                if self._posibles and self.queda in self.elegidas:
                    tipos = [t for t in self.elegidas[self.queda] if t in self._posibles][:1] or tipos
                for t in tipos:
                    self._mete(t)
        # p01:68CA: primero se borra todo y luego se pinta todo
        for r in self.ranuras:
            if r and r[0] < 0x1A:
                t = self._palabra(DIBUJOS_DE_COSA + 2 * (r[0] - 1), B10)
                viejo = r[1]
                r[1] += 1
                if viejo:
                    self._rellena(self._palabra(t + 2 * (viejo - 1), B10))
        for i, r in enumerate(self.ranuras):
            if r and r[0] < 0x1A and r[1] > 0x10:
                self.ranuras[i] = None
        for r in self.ranuras:
            if r and r[0] < 0x1A:
                t = self._palabra(DIBUJOS_DE_COSA + 2 * (r[0] - 1), B10)
                p.copia_bloques(B10, self._palabra(t + 2 * (r[1] - 1), B10))
            elif r:                               # las de sprite solo avanzan
                r[1] += 1
                if r[1] > 0x10:
                    self.ranuras[self.ranuras.index(r)] = None
        # p01:65CF: los cortes del final
        if self.queda in (0x30, 0x25, 0x20, 0x15, 0x10, 0x08, 0x05, 0x02, 0x00):
            from pantalla import aplica_el_corte
            aplica_el_corte(self.p, self.fase, self.queda)
            self.cortes_hechos.append(self.queda)
        # p09:A83F: el bicho que toque (en el segundo trio del cuadro)
        if self.queda == self.e301:
            a = self.guion_b + 2 * self.e300
            clase = self.cart.leer(a, B9)
            self.e300 += 1
            if clase:
                self.bichos.append((self.queda, clase))
            d = self.cart.leer(a + 1, B9)
            if d == 0xFF:
                self.e301 = 0xFFFF
            else:
                self.e301 = bcd_resta(self.queda, d)
        # p03:B8AB: el aviso, al final del cuadro
        if self.e0af != 0xFFFF and self.queda == self.e0af:
            self.e0b6 += 1
            self.e0b3, self.e0ba = self.e0b2, self.e0b1
            self._aviso()
        # p01:6AA8: los lados, uno de cada dos pasos (solo si se pide: no va
        # por distancia)
        if self.n_lados and self.con_lados:
            self.e405 = (self.e405 + 1) & 0xFF
            if self.e405 & 1:
                for k in range(self.n_lados - 1, -1, -1):
                    tabla = self._palabra(LADOS + 2 * k, B10)
                    viejo = self.e409[k]
                    self.e409[k] = (viejo + 1) % 10
                    if viejo:
                        self._rellena(self._palabra(tabla + 2 * (viejo - 1), B10))
                for k in range(self.n_lados - 1, -1, -1):
                    tabla = self._palabra(LADOS + 2 * k, B10)
                    if self.e409[k]:
                        p.copia_bloques(B10, self._palabra(tabla + 2 * (self.e409[k] - 1), B10))

    def _resuelve(self, c):
        if c >= 0x30:                               # p01:68BB, dos cosas
            a = DOBLES + 2 * (c - 0x30)
            return [self.cart.leer(a, B10), self.cart.leer(a + 1, B10)]
        if c >= 0x27:                               # p01:6888, apuntan al jugador
            a = APUNTAN + 2 * (c - 0x27)
            c1, e = self.cart.leer(a, B10), self.cart.leer(a + 1, B10)
            if c1 in (4, 0x0F):
                return [c1 if self.x < 0x50 else (c1 - 1 if self.x < 0xA0 else e)]
            return [c1 if self.x < 0x70 else e]
        return [c]

    def _alternativas(self, c):
        """Las que pueden salir de verdad: las que apuntan dependen de donde
        este el jugador, y cualquiera de sus variantes vale."""
        if 0x27 <= c < 0x30:
            a = APUNTAN + 2 * (c - 0x27)
            c1, e = self.cart.leer(a, B10), self.cart.leer(a + 1, B10)
            return {c1, e, c1 - 1} if c1 in (4, 0x0F) else {c1, e}
        return None

    def _mete(self, t):
        if not t:
            return
        for i in range(5):
            if self.ranuras[i] is None:
                self.ranuras[i] = [t, 0]
                secreto = None
                if 0x0A <= t <= 0x0D and (self.e0b3 or self.e0ba):   # p01:686D
                    secreto = (self.e0b3 & 0x0F, self.e0ba)
                    self.e0b3 = self.e0ba = 0
                self.salidas.append((self.queda, t, secreto, self._posibles))
                return

    def _rellena(self, hl):
        """p00:41AD: la misma forma de tira, pero lo que cae es un 1."""
        cart = self.cart
        de = cart.leer(hl, B10) | (cart.leer(hl + 1, B10) << 8)
        hl += 2
        while True:
            b = cart.leer(hl, B10)
            if b == 0xFF:
                return
            if b == 0xFE:
                de = cart.leer(hl + 1, B10) | (cart.leer(hl + 2, B10) << 8)
                hl += 3
                continue
            self.p.ram[de & 0xFFFF] = 1
            de += 1
            hl += 1

    def casillas_de_los_lados(self):
        """Todas las casillas que puede tocar p01:6AA8 en este decorado: esa
        animacion va por cuadros con la barra clavada, no por distancia, y no
        se puede reconstruir desde lo andado."""
        fuera = set()
        for k in range(self.n_lados):
            tabla = self._palabra(LADOS + 2 * k, B10)
            for paso in range(9):
                hl = self._palabra(tabla + 2 * paso, B10)
                de = self._palabra(hl, B10)
                hl += 2
                while True:
                    b = self.cart.leer(hl, B10)
                    if b == 0xFF:
                        break
                    if b == 0xFE:
                        de = self._palabra(hl + 1, B10)
                        hl += 3
                        continue
                    fuera.add(de)
                    de += 1
                    hl += 1
        return fuera

    def anda_hasta(self, queda):
        while self.queda != queda and self.queda != 0:
            self.paso()
        sube_el_mapa(self.p)
        return self.p
