#!/usr/bin/env python3
"""Dibuja desde la ROM: ejecuta en Python lo que el cartucho hace con el Z80.

Aqui no hay ni una captura de emulador. Lo que se ejecuta es el mismo codigo
del cartucho, reescrito instruccion a instruccion:

  - `descomprime` es la rutina de p00:418C, la que lee un guion con su destino
    delante y lo suelta en la RAM.
  - `pinta` es la de p00:4386, que lee el MISMO formato pero lo manda al puerto
    del VDP en vez de a la RAM, pasando cada byte por p00:43F9 -que es donde se
    le da la vuelta o se le cambian los colores-.
  - `da_la_vuelta` es p00:4402 y `cambia_colores` es p00:440D.
  - `pinta_en_los_tres` es p00:42A4, que repite lo mismo en los tres bloques de
    2 KB en que el modo 2 parte la pantalla.

EL MAPA DE LA VRAM sale de los ocho bytes de p00:44AE, que se escriben del
registro 7 al 0, y esta del reves de lo que se ve en casi todos los juegos:

    0x0000-0x17FF   tabla de COLORES        (R3 = 0x7F)
    0x1800-0x1FFF   patrones de los sprites (R6 = 0x03)
    0x2000-0x37FF   tabla de PATRONES       (R4 = 0x07)
    0x3800-0x3AFF   tabla de nombres        (R2 = 0x0E)
    0x3B00-0x3B7F   atributos de los sprites(R5 = 0x76)

Uso:
    graficos.py inventario     que toca cada guion, sin dibujar nada
    graficos.py laminas        las hojas de patrones y colores de cada guion
    graficos.py                todo lo anterior y las imagenes de docs/
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from paginas import ORG, TAM_PAGINA, N_PAGINAS               # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM = os.path.join(RAIZ, "penguinadventure.rom")
IMAGENES = os.path.join(RAIZ, "docs", "imagenes")

COLORES = 0x0000
SPRITES_PAT = 0x1800
PATRONES = 0x2000
NOMBRES = 0x3800
SPRITES_ATR = 0x3B00

# La paleta del TMS9918, tal como la da el manual del VDP.
PALETA = [
    (0, 0, 0), (0, 0, 0), (33, 200, 66), (94, 220, 120),
    (84, 85, 237), (125, 118, 252), (212, 82, 77), (66, 235, 245),
    (252, 85, 84), (255, 121, 120), (212, 193, 84), (230, 206, 128),
    (33, 176, 59), (201, 91, 186), (204, 204, 204), (255, 255, 255),
]


class Cartucho:
    """Los 128 KB con el mapper puesto, igual que tools/bancos.py."""

    def __init__(self, ruta=ROM):
        with open(ruta, "rb") as f:
            self.rom = f.read()
        if len(self.rom) != TAM_PAGINA * N_PAGINAS:
            raise SystemExit("la ROM mide %d bytes y no %d"
                             % (len(self.rom), TAM_PAGINA * N_PAGINAS))

    def leer(self, addr, bancos):
        """Un byte, sabiendo que banco hay en cada ranura.

        `bancos` es (b6000, b8000, bA000). La pagina de 0x4000 es siempre el
        banco 0: no hay registro para ella.
        """
        if 0x4000 <= addr < 0x6000:
            b = 0
        elif 0x6000 <= addr < 0x8000:
            b = bancos[0]
        elif 0x8000 <= addr < 0xA000:
            b = bancos[1]
        elif 0xA000 <= addr < 0xC000:
            b = bancos[2]
        else:
            raise ValueError("%#06x no cae en el cartucho" % addr)
        return self.rom[b * TAM_PAGINA + (addr & 0x1FFF)]


def da_la_vuelta(v):
    """p00:4402. Un caracter espejado es el mismo byte leido del reves."""
    r = 0
    for _ in range(8):
        r = ((r << 1) | (v & 1)) & 0xFF
        v >>= 1
    return r


def cambia_colores(v, bajo, alto):
    """p00:440D. Seis parejas para el nibble de abajo y seis para el de arriba.

    `bajo` y `alto` son listas de (de, a) de como mucho seis parejas, tal como
    estan en 0xE4EC y 0xE4E0 de la RAM.
    """
    n = v & 0x0F
    for de, a in bajo:
        if n == de:
            v = (v & 0xF0) | (a & 0x0F)
            break
    n = v & 0xF0
    for de, a in alto:
        if n == (de & 0xF0):
            v = (v & 0x0F) | (a & 0xF0)
            break
    return v


class Lienzo:
    """Los 16 KB de VRAM, y de paso la cuenta de que se ha tocado."""

    def __init__(self):
        self.v = bytearray(0x4000)
        self.tocado = bytearray(0x4000)

    def escribe(self, addr, valor):
        addr &= 0x3FFF
        self.v[addr] = valor
        self.tocado[addr] = 1

    def rangos(self):
        """Los tramos tocados, como lista de (ini, fin)."""
        fuera, ini = [], None
        for i in range(0x4000):
            if self.tocado[i] and ini is None:
                ini = i
            elif not self.tocado[i] and ini is not None:
                fuera.append((ini, i))
                ini = None
        if ini is not None:
            fuera.append((ini, 0x4000))
        return fuera


def _manda(cart, bancos, de):
    """Lee un byte del guion y avanza. Devuelve (byte, de+1)."""
    return cart.leer(de, bancos), de + 1


def pinta(cart, bancos, de, lienzo, dest=None, c=0, bajo=(), alto=()):
    """p00:4386. El guion, byte a byte, al lienzo.

    Si `dest` es None se lee del propio guion, que es lo que hace la puerta de
    p00:4381 (`pinta_sin_color`). El formato, que sale de las cinco
    instrucciones de p00:438F:

        0x00        se acabo
        0x80        vuelve a leer una palabra de destino, y ademas C a cero
        bit 7 PUESTO    los siete de abajo son cuantos bytes van tal cual
        bit 7 CLARO     los siete de abajo son cuantas veces se repite el que viene

    C manda sobre cada byte: el bit 0 lo da la vuelta y el bit 7 le cambia los
    colores.
    """
    if dest is None:
        lo, de = _manda(cart, bancos, de)
        hi, de = _manda(cart, bancos, de)
        dest = lo | (hi << 8)
    while True:
        mando, de = _manda(cart, bancos, de)
        if mando == 0x00:
            return de
        n = mando & 0x7F
        if n == mando:                       # bit 7 claro: repetir
            v, de = _manda(cart, bancos, de)
            v = _prepara(v, c, bajo, alto)
            for _ in range(n):
                lienzo.escribe(dest, v)
                dest += 1
        elif n == 0:                         # 0x80 pelado: otro destino
            c = 0
            lo, de = _manda(cart, bancos, de)
            hi, de = _manda(cart, bancos, de)
            dest = lo | (hi << 8)
        else:                                # bit 7 puesto: literales
            for _ in range(n):
                v, de = _manda(cart, bancos, de)
                lienzo.escribe(dest, _prepara(v, c, bajo, alto))
                dest += 1


def _prepara(v, c, bajo, alto):
    """p00:43F9. Lo que se le hace a cada byte antes de soltarlo."""
    if c & 0x80:
        return cambia_colores(v, bajo, alto)
    if c & 0x01:
        return da_la_vuelta(v)
    return v


def pinta_en_los_tres(cart, bancos, de, lienzo, dest, c=0, bajo=(), alto=()):
    """p00:42A4. Lo mismo en los tres bloques de 2 KB del modo 2."""
    for k in range(3):
        pinta(cart, bancos, de, lienzo, dest + k * 0x800, c, bajo, alto)


def descomprime(cart, bancos, hl, ram):
    """p00:418C. El mismo formato, pero a la RAM en vez de a la VRAM.

    `ram` es un bytearray de 64 KB. Devuelve la lista de tramos escritos.
    """
    tramos = []
    lo = cart.leer(hl, bancos); hl += 1
    hi = cart.leer(hl, bancos); hl += 1
    dest = lo | (hi << 8)
    ini = dest
    while True:
        mando = cart.leer(hl, bancos); hl += 1
        if mando == 0x00:
            tramos.append((ini, dest))
            return tramos
        n = mando & 0x7F
        if n == mando:                       # repetir
            v = cart.leer(hl, bancos); hl += 1
            for _ in range(n):
                ram[dest & 0xFFFF] = v
                dest += 1
        elif n == 0:                         # otro destino
            tramos.append((ini, dest))
            lo = cart.leer(hl, bancos); hl += 1
            hi = cart.leer(hl, bancos); hl += 1
            dest = lo | (hi << 8)
            ini = dest
        else:                                # literales
            for _ in range(n):
                ram[dest & 0xFFFF] = cart.leer(hl, bancos)
                hl += 1
                dest += 1


# --------------------------------------------------------------------- dibujo
def pinta_pantalla(lienzo):
    """La pantalla de 256x192 tal como la sacaria el VDP en modo 2."""
    img = [[0] * 256 for _ in range(192)]
    for fila in range(24):
        for col in range(32):
            idx = lienzo.v[NOMBRES + fila * 32 + col]
            tercio = fila // 8
            base = tercio * 0x800 + idx * 8
            for y in range(8):
                pat = lienzo.v[PATRONES + base + y]
                col8 = lienzo.v[COLORES + base + y]
                tinta, fondo = col8 >> 4, col8 & 0x0F
                for x in range(8):
                    bit = (pat >> (7 - x)) & 1
                    img[fila * 8 + y][col * 8 + x] = tinta if bit else fondo
    return img


def hoja_de_caracteres(lienzo, ancho=32):
    """Los 256 caracteres de cada tercio, puestos en rejilla.

    OJO: esto es una HOJA, no una pantalla. Ensena que dibujos hay definidos,
    no como se colocan; para eso hace falta la tabla de nombres.
    """
    filas = (256 // ancho) * 3
    img = [[0] * (ancho * 8) for _ in range(filas * 8)]
    for tercio in range(3):
        for n in range(256):
            base = tercio * 0x800 + n * 8
            f = tercio * (256 // ancho) + n // ancho
            c = n % ancho
            for y in range(8):
                pat = lienzo.v[PATRONES + base + y]
                col8 = lienzo.v[COLORES + base + y]
                tinta, fondo = col8 >> 4, col8 & 0x0F
                for x in range(8):
                    bit = (pat >> (7 - x)) & 1
                    img[f * 8 + y][c * 8 + x] = tinta if bit else fondo
    return img


def guarda_png(img, ruta, escala=2):
    """Un PNG sin dependencias: zlib y las cuatro cabeceras a mano."""
    import struct
    import zlib
    alto, ancho = len(img), len(img[0])
    crudo = bytearray()
    for f in img:
        for _ in range(escala):
            crudo.append(0)
            for v in f:
                r, g, b = PALETA[v & 0x0F]
                crudo += bytes((r, g, b)) * escala
    def trozo(tipo, datos):
        return (struct.pack(">I", len(datos)) + tipo + datos
                + struct.pack(">I", zlib.crc32(tipo + datos) & 0xFFFFFFFF))
    png = (b"\x89PNG\r\n\x1a\n"
           + trozo(b"IHDR", struct.pack(">IIBBBBB", ancho * escala,
                                        alto * escala, 8, 2, 0, 0, 0))
           + trozo(b"IDAT", zlib.compress(bytes(crudo), 9))
           + trozo(b"IEND", b""))
    os.makedirs(os.path.dirname(ruta), exist_ok=True)
    with open(ruta, "wb") as f:
        f.write(png)
    return ruta


# ============================================================== las imagenes
# Cada una lleva al lado la rutina del cartucho que la monta, para que se pueda
# ir a mirarla en el listado.

# p00:5C10 + p00:5C6B. La pantalla de titulo, y son DOS: p00:5C44 lee (0x002B)
# -el byte de pais de la BIOS- y solo pinta el guion 0xA463 si la maquina NO es
# japonesa. Con el, el rotulo pasa a PENGUIN ADVENTURE; sin el se queda el
# original, 夢大陸アドベンチャー.
def titulo(cart, internacional):
    li = Lienzo()
    pinta_en_los_tres(cart, (4, 5, 6), 0xB5A8, li, dest=0x0058)
    pinta(cart, (7, 8, 9), 0x9846, li)
    if internacional:
        pinta(cart, (7, 8, 9), 0xA463, li)
    pinta(cart, (1, 12, 13), 0xBAB2, li)
    return li


# p00:4995, p00:49FC y p00:49D2 cargan los caracteres de un decorado, uno por
# tercio de pantalla, con tablas de DIEZ bytes por decorado; y p01:6000
# descomprime en 0xEBE0 los 672 bytes de la tabla de nombres.
TERCIOS = ((0x4A93, 0x2200, 0x0200),
           (0x4AF7, 0x2808, 0x0808),
           (0x4B5B, 0x3008, 0x1008))
COLOR_DEL_FONDO = 0x4A89
GUION_DE_NOMBRES = {0: 0x8014, 1: 0x81EC, 2: 0x8725, 3: 0x89B0, 4: 0x8EE9,
                    5: 0x90EF, 6: 0x9735, 7: 0x9D72, 8: 0xA314, 9: 0x9735}


def _palabra(cart, addr, bancos=(4, 5, 6)):
    return cart.leer(addr, bancos) | (cart.leer(addr + 1, bancos) << 8)


def decorado(cart, n):
    li = Lienzo()
    v = cart.leer(COLOR_DEL_FONDO + n, (4, 5, 6))
    for i in range(8):
        li.escribe(0x0008 + i, v)
    for tabla, pat, col in TERCIOS:
        e = tabla + n * 10
        a, b = _palabra(cart, e), _palabra(cart, e + 2)
        dest = _palabra(cart, e + 4)
        c, d = _palabra(cart, e + 6), _palabra(cart, e + 8)
        pinta(cart, (4, 5, 6), a, li, dest=pat, c=0)
        pinta(cart, (4, 5, 6), b, li, dest=dest, c=1)
        pinta(cart, (4, 5, 6), c, li, dest=col, c=0)
        pinta(cart, (4, 5, 6), d, li, dest=dest - 0x2000, c=0)
    ram = bytearray(0x10000)
    descomprime(cart, (1, 12, 13), GUION_DE_NOMBRES[n], ram)
    for a in range(0xEBE0, 0xEE80):
        li.escribe(a + 0x4C80, ram[a])       # 0xEBA0 <-> 0x3820
    return li


def hoja_de_sprites(li, tinta=15, fondo=4):
    """Los 64 sprites de 16x16 de 0x1800-0x1FFF, en rejilla de ocho por ocho.

    Van en blanco a proposito: en la ROM el patron NO lleva color -el color es
    el cuarto byte de la entrada de la tabla de atributos- y una figura de
    varios colores son varios sprites superpuestos, uno por capa.
    """
    img = [[fondo] * (8 * 18) for _ in range(8 * 18)]
    for n in range(64):
        base = SPRITES_PAT + n * 32
        fy, fx = (n // 8) * 18, (n % 8) * 18
        for mitad in range(2):
            for y in range(16):
                b = li.v[base + mitad * 16 + y]
                for x in range(8):
                    if (b >> (7 - x)) & 1:
                        img[fy + y + 1][fx + mitad * 8 + x + 1] = tinta
    return img


def inventario(cart):
    """Que toca cada guion, sin dibujar: para ir cerrando el mapa de la VRAM."""
    for n in sorted(GUION_DE_NOMBRES):
        li = decorado(cart, n)
        print("decorado %d  guion de nombres %04X  %s"
              % (n, GUION_DE_NOMBRES[n],
                 " ".join("%04X-%04X" % (i, f - 1) for i, f in li.rangos()[:8])))


def main():
    cart = Cartucho()
    if len(sys.argv) > 1 and sys.argv[1] == "inventario":
        inventario(cart)
        return
    hechas = []
    for nom, internacional in (("titulo_japon", False), ("titulo_resto", True)):
        li = titulo(cart, internacional)
        hechas.append(guarda_png(pinta_pantalla(li),
                                 os.path.join(IMAGENES, nom + ".png")))
    for n in sorted(GUION_DE_NOMBRES):
        li = decorado(cart, n)
        hechas.append(guarda_png(pinta_pantalla(li),
                                 os.path.join(IMAGENES, "decorado_%d.png" % n)))
    for f in hechas:
        print("  %s" % os.path.relpath(f, RAIZ))
    print("%d imagenes en docs/imagenes/" % len(hechas))


if __name__ == "__main__":
    main()
