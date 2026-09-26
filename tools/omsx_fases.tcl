# omsx_fases.tcl - Penguin Adventure EN MARCHA, en la fase que se pida.
#
# Para cotejar lo que se dibuja desde las tablas con lo que pone el cartucho.
# Arranca una partida, y en cuanto el juego llega a montar la primera fase
# (monta_la_fase_desde_el_decorado, p00:46E3, por donde pasan tanto el montaje
# normal como el del Game Master) le cambia la fase y el nivel. A partir de
# ahi cuenta los cuadros de juego (p00:451C, `cuadro`) y vuelca la VRAM entera,
# la RAM de 0xE000 a 0xEFFF y los ocho registros del VDP en los cuadros que se
# pidan. Y apunta en el registro cada vez que el guion de la fase suelta un
# objeto (0xE300 cambia), con lo que quedaba de fase (0xE08D) en ese momento.
#
#   PA_OUT=<dir> PA_FASE=<1..24> PA_NIVEL=<0|1> PA_CUADROS="10 200 ..." \
#   PA_INMUNE=<0|1> PA_CORRE=<0|1> \
#   openmsx -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script este.tcl
#
# PA_INMUNE mantiene lo que salva de todo (0xE1F1) y el tiempo (0xE08B) para
# que la fase llegue al final; cambia como se ve un hueco al pisarlo, asi que
# para las fotos del jugador va a 0. PA_CORRE deja pulsado arriba, PA_SALTA
# pulsa el salto (la barra, bit 4 del mando de p00:44C8) cada 60 cuadros y
# PA_CADA vuelca ademas cada tantos cuadros. PA_QUEDA=0xNNNN pone en el cuadro
# 60 lo que queda de fase (0xE08D, BCD) -NO SIRVE: el guion del terreno lo
# reescribe-. PA_RAPIDO pone a 1 el periodo del paso (0xE4C0, p01:64FF): la
# fase se anda a un paso por cuadro, que es lo que hace falta para llegar al
# final de las largas.
#
# La maquina importa: con Philips_VG_8020 este cartucho no arranca.
set OUT $::env(PA_OUT)
set FASE $::env(PA_FASE)
set NIVEL [expr {[info exists ::env(PA_NIVEL)] ? $::env(PA_NIVEL) : 0}]
set CUADROS [expr {[info exists ::env(PA_CUADROS)] ? $::env(PA_CUADROS) : {10 100 300 600 1000 1500 2000 3000}}]
set INMUNE [expr {[info exists ::env(PA_INMUNE)] ? $::env(PA_INMUNE) : 0}]
set CORRE [expr {[info exists ::env(PA_CORRE)] ? $::env(PA_CORRE) : 0}]
set SALTA [expr {[info exists ::env(PA_SALTA)] ? $::env(PA_SALTA) : 0}]
set CADA [expr {[info exists ::env(PA_CADA)] ? $::env(PA_CADA) : 0}]
set QUEDA [expr {[info exists ::env(PA_QUEDA)] ? $::env(PA_QUEDA) : 0}]
set RAPIDO [expr {[info exists ::env(PA_RAPIDO)] ? $::env(PA_RAPIDO) : 0}]
file mkdir $OUT
set LOG [open "$OUT/fase_[format %02d $FASE]_n$NIVEL.log" w]
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
set ::ultimo_guion -1
set ::ultimo_objeto {}
set ::ultimo_estado -1
set ::ultimo_q -1
set ::FIN_EN_FASE [expr {[info exists ::env(PA_FIN_EN_FASE)] ? $::env(PA_FIN_EN_FASE) : 0}]
set ::t_pelea 0
set ::saliendo 0
set LIMITE [expr {[info exists ::env(PA_LIMITE)] ? $::env(PA_LIMITE) : 400}]

