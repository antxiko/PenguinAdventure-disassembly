# Hallazgos

Lo que aparece al desmontarlo, con la dirección al lado para que se pueda
comprobar.

## Dos claves de teclado: NORIKO y KAZUMI

Se teclean en la pantalla del título —el estado 3, el del PUSH SPACE KEY— y
encienden el **CONTINUE**, que sin ellas no existe.

p02:9522 vigila **nueve** teclas con `SNSMAT` de la BIOS, que devuelve el bit a
cero cuando la tecla está pulsada. A cada una le guarda su estado del cuadro
anterior en un byte propio, y cuando una acaba de pulsarse —antes suelta, ahora
pulsada— apunta su número en una cola de seis en 0xF0F8: los cinco de atrás se
corren con `ldir` y la nueva entra por el final.

Las nueve teclas, con el número que les toca por el orden en que el código las
mira:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|---|
| A | I | K | M | N | O | R | U | Z |

Al pulsar espacio, p02:80F2 compara esas seis con los dos patrones de 0x965F:

```
04 05 06 01 02 05   ->  N O R I K O
02 00 08 07 03 01   ->  K A Z U M I
```

Y no son nueve teclas cualesquiera: son **exactamente** las letras que hacen
falta para escribir esos dos nombres, y ninguna más. Si una clave de teclado
vigila un puñado raro de teclas, esas teclas son el alfabeto de la clave.

**Las dos no hacen lo mismo.** NORIKO deja 0xFE en 0xF0F7 y KAZUMI 0xFF. Con
0xFE o más aparece el CONTINUE (p02:8937 y p02:8A32), pero con 0xFE **justo** el
borrado del fin de partida se salta los 143 bytes de 0xE160 y los 64 del espejo
de pantalla (p02:8985): NORIKO además conserva lo que se lleve encima.

Las dos están comprobadas en openMSX, no sólo leídas. Ver
[En el emulador](EN-EL-EMULADOR.html).

## El final bueno depende de cuántas veces pauses

El hallazgo es de **Manuel Pazos**, que lo contó en una charla. Lo que aporta
este desensamblado es dónde está escrito en el binario y la regla exacta.

p02:81EE sube el contador de **0xE0DE** cada vez que se **entra** en pausa —no al
salir, así que parar y volver a seguir cuenta **una**—. Y al acabar la fase 24,
p02:82DE lo lee:

```
ld a,(0e0deh)   ; las veces que se ha parado
and 003h        ; sus dos bits bajos
dec a
ld c,000h
jr z,...        ; si (cuenta & 3) == 1  ->  c = 0
inc c           ; cualquier otra cosa    ->  c = 1
```

Ese `c` va a 0xE0B9, y el texto del final (p00:5F19) escoge lista según valga
cero o no:

| veces que has pausado | final |
|---|---|
| **1, 5, 9, 13, 17…** | **bueno** — la princesa viva |
| 0, 2, 3, 4, 6, 7, 8… | malo |

Es decir: **el resto de dividir entre cuatro tiene que ser exactamente 1**, y no
pausar nunca da el final malo.

Dos detalles que cambian cómo se juega. La cuenta **no** se borra al perder una
vida —`reempieza` limpia de 0xE1F0 en adelante y no la toca—, pero **sí** se
borra al usar el CONTINUE: el estado 15 limpia 217 bytes desde 0xE086 y 0xE0DE
cae dentro. Si continúas, vuelves a cero.

Y los dos textos están en la ROM, descomprimidos desde el banco 11. El alfabeto
del cartucho es `A = 0x21` y el espacio `0x00`:

```
EPILOGUE                        EPILOGUE
YOU HAVE SUCCEEDED IN           YOU HAVE FAILED TO
RESCUING THE PRINCESS AND       RESCUE THE PRINCESS!
SAVING THE PENGUIN KINGDOM!     PLEASE TRY AGAIN!
CONGRATULATIONS!
```

Los dos comparten la primera línea —el EPILOGUE de 0xBAC0— y se separan en la
siguiente.

**Comprobado en marcha**, no sólo leído: metiendo el juego en el estado 6,
subestado 5 —que es donde está la decisión— con la fase 24 puesta, con **cero**
pausas sale el final malo y con **una** el bueno. Y con un watchpoint sobre
0xE0B9 para ver que quien la escribe es p02:82EA y no el borrado del fin de
partida, que es un error fácil de cometer: ese borrado también la deja a cero y
parece un final bueno.

## La cereza es el único símbolo que cuenta suelto

Los rodillos de la máquina de apostar sacan su símbolo del registro R
enmascarado a cuatro bits, y con ese índice leen la tabla de dieciséis de
0x7B34:

