#!/usr/bin/env python3
"""Anota el protocolo del mapper en el listado de un banco.

Este cartucho cambia de banco mas de quinientas veces, siempre con el mismo
baile, y cada paso tiene su motivo:

    di                  mientras el mapa de memoria esta a medias no puede
                        entrar la interrupcion, que lee del cartucho
    push hl             HL va a hacer de puntero a las copias en RAM
    ld hl,0xF0F1        las tres copias, una por ranura y seguidas
    ld a,N              el primer banco del trio
    ld (0x6000),a       al registro del mapper
    ld (hl),a           y apuntado en su copia
    inc a / inc hl      el banco siguiente y la copia siguiente
    ei                  ya se puede volver a interrumpir

Escribir eso a mano quinientas veces no tendria ningun merito y ademas se
equivocaria: aqui sale de seguir el estado de verdad, contando los `inc hl`
para saber a que copia apunta HL y los `inc a` para saber que banco lleva A.

Se salta las direcciones que ya tengan comentario en el .notes, asi que lo
escrito a mano manda siempre.

Uso:  anota_mapper.py <banco> [ini] [fin]     lo saca por la salida estandar
      anota_mapper.py <banco> --anexa         lo anexa al .notes de ese banco
"""
import io
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, nombre                  # noqa: E402

CABECERA = """
# --- El protocolo del mapper, paso a paso. Lo genera tools/anota_mapper.py
# siguiendo el estado real de HL y de A; la explicacion de por que se hace asi
# esta en el banco 0.
"""


def anota(banco, ini=None, fin=None):
    asm = os.path.join(RAIZ, "src", "penguinadventure_%s.asm" % nombre(banco))
    notas = os.path.join(RAIZ, "src", "%s.notes" % nombre(banco))
    if ini is None:
        ini, fin = ORG[banco], ORG[banco] + TAM_PAGINA

    ya = set()
    if os.path.exists(notas):
        for ln in io.open(notas, encoding="utf-8"):
            m = re.match(r"^C 0x([0-9A-Fa-f]{4})\s", ln)
            if m:
                ya.add(int(m.group(1), 16))

    lineas = []
    for l in io.open(asm, encoding="utf-8"):
        m = re.search(r"^\s*(.*?)\s*;\s?([0-9a-f]{4})(?:\s|$)", l)
        if m and m.group(1):
            lineas.append((int(m.group(2), 16), m.group(1).strip()))

    salida = []
    hl = None
    a = None
    dentro = False
    for k, (dir_, ins) in enumerate(lineas):
        if not ini <= dir_ < fin:
            continue
        sig = lineas[k + 1][1] if k + 1 < len(lineas) else ""
        txt = None
        m = re.match(r"ld a,0([0-9a-f]{2})h$", ins)
        if m:
            a = int(m.group(1), 16)
        elif ins == "inc a" and a is not None:
            a += 1
        if ins == "di":
            for j in range(k + 1, min(k + 10, len(lineas))):
                if re.match(r"ld \(0(6000|8000|a000)h\),a$", lineas[j][1]):
                    dentro = True
                    txt = "sin interrupciones mientras cambia el mapa"
                    break
        elif ins == "ei" and dentro:
            dentro = False
            txt = "el mapa ya esta entero"
        elif ins == "push hl" and sig.startswith("ld hl,0f0f1h"):
            txt = "HL va a apuntar a las copias"
        elif ins == "ld hl,0f0f1h":
            hl = 0xF0F1
            txt = "las tres copias, seguidas"
        elif ins == "inc hl" and hl is not None:
            hl += 1
            txt = "la copia siguiente"
        elif ins == "ld (hl),a" and hl is not None:
            txt = "apuntado en 0x%04X" % hl
        elif ins == "pop hl" and hl is not None:
            hl = None
            txt = "HL, como estaba"
        else:
            m = re.match(r"ld \(0(6000|8000|a000)h\),a$", ins)
            if m and a is not None and a < 16:
                txt = "el banco %d a 0x%s" % (a, m.group(1).upper())
            elif re.match(r"ld \(0(f0f1|f0f2|f0f3)h\),a$", ins):
                txt = "y en su copia de RAM"
        if txt and dir_ not in ya:
            ya.add(dir_)
            salida.append("C 0x%04X %s" % (dir_, txt))
    return salida, notas


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    banco = int(sys.argv[1], 10)
    salida, notas = anota(banco)
    if "--anexa" in sys.argv:
        with io.open(notas, "a", encoding="utf-8", newline="\n") as f:
            f.write(CABECERA + "\n".join(salida) + "\n")
        print("%s: %d comentarios anexados" % (os.path.basename(notas),
                                               len(salida)))
    else:
        print("\n".join(salida))
        sys.stderr.write("%d comentarios\n" % len(salida))


if __name__ == "__main__":
    main()
