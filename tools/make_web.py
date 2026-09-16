#!/usr/bin/env python3
"""Genera la portada de la web, en los dos idiomas.

El diseno es el compartido por la serie (tools/estilo_web.py) y la pagina sale
autocontenida, con las imagenes embebidas como data URI.

NINGUNA imagen es una captura de emulador: todas las pinta tools/graficos.py
ejecutando en Python las mismas rutinas que el cartucho ejecuta en el Z80 -el
descompresor de p00:418C, el pintor de p00:4386, el pintor con mascara de
p00:42BC-. Si un rango estuviera mal etiquetado, saldrian a ruido.

Uso: make_web.py <docs/imagenes> <salida.html> <idioma>
"""
import base64
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO                                   # noqa: E402

# Las cifras salen de contar sobre el listado, no de escribirlas a ojo: las
# imprime tools/cifras.py, que es lo que tambien escribe la tabla de los dos
# README. 131072 = 32317 + 98755 + 0.
CODIGO = 32317
DATOS = 98755
PENDIENTE = 0
ETIQUETAS = 827
INSTRUCCIONES = 16227
COMENTADAS = 7244
FASES = 24
TOTAL = CODIGO + DATOS + PENDIENTE


def mil(n, idioma):
    return f"{n:,}".replace(",", "." if idioma == "es" else ",")


def pct(idioma, v=None):
    if v is None:
        v = 100.0 * (CODIGO + DATOS) / TOTAL
        if not PENDIENTE:
            return "100 %"
    return f"{v:.1f}".replace(".", "," if idioma == "es" else ".") + " %"


def img64(ruta):
    return "data:image/png;base64," + base64.b64encode(open(ruta, "rb").read()).decode()


GALERIA = [
    ("titulo_japon.png",
     "La pantalla del título japonesa, montada con los pasos del propio "
     "cartucho: el guion 0xB5A8 del banco 6 en los tres tercios de la tabla de "
     "patrones, los sprites de p07 0x9846 y los rótulos de p13 0xBAB2.",
     "The Japanese title screen, built with the cartridge's own steps: script "
     "0xB5A8 from bank 6 into the three thirds of the pattern table, the "
     "sprites from p07 0x9846 and the lettering from p13 0xBAB2."),
    ("titulo_resto.png",
     "Y la del resto del mundo. El cartucho elige una u otra con el byte de "
     "país de la BIOS (0x002B): la diferencia es UN guion de más, el 0xA463, "
     "que sólo toca el rótulo.",
     "And the one for the rest of the world. The cartridge picks one or the "
     "other from the BIOS country byte (0x002B): the difference is ONE extra "
     "script, 0xA463, and it only touches the lettering."),
    ("decorado_0.png",
     "El primero de los diez decorados, descomprimido desde la ROM. Cada uno "
     "son tres cargas de caracteres -una por tercio de pantalla- y 672 bytes "
     "de tabla de nombres que p01:6000 suelta en 0xEBE0.",
     "The first of the ten backdrops, decompressed from the ROM. Each one is "
     "three character loads -one per third of the screen- and 672 bytes of "
     "name table that p01:6000 drops at 0xEBE0."),
    ("apostar.png",
     "La máquina de apostar, con tres cerezas. La tabla de premios está "
     "pintada en la propia máquina y dice lo mismo que el código: una cereza "
     "×1, dos ×2, tres ×4, y los demás símbolos sólo pagan de tres en tres.",
     "The gambling machine, showing three cherries. The payout table is "
     "painted on the machine itself and says exactly what the code says: one "
     "cherry ×1, two ×2, three ×4, and every other symbol pays only in threes."),
    ("simbolos.png",
     "Los seis símbolos de los rodillos, con cuántas de las dieciséis casillas "
     "de la tabla de 0x7B34 les tocan. La cereza se lleva cinco: es el símbolo "
     "más probable y el único que cuenta suelto.",
     "The six reel symbols, with how many of the sixteen slots in the table at "
     "0x7B34 fall to each. The cherry gets five: it is the most likely symbol "
     "and the only one that counts on its own."),
    ("fases_1_jugador.png",
     "Las veinticuatro fases de un jugador: cada fila es una fase, los bloques "
     "de color son los tramos de terreno en orden y las marcas de debajo, los "
     "bichos que salen. Son 24 y no 13: los trece son lo que el cartucho le "
     "declara al Konami Game Master en su cabecera de 0x4010.",
     "The twenty-four one-player stages: each row is a stage, the coloured "
     "blocks are its terrain sections in order and the marks below are the "
     "creatures it spawns. There are 24 and not 13: thirteen is what the "
     "cartridge declares to the Konami Game Master in its 0x4010 header."),
    ("fases_2_jugadores.png",
     "Y las de dos jugadores, que son OTRO diseño: ni un solo tramo coincide "
     "byte a byte con el de un jugador.",
     "And the two-player ones, which are a DIFFERENT design: not one section "
     "matches the one-player table byte for byte."),
    ("sprites_9846.png",
     "Una de las diecinueve hojas de sprites, la del título. Los dos colores "
     "son blanco y gris a propósito: en el MSX1 un sprite es de un solo color "
     "y el color no está en el dibujo sino en el cuarto byte de la entrada de "
     "la tabla de atributos, así que estas hojas enseñan qué capa pone qué.",
     "One of the nineteen sprite sheets, the title one. The two colours are "
     "white and grey on purpose: on the MSX1 a sprite has a single colour and "
     "that colour is not in the drawing but in the fourth byte of the "
     "attribute table entry, so these sheets show which layer puts what."),
]

