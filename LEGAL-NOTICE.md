# Legal notice and attribution

*(Tambien disponible [en castellano](AVISO-LEGAL.md).)*

## Who owns what

**The game is not ours.** *Penguin Adventure / Yume Tairiku Adventure* was published by **Konami** for the MSX in 1986;
its catalogue number is **RC-743** and it is 128 KB, a MegaROM with the
SCC-less Konami mapper. All rights over the game
remain with their holders.

**What is ours** are this repository's tools, the comments in the listing, the
analysis and the documentation. That is published under the licence in
`LICENSE`.

## What is in this repository

The files `src/penguinadventure_pNN.asm` are the commented disassembly of the
cartridge, one per each of its sixteen 8 KB banks. It is
published for the **preservation, study and documentation** of a title that is
part of MSX software history.

The cartridge image (`.rom`) is **not** distributed here. Anyone who wants to
rebuild the listing has to supply their own, and the `Makefile` checks its
sha256 before doing anything.

The compressed blocks the listing declares were not estimated by eye:
`tools/rle.py` counts them by actually unpacking them, and the fact that they
tile the data banks without a single byte of slack is part of the proof that
the format is read right. If it were wrong, the next block would start in the
wrong place.

## What it rests on

Nobody else's work. Everything stated here comes from reading this binary or
from measuring it running, and each claim carries its evidence next to it: the
instruction that reads a datum, the table that ends exactly where it has to end,
or the measurement made in the emulator. What is not settled is said not to be.

Where something outside the cartridge is cited, its source is named and the
person who found it is thanked:

- **The format of Konami's hidden mark** — the catalogue number in BCD and the
  title in katakana at the end of a bank — was discovered by **Manuel Pazos
  (@ManuelPazosMSX)** in 2021. Without that finding there would be nowhere to
  look. All that is done here is to check that this cartridge carries it and to
  read it.
- **What the bytes of the second header at 0x4010 mean** comes from reading the
  cheat cartridge that uses them, the **Konami Game Master (RC-741)**, which is
  disassembled in this same series: it is its routine at 0x5E64 that says which
  of those pointers is the lives, which the stage and which the score.

## If you are one of the authors

If you worked on *Penguin Adventure / Yume Tairiku Adventure* or hold rights over the game, and you would rather this
material were not published, **say so and it comes down, no argument**. The
intent of this work is the opposite of harming you: it is to put on record how
it was made.
