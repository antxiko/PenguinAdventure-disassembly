#!/usr/bin/env python3
"""Desensambla un trozo del cartucho, con el banco puesto donde le toca.

Es el atajo para mirar una rutina sin generar el listado entero: se le dice el
banco y el tramo, y saca el z80dasm de esos bytes con el org que ese banco
tiene de verdad (tools/paginas.py). Vale para hurgar, no para publicar: lo que
se publica lo genera tools/mkasm.py a partir del trazado y de las notas.

Uso: desensambla.py <banco> <ini> <fin>   (ini y fin, direcciones de ejecucion)
"""
import os
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from paginas import ORG, TAM_PAGINA                        # noqa: E402


def main():
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    aqui = os.path.dirname(os.path.abspath(__file__))
    rom = open(os.path.join(aqui, "..", "penguinadventure.rom"), "rb").read()
    banco = int(sys.argv[1], 0)
    ini, fin = int(sys.argv[2], 0), int(sys.argv[3], 0)
    o = ORG[banco]
    if not (o <= ini < fin <= o + TAM_PAGINA):
        sys.exit("el banco %d se ejecuta en %#06x..%#06x" % (banco, o,
                                                             o + TAM_PAGINA - 1))
    trabajo = os.path.join(aqui, "..", "work")
    os.makedirs(trabajo, exist_ok=True)
    tmp = os.path.join(trabajo, "_desensambla.bin")
    off = banco * TAM_PAGINA + (ini - o)
    open(tmp, "wb").write(rom[off:off + (fin - ini)])
    # TMP/TEMP saneados: bajo el make de msys llegan como '/tmp', que el CRT
    # nativo de Windows no sabe usar, y z80dasm acaba escribiendo en la raiz.
    r = subprocess.run(["z80dasm", "-a", "-l", "-g", hex(ini), tmp],
                       capture_output=True, text=True,
                       env=dict(os.environ, TMP=trabajo, TEMP=trabajo))
    os.unlink(tmp)
    sys.stdout.write(r.stdout)
    sys.stderr.write(r.stderr)
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
