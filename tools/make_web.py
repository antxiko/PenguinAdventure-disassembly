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
ETIQUETAS = 830
INSTRUCCIONES = 16227
COMENTADAS = 7250
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
    ("jugador.png",
     "El pingüino, de espaldas y en negro, con las poses de la tabla de 0xA91D "
     "sobre los patrones que carga cada terreno. De arriba abajo: en tierra, "
     "en el hielo, nadando (la pose 10 y una espuma que alterna cada 16 "
     "cuadros, p02:9A1D), bajo el mar (poses 7, 8 y 9) y en el espacio, con "
     "los colores que le pisa p03:A778.",
     "The penguin, seen from behind and black, in the poses of the 0xA91D "
     "table over the patterns each terrain loads. Top to bottom: on land, on "
     "ice, swimming (pose 10 plus a splash that alternates every 16 frames, "
     "p02:9A1D), under the sea (poses 7, 8 and 9) and in space, with the "
     "colours p03:A778 forces on it."),
    ("bichos.png",
     "Los diez bichos de los guiones de las fases, cada uno en sus cuatro "
     "tamaños y, si aletea, en sus dos pasos, con su clase y las fases que lo "
     "sacan. El de la clase 7 no se ve: p09:B8B3 le da el color 0 salvo que se "
     "lleve 0xE16A.",
     "The ten creatures of the stage scripts, each at its four sizes and, if "
     "it flaps, in both steps, with its class and the stages that spawn it. "
     "Class 7 is invisible: p09:B8B3 gives it colour 0 unless 0xE16A is "
     "carried."),
    ("dinosaurio.png",
     "El dinosaurio que cierra cada tres fases, en los cinco tamaños con que "
     "se acerca: las tiras de 0xA76B que p01:6697 copia a 0x20, 0x10, 5, 2 y "
     "0 de la meta. El color lo escoge el decorado.",
     "The dinosaur that closes every third stage, at the five sizes it has "
     "as it approaches: the 0xA76B strips p01:6697 copies at 0x20, 0x10, 5, 2 "
     "and 0 from the goal. The backdrop picks its colour."),
    ("pelea.png",
     "La pelea, el estado 7: caen los cuatro bloques, el dinosaurio lanza "
     "(0xB212) y a los veinte aciertos el hielo se agrieta y se hunde "
     "(0xAE0A, 0xADA2, 0xAB60). Debajo, sus nueve dibujos de 0xA842: tres "
     "pasos por tres lados, porque mira hacia el pingüino.",
     "The fight, state 7: the four blocks fall, the dinosaur throws (0xB212) "
     "and after twenty hits the ice cracks and it sinks (0xAE0A, 0xADA2, "
     "0xAB60). Below, its nine drawings at 0xA842: three steps by three "
     "sides, because it looks towards the penguin."),
    ("escenas.png",
     "Las escenas de p03:AA80: el árbol tras la fase 12 y, tras la 24, el "
     "final bueno y el malo, con sus mensajes. Pantallas de 32 columnas del "
     "banco 13 pintadas del centro hacia fuera; en el final malo, la pieza de "
     "0xB963 ocupa el sitio de la princesa.",
     "The p03:AA80 scenes: the tree after stage 12 and, after stage 24, the "
     "good and the bad endings, with their messages. 32-column screens from "
     "bank 13 painted from the middle outwards; in the bad ending the 0xB963 "
     "piece takes the princess's place."),
    ("mapa.png",
     "El mapa de antes de cada fase: el camino andado en rojo, el pingüino en "
     "la fase de ahora y los atajos cogidos como caminos de puntos (p02:8AEC, "
     "0x8FE7, 0x8D85).",
     "The map before every stage: the road travelled in red, the penguin on "
     "the current stage and the warps taken as dotted roads (p02:8AEC, "
     "0x8FE7, 0x8D85)."),
    ("escenas_andando.png",
     "Lo que se mueve en las escenas: el pingüino entra de espaldas y sube una "
     "fila cada cuatro cuadros (p03:ACE6); en el árbol cae y rebota la manzana "
     "(0xAD88), en el final bueno salta (0xADBA) y en el malo llora (0xADD7 y "
     "0xADEF).",
     "What moves in the scenes: the penguin walks in from behind and goes up "
     "one row every four frames (p03:ACE6); in the tree the apple falls and "
     "bounces (0xAD88), in the good ending it jumps (0xADBA) and in the bad "
     "one it cries (0xADD7 and 0xADEF)."),
    ("espacio.png",
     "El espacio, el bonus: la Tierra, el pingüino y los meteoritos, que son "
     "cosas hechas de caracteres (0x15 a 0x19) con dieciséis dibujos que "
     "crecen hasta salirse por un lado.",
     "Space, the bonus stage: the Earth, the penguin and the meteorites, "
     "objects built from characters (0x15 to 0x19) with sixteen drawings that "
     "grow until they leave by one side."),
    ("warp.png",
     "El WARP, el decorado 9: una grieta de modo 2 pulsando abajo lleva a esta "
     "cueva y de ahí a otra fase. Son seis atajos: de la 1 a la 6, de la 6 a "
     "la 9, de la 9 a la 12, de la 13 a la 15, de la 15 a la 18 y de la 18 a "
     "la 21 (0xB79B).",
     "The WARP, backdrop 9: a mode-2 crevasse and pressing down lead to this "
     "cave and from there to another stage. There are six: 1 to 6, 6 to 9, 9 "
     "to 12, 13 to 15, 15 to 18 and 18 to 21 (0xB79B)."),
    ("tienda.png",
     "Las tres tiendas escondidas, el estado 12: el tendero de siempre, el que "
     "cobra el doble y Santa Claus, cada uno con su saludo (0xB038, 0xB065 y "
     "0xB0DD) y, debajo, su despedida al pulsar END. Los artículos y los "
     "precios salen de la lista de la fase (0xAF90) y de la tabla del tendero "
     "(0x6FD5, 0x6FE5 y 0x6FF5); la bolsa de la izquierda sólo sale con puntos.",
     "The three hidden shops, state 12: the usual shopkeeper, the one who "
     "charges double and Santa Claus, each with his greeting (0xB038, 0xB065 "
     "and 0xB0DD) and, below, his farewell when you press END. The items and "
     "the prices come from the stage's list (0xAF90) and the shopkeeper's "
     "table (0x6FD5, 0x6FE5 and 0x6FF5); the purse on the left only shows up "
     "when you have points."),
    ("articulos.png",
     "Los dieciséis artículos, dibujados con los caracteres del marcador "
     "(0xB71B, cuatro por artículo desde el 0xB2), con su precio normal y el "
     "caro. El 14 y el 15 no los vende nadie: son los premios de los secretos "
     "de la fase 6 (p03:BE7D) y de la 13 (p03:BEC0).",
     "The sixteen items, drawn with the status-bar characters (0xB71B, four "
     "per item from 0xB2), with their usual and expensive prices. Nobody "
     "sells 14 or 15: they are the prizes of the stage 6 secret (p03:BE7D) "
     "and the stage 13 secret (p03:BEC0)."),
    ("items.png",
     "Los peces con alas que se cogen en el espacio, en los dieciséis pasos "
     "de la lista de 0xA545. Debajo, los dos colores entre los que salta el "
     "que da una vida (p01:6A04).",
     "The winged fish you catch in space, in the sixteen steps of the 0xA545 "
     "list. Below, the two colours the extra-life one flickers between "
     "(p01:6A04)."),
    ("recorridos_level_1.png",
     "Las veinticuatro fases del LEVEL 1, andadas paso a paso desde sus "
     "tablas: ocho vistas de la carretera por fase, de la salida a la meta, "
     "con lo que sale del guion del terreno y las curvas; debajo, los bichos "
     "de cada tramo.",
     "The twenty-four LEVEL 1 stages, walked step by step from their tables: "
     "eight views of the road per stage, start to goal, with what the terrain "
     "script puts on it and the curves; below, each stretch's creatures."),
    ("decorado_0.png",
     "Uno de los ocho decorados de las fases, montado como lo monta el juego: "
     "las diez piezas de p02:966B con su tabla de color, el mapa de p01:6000 "
     "y la animación del suelo.",
     "One of the eight stage backdrops, built the way the game builds it: the "
     "ten pieces of p02:966B with their colour table, the p01:6000 map and "
     "the ground animation."),
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
]

