# The cartridge

128 KB with the **Konami mapper WITHOUT SCC** (Konami4): sixteen 8 KB banks.
There is no register for 0x4000-0x5FFF —bank 0 is fixed there— and the other
three windows are chosen by writing the bank number to 0x6000, 0x8000 and
0xA000.

`tools/reconocimiento.py` measures this on the bytes themselves: not a single
write to 0x5000, 0x7000, 0x9000 or 0xB000 —the registers of the mapper *with*
SCC— and all **512** writes to the Konami4 registers carry a bank that obeys the
rule, without one exception.

## Banks are swapped in groups of three

Always the same dance, and every step has its reason:

```
di                  while the memory map is half done the interrupt, which
                    reads from the cartridge, must not come in
ld hl,0xF0F1        the three RAM mirrors, one per window and consecutive
ld a,N              the first bank of the trio
ld (0x6000),a       to the mapper register
ld (hl),a           and noted in its mirror
inc a / inc hl      the next bank and the next mirror
ei                  interrupts can come back
```

The mirrors at 0xF0F1, 0xF0F2 and 0xF0F3 exist because the mapper **cannot be
read**: writing to 0x6000 sets the bank, but there is no way to ask which one is
there. Anyone who needs to put it back has to have written it down.

## What is in each bank

| banks | what they hold |
|---|---|
| 0 | the core: interrupt, decompressor, painters, the bridges to the data |
| 1, 2, 3, 9, 14 | code |
| 4 to 8, 10 to 13, 15 | data: characters, backdrops, stage scripts, sound |

The data banks never execute an instruction: they are mapped, read and put back.
p00:479D is the clean example —it maps banks 12 and 13 only to read four bytes
of the table at 0xACBA— and from 0x47E2 onwards there is a long row of bridges
doing exactly that. They live in the fixed bank because it is the only place
from which you can switch banks without pulling the floor out from under
yourself.

## What INIT does

The header at 0x4000 is `AB` with INIT at 0x406A, and that routine does four
things before never returning —it ends in a `jr` to itself—:

1. sets the trio 1-2-3 and notes it in the three mirrors;
2. reads the primary slot register with `RSLREG` and keeps **the bits of page
   1**, which is where the cartridge is; with `ENASLT` it puts that same slot
   into **page 2**, so the cartridge spans 0x4000 to 0xBFFF;
3. hooks its interrupt into `H.KEYI` (0xFD9A) with a `jp`;
4. wipes the 0x10EF bytes from 0xE000 to 0xF0F0 in one go, plants the stack
   right there and releases the semaphore at 0xE005.

## The second header: the Konami Game Master

At 0x4010 there is another header, `CD`, which is the one the **Konami Game
Master** reads. It declares thirteen stages —which are not the twenty-four the
game has— and gives it the addresses of the things the Game Master knows how to
touch: the game data, the score and the routine to jump into.

That routine is `arranca_en_la_fase_pedida` (p00:40F7), and **not one instruction
of this cartridge calls it**. Its first instruction says whose it is: it reads
0xD31A, which is Game Master RAM —where the stage the user asked for in its
MODIFY MODE is written—, and a value of this game would have no business there.

## The VRAM map, which is upside down

The eight bytes p00:44AE writes from register 7 down to 0 give a layout that is
not the one almost any MSX1 game uses:

| where | what |
|---|---|
| 0x0000-0x17FF | **colour** table (R3 = 0x7F) |
| 0x1800-0x1FFF | sprite patterns (R6 = 0x03) |
| 0x2000-0x37FF | **pattern** table (R4 = 0x07) |
| 0x3800-0x3AFF | name table (R2 = 0x0E) |
| 0x3B00-0x3B7F | sprite attributes (R5 = 0x76) |

Colours **below** patterns. R3 and R4 are not addresses but base and mask, and
reading them the wrong way round gives correct shapes with striped colours.

## Konami's hidden mark

At the end of the ROM is the mark Manuel Pazos documented: the catalogue
number —**RC-743**— and the title in katakana, written with a syllabary of its
own. `tools/marca_konami.py` extracts it and checks it. The finding is his; here
it is only verified on this cartridge.
