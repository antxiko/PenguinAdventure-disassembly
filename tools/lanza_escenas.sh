#!/bin/sh
# lanza_escenas.sh: las tres escenas de p03:AA80 con un volcado cada dos
# cuadros (PA_CADA, ver tools/omsx_escenas.tcl), en work/escenas_en_marcha
R=$(cd "$(dirname "$0")/.." && pwd)
for e in "arbol 12 1" "bueno 24 1" "malo 24 0"; do
  set -- $e
  d=$R/work/escenas_en_marcha/$1
  rm -rf $d; mkdir -p $d
  ( cd $R && PA_OUT="$d" PA_FASE=$2 PA_PAUSAS=$3 PA_CADA=2 \
    timeout 600 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script tools/omsx_escenas.tcl > $d/stdout.txt 2>&1 ) &
done
wait
echo hecho
