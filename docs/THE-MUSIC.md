# The music

Everything you hear here comes from running the cartridge's own sound engine (`cuadro_de_sonido`, 0x8082 of bank 14, and the routine at p14:86BA which shares the channels; the interrupt calls it at p00:4030) on an emulated Z80, frame by frame at 60 per second, just as the game calls it. What the engine writes to the PSG is turned into sound with an AY-3-8910 (`tools/musica.py`). Each MP3 is the whole piece up to where it starts again, plus 8 seconds of the repeat fading out; those that do not repeat end where the engine ends.

## Checked against openMSX

The PSG writes have been compared frame by frame with those of openMSX (C-BIOS MSX1 japonés). In every frame the PSG ends up the same:

- track 0x3B, its first 218 frames;
- track 0x44, its first 218 frames.

The timbre is not checked: it is a textbook AY-3-8910, not a recording of the emulator. The probes are `tools/omsx_psg.tcl` and `tools/coteja_psg.py`.

## How a piece is asked for

`pide_sonido` (p00:4145) and `pide_sonido_si_esta_activo` (p00:413A, which first checks bit 6 of 0xE002) save the registers, map banks 14 and 15 and call the routine at p14:86BA with the number in A. Low numbers are effects and from 0x3B up there is music; the game computes each stage's, so almost all are tracks «in the table». The voices take 21 bytes from 0xE010 and 0xE079 holds the copy of the PSG mixer, which start-up leaves at 0xB8. Tracks that last over 75 seconds without starting again are cut at 75, and each one says so. Only two tracks have been checked against openMSX, 0x3B and 0x44; the rest come out of the same engine.

## The tunes

**The `estado_9_ultimo` tune** (0x56)

Asked for by `estado_9_ultimo`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_56.mp3?v=62bf9e27"></audio>

**The tune at 0x74EC** (0x38)

Asked for by `L_74EC`; lasts 1.3 s.

<audio controls preload="none" src="audio/musica_38.mp3?v=5f85e65c"></audio>

**Table track 0x3B** (0x3B)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 26.4 s and starts again at second 0.2.

<audio controls preload="none" src="audio/musica_3B.mp3?v=3e4adf00"></audio>

**Table track 0x3C** (0x3C)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_3C.mp3?v=a4679b54"></audio>

**Table track 0x3D** (0x3D)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_3D.mp3?v=eb7581dc"></audio>

**Table track 0x3E** (0x3E)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_3E.mp3?v=8f6a9784"></audio>

**Table track 0x3F** (0x3F)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_3F.mp3?v=d6aa0258"></audio>

**Table track 0x40** (0x40)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_40.mp3?v=3c718116"></audio>

**Table track 0x41** (0x41)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 22.4 s and starts again at second 0.0.

<audio controls preload="none" src="audio/musica_41.mp3?v=3e07a5ab"></audio>

**Table track 0x42** (0x42)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_42.mp3?v=4dc9da26"></audio>

**Table track 0x43** (0x43)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_43.mp3?v=13c3e149"></audio>

**Table track 0x44** (0x44)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_44.mp3?v=be8f4cbe"></audio>

**Table track 0x45** (0x45)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_45.mp3?v=41589fbc"></audio>

**Table track 0x46** (0x46)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_46.mp3?v=546c6f4e"></audio>

**Table track 0x47** (0x47)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_47.mp3?v=15806152"></audio>

**Table track 0x48** (0x48)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_48.mp3?v=1cbd4dc6"></audio>

**Table track 0x49** (0x49)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_49.mp3?v=e60630e0"></audio>

**Table track 0x4A** (0x4A)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 44.8 s and starts again at second 5.6.

<audio controls preload="none" src="audio/musica_4A.mp3?v=b9f45cbd"></audio>

**Table track 0x4B** (0x4B)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_4B.mp3?v=f1c96e15"></audio>

**Table track 0x4C** (0x4C)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_4C.mp3?v=1735471f"></audio>

**Table track 0x4D** (0x4D)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 32.0 s and starts again at second 0.0.

<audio controls preload="none" src="audio/musica_4D.mp3?v=33a7cf66"></audio>

**Table track 0x4E** (0x4E)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_4E.mp3?v=69397aa8"></audio>

**Table track 0x4F** (0x4F)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_4F.mp3?v=e323273e"></audio>

**Table track 0x50** (0x50)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 21.3 s and starts again at second 0.0.

<audio controls preload="none" src="audio/musica_50.mp3?v=7a0d4975"></audio>

**Table track 0x51** (0x51)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_51.mp3?v=461f2765"></audio>

**Table track 0x52** (0x52)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_52.mp3?v=79ed4288"></audio>

**Table track 0x53** (0x53)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 24.0 s and starts again at second 0.8.

<audio controls preload="none" src="audio/musica_53.mp3?v=2f14628a"></audio>

**Table track 0x54** (0x54)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_54.mp3?v=f68babbf"></audio>

**Table track 0x55** (0x55)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_55.mp3?v=3da72aac"></audio>
