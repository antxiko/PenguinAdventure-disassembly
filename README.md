# Penguin Adventure / Yume Tairiku Adventure (Konami, 1986, MSX1) — a commented disassembly

A byte-exact, reproducible disassembly of the 128 KB MegaROM cartridge
**Penguin Adventure** (夢大陸アドベンチャー, *Yume Tairiku Adventure*), Konami
**RC-743** (1986), for the MSX1. It is the sequel to *Antarctic Adventure*, and
it grows from a 32 KB cartridge to 128.

The listing is produced by tracing the real flow, bank by bank, and
**reassembling it gives back the original ROM byte for byte**: all sixteen 8 KB
banks and the whole 131,072-byte image. That is the test that decides whether a
disassembly can be trusted; everything else in this repository is there so the
listing does not *lie* about what it reassembles.

*(En español: [README.es.md](README.es.md).)*

## Where it stands

| | |
|---|---|
| ROM | 131,072 bytes, sha256 `525608aa990e1a19285edc98dec3f0aa11339d8a17641c89df3966845d10cc6a` |
| reassembles byte for byte | yes, all 16 banks and the whole image |
| traced code | 32,185 bytes |
| identified data | 98,887 bytes |
| listing | 25,709 lines |
| entry points, each with its justification | 360 |
| named labels | 237 |
| anchored comments | 4,399 |
| explained data ranges | 24 |

## The cartridge

128 KB with the **Konami mapper WITHOUT SCC** (Konami4): sixteen 8 KB banks.
There is no register for 0x4000-0x5FFF — bank 0 is fixed there — and the other
three windows are chosen by writing the bank number to 0x6000, 0x8000 and
0xA000. `tools/reconocimiento.py` measures this on the bytes themselves: not a
single write to 0x5000, 0x7000, 0x9000 or 0xB000 — the registers of the mapper
*with* SCC — and all **512** writes to the Konami4 registers carry a bank that
obeys the rule, without one exception.

Banks are swapped in **groups of three**: `ld a,N` followed by
`ld (0x6000),a` / `inc a` / `ld (0x8000),a` / `inc a` / `ld (0xA000),a`, filling
all 24 KB at once with N, N+1 and N+2. The triples that appear are 1-2-3, 4-5-6
and 7-8-9; the high banks go in pairs, leaving 0x6000 alone.

| bank | runs at | what it holds |
|---|---|---|
| 0 | 0x4000 (fixed) | header, INIT, interrupt, dispatcher, mapper |
| 1, 2, 3 | 0x6000 / 0x8000 / 0xA000 | the game code |
| 4, 5, 6 | 0x6000 / 0x8000 / 0xA000 | data |
| 7, 8 | 0x6000 / 0x8000 | data |
| 9 | 0xA000 | code |
| 10, 11 | 0x8000 / 0xA000 | data |
| 12, 13 | 0x8000 / 0xA000 | a data library (see `src/datos.txt`) |
| 14 | 0x8000 | the sound player |
| 15 | 0xA000 | data |

**No bank is filler.** All 128 KB are used, which is not true of every MegaROM
from this house.

## The cartridge states its catalogue number twice

**At the end of bank 3** it carries the mark Konami hid in its cartridges: the
catalogue number in BCD and the title in katakana, written backwards. Here it
is sixteen characters reading **ユメタイリク アドベンチャー** — *Yume Tairiku
Adventure* — and the `07 43` of **RC-743**.

Finding that mark is **not our work**: it was uncovered by
**Manuel Pazos ([@ManuelPazosMSX](https://github.com/ManuelPazos))** in 2021.
All we do here is check that this cartridge carries it. It also yields **two new
characters** for the syllabary table, which the title pins down with no room for
doubt: index 49 is the small ャ and index 58 the lengthening mark ー.

**At 0x4010** it also carries the *second header*, the one the **Konami Game
Master** reads from the neighbouring cartridge: the marker `CD` — used by the
1986-87 titles — followed by the same `07 43`. Its bytes are pointers to the
game's variables in RAM.

## How to build it

You need the ROM in the root as `penguinadventure.rom`. It is **not distributed
here**; read [LEGAL-NOTICE.md](LEGAL-NOTICE.md).

    make comprueba     the ROM's sha256
    make reconoce      header, mapper and the bank -> org rule
    make marca         the mark hidden at the end of bank 3
    make semillas      re-derive the .entries and .nocode files
    make trace         trace the 16 banks
    make listado       generate src/penguinadventure_pNN.asm
    make verify        THE TEST: reassemble and compare with the ROM
    make sanity        what reassembly cannot catch
    make test          the tests
    make densidad      how much is commented, bank by bank

## Licence

The code, comments and tools in this repository are MIT licensed
([LICENSE](LICENSE)). **The game is not**: it belongs to Konami and its rights
holders. Read [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
