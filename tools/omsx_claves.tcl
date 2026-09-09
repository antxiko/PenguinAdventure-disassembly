# Comprueba EN MARCHA las claves que se escriben con el teclado.
#
# El listado dice que 0x44E7 mira la tecla GRAPH -fila 6, bit 5- y que, con el
# juego EN PAUSA, 0x50C9 lee el teclado, va guardando letras en 0xE1E8 y, al
# pulsar RETURN, compara lo escrito contra las palabras de 0x51BF. Esto lo
# prueba de verdad: arranca la partida, pausa, escribe la palabra letra a
# letra, pulsa RETURN y apunta las casillas de la nave que el listado dice que
# cambian, ademas de fotografiar antes y despues.
#
# Trampas ya pagadas en esta serie:
#   - con -script el emulador arranca con el renderer en `uninitialized` y
#     `screenshot` devuelve un PNG negro con rc=0: hay que encenderlo a mano.
#   - las capturas se piden con el acelerador PUESTO y con `after realtime`.
#   - `type` de una tacada va demasiado rapido: el juego solo apunta la tecla
#     cuando CAMBIA, asi que se escribe letra a letra.
#
#   NEM_OUT=<dir> [NEM_CLAVE=option] openmsx -machine Philips_VG_8020 \
#       -carta penguinadventure.rom -script este.tcl
set OUT $::env(NEM_OUT)
file mkdir $OUT
set LOG [open "$OUT/claves.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %8.2f [machine_info time]]  $m"; flush $LOG }

catch {set renderer SDLGL-PP}
set throttle on
say "en marcha"

set ::n 0
proc foto {que} {
    global OUT
    incr ::n
    set f [format "%s/nem_%02d_%s.png" $OUT $::n $que]
    catch {screenshot -raw -doublesize $f} e
    say "foto [file tail $f] rc=$e"
}

# Las casillas de la nave que, segun el listado, tocan las claves.
proc estado {que} {
    set l ""
    foreach {n d} {naves 0xE060 aviso 0xE05F escudo 0xE200 vel 0xE202 opciones 0xE20B disparoA 0xE20C disparoB 0xE20D laser 0xE20E misil 0xE20F} {
        append l [format "%s=%02X " $n [debug read memory $d]]
    }
    say "$que  $l"
}

proc buffer {que} {
    set l ""
    for {set i 0} {$i < 10} {incr i} {
        append l [format "%02X " [debug read memory [expr {0xE1E6 + $i}]]]
    }
    say "$que  0xE1E6..: $l"
}

proc pulsa {fila mascara} {
    keymatrixdown $fila $mascara
    after realtime 0.25 [list keymatrixup $fila $mascara]
}

set CLAVE [expr {[info exists ::env(NEM_CLAVE)] ? $::env(NEM_CLAVE) : "option"}]

after realtime 8  { say "arranque"; foto titulo }
after realtime 10 { pulsa 8 0x01 }
after realtime 14 { pulsa 8 0x01 }
after realtime 19 { estado "en juego"; foto enjuego }
after realtime 20 { say "GRAPH: pausa"; pulsa 6 0x20 }
after realtime 21 { buffer "recien pausado" }

set ::t 22.0
foreach c [split $CLAVE ""] {
    after realtime $::t [list apply {{c} { say "tecla '$c'"; type $c }} $c]
    set ::t [expr {$::t + 0.6}]
}
after realtime [expr {$::t + 0.4}] { buffer "escrito" }
after realtime [expr {$::t + 1.0}] { say "RETURN"; type "\r" }
after realtime [expr {$::t + 2.0}] { estado "despues de la clave"; buffer "despues"; foto despues }
after realtime [expr {$::t + 2.5}] { say "GRAPH: seguir"; pulsa 6 0x20 }
after realtime [expr {$::t + 4.0}] { foto siguiendo; say "FIN"; exit 0 }
