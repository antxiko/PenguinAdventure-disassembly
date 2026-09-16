#!/usr/bin/env python3
"""Que el repositorio hable de ESTE juego y no del anterior.

El armazon de este desensamblado esta copiado del de Nemesis, que es el otro
MegaROM Konami4 de 128 KB de la serie. Copiar el armazon es lo sensato; lo que
no lo es -y ya ha pasado en la serie, con cinco LICENSE nombrando otro juego y
once repos citando ficheros que no existian- es que se quede el nombre viejo
en algun sitio.

Ninguna de estas comprobaciones necesita el cartucho.
"""
import os
import re
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, N_PAGINAS, nombre                   # noqa: E402

SRC = os.path.join(RAIZ, "src")

# Los demas juegos de la serie. Que el nombre de otro aparezca aqui es casi
# siempre un copia y pega sin barrer.
OTROS_JUEGOS = (
    "Nemesis", "Gradius", "RC-742",
    "Pitfall", "Temptations", "Stardust", "Ale Hop", "Colt 36",
    "Middle Earth", "Monkey Academy", "F-1 Spirit", "Athletic Land",
    "Antarctic", "Pippols", "Frogger", "Time Pilot", "Super Cobra",
    "Billiards", "Mahjong", "Hyper Olympic", "Hyper Sports", "Hyper Rally",
    "Sky Jaguar", "Yie Ar", "Knightmare", "Twin Bee", "Road Fighter",
    "Ping Pong", "Soccer", "Goonies", "Trailblazer",
    "Boxing", "Bomber Man", "King's Valley", "Mopi Ranger", "Baseball",
    "Tennis", "Demonia", "Descubrimiento", "Cabbage Patch", "Casio World",
    "Hole in One", "3D Golf", "Konami's Golf", "Football",
)

# El Konami Game Master (RC-741) NO esta en la lista de arriba, y es a
# proposito: no es un juego de la serie que se haya podido colar copiando, es un
# cartucho con el que ESTE tiene una relacion documentada -le lee la segunda
# cabecera de 0x4010 y le llama a la rutina de 0x40F7-, asi que su nombre sale
# donde tiene que salir y prohibirlo solo obligaria a ir haciendo excepciones.

# Los que SI pueden aparecer, y por que.
PERMITIDO = {
    # tools/marca_konami.py explica de donde salio el caracter 52 del silabario
    # y hay que decir de que cartucho: es la unica forma de justificarlo.
    os.path.join("tools", "marca_konami.py"): ("Nemesis", "RC-742"),
    # tools/bancos.py y el Makefile comparan con el otro MegaROM de la serie.
    os.path.join("tests", "test_repo.py"): OTROS_JUEGOS,
    # test_cartucho.py habla del Konami Game Master porque la segunda
    # cabecera de 0x4010 es SUYA: la lee el cartucho de trucos desde la
    # otra ranura. Y compara con Nemesis lo de los bancos de relleno.
    os.path.join("tests", "test_cartucho.py"): ("Nemesis",),
    os.path.join("src", "datos.txt"): (),
    # Los README nombran Antarctic Adventure porque este juego ES su
    # continuacion: no es un copia y pega, es el dato.
    "README.md": ("Antarctic",),
    "README.es.md": ("Antarctic",),
}

# Y la misma excepcion en las paginas donde la continuacion ES el contenido.
# La excepcion NO es abierta: ademas de estar en esta lista, el fichero tiene
# que llevar en el texto la palabra que la justifica -"continuacion" o
# "sequel"-. Asi, si alguna vez alguien copia un parrafo del juego anterior sin
# esa palabra, el test vuelve a saltar, que es para lo que esta.
PERMITIDO_SI_LO_JUSTIFICA = {
    os.path.join("docs", "THE-GAME.md"): ("Antarctic",),
    os.path.join("docs", "THE-GAME.html"): ("Antarctic",),
    os.path.join("docs", "index.html"): ("Antarctic",),
    os.path.join("docs", "es", "EL-JUEGO.md"): ("Antarctic",),
    os.path.join("docs", "es", "EL-JUEGO.html"): ("Antarctic",),
    os.path.join("docs", "es", "index.html"): ("Antarctic",),
    os.path.join("tools", "make_web.py"): ("Antarctic",),
}
JUSTIFICAN = ("continuaci", "sequel")

EXTENSIONES = (".py", ".md", ".txt", ".html", ".sh", ".tcl", ".notes",
               ".entries", ".nocode", ".yml")
NOMBRES_SUELTOS = ("Makefile", "LICENSE", ".gitignore")


def ficheros_del_repo():
    for base, dirs, ficheros in os.walk(RAIZ):
        dirs[:] = [d for d in dirs
                   if d not in (".git", "work", "dump", "__pycache__",
                                ".forja", ".pytest_cache")]
        for fn in ficheros:
            if fn.endswith(EXTENSIONES) or fn in NOMBRES_SUELTOS:
                yield os.path.join(base, fn)


