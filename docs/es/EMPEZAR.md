# Empezar

Lo único que hace falta para reproducir este desensamblado es Python 3, GNU
make y [Pasmo](https://pasmo.speccy.org/). La imagen del cartucho **no viaja en
este repositorio**: cada cual pone la suya.

```
penguinadventure.rom    131.072 bytes
sha256                  525608aa990e1a19285edc98dec3f0aa11339d8a17641c89df3966845d10cc6a
```

Con el fichero en la raíz del repositorio:

```
make            # listado, verificación, coherencia y tests
```

## Qué hace cada paso

| orden | qué hace |
|---|---|
| `make listado` | genera los dieciséis `.asm` desde el binario, las notas y las semillas |
| `make verify` | reensambla cada banco y la ROM entera, y compara los sha256 |
| `make sanity` | comprueba que no queda un solo byte sin asignar a código o a datos |
| `make test` | los 30 tests |
| `make densidad` | cuántas instrucciones llevan comentario, banco a banco |
| `make cifras` | vuelve a escribir las cifras de los dos README contando sobre el árbol |
| `make imagenes` | dibuja los 35 PNG desde la ROM |
| `make web` | genera las páginas HTML y comprueba los enlaces |

`make verify` es el que decide. Tiene que imprimir diecisiete veces
`OK: reproducible byte a byte`: una por cada uno de los dieciséis bancos y otra
por la ROM entera. Si falla uno, el listado miente.

## Dónde está cada cosa

- `src/penguinadventure_pNN.asm` — el listado, uno por banco. **Se genera**: no
  se edita a mano.
- `src/pNN.notes` — las etiquetas (`L`), los comentarios de línea (`C`), los
  rangos de datos (`D`) y los encabezados de rutina (`B`). Esto **sí** se edita.
- `src/pNN.entries` — los puntos de entrada del trazado, cada uno con el porqué
  escrito al lado.
- `tools/` — el desensamblador, el trazador, el dibujante y las comprobaciones.
- `work/` — lo intermedio. Está ignorado salvo `work/msx.sym`, que hace falta
  para generar el listado y por eso sí viaja.

## Por qué las notas van aparte del listado

Porque el listado se regenera entero cada vez. Si los comentarios vivieran
dentro del `.asm`, cualquier cambio en el trazado los perdería. Viviendo en los
`.notes`, anclados a su dirección, sobreviven a que el listado se rehaga.

Y de ahí sale una comprobación que no es cosmética: `tools/valida_c.py` mira
que cada comentario cae en el **primer byte** de una instrucción. Uno anclado a
media instrucción no aparece en el listado y nadie se entera de que se ha
perdido.
