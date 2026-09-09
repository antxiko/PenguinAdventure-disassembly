#!/usr/bin/env python3
"""Ensena un trozo del listado de un banco.

    python3 tools/ver.py <banco> 0x4629 0x4680     (un rango)
    python3 tools/ver.py <banco> 0x4629 [antes] [despues]

Es para mirar el codigo mientras se comenta, sin sacar medio fichero por la
consola. El banco es 00..15: aqui cada uno tiene su propio listado y su propio
org, asi que la misma direccion sale en varios.
"""
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    banco = sys.argv[1].zfill(2)
    asm = os.path.join(RAIZ, "src", "penguinadventure_p%s.asm" % banco)
    lineas = open(asm, encoding="utf-8").read().splitlines()
    dirs = []
    for i, l in enumerate(lineas):
        m = re.search(r"	;\s?([0-9a-f]{4})(?:\s|$)", l)
        dirs.append((int(m.group(1), 16), i) if m else (None, i))
    a = int(sys.argv[2], 0)
    if len(sys.argv) > 3 and sys.argv[3].startswith("0x"):
        b = int(sys.argv[3], 0)
        ini = next((i for d, i in dirs if d is not None and d >= a), 0)
        fin = next((i for d, i in dirs if d is not None and d >= b), len(lineas))
    else:
        antes = int(sys.argv[3]) if len(sys.argv) > 3 else 6
        despues = int(sys.argv[4]) if len(sys.argv) > 4 else 30
        centro = next((i for d, i in dirs if d is not None and d >= a), 0)
        ini, fin = max(0, centro - antes), min(len(lineas), centro + despues)
    while ini > 0 and re.match(r"^[A-Za-z_][\w]*:", lineas[ini - 1]):
        ini -= 1
    print("\n".join(lineas[ini:fin]))
    return 0


if __name__ == "__main__":
    sys.exit(main())
