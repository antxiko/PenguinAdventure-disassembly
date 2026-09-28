#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM, y si no esta **fallan**: no se saltan.
Un test que se salta no comprueba nada, y en verde daria la impresion contraria
-la serie ya se llevo ese aviso del analisis forense y tenia razon-. Quien
clone esto sin poner su copia del cartucho vera fallar este fichero con un
mensaje que dice exactamente que falta; el resto de los tests, los que solo
miran el listado publicado, siguen pasando.

Cada una corresponde a una afirmacion de la web o de las notas. No hay ninguna
que compruebe una constante contra la misma constante: todas leen el binario.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, N_PAGINAS               # noqa: E402
import marca_konami                                          # noqa: E402

ROM = os.path.join(RAIZ, "penguinadventure.rom")
SHA = "525608aa990e1a19285edc98dec3f0aa11339d8a17641c89df3966845d10cc6a"

FALTA = ("falta penguinadventure.rom en la raiz del repo. Son los 131.072 "
         "bytes de Penguin Adventure / Yume Tairiku Adventure (Konami, RC-743,"
         " 1986), y no se distribuyen aqui: pon tu copia. El sha256 tiene que "
         "ser %s" % SHA)


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(FALTA)
        with open(ROM, "rb") as f:
            cls.rom = f.read()

    def test_es_la_misma_rom(self):
        self.assertEqual(len(self.rom), 131072)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_ab(self):
        """0x4000 'AB', INIT 0x406A y los otros tres vectores a cero."""
        self.assertEqual(self.rom[0:2], b"AB")
        init = self.rom[2] | (self.rom[3] << 8)
        self.assertEqual(init, 0x406A)
        self.assertEqual(self.rom[4:10], b"\x00" * 6)

    def test_mapper_es_konami4(self):
        """Ni una escritura a los registros del mapper CON SCC.

        Los cuatro de Konami5 son 0x5000, 0x7000, 0x9000 y 0xB000. Se busca el
        `ld (nn),a` -0x32- con cada uno de ellos de operando, en los 128 KB.
        """
        for reg in (0x5000, 0x7000, 0x9000, 0xB000):
            pat = bytes([0x32, reg & 0xFF, reg >> 8])
            self.assertNotIn(pat, self.rom,
                             "aparece un ld (%#06x),a: eso seria Konami5" % reg)
        # y los de Konami4 si estan
        for reg in (0x6000, 0x8000, 0xA000):
            pat = bytes([0x32, reg & 0xFF, reg >> 8])
            self.assertIn(pat, self.rom)

    def test_regla_banco_org(self):
        """Cada banco se mapea SIEMPRE en la misma ranura.

        Se recorren los `ld a,N` / `ld (reg),a` de todo el cartucho -incluido
        el patron de trio `ld a,N / ld (0x6000),a / inc a / ld (0x8000),a /
        inc a / ld (0xA000),a`- y se comprueba que el banco que llega a cada
        registro es de los que tools/paginas.py dice.
        """
        ranura = {0x6000: 0x6000, 0x8000: 0x8000, 0xA000: 0xA000}
        vistos = {}
        for i in range(len(self.rom) - 5):
            if self.rom[i] != 0x3E:                 # ld a,N
                continue
            n = self.rom[i + 1]
            j, val = i + 2, n
            # se sigue la cadena de `ld (reg),a` e `inc a` que viene detras
            while j < len(self.rom) - 2:
                if self.rom[j] == 0x32 and (self.rom[j + 1] |
                                            (self.rom[j + 2] << 8)) in ranura:
                    reg = self.rom[j + 1] | (self.rom[j + 2] << 8)
                    if val < N_PAGINAS:
                        vistos.setdefault(val, set()).add(reg)
                    j += 3
                elif self.rom[j] == 0x3C:           # inc a
                    val += 1
                    j += 1
                else:
                    break
        self.assertTrue(vistos, "no se ha visto ni un cambio de banco")
        for banco, regs in sorted(vistos.items()):
            for reg in regs:
                self.assertEqual(
                    ORG[banco], reg,
                    "el banco %d se mapea en %#06x y paginas.py dice %#06x"
                    % (banco, reg, ORG[banco]))

    def test_marca_oculta_de_konami(self):
        """RC-743 y el titulo japones, al final del banco 3.

        El hallazgo del formato es de Manuel Pazos (@ManuelPazosMSX). Aqui solo
        se comprueba que este cartucho lo lleva y que dice lo que decimos.
        """
        encontradas = marca_konami.busca(self.rom)
        self.assertEqual(len(encontradas), 1, "deberia haber una sola marca")
        fin, rc, n, titulo = encontradas[0]
        self.assertEqual(rc, 0x43)                   # RC-7 + 43
        self.assertEqual(n, 16)
        self.assertEqual(fin - 1, 0x07FFF)           # ultimo byte del banco 3
        leido = " ".join(marca_konami.caracter(v) for v in titulo)
        self.assertEqual(leido, "YU ME TA I RI KU   A TO \" HE \" N TI ya -")

    def test_segunda_cabecera_del_game_master(self):
        """0x4010 = 'CD', y el numero de catalogo repetido en BCD.

        La segunda cabecera que lee el Konami Game Master desde la otra ranura.
        El marcador 'CD' es el de los cartuchos de 1986-87, y los dos bytes que
        van detras son el RC en BCD: 0x07 0x43, o sea RC-743. Es la SEGUNDA vez
        que el cartucho dice su numero, y coincide con la marca escondida al
        final del banco 3.
        """
        self.assertEqual(self.rom[0x10:0x12], b"CD")
        self.assertEqual(self.rom[0x12], 0x07)
        self.assertEqual(self.rom[0x13], 0x43)

    def test_gancho_de_interrupcion(self):
        """INIT engancha 0x4023 en H.KEYI (0xFD9A/0xFD9B).

        `ld a,0xC3 / ld (0xFD9A),a / ld hl,0x4023 / ld (0xFD9B),hl`. Es la
        instruccion por la que el Game Master reconoce a los cartuchos de
        Konami, y aqui ademas fija cual es el manejador.
        """
        pat = bytes([0x3E, 0xC3,                     # ld a,0xC3
                     0x32, 0x9A, 0xFD,               # ld (0xFD9A),a
                     0x21, 0x23, 0x40,               # ld hl,0x4023
                     0x22, 0x9B, 0xFD])              # ld (0xFD9B),hl
        self.assertIn(pat, self.rom[:TAM_PAGINA])

    def test_no_hay_bancos_de_relleno(self):
        """Los 128 KB se usan: ningun banco es 0xFF de punta a punta.

        Nemesis, el otro MegaROM Konami4 de la serie, tiene cuatro bancos
        vacios. Este no tiene ninguno.
        """
        for b in range(N_PAGINAS):
            blq = self.rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
            self.assertNotEqual(blq, b"\xff" * TAM_PAGINA,
                                "el banco %d es todo 0xFF" % b)

    def test_despachador_de_konami(self):
        """El despachador esta en 0x4060 y es el de la casa.

        `pop hl / add a,a / call 0x4056 / ld e,(hl) / inc hl / ld d,(hl) /
        ex de,hl / jp (hl)`: coge la direccion de vuelta como base de la tabla.
        """
        esperado = bytes([0xE1,                      # pop hl
                          0x87,                      # add a,a
                          0xCD, 0x56, 0x40,          # call 0x4056
                          0x5E,                      # ld e,(hl)
                          0x23,                      # inc hl
                          0x56,                      # ld d,(hl)
                          0xEB,                      # ex de,hl
                          0xE9])                     # jp (hl)
        self.assertEqual(self.rom[0x0060:0x0060 + len(esperado)], esperado)


    def test_los_secretos_de_cinco_fases(self):
        """Solo cinco de las veinticuatro tienen algo, y dos son secuencias.

        La tabla de p03:BE4D lleva una entrada por fase y diecinueve apuntan a
        0xBF2B, que es un `ret` pelado. Las cinco con rutina propia son la 6, la
        9, la 13, la 14 y la 16.

        Y las dos secuencias estan en p03:BF2C, en mascaras de los mandos tal
        como los deja p00:44C8: bit 0 arriba, bit 1 abajo, bit 2 izquierda y bit
        3 derecha. La de la fase 14 son dos pasos y la de la 16, cuatro.
        """
        banco3 = 3 * TAM_PAGINA
        def pal(a):
            o = banco3 + (a - 0xA000)
            return self.rom[o] | (self.rom[o + 1] << 8)
        tabla = [pal(0xBE4D + 2 * i) for i in range(24)]
        self.assertEqual(len(tabla), 24)
        con_secreto = {i + 1 for i, d in enumerate(tabla) if d != 0xBF2B}
        self.assertEqual(con_secreto, {6, 9, 13, 14, 16})
        self.assertEqual(tabla[13], 0xBEEC)      # fase 14
        self.assertEqual(tabla[15], 0xBF18)      # fase 16
        o = banco3 + (0xBF2C - 0xA000)
        self.assertEqual(list(self.rom[o:o + 6]), [0x04, 0x08, 0x01, 0x08,
                                                   0x02, 0x04])

    def test_el_secreto_de_la_fase_16_exige_la_pausa(self):
        """0xBF18 mira (0xE0A0) y se va si esta a cero.

        (0xE0A0) es la bandera de pausa: p02:81DD le da la vuelta con la tecla
        de parar. Sin ella, la secuencia de cuatro no cuenta.
        """
        banco3 = 3 * TAM_PAGINA
        o = banco3 + (0xBF18 - 0xA000)
        # ld a,(0xE0A0) / and a / jr z,...
        self.assertEqual(list(self.rom[o:o + 5]),
                         [0x3A, 0xA0, 0xE0, 0xA7, 0x28])
        # y la tecla de pausa que enciende esa bandera esta en el banco 2
        banco2 = 2 * TAM_PAGINA
        p = banco2 + (0x81D2 - 0x8000)
        # ld a,(0xE006) / and 0x80
        self.assertEqual(list(self.rom[p:p + 5]),
                         [0x3A, 0x06, 0xE0, 0xE6, 0x80])

    def test_los_premios_de_los_secretos_son_banderas(self):
        """El numero del premio es la bandera 0xE160 + n, no el articulo.

        0xBE92 mira 0xE160 + n y p03:BA3C apunta en 0xE160 + n sin restar
        nada; la tienda si resta uno antes de llamar a p03:BA2F (p01:6EEA,
        `dec c`). Asi que la fase 6 (0x0D) pone 0xE16D, las botas azules
        (articulo 14), que p03:A889 lee para ir de lado al doble; y la 13
        (0x0E) pone 0xE16E, las botas rojas (articulo 15), que p03:A8BB lee
        para quitar el arrastre. Las fases 6, 13 y 14 piden el anillo
        (0xE167); la 6 cuenta cinco peces y la 13, 0xB4 cuadros contra el
        lado al que empuja la curva (0x1C y 0xC4).
        """
        banco3 = 3 * TAM_PAGINA

        def b3(a, n):
            o = banco3 + (a - 0xA000)
            return list(self.rom[o:o + n])
        premios = {6: 0xBE8D, 9: 0xBEA6, 13: 0xBEC8, 14: 0xBEFE, 16: 0xBF23}
        n = {f: b3(a, 2)[1] for f, a in premios.items() if b3(a, 1) == [0x0E]}
        self.assertEqual(n, {6: 0x0D, 9: 0x11, 13: 0x0E, 14: 0x10, 16: 0x12})
        # ld hl,0xE160 / ld a,c / call a_mas_hl, sin dec
        self.assertEqual(b3(0xBE92, 7), [0x21, 0x60, 0xE1, 0x79, 0xCD, 0x56, 0x40])
        self.assertEqual(b3(0xBA3C, 8), [0x79, 0x21, 0x60, 0xE1, 0xCD, 0x56, 0x40, 0x70])
        # la tienda: ld a,(hl) / ld c,a / dec c / ... / call 0xBA2F
        o = TAM_PAGINA + (0x6EE8 - 0x6000)
        self.assertEqual(list(self.rom[o:o + 8]),
                         [0x7E, 0x4F, 0x0D, 0xC5, 0xE5, 0xCD, 0x2F, 0xBA])
        # quien lee las dos banderas de las botas
        self.assertEqual(b3(0xA889, 3), [0x3A, 0x6D, 0xE1])
        self.assertEqual(b3(0xA8BB, 3), [0x3A, 0x6E, 0xE1])
        # el anillo en las fases 6, 13 y 14
        for a in (0xBE7D, 0xBEC0, 0xBEEC):
            self.assertEqual(b3(a, 3), [0x3A, 0x67, 0xE1])
        # cinco peces (ld bc,5) y 0xB4 cuadros (ld c,0xB4); los topes 0x1C y 0xC4
        self.assertEqual(b3(0xBE23, 3), [0x01, 0x05, 0x00])
        self.assertEqual(b3(0xBE2D, 2), [0x0E, 0xB4])
        self.assertEqual(b3(0xBECF, 2) + b3(0xBED8, 2), [0x16, 0x1C, 0x16, 0xC4])


if __name__ == "__main__":
    unittest.main()
