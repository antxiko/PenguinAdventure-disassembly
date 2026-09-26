#!/bin/sh
# lanza_pelea.sh NIVEL "fases": cada fase hasta su final y la pelea GANADA
# (PA_GANA, ver tools/omsx_fases.tcl), en work/pelea/nN/fNN, seis a la vez;
# con PA_GANA_DERECHA=1, en work/pelea/nN/fNN_der
N=$1; FASES=$2
R=$(cd "$(dirname "$0")/.." && pwd)
for f in $FASES; do
  d=$R/work/pelea/n$N/f$(printf %02d $f)${PA_GANA_DERECHA:+_der}
  rm -rf $d; mkdir -p $d
  ( cd $R && PA_OUT="$d" PA_FASE=$f PA_NIVEL=$N PA_INMUNE=1 PA_CORRE=1 PA_SALTA=1 PA_RAPIDO=1 PA_FIN_EN_FASE=1 PA_GANA=1 PA_GANA_DERECHA=${PA_GANA_DERECHA:-0} PA_GANA_TRAS=${PA_GANA_TRAS:-900} PA_LIMITE=2500 PA_CUADROS="10 60000" \
    timeout 1500 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script tools/omsx_fases.tcl > $d/stdout.txt 2>&1 ) &
  while [ $(jobs -r | wc -l) -ge 6 ]; do sleep 2; done
done
wait
echo hecho
