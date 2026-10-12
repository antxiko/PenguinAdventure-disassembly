# La música

Todo lo que suena aquí sale de ejecutar el motor de sonido del cartucho (`cuadro_de_sonido`, 0x8082 del banco 14, y la rutina de p14:86BA que reparte los canales; lo llama la interrupción en p00:4030) en un Z80 emulado, cuadro a cuadro y a 60 por segundo, igual que lo llama el juego. Lo que el motor escribe en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). Cada MP3 es la pieza entera hasta donde vuelve a empezar, más 8 segundos de la vuelta apagándose; las que no se repiten acaban donde acaba el motor.

## Cotejado con openMSX

Las escrituras al PSG se han comparado cuadro a cuadro con las de openMSX (C-BIOS MSX1 japonés). En todos los cuadros el PSG queda igual:

- la pista 0x3B, sus primeros 218 cuadros;
- la pista 0x44, sus primeros 218 cuadros.

El timbre no está cotejado: es el de un AY-3-8910 de manual, no una grabación del emulador. Las sondas están en `tools/omsx_psg.tcl` y `tools/coteja_psg.py`.

## Cómo se pide una pieza

`pide_sonido` (p00:4145) y `pide_sonido_si_esta_activo` (p00:413A, que mira antes el bit 6 de 0xE002) guardan los registros, mapean los bancos 14 y 15 y llaman a la rutina de p14:86BA con el número en A. Los números bajos son efectos y del 0x3B en adelante hay música; el juego calcula el de cada fase, así que casi todas son pistas «de la tabla». Las voces ocupan 21 bytes desde 0xE010 y 0xE079 guarda la copia del mezclador del PSG, que el arranque deja en 0xB8. Las pistas que duran más de 75 segundos sin volver a empezar se cortan a los 75, y así se dice en cada una. Solo hay dos pistas cotejadas con openMSX, la 0x3B y la 0x44; las demás salen del mismo motor.

## Las músicas

**La pieza de `estado_9_ultimo`** (0x56)

Lo pide `estado_9_ultimo`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_56.mp3?v=62bf9e27"></audio>

**La pieza del 0x74EC** (0x38)

Lo pide `L_74EC`; dura 1,3 s.

<audio controls preload="none" src="../audio/musica_38.mp3?v=5f85e65c"></audio>

**Pista 0x3B de la tabla** (0x3B)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 26,4 s y vuelve a empezar en el segundo 0,2.

<audio controls preload="none" src="../audio/musica_3B.mp3?v=3e4adf00"></audio>

**Pista 0x3C de la tabla** (0x3C)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_3C.mp3?v=a4679b54"></audio>

**Pista 0x3D de la tabla** (0x3D)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_3D.mp3?v=eb7581dc"></audio>

**Pista 0x3E de la tabla** (0x3E)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_3E.mp3?v=8f6a9784"></audio>

**Pista 0x3F de la tabla** (0x3F)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_3F.mp3?v=d6aa0258"></audio>

**Pista 0x40 de la tabla** (0x40)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_40.mp3?v=3c718116"></audio>

**Pista 0x41 de la tabla** (0x41)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 22,4 s y vuelve a empezar en el segundo 0,0.

<audio controls preload="none" src="../audio/musica_41.mp3?v=3e07a5ab"></audio>

**Pista 0x42 de la tabla** (0x42)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_42.mp3?v=4dc9da26"></audio>

**Pista 0x43 de la tabla** (0x43)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_43.mp3?v=13c3e149"></audio>

**Pista 0x44 de la tabla** (0x44)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_44.mp3?v=be8f4cbe"></audio>

**Pista 0x45 de la tabla** (0x45)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_45.mp3?v=41589fbc"></audio>

**Pista 0x46 de la tabla** (0x46)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_46.mp3?v=546c6f4e"></audio>

**Pista 0x47 de la tabla** (0x47)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_47.mp3?v=15806152"></audio>

**Pista 0x48 de la tabla** (0x48)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_48.mp3?v=1cbd4dc6"></audio>

**Pista 0x49 de la tabla** (0x49)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_49.mp3?v=e60630e0"></audio>

**Pista 0x4A de la tabla** (0x4A)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 44,8 s y vuelve a empezar en el segundo 5,6.

<audio controls preload="none" src="../audio/musica_4A.mp3?v=b9f45cbd"></audio>

**Pista 0x4B de la tabla** (0x4B)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_4B.mp3?v=f1c96e15"></audio>

**Pista 0x4C de la tabla** (0x4C)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_4C.mp3?v=1735471f"></audio>

**Pista 0x4D de la tabla** (0x4D)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 32,0 s y vuelve a empezar en el segundo 0,0.

<audio controls preload="none" src="../audio/musica_4D.mp3?v=33a7cf66"></audio>

**Pista 0x4E de la tabla** (0x4E)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_4E.mp3?v=69397aa8"></audio>

**Pista 0x4F de la tabla** (0x4F)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_4F.mp3?v=e323273e"></audio>

**Pista 0x50 de la tabla** (0x50)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 21,3 s y vuelve a empezar en el segundo 0,0.

<audio controls preload="none" src="../audio/musica_50.mp3?v=7a0d4975"></audio>

**Pista 0x51 de la tabla** (0x51)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_51.mp3?v=461f2765"></audio>

**Pista 0x52 de la tabla** (0x52)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_52.mp3?v=79ed4288"></audio>

**Pista 0x53 de la tabla** (0x53)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; dura 24,0 s y vuelve a empezar en el segundo 0,8.

<audio controls preload="none" src="../audio/musica_53.mp3?v=2f14628a"></audio>

**Pista 0x54 de la tabla** (0x54)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_54.mp3?v=f68babbf"></audio>

**Pista 0x55 de la tabla** (0x55)

Lo pide ninguna llamada directa: sale de la tabla de pistas por un número calculado; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_55.mp3?v=3da72aac"></audio>
