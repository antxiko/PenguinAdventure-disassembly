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

## Cotejar un dibujo contra la VRAM

Las imágenes de esta web se dibujan ejecutando las rutinas del cartucho en
Python. La forma de comprobar que una está bien no es mirarla: es volcar los
16 KB de VRAM del emulador en el mismo instante y compararlos byte a byte. Si
salen cero diferencias, la imagen es la del cartucho.

Y si salen una o dos, mirar primero si es el **instante** del volcado —una
animación pillada a medias— antes de tocar nada.
