# El código

## La máquina de estados

Dieciséis estados y, dentro de cada uno, tantos subestados como haga falta. El
truco está en el `ld bc,(0xE000)` de p02:800F: con una sola instrucción se
cargan los dos —el estado en C y el subestado en B—, y luego el despachador de
la casa salta por C mientras cada estado va bajando B con `djnz` hasta dar con
el subestado que toca. Salir de un subestado es tan corto como `inc (hl)` sobre
0xE001.

Y un detalle de p02:800B: en los estados 0, 1 y 2 se mete 0x8A55 en la **pila**
antes de despachar, de modo que cuando el estado haga `ret` no vuelva a quien le
llamó sino ahí. Es una forma de encadenar sin gastar una llamada.

El ciclo de atracción es 0 → 1 → 2 → 0. Al estado 3 —la pantalla del título con
PUSH SPACE KEY— sólo se entra pulsando.

## El despachador de la casa

`call despacha` (p00:4060) con el índice en A, y **los punteros van pegados
detrás de la propia llamada**: la rutina saca la dirección de retorno de la
pila, la usa de base de la tabla y salta. No gasta ni un registro en pasar la
tabla, y por eso en el listado los `defw` aparecen justo después del `call`.

## Los tres formatos de guion

El cartucho no tiene un descompresor: tiene tres formas de soltar bytes, y las
tres se ejecutan en Python en `tools/graficos.py` para dibujar las imágenes de
esta web.

**El comprimido** (p00:418C a la RAM, p00:4386 a la VRAM). Una palabra de
destino y luego órdenes:

| byte | qué hace |
|---|---|
| `0x00` | se acabó |
| `0x80` pelado | detrás viene otra palabra de destino |
| bit 7 puesto | los siete de abajo son cuántos bytes van tal cual |
| bit 7 claro | los siete de abajo son cuántas veces se repite el que viene |

Cada byte pasa además por p00:43F9, que es donde se le da la vuelta —un carácter
espejado es el mismo byte leído del revés, p00:4402— o se le cambian los
colores por parejas (p00:440D).

**El de máscara** (p00:42BC y p00:42BE). Sin compresión ninguna: una palabra de
destino, `0xFF` acaba, `0xFE` abre otro tramo y lo demás son bytes tal cual.
Lo interesante es el `and c` de p00:42C9: con la máscara a cero lo que se
escribe son ceros, o sea que **el mismo guion sirve para pintar un rótulo y para
borrarlo**. Es lo que hace la tienda al cerrarse.

**El de bloque** (p00:43B3). Bytes sin comprimir de dieciséis en dieciséis, y el
bit 0 de H manda: si está puesto, cada columna se pinta **dos veces**, la segunda
dada la vuelta. Por eso en la ROM hay media figura y no la figura entera.

## Los objetos, y las tres coordenadas

Hay tres juegos de huecos, y el primero explica cómo está hecho el juego.

**0xE310: tres huecos de 0x20 bytes.** Cada objeto tiene **tres** coordenadas,
no dos, y cada una con su velocidad de 16 bits:

```
+0x00  qué clase de objeto es; un cero quiere decir hueco libre
+0x02  la columna de pantalla    +0x03  la fila
+0x06  X, en 16 bits             +0x0C  su velocidad
+0x08  Y, en 16 bits             +0x0E  su velocidad
+0x0A  Z -la PROFUNDIDAD-        +0x10  su velocidad
+0x12  si se mueve solo
```

La Z es lo que hace que las cosas vengan hacia ti: p09:A966 saca la columna de
pantalla **restando la profundidad a la X** y quedándose con el byte alto, que
es lo que da la perspectiva. Y p09:AA18 escoge uno de cuatro dibujos según el
byte alto de la X: el mismo bicho de mayor a menor.

**0xE370: tres huecos de 0x10 bytes**, con dos coordenadas y sus velocidades.

**0xE3A0: tres huecos de 0x10 bytes** para lo que vuela por el aire. Cada uno
lleva **dos sprites**, no uno: fila, columna, dibujo y color el primero, y fila,
columna y dibujo el segundo, que hereda el color. Esa es la forma de la casa de
pintar una figura de dos colores en un MSX1, donde un sprite es de un color.

## Lo que se maneja

Cuatro sprites en cuadro de dos por dos, colocados por p03:A8DB a partir de
(0xE204, 0xE205) —fila y columna—, y la pose la pone p03:A8F5 desde la tabla de
0xA91D: trece poses de ocho bytes, cuatro parejas de (patrón, color) cada una.

El **estado** de lo que se maneja es 0xE203, y no es un contador de animación:
es de lo que cuelga casi todo. Los estados 3, 4, 8 y 10 son en los que no se
choca con nada; p02:9751 lo pone a 1 o a 2 al saltar, p03:B33B a 15, y p02:925D
a 0x15 o 0x16 al perder. p00:42FB lo mira sólo para decidir por dónde partir la
tabla de sprites al subirla: en el estado 4 adelanta los sprites 4 y 5 y en el
16 los ocho de 0xEEE0, que en un VDP que sólo pinta cuatro por línea es darles
prioridad.

## El espejo de pantalla

La RAM de 0xEBA0 a 0xEEFF es copia exacta de la VRAM de 0x3820 a 0x3B7F, con
0x4C80 de diferencia: 0xEBA0 es la fila 1, 0xEBE0 la 3 —donde empieza la zona de
juego— y 0xEE80 la tabla de atributos de los sprites. La pantalla se monta en
RAM y se sube de golpe con `outi`, que es la única forma de llenar la VRAM a la
velocidad de un cuadro.

Y ojo con la cuenta del bucle de p00:4270: `ld b,d` entra con 0x40, pero cada
vuelta baja B **dos veces** —una el `outi`, que es «saca y decrementa», y otra el
`djnz`—, así que salen 32 bytes por vuelta y no 64. Y 32 es justo el ancho de
una fila.

## Trigonometría de verdad

Las curvas están escritas en la ROM y se leen: una circunferencia de 24 pasos y
una parábola de 32. Pero para **apuntar** al jugador el banco 9 calcula:

- p09:ACE3 divide 16 entre 8 bits restando y desplazando, porque el Z80 no tiene
  `div`;
- p09:ACF8 hace dos divisiones seguidas para sacar la tangente con parte entera
  y fracción;
- p09:ACBA busca esa tangente en la tabla de **ocho** de 0xADB8 —0x04F6, 0x0266,
  0x017D, 0x00FF, 0x00AA, 0x0069, 0x0032 y 0—, que son las tangentes de 78,75°,
  67,5°, 56,25°, 45°, 33,75°, 22,5°, 11,25° y 0°. Eso es una **arcotangente**.

El ángulo sale en las 256 unidades de circunferencia de la casa, y p09:AD27 lo
descompone otra vez en sus dos componentes leyendo la curva de 65 de 0xAD77 dos
veces, en B y en 0x40 − B.

## El azar

No hay generador. El azar sale del **registro R del Z80**, el contador de
refresco de memoria, que sube uno por cada instrucción que la CPU lee. p00:5630
lo usa para elegir uno de cuatro fondos, p09:AADA para el lado y el empujón de un
bicho, y p01:79A1 para los rodillos de la máquina de apostar.

Es barato y no es azar: R es un contador, y dos lecturas separadas por un trozo
de código fijo se diferencian en una cantidad **fija**.
