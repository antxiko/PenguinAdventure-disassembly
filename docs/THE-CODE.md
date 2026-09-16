# The code

## The state machine

Sixteen states and, inside each one, as many substates as needed. The trick is
the `ld bc,(0xE000)` at p02:800F: one instruction loads both —the state in C and
the substate in B— and then the house dispatcher jumps on C while each state
walks B down with `djnz` until it reaches the substate due. Leaving a substate is
as short as `inc (hl)` on 0xE001.

And a detail at p02:800B: in states 0, 1 and 2 the address 0x8A55 is pushed onto
the **stack** before dispatching, so that when the state does `ret` it does not
go back to its caller but there. It is a way of chaining without spending a call.

The attract cycle is 0 → 1 → 2 → 0. State 3 —the title screen with PUSH SPACE
KEY— is only entered by pressing something.

## The house dispatcher

`call despacha` (p00:4060) with the index in A, and **the pointers sit glued
right behind the call itself**: the routine pops the return address off the
stack, uses it as the base of the table and jumps. It spends no register passing
the table around, which is why in the listing the `defw`s appear immediately
after the `call`.

## The three script formats

The cartridge does not have one decompressor: it has three ways of emitting
bytes, and all three are run in Python by `tools/graficos.py` to draw the images
on this site.

**The compressed one** (p00:418C to RAM, p00:4386 to VRAM). A destination word
and then orders:

| byte | what it does |
|---|---|
| `0x00` | done |
| bare `0x80` | another destination word follows |
| bit 7 set | the low seven are how many bytes go through as they are |
| bit 7 clear | the low seven are how many times the next byte repeats |

Each byte also goes through p00:43F9, which is where it gets mirrored —a mirrored
character is the same byte read backwards, p00:4402— or has its colours swapped
in pairs (p00:440D).

**The masked one** (p00:42BC and p00:42BE). No compression at all: a destination
word, `0xFF` ends it, `0xFE` opens another run and everything else is a byte as
it is. The interesting part is the `and c` at p00:42C9: with the mask at zero
what gets written is zeros, so **the same script both paints a caption and
erases it**. That is what the shop does when it closes.

**The block one** (p00:43B3). Uncompressed bytes sixteen at a time, and bit 0 of
H rules: if it is set, each column is painted **twice**, the second one mirrored.
That is why the ROM holds half a figure and not the whole one.

## The objects, and the three coordinates

There are three sets of slots, and the first one explains how the game is built.

**0xE310: three slots of 0x20 bytes.** Each object has **three** coordinates, not
two, each with its own 16-bit speed:

```
+0x00  what class of object; a zero means a free slot
+0x02  the screen column        +0x03  the row
+0x06  X, 16 bits               +0x0C  its speed
+0x08  Y, 16 bits               +0x0E  its speed
+0x0A  Z -the DEPTH-            +0x10  its speed
+0x12  whether it moves by itself
```

The Z is what makes things come towards you: p09:A966 works out the screen column
by **subtracting the depth from the X** and keeping the high byte, and that is
what gives the perspective. And p09:AA18 picks one of four drawings from the high
byte of the X: the same creature from larger to smaller.

**0xE370: three slots of 0x10 bytes**, with two coordinates and their speeds.

**0xE3A0: three slots of 0x10 bytes** for what flies through the air. Each one
carries **two sprites**, not one: row, column, drawing and colour for the first,
and row, column and drawing for the second, which inherits its colour. That is
the house way of painting a two-coloured figure on an MSX1, where a sprite has
one colour.

## What you control

Four sprites in a two-by-two block, placed by p03:A8DB from (0xE204, 0xE205)
—row and column— and the pose set by p03:A8F5 from the table at 0xA91D: thirteen
poses of eight bytes, four (pattern, colour) pairs each.

The **state** of what you control is 0xE203, and it is not an animation counter:
it is what nearly everything hangs off. States 3, 4, 8 and 10 are the ones where
nothing collides; p02:9751 sets it to 1 or 2 on a jump, p03:B33B to 15, and
p02:925D to 0x15 or 0x16 on losing. p00:42FB only consults it to decide where to
split the sprite table on upload: in state 4 it moves sprites 4 and 5 to the
front, and in 16 the eight at 0xEEE0, which on a VDP that paints only four per
line is giving them priority.

## The screen mirror

The RAM from 0xEBA0 to 0xEEFF is an exact copy of the VRAM from 0x3820 to
0x3B7F, 0x4C80 apart: 0xEBA0 is row 1, 0xEBE0 row 3 —where the play area starts—
and 0xEE80 the sprite attribute table. The screen is built in RAM and pushed in
one go with `outi`, which is the only way to fill the VRAM at frame rate.

And mind the loop count at p00:4270: `ld b,d` comes in with 0x40, but each turn
drops B **twice** —once the `outi`, which is "output and decrement", and once the
`djnz`— so it moves 32 bytes per turn and not 64. And 32 is exactly one row.

## Real trigonometry

The curves are written in the ROM and read back: a 24-step circle and a 32-step
parabola. But to **aim** at the player, bank 9 computes:

- p09:ACE3 divides 16 by 8 bits by subtract-and-shift, because the Z80 has no
  `div`;
- p09:ACF8 does two divisions in a row to get the tangent with whole part and
  fraction;
- p09:ACBA looks that tangent up in the table of **eight** at 0xADB8 —0x04F6,
  0x0266, 0x017D, 0x00FF, 0x00AA, 0x0069, 0x0032 and 0—, which are the tangents
  of 78.75°, 67.5°, 56.25°, 45°, 33.75°, 22.5°, 11.25° and 0°. That is an
  **arctangent**.

The angle comes out in the house's 256 units of a circle, and p09:AD27 breaks it
back into its two components by reading the 65-entry curve at 0xAD77 twice, at B
and at 0x40 − B.

## Randomness

There is no generator. The randomness comes from the **Z80's R register**, the
memory refresh counter, which goes up by one for every instruction the CPU
fetches. p00:5630 uses it to pick one of four backgrounds, p09:AADA for a
creature's side and shove, and p01:79A1 for the gambling machine's reels.

It is cheap and it is not random: R is a counter, and two reads separated by a
fixed piece of code differ by a **fixed** amount.
