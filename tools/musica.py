#!/usr/bin/env python3
"""La musica del cartucho, ejecutando su motor de sonido (ver motor_musica.py).

El reproductor `cuadro_de_sonido` (0x8082, banco 14 en 0x8000 y banco 15 en
0xA000) lo llama la interrupcion en cada cuadro (p00:4030). El sonido se pide
con la rutina de p14:86BA (A = numero), a la que llegan `pide_sonido` (p00:4145)
y `pide_sonido_si_esta_activo` (p00:413A). Tres voces de 21 bytes desde 0xE010;
la mezcla del PSG, en 0xE079. MegaROM Konami4 de 128 KB, sin SCC.
Uso:  musica.py registros 0x3B [cuadros] | mp3 0x3B f.mp3 | todas docs/audio
      musica.py barrido 0x01 0xFF | emu
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

TABLA = "ninguna llamada directa: sale de la tabla de pistas por un número calculado"

PIEZAS = [
    P(0x56, "La pieza de `estado_9_ultimo`", "The `estado_9_ultimo` tune",
      "`estado_9_ultimo`"),
    P(0x38, "La pieza del 0x74EC", "The tune at 0x74EC", "`L_74EC`"),
] + [P(n, "Pista 0x%02X de la tabla" % n, "Table track 0x%02X" % n, TABLA)
     for n in range(0x3B, 0x56)]

PAGINA = motor_musica.pagina_basica(
    "`cuadro_de_sonido`, 0x8082 del banco 14, y la rutina de p14:86BA que "
    "reparte los canales; lo llama la interrupción en p00:4030",
    "`cuadro_de_sonido`, 0x8082 of bank 14, and the routine at p14:86BA "
    "which shares the channels; the interrupt calls it at p00:4030",
    "C-BIOS MSX1 japonés",
    [("la pista 0x3B, sus primeros 218 cuadros",
      "track 0x3B, its first 218 frames"),
     ("la pista 0x44, sus primeros 218 cuadros",
      "track 0x44, its first 218 frames")],
    [("Cómo se pide una pieza",
      "`pide_sonido` (p00:4145) y `pide_sonido_si_esta_activo` (p00:413A, que "
      "mira antes el bit 6 de 0xE002) guardan los registros, mapean los "
      "bancos 14 y 15 y llaman a la rutina de p14:86BA con el número en A. "
      "Los números bajos son efectos y del 0x3B en adelante hay música; el "
      "juego calcula el de cada fase, así que casi todas son pistas «de la "
      "tabla». Las voces ocupan 21 bytes desde 0xE010 y 0xE079 guarda la "
      "copia del mezclador del PSG, que el arranque deja en 0xB8. Las pistas "
      "que duran más de 75 segundos sin volver a empezar se cortan a los 75, "
      "y así se dice en cada una. Solo hay dos pistas cotejadas con "
      "openMSX, la 0x3B y la 0x44; las demás salen del mismo motor.",
      "How a piece is asked for",
      "`pide_sonido` (p00:4145) and `pide_sonido_si_esta_activo` (p00:413A, "
      "which first checks bit 6 of 0xE002) save the registers, map banks 14 "
      "and 15 and call the routine at p14:86BA with the number in A. Low "
      "numbers are effects and from 0x3B up there is music; the game "
      "computes each stage's, so almost all are tracks «in the table». The "
      "voices take 21 bytes from 0xE010 and 0xE079 holds the copy of the "
      "PSG mixer, which start-up leaves at 0xB8. Tracks that last over 75 "
      "seconds without starting again are cut at 75, and each one says so. "
      "Only two tracks have been checked against openMSX, 0x3B and 0x44; "
      "the rest come out of the same engine.")])

CFG = dict(rom="penguinadventure.rom", org=0x4000, mapper="konami",
           bancos0=((0x4000, 0), (0x6000, 1), (0x8000, 14), (0xA000, 15)),
           frame=0x8082, pide=0x86BA, banco_frame=14, banco_pide=14,
           ram=(0xE010, 0xE07A), excluye=[0xE019, 0xE02E, 0xE043],
           ram0=[(0xE079, 0xB8)], hz=60, psg0={7: 0xB8}, romtype="konami",
           max_s=75, piezas=PIEZAS, pagina=PAGINA,
           cotejado=[(0x3B, 1583, 15)])

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
