# In the emulator

Almost everything on this site comes from reading the binary and running its
routines in Python. But some things are only settled by watching them run, and
the two keyboard codes are one of them.

## The machine matters

With `Philips_VG_8020` this cartridge **does not start**: the MSX sits on the
BASIC boot screen and never runs. With `C-BIOS_MSX1_EU` it does. You can tell in
two places:

- 0xE003, the frame counter, moves;
- 0xF0F7 goes to 0, which is what INIT does at p00:40BD.

If you look at the screen and see BASIC, this is why. And if you check those two
addresses before starting, it saves you an afternoon.

## Checking the two codes

```
PA_OUT=work/omsx PA_CLAVE=NORIKO openmsx -machine C-BIOS_MSX1_EU \
    -carta penguinadventure.rom -script tools/omsx_claves.tcl
```

The probe boots, presses space to get into the title screen, types the word
letter by letter on the key matrix and reads 0xF0F7 and the queue at 0xF0F8. With
`PA_CLAVE=KAZUMI` it tries the other one.

What comes out, and it is what the listing predicted byte for byte:

```
pulsada N (fila 4 mascara 08) -> cola 00 00 00 00 00 04
pulsada O (fila 4 mascara 10) -> cola 00 00 00 00 04 05
pulsada R (fila 4 mascara 80) -> cola 00 00 00 04 05 06
pulsada I (fila 3 mascara 40) -> cola 00 00 04 05 06 01
pulsada K (fila 4 mascara 01) -> cola 00 04 05 06 01 02
pulsada O (fila 4 mascara 10) -> cola 04 05 06 01 02 05
0xF0F7 DESPUES = FE
VERDE: 0xFE, o sea NORIKO
```

And with KAZUMI, the queue `02 00 08 07 03 01` and 0xF0F7 at 0xFF.

## The four traps, which cost an afternoon

**The state.** The code watcher only runs in **state 3**, which is the PUSH SPACE
KEY screen. The attract cycle goes 0 → 1 → 2 → 0 and state 3 is not reached on
its own: you have to press something to get in. Typing the word during the demo
does absolutely nothing, and you cannot see that by looking at the screen.

**`type` will not do.** It holds the key too briefly and the watcher, which only
notes a key when it **changes** from released to pressed, never sees it. You
press the matrix by hand with `keymatrixdown` and `keymatrixup`, and you have to
**release** between keys: two presses in a row without a release in between are
one press.

**The first key is lost** if it is pressed at the very instant state 3 is
entered. Half a second of breathing room and it registers.

**Screenshots come out stale** with `throttle off`: the renderer does not refresh
and you see the screen from several seconds ago. To take pictures you have to run
at real speed.

## Starting on whichever stage you like

There is no need to play the whole game. The stage is at 0xE092, from 1 to 24,
and it can be written from the emulator console:

```
debug write memory 0xE092 12
```

Mind the two tables at p00:4105 and p00:4113, which **only cover the first
thirteen** of the twenty-four: that is one of the
[open questions](OPEN-QUESTIONS.html).

## Checking a drawing against the VRAM

The images on this site are drawn by running the cartridge's routines in Python.
The way to check one is right is not to look at it: it is to dump the emulator's
16 KB of VRAM at the same instant and compare byte for byte. If it comes out at
zero differences, the image is the cartridge's.

And if one or two come out, look first at whether it is the **instant** of the
dump —an animation caught halfway— before touching anything.