HALLAZGOS = {
    "es": [
        ("Dos claves de teclado: NORIKO y KAZUMI",
         "<p>Se teclean en la pantalla del título y encienden el "
         "<b>CONTINUE</b>, que sin ellas no existe. p02:9522 vigila NUEVE "
         "teclas con <code>SNSMAT</code> de la BIOS y guarda las seis últimas "
         "pulsadas en una cola; p02:9634 las compara con dos patrones de seis "
         "bytes. Y las nueve teclas vigiladas —A, I, K, M, N, O, R, U y Z— son "
         "<b>exactamente</b> las letras que hacen falta para escribir esos dos "
         "nombres y ninguna más.</p><p>Las dos no hacen lo mismo: NORIKO deja "
         "0xFE en 0xF0F7 y KAZUMI 0xFF, y con 0xFE justo el borrado del fin de "
         "partida se salta 143 bytes, así que <b>NORIKO además conserva lo que "
         "se lleve encima</b>.</p>"),
        ("La cereza es el símbolo más probable y el único que cuenta suelto",
         "<p>Los rodillos de la máquina de apostar sacan su símbolo del "
         "<b>registro R del Z80</b> —el contador de refresco de memoria— "
         "enmascarado a cuatro bits, y con ese índice leen la tabla de "
         "dieciséis de 0x7B34. La cereza ocupa <b>cinco</b> de las dieciséis "
         "casillas: 31,2 % por rodillo, y <b>al menos una en el 67,5 % de las "
         "tiradas</b>.</p><p>Y el reparto de premios de p01:7AF0 la trata "
         "aparte: por cada rodillo que saque cereza sube un contador, y los "
         "tres primeros multiplicadores de la tabla son 1, 2 y 4. Los demás "
         "símbolos sólo pagan si salen los tres iguales: ×8, ×10, ×15, ×20 y "
         "el premio gordo. Es la regla clásica de las cerezas, escrita en el "
         "Z80.</p>"),
        ("Veinticuatro fases, no trece",
         f"<p>Los trece son lo que el cartucho le <i>declara</i> al Konami "
         f"Game Master en su segunda cabecera, la de 0x4010. El juego dice "
         f"otra cosa: p02:8328 compara la fase con 0x19 y las tres tablas de "
         f"guion —terreno, enemigos y el tercero— cierran en <b>{FASES}</b> "
         f"entradas justas. Y la partida de dos jugadores es otro diseño "
         f"entero, sin un solo tramo igual.</p>"),
        ("El tiempo corre aunque no se ande",
         "<p>0xE08B no es el largo de la fase: es el <b>tiempo</b>. p02:922D "
         "le quita uno cada 32 cuadros se ande o no se ande, por debajo de "
         "0x15 pita un cuadro sí y otro no, y al acabar la fase p02:94D1 lo "
         "cambia por puntos de 0x20 en 0x20. Lo que va bajando con el terreno "
         "es otra cosa, 0xE08D, y de ella salen los nueve cortes del final de "
         "fase.</p><p>De ahí que el objeto de p03:B31E, que le suma 0x50 en "
         "BCD, no alargue el recorrido: <b>da tiempo extra</b>. Es lo único de "
         "todo el cartucho que toca ese contador después de montada la "
         "fase.</p>"),
        ("Las curvas se leen, pero el ángulo se calcula",
         "<p>La circunferencia de 24 pasos y la parábola de 32 están escritas "
         "en la ROM y se leen. Pero para apuntar al jugador el banco 9 hace "
         "trigonometría de verdad: p09:ACE3 es una división de 16 entre 8 bits "
         "a base de restar y desplazar —el Z80 no tiene <code>div</code>— y "
         "p09:ACBA una <b>arcotangente</b> que busca el cociente en una tabla "
         "de ocho tangentes en formato 8.8, de 11,25 en 11,25 grados. El "
         "ángulo sale en las 256 unidades de circunferencia de la casa.</p>"),
        ("Cambia de banco con las interrupciones abiertas",
         "<p>Y con semáforo en 0xE005. Ningún trazador estático lo sigue: de "
         "ahí salían 14 KB inventados en los bancos 12 y 13, que hubo que "
         "declarar a mano. Con el relleno 0xFF de la cola de un banco pasa algo "
         "parecido: <code>0xFF</code> es <code>rst 38h</code>, así que el "
         "trazador se salía al banco vecino por la puerta de atrás.</p>"),
    ],
    "en": [
        ("Two keyboard codes: NORIKO and KAZUMI",
         "<p>You type them on the title screen and they turn on "
         "<b>CONTINUE</b>, which does not exist without them. p02:9522 watches "
         "NINE keys with the BIOS <code>SNSMAT</code> and keeps the last six "
         "pressed in a queue; p02:9634 compares them against two six-byte "
         "patterns. And the nine watched keys —A, I, K, M, N, O, R, U and Z— "
         "are <b>exactly</b> the letters needed to spell those two names and "
         "no others.</p><p>They do not do the same thing: NORIKO leaves 0xFE "
         "in 0xF0F7 and KAZUMI 0xFF, and with exactly 0xFE the game-over wipe "
         "skips 143 bytes, so <b>NORIKO also keeps what you are "
         "carrying</b>.</p>"),
        ("The cherry is the likeliest symbol and the only one that counts alone",
         "<p>The gambling machine's reels take their symbol from the "
         "<b>Z80's R register</b> —the memory refresh counter— masked to four "
         "bits, and use that index into the sixteen-entry table at 0x7B34. The "
         "cherry takes <b>five</b> of the sixteen slots: 31.2 % per reel, and "
         "<b>at least one on 67.5 % of the spins</b>.</p><p>And the payout "
         "code at p01:7AF0 treats it apart: every reel showing a cherry bumps "
         "a counter, and the first three multipliers in the table are 1, 2 and "
         "4. Every other symbol pays only on three of a kind: ×8, ×10, ×15, "
         "×20 and the jackpot. It is the classic cherry rule, written in "
         "Z80.</p>"),
        ("Twenty-four stages, not thirteen",
         f"<p>Thirteen is what the cartridge <i>declares</i> to the Konami "
         f"Game Master in its second header, the one at 0x4010. The game says "
         f"otherwise: p02:8328 compares the stage with 0x19 and the three "
         f"script tables —terrain, creatures and the third one— close at "
         f"exactly <b>{FASES}</b> entries. And the two-player game is a whole "
         f"different design, without a single matching section.</p>"),
        ("The clock runs whether you move or not",
         "<p>0xE08B is not the stage length: it is the <b>time</b>. p02:922D "
         "takes one off it every 32 frames whether you move or not, below 0x15 "
         "it beeps every other frame, and when the stage ends p02:94D1 turns "
         "it into points 0x20 at a time. What goes down with the terrain is "
         "something else, 0xE08D, and the nine end-of-stage cues come from "
         "it.</p><p>Which is why the item at p03:B31E, which adds 0x50 in BCD, "
         "does not make the run longer: it <b>gives extra time</b>. It is the "
         "only thing in the whole cartridge that touches that counter once the "
         "stage is up.</p>"),
        ("The curves are read, but the angle is computed",
         "<p>The 24-step circle and the 32-step parabola are written in the "
         "ROM and read back. But to aim at the player, bank 9 does real "
         "trigonometry: p09:ACE3 is a 16-by-8 division by subtract-and-shift "
         "—the Z80 has no <code>div</code>— and p09:ACBA an <b>arctangent</b> "
         "that looks the quotient up in a table of eight tangents in 8.8 "
         "format, 11.25 degrees apart. The angle comes out in the house's 256 "
         "units of a circle.</p>"),
        ("It switches banks with interrupts enabled",
         "<p>With a semaphore at 0xE005. No static tracer follows that: it is "
         "where 14 KB of invented code in banks 12 and 13 came from, and they "
         "had to be declared by hand. The 0xFF padding at the tail of a bank "
         "does something similar: <code>0xFF</code> is <code>rst 38h</code>, "
         "so the tracer walked out into the neighbouring bank through the back "
         "door.</p>"),
    ],
}