class NombreDelJuego(unittest.TestCase):

    def test_ningun_fichero_nombra_otro_juego(self):
        malos = []
        for ruta in ficheros_del_repo():
            rel = os.path.relpath(ruta, RAIZ)
            permitidos = PERMITIDO.get(rel, ())
            try:
                texto = open(ruta, encoding="utf-8").read()
            except (UnicodeDecodeError, OSError):
                continue
            justificado = ()
            if any(p in texto.lower() for p in JUSTIFICAN):
                justificado = PERMITIDO_SI_LO_JUSTIFICA.get(rel, ())
            for juego in OTROS_JUEGOS:
                if juego in permitidos or juego in justificado:
                    continue
                if re.search(re.escape(juego), texto, re.IGNORECASE):
                    malos.append("%s nombra a %r" % (rel, juego))
        self.assertEqual(malos, [], "\n".join(malos))

    def test_los_listados_se_llaman_como_el_juego(self):
        for p in range(N_PAGINAS):
            ruta = os.path.join(SRC, "penguinadventure_%s.asm" % nombre(p))
            self.assertTrue(os.path.exists(ruta), "falta %s" % ruta)


class Coherencia(unittest.TestCase):

    def test_el_makefile_y_paginas_py_dicen_lo_mismo(self):
        """La tabla banco -> org esta en dos sitios; tienen que coincidir.

        El Makefile la lleva copiada para no lanzar python 32 veces por cada
        `make`. Si alguien toca una y no la otra, los listados salen con el org
        equivocado y el reensamblado deja de dar la ROM.
        """
        texto = open(os.path.join(RAIZ, "Makefile"), encoding="utf-8").read()
        for p in range(N_PAGINAS):
            m = re.search(r"^ORG_%02d\s*=\s*(0x[0-9a-fA-F]+)\s*$" % p,
                          texto, re.M)
            self.assertIsNotNone(m, "el Makefile no declara ORG_%02d" % p)
            self.assertEqual(int(m.group(1), 16), ORG[p],
                             "ORG_%02d del Makefile no casa con paginas.py" % p)

    def test_los_bancos_de_datos_estan_declarados_enteros(self):
        """Lo que src/datos.txt llama datos, el .nocode lo tapa entero.

        Si no, tools/z80trace.py volveria a entrar a desensamblarlos y saldrian
        otra vez los kilobytes de codigo inventado que costo quitar.
        """
        import bancos
        declarados = bancos.carga_datos(os.path.join(SRC, "datos.txt"))
        self.assertTrue(declarados, "src/datos.txt no declara ningun banco")
        for p, porque in declarados.items():
            self.assertTrue(porque.strip(),
                            "el banco %d se declara datos sin explicar por que" % p)
            ruta = os.path.join(SRC, "%s.nocode" % nombre(p))
            texto = open(ruta, encoding="utf-8").read()
            esperado = "0x%04X 0x%04X" % (ORG[p], ORG[p] + 0x2000)
            self.assertIn(esperado, texto,
                          "%s.nocode no tapa el banco entero" % nombre(p))

    def test_toda_semilla_lleva_su_porque(self):
        """Ninguna entrada de src/semillas.txt sin justificacion escrita."""
        ruta = os.path.join(SRC, "semillas.txt")
        n = 0
        for ln in open(ruta, encoding="utf-8"):
            crudo, _, coment = ln.partition("#")
            if crudo.split():
                n += 1
                self.assertTrue(coment.strip(),
                                "semilla sin porque: %s" % ln.strip())
        self.assertGreater(n, 0, "src/semillas.txt no tiene ninguna semilla")


    def test_ningun_comentario_dice_trece_fases(self):
        """El juego tiene VEINTICUATRO, y esto ya se escribio mal una vez.

        La cifra de trece salia de fiarse de lo que el cartucho le declara al
        Konami Game Master en la cabecera de 0x4010. Lo que dice el juego es
        p02:8328, que sube (0xE092) y la compara con 0x19.
        """
        # Se mira SOLO el texto del comentario, no la linea entera: la propia
        # direccion puede llevar un 13 dentro y no querer decir nada.
        malos = []
        for base, dirs, ficheros in os.walk(SRC):
            for fn in ficheros:
                if not fn.endswith((".notes", ".asm")):
                    continue
                ruta = os.path.join(base, fn)
                for n, ln in enumerate(open(ruta, encoding="utf-8"), 1):
                    if "fase" not in ln.lower():
                        continue
                    texto = ln.split(";")[-1] if ";" in ln else ln
                    if re.search(r"(de )?1 a 13|trece fases", texto, re.I):
                        malos.append("%s:%d %s" % (fn, n, ln.strip()[:90]))
        self.assertEqual(malos, [], chr(10).join(malos))


if __name__ == "__main__":
    unittest.main()
