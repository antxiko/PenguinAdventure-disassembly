# omsx_secreto.tcl - los secretos de las fases 6 y 13: que premio dan y que bandera pone.
#
# Fuerza la fase en p00:46E3 como tools/omsx_tienda.tcl y en el cuadro 5 de
# juego (p00:451C) pone el anillo (0xE167) y 0xE1F1 (que no se muera).
#   fase 6, PA_MODO=nat:  salta cada 24 cuadros; se apunta cada pez que baja
#                         0xE111 (p03:B45A) hasta el premio.
#   fase 6, PA_MODO=poke: 0xE111 a cero en el cuadro 60.
#   fase 13:              izquierda pulsada toda la fase; se apunta 0xE112.
# Cuando sale lo del premio (0xE0D7 != 0, p03:BF60) se le pone encima del
# pinguino (0xE0DA/0xE0DB) para que p03:B36B lo coja, y se apunta que bandera
# de 0xE160 cambia; luego 40 cuadros con derecha, para medir cuanto se anda.
#
#   PA_OUT=<dir> PA_FASE=6|13 PA_MODO=nat|poke openmsx -machine C-BIOS_MSX1_EU
#       -cart penguinadventure.rom -script tools/omsx_secreto.tcl
set OUT $::env(PA_OUT)
set FASE $::env(PA_FASE)
set MODO $::env(PA_MODO)
file mkdir $OUT
set LOG [open "$OUT/secreto_f${FASE}_$MODO.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc h {a} { return [format %02X [lee $a]] }
proc seguro {orden} {
    if {[catch {uplevel #0 $orden} e]} { say "ERROR en '$orden': $e" ; exit 1 }
}
proc banderas {} {
    set s ""
    for {set a 0xE160} {$a < 0xE174} {incr a} { append s [h $a] }
    return $s
}
set ::armado 0
set ::forzada 0
set ::cuadro 0
set ::fase_ok 0
set ::bolsa 0
set ::cogida 0
set ::ultimo ""

proc pulsa {fila mascara} {
    keymatrixdown $fila $mascara
    after time 0.3 [list keymatrixup $fila $mascara]
}

proc fuerza {} {
    global FASE
    if {!$::armado || $::forzada} return
    set ::forzada 1
    pon 0xE092 $FASE
    pon 0xE091 [expr {($FASE / 10) * 16 + ($FASE % 10)}]
    pon 0xE093 [expr {(($FASE - 1) % 3) + 1}]
    pon 0xE08F 0
    pon 0xE082 0
    say "fase forzada: E092=[lee 0xE092]"
}

proc cuadro {} {
    global FASE MODO
    if {!$::forzada} return
    incr ::cuadro
    if {$::cuadro == 1} {
        say "primer cuadro de juego: ESTADO [lee 0xE000].[lee 0xE001] fase [lee 0xE092]  E110..E117=[h 0xE110][h 0xE111][h 0xE112][h 0xE113][h 0xE114][h 0xE115][h 0xE116][h 0xE117]  banderas=[banderas]"
    }
    if {$::cuadro == 5} {
        pon 0xE167 1
        pon 0xE1F1 1
        say "cuadro 5: E167=1 (el anillo) y E1F1=1 (que no muera)"
        if {$FASE == 13} { keymatrixdown 8 0x10 ; say "izquierda pulsada" }
    }
    if {$FASE == 6 && $MODO eq "nat" && !$::cogida && $::cuadro > 5 && $::cuadro % 24 == 0} {
        keymatrixdown 8 1
        after time 0.1 { keymatrixup 8 1 }
    }
    if {$FASE == 6 && $MODO eq "poke" && $::cuadro == 60} {
        pon 0xE111 0
        say "cuadro 60: E111=0 a mano"
    }
    set now "E0A6=[h 0xE0A6] E111=[h 0xE111] E112=[h 0xE112] E115=[h 0xE115] E110=[h 0xE110] E0D7=[h 0xE0D7]"
    if {$now ne $::ultimo} {
        if {$FASE == 6 || [lee 0xE112] % 16 == 0 || [lee 0xE0A6] != [string range $::ultimo 5 6]} {
            say "c$::cuadro E08D=[h 0xE08E][h 0xE08D] X=[h 0xE205] Y=[h 0xE204] E203=[h 0xE203] $now"
        }
        set ::ultimo $now
    }
    if {!$::cogida && [lee 0xE0D7] != 0} {
        if {!$::bolsa} {
            set ::bolsa 1
            say "LA BOLSA SALE: E0D7=[h 0xE0D7] en Y=[h 0xE0DA] X=[h 0xE0DB] (pinguino X=[h 0xE205] Y=[h 0xE204])  banderas=[banderas]"
        }
        pon 0xE0DA [expr {([lee 0xE204] + 8) & 0xFF}]
        pon 0xE0DB [expr {([lee 0xE205] + 8) & 0xFF}]
    }
    if {$::bolsa && !$::cogida && [lee 0xE0D7] == 0} {
        set ::cogida 1
        say "BOLSA COGIDA: banderas E160..E173=[banderas]  E16D=[h 0xE16D] E16E=[h 0xE16E]"
        keymatrixup 8 0x10
        set ::x0 [lee 0xE205]
        set ::c0 $::cuadro
    }
    if {$::cogida && $::cuadro == $::c0 + 1} { keymatrixdown 8 0x80 }
    if {$::cogida && $::cuadro == $::c0 + 41} {
        keymatrixup 8 0x80
        say "derecha 40 cuadros: X de [format %02X $::x0] a [h 0xE205]"
        exit 0
    }
}

proc vigila {} {
    after time 0.05 vigila
}

set throttle off
debug set_bp 0x46E3 {} {seguro fuerza}
debug set_bp 0x451C {} {seguro cuadro}
debug set_watchpoint write_mem 0xE111 {} {seguro {if {[reg PC] != 0xBE89 && [reg PC] != 0xBE87} {say "escribe E111=[h 0xE111] pc=[format %04X [reg PC]] E203=[h 0xE203] E167=[h 0xE167]"}}}
debug set_watchpoint write_mem 0xE115 {} {seguro {say "escribe E115=[h 0xE115] E110=[h 0xE110] pc=[format %04X [reg PC]]"}}
after time 12 { say "espacio: al titulo" ; pulsa 8 1 }
after time 15 { set ::armado 1 ; say "espacio: a empezar la partida" ; pulsa 8 1 }
after time 400 { say "ROJO: se acabo el tiempo; cuadro $::cuadro banderas=[banderas]" ; exit 1 }