TXT = {
    "es": dict(
        titulo="Penguin Adventure (1986) — desensamblado comentado",
        aviso="<b>Aquí no hay ni una captura de pantalla.</b> Las pantallas "
              "están dibujadas ejecutando en Python las mismas rutinas que el "
              "cartucho ejecuta en el Z80: su descompresor, su pintor y su "
              "pintor con máscara. Lo demás —el listado y las cifras— sale del "
              "binario y se reproduce con <code>make</code>.",
        claim="Un MegaROM Konami4 de 128 KB de 1986, la continuación de "
              "Antarctic Adventure. Veinticuatro fases, una tienda, una "
              "máquina de apostar y dos claves de teclado escondidas.",
        ficha=["Konami · <b>1986</b>", "Cartucho <b>RC-743</b>, 128 KB",
               "MSX1 · <b>Konami4, sin SCC</b>", "Volcado <b>525608aa…</b>"],
        nav=[("#numbers", "Las cifras"), ("#findings", "Hallazgos"),
             ("#screens", "Lo que dibuja")],
        docnav=[("EMPEZAR.html", "Empezar"), ("EL-JUEGO.html", "El juego"),
                ("EL-CARTUCHO.html", "El cartucho"),
                ("EL-CODIGO.html", "El código"),
                ("HALLAZGOS.html", "Hallazgos"),
                ("EN-EL-EMULADOR.html", "En el emulador"),
                ("PREGUNTAS-ABIERTAS.html", "Preguntas abiertas")],
        otro=("../", "In English"),
        h_num="El juego en cifras", h_find="Lo que aparece al desmontarlo",
        h_scr="Lo que dibuja",
        nota_scr="Ninguna de estas imágenes es una captura: las dibuja "
                 "<code>tools/graficos.py</code> desde la ROM.",
        pie_leg="La imagen del cartucho no se distribuye: cada cual pone la "
                "suya. Penguin Adventure es de Konami; esto es un estudio del "
                "binario.",
        cifras=lambda i: [
            (pct(i), "del binario explicado"),
            (mil(ETIQUETAS, i), "etiquetas con nombre"),
            (pct(i, 100.0 * COMENTADAS / INSTRUCCIONES),
             "de las instrucciones, comentadas"),
            ("0", "rutinas por debajo del 10 %"),
            (mil(CODIGO, i), "bytes de código"),
            (mil(DATOS, i), "bytes de datos"),
        ],
    ),
    "en": dict(
        titulo="Penguin Adventure (1986) — commented disassembly",
        aviso="<b>There is not a single screenshot here.</b> The screens are "
              "drawn by running in Python the same routines the cartridge runs "
              "on the Z80: its decompressor, its painter and its masked "
              "painter. The rest —the listing and the numbers— comes out of "
              "the binary and is reproduced with <code>make</code>.",
        claim="A 128 KB Konami4 MegaROM from 1986, the sequel to Antarctic "
              "Adventure. Twenty-four stages, a shop, a gambling machine and "
              "two hidden keyboard codes.",
        ficha=["Konami · <b>1986</b>", "Cartridge <b>RC-743</b>, 128 KB",
               "MSX1 · <b>Konami4, no SCC</b>", "Dump <b>525608aa…</b>"],
        nav=[("#numbers", "The numbers"), ("#findings", "Findings"),
             ("#screens", "What it draws")],
        docnav=[("GETTING-STARTED.html", "Start"), ("THE-GAME.html", "The game"),
                ("THE-CARTRIDGE.html", "The cartridge"),
                ("THE-CODE.html", "The code"),
                ("FINDINGS.html", "Findings"),
                ("IN-THE-EMULATOR.html", "In the emulator"),
                ("OPEN-QUESTIONS.html", "Open questions")],
        otro=("es/", "En español"),
        h_num="The game in numbers",
        h_find="What turns up when you take it apart",
        h_scr="What it draws",
        nota_scr="None of these images is a screenshot: "
                 "<code>tools/graficos.py</code> draws them from the ROM.",
        pie_leg="The cartridge image is not distributed: bring your own. "
                "Penguin Adventure belongs to Konami; this is a study of the "
                "binary.",
        cifras=lambda i: [
            (pct(i), "of the binary explained"),
            (mil(ETIQUETAS, i), "named labels"),
            (pct(i, 100.0 * COMENTADAS / INSTRUCCIONES),
             "of the instructions, commented"),
            ("0", "routines under 10 %"),
            (mil(CODIGO, i), "bytes of code"),
            (mil(DATOS, i), "bytes of data"),
        ],
    ),
}


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    imgdir, salida, idioma = argv[1:4]
    t = TXT[idioma]

    nav = "".join(f'<a href="{h}">{x}</a>' for h, x in t["nav"])
    nav += "".join(f'<a href="{h}">{x}</a>' for h, x in t["docnav"])
    nav += (f'<a href="{t["otro"][0]}" style="margin-left:auto;color:var(--oro)">'
            f'{t["otro"][1]}</a>')

    cifras = "".join(f'<div class="cifra"><b>{v}</b><span>{e}</span></div>'
                     for v, e in t["cifras"](idioma))
    halls = "".join(f'<div class="hall"><h3>{tit}</h3>{cuerpo}</div>'
                    for tit, cuerpo in HALLAZGOS[idioma])

    # La cabecera no es un montaje: es la pantalla del titulo que el propio
    # cartucho monta, sacada desde la ROM por graficos.py. Si el PNG no esta,
    # se cae al texto.
    ruta_logo = os.path.join(imgdir, "titulo_resto.png")
    cabecera = (f'<img src="{img64(ruta_logo)}" alt="Penguin Adventure">'
                if os.path.exists(ruta_logo)
                else "<h1>Penguin Adventure (1986)</h1>")

    imgs, faltan = "", []
    for fich, es, en in GALERIA:
        ruta = os.path.join(imgdir, fich)
        if not os.path.exists(ruta):
            faltan.append(fich)
            continue
        pie = es if idioma == "es" else en
        imgs += (f'<figure><img src="{img64(ruta)}" alt="{pie}">'
                 f'<figcaption>{pie}</figcaption></figure>')
    if faltan:
        print("  (faltan %d imagenes: %s)" % (len(faltan), " ".join(faltan)))

    html = f"""<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{t['titulo']}</title>
<style>{ESTILO}</style>
<header class="top">
  {cabecera}
  <p class="claim">{t['claim']}</p>
  <p class="ficha">{' · '.join(t['ficha'])}</p>
</header>
<p class="ficha" style="border:1px solid var(--oro);padding:.8em 1em;margin:1.5em 0">
{t['aviso']}</p>
<nav>{nav}</nav>
<section id="numbers">
  <h2>{t['h_num']}</h2>
  <div class="cifras">{cifras}</div>
</section>
<section id="findings"><h2>{t['h_find']}</h2>{halls}</section>
<section id="screens">
  <h2>{t['h_scr']}</h2>
  <p class="n">{t['nota_scr']}</p>
  <div class="galeria">{imgs}</div>
</section>
<footer><p>{t['pie_leg']}</p></footer>
"""
    with open(salida, "w", encoding="utf-8") as f:
        f.write(html)
    print("  %s: %d KB (%s)" % (salida, len(html) // 1024, idioma))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
