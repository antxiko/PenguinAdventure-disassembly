# En el emulador

Casi todo lo que hay en esta web sale de leer el binario y de ejecutar sus
rutinas en Python. Pero hay cosas que sólo cierra verlas correr, y las dos
claves de teclado son una de ellas.

## La máquina importa

Con `Philips_VG_8020` este cartucho **no arranca**: el MSX se queda en la
pantalla de inicio del BASIC y no llega a ejecutarse nunca. Con
`C-BIOS_MSX1_EU` sí. Se nota en dos sitios:

- 0xE003, el contador de cuadros, se mueve;
- 0xF0F7 se pone a 0, que es lo que hace el INIT en p00:40BD.

Si se mira a ojo la pantalla y se ve el BASIC, es esto. Y si se miran esas dos
direcciones antes de empezar, se ahorra la tarde.

## Comprobar las dos claves

```
PA_OUT=work/omsx PA_CLAVE=NORIKO openmsx -machine C-BIOS_MSX1_EU \
    -carta penguinadventure.rom -script tools/omsx_claves.tcl
```

La sonda arranca, pulsa espacio para entrar en la pantalla del título, escribe
la palabra letra a letra sobre la matriz de teclado y lee 0xF0F7 y la cola de
0xF0F8. Con `PA_CLAVE=KAZUMI` prueba la otra.

Lo que sale, y es lo que el listado predecía byte a byte:

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

Y con KAZUMI, la cola `02 00 08 07 03 01` y 0xF0F7 a 0xFF.

## Las cuatro trampas, que han costado una tarde

**El estado.** El vigilante de las claves sólo corre en el **estado 3**, que es
la pantalla del PUSH SPACE KEY. El ciclo de atracción va 0 → 1 → 2 → 0 y al 3 no
se llega solo: hay que pulsar para entrar. Teclear la palabra durante la demo no
hace absolutamente nada, y eso no se ve mirando la pantalla.

**`type` no sirve.** Manda la tecla demasiado poco tiempo y el vigilante, que
sólo apunta la tecla cuando **cambia** de suelta a pulsada, no llega a verla. Se
pulsa la matriz a mano con `keymatrixdown` y `keymatrixup`, y hay que **soltar**
entre tecla y tecla: dos pulsaciones seguidas sin soltar en medio son una sola.

**La primera tecla se pierde** si se pulsa en el mismo instante de entrar en el
estado 3. Medio segundo de respiro y entra.

**Las capturas salen rancias** con `throttle off`: el render no se refresca y se
ve la pantalla de hace varios segundos. Para fotografiar hay que correr a
velocidad real.

## Arrancar en la fase que se quiera

No hace falta jugarse el juego entero. La fase está en 0xE092, de 1 a 24, y se
puede escribir desde la consola del emulador:

```
debug write memory 0xE092 12
```

Ojo con las dos tablas de p00:4105 y p00:4113, que **sólo cubren las trece
primeras** de las veinticuatro: es una de las
[preguntas abiertas](PREGUNTAS-ABIERTAS.html).

## Cotejar lo dibujado contra openMSX

Las imágenes de esta web se dibujan leyendo las tablas del cartucho con código
nuestro. Lo que dice que están bien no es mirarlas: es compararlas con
volcados del emulador.

`tools/omsx_fases.tcl` fuerza la fase y el nivel en p00:46E3 —por donde pasan
el montaje normal y el del Game Master— y vuelca la VRAM, la RAM y los
registros del VDP cada tantos cuadros, en cada cambio de estado y en cada
corte del final; y apunta cada cosa que sale en la carretera (p01:6852). Para
llegar al final de las fases largas pone a 1 el periodo del paso (0xE4C0)
justo antes de andar, en p00:4560, y para que el pingüino no se muera mantiene
0xE1F1. Las escenas, el mapa, la pelea y la tienda tienen su propia sonda
(tools/omsx_escenas.tcl, omsx_mapa.tcl, lanza_pelea.sh y omsx_tienda.tcl).

`make coteja` compara con esos volcados:

| qué | cuánto | diferencias |
|---|---|---|
| la pantalla de cada fase | 24 fases | 0 bytes |
| el final: la meta y el dinosaurio | 144 cortes | 0 |
| el pingüino, pose y colocación | 1.107 cuadros | 0 |
| los bichos, dibujo por clase y distancia | 510 objetos | 0 |
| el espacio | 9 pantallas, 8 peces, 13 meteoritos | 0 |
| las cosas de la carretera, LEVEL 1 y 2 | 5.414 | 0 |
| el espejo de pantalla, andando la fase | 424 volcados | 0 |
| el WARP, el decorado 9 | 21 pantallas | 0 |
| el árbol y los dos finales | 3 escenas | 0 |
| lo que se mueve en las escenas | 1.337 volcados | 0 |
| la pelea con el dinosaurio | 3.246 volcados | 0 |
| el mapa de antes de cada fase | 32 volcados | 0 |
| la tienda: los tres tenderos, abierta y al cerrarse | 14 volcados | 0 |

Dos trampas. En el punto de volcado (p00:451C) la tabla de nombres de la VRAM
va un cuadro por detrás del espejo de RAM, así que las casillas se miran en el
espejo. Y las fases 12, 18 y 24 no se acaban sin el objeto de 0xE16C: un
volcado tardío va por otra pasada, con los índices de los guiones iguales y
las ranuras no.
