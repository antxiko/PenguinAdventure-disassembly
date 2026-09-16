#!/usr/bin/env python3
"""Que la web no diga una cosa y el listado otra.

En esta serie ya ha pasado: se da otra pasada de comentarios, las cifras del
arbol suben y la portada se queda con las de la semana pasada. Estos tests
comparan las constantes de tools/make_web.py con lo que se cuenta sobre el
listado AHORA, asi que no hay forma de publicar una cifra vieja.
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

import cifras                                                  # noqa: E402
import make_web                                                # noqa: E402
from paginas import N_PAGINAS, TAM_PAGINA                      # noqa: E402

DOCS = os.path.join(RAIZ, "docs")


class CifrasDeLaPortada(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.c = cifras.cuenta()

    def test_la_suma_de_bytes_da_el_cartucho(self):
        self.assertEqual(make_web.CODIGO + make_web.DATOS + make_web.PENDIENTE,
                         TAM_PAGINA * N_PAGINAS)
        self.assertEqual(make_web.TOTAL, TAM_PAGINA * N_PAGINAS)

    def test_las_cifras_de_la_portada_son_las_del_listado(self):
        self.assertEqual(make_web.CODIGO, self.c["codigo"], "codigo trazado")
        self.assertEqual(make_web.DATOS, self.c["datos"], "datos")
        self.assertEqual(make_web.ETIQUETAS, self.c["L"], "etiquetas con nombre")
        self.assertEqual(make_web.INSTRUCCIONES, self.c["instr"], "instrucciones")
        self.assertEqual(make_web.COMENTADAS, self.c["comentadas"], "comentadas")

    def test_ninguna_rutina_por_debajo_del_diez_por_ciento(self):
        """Cerrado a cero el 2026-09-16, y de ahi no se baja.

        Va como igualdad y no como "menos de N" a proposito: en cuanto se
        admite un margen, el margen se llena.
        """
        self.assertEqual(self.c["flojas"], 0)

    def test_la_densidad_no_baja_del_liston(self):
        d = 100.0 * self.c["comentadas"] / self.c["instr"]
        self.assertGreaterEqual(round(d, 1), 40.0,
                                "la densidad ha bajado a %.1f %%" % d)

    def test_la_frase_que_se_publica_dice_la_verdad(self):
        """La portada afirma "ninguna rutina por debajo del 10 %"."""
        for fichero in ("README.md", "README.es.md"):
            with open(os.path.join(RAIZ, fichero), encoding="utf-8") as f:
                texto = f.read()
            self.assertIn("10 %", texto, fichero)
            if self.c["flojas"]:
                self.fail("%s lo afirma y hay %d flojas"
                          % (fichero, self.c["flojas"]))


class LasImagenesQueLaWebNOMBRA(unittest.TestCase):

    def test_estan_todas_las_de_la_galeria(self):
        faltan = [f for f, _es, _en in make_web.GALERIA
                  if not os.path.exists(os.path.join(DOCS, "imagenes", f))]
        self.assertEqual(faltan, [], "faltan de docs/imagenes: %s" % faltan)

    def test_la_cabecera_tiene_su_png(self):
        self.assertTrue(
            os.path.exists(os.path.join(DOCS, "imagenes", "titulo_resto.png")),
            "sin ese PNG la cabecera se cae al texto")

    def test_los_dos_idiomas_tienen_las_mismas_paginas(self):
        pares = (("GETTING-STARTED", "EMPEZAR"), ("THE-GAME", "EL-JUEGO"),
                 ("THE-CARTRIDGE", "EL-CARTUCHO"), ("THE-CODE", "EL-CODIGO"),
                 ("FINDINGS", "HALLAZGOS"),
                 ("IN-THE-EMULATOR", "EN-EL-EMULADOR"),
                 ("OPEN-QUESTIONS", "PREGUNTAS-ABIERTAS"))
        for en, es in pares:
            self.assertTrue(os.path.exists(os.path.join(DOCS, en + ".md")),
                            "falta docs/%s.md" % en)
            self.assertTrue(os.path.exists(os.path.join(DOCS, "es", es + ".md")),
                            "falta docs/es/%s.md" % es)

    def test_las_paginas_en_castellano_suben_un_nivel_para_las_imagenes(self):
        """docs/es/*.md vive un nivel mas abajo: ../imagenes/, no imagenes/."""
        carpeta = os.path.join(DOCS, "es")
        for fn in sorted(os.listdir(carpeta)):
            if not fn.endswith(".md"):
                continue
            with open(os.path.join(carpeta, fn), encoding="utf-8") as f:
                texto = f.read()
            self.assertNotIn("](imagenes/", texto,
                             "%s enlaza imagenes sin subir de carpeta" % fn)


if __name__ == "__main__":
    unittest.main()
