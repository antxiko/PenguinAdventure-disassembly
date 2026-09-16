#!/usr/bin/env python3
"""Pone en los dos README las cifras que de verdad hay en el arbol.

Existe porque en esta serie de desensamblados ya ha pasado dos veces que la
portada publicaba una cuenta y el listado tenia otra: se comenta, se anaden
etiquetas, y nadie se acuerda de tocar la tabla del README. Los tests lo cazan
-comparan las dos cifras- pero entonces hay que ir a mano a cuadrarlas. Esto
las cuadra solo.

Lo que actualiza, en README.md y README.es.md, son las filas de la tabla de
"por donde va": codigo trazado, datos identificados, lineas del listado,
puntos de entrada, etiquetas, comentarios, rangos de datos y la DENSIDAD -que
no es una cuenta sino la medida de la serie: cuantas instrucciones llevan
comentario, y que no quede ninguna rutina por debajo del 10 %-.

Si aparece una rutina floja, esto avisa por la consola ANTES de escribir nada,
porque la frase que se publica dice que no hay ninguna y dejaria de ser cierta.

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

# Las dos filas que no son una cuenta sino una MEDIDA, y que hay que escribir
# con su texto entero: la densidad y las rutinas flojas. Se rehacen con la
# misma cuenta que tools/densidad.py, que es la vara de la serie.
MEDIDAS = {
    "README.md": ("commented instructions",
                  "%s of %s (%.1f %%), and no routine under 10 %%"),
    "README.es.md": ("instrucciones comentadas",
                     "%s de %s (%.1f %%), y ninguna rutina por debajo del 10 %%"),
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
    c["instr"], c["comentadas"], c["flojas"] = densidad()
    return c


def densidad():
    """Instrucciones, cuantas llevan comentario y cuantas rutinas flojas.

    La misma cuenta que tools/densidad.py: solo instrucciones de verdad -las
    lineas que llevan su direccion detras del punto y coma-, nunca las filas de
    `defb`, que hundirian el porcentaje sin querer decir nada. Y floja es la
    rutina de SEIS instrucciones o mas que no llega al 10 %: por debajo de seis
    el porcentaje no dice nada, que es el mismo minimo que usa densidad.py.
    """
    MINIMO = 6
    total = comentadas = flojas = 0
    for p in range(N_PAGINAS):
        asm = os.path.join(RAIZ, "src", "penguinadventure_%s.asm" % nombre(p))
        if not os.path.exists(asm):
            continue
        n = c = 0
        with open(asm, encoding="utf-8") as f:
            for ln in f:
                if re.match(r"^[A-Za-z_][A-Za-z_0-9]*:\s*(;.*)?$", ln):
                    if n >= MINIMO and c * 100 // n < 10:
                        flojas += 1
                    n = c = 0
                    continue
                m = re.match(r"^\t.*;([0-9a-f]{4})(.*)$", ln)
                if not m:
                    continue
                n += 1
                if ";" in m.group(2):
                    c += 1
                total += 1
                comentadas += 1 if ";" in m.group(2) else 0
        if n >= MINIMO and c * 100 // n < 10:
            flojas += 1
    return total, comentadas, flojas


def main():
    c = cuenta()
    print("  codigo %d  datos %d  lineas %d  entradas %d  L %d  C %d  D %d"
          % (c["codigo"], c["datos"], c["lineas"], c["entradas"],
             c["L"], c["C"], c["D"]))
    print("  densidad %d de %d = %.1f %%  flojas %d"
          % (c["comentadas"], c["instr"],
             100.0 * c["comentadas"] / c["instr"], c["flojas"]))
    if c["flojas"]:
        print("  OJO: hay %d rutinas por debajo del 10 %%, y las cifras que se"
              " escriben abajo dicen que no hay ninguna" % c["flojas"])
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
        rotulo, plantilla = MEDIDAS[fichero]
        valor = plantilla % (format(c["comentadas"], ",").replace(",", sep),
                             format(c["instr"], ",").replace(",", sep),
                             100.0 * c["comentadas"] / c["instr"])
        texto = re.sub(r"(\|\s*%s\s*\|\s*)[^|]*" % re.escape(rotulo),
                       lambda m, v=valor: m.group(1) + v + " ", texto)
        with open(ruta, "w", encoding="utf-8") as f:
            f.write(texto)
        print("  %s actualizado" % fichero)
    return 0


if __name__ == "__main__":
    sys.exit(main())
