# Comprueba EN MARCHA las dos claves de teclado que el listado dice que existen.
#
# Lo que dice el listado: p02:9522 vigila NUEVE teclas -A, I, K, M, N, O, R, U
# y Z- con SNSMAT de la BIOS, guarda en la cola de 0xF0F8 el numero de la
# ultima que acaba de pulsarse, y p02:9634 compara esas seis con dos patrones
# de 0x965F. NORIKO deja 0xFE en 0xF0F7 y KAZUMI 0xFF, y con eso aparece el
# CONTINUE al acabarse la partida (p02:8937 y p02:8A32).
#
# Esto lo prueba de verdad: arranca, espera a la pantalla del titulo, pulsa las
# seis teclas UNA A UNA sobre la matriz y lee 0xF0F7 y la cola de 0xF0F8.
#
# Trampas ya pagadas, y estas cuatro han costado una tarde:
#   - LA MAQUINA IMPORTA. Con Philips_VG_8020 este cartucho se queda en la
#     pantalla de arranque del BASIC y no llega a correr nunca. Con
#     C-BIOS_MSX1_EU arranca: se nota en que 0xE003 -el contador de cuadros- se
#     mueve y en que 0xF0F7 se pone a 0, que es lo que hace el INIT de p00:40BD.
#   - con `throttle off` la captura sale RANCIA -el render no se refresca- y se
#     ve la pantalla de hace varios segundos. Se corre a velocidad real.
#   - `type` no sirve: manda la tecla demasiado poco tiempo y el vigilante, que
#     solo apunta la tecla cuando CAMBIA de suelta a pulsada, no llega a verla.
#     Se pulsa la matriz a mano con keymatrixdown/keymatrixup.
#   - y las teclas hay que soltarlas: dos pulsaciones seguidas sin soltar en
#     medio son UNA sola para el vigilante.
#
#   PA_OUT=<dir> [PA_CLAVE=NORIKO] openmsx -machine C-BIOS_MSX1_EU \
#       -carta penguinadventure.rom -script este.tcl
set OUT $::env(PA_OUT)
set CLAVE [expr {[info exists ::env(PA_CLAVE)] ? $::env(PA_CLAVE) : "NORIKO"}]
file mkdir $OUT
set LOG [open "$OUT/claves.log" w]
proc say {m} { global LOG; puts $LOG "t=[format %8.2f [machine_info time]]  $m"; flush $LOG }

catch {set renderer SDLGL-PP}
set throttle on

# La matriz del MSX: fila y bit de cada una de las nueve teclas que vigila
# p02:9522, en el mismo orden en que las mira -que es el que da su numero-.
array set TECLA {
    A {2 6}  I {3 6}  K {4 0}  M {4 2}  N {4 3}
    O {4 4}  R {4 7}  U {5 2}  Z {5 7}
}

proc lee {a} { return [debug read memory $a] }

proc cola {} {
    set s {}
    for {set i 0} {$i < 6} {incr i} { lappend s [format %02X [lee [expr {0xF0F8 + $i}]]] }
    return [join $s " "]
}

say "clave a probar: $CLAVE"

# El vigilante de las claves solo corre en el ESTADO 3 (p02:80DC), asi que no
# vale teclear a ojo: se espera a que 0xE000 llegue a 3.
proc espera_al_estado_3 {} {
    set e [lee 0xE000]
    say "estado = [format %02X $e]"
    # medio segundo de respiro: si la primera tecla se pulsa en el mismo
    # instante de entrar en el estado 3, el vigilante se la pierde.
    if {$e == 3} { after time 0.5 arranca_la_clave ; return }
    if {[machine_info time] > 90} { say "ROJO: no se llega al estado 3" ; exit 1 }
    after time 1 espera_al_estado_3
}

# Al estado 3 no se llega solo: el ciclo de atraccion va 0 -> 1 -> 2 -> 0 y
# hay que PULSAR para entrar. Medido en openMSX: el estado 1 empieza sobre el
# segundo 11.
after time 12 {
    say "espacio para entrar en el titulo"
    keymatrixdown 8 1
    after time 0.25 { keymatrixup 8 1 ; after time 1 espera_al_estado_3 }
}

proc arranca_la_clave {} {
    say "0xE003 = [format %02X [lee 0xE003]]  (si se mueve, el cartucho corre)"
    say "estado = [format %02X [lee 0xE000]]  subestado = [format %02X [lee 0xE001]]"
    say "0xF0F7 antes = [format %02X [lee 0xF0F7]]"
    say "cola  antes  = [cola]"
    set ::i 0
    proc siguiente {} {
        global CLAVE TECLA
        if {$::i >= [string length $CLAVE]} {
            # y ahora ESPACIO, que es lo unico que dispara la comparacion:
            # p02:80F2 llama a mira_si_es_una_de_las_dos_claves justo despues
            # de ver el bit 4 de las teclas recien pulsadas.
            after time 0.4 {
                say "estado al pulsar = [format %02X [lee 0xE000]]  cola = [cola]"
                keymatrixdown 8 1
                after time 0.20 { keymatrixup 8 1 }
            }
            after time 2 {
                say "0xF0F7 DESPUES = [format %02X [lee 0xF0F7]]"
                say "cola  despues  = [cola]"
                set v [lee 0xF0F7]
                if {$v == 0xFE} { say "VERDE: 0xFE, o sea NORIKO" } \
                elseif {$v == 0xFF} { say "VERDE: 0xFF, o sea KAZUMI" } \
                else { say "ROJO: 0xF0F7 se ha quedado en [format %02X $v]" }
                after realtime 0.5 {
                    catch {screenshot -raw $::env(PA_OUT)/tras_la_clave.png}
                    exit 0
                }
            }
            return
        }
        set c [string index $CLAVE $::i]
        incr ::i
        set fb $TECLA($c)
        set fila [lindex $fb 0]
        set mascara [expr {1 << [lindex $fb 1]}]
        keymatrixdown $fila $mascara
        after time 0.20 [list apply {{fila mascara c} {
            keymatrixup $fila $mascara
            say "pulsada $c (fila $fila mascara [format %02X $mascara]) -> cola [cola]"
            after time 0.20 siguiente
        }} $fila $mascara $c]
    }
    siguiente
}
