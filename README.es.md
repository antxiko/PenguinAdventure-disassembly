# Penguin Adventure / Yume Tairiku Adventure (Konami, 1986, MSX1) — desensamblado

Desensamblado reproducible, byte a byte, del cartucho MegaROM de 128 KB
**Penguin Adventure** (夢大陸アドベンチャー, *Yume Tairiku Adventure*), Konami
**RC-743** (1986), para MSX1. Es la continuación de *Antarctic Adventure*, y de
un cartucho de 32 KB pasa a 128.

El listado se genera trazando el flujo de verdad, banco a banco, y
**reensamblarlo devuelve la ROM original byte a byte**: los dieciséis bancos de
8 KB y la imagen entera de 131.072 bytes. Esa es la prueba que decide si un
desensamblado es fiable; todo lo demás que hay en este repositorio está para
que además el listado no *mienta* sobre lo que reensambla.

*(In English: [README.md](README.md).)*

## Por dónde va

| | |
|---|---|
| ROM | 131.072 bytes, sha256 `525608aa990e1a19285edc98dec3f0aa11339d8a17641c89df3966845d10cc6a` |
| reensambla byte a byte | sí, los 16 bancos y la imagen entera |
| código trazado | 32.185 bytes |
| datos identificados | 98.887 bytes |
| listado | 25.857 líneas |
| puntos de entrada, cada uno con su justificación | 360 |
| etiquetas con nombre | 330 |
| comentarios anclados | 5.000 |
| rangos de datos con explicación | 29 |

## El cartucho

128 KB con el **mapper de Konami SIN SCC** (Konami4): dieciséis bancos de 8 KB.
Para 0x4000-0x5FFF no hay registro —el banco 0 está fijo ahí— y las otras tres
ventanas se eligen escribiendo el número de banco en 0x6000, 0x8000 y 0xA000.
`tools/reconocimiento.py` lo mide sobre los bytes: ni una escritura a 0x5000,
0x7000, 0x9000 ni 0xB000 —los registros del mapper con SCC— y las **512**
escrituras a los registros del Konami4 llevan todas un banco que cumple la
regla, sin una sola excepción.

Los bancos se reparten **de tres en tres**: `ld a,N` y luego
`ld (0x6000),a` / `inc a` / `ld (0x8000),a` / `inc a` / `ld (0xA000),a`, que
llena los 24 KB de golpe con N, N+1 y N+2. Los tríos que aparecen son 1-2-3,
4-5-6 y 7-8-9; los bancos altos van de dos en dos, sin tocar 0x6000.

| banco | se ejecuta en | qué lleva |
|---|---|---|
| 0 | 0x4000 (fijo) | cabecera, INIT, interrupción, despachador, mapper |
| 1, 2, 3 | 0x6000 / 0x8000 / 0xA000 | el código del juego |
| 4, 5, 6 | 0x6000 / 0x8000 / 0xA000 | datos |
| 7, 8 | 0x6000 / 0x8000 | datos |
| 9 | 0xA000 | código |
| 10, 11 | 0x8000 / 0xA000 | datos |
| 12, 13 | 0x8000 / 0xA000 | biblioteca de datos (ver `src/datos.txt`) |
| 14 | 0x8000 | el reproductor de sonido |
| 15 | 0xA000 | datos |

**Ningún banco es de relleno.** Los 128 KB se usan enteros, cosa que no pasa en
todos los MegaROM de la casa.

## El cartucho dice su número de catálogo dos veces

**Al final del banco 3** lleva la marca que Konami escondía en sus cartuchos: el
número de catálogo en BCD y el título en katakana, escrito del revés. Aquí son
dieciséis caracteres que se leen **ユメタイリク アドベンチャー** —*Yume Tairiku
Adventure*— y el `07 43` de **RC-743**.

El hallazgo de esa marca **no es nuestro**: lo destapó
**Manuel Pazos ([@ManuelPazosMSX](https://github.com/ManuelPazos))** en 2021.
Aquí sólo se comprueba que este cartucho la lleva. De paso salen **dos
caracteres nuevos** para la tabla del silabario, que el título permite deducir
sin margen: el índice 49 es la ャ pequeña y el 58 el alargador ー.

**En 0x4010** lleva además la *segunda cabecera*, la que el **Konami Game
Master** lee del cartucho vecino: el marcador `CD` —el de los títulos de
1986-87— y detrás el mismo `07 43`. Sus bytes son punteros a las variables del
juego en la RAM.

## Cómo se monta

Hace falta la ROM en la raíz como `penguinadventure.rom`. **No se distribuye
aquí**; lee [AVISO-LEGAL.md](AVISO-LEGAL.md).

    make comprueba     el sha256 de la ROM
    make reconoce      cabecera, mapper y la regla banco -> org
    make marca         la marca escondida al final del banco 3
    make semillas      vuelve a deducir los .entries y los .nocode
    make trace         traza los 16 bancos
    make listado       genera src/penguinadventure_pNN.asm
    make verify        LA PRUEBA: reensambla y compara con la ROM
    make sanity        lo que el reensamblado no puede cazar
    make test          los tests
    make densidad      cuánto está comentado, banco a banco

## Licencia

El código, los comentarios y las herramientas de este repositorio van con
licencia MIT ([LICENSE](LICENSE)). **El juego no**: es de Konami y de sus
titulares de derechos. Lee [AVISO-LEGAL.md](AVISO-LEGAL.md).
