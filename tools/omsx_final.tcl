# De que depende el final bueno y el malo, comprobado EN MARCHA.
#
# Lo que dice el listado: p02:81EE sube 0xE0DE cada vez que se ENTRA en pausa,
# y al acabar la fase 24 p02:82DE mira (0xE0DE) AND 3, le resta uno y con el
# resultado a cero deja 0xE0B9 a 0 y si no a 1. Luego p00:5F19 escoge con esa
# 0xE0B9 cual de los dos juegos de cinco lineas sube por la pantalla: el de
# 0x5F63 -"YOU HAVE SUCCEEDED IN RESCUING THE PRINCESS"- o el de 0x5F6D -"YOU
# HAVE FAILED TO RESCUE THE PRINCESS"-.
#
# O sea: el final bueno pide 1, 5, 9, 13... pausas.
#
# COMO SE PRUEBA SIN JUGAR. No se juega ni una fase: en cuanto la partida esta
# montada se le pone la fase 24 y la cuenta de pausas, y se mete la maquina de
# estados directamente en el ESTADO 6, SUBESTADO 5, que es donde esta la
# decision (la cadena de `djnz` de p02:8278 llega ahi con B = 5). A partir de
# ahi el cartucho sigue solo hasta el texto del final.
#
# EL FALLO QUE ESTO ARREGLA, y que conviene no repetir: la primera version
# dejaba correr la partida y esperaba. El pingüino se moria, el fin de partida
# borra 217 bytes desde 0xE086 -que incluyen 0xE0DE y 0xE0B9- y 0xE0B9 se
# quedaba a 0. Leido sin mirar, eso parecia "final bueno" cuando lo unico que
# habia pasado es que se habia borrado la RAM. Por eso aqui hay un WATCHPOINT:
# no vale con ver el valor, hay que ver QUIEN lo escribe. Si el PC no viene de
# p02:82EA, no cuenta.
#
#   PA_OUT=<dir> PA_PAUSAS=<n> openmsx -machine C-BIOS_MSX1_EU \
#       -carta penguinadventure.rom -script este.tcl
set OUT $::env(PA_OUT)
set PAUSAS [expr {[info exists ::env(PA_PAUSAS)] ? $::env(PA_PAUSAS) : 1}]
file mkdir $OUT
set LOG [open "$OUT/final_$PAUSAS.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }

catch {set renderer SDLGL-PP}
set throttle on

proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc pulsa {fila mascara} {
    keymatrixdown $fila $mascara
    after time 0.2 [list keymatrixup $fila $mascara]
}

set ::decidido 0
say "pausas a probar: $PAUSAS"
say "el listado predice: 0xE0B9 = [expr {($PAUSAS & 3) == 1 ? 0 : 1}]  -> final [expr {($PAUSAS & 3) == 1 ? {BUENO} : {malo}}]"

# El watchpoint: aqui esta la diferencia entre medir y creerse un valor.
debug set_watchpoint write_mem 0xE0B9 {} {
    # OJO: se compara el NUMERO, no la cadena hexadecimal. Comparar "82EA"
    # con 0x82E9 en Tcl no hace lo que parece y da siempre que no.
    set n [reg PC]
    set pc [format %04X $n]
    say "ESCRITURA en 0xE0B9 desde PC=$pc"
    if {$n >= 0x82E9 && $n <= 0x82F0} {
        say "  es la decision del final (p02:82EA)"
        set ::decidido 1
    } else {
        say "  NO es la decision: viene de otro sitio, no cuenta"
    }
}

after time 12 { say "espacio: al titulo" ; pulsa 8 1 }
after time 15 { say "espacio: a empezar la partida" ; pulsa 8 1 }

proc espera_a_jugar {} {
    set e [lee 0xE000]
    if {$e == 5} { al_final_de_la_24 ; return }
    if {[machine_info time] > 60} { say "ROJO: no se llega al estado 5 (va por el $e)" ; exit 1 }
    after time 0.5 espera_a_jugar
}
after time 17 espera_a_jugar

proc al_final_de_la_24 {} {
    global PAUSAS
    say "partida montada. Se le pone la fase 24 y se salta a la decision"
    pon 0xE092 24            ;# la FASE, de 1 a 24
    pon 0xE093 3             ;# el 1-2-3 del decorado: la condicion de p02:82C3
    pon 0xE091 0x24          ;# el numero que se pinta, en BCD, por coherencia
    pon 0xE0DE $PAUSAS       ;# las veces que se ha parado
    pon 0xE0B9 0xAA          ;# un valor imposible: asi se ve quien lo cambia
    pon 0xE001 5             ;# subestado 5...
    pon 0xE000 6             ;# ...del estado 6: mira_si_toca_bonus
    say "E092=[format %02X [lee 0xE092]] E093=[format %02X [lee 0xE093]] E0DE=[format %02X [lee 0xE0DE]] E0B9=AA"
    after time 2 mira_como_ha_quedado
}

proc mira_como_ha_quedado {} {
    global PAUSAS
    if {!$::decidido} {
        if {[machine_info time] > 90} { say "ROJO: la decision no ha llegado a ejecutarse" ; exit 1 }
        after time 1 mira_como_ha_quedado
        return
    }
    set b [lee 0xE0B9]
    set esperado [expr {($PAUSAS & 3) == 1 ? 0 : 1}]
    say "0xE0B9 = [format %02X $b]  -> final [expr {$b == 0 ? {BUENO} : {malo}}]"
    if {$b == $esperado} { say "VERDE: coincide con lo que predice el listado" } \
    else { say "ROJO: el listado predecia [format %02X $esperado]" }
    # y ahora las fotos del texto que sube, que es la prueba que se ve
    foreach s {14 22 30 38} {
        after time $s [list apply {{s} {
            catch {screenshot -raw $::env(PA_OUT)/final_$::env(PA_PAUSAS)_$s.png}
            say "foto a los $s s del final"
        }} $s]
    }
    after time 42 { exit 0 }
}
