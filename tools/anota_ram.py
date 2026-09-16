#!/usr/bin/env python3
"""Anota los accesos a las direcciones de RAM que ya estan identificadas.

El mapa de la RAM de este cartucho se ha ido cerrando leyendo el codigo, y una
vez cerrado no tiene ningun merito -ni ninguna fiabilidad- ir escribiendo a
mano "la fase" cada una de las cuarenta veces que aparece un `ld a,(0xE092)`.
Esto lo hace de una vez y sin equivocarse.

CADA ENTRADA DE LA TABLA LLEVA DE DONDE SALE. Si no se sabe de donde sale, no
esta en la tabla: aqui no se bautiza nada por parecido.

Uso:  anota_ram.py <banco>            lo saca por la salida estandar
      anota_ram.py <banco> --anexa    lo anexa al .notes de ese banco
      anota_ram.py --todos --anexa    los seis bancos con codigo
"""
import io
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, nombre                  # noqa: E402

BANCOS_CON_CODIGO = (0, 1, 2, 3, 9, 14)

# direccion -> (que es, de donde se sabe)
RAM = {
    0xE000: ("la variable de fase", "la cabecera de 0x4010 se la declara al Game Master"),
    0xE003: ("el contador de cuadros", "p00:5DCF y p14 lo usan de reloj"),
    0xE005: ("el semaforo de reentrada de la interrupcion", "p00:4043"),
    0xE006: ("las teclas recien pulsadas", "p00:44BE"),
    0xE007: ("el estado de los mandos del cuadro anterior", "p00:44BE"),
    0xE051: ("la prioridad del efecto que suena", "p14:86EE"),
    0xE079: ("la copia del registro 7 del PSG, el de la mezcla", "p14:8049"),
    0xE07A: ("la marca de silencio general", "p14:8007"),
    0xE083: ("los datos del juego", "la cabecera de 0x4010 (0xD30C)"),
    0xE086: ("el marcador", "la cabecera de 0x4010 (0xD30E)"),
    0xE08B: ("el TIEMPO que queda, en BCD",
             "p02:922D lo baja de uno en uno CADA 32 CUADROS -o sea que corre "
             "solo, se ande o no se ande- y por debajo de 0x15 pita un cuadro "
             "si y otro no; y al acabar la fase, p02:94D1 lo cambia por puntos "
             "de 0x20 en 0x20. Sale de la tabla de 0xACBA (p00:47C4) y el "
             "objeto de p03:B31E le suma 0x50: eso es tiempo extra"),
    0xE08D: ("lo que queda de fase",
             "p01:6233 lo carga del registro de la fase y p01:6507 lo "
             "descuenta en BCD; a los 0x50, 0x30, 0x25, 0x20, 0x15, 0x10, 8, "
             "5, 2 y 0 que quedan se van soltando los pasos del final"),
    0xE092: ("la FASE, de 1 a 24",
             "p02:8328 la sube y la compara con 0x19; y las tres tablas de guion -0xA8FB, 0x8000 y 0xACBA- tienen 24 entradas justas"),
    0xE093: ("el valor 1-2-3 de la fase", "p00:411A, de la tabla de 0x412D"),
    0xE091: ("el numero de fase tal como se pinta", "p00:410C, de la tabla de 0x4120"),
    0xE0A1: ("el DECORADO, de 0 a 9", "p01:6000 despacha por el"),
    0xE0A2: ("el modo en el que esta el juego", "p00:4566 y p09:A83F"),
    0xE0DC: ("la pausa que se hace al perder o al cambiar de fase", "p00:451F"),
    0xE203: ("el ESTADO de lo que se maneja",
             "p01:64F0, p01:6AA8, p01:70E3, p01:712D y p03:B2D9 se plantan si "
             "vale 3, 4, 8 o 10 -los estados en los que no se choca con nada-; "
             "p02:9751 lo pone a 1 o a 2 al saltar, p03:B33B a 15 y p02:925D a "
             "0x15 o 0x16 al perder; y p00:42FB lo mira para decidir por donde "
             "partir la tabla de sprites al subirla"),
    0xE300: ("por que pareja del guion de la fase va", "p09:A85C"),
    0xE301: ("la distancia a la que toca el objeto siguiente",
             "p09:A886 la saca de restarle a lo que queda de fase (0xE08D) lo "
             "que diga el guion, en BCD, y p09:A898 la pone a 0xFFFF -una "
             "distancia a la que no se llega- cuando el guion se acaba"),
    0xE310: ("el primer hueco de objeto, de tres de 0x20 bytes", "p09:A92B"),
    0xE4E0: ("la tabla de cambio de color, nibble alto", "p00:440D"),
    0xE4EC: ("la tabla de cambio de color, nibble bajo", "p00:440D"),
    0xE440: ("las cinco ranuras de lo que se lleva", "p00:4748 y p09:B61B"),
    0xEBA0: ("el espejo de pantalla: la fila 1", "p00:424B lo sube a 0x3820"),
    0xEBE0: ("el espejo de pantalla: la fila 3, donde empieza la zona de juego",
             "p00:4265 lo sube a 0x3860"),
    0xEC80: ("el espejo de pantalla: la fila 8", "p00:4258 lo sube a 0x3900"),
    0xEE80: ("la tabla de atributos de los 32 sprites", "p00:42ED la sube a 0x3B00"),
    0xE090: ("las VIDAS, en BCD",
             "p02:8833 las descuenta con `sub 1` + `daa` y manda a la pantalla "
             "de fin de partida cuando llegan a cero"),
    0xE089: ("el marcador, cifras bajas (BCD)",
             "p03:B426 y p03:B6A0 le suman con `daa`, y el tope es 0x0999"),
    0xE08A: ("el marcador, cifra alta (BCD)", "p03:B431 y p03:B6AB"),
    0xE0CE: ("el paso de la cuenta del bonus", "p03:B63F despacha por el"),
    0xE0D0: ("lo que queda de bonus por pasar al marcador", "p03:B694"),
    0xE204: ("la Y en la pantalla de lo que se maneja",
             "p03:A8DB la mete en el byte Y de los cuatro sprites (0xEE80, "
             "0xEE84, 0xEE88 y 0xEE8C); p02:97EB le suma el arco del salto "
             "(0x97FF: -4 -3 -2 -1 -1 +1 +1 +2 +3 +4) y p03:AD2F los 29 "
             "valores simetricos de 0xADBA"),
    0xE205: ("la X en la pantalla de lo que se maneja",
             "p03:A8DB la mete en el byte X de esos mismos cuatro sprites; "
             "p03:A87A la sube o la baja con las teclas de izquierda y derecha "
             "(bits 2 y 3) y la deja entre 0x14 y 0xCC; y la tabla de salida de "
             "cada decorado (p13:AD1A) la pone en 0x70, el centro justo"),
    0xE096: ("los avisos que deja el cuadro",
             "p02:8257 salta tantos estados como diga cada bit"),
    0xE097: ("la bandera de que la fase se ha acabado", "p02:824D y p00:4622"),
    0xE0A5: ("por que vuelta de la fase va", "p00:45E2 y p02:81C5"),
    0xE082: ("el NIVEL que se elige en el menu: 0 es LEVEL 1 y 1 es LEVEL 2",
             "p02:80F5 borra con ella uno de los dos rotulos -0x8E0A dice "
             "LEVEL 1 y 0x8E14 LEVEL 2- y p02:951A la cambia con dos teclas"),
    0xE08F: ("el NIVEL de la partida en curso",
             "p02:813B copia aqui 0xE082 al empezar, y p01:675B elige con ella "
             "la tabla de terreno: con cero la de 0x8000 y si no la de 0x80F9, "
             "que son DOS juegos completos de 24 tiras"),
    0xE0A0: ("la bandera de PAUSA",
             "p02:81DD le da la vuelta con la tecla de parar y p02:820B manda "
             "al estado 13 mientras este puesta"),
    0xE004: ("el contador de espera del estado", "p02:8091 lo carga y p02:809B lo baja"),
    0xE001: ("el SUBESTADO", "p02:800F lo carga en B y p02:8094 lo sube"),
    0xE0E3: ("que hueco de sprite toca", "p01:6A25 y p01:6A31"),
    0xE2A0: ("la copia de los tres objetos, para la segunda capa de color",
             "p09:A9F5 y p09:AA1C"),
    # --- los cuatro sprites de lo que se maneja, que p03:A8DB monta en cuadro
    # de dos por dos a partir de (0xE204, 0xE205) ---
    0xEE84: ("el sprite 1 de lo que se maneja: arriba a la derecha", "p03:A8E6"),
    0xEE88: ("el sprite 2 de lo que se maneja: abajo a la izquierda", "p03:A8F1"),
    0xEE8C: ("el sprite 3 de lo que se maneja: abajo a la derecha", "p03:A8ED"),
    0xEE90: ("el hueco de sprite 4", "0xEE80 + 4 x 4"),
    0xEE94: ("el hueco de sprite 5", "0xEE80 + 4 x 5"),
    0xEE98: ("el hueco de sprite 6, el del bicho que vuela", "p03:B599"),
    0xEE9C: ("el hueco de sprite 7", "p00:5CB0 le mete la fila y la columna de una vez"),
    0xEEA0: ("el hueco de sprite 8", "p00:5CB8, el companero del anterior"),
    # --- el salto ---
    0xE207: ("el tramo del salto: 1 subiendo, 2 bajando",
             "p02:9756 lo pone a 1 al pulsar, p02:97C7 lo sube a 2 y p02:97D8 "
             "lo devuelve a cero al aterrizar"),
    0xE208: ("el paso dentro del salto",
             "p02:97BD y 97CD lo suben uno cada cuatro cuadros, y con el se "
             "indexa el arco de 0x97FF, que es lo que se le suma a la fila"),
    0xE209: ("hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha",
             "p03:A84B lo saca de los bits 2 y 3 del mando y p03:A87A lo "
             "reparte: con 4 resta de la columna y con 8 suma"),
    0xE20A: ("la direccion congelada mientras dura el salto",
             "p02:975C la copia de 0xE209 al empezar el salto y p02:97DE la "
             "borra al acabarlo"),
    # --- las tres cosas con las que se choca, cada una con su terna ---
    0xE0BB: ("la fila del bicho que vuela", "p03:B54E y p03:B593"),
    0xE0BC: ("la columna del bicho que vuela", "va con la anterior, y p03:B599 las sube juntas al sprite 6"),
    0xE0BD: ("en que tiempo va el bicho que vuela: 0 nada, 1 aparecer, 2 mover",
             "p03:B52E despacha por el"),
    0xE0BE: ("el paso del vaiven del que vuela, de 32", "p03:B56A"),
    0xE0BF: ("hacia que lado cruza el que vuela", "p03:B57D: par a la izquierda, impar a la derecha"),
    0xE0C0: ("cual de las cuatro cosas que se cogen esta puesta",
             "p03:B2D9 se planta si vale cero y p03:B307 despacha por ella - 1"),
    0xE0C3: ("la fila de eso que se coge", "p03:B2ED, contra la de lo que se maneja"),
    0xE0C4: ("la columna de eso que se coge", "va con la anterior"),
    0xE0D7: ("cual es el otro objeto con el que se choca", "p03:B391"),
    0xE0DA: ("la fila de ese otro objeto", "p03:B37F"),
    0xE0DB: ("la columna de ese otro objeto", "va con la anterior"),
    0xE0A6: ("el arrastre de lado que se lleva solo",
             "p03:A8C0: si vale cero no arrastra, y si no, el bit 0 dice si "
             "suma o resta un pixel a la columna cada dos cuadros"),
    0xE4C0: ("el nivel de la barra de nueve",
             "p00:5F7A escoge con ella cual de los nueve guiones de 0x5F99 "
             "pinta, y p03:A084 la vacia al arrancar una secuencia"),
    0xE20B: ("por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha",
             "p01:722C y p01:7233 lo sacan de comparar la columna con el punto "
             "medio de la ventana, y p02:98F2 convierte ese bit 7 en el 4 o el "
             "8 que entiende p03:A87A. En los seis bits bajos lleva ademas el "
             "paso de la caida (p02:98C2 y p02:9924)"),
    0xE20C: ("la cuenta de cuadros del paso de la caida",
             "p02:98BC la carga con 8, p02:991E con 6 y p02:98D7 la baja"),
    0xE21C: ("la cuenta de la espera", "p03:A806 la carga con 16 y p03:A812 la baja"),
    0xE21E: ("por que tiempo va la otra secuencia", "p03:A7CB despacha por el"),
    0xE21F: ("el paso de montar y desmontar la figura",
             "p03:A7DF lo sube hasta 0x90 y p03:A81C lo baja"),
    0xE220: ("cuantos sprites lleva puestos la figura",
             "p03:A7EA lo sube al poner uno y p03:A823 lo baja al quitarlo"),
    0xE21B: ("la cuenta de cuadros del paso en el que va la secuencia",
             "p03:A0B8 la sube hasta 32 y p03:A16D la descuenta desde 0x80"),
    0xE21D: ("por que paso va la secuencia",
             "p03:A08D y p03:A192 despachan por el, y p02:927C lo borra"),
    0xF0F1: ("la copia en RAM del banco de 0x6000", "p00:4077"),
    0xF0F2: ("la copia en RAM del banco de 0x8000", "p00:4079"),
    0xF0F3: ("la copia en RAM del banco de 0xA000", "p00:407F"),
    0xF0F4: ("la segunda copia del banco de 0x8000, la del sonido", "p00:4151"),
    0xF0F5: ("la segunda copia del banco de 0xA000, la del sonido", "p00:4157"),
}

