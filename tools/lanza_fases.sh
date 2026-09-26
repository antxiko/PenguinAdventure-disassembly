#!/bin/sh
# lanza_fases.sh NIVEL "fases" CUADROS CADA : una sonda por fase, seis a la vez
N=$1; FASES=$2; FIN=$3; CADA=$4
R=$(cd "$(dirname "$0")/.." && pwd)
for f in $FASES; do
  d=$R/work/fases/n$N/f$(printf %02d $f)
  mkdir -p $d
  ( cd $R && PA_OUT="$d" PA_FASE=$f PA_NIVEL=$N PA_INMUNE=1 PA_CORRE=1 PA_SALTA=1 PA_CADA=$CADA PA_LIMITE=600 PA_CUADROS="10 $FIN" \
    timeout 900 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script tools/omsx_fases.tcl > $d/stdout.txt 2>&1 ) &
  while [ $(jobs -r | wc -l) -ge 6 ]; do sleep 2; done
done
wait
echo hecho
