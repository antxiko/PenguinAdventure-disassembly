# Findings

What turns up when you take it apart, with the address next to it so it can be
checked.

## Two keyboard codes: NORIKO and KAZUMI

You type them on the title screen —state 3, the PUSH SPACE KEY one— and they
turn on **CONTINUE**, which does not exist without them.

p02:9522 watches **nine** keys with the BIOS `SNSMAT`, which returns the bit at
zero when the key is down. It keeps each one's previous-frame state in a byte of
its own, and when one has just been pressed —released before, down now— it notes
its number in a six-entry queue at 0xF0F8: the five behind shift along with
`ldir` and the new one comes in at the end.

The nine keys, with the number each gets from the order the code looks at them:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|---|
| A | I | K | M | N | O | R | U | Z |

When space is pressed, p02:80F2 compares those six against the two patterns at
0x965F:

```
04 05 06 01 02 05   ->  N O R I K O
02 00 08 07 03 01   ->  K A Z U M I
```

And they are not nine arbitrary keys: they are **exactly** the letters needed to
spell those two names, and no others. If a keyboard code watches an odd handful
of keys, those keys are the code's alphabet.

**The two do not do the same thing.** NORIKO leaves 0xFE in 0xF0F7 and KAZUMI
0xFF. With 0xFE or more the CONTINUE appears (p02:8937 and p02:8A32), but with
**exactly** 0xFE the game-over wipe skips the 143 bytes at 0xE160 and the 64 of
the screen mirror (p02:8985): NORIKO also keeps what you are carrying.

Both are verified in openMSX, not merely read off the listing. See
[In the emulator](IN-THE-EMULATOR.html).

## The good ending depends on how many times you pause

The finding is **Manuel Pazos's**, who told it at a talk. What this disassembly
adds is where it is written in the binary and the exact rule.

p02:81EE bumps the counter at **0xE0DE** every time you **enter** pause —not when
you leave, so pausing and resuming counts as **one**—. And when stage 24 ends,
p02:82DE reads it:

```
ld a,(0e0deh)   ; how many times it has been paused
and 003h        ; its low two bits
dec a
ld c,000h
jr z,...        ; if (count & 3) == 1  ->  c = 0
inc c           ; anything else         ->  c = 1
```

That `c` goes into 0xE0B9, and the ending text (p00:5F19) picks its list
depending on whether it is zero:

| times you paused | ending |
|---|---|
| **1, 5, 9, 13, 17…** | **good** — the princess alive |
| 0, 2, 3, 4, 6, 7, 8… | bad |

That is: **the remainder of dividing by four has to be exactly 1**, and never
pausing gives you the bad ending.

Two details that change how you play. The count is **not** cleared when you lose
a life —`reempieza` wipes from 0xE1F0 onwards and does not touch it— but it
**is** cleared by CONTINUE: state 15 wipes 217 bytes from 0xE086 and 0xE0DE
falls inside. If you continue, you are back to zero.

And both texts are in the ROM, decompressed from bank 11. The cartridge's
alphabet is `A = 0x21` and space `0x00`:

```
EPILOGUE                        EPILOGUE
YOU HAVE SUCCEEDED IN           YOU HAVE FAILED TO
RESCUING THE PRINCESS AND       RESCUE THE PRINCESS!
SAVING THE PENGUIN KINGDOM!     PLEASE TRY AGAIN!
CONGRATULATIONS!
```

Both share the first line —the EPILOGUE at 0xBAC0— and part company on the next.

**Checked in motion**, not merely read: dropping the game into state 6, substate
5 —where the decision lives— with stage 24 set, **zero** pauses gives the bad
ending and **one** gives the good one. And with a watchpoint on 0xE0B9 to see
that what writes it is p02:82EA and not the game-over wipe, which is an easy
mistake to make: that wipe also leaves it at zero and looks like a good ending.

## The cherry is the only symbol that counts alone

The gambling machine's reels take their symbol from the R register masked to
four bits, and use that index into the sixteen-entry table at 0x7B34:

```
00 01 04 03 02 00 01 00 01 02 05 00 01 00 02 03
```

The cherry —symbol 0— takes **five** of the sixteen slots: 31.2 % per reel, and
at least one on **67.5 %** of the spins.

And the payout code at p01:7AF0 treats it apart. There are two separate counts:
one that requires all three reels to match, and an `inc (hl)` that bumps a
counter **for each** reel showing a zero. The seven multipliers at 0x7B23 are 1,
2, 4, 8, 10, 15 and 20, and the first three are for one, two and three cherries.
Every other symbol pays only in threes, and symbol 5 is marked 0xFF: the jackpot.

It is the classic slot-machine cherry rule, written in Z80. And the payout table
painted on the machine itself says the same.

## Every third stage, a dinosaur