proc vuelca {nombre} {
    global OUT
    set f [open "$OUT/$nombre.vram" wb]
    puts -nonewline $f [debug read_block VRAM 0 16384]
    close $f
    set f [open "$OUT/$nombre.ram" wb]
    puts -nonewline $f [debug read_block memory 0xE000 4096]
    close $f
    set r {}
    for {set i 0} {$i < 8} {incr i} { lappend r [format %02X [debug read "VDP regs" $i]] }
    set m [format "%02X %02X %02X" [lee 0xF0F1] [lee 0xF0F2] [lee 0xF0F3]]
    say "volcado $nombre  R0-7=$r  bancos=$m  E000=[format %02X [lee 0xE000]] E001=[format %02X [lee 0xE001]] E203=[format %02X [lee 0xE203]]"
}

proc fuerza {} {
    global FASE NIVEL
    if {!$::armado || $::forzada} return
    set ::forzada 1
    pon 0xE092 $FASE
    pon 0xE091 [expr {($FASE / 10) * 16 + ($FASE % 10)}]
    pon 0xE093 [expr {(($FASE - 1) % 3) + 1}]
    pon 0xE08F $NIVEL
    pon 0xE082 $NIVEL
    say "fase forzada: E092=[lee 0xE092] E091=[format %02X [lee 0xE091]] E093=[lee 0xE093] E08F=[lee 0xE08F]"
}

proc cuadro {} {
    global CUADROS INMUNE
    if {!$::forzada || $::saliendo} return
    incr ::cuadro
    if {$INMUNE} {
        pon 0xE1F1 1
        pon 0xE08B 0x99
    }
    if {$::SALTA} {
        if {$::cuadro % 60 == 0} { keymatrixdown 8 1 }
        if {$::cuadro % 60 == 8} { keymatrixup 8 1 }
    }
    if {$::QUEDA && $::cuadro == 60} {
        pon 0xE08D [expr {$::QUEDA & 0xFF}]
        pon 0xE08E [expr {$::QUEDA >> 8}]
        say "queda puesto a [format %04X $::QUEDA]"
    }
    set e [lee 0xE000]
    if {$e != $::ultimo_estado} {
        set ::ultimo_estado $e
        say "cuadro $::cuadro  ESTADO $e.[lee 0xE001]  queda=[format %02X%02X [lee 0xE08E] [lee 0xE08D]]  E0A1=[lee 0xE0A1]"
        vuelca [format "f%02d_n%d_c%05d_e%d" $::FASE $::NIVEL $::cuadro $e]
    }
    # los cortes del final de fase (p01:65CF): 0x30, 0x25, 0x20, 0x15, 0x10, 8, 5,
    # 2 y 0 de la meta, en BCD
    set q [lee 0xE08D]
    if {[lee 0xE08E] == 0 && $q != $::ultimo_q && [lsearch {48 37 32 21 16 8 5 2 0} $q] >= 0} {
        vuelca [format "f%02d_n%d_fin%02X_c%05d" $::FASE $::NIVEL $q $::cuadro]
    }
    set ::ultimo_q $q
    if {[lee 0xE092] != $::FASE && $::FIN_EN_FASE} {
        say "la fase ha cambiado: fin"
        set ::saliendo 1
        after time 0.2 exit
    }
    set g [lee 0xE300]
    if {$g != $::ultimo_guion} {
        set ::ultimo_guion $g
        set d [format "%02X%02X" [lee 0xE08E] [lee 0xE08D]]
        set o {}
        for {set k 0} {$k < 3} {incr k} {
            set b [expr {0xE310 + $k * 0x20}]
            set s {}
            for {set i 0} {$i < 8} {incr i} { append s [format %02X [lee [expr {$b + $i}]]] }
            lappend o $s
        }
        say "cuadro $::cuadro  E300=$g  queda=$d  objetos=$o"
    }
    if {[lsearch $CUADROS $::cuadro] >= 0 || ($::CADA && $::cuadro % $::CADA == 0)} {
        vuelca [format "f%02d_n%d_c%05d" $::FASE $::NIVEL $::cuadro]
    }
    if {$::cuadro >= [lindex $CUADROS end]} {
        say "fin"
        set ::saliendo 1
        after time 0.2 exit
    }
}

