# omsx_escenas.tcl - Las tres escenas de p03:AA80, volcadas para cotejarlas.
#
# p02:82C3 decide al acabar una fase cuyo 1-2-3 (0xE093) vale 3: en la 12 deja
# 0xE0B9 = 2 -la escena del arbol- y en la 24 decide el final bueno (0) o el
# malo (1) con las veces que se ha pausado (0xE0DE). Sin jugar: en cuanto la
# partida esta montada se ponen la fase, el 1-2-3 y las pausas, y se mete la
# maquina de estados en el estado 6, subestado 5 (como tools/omsx_final.tcl).
# Luego se vuelca la VRAM y la RAM cada medio segundo mientras dura la escena.
#
#   PA_OUT=<dir> PA_FASE=<12|24> PA_PAUSAS=<n> \
#   openmsx -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script este.tcl
set OUT $::env(PA_OUT)
set FASE $::env(PA_FASE)
set PAUSAS [expr {[info exists ::env(PA_PAUSAS)] ? $::env(PA_PAUSAS) : 1}]
file mkdir $OUT
set LOG [open "$OUT/escena.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %7.2f [machine_info time]]  $m"; flush $LOG }
proc lee {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc pulsa {fila mascara} {
    keymatrixdown $fila $mascara
    after time 0.2 [list keymatrixup $fila $mascara]
}
set ::n 0
proc vuelca {} {
    global OUT
    incr ::n
    set nombre [format "e%03d_%d_%d_b%d" $::n [lee 0xE000] [lee 0xE001] [lee 0xE0B9]]
    set f [open "$OUT/$nombre.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 16384]
    close $f
    set f [open "$OUT/$nombre.ram" wb]
    puts -nonewline $f [debug read_block memory 0xE000 4096]
    close $f
    if {$::n < 120} { after time 0.5 vuelca } else { say "fin" ; exit 0 }
}
set throttle off
after time 12 { pulsa 8 1 }
after time 15 { pulsa 8 1 }
proc espera_a_jugar {} {
    if {[lee 0xE000] == 5} {
        pon 0xE092 $::FASE
        pon 0xE093 3
        pon 0xE091 [expr {($::FASE / 10) * 16 + ($::FASE % 10)}]
        pon 0xE0DE $::PAUSAS
        pon 0xE001 5
        pon 0xE000 6
        say "fase $::FASE, pausas $::PAUSAS: al estado 6.5"
        after time 0.5 vuelca
        return
    }
    if {[machine_info time] > 60} { say "ROJO: no se llega a jugar" ; exit 1 }
    after time 0.5 espera_a_jugar
}
after time 17 espera_a_jugar
after time 200 { exit 1 }