On the stages whose 1-2-3 counter (0xE093) is 3 —3, 6, 9... up to 24— what
approaches at the end is not the goal. p01:6697 copies onto the map the five
strips at 0xA76B instead of those at 0xA605, and what grows is a dinosaur made
of characters, with its own four loads (p00:537A, 5424, 53CF and 5498) and the
colour the backdrop picks. The fight follows, state 7. See
[The game](THE-GAME.html).

## Space is inside a crevasse

The warnings script at 0xB046 flags, at its distance, that the next object to
come out is a crevasse carrying two extra bytes: the mode and the list.
Falling into it and pressing down (p02:99A2) enters mode 1, space. It is the
only way there: backdrop 8 belongs to none of the twenty-four stages.

## A creature you cannot see

Object class 7 appears in the scripts of six stages, but p09:B8B3 gives it
colour 0 —transparent— unless 0xE16A is carried. With that set it shows in
colour 5.

## The patterns nobody loaded

The penguin's sprite patterns 0x00 to 0x14 are not loaded by any compressed
script: the cartridge's other painter uploads them, `pinta_bloque`
(p00:43B3), which reads uncompressed sixteen-byte columns and, with bit 0 of
C, paints each column twice, the second time mirrored. p00:57FB calls it with
one of three strips depending on the terrain.

## The roadsides are not colours

The listing called p01:6AA8 "the colours that go round". It touches no
colours: it erases with ones and paints with p00:41BF, step by step, what goes
by at the sides of the road, from the strips at 0xA420. And it does not run on
distance but on frames with the speed bar pinned, so it depends on how you
accelerate.

## Twenty-four stages, not thirteen

Thirteen is what the cartridge declares to the Konami Game Master in the header
at 0x4010. p02:8328 compares the stage with 0x19, and the three script tables
close at exactly twenty-four entries. And LEVEL 2 from the title menu is a
whole different design: not one section matches the LEVEL 1 ones byte for byte.

## The clock runs whether you move or not

0xE08B is not the stage length: it is the time. p02:922D takes one off it **every
32 frames**, whether you move or not; below 0x15 it beeps every other frame; and
when the stage ends p02:94D1 turns it into points 0x20 at a time.

Which is why the item at p03:B31E, which adds 0x50 in BCD, does not make the run
longer: it **gives extra time**. It is the only thing in the whole cartridge that
touches that counter once the stage is up.

## An extra life every 50,000 points

The score is three BCD bytes —six digits— and caps at 999999. p02:938B checks the
high byte against the threshold at 0xE095: when it reaches it, the threshold goes
**up by 5 in BCD** —another 50,000— and a life is granted. If the threshold
overflows it sticks at 0xFF, which is never reached again.

Lives cap at 99: p01:74E5 checks the carry out of the `daa` and, if it overflows,
pins them at 0x99.

## The target takes twenty hits

What the second button fires comes from p03:BD8A and there can only be one in
flight: 0xE500 is the flag. Against the target at 0xE535, each hit adds one to
0xE53C and it has to reach **twenty** (p01:77D1). The previous nineteen only make
a sound. The twentieth sets the four records at 0xE550 to 5, points 0xE53A at
0xAE0A and 0xE530 becomes 2.

## What gets thrown AIMS

The record at 0xE540 appears blinking between two drawings for 32 frames —the
warning that it is coming— and then p03:B1C8 looks at where the player is and
picks one of three steps: left, straight or right. If the difference is under 16
columns, it goes straight.

It comes down in three legs with sub-pixel precision —a fraction byte below each
coordinate— and changes drawing on each one: 0xAC, 0xB0 and 0xB4.

## A bank's padding is an instruction

The `0xFF` that pads the tail of a bank is `rst 38h`. The tracer walked out
through it into the neighbouring bank and took padding for code.

And worse: this cartridge **switches banks with interrupts enabled**, with a
semaphore at 0xE005. No static tracer follows that, and it is where 14 KB of
invented code in banks 12 and 13 came from, which had to be declared by hand.

## Fourteen bytes of dead code

At p01:7B50 there are fourteen bytes that read cleanly as code —`ld a,(0xE0C5) /
and a / ret nz / ld a,(0xE115) / and a / ret z`…— and that nobody jumps to. Not a
`call`, not a `jp`, not a table. They are declared as data because as code they
never run.

## The D that is not a high byte

`resta_en_bcd_de_dos_bytes` (p01:6F86) is the routine you pay with in the shop and
bet with at the machine. It takes IX pointing at the number and C holding what
comes off it —but **D is not the amount's high byte**: it is what gets subtracted
from the high byte *when a borrow is needed*, and it is 1 in every call. It is
the carry done by hand, and it is needed because `daa` does not get along with
`sbc`.

Read as a 16-bit amount, every price in the shop comes out 256 times dearer than
it is.
