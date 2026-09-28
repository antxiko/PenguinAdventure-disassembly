#!/bin/sh
# lanza_mapas.sh: el mapa de antes de cada fase (tools/omsx_mapa.tcl), las 24
# sin atajos y unas cuantas con ellos, en work/mapas, de uno en uno
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/mapas
mkdir -p $d
for e in 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0 12:0 13:0 14:0 15:0 16:0 \
         17:0 18:0 19:0 20:0 21:0 22:0 23:0 24:0 7:1 10:3 13:7 16:15 19:31 22:63 24:63 24:42; do
  f=${e%:*}; a=${e#*:}
  ( cd $R && PA_OUT="$d" PA_FASE=$f PA_ATAJOS=$a \
    timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script tools/omsx_mapa.tcl > /dev/null 2>&1 ) &
  while [ $(jobs -r | wc -l) -ge 1 ]; do sleep 2; done
done
wait
echo hecho