HALLAZGOS = {
    "es": [
        ("El final bueno depende de cuántas veces pauses",
         "<p>El hallazgo es de <b>Manuel Pazos</b>, que lo contó en una charla; "
         "lo que aporta este desensamblado es dónde está escrito y la regla "
         "exacta. p02:81EE sube un contador cada vez que se <b>entra</b> en "
         "pausa, y al acabar la fase 24 p02:82DE mira sus dos bits bajos y les "
         "resta uno: si queda cero, la princesa sale viva.</p><p>O sea que hay "
         "que haber pausado <b>1, 5, 9, 13…</b> veces —el resto de dividir "
         "entre cuatro tiene que ser 1— y <b>no pausar nunca da el final "
         "malo</b>. La cuenta sobrevive a perder una vida, pero el CONTINUE la "
         "borra. Los dos textos están en la ROM: <i>YOU HAVE SUCCEEDED IN "
         "RESCUING THE PRINCESS</i> y <i>YOU HAVE FAILED TO RESCUE THE "
         "PRINCESS</i>.</p>"),
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
        ("Santa Claus regala, y el tendero enfadado cobra el doble",
         "<p>Caer en el centro de una grieta de modo 3, 4 o 5 (p01:72F2) abre "
         "la tienda, y el modo es el tendero. Los tres venden lo mismo —la "
         "lista de siete de la fase, 0xAF90— pero cada uno con su tabla de "
         "precios: la normal (0x6FD5), la del <b>doble</b> (0x6FE5, salvo el "
         "artículo 7, que sube de 17 a 32 y no a 34) y la de <b>Santa "
         "Claus</b>, que está a cero (0x6FF5) y cierra la tienda tras la "
         "primera compra (p01:6F09): regala una cosa. Son <b>41 tiendas</b> "
         "en 18 fases: 18 normales, 20 caras y tres de Santa, en las fases 6, "
         "12 y 21.</p><p>Y cada tendero habla: <i>MAY I HELP YOU? GET "
         "WHATEVER YOU LIKE.</i>, <i>HEY YOU! YOU MUST BUY SOMETHING FROM "
         "ME!!</i> y <i>WELCOME! I WILL GIVE YOU A JEWEL.</i>; al pulsar END "
         "se despiden, el enfadado con un <i>BUY MORE! WAIT! DAMN IT!!</i>. "
         "Las seis pantallas están dibujadas desde las tablas y cotejadas "
         "contra 14 volcados de openMSX: cero diferencias.</p>"),
        ("Seis atajos, escondidos en grietas",
         "<p>El guion de avisos de 0xB046 convierte en grieta la cosa que "
         "sale tras su distancia y le pega dos bytes: el modo y la lista. Con "
         "el modo 2, caer dentro y pulsar abajo (p02:999C) lleva al "
         "<b>WARP</b>, una carrera de 0x150 pasos por el decorado 9, y al "
         "acabar p03:B94A lee el registro de 17 bytes de 0xB79B que escoge "
         "la lista y <b>suma fases</b>. Son seis: de la 1 a la 6, de la 6 a "
         "la 9, de la 9 a la 12, de la 13 a la 15, de la 15 a la 18 y de la "
         "18 a la 21, medidos los seis en openMSX. Y en el mapa de antes de "
         "cada fase salen como caminos de puntos (0x8D85).</p>"),
        ("Veinticuatro fases, no trece",
         f"<p>Los trece son lo que el cartucho le <i>declara</i> al Konami "
         f"Game Master en su segunda cabecera, la de 0x4010. El juego dice "
         f"otra cosa: p02:8328 compara la fase con 0x19 y las tres tablas de "
         f"guion —terreno, enemigos y el tercero— cierran en <b>{FASES}</b> "
         f"entradas justas. Y la partida del LEVEL 2 es otro diseño "
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
        ("The good ending depends on how many times you pause",
         "<p>The finding is <b>Manuel Pazos&rsquo;s</b>, who told it at a talk; "
         "what this disassembly adds is where it is written and the exact rule. "
         "p02:81EE bumps a counter every time you <b>enter</b> pause, and when "
         "stage 24 ends p02:82DE takes its low two bits and subtracts one: if "
         "nothing is left, the princess comes out alive.</p><p>So you have to "
         "have paused <b>1, 5, 9, 13…</b> times —the remainder of dividing by "
         "four has to be 1— and <b>never pausing gives you the bad ending</b>. "
         "The count survives losing a life, but CONTINUE wipes it. Both texts "
         "are in the ROM: <i>YOU HAVE SUCCEEDED IN RESCUING THE PRINCESS</i> "
         "and <i>YOU HAVE FAILED TO RESCUE THE PRINCESS</i>.</p>"),
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
        ("Santa Claus gives things away, and the angry shopkeeper charges double",
         "<p>Falling into the middle of a mode 3, 4 or 5 crevasse (p01:72F2) "
         "opens the shop, and the mode is the shopkeeper. All three sell the "
         "same —the stage's seven-item list, 0xAF90— but each with his own "
         "price table: the usual one (0x6FD5), the <b>double</b> one (0x6FE5, "
         "except item 7, which goes from 17 to 32 and not 34) and <b>Santa "
         "Claus&rsquo;s</b>, all zeros (0x6FF5), who closes the shop after the "
         "first purchase (p01:6F09): he gives one thing away. There are "
         "<b>41 shops</b> on 18 stages: 18 usual, 20 expensive and three "
         "Santas, on stages 6, 12 and 21.</p><p>And every shopkeeper talks: "
         "<i>MAY I HELP YOU? GET WHATEVER YOU LIKE.</i>, <i>HEY YOU! YOU MUST "
         "BUY SOMETHING FROM ME!!</i> and <i>WELCOME! I WILL GIVE YOU A "
         "JEWEL.</i>; press END and they say goodbye, the angry one with "
         "<i>BUY MORE! WAIT! DAMN IT!!</i>. The six screens are drawn from "
         "the tables and checked against 14 openMSX dumps: zero "
         "differences.</p>"),
        ("Six warps, hidden in crevasses",
         "<p>The warnings script at 0xB046 turns the object that comes out "
         "after its distance into a crevasse and attaches two bytes: the mode "
         "and the list. With mode 2, falling in and pressing down (p02:999C) "
         "leads to the <b>WARP</b>, a 0x150-step run through backdrop 9, and "
         "when it ends p03:B94A reads the 17-byte record at 0xB79B picked by "
         "the list and <b>adds stages</b>. There are six: 1 to 6, 6 to 9, 9 "
         "to 12, 13 to 15, 15 to 18 and 18 to 21, all six measured in openMSX. "
         "And on the map before every stage they show up as dotted roads "
         "(0x8D85).</p>"),
        ("Twenty-four stages, not thirteen",
         f"<p>Thirteen is what the cartridge <i>declares</i> to the Konami "
         f"Game Master in its second header, the one at 0x4010. The game says "
         f"otherwise: p02:8328 compares the stage with 0x19 and the three "
         f"script tables —terrain, creatures and the third one— close at "
         f"exactly <b>{FASES}</b> entries. And LEVEL 2 is a whole different "
         f"design, without a single matching section.</p>"),
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
