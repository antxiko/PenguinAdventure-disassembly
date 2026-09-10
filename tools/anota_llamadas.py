#!/usr/bin/env python3
"""Pone nombre a las llamadas al banco 0, que se hacen desde todas partes.

El banco 0 esta FIJO en 0x4000-0x5FFF, asi que un `call 0x4265` quiere decir lo
mismo se haga desde donde se haga. Los demas no: en 0x8014 puede estar
cualquiera de seis bancos, y por eso aqui solo se anotan las llamadas a la
pagina fija -no hay forma de equivocarse-.

Los nombres NO estan escritos aqui: se leen de las directivas `L` de
src/p00.notes, que es donde se bautizan las rutinas. Asi no pueden desincronizarse:
si una rutina se renombra, esto cambia solo la proxima vez que se corre.

Uso:  anota_llamadas.py <banco> [--anexa]
      anota_llamadas.py --todos --anexa
"""
import io
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import nombre                                   # noqa: E402

BANCOS_CON_CODIGO = (1, 2, 3, 9, 14)

CABECERA = """
# --- Las llamadas al banco 0, que esta fijo en 0x4000-0x5FFF. Los nombres los
# saca tools/anota_llamadas.py de las directivas L de src/p00.notes.
"""


def nombres_del_banco_0():
    fuera = {}
    ruta = os.path.join(RAIZ, "src", "p00.notes")
    for ln in io.open(ruta, encoding="utf-8"):
        m = re.match(r"^L 0x([0-9A-Fa-f]{4})\s+(\S+)", ln)
        if m:
            fuera[int(m.group(1), 16)] = m.group(2)
    return fuera


def anota(banco, mapa):
    asm = os.path.join(RAIZ, "src", "penguinadventure_%s.asm" % nombre(banco))
    notas = os.path.join(RAIZ, "src", "%s.notes" % nombre(banco))
    ya = set()
    if os.path.exists(notas):
        for ln in io.open(notas, encoding="utf-8"):
            m = re.match(r"^C 0x([0-9A-Fa-f]{4})\s", ln)
            if m:
                ya.add(int(m.group(1), 16))
    salida = []
    for l in io.open(asm, encoding="utf-8"):
        m = re.search(r"^\s*(.*?)\s*;\s?([0-9a-f]{4})(?:\s|$)", l)
        if not m or not m.group(1):
            continue
        dir_, ins = int(m.group(2), 16), m.group(1).strip()
        if dir_ in ya:
            continue
        mm = re.match(r"(?:call|jp)(?: [a-z]{1,2},)? 0([0-9a-f]{4})h$", ins)
        if not mm:
            continue
        destino = int(mm.group(1), 16)
        if not 0x4000 <= destino < 0x6000 or destino not in mapa:
            continue
        ya.add(dir_)
        salida.append("C 0x%04X banco 0: %s" % (dir_, mapa[destino]))
    return salida, notas


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    mapa = nombres_del_banco_0()
    if not mapa:
        sys.exit("src/p00.notes no bautiza ninguna rutina")
    bancos = BANCOS_CON_CODIGO if "--todos" in sys.argv else [int(sys.argv[1], 10)]
    for b in bancos:
        salida, notas = anota(b, mapa)
        if "--anexa" in sys.argv:
            if salida:
                with io.open(notas, "a", encoding="utf-8", newline="\n") as f:
                    f.write(CABECERA + "\n".join(salida) + "\n")
            print("%s: %d comentarios" % (os.path.basename(notas), len(salida)))
        else:
            print("\n".join(salida))


if __name__ == "__main__":
    main()
