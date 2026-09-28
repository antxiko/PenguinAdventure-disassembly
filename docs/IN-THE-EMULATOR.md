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

## Checking the drawings against openMSX

The images on this site are drawn by reading the cartridge's tables with our
own code. What says they are right is not looking at them: it is comparing
them with emulator dumps.

`tools/omsx_fases.tcl` forces the stage and the level at p00:46E3 —where both
the normal set-up and the Game Master one go through— and dumps VRAM, RAM and
the VDP registers every so many frames, on every state change and at every
cut of the ending; and it logs every object that comes out on the road
(p01:6852). To reach the end of the long stages it sets the step period
(0xE4C0) to 1 right before walking, at p00:4560, and it keeps 0xE1F1 so the
penguin does not die. The scenes, the map, the fight and the shop have their
own probes (tools/omsx_escenas.tcl, omsx_mapa.tcl, lanza_pelea.sh and
omsx_tienda.tcl).

`make coteja` compares against those dumps:

| what | how many | differences |
|---|---|---|
| each stage's screen | 24 stages | 0 bytes |
| the ending: goal and dinosaur | 144 cuts | 0 |
| the penguin, pose and placement | 1,107 frames | 0 |
| the creatures, drawing by class and distance | 510 objects | 0 |
| space | 9 screens, 8 fish, 13 meteorites | 0 |
| the road objects, LEVEL 1 and 2 | 5,414 | 0 |
| the screen mirror, walking the stage | 424 dumps | 0 |
| the WARP, backdrop 9 | 21 screens | 0 |
| the tree and the two endings | 3 scenes | 0 |
| what moves in the scenes | 1,337 dumps | 0 |
| the fight with the dinosaur | 3,246 dumps | 0 |
| the map before every stage | 32 dumps | 0 |
| the shop: the three shopkeepers, open and closing | 14 dumps | 0 |

Two traps. At the dump point (p00:451C) the VRAM name table lags one frame
behind the RAM mirror, so cells are compared in the mirror. And stages 12, 18
and 24 never end without the item at 0xE16C: a late dump is on another pass,
with the script indices the same and the slots not.
