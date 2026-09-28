# Preguntas abiertas

Lo que no se sabe, dicho como lo que es. Cada byte del cartucho está asignado a
código o a datos y el listado reensambla byte a byte, pero eso no quiere decir
que todo esté **entendido**.

## Qué banda de distancia es la de cerca

Los bichos escogen uno de sus cuatro dibujos por el byte alto de ix+6 (0x60,
0x78, 0x90 y 0xA8, p09:AA86), y en la lámina van del más pequeño al más grande.
Qué banda corresponde a lo que está cerca no se ha medido: los volcados no lo
zanjan porque los bichos que más salen saltan y su fila no dice la distancia.

## La cabecera del Game Master mete la fase donde el Game Master espera vidas

La segunda cabecera, la de 0x4010, declara trece fases y da las direcciones de
lo que el Konami Game Master sabe tocar. Una de ellas cae donde el Game Master
espera el contador de vidas y lo que hay ahí es la fase. Puede ser deliberado
—para que el Game Master deje cambiar la fase desde su MODIFY MODE— o puede ser
un descuido de Konami. No hay forma de decidirlo desde este binario solo.

## Qué son cuatro de los seis símbolos de la máquina

La cereza y el racimo de uvas se reconocen sin discusión en el dibujo sacado de
la ROM. Los otros cuatro no: hay un dibujo en tonos tostados con verde debajo,
uno rojo, uno azul y el del premio gordo, que es blanco sobre transparente. Se
publican tal como salen y cada cual que los mire.

## El ritmo exacto del truco de la tragaperras

Los tres rodillos se sortean en el mismo bucle y en el mismo cuadro, con un
trozo de código idéntico entre uno y otro, así que sus índices son *r*, *r+k* y
*r+2k* con **k fija**. Y al parar un rodillo el bucle hace una vuelta menos, con
lo que el cuadro tarda un poco menos y R avanza distinto.

De ahí que pulsar a un ritmo fijo no dé azar sino siempre el mismo patrón. Lo
que **no** está medido es cuánto vale esa k módulo 16, porque depende de cuántas
instrucciones lee la CPU dentro del bucle contando la rutina `WRTVRM` de la
BIOS, y esa cambia de un modelo de MSX a otro. Es decir: el truco podría
funcionar en una máquina y no en otra.

## Por qué no arranca en un Philips VG-8020

Está medido que en esa máquina el cartucho se queda en la pantalla de inicio del
BASIC —0xE003 no se mueve y 0xF0F7 no se pone a cero— y que con `C-BIOS_MSX1_EU`
arranca sin problema. No está averiguado **por qué**. La cabecera es correcta,
el `AB` y el INIT de 0x406A se leen bien en 0x4000 desde la propia consola del
emulador, y aun así el BIOS no llega a llamarlo.

## Las tablas que sólo cubren trece fases

p00:4105 y p00:4113 indexan dos tablas con el número de fase, y las dos tienen
trece entradas cuando las fases son veinticuatro. Con una fase de la 14 en
adelante se leen bytes de más allá del final de la tabla. No se ha comprobado en
marcha qué sale de ahí ni si el juego llega alguna vez a ese camino.

## El sonido, por dentro

Las partituras están declaradas enteras y el lenguaje se entiende —`FE 00`
cambia la marca +0x0E y la partitura pasa de lenguaje de efecto a lenguaje de
música—, pero no se ha escrito un reproductor que las saque fuera del cartucho.
Mientras no lo haya, lo que hay es una descripción, no una prueba.

## Lo que pasa por los lados

p01:6AA8 va por cuadros y no por distancia, y el cotejo de la carretera se
salta sus casillas. Lo que sale por los lados no está dibujado ni cotejado.
