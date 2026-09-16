# Open questions

What is not known, said as what it is. Every byte of the cartridge is assigned to
code or data and the listing reassembles byte for byte, but that does not mean
everything is **understood**.

## Nobody loads sprite patterns 0x00 to 0x0C

Eight of the thirteen poses in the table at 0xA91D ask for sprite patterns 0x00,
0x04, 0x08 and 0x0C. And that area of VRAM —0x1800 to 0x187F— **is written by
none** of the nineteen known sprite scripts, nor by any of the masked scripts the
bank 1 bridges emit.

The two explanations that fit:

1. there is a load the script sweep does not see, for instance an uncompressed
   copy with a computed destination;
2. the sprite pattern base —VDP register 6— changes in some scene, and then those
   numbers point somewhere else.

It has not been settled. And until it is, drawing the thirteen poses together
means nothing: the pattern numbers are **relative to whichever sprite sheet each
scene has loaded**, so the same pose is a different thing depending on what was
dropped into 0x1800 beforehand.

## The Game Master header puts the stage where the Game Master expects lives

The second header, the one at 0x4010, declares thirteen stages and gives the
addresses of the things the Konami Game Master knows how to touch. One of them
lands where the Game Master expects the lives counter, and what is there is the
stage. It may be deliberate —so that the Game Master lets you change the stage
from its MODIFY MODE— or it may be a slip by Konami. There is no way to decide
from this binary alone.

## What four of the machine's six symbols are

The cherry and the bunch of grapes are unmistakable in the drawing taken from the
ROM. The other four are not: there is one in tan tones with green underneath, a
red one, a blue one and the jackpot, which is white on transparent. They are
published as they come out and readers can make up their own minds.

## The exact rhythm of the slot machine trick

The three reels are drawn in the same loop in the same frame, with an identical
piece of code between one and the next, so their indices are *r*, *r+k* and
*r+2k* with **k fixed**. And stopping a reel makes the loop do one turn fewer, so
the frame takes slightly less and R advances differently.

Which is why pressing at a fixed rhythm gives you not randomness but always the
same pattern. What is **not** measured is what that k is modulo 16, because it
depends on how many instructions the CPU fetches inside the loop, counting the
BIOS `WRTVRM` routine, and that differs between MSX models. In other words: the
trick could work on one machine and not on another.

## Why it does not start on a Philips VG-8020

It is measured that on that machine the cartridge sits on the BASIC boot screen
—0xE003 does not move and 0xF0F7 does not go to zero— and that with
`C-BIOS_MSX1_EU` it starts without trouble. **Why** has not been worked out. The
header is correct, the `AB` and the INIT at 0x406A read back fine at 0x4000 from
the emulator's own console, and even so the BIOS never calls it.

## The tables that only cover thirteen stages

p00:4105 and p00:4113 index two tables with the stage number, and both have
thirteen entries when there are twenty-four stages. With a stage from 14 onwards
they read bytes past the end of the table. It has not been checked in motion what
comes out of there, nor whether the game ever reaches that path.

## The sound, from the inside

The scores are fully declared and the language is understood —`FE 00` changes the
+0x0E marker and the score switches from the effect language to the music
language— but no player has been written to get them out of the cartridge. Until
there is one, what there is is a description, not a proof.
