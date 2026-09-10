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
    0xE08B: ("el largo de la fase", "p00:47C4, de la tabla de 0xACBA"),
    0xE08D: ("la distancia a la que sale el objeto siguiente", "p09:A844"),
    0xE092: ("la FASE, de 1 a 13", "p00:47B1, p00:4101 y p01:6216 la indexan"),
    0xE093: ("el valor 1-2-3 de la fase", "p00:411A, de la tabla de 0x412D"),
    0xE091: ("el numero de fase tal como se pinta", "p00:410C, de la tabla de 0x4120"),
    0xE0A1: ("el DECORADO, de 0 a 9", "p01:6000 despacha por el"),
    0xE0A2: ("el modo en el que esta el juego", "p00:4566 y p09:A83F"),
    0xE0DC: ("la pausa que se hace al perder o al cambiar de fase", "p00:451F"),
    0xE203: ("por que hueco se parte la tabla de sprites al subirla",
             "p00:42FB y p00:4332 comparan con 4 y con 16 para elegir "
             "en cuantos trozos y desde donde subirla"),
    0xE300: ("por que pareja del guion de la fase va", "p09:A85C"),
    0xE301: ("lo andado en la fase", "p09:A848"),
    0xE310: ("el primer hueco de objeto, de tres de 0x20 bytes", "p09:A92B"),
    0xE4E0: ("la tabla de cambio de color, nibble alto", "p00:440D"),
    0xE4EC: ("la tabla de cambio de color, nibble bajo", "p00:440D"),
    0xE440: ("las cinco ranuras de lo que se lleva", "p00:4748 y p09:B61B"),
    0xEBA0: ("el espejo de pantalla: la fila 1", "p00:424B lo sube a 0x3820"),
    0xEBE0: ("el espejo de pantalla: la fila 3, donde empieza la zona de juego",
             "p00:4265 lo sube a 0x3860"),
    0xEC80: ("el espejo de pantalla: la fila 8", "p00:4258 lo sube a 0x3900"),
    0xEE80: ("la tabla de atributos de los 32 sprites", "p00:42ED la sube a 0x3B00"),
    0xE204: ("la X en la pantalla de lo que se maneja",
             "p01:6286 y p01:6C10 la cargan junto a la Y de tablas de tres "
             "bytes; p02:97EB le suma deltas y p02:98CA la devuelve a 0x90"),
    0xE205: ("la Y en la pantalla de lo que se maneja",
             "va siempre con la anterior, y p01:70F5 las compara las dos "
             "contra los cuatro bytes de un rectangulo"),
    0xE096: ("los avisos que deja el cuadro",
             "p02:8257 salta tantos estados como diga cada bit"),
    0xE097: ("la bandera de que la fase se ha acabado", "p02:824D y p00:4622"),
    0xE0A5: ("por que vuelta de la fase va", "p00:45E2 y p02:81C5"),
    0xE082: ("uno o dos jugadores", "p02:80F5 elige el rotulo con ella"),
    0xE0A0: ("la bandera de PAUSA",
             "p02:81DD le da la vuelta con la tecla de parar y p02:820B manda "
             "al estado 13 mientras este puesta"),
    0xE004: ("el contador de espera del estado", "p02:8091 lo carga y p02:809B lo baja"),
    0xE001: ("el SUBESTADO", "p02:800F lo carga en B y p02:8094 lo sube"),
    0xE0E3: ("que hueco de sprite toca", "p01:6A25 y p01:6A31"),
    0xE2A0: ("la copia de los tres objetos, para la segunda capa de color",
             "p09:A9F5 y p09:AA1C"),
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
