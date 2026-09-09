# Aviso legal y atribucion

*(Also available [in English](LEGAL-NOTICE.md).)*

## De quien es cada cosa

**El juego no es nuestro.** *Penguin Adventure / Yume Tairiku Adventure* lo publico **Konami** para MSX en 1986; su
numero de catalogo es **RC-743** y son 128 KB, un MegaROM con el mapper Konami
sin SCC. Todos los derechos sobre el juego
siguen siendo de sus titulares.

**Lo que si es nuestro** son las herramientas de este repositorio, los
comentarios del listado, el analisis y la documentacion. Eso se publica con la
licencia de `LICENSE`.

## Que hay en este repositorio

Los ficheros `src/penguinadventure_pNN.asm` son el desensamblado comentado del
cartucho, uno por cada uno de sus dieciseis bancos de 8 KB. Se publica
para la **preservacion, el estudio y la documentacion** de un titulo que es
parte de la historia del software del MSX.

La imagen del cartucho (`.rom`) **no** se distribuye aqui. Quien quiera volver a
montar el listado tiene que poner la suya, y el `Makefile` comprueba su sha256
antes de hacer nada.

Los bloques comprimidos que declara el listado no se han estimado a ojo: los
cuenta `tools/rle.py` descomprimiendolos de verdad, y que encajen unos con
otros sin dejar ni un byte suelto es parte de la prueba de que el formato esta
bien leido. Si estuviera mal, el bloque siguiente empezaria donde no debe.

## En que se apoya

En nada de nadie. Todo lo que se afirma aqui sale de leer este binario o de
medirlo corriendo, y cada afirmacion lleva su evidencia al lado: la instruccion
que lee un dato, la tabla que cierra exactamente donde tiene que cerrar, o la
medida hecha en el emulador. Lo que no esta cerrado se dice que no lo esta.

Donde se cita algo de fuera del cartucho se dice de donde sale y se da las
gracias a quien lo hallo:

- **El formato de la marca oculta de Konami** -el numero de catalogo en BCD y
  el titulo en katakana al final de un banco- lo descubrio **Manuel Pazos
  (@ManuelPazosMSX)** en 2021. Sin ese hallazgo no habria donde mirar. Lo que
  se hace aqui es comprobar que este cartucho la lleva y leerla.
- **Que significan los bytes de la segunda cabecera de 0x4010** sale de leer el
  cartucho de trucos que los usa, el **Konami Game Master (RC-741)**, que esta
  desensamblado en esta misma serie: es su rutina de 0x5E64 la que dice cual de
  esos punteros son las vidas, cual la fase y cual el marcador.

## Si eres uno de los autores

Si trabajaste en *Penguin Adventure / Yume Tairiku Adventure* o tienes derechos sobre el juego, y preferirias que este
material no estuviera publicado, **dilo y se retira, sin discusion**. La
intencion de este trabajo es justo la contraria de perjudicarte: es dejar
constancia de como se hizo.