```
00 01 04 03 02 00 01 00 01 02 05 00 01 00 02 03
```

La cereza —el símbolo 0— ocupa **cinco** de las dieciséis casillas: 31,2 % por
rodillo, y al menos una en el **67,5 %** de las tiradas.

Y el reparto de premios de p01:7AF0 la trata aparte. Hay dos cuentas distintas:
una que exige que los tres rodillos sean iguales, y un `inc (hl)` que sube un
contador **por cada** rodillo que valga cero. Los siete multiplicadores de
0x7B23 son 1, 2, 4, 8, 10, 15 y 20, y los tres primeros son los de una, dos y
tres cerezas. Los demás símbolos sólo pagan de tres en tres, y el símbolo 5 se
marca con 0xFF: el premio gordo.

Es la regla clásica de las cerezas de una tragaperras, escrita en Z80. Y la
tabla de premios pintada en la propia máquina dice lo mismo.

## Veinticuatro fases, no trece

Los trece son lo que el cartucho le declara al Konami Game Master en la cabecera
de 0x4010. p02:8328 compara la fase con 0x19, y las tres tablas de guion cierran
en veinticuatro entradas justas. Y el LEVEL 2 del menu del titulo es otro
diseño entero: ni un solo tramo coincide byte a byte con los del LEVEL 1.

## El tiempo corre aunque no se ande

0xE08B no es el largo de la fase: es el tiempo. p02:922D le quita uno **cada 32
cuadros**, se ande o no se ande; por debajo de 0x15 pita un cuadro sí y otro no;
y al acabar la fase p02:94D1 lo cambia por puntos de 0x20 en 0x20.

De ahí que el objeto de p03:B31E, que le suma 0x50 en BCD, no alargue el
recorrido: **da tiempo extra**. Es lo único de todo el cartucho que toca ese
contador después de montada la fase.

## Una vida extra cada 50.000 puntos

El marcador son tres bytes en BCD —seis cifras— y topa en 999999. p02:938B mira
el byte alto contra el umbral de 0xE095: cuando lo alcanza, el umbral **sube 5
en BCD** —otros 50.000— y se da una vida. Si el umbral se desborda se queda en
0xFF, que ya no se alcanza nunca.

Las vidas topan en 99: p01:74E5 mira el acarreo del `daa` y, si se pasa, las
clava en 0x99.

## El blanco aguanta veinte impactos

Lo que se dispara con el segundo botón sale de p03:BD8A y sólo puede haber uno
en vuelo: 0xE500 es la marca. Contra el blanco de 0xE535, cada acierto suma uno
a 0xE53C y hace falta llegar a **veinte** (p01:77D1). Los diecinueve anteriores
sólo suenan. El vigésimo pone los cuatro registros de 0xE550 a 5, apunta 0xE53A
a 0xAE0A y 0xE530 pasa a 2.

## Lo que se lanza APUNTA

El registro de 0xE540 aparece parpadeando 32 cuadros entre dos dibujos —el aviso
de que va a salir— y entonces p03:B1C8 mira dónde está el jugador y escoge uno
de tres pasos: a la izquierda, recto o a la derecha. Si la diferencia es menor de
16 columnas, va recto.

Baja en tres tramos con precisión de subpíxel —un byte de fracción por debajo de
cada coordenada— y cambia de dibujo en cada uno: 0xAC, 0xB0 y 0xB4.

## El relleno de un banco es una instrucción

El `0xFF` con el que se rellena la cola de un banco es `rst 38h`. El trazador se
salía por ahí al banco vecino y daba por código lo que era relleno.

Y peor: este cartucho **cambia de banco con las interrupciones abiertas**, con
semáforo en 0xE005. Ningún trazador estático sigue eso, y de ahí salieron 14 KB
inventados en los bancos 12 y 13 que hubo que declarar a mano.

## Catorce bytes de código muerto

En p01:7B50 hay catorce bytes que se leen limpios como código —`ld a,(0xE0C5) /
and a / ret nz / ld a,(0xE115) / and a / ret z`…— y a los que no salta nadie. Ni
un `call`, ni un `jp`, ni una tabla. Están declarados como datos porque como
código no se ejecutan nunca.

## La D que no es un byte alto

`resta_en_bcd_de_dos_bytes` (p01:6F86) es la rutina con la que se paga en la
tienda y se apuesta. Entra con IX apuntando al número y C con lo que se quita
—pero **la D no es el byte alto del importe**: es lo que se le resta al byte
alto *cuando hay que pedir prestado*, y vale 1 en todas las llamadas. Es el
acarreo a mano, y hace falta porque `daa` no se lleva bien con `sbc`.

Si se lee como un importe de 16 bits, todos los precios de la tienda salen 256
veces más caros de lo que son.
