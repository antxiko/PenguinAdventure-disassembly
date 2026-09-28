# omsx_mapa.tcl - El mapa de antes de cada fase (estado 4), volcado para cotejarlo.
#
# Arranca una partida y, la primera vez que entra en p02:81A0 (el estado 4.0,
# el que prepara el mapa), pone la fase (0xE092 y 0xE091 en BCD) y las seis
# banderas de los atajos (0xE0C6-0xE0CB, una por bit de PA_ATAJOS). Cuando el
# guion de la escena llega al paso de los sprites (0xE0B5 = 5) espera un poco
# y vuelca la VRAM y la RAM.
#
#   PA_OUT=<dir> PA_FASE=<1..24> PA_ATAJOS=<0..63> \
#   openmsx -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script este.tcl
set OUT $::env(PA_OUT)
set FASE $::env(PA_FASE)
set ATAJOS [expr {[info exists ::env(PA_ATAJOS)] ? $::env(PA_ATAJOS) : 0}]
file mkdir $OUT
set LOG [open [format "%s/mapa_f%02d_a%02d.log" $OUT $FASE $ATAJOS] w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc pulsa {fila mascara} {
    keymatrixdown $fila $mascara
    after time 0.2 [list keymatrixup $fila $mascara]
}
set ::armado 0
set ::puesta 0
proc pon_la_fase {} {
    global FASE ATAJOS
    if {!$::armado || $::puesta} return
    set ::puesta 1
    pon 0xE092 $FASE
    pon 0xE091 [expr {($FASE / 10) * 16 + ($FASE % 10)}]
    for {set k 0} {$k < 6} {incr k} { pon [expr {0xE0C6 + $k}] [expr {($ATAJOS >> $k) & 1}] }
    say "fase $FASE, atajos $ATAJOS"
    after time 0.2 espera_al_pinguino
}
proc espera_al_pinguino {} {
    if {[lee 0xE0B5] == 5} { after time 0.3 vuelca ; return }
    if {[machine_info time] > 90} { say "ROJO: el mapa no llega a los sprites" ; exit 1 }
    after time 0.1 espera_al_pinguino
}
proc vuelca {} {
    global OUT FASE ATAJOS
    set nombre [format "mapa_f%02d_a%02d" $FASE $ATAJOS]
    set f [open "$OUT/$nombre.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 16384]
    close $f
    set f [open "$OUT/$nombre.ram" wb]
    puts -nonewline $f [debug read_block memory 0xE000 4096]
    close $f
    say "volcado $nombre E0B5=[lee 0xE0B5] E143=[lee 0xE143] E141=[format %02X%02X [lee 0xE142] [lee 0xE141]]"
    exit 0
}
set throttle off
debug set_bp 0x81A0 {} {pon_la_fase}
after time 12 { pulsa 8 1 }
after time 15 { set ::armado 1 ; pulsa 8 1 }
after time 120 { say "ROJO: tiempo" ; exit 1 }
