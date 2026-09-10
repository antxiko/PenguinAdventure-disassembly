#!/usr/bin/env python3
"""Las imagenes de la web salen de la ROM, y siguen saliendo iguales.

No comprueban que la imagen sea BONITA -eso hay que mirarlo con los ojos-, sino
que el motor de tools/graficos.py sigue produciendo exactamente los mismos
bytes. Si alguien toca el descompresor o el pintor y una imagen cambia, esto se
pone rojo y hay que volver a mirar el PNG antes de dar nada por bueno.

Necesitan la ROM: sin ella fallan, no se saltan.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

import graficos                                              # noqa: E402

ROM = os.path.join(RAIZ, "penguinadventure.rom")
IMAGENES = os.path.join(RAIZ, "docs", "imagenes")

def firma(li):
    """Los 16 KB de VRAM montados, resumidos."""
    return hashlib.sha256(bytes(li.v)).hexdigest()


class Imagenes(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(
                "falta penguinadventure.rom en la raiz del repo: sin el "
                "cartucho no se puede dibujar nada")
        cls.cart = graficos.Cartucho()

    def test_las_dos_pantallas_de_titulo_son_distintas(self):
        """El mismo cartucho lleva DOS titulos, y elige por el pais.

        p00:5C44 lee (0x002B) -el byte de pais de la BIOS-, se queda con el
        nibble de abajo y solo pinta el guion 0xA463 si NO es cero. Con el sale
        PENGUIN ADVENTURE; sin el, el titulo japones. Si las dos firmas
        salieran iguales seria que el guion de mas no esta haciendo nada.
        """
        jap = firma(graficos.titulo(self.cart, False))
        res = firma(graficos.titulo(self.cart, True))
        self.assertNotEqual(jap, res)

    def test_el_guion_de_mas_solo_toca_el_rotulo(self):
        """0xA463 pinta encima, no monta otra pantalla.

        Se comprueba contando cuantos de los 16 KB de VRAM cambian entre las
        dos versiones: si fueran muchos, seria otra pantalla entera y no un
        rotulo.
        """
        a = graficos.titulo(self.cart, False).v
        b = graficos.titulo(self.cart, True).v
        distintos = sum(1 for x, y in zip(a, b) if x != y)
        self.assertGreater(distintos, 0)
        self.assertLess(distintos, 0x0C00,
                        "cambian %d bytes: eso no es solo el rotulo" % distintos)

    def test_los_diez_decorados_se_montan(self):
        """Los diez que despacha p01:6000, y ninguno sale en blanco."""
        vistos = {}
        for n in sorted(graficos.GUION_DE_NOMBRES):
            li = graficos.decorado(self.cart, n)
            tocado = sum(li.tocado)
            self.assertGreater(tocado, 0x800,
                               "el decorado %d apenas toca la VRAM" % n)
            # la tabla de nombres tiene que quedar llena de la fila 3 a la 23
            self.assertTrue(all(li.tocado[a] for a in range(0x3860, 0x3B00)),
                            "al decorado %d le faltan filas de pantalla" % n)
            vistos[n] = firma(li)
        # EL 9 ES EL 6 REPINTADO. p01:6000 manda los dos a p01:614D, o sea el
        # mismo guion de nombres, y en las tres tablas de diez bytes las dos
        # entradas llevan los MISMOS guiones de patrones (0x7360, 0x7396,
        # 0x758A, 0x75A3, 0x7842, 0x7848) y distintos de color. El resultado es
        # el mismo decorado con otra paleta.
        seis = graficos.decorado(self.cart, 6)
        nueve = graficos.decorado(self.cart, 9)
        self.assertEqual(bytes(seis.v[0x3800:0x3B00]),
                         bytes(nueve.v[0x3800:0x3B00]),
                         "misma tabla de nombres")
        self.assertEqual(bytes(seis.v[0x2000:0x3800]),
                         bytes(nueve.v[0x2000:0x3800]),
                         "mismos patrones: el 9 es el 6 con otros colores")
        self.assertNotEqual(bytes(seis.v[0x0000:0x1800]),
                            bytes(nueve.v[0x0000:0x1800]),
                            "y lo unico que cambia son los colores")
        self.assertEqual(len(set(vistos.values())), 10,
                         "los diez decorados tienen que salir distintos entre si")

    def test_los_png_estan_y_no_son_de_un_color(self):
        """Que el fichero exista y tenga mas de un color en la pantalla."""
        for nom in ("titulo_japon", "titulo_resto"):
            ruta = os.path.join(IMAGENES, nom + ".png")
            self.assertTrue(os.path.exists(ruta), "falta %s" % ruta)
            self.assertGreater(os.path.getsize(ruta), 1000)
        li = graficos.titulo(self.cart, True)
        img = graficos.pinta_pantalla(li)
        colores = {v for f in img for v in f}
        self.assertGreater(len(colores), 4,
                           "la pantalla de titulo sale con %d colores"
                           % len(colores))

    def test_el_descompresor_cierra_los_guiones(self):
        """Cada guion de nombres cae dentro de 0xEBE0-0xEE7F, y los huecos que
        deja son los que tienen que ser.

        Esos 672 bytes son veintiuna filas de treinta y dos, o sea la zona de
        juego de la fila 3 a la 23, que es justo lo que p00:4265 sube a la
        VRAM. Ocho de los diez guiones la llenan entera. Los otros dos dejan
        hueco a proposito, y el hueco dice que clase de decorado es:

        - 0x8EE9 (decorado 4) deja 32 bytes seguidos, o sea una FILA entera,
          en 0xECA0-0xECBF. Una fila heredada.
        - 0xA314 (decorado 8, la Tierra vista desde el espacio) deja 59 bytes
          repartidos en once huecos pequenos y ni siquiera llega al final:
          para en 0xEE7B. No esta pintando una pantalla, esta pintando un
          dibujo ENCIMA de lo que ya hubiera, y lo que se cuela por los huecos
          son las estrellas.

        Que la cuenta cierre asi, y no de cualquier manera, es lo que dice que
        el formato esta bien leido.
        """
        huecos = {}
        for n, guion in sorted(graficos.GUION_DE_NOMBRES.items()):
            ram = bytearray(0x10000)
            tramos = graficos.descomprime(self.cart, (1, 12, 13), guion, ram)
            for i, f in tramos:
                self.assertGreaterEqual(i, 0xEBE0, "el guion %04X se sale por "
                                        "abajo" % guion)
                self.assertLessEqual(f, 0xEE80, "el guion %04X se sale por "
                                     "arriba" % guion)
            self.assertEqual(tramos[0][0], 0xEBE0,
                             "el guion %04X no empieza en 0xEBE0" % guion)
            huecos[guion] = 672 - sum(f - i for i, f in tramos)

        # Son SIETE y no ocho porque los decorados 6 y 9 comparten guion
        # (0x9735): diez decorados, nueve guiones distintos, y de esos nueve
        # dos dejan hueco.
        llenos = {g for g, h in huecos.items() if h == 0}
        self.assertEqual(len(huecos), 9, "tendrian que ser nueve guiones "
                         "distintos para diez decorados")
        self.assertEqual(len(llenos), 7,
                         "tendrian que ser siete los guiones que llenan la "
                         "zona de juego entera, y son %d" % len(llenos))
        self.assertEqual(huecos[0x8EE9], 32)
        self.assertEqual(huecos[0xA314], 59)

    def test_la_fila_que_hereda_el_decorado_4(self):
        """El hueco de 0x8EE9 mide una fila justa y esta donde se dice."""
        ram = bytearray(0x10000)
        tramos = graficos.descomprime(self.cart, (1, 12, 13), 0x8EE9, ram)
        self.assertEqual(tramos, [(0xEBE0, 0xECA0), (0xECC0, 0xEE80)])


    def test_los_guiones_de_sprite_tocan_la_zona_de_sprites(self):
        """Los diecinueve pintan dentro de 0x1800-0x1FFF y en ningun otro sitio.

        Si alguno se saliera de ahi seria que la lista de
        graficos.GUIONES_DE_SPRITE tiene metido un guion que no es de sprites,
        y la hoja saldria en blanco sin que nadie se enterase.
        """
        self.assertEqual(len(graficos.GUIONES_DE_SPRITE), 19)
        for guion in graficos.GUIONES_DE_SPRITE:
            li = graficos.Lienzo()
            graficos.pinta(self.cart, (7, 8, 9), guion, li)
            r = li.rangos()
            self.assertTrue(r, "el guion %04X no pinta nada" % guion)
            dentro = sum(f - i for i, f in r
                         if i >= graficos.SPRITES_PAT and f <= 0x2000)
            total = sum(f - i for i, f in r)
            self.assertGreater(dentro, 0,
                               "el guion %04X no toca la zona de sprites" % guion)
            # 0x9846 es el de la portada y ademas pinta la pantalla entera; los
            # otros dieciocho son solo de sprites.
            if guion != 0x9846:
                self.assertEqual(dentro, total,
                                 "el guion %04X pinta %d bytes fuera de la "
                                 "zona de sprites" % (guion, total - dentro))

    def test_la_hoja_empareja_desde_el_primer_sprite(self):
        """Las capas se emparejan desde donde empieza el guion, no desde cero.

        Es lo que hace que las figuras salgan enteras: el guion 0x7FBC empieza
        en 0x19A0, que es el sprite 13, asi que las parejas son (13,14),
        (15,16)... Si se emparejara desde el 0 saldrian partidas por la mitad.
        """
        li = graficos.Lienzo()
        graficos.pinta(self.cart, (7, 8, 9), 0x7FBC, li)
        primero = next((a - graficos.SPRITES_PAT) // 32
                       for a in range(graficos.SPRITES_PAT, 0x2000)
                       if li.tocado[a])
        self.assertEqual(primero, 13)
        img = graficos.hoja_de_sprites(li)
        pintados = sum(1 for f in img for v in f if v != 1)
        self.assertGreater(pintados, 2000,
                           "la hoja de 0x7FBC sale casi vacia")


if __name__ == "__main__":
    unittest.main()
