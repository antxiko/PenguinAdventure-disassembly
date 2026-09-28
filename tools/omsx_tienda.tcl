# omsx_tienda.tcl - La tienda escondida (estado 12), volcada para cotejarla.
#
# Arranca una partida, fuerza la fase en p00:46E3 como tools/omsx_fases.tcl y
# en el cuadro PA_CENTRO de juego (p00:451C) deja al pinguino en el centro de
# una grieta con modo, que es lo que hace p01:72F2: 0xE203 = 0x12, 0xE0A2 =
# PA_MODO y el aviso 0x20. Antes pone en el marcador PA_PUNTOS (BCD), que es
# lo que decide si sale la bolsa de apostar. Cuando el estado llega a 12.4 con
# el pinguino ya en su sitio (0xE203 = 0) espera medio segundo -para que
# p01:6E1E haya pintado el saludo- y vuelca (abierta). Luego pulsa izquierda,
# que desde la primera casilla lleva el cursor a END (p01:6E8D), dispara, y
# cuando p01:6F29 ha pintado la despedida (0xE11D = 1) vuelca otra vez
# (cierre) y se sale.
#
#   PA_OUT=<dir> PA_FASE=<1..24> PA_MODO=<3|4|5> PA_PUNTOS=<0xNNNN> \
#   openmsx -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script este.tcl
set OUT $::env(PA_OUT)
set FASE $::env(PA_FASE)
set MODO $::env(PA_MODO)
set PUNTOS [expr {[info exists ::env(PA_PUNTOS)] ? $::env(PA_PUNTOS) : 0}]
set CENTRO [expr {[info exists ::env(PA_CENTRO)] ? $::env(PA_CENTRO) : 20}]
file mkdir $OUT
set NOMBRE [format "tienda_f%02d_m%d" $FASE $MODO]
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc pulsa {fila mascara} {
    keymatrixdown $fila $mascara
    after time 0.3 [list keymatrixup $fila $mascara]
}
proc seguro {orden} {
    if {[catch {uplevel #0 $orden} e]} { say "ERROR en '$orden': $e" ; exit 1 }
}
set ::armado 0
set ::forzada 0
set ::cuadro 0
set ::paso 0

proc vuelca {sufijo} {
    global OUT NOMBRE
    set f [open "$OUT/${NOMBRE}_$sufijo.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 16384]
    close $f
    set f [open "$OUT/${NOMBRE}_$sufijo.ram" wb]
    puts -nonewline $f [debug read_block memory 0xE000 4096]
    close $f
    say "volcado ${NOMBRE}_$sufijo  E000.E001=[lee 0xE000].[lee 0xE001] E203=[format %02X [lee 0xE203]] E10C=[lee 0xE10C] E11D=[lee 0xE11D] E134=[lee 0xE134] casillas=[format %02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X [lee 0xE100] [lee 0xE101] [lee 0xE102] [lee 0xE103] [lee 0xE104] [lee 0xE105] [lee 0xE106] [lee 0xE107] [lee 0xE108] [lee 0xE109] [lee 0xE10A] [lee 0xE10B]]"
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
    say "fase forzada: E092=[lee 0xE092] E093=[lee 0xE093]"
}

proc cuadro {} {
    global MODO PUNTOS CENTRO
    if {!$::forzada} return
    incr ::cuadro
    if {$::cuadro == $CENTRO} {
        pon 0xE089 [expr {$PUNTOS & 0xFF}]
        pon 0xE08A [expr {($PUNTOS >> 8) & 0xFF}]
        pon 0xE203 0x12
        pon 0xE0A2 $MODO
        pon 0xE096 0x20
        say "cuadro $::cuadro: centro de una grieta con modo [lee 0xE0A2], puntos [format %02X%02X [lee 0xE08A] [lee 0xE089]]"
    }
}

proc vigila {} {
    if {$::forzada} {
        if {$::paso == 0 && [lee 0xE000] == 12 && [lee 0xE001] == 4 && [lee 0xE203] == 0} {
            set ::paso 1
            say "tienda abierta, el pinguino en la fila [format %02X [lee 0xE204]]"
            after time 0.5 {
                vuelca abierta
                set ::paso 2
                pulsa 8 0x10
                after time 0.5 { say "END: disparo" ; pulsa 8 1 }
            }
        }
        if {$::paso == 2 && [lee 0xE11D] == 1} {
            set ::paso 3
            after time 0.3 { vuelca cierre ; say "fin" ; exit 0 }
        }
    }
    after time 0.05 vigila
}

set throttle off
debug set_bp 0x46E3 {} {seguro fuerza}
debug set_bp 0x451C {} {seguro cuadro}
after time 12 { say "espacio: al titulo" ; pulsa 8 1 }
after time 15 { set ::armado 1 ; say "espacio: a empezar la partida" ; pulsa 8 1 }
after time 16 vigila
after time 240 { say "ROJO: se acabo el tiempo en el paso $::paso" ; exit 1 }
