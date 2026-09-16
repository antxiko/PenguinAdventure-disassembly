# El cartucho

128 KB con el **mapper Konami SIN SCC** (Konami4): dieciséis bancos de 8 KB.
No hay registro para 0x4000-0x5FFF —el banco 0 está fijo ahí— y las otras tres
ventanas se eligen escribiendo el número de banco en 0x6000, 0x8000 y 0xA000.

`tools/reconocimiento.py` lo mide sobre los propios bytes: ni una sola escritura
a 0x5000, 0x7000, 0x9000 o 0xB000 —los registros del mapper *con* SCC— y las
**512** escrituras a los registros Konami4 llevan todas un banco que cumple la
regla, sin una excepción.

## Los bancos van de tres en tres

Siempre el mismo baile, y cada paso tiene su motivo:

```
di                  mientras el mapa está a medias no puede entrar la
                    interrupción, que lee del cartucho
ld hl,0xF0F1        las tres copias en RAM, una por ranura y seguidas
ld a,N              el primer banco del trío
ld (0x6000),a       al registro del mapper
ld (hl),a           y apuntado en su copia
inc a / inc hl      el banco siguiente y la copia siguiente
ei                  ya se puede volver a interrumpir
```

Las copias de 0xF0F1, 0xF0F2 y 0xF0F3 existen porque el mapper **no se puede
leer**: escribir en 0x6000 pone el banco, pero no hay forma de preguntar cuál
hay. Quien necesite devolverlo tiene que haberlo apuntado.

## Qué hay en cada banco

| bancos | qué llevan |
|---|---|
| 0 | el núcleo: interrupción, descompresor, pintores, los puentes a los datos |
| 1, 2, 3, 9, 14 | código |
| 4 a 8, 10 a 13, 15 | datos: caracteres, decorados, guiones de fase, sonido |

Los bancos de datos no ejecutan ni una instrucción: se mapean, se lee y se
devuelven. p00:479D es el ejemplo limpio —mete los bancos 12 y 13 sólo para leer
cuatro bytes de la tabla de 0xACBA— y de 0x47E2 en adelante hay una fila larga
de puentes que hacen justo eso. Están en el banco fijo porque es el único sitio
desde el que se puede cambiar de banco sin quedarse sin suelo.

## Lo que hace el INIT

La cabecera de 0x4000 es `AB` con INIT en 0x406A, y esa rutina hace cuatro cosas
antes de no volver nunca —acaba en un `jr` a sí misma—:

1. pone el trío 1-2-3 y lo apunta en las tres copias;
2. lee con `RSLREG` el registro de ranuras primarias y se queda con **los bits
   de la página 1**, que es donde está el cartucho; con `ENASLT` mete esa misma
   ranura en la **página 2**, y así el cartucho ocupa de 0x4000 a 0xBFFF;
3. engancha su interrupción en `H.KEYI` (0xFD9A) con un `jp`;
4. borra de un tirón los 0x10EF bytes de 0xE000 a 0xF0F0, planta la pila justo
   ahí y suelta el semáforo de 0xE005.

## La segunda cabecera: el Konami Game Master

En 0x4010 hay otra cabecera, `CD`, que es la que el **Konami Game Master** lee.
Le declara trece fases —que no son las veinticuatro que el juego tiene— y le da
las direcciones de las cosas que el Game Master sabe tocar: los datos de la
partida, el marcador y la rutina a la que saltar.

Esa rutina es `arranca_en_la_fase_pedida` (p00:40F7), y **no la llama ni una
instrucción de este cartucho**. Que es del Game Master lo dice su primera
instrucción: lee 0xD31A, que es RAM del Game Master —donde apunta la fase que el
usuario ha pedido en su MODIFY MODE—, y ahí un dato de este juego no tendría
nada que hacer.

## El mapa de la VRAM, que está del revés

Los ocho bytes que p00:44AE escribe del registro 7 al 0 dan un reparto que no es
el de casi ningún juego de MSX1:

| dónde | qué |
|---|---|
| 0x0000-0x17FF | tabla de **colores** (R3 = 0x7F) |
| 0x1800-0x1FFF | patrones de los sprites (R6 = 0x03) |
| 0x2000-0x37FF | tabla de **patrones** (R4 = 0x07) |
| 0x3800-0x3AFF | tabla de nombres (R2 = 0x0E) |
| 0x3B00-0x3B7F | atributos de los sprites (R5 = 0x76) |

Colores **debajo** de patrones. R3 y R4 no son direcciones sino base y máscara,
y leerlos al revés da formas correctas con los colores a franjas.

## La marca oculta de Konami

Al final de la ROM está la marca que Manuel Pazos documentó: el número de
catálogo —**RC-743**— y el título en katakana, escritos con un silabario propio.
`tools/marca_konami.py` la saca y la coteja. El hallazgo es suyo; aquí sólo se
comprueba sobre este cartucho.
