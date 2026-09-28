#!/bin/sh
# lanza_tiendas.sh: la tienda escondida (tools/omsx_tienda.tcl) con los tres
# tenderos y en fases que entre todas venden los catorce articulos, en
# work/tiendas, de uno en uno. Cada entrada es fase:modo:puntos (BCD).
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/tiendas
mkdir -p $d
for e in 1:3:0x0250 1:4:0 6:5:0x0130 9:3:0 12:5:0x0999 18:4:0x0500 22:3:0; do
  f=${e%%:*}; r=${e#*:}; m=${r%%:*}; p=${r#*:}
  ( cd $R && PA_OUT="$d" PA_FASE=$f PA_MODO=$m PA_PUNTOS=$p \
    timeout 300 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_EU -cart penguinadventure.rom -script tools/omsx_tienda.tcl > /dev/null 2>&1 ) &
  while [ $(jobs -r | wc -l) -ge 1 ]; do sleep 2; done
done
wait
echo hecho