# Y un vigilante aparte, fuera del cuadro de juego (que no corre en las
# escenas de entre fases): cada decima de segundo mira el estado y el subestado
# (0xE000, 0xE001), el decorado (0xE0A1), la fase (0xE092), el modo (0xE0A2) y
# el blanco (0xE530), y vuelca cuando cambian.
set ::visto {}
proc vigila {} {
    if {$::forzada && !$::saliendo} {
        set v [list [lee 0xE000] [lee 0xE001] [lee 0xE0A1] [lee 0xE092] [lee 0xE0A2] [lee 0xE530]]
        if {$v ne $::visto} {
            set ::visto $v
            incr ::n_vigila
            say "VIGILA E000.E001=[lindex $v 0].[lindex $v 1] E0A1=[lindex $v 2] fase=[lindex $v 3] E0A2=[lindex $v 4] E530=[lindex $v 5] cuadro=$::cuadro"
            if {$::n_vigila < 400} { vuelca [format "v%04d_e%d_%d_f%02d" $::n_vigila [lindex $v 0] [lindex $v 1] [lindex $v 3]] }
        }
        if {[lindex $v 0] == 7} {
            if {$::INMUNE} { pon 0xE1F1 1 }
            incr ::t_pelea
            if {$::t_pelea % 5 == 0} { vuelca [format "f%02d_n%d_pelea%04d" $::FASE $::NIVEL $::t_pelea] }
            if {$::FIN_EN_FASE && $::t_pelea > 400} { say "pelea: fin" ; set ::saliendo 1 ; after time 0.2 exit }
        }
        if {$::FIN_EN_FASE && [lsearch {0 1 2 14 15} [lindex $v 0]] >= 0 && $::cuadro > 100} {
            say "fuera de la partida (estado [lindex $v 0]): fin" ; set ::saliendo 1 ; after time 0.2 exit
        }
    }
    after time 0.1 vigila
}
set ::n_vigila 0
after time 16 vigila

set throttle off
debug set_bp 0x46E3 {} {seguro fuerza}
debug set_bp 0x451C {} {seguro cuadro}
# el paso se pone justo antes de andar (p00:4560 llama a p01:64F0), porque la
# barra de p00:5F77 lo recalcula antes en el mismo cuadro
# cada cosa que sale del terreno: p01:6852 (`llena_la_ranura`) la mete en una
# de las cinco ranuras de 0xE440 con el tipo en C
set COSAS [open "$OUT/cosas_[format %02d $FASE]_n$NIVEL.log" w]
proc cosa {} {
    if {!$::forzada || [debug read memory 0xF0F1] != 1} return
    puts $::COSAS "[format %02X%02X [lee 0xE08E] [lee 0xE08D]] [format %02X [reg C]] [format %02X [lee 0xE402]] [lee 0xE404] [lee 0xE0A2]"
    flush $::COSAS
}
debug set_bp 0x6852 {} {seguro cosa}
proc rapido {} { if {$::RAPIDO && $::forzada} { pon 0xE4C0 1 ; pon 0xE4C1 1 } }
debug set_bp 0x4560 {} {seguro rapido}

after time 12 { say "espacio: al titulo" ; pulsa 8 1 }
after time 14 { pon 0xE082 $::NIVEL }
after time 15 { set ::armado 1 ; say "espacio: a empezar la partida" ; pulsa 8 1 }
if {$CORRE} { after time 16 { keymatrixdown 8 0x20 ; say "arriba pulsado" } }
after time $LIMITE { say "ROJO: se acabo el tiempo sin llegar al ultimo cuadro ($::cuadro)" ; exit 1 }
