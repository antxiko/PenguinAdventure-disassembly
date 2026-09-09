#!/usr/bin/env python3
"""Pone en los dos README las cifras que de verdad hay en el arbol.

Existe porque en esta serie de desensamblados ya ha pasado dos veces que la
portada publicaba una cuenta y el listado tenia otra: se comenta, se anaden
etiquetas, y nadie se acuerda de tocar la tabla del README. Los tests lo cazan
-comparan las dos cifras- pero entonces hay que ir a mano a cuadrarlas. Esto
las cuadra solo.

Lo que actualiza, en README.md y README.es.md, son las filas de la tabla de
"por donde va": codigo trazado, datos identificados, lineas del listado,
puntos de entrada, etiquetas, comentarios y rangos de datos.

Uso: cifras.py            escribe las cifras en los dos README
     cifras.py --mira     solo las imprime
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from paginas import N_PAGINAS, TAM_PAGINA, nombre                # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOTAL = TAM_PAGINA * N_PAGINAS

FILAS = {
    "README.md": (",", (("traced code", "codigo"),
                        ("identified data", "datos"),
                        ("listing", "lineas"),
                        ("entry points, each with its justification", "entradas"),
                        ("named labels", "L"),
                        ("anchored comments", "C"),
                        ("explained data ranges", "D"))),
    "README.es.md": (".", (("código trazado", "codigo"),
                           ("datos identificados", "datos"),
                           ("listado", "lineas"),
                           ("puntos de entrada, cada uno con su justificación",
                            "entradas"),
                           ("etiquetas con nombre", "L"),
                           ("comentarios anclados", "C"),
                           ("rangos de datos con explicación", "D"))),
}


def cuenta():
    c = {"L": 0, "C": 0, "D": 0, "codigo": 0, "lineas": 0, "entradas": 0}
    for p in range(N_PAGINAS):
        with open(os.path.join(RAIZ, "src", nombre(p) + ".notes"),
                  encoding="utf-8") as f:
            for ln in f:
                if ln[:2] in ("L ", "C ", "D "):
                    c[ln[0]] += 1
        traza = os.path.join(RAIZ, "work", nombre(p) + ".trace.json")
        if os.path.exists(traza):
            with open(traza, encoding="utf-8") as f:
                c["codigo"] += json.load(f)["report"]["code_bytes"]
        asm = os.path.join(RAIZ, "src", "penguinadventure_%s.asm" % nombre(p))
        if os.path.exists(asm):
            with open(asm, encoding="utf-8") as f:
                c["lineas"] += len(f.read().splitlines())
        with open(os.path.join(RAIZ, "src", nombre(p) + ".entries"),
                  encoding="utf-8") as f:
            c["entradas"] += sum(1 for ln in f
                                 if ln.strip() and not ln.lstrip().startswith("#"))
    c["datos"] = TOTAL - c["codigo"]
    return c


def main():
    c = cuenta()
    print("  codigo %d  datos %d  lineas %d  entradas %d  L %d  C %d  D %d"
          % (c["codigo"], c["datos"], c["lineas"], c["entradas"],
             c["L"], c["C"], c["D"]))
    if "--mira" in sys.argv:
        return 0
    for fichero, (sep, filas) in FILAS.items():
        ruta = os.path.join(RAIZ, fichero)
        if not os.path.exists(ruta):
            continue
        with open(ruta, encoding="utf-8") as f:
            texto = f.read()
        for rotulo, clave in filas:
            valor = format(c[clave], ",").replace(",", sep)
            texto = re.sub(r"(\|\s*%s\s*\|\s*)[0-9.,]+" % re.escape(rotulo),
                           lambda m, v=valor: m.group(1) + v, texto)
        with open(ruta, "w", encoding="utf-8") as f:
            f.write(texto)
        print("  %s actualizado" % fichero)
    return 0


if __name__ == "__main__":
    sys.exit(main())