CABECERA = """
# --- Los accesos a la RAM ya identificada. Los anota tools/anota_ram.py con la
# tabla que ese fichero lleva dentro, y cada entrada de esa tabla dice de donde
# se sabe lo que dice.
"""


def anota(banco):
    asm = os.path.join(RAIZ, "src", "penguinadventure_%s.asm" % nombre(banco))
    notas = os.path.join(RAIZ, "src", "%s.notes" % nombre(banco))
    ya = set()
    if os.path.exists(notas):
        for ln in io.open(notas, encoding="utf-8"):
            m = re.match(r"^C 0x([0-9A-Fa-f]{4})\s", ln)
            if m:
                ya.add(int(m.group(1), 16))
    salida = []
    for l in io.open(asm, encoding="utf-8"):
        m = re.search(r"^\s*(.*?)\s*;\s?([0-9a-f]{4})(?:\s|$)", l)
        if not m or not m.group(1):
            continue
        dir_, ins = int(m.group(2), 16), m.group(1).strip()
        if dir_ in ya:
            continue
        # solo `ld ...,(nnnn)` y `ld (nnnn),...`, que son accesos de verdad
        mm = re.search(r"\((0[0-9a-f]{4})h\)", ins)
        if not mm or not ins.startswith("ld "):
            continue
        a = int(mm.group(1), 16)
        if a not in RAM:
            continue
        ya.add(dir_)
        salida.append("C 0x%04X %s" % (dir_, RAM[a][0]))
    return salida, notas


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    bancos = BANCOS_CON_CODIGO if "--todos" in sys.argv else [int(sys.argv[1], 10)]
    for b in bancos:
        salida, notas = anota(b)
        if "--anexa" in sys.argv:
            if salida:
                with io.open(notas, "a", encoding="utf-8", newline="\n") as f:
                    f.write(CABECERA + "\n".join(salida) + "\n")
            print("%s: %d comentarios" % (os.path.basename(notas), len(salida)))
        else:
            print("\n".join(salida))


if __name__ == "__main__":
    main()
