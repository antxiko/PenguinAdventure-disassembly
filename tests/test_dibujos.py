"""Lo que se dibuja desde las tablas: comprobaciones que no necesitan openMSX.

El cotejo contra los volcados esta en tools/coteja.py (make coteja); esto son
los hechos de la ROM en los que se apoyan los dibujos.
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
ROM = os.path.join(RAIZ, "penguinadventure.rom")


class Dibujos(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(
                "falta penguinadventure.rom en la raiz del repo: sin el "
                "cartucho no se puede dibujar nada")
        from graficos import Cartucho
        cls.cart = Cartucho(ROM)

    def test_los_patrones_del_pinguino_los_sube_pinta_bloque(self):
        from sprites import carga_de_la_fase
        li = carga_de_la_fase(self.cart, 1)
        tocados = sum(li.tocado[0x1800:0x18C0])
        self.assertEqual(tocados, 0xC0, "0x8600: tres columnas con espejo, seis sprites")

    def test_el_dinosaurio_cada_tres_fases(self):
        from pantalla import que_final
        self.assertEqual([f for f in range(1, 25) if que_final(f) == "dinosaurio"],
                         [3, 6, 9, 12, 15, 18, 21, 24])

    def test_la_clase_7_mira_lo_que_se_lleva_para_verse(self):
        # p09:B8B3: ld a,(0E16Ah) / and a / ld a,5 / jr nz / xor a
        b = [self.cart.leer(0xB8B3 + i, (7, 8, 9)) for i in range(9)]
        self.assertEqual(b, [0x3A, 0x6A, 0xE1, 0xA7, 0x3E, 0x05, 0x20, 0x01, 0xAF])

    def test_las_primeras_cosas_de_la_fase_1(self):
        from carretera import Carretera
        k = Carretera(self.cart, 1, 0)
        while len(k.salidas) < 10:
            k.paso()
        # medidas en openMSX (p01:6852): la primera a los 0x20 pasos y luego
        # cada 6, del tramo 1 de 0x84EA
        self.assertEqual([(q, t) for q, t, _s, _v in k.salidas],
                         [(0x568, 1), (0x562, 2), (0x556, 1), (0x550, 2), (0x544, 1),
                          (0x538, 2), (0x520, 1), (0x514, 2), (0x508, 1), (0x502, 2)])

    def test_en_el_espacio_solo_salen_meteoritos_y_peces(self):
        b = (1, 10, 11)
        for k in range(10):
            p = self.cart.leer(0x81F2 + 2 * k, b) | (self.cart.leer(0x81F3 + 2 * k, b) << 8)
            for i in range(40):
                v = self.cart.leer(p + i, b)
                self.assertTrue(0x15 <= v <= 0x1F, "lista %d: %02X" % (k, v))

    def test_los_seis_atajos(self):
        # p03:B94A: registro de 17 bytes de 0xB79B por lista; el septimo son
        # las fases que se suman. Medidos en openMSX con PA_GRIETA.
        origen = {0x0A: 1, 0x0B: 6, 0x0C: 9, 0x0D: 13, 0x0E: 15, 0x0F: 18}
        llegada = {k: o + self.cart.leer(0xB79B + 17 * k + 6, (1, 2, 3))
                   for k, o in origen.items()}
        self.assertEqual(llegada, {0x0A: 6, 0x0B: 9, 0x0C: 12, 0x0D: 15,
                                   0x0E: 18, 0x0F: 21})

    def test_la_pantalla_de_la_cueva_se_monta_entera(self):
        from pantalla import monta_la_pantalla
        p = monta_la_pantalla(self.cart, 2)
        self.assertEqual(sum(p.li.tocado[0x3860:0x3B00]), 21 * 32)


if __name__ == "__main__":
    unittest.main()
