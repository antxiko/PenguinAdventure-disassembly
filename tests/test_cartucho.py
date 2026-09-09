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


if __name__ == "__main__":
    unittest.main()
