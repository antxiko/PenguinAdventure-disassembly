; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 11 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS cola_9FFC: la cola del guion de bytes sueltos (0xFF acaba, 0xFE otro
;   destino) (de las ranuras de 0xE440) de 0x9FFC del banco 10, que pasa de
;   ranura sin cambiar de banco; lo cargan p00:4760, p01:6910 y p01:6985 por
;   0x89AE[6] (16 bytes)
;   0xa000..0xa010  (16 bytes)
DATA_cola_9FFC:
	defb 03eh,0feh,00eh,0edh,06fh,01bh,002h,070h,0feh,02eh,0edh,00ah,074h,074h,0fch,0ffh	; a000  >...o..p....tt..

; ----------------------------------------------------------------------
; DATOS tira_A010: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[7] (20 bytes)
;   0xa010..0xa024  (20 bytes)
DATA_tira_A010:
	defb 0eeh,0ech,058h,033h,0fah,0feh,00eh,0edh,08eh,01bh,054h,075h,0feh,02eh,0edh,092h	; a010  ..X3......Tu....
	defb 093h,094h,095h,0ffh	; a020

; ----------------------------------------------------------------------
; DATOS tira_A024: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[8] (26 bytes)
;   0xa024..0xa03e  (26 bytes)
DATA_tira_A024:
	defb 0eeh,0ech,058h,033h,0fah,0feh,00eh,0edh,078h,036h,054h,075h,0feh,02eh,0edh,079h	; a024  ..X3....x6Tu...y
	defb 077h,024h,076h,0feh,04eh,0edh,027h,0a8h,0a8h,0ffh	; a034  w$v.N.'...

; ----------------------------------------------------------------------
; DATOS tira_A03E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[9] (21 bytes)
;   0xa03e..0xa053  (21 bytes)
DATA_tira_A03E:
	defb 00eh,0edh,07ah,037h,018h,084h,0feh,02eh,0edh,07bh,01bh,002h,07ch,0feh,04eh,0edh	; a03e  ..z7.....{..|.N.
	defb 08dh,07dh,07eh,07fh,0ffh	; a04e

; ----------------------------------------------------------------------
; DATOS tira_A053: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[10] (27 bytes)
;   0xa053..0xa06e  (27 bytes)
DATA_tira_A053:
	defb 0eeh,0ech,0f5h,033h,0fah,0feh,00eh,0edh,087h,01bh,054h,03eh,0feh,02eh,0edh,088h	; a053  ...3......T>....
	defb 060h,002h,089h,0feh,04eh,0edh,08dh,08ch,08bh,08ah,0ffh	; a063  `...N......

; ----------------------------------------------------------------------
; DATOS tira_A06E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[11] (27 bytes)
;   0xa06e..0xa089  (27 bytes)
DATA_tira_A06E:
	defb 0eeh,0ech,0f5h,033h,0fah,0feh,00eh,0edh,096h,01bh,054h,03eh,0feh,02eh,0edh,01ah	; a06e  ...3......T>....
	defb 060h,002h,099h,0feh,04eh,0edh,01dh,052h,091h,06eh,0ffh	; a07e  `...N..R.n.

; ----------------------------------------------------------------------
; DATOS tira_A089: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[12] (36 bytes)
;   0xa089..0xa0ad  (36 bytes)
DATA_tira_A089:
	defb 0efh,0ech,033h,0fah,0feh,00eh,0edh,016h,002h,054h,03eh,0feh,02dh,0edh,097h,098h	; a089  ..3......T>.-...
	defb 01bh,002h,099h,09ah,0feh,04dh,0edh,097h,098h,082h,008h,09bh,0feh,06eh,0edh,085h	; a099  .....M.......n..
	defb 0fdh,085h,086h,0ffh	; a0a9

; ----------------------------------------------------------------------
; DATOS tira_A0AD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[13] (37 bytes)
;   0xa0ad..0xa0d2  (37 bytes)
DATA_tira_A0AD:
	defb 0efh,0ech,033h,0feh,00dh,0edh,0f5h,0e7h,036h,0dah,0eeh,0feh,02dh,0edh,0e6h,001h	; a0ad  ..3.....6...-...
	defb 01bh,0efh,0edh,070h,0feh,04dh,0edh,0e6h,001h,0d8h,024h,0ebh,0ech,0feh,06eh,0edh	; a0bd  ...p.M....$...n.
	defb 005h,0e8h,0e9h,0eah,0ffh	; a0cd

; ----------------------------------------------------------------------
; DATOS tira_A0D2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[14] (3 bytes)
;   0xa0d2..0xa0d5  (3 bytes)
DATA_tira_A0D2:
	defb 055h,0eeh,0ffh	; a0d2

; ----------------------------------------------------------------------
; DATOS tira_A0D5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[15] (3 bytes)
;   0xa0d5..0xa0d8  (3 bytes)
DATA_tira_A0D5:
	defb 076h,0eeh,0ffh	; a0d5

; ----------------------------------------------------------------------
; DATOS tira_A0D8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[0] (5 bytes)
;   0xa0d8..0xa0dd  (5 bytes)
DATA_tira_A0D8:
	defb 0f7h,0ech,029h,02ah,0ffh	; a0d8

; ----------------------------------------------------------------------
; DATOS tira_A0DD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[1] (5 bytes)
;   0xa0dd..0xa0e2  (5 bytes)
DATA_tira_A0DD:
	defb 0f7h,0ech,02bh,02ch,0ffh	; a0dd

; ----------------------------------------------------------------------
; DATOS tira_A0E2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[2] (10 bytes)
;   0xa0e2..0xa0ec  (10 bytes)
DATA_tira_A0E2:
	defb 0f7h,0ech,05eh,05fh,0feh,017h,0edh,0f7h,066h,0ffh	; a0e2  ..^_....f.

; ----------------------------------------------------------------------
; DATOS tira_A0EC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[3] (12 bytes)
;   0xa0ec..0xa0f8  (12 bytes)
DATA_tira_A0EC:
	defb 0f7h,0ech,0f5h,045h,0fah,0feh,017h,0edh,04eh,04fh,034h,0ffh	; a0ec  ...E....NO4.

; ----------------------------------------------------------------------
; DATOS tira_A0F8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[4] (12 bytes)
;   0xa0f8..0xa104  (12 bytes)
DATA_tira_A0F8:
	defb 0f7h,0ech,02dh,02eh,02fh,0feh,017h,0edh,030h,031h,032h,0ffh	; a0f8  ..-./...012.

; ----------------------------------------------------------------------
; DATOS tira_A104: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[5] (12 bytes)
;   0xa104..0xa110  (12 bytes)
DATA_tira_A104:
	defb 0f7h,0ech,03fh,040h,041h,0feh,017h,0edh,043h,044h,064h,0ffh	; a104  ..?@A...CDd.

; ----------------------------------------------------------------------
; DATOS tira_A110: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[6] (18 bytes)
;   0xa110..0xa122  (18 bytes)
DATA_tira_A110:
	defb 0d8h,0ech,04dh,0feh,0f7h,0ech,053h,01bh,054h,056h,0feh,017h,0edh,05ah,05bh,05ch	; a110  ..M...S.TV...Z[\
	defb 05dh,0ffh	; a120

; ----------------------------------------------------------------------
; DATOS tira_A122: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[7] (21 bytes)
;   0xa122..0xa137  (21 bytes)
DATA_tira_A122:
	defb 0f7h,0ech,021h,022h,018h,019h,0feh,017h,0edh,023h,01bh,024h,025h,0feh,037h,0edh	; a122  ..!".....#.$%.7.
	defb 027h,026h,028h,049h,0ffh	; a132

; ----------------------------------------------------------------------
; DATOS tira_A137: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[8] (21 bytes)
;   0xa137..0xa14c  (21 bytes)
DATA_tira_A137:
	defb 0f7h,0ech,03bh,03ch,03dh,03eh,0feh,017h,0edh,03bh,01bh,024h,042h,0feh,037h,0edh	; a137  ..;<=>...;.$B.7.
	defb 0f7h,04ah,04bh,04ch,0ffh	; a147

; ----------------------------------------------------------------------
; DATOS tira_A14C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[9] (22 bytes)
;   0xa14c..0xa162  (22 bytes)
DATA_tira_A14C:
	defb 0f7h,0ech,058h,059h,037h,018h,019h,0feh,017h,0edh,058h,001h,0bch,002h,039h,0feh	; a14c  ..XY7.....X...9.
	defb 038h,0edh,062h,063h,064h,0ffh	; a15c

; ----------------------------------------------------------------------
; DATOS tira_A162: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[10] (21 bytes)
;   0xa162..0xa177  (21 bytes)
DATA_tira_A162:
	defb 0f8h,0ech,016h,017h,018h,019h,0feh,018h,0edh,01ah,01bh,002h,01ch,0feh,038h,0edh	; a162  ..............8.
	defb 01dh,01eh,01fh,020h,0ffh	; a172

; ----------------------------------------------------------------------
; DATOS tira_A177: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[11] (28 bytes)
;   0xa177..0xa193  (28 bytes)
DATA_tira_A177:
	defb 0d9h,0ech,033h,0fah,0feh,0f8h,0ech,035h,036h,037h,038h,0feh,018h,0edh,03ah,01bh	; a177  ..3....5678...:.
	defb 002h,002h,039h,0feh,038h,0edh,03ah,046h,047h,048h,049h,0ffh	; a187  ..9.8.:FGHI.

; ----------------------------------------------------------------------
; DATOS tira_A193: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[12] (37 bytes)
;   0xa193..0xa1b8  (37 bytes)
DATA_tira_A193:
	defb 0d9h,0ech,0f5h,0f9h,0feh,0f8h,0ech,055h,036h,037h,018h,057h,0feh,018h,0edh,050h	; a193  .......U67.W...P
	defb 01bh,002h,002h,01ch,0feh,038h,0edh,050h,060h,047h,061h,020h,0feh,059h,0edh,051h	; a1a3  .....8.P`Ga .Y.Q
	defb 0feh,05bh,0edh,051h,0ffh	; a1b3

; ----------------------------------------------------------------------
; DATOS tira_A1B8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[13] (37 bytes)
;   0xa1b8..0xa1dd  (37 bytes)
DATA_tira_A1B8:
	defb 0dah,0ech,033h,0feh,0f8h,0ech,0f5h,0e7h,036h,0dah,0eeh,0feh,018h,0edh,0e6h,001h	; a1b8  ..3.....6.......
	defb 01bh,0efh,0edh,070h,0feh,038h,0edh,0e6h,001h,0d8h,024h,0ebh,0ech,0feh,059h,0edh	; a1c8  ...p.8....$...Y.
	defb 005h,0e8h,0e9h,0eah,0ffh	; a1d8

; ----------------------------------------------------------------------
; DATOS tira_A1DD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[14] (39 bytes)
;   0xa1dd..0xa204  (39 bytes)
DATA_tira_A1DD:
	defb 0fbh,0ech,0f5h,0e5h,0fah,0feh,01ah,0edh,0d5h,0d9h,036h,0dah,0dbh,0feh,03ah,0edh	; a1dd  ..........6...:.
	defb 0ceh,001h,01bh,002h,0deh,0cfh,0feh,05ah,0edh,0ceh,001h,0d8h,024h,0ebh,0ddh,0feh	; a1ed  .......Z....$...
	defb 07bh,0edh,0d6h,0d0h,0dfh,0dch,0ffh	; a1fd

; ----------------------------------------------------------------------
; DATOS tira_A204: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89CE[15] (24 bytes)
;   0xa204..0xa21c  (24 bytes)
DATA_tira_A204:
	defb 0ffh,0ech,0d4h,0feh,01eh,0edh,0d3h,036h,0feh,03eh,0edh,0d2h,01bh,0feh,05eh,0edh	; a204  .......6.>....^.
	defb 0d2h,001h,0feh,07eh,0edh,0e2h,0e3h,0ffh	; a214  ...~....

; ----------------------------------------------------------------------
; DATOS tira_A21C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89EE[14] (22 bytes)
;   0xa21c..0xa232  (22 bytes)
DATA_tira_A21C:
	defb 04dh,0eeh,0ebh,001h,0ebh,001h,001h,0ebh,0feh,06bh,0eeh,0ebh,001h,001h,0ebh,001h	; a21c  M........k......
	defb 0ebh,0ebh,001h,001h,0ebh,0ffh	; a22c

; ----------------------------------------------------------------------
; DATOS tira_A232: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89EE[15] (33 bytes)
;   0xa232..0xa253  (33 bytes)
DATA_tira_A232:
	defb 02ch,0eeh,0ebh,001h,001h,001h,001h,001h,001h,0ebh,0feh,04eh,0eeh,0ebh,001h,001h	; a232  ,..........N....
	defb 0ebh,0feh,06ah,0eeh,0ebh,001h,001h,0ebh,001h,001h,0ebh,001h,0ebh,001h,001h,0ebh	; a242  ..j.............
	defb 0ffh	; a252

; ----------------------------------------------------------------------
; DATOS tira_A253: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A0E[14] (15 bytes)
;   0xa253..0xa262  (15 bytes)
DATA_tira_A253:
	defb 040h,0eeh,0ebh,001h,001h,0ebh,0feh,061h,0eeh,0ebh,0ebh,001h,001h,0ebh,0ffh	; a253  @......a.......

; ----------------------------------------------------------------------
; DATOS tira_A262: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A0E[15] (17 bytes)
;   0xa262..0xa273  (17 bytes)
DATA_tira_A262:
	defb 024h,0eeh,0ebh,0feh,041h,0eeh,0ebh,0feh,060h,0eeh,0ebh,001h,0ebh,001h,001h,0ebh	; a262  $...A...`.......
	defb 0ffh	; a272

; ----------------------------------------------------------------------
; DATOS tira_A273: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A2E[14] (16 bytes)
;   0xa273..0xa283  (16 bytes)
DATA_tira_A273:
	defb 05bh,0eeh,0ebh,001h,0ebh,0feh,079h,0eeh,0ebh,001h,001h,0ebh,001h,0ebh,0ebh,0ffh	; a273  [.....y.........

; ----------------------------------------------------------------------
; DATOS tira_A283: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A2E[15] (11 bytes)
;   0xa283..0xa28e  (11 bytes)
DATA_tira_A283:
	defb 05dh,0eeh,0ebh,0feh,07ch,0eeh,0ebh,001h,001h,0ebh,0ffh	; a283  ]...|......

; ----------------------------------------------------------------------
; DATOS tira_A28E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A4E[14] (24 bytes)
;   0xa28e..0xa2a6  (24 bytes)
DATA_tira_A28E:
	defb 043h,0eeh,067h,001h,067h,001h,001h,067h,001h,067h,001h,067h,0feh,064h,0eeh,067h	; a28e  C.g.g..g.g.g.d.g
	defb 001h,067h,067h,001h,067h,001h,067h,0ffh	; a29e  .gg.g.g.

; ----------------------------------------------------------------------
; DATOS tira_A2A6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A4E[15] (39 bytes)
;   0xa2a6..0xa2cd  (39 bytes)
DATA_tira_A2A6:
	defb 023h,0eeh,067h,001h,001h,067h,001h,001h,067h,001h,001h,001h,067h,0feh,045h,0eeh	; a2a6  #.g..g..g...g.E.
	defb 067h,001h,001h,067h,001h,001h,067h,0feh,062h,0eeh,067h,001h,067h,001h,067h,001h	; a2b6  g..g..g.b.g.g.g.
	defb 001h,067h,001h,001h,001h,067h,0ffh	; a2c6

; ----------------------------------------------------------------------
; DATOS tira_A2CD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A6E[14] (24 bytes)
;   0xa2cd..0xa2e5  (24 bytes)
DATA_tira_A2CD:
	defb 053h,0eeh,067h,001h,067h,001h,067h,001h,001h,067h,001h,067h,0feh,074h,0eeh,067h	; a2cd  S.g.g.g..g.g.t.g
	defb 001h,067h,001h,067h,067h,001h,067h,0ffh	; a2dd  .g.gg.g.

; ----------------------------------------------------------------------
; DATOS tira_A2E5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A6E[15] (39 bytes)
;   0xa2e5..0xa30c  (39 bytes)
DATA_tira_A2E5:
	defb 032h,0eeh,067h,001h,001h,001h,067h,001h,001h,067h,001h,001h,067h,0feh,054h,0eeh	; a2e5  2.g...g..g..g.T.
	defb 067h,001h,001h,067h,001h,001h,067h,0feh,072h,0eeh,067h,001h,001h,001h,067h,001h	; a2f5  g..g..g.r.g...g.
	defb 001h,067h,001h,067h,001h,067h,0ffh	; a305

; ----------------------------------------------------------------------
; DATOS tira_A30C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A8E[14] (63 bytes)
;   0xa30c..0xa34b  (63 bytes)
DATA_tira_A30C:
	defb 003h,0eeh,06dh,001h,001h,001h,06ch,06dh,001h,06ch,06dh,001h,001h,001h,06ch,001h	; a30c  ..m...lm.lm...l.
	defb 06ch,06dh,0feh,023h,0eeh,06ch,070h,06eh,06fh,070h,06eh,06fh,070h,06eh,06fh,070h	; a31c  lm.#.lpnopnopnop
	defb 06eh,06fh,070h,06eh,06fh,070h,0feh,042h,0eeh,086h,07dh,085h,07fh,085h,07fh,085h	; a32c  nopnop.B..}.....
	defb 07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,082h,08ch,0ffh	; a33c  ...............

; ----------------------------------------------------------------------
; DATOS tira_A34B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8A8E[15] (75 bytes)
;   0xa34b..0xa396  (75 bytes)
DATA_tira_A34B:
	defb 024h,0eeh,06ch,06dh,001h,001h,06ch,06dh,001h,001h,001h,001h,06ch,06dh,001h,001h	; a34b  $.lm..lm....lm..
	defb 06ch,06dh,0feh,041h,0eeh,071h,072h,075h,001h,071h,072h,073h,001h,074h,075h,071h	; a35b  lm.A.qru.qrs.tuq
	defb 073h,073h,074h,075h,071h,073h,073h,075h,071h,073h,075h,074h,075h,0feh,060h,0eeh	; a36b  sstuqssuqsutu.`.
	defb 074h,075h,071h,072h,073h,001h,071h,073h,001h,001h,074h,075h,001h,071h,072h,073h	; a37b  tuqrs.qs..tu.qrs
	defb 001h,071h,073h,001h,001h,071h,073h,073h,001h,071h,0ffh	; a38b  .qs..qss.q.

; ----------------------------------------------------------------------
; DATOS tira_A396: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8AAE[14] (63 bytes)
;   0xa396..0xa3d5  (63 bytes)
DATA_tira_A396:
	defb 00ah,0eeh,06dh,001h,001h,001h,06ch,06dh,001h,06ch,06dh,001h,001h,001h,06ch,001h	; a396  ..m...lm.lm...l.
	defb 06ch,06dh,0feh,02ah,0eeh,06ch,070h,06eh,06fh,070h,06eh,06fh,070h,06eh,06fh,070h	; a3a6  lm.*.lpnopnopnop
	defb 06eh,06fh,070h,06eh,06fh,070h,0feh,049h,0eeh,086h,07dh,085h,07fh,085h,07fh,085h	; a3b6  nopnop.I..}.....
	defb 07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,082h,08ch,0ffh	; a3c6  ...............

; ----------------------------------------------------------------------
; DATOS tira_A3D5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x8AAE[15] (75 bytes)
;   0xa3d5..0xa420  (75 bytes)
DATA_tira_A3D5:
	defb 02ah,0eeh,06ch,06dh,001h,001h,06ch,06dh,001h,001h,001h,001h,06ch,06dh,001h,001h	; a3d5  *.lm..lm....lm..
	defb 06ch,06dh,0feh,047h,0eeh,071h,072h,075h,001h,071h,072h,073h,001h,074h,075h,071h	; a3e5  lm.G.qru.qrs.tuq
	defb 073h,073h,074h,075h,071h,073h,073h,075h,071h,073h,075h,074h,075h,0feh,066h,0eeh	; a3f5  sstuqssuqsutu.f.
	defb 074h,075h,071h,072h,073h,001h,071h,073h,001h,001h,074h,075h,001h,071h,072h,073h	; a405  tuqrs.qs..tu.qrs
	defb 001h,071h,073h,001h,001h,071h,073h,073h,001h,071h,0ffh	; a415  .qs..qss.q.

; ----------------------------------------------------------------------
; DATOS tabla_de_tablas_A420: 4 punteros a tablas de 9 palabras (de las
;   ranuras de 0xE409). La indexa p01:6B02 y p01:6B5E con el primer byte de la
;   ranura menos uno
;   0xa420..0xa428  (8 bytes)
DATA_tabla_de_tablas_A420:
	defb 028h,0a4h	; a420
	defb 03ah,0a4h	; a422
	defb 04ch,0a4h	; a424
	defb 05eh,0a4h	; a426

; ----------------------------------------------------------------------
; DATOS tablas_internas_A420: las 4 tablas de 9 palabras de
;   tabla_de_tablas_A420, seguidas: cada palabra apunta a un guion de bytes
;   sueltos; p01:6B02 y p01:6B5E las indexa con el segundo byte menos uno
;   0xa428..0xa470  (72 bytes)
DATA_tablas_internas_A420:
	defb 070h,0a4h,074h,0a4h,078h,0a4h,07ch,0a4h,081h,0a4h,086h,0a4h,08ch,0a4h,092h,0a4h,098h,0a4h	; a428  p.t.x.|...........
	defb 09bh,0a4h,09fh,0a4h,0a3h,0a4h,0a7h,0a4h,0ach,0a4h,0b1h,0a4h,0b6h,0a4h,0bch,0a4h,0c2h,0a4h	; a43a  ..................
	defb 0c5h,0a4h,0c9h,0a4h,0ceh,0a4h,0d8h,0a4h,0ddh,0a4h,0e7h,0a4h,0edh,0a4h,0f4h,0a4h,0fch,0a4h	; a44c  ..................
	defb 0ffh,0a4h,003h,0a5h,008h,0a5h,012h,0a5h,017h,0a5h,021h,0a5h,027h,0a5h,02eh,0a5h,036h,0a5h	; a45e  ..........!.'...6.

; ----------------------------------------------------------------------
; DATOS tira_A470: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[0] (4 bytes)
;   0xa470..0xa474  (4 bytes)
DATA_tira_A470:
	defb 06eh,0ech,08ch,0ffh	; a470

; ----------------------------------------------------------------------
; DATOS tira_A474: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[1] (4 bytes)
;   0xa474..0xa478  (4 bytes)
DATA_tira_A474:
	defb 06eh,0ech,08fh,0ffh	; a474

; ----------------------------------------------------------------------
; DATOS tira_A478: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[2] (4 bytes)
;   0xa478..0xa47c  (4 bytes)
DATA_tira_A478:
	defb 04eh,0ech,08eh,0ffh	; a478

; ----------------------------------------------------------------------
; DATOS tira_A47C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[3] (5 bytes)
;   0xa47c..0xa481  (5 bytes)
DATA_tira_A47C:
	defb 04dh,0ech,09dh,096h,0ffh	; a47c

; ----------------------------------------------------------------------
; DATOS tira_A481: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[4] (5 bytes)
;   0xa481..0xa486  (5 bytes)
DATA_tira_A481:
	defb 04dh,0ech,09ah,0a4h,0ffh	; a481

; ----------------------------------------------------------------------
; DATOS tira_A486: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[5] (6 bytes)
;   0xa486..0xa48c  (6 bytes)
DATA_tira_A486:
	defb 02ch,0ech,09fh,093h,0a2h,0ffh	; a486

; ----------------------------------------------------------------------
; DATOS tira_A48C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[6] (6 bytes)
;   0xa48c..0xa492  (6 bytes)
DATA_tira_A48C:
	defb 00ch,0ech,0a1h,088h,090h,0ffh	; a48c

; ----------------------------------------------------------------------
; DATOS tira_A492: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[7] (6 bytes)
;   0xa492..0xa498  (6 bytes)
DATA_tira_A492:
	defb 0ebh,0ebh,094h,092h,09eh,0ffh	; a492

; ----------------------------------------------------------------------
; DATOS tira_A498: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA428[8] (3 bytes)
;   0xa498..0xa49b  (3 bytes)
DATA_tira_A498:
	defb 080h,0ebh,0ffh	; a498

; ----------------------------------------------------------------------
; DATOS tira_A49B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[0] (4 bytes)
;   0xa49b..0xa49f  (4 bytes)
DATA_tira_A49B:
	defb 071h,0ech,08ch,0ffh	; a49b

; ----------------------------------------------------------------------
; DATOS tira_A49F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[1] (4 bytes)
;   0xa49f..0xa4a3  (4 bytes)
DATA_tira_A49F:
	defb 071h,0ech,08fh,0ffh	; a49f

; ----------------------------------------------------------------------
; DATOS tira_A4A3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[2] (4 bytes)
;   0xa4a3..0xa4a7  (4 bytes)
DATA_tira_A4A3:
	defb 051h,0ech,08eh,0ffh	; a4a3

; ----------------------------------------------------------------------
; DATOS tira_A4A7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[3] (5 bytes)
;   0xa4a7..0xa4ac  (5 bytes)
DATA_tira_A4A7:
	defb 051h,0ech,0a0h,0a7h,0ffh	; a4a7

; ----------------------------------------------------------------------
; DATOS tira_A4AC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[4] (5 bytes)
;   0xa4ac..0xa4b1  (5 bytes)
DATA_tira_A4AC:
	defb 051h,0ech,09ah,0a4h,0ffh	; a4ac

; ----------------------------------------------------------------------
; DATOS tira_A4B1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[5] (5 bytes)
;   0xa4b1..0xa4b6  (5 bytes)
DATA_tira_A4B1:
	defb 031h,0ech,098h,093h,0ffh	; a4b1

; ----------------------------------------------------------------------
; DATOS tira_A4B6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[6] (6 bytes)
;   0xa4b6..0xa4bc  (6 bytes)
DATA_tira_A4B6:
	defb 011h,0ech,0a1h,088h,090h,0ffh	; a4b6

; ----------------------------------------------------------------------
; DATOS tira_A4BC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[7] (6 bytes)
;   0xa4bc..0xa4c2  (6 bytes)
DATA_tira_A4BC:
	defb 0f2h,0ebh,094h,092h,09eh,0ffh	; a4bc

; ----------------------------------------------------------------------
; DATOS tira_A4C2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA43A[8] (3 bytes)
;   0xa4c2..0xa4c5  (3 bytes)
DATA_tira_A4C2:
	defb 080h,0ebh,0ffh	; a4c2

; ----------------------------------------------------------------------
; DATOS tira_A4C5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[0] (4 bytes)
;   0xa4c5..0xa4c9  (4 bytes)
DATA_tira_A4C5:
	defb 06ah,0ech,08ch,0ffh	; a4c5

; ----------------------------------------------------------------------
; DATOS tira_A4C9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[1] (5 bytes)
;   0xa4c9..0xa4ce  (5 bytes)
DATA_tira_A4C9:
	defb 069h,0ech,099h,0a3h,0ffh	; a4c9

; ----------------------------------------------------------------------
; DATOS tira_A4CE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[2] (10 bytes)
;   0xa4ce..0xa4d8  (10 bytes)
DATA_tira_A4CE:
	defb 048h,0ech,09ch,0a6h,0feh,068h,0ech,09bh,0a5h,0ffh	; a4ce  H....h....

; ----------------------------------------------------------------------
; DATOS tira_A4D8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[3] (5 bytes)
;   0xa4d8..0xa4dd  (5 bytes)
DATA_tira_A4D8:
	defb 047h,0ech,09dh,096h,0ffh	; a4d8

; ----------------------------------------------------------------------
; DATOS tira_A4DD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[4] (10 bytes)
;   0xa4dd..0xa4e7  (10 bytes)
DATA_tira_A4DD:
	defb 027h,0ech,09ch,0a6h,0feh,047h,0ech,094h,09eh,0ffh	; a4dd  '....G....

; ----------------------------------------------------------------------
; DATOS tira_A4E7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[5] (6 bytes)
;   0xa4e7..0xa4ed  (6 bytes)
DATA_tira_A4E7:
	defb 026h,0ech,091h,091h,095h,0ffh	; a4e7

; ----------------------------------------------------------------------
; DATOS tira_A4ED: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[6] (7 bytes)
;   0xa4ed..0xa4f4  (7 bytes)
DATA_tira_A4ED:
	defb 004h,0ech,08ah,08bh,08bh,097h,0ffh	; a4ed

; ----------------------------------------------------------------------
; DATOS tira_A4F4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[7] (8 bytes)
;   0xa4f4..0xa4fc  (8 bytes)
DATA_tira_A4F4:
	defb 0e2h,0ebh,094h,088h,088h,088h,089h,0ffh	; a4f4  ........

; ----------------------------------------------------------------------
; DATOS tira_A4FC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA44C[8] (3 bytes)
;   0xa4fc..0xa4ff  (3 bytes)
DATA_tira_A4FC:
	defb 080h,0ebh,0ffh	; a4fc

; ----------------------------------------------------------------------
; DATOS tira_A4FF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[0] (4 bytes)
;   0xa4ff..0xa503  (4 bytes)
DATA_tira_A4FF:
	defb 075h,0ech,08ch,0ffh	; a4ff

; ----------------------------------------------------------------------
; DATOS tira_A503: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[1] (5 bytes)
;   0xa503..0xa508  (5 bytes)
DATA_tira_A503:
	defb 075h,0ech,099h,0a3h,0ffh	; a503

; ----------------------------------------------------------------------
; DATOS tira_A508: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[2] (10 bytes)
;   0xa508..0xa512  (10 bytes)
DATA_tira_A508:
	defb 056h,0ech,09ch,0a6h,0feh,076h,0ech,09bh,0a5h,0ffh	; a508  V....v....

; ----------------------------------------------------------------------
; DATOS tira_A512: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[3] (5 bytes)
;   0xa512..0xa517  (5 bytes)
DATA_tira_A512:
	defb 057h,0ech,0a0h,0a7h,0ffh	; a512

; ----------------------------------------------------------------------
; DATOS tira_A517: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[4] (10 bytes)
;   0xa517..0xa521  (10 bytes)
DATA_tira_A517:
	defb 037h,0ech,09ch,0a6h,0feh,057h,0ech,094h,09eh,0ffh	; a517  7....W....

; ----------------------------------------------------------------------
; DATOS tira_A521: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[5] (6 bytes)
;   0xa521..0xa527  (6 bytes)
DATA_tira_A521:
	defb 037h,0ech,09fh,091h,091h,0ffh	; a521

; ----------------------------------------------------------------------
; DATOS tira_A527: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[6] (7 bytes)
;   0xa527..0xa52e  (7 bytes)
DATA_tira_A527:
	defb 018h,0ech,08ah,08bh,08bh,097h,0ffh	; a527

; ----------------------------------------------------------------------
; DATOS tira_A52E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[7] (8 bytes)
;   0xa52e..0xa536  (8 bytes)
DATA_tira_A52E:
	defb 0f9h,0ebh,094h,088h,088h,088h,089h,0ffh	; a52e  ........

; ----------------------------------------------------------------------
; DATOS tira_A536: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE409) que lee rellena_de_unos y copia_bloques; lo cargan
;   p01:6B02 y p01:6B5E por 0xA45E[8] (3 bytes)
;   0xa536..0xa539  (3 bytes)
DATA_tira_A536:
	defb 080h,0ebh,0ffh	; a536

; ----------------------------------------------------------------------
; DATOS listas_de_cuatro_A539: 6 punteros que p01:69D5 indexa con A - 0x1A;
;   llevan a listas de 16 entradas de 4 bytes
;   0xa539..0xa545  (12 bytes)
DATA_listas_de_cuatro_A539:
	defb 045h,0a5h	; a539
	defb 085h,0a5h	; a53b
	defb 0c5h,0a5h	; a53d
	defb 045h,0a5h	; a53f
	defb 085h,0a5h	; a541
	defb 0c5h,0a5h	; a543

; ----------------------------------------------------------------------
; DATOS lista_de_cuatro_A545: 16 entradas de 4 bytes que p01:69F5 copia con
;   cuatro ldi, una por vuelta del contador de (DE)
;   0xa545..0xa585  (64 bytes)
DATA_lista_de_cuatro_A545:
	defb 03dh,07eh,090h,009h	; a545
	defb 03dh,07fh,094h,009h	; a549
	defb 03bh,080h,098h,009h	; a54d
	defb 03bh,085h,09ch,009h	; a551
	defb 039h,087h,0a0h,009h	; a555
	defb 037h,087h,0a4h,009h	; a559
	defb 033h,084h,0a8h,009h	; a55d
	defb 031h,085h,0ach,009h	; a561
	defb 02fh,085h,0b0h,009h	; a565
	defb 02fh,083h,0b4h,009h	; a569
	defb 02dh,084h,0b8h,009h	; a56d
	defb 02ah,084h,0bch,009h	; a571
	defb 028h,085h,0c0h,009h	; a575
	defb 027h,088h,0c4h,009h	; a579
	defb 01fh,08ch,0c8h,009h	; a57d
	defb 017h,090h,0cch,009h	; a581

; ----------------------------------------------------------------------
; DATOS lista_de_cuatro_A585: 16 entradas de 4 bytes que p01:69F5 copia con
;   cuatro ldi, una por vuelta del contador de (DE)
;   0xa585..0xa5c5  (64 bytes)
DATA_lista_de_cuatro_A585:
	defb 046h,073h,090h,009h	; a585
	defb 047h,071h,094h,009h	; a589
	defb 048h,06fh,098h,009h	; a58d
	defb 04ah,06eh,09ch,009h	; a591
	defb 04ah,06ch,0a0h,009h	; a595
	defb 04bh,069h,0a4h,009h	; a599
	defb 049h,066h,0a8h,009h	; a59d
	defb 049h,063h,0ach,009h	; a5a1
	defb 04ah,060h,0b0h,009h	; a5a5
	defb 04dh,05eh,0b4h,009h	; a5a9
	defb 052h,05ch,0b8h,009h	; a5ad
	defb 056h,058h,0bch,009h	; a5b1
	defb 058h,053h,0c0h,009h	; a5b5
	defb 05fh,050h,0c4h,009h	; a5b9
	defb 06bh,048h,0c8h,009h	; a5bd
	defb 06fh,038h,0cch,009h	; a5c1

; ----------------------------------------------------------------------
; DATOS lista_de_cuatro_A5C5: 16 entradas de 4 bytes que p01:69F5 copia con
;   cuatro ldi, una por vuelta del contador de (DE)
;   0xa5c5..0xa605  (64 bytes)
DATA_lista_de_cuatro_A5C5:
	defb 044h,083h,090h,009h	; a5c5
	defb 045h,084h,094h,009h	; a5c9
	defb 046h,085h,098h,009h	; a5cd
	defb 048h,087h,09ch,009h	; a5d1
	defb 048h,08ah,0a0h,009h	; a5d5
	defb 048h,08ch,0a4h,009h	; a5d9
	defb 049h,090h,0a8h,009h	; a5dd
	defb 04ah,092h,0ach,009h	; a5e1
	defb 04ch,094h,0b0h,009h	; a5e5
	defb 04eh,096h,0b4h,009h	; a5e9
	defb 051h,097h,0b8h,009h	; a5ed
	defb 055h,098h,0bch,009h	; a5f1
	defb 058h,09bh,0c0h,009h	; a5f5
	defb 05fh,0a0h,0c4h,009h	; a5f9
	defb 057h,0a4h,0c8h,009h	; a5fd
	defb 06fh,0b0h,0cch,009h	; a601

; ----------------------------------------------------------------------
; DATOS cinco_guiones_A605: cinco punteros a guiones de copia_bloques que
;   p01:66B8 indexa con C = 0, 2, 4, 6 u 8; se usa con (0xE093) distinto de 3
;   0xa605..0xa60f  (10 bytes)
DATA_cinco_guiones_A605:
	defb 00fh,0a6h	; a605
	defb 014h,0a6h	; a607
	defb 022h,0a6h	; a609
	defb 055h,0a6h	; a60b
	defb 0bah,0a6h	; a60d

; ----------------------------------------------------------------------
; DATOS tira_A60F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=0 (5 bytes)
;   0xa60f..0xa614  (5 bytes)
DATA_tira_A60F:
	defb 0efh,0ech,0b1h,0dah,0ffh	; a60f

; ----------------------------------------------------------------------
; DATOS tira_A614: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=2 (14 bytes)
;   0xa614..0xa622  (14 bytes)
DATA_tira_A614:
	defb 0eeh,0ech,0afh,0b8h,0e1h,0d8h,0feh,00eh,0edh,0bfh,0d1h,0fah,0e8h,0ffh	; a614  ..............

; ----------------------------------------------------------------------
; DATOS tira_A622: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=4 (51 bytes)
;   0xa622..0xa655  (51 bytes)
DATA_tira_A622:
	defb 0eeh,0ech,001h,001h,001h,001h,0feh,00ch,0edh,0abh,0bch,0bdh,001h,001h,0e6h,0e5h	; a622  ................
	defb 0d4h,0feh,02ch,0edh,0ach,0b4h,0c9h,0b6h,0dfh,0f2h,0ddh,0d5h,0feh,04ch,0edh,0adh	; a632  ..,..........L..
	defb 0b0h,0c2h,0aeh,0d7h,0ebh,0d9h,0d6h,0feh,06ch,0edh,0c5h,0c4h,0d2h,0aah,0aah,0fbh	; a642  ........l.......
	defb 0edh,0eeh,0ffh	; a652

; ----------------------------------------------------------------------
; DATOS tira_A655: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=6 (101 bytes)
;   0xa655..0xa6ba  (101 bytes)
DATA_tira_A655:
	defb 00ch,0edh,001h,001h,001h,001h,001h,001h,001h,001h,0feh,02ah,0edh,0b7h,0c8h,0bah	; a655  ...........*....
	defb 0beh,001h,001h,001h,001h,0e7h,0e3h,0f1h,0e0h,0feh,04ah,0edh,0c1h,0c3h,0cch,0d0h	; a665  ..........J.....
	defb 001h,001h,001h,001h,0f9h,0f5h,0ech,0eah,0feh,06ah,0edh,0cfh,0b5h,0cdh,0ceh,0b9h	; a675  .........j......
	defb 001h,001h,0e2h,0f7h,0f6h,0deh,0f8h,0feh,08ah,0edh,05eh,076h,081h,085h,05fh,001h	; a685  ..........^v.._.
	defb 001h,094h,0bah,0b6h,0abh,093h,0feh,0aah,0edh,066h,07dh,075h,072h,061h,05bh,05bh	; a695  .........f}ura[[
	defb 096h,0a7h,0aah,0b2h,09bh,0feh,0cah,0edh,067h,068h,080h,07ch,05dh,057h,057h,092h	; a6a5  ........gh.|]WW.
	defb 0b1h,0b5h,09dh,09ch,0ffh	; a6b5

; ----------------------------------------------------------------------
; DATOS tira_A6BA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=8 (177 bytes)
;   0xa6ba..0xa76b  (177 bytes)
DATA_tira_A6BA:
	defb 02ah,0edh,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,0feh,049h	; a6ba  *..............I
	defb 0edh,0c6h,0bbh,0cbh,0c0h,001h,001h,001h,001h,001h,001h,0e9h,0f4h,0e4h,0efh,0feh	; a6ca  ................
	defb 068h,0edh,0c7h,0b3h,0b2h,0d3h,0cah,001h,001h,001h,001h,001h,001h,0f3h,0fch,0dbh	; a6da  h...............
	defb 0dch,0f0h,0feh,087h,0edh,078h,06eh,071h,074h,06ch,083h,08fh,001h,001h,001h,001h	; a6ea  .....xnqtl......
	defb 0c4h,0b8h,0a1h,0a9h,0a6h,0a3h,0adh,0feh,0a7h,0edh,065h,06fh,06dh,089h,06bh,084h	; a6fa  ..........eom.k.
	defb 07eh,001h,001h,001h,001h,0b3h,0b9h,0a0h,0beh,0a2h,0a4h,09ah,0feh,0c8h,0edh,064h	; a70a  ~..............d
	defb 088h,073h,07ah,06ah,060h,001h,001h,001h,001h,095h,09fh,0afh,0a8h,0bdh,099h,0feh	; a71a  .szj`...........
	defb 0e8h,0edh,077h,07fh,070h,086h,082h,079h,05ah,05ah,05ah,05ah,0aeh,0b7h,0bbh,0a5h	; a72a  ..w.p..yZZZZ....
	defb 0b4h,0ach,0feh,006h,0eeh,08eh,090h,062h,08ah,07bh,087h,063h,05ch,058h,058h,058h	; a73a  .......b.{.c\XXX
	defb 058h,091h,098h,0bch,0b0h,0bfh,097h,0c5h,0c3h,0feh,026h,0eeh,069h,08ch,08bh,08dh	; a74a  X.........&.i...
	defb 059h,059h,059h,059h,059h,059h,059h,059h,059h,059h,059h,059h,0c2h,0c0h,0c1h,09eh	; a75a  YYYYYYYYYYYY....
	defb 0ffh	; a76a

; ----------------------------------------------------------------------
; DATOS cinco_guiones_A76B: cinco punteros a guiones de copia_bloques que
;   p01:66B8 indexa con C = 0, 2, 4, 6 u 8; se usa con (0xE093) igual a 3
;   0xa76b..0xa775  (10 bytes)
DATA_cinco_guiones_A76B:
	defb 075h,0a7h	; a76b
	defb 07ah,0a7h	; a76d
	defb 086h,0a7h	; a76f
	defb 0a4h,0a7h	; a771
	defb 0e0h,0a7h	; a773

; ----------------------------------------------------------------------
; DATOS tira_A775: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=0 (5 bytes)
;   0xa775..0xa77a  (5 bytes)
DATA_tira_A775:
	defb 0efh,0ech,08dh,08eh,0ffh	; a775

; ----------------------------------------------------------------------
; DATOS tira_A77A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=2 (12 bytes)
;   0xa77a..0xa786  (12 bytes)
DATA_tira_A77A:
	defb 0efh,0ech,0a3h,0c0h,0feh,00eh,0edh,0a4h,08fh,090h,0c1h,0ffh	; a77a  ............

; ----------------------------------------------------------------------
; DATOS tira_A786: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=4 (30 bytes)
;   0xa786..0xa7a4  (30 bytes)
DATA_tira_A786:
	defb 0efh,0ech,001h,001h,0feh,00eh,0edh,0a5h,0a6h,0c3h,0c2h,0feh,02dh,0edh,0a7h,0a8h	; a786  ............-...
	defb 091h,092h,0c5h,0c4h,0feh,04dh,0edh,0a9h,0aah,093h,094h,0c7h,0c6h,0ffh	; a796  .....M........

; ----------------------------------------------------------------------
; DATOS tira_A7A4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=6 (60 bytes)
;   0xa7a4..0xa7e0  (60 bytes)
DATA_tira_A7A4:
	defb 00eh,0edh,001h,0abh,0c8h,001h,0feh,02dh,0edh,0ach,0adh,0aeh,0cbh,0cah,0c9h,0feh	; a7a4  .......-........
	defb 04ch,0edh,0ach,0afh,095h,096h,097h,098h,0cch,0c9h,0feh,06ch,0edh,0b0h,0b1h,099h	; a7b4  L..........l....
	defb 09ah,09bh,09ch,0ceh,0cdh,0feh,08ch,0edh,06eh,06fh,057h,058h,059h,05ah,07dh,07ch	; a7c4  ........noWXYZ}|
	defb 0feh,0ach,0edh,070h,071h,072h,05bh,05bh,080h,07fh,07eh,0ffh	; a7d4  ...pqr[[..~.

; ----------------------------------------------------------------------
; DATOS tira_A7E0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee copia_bloques; lo cargan p01:66C0 con C=8 (98 bytes)
;   0xa7e0..0xa842  (98 bytes)
DATA_tira_A7E0:
	defb 00fh,0edh,001h,001h,0feh,02dh,0edh,0e2h,0e3h,0e4h,0f2h,0f1h,0f0h,0feh,04ch,0edh	; a7e0  .....-........L.
	defb 0b2h,0ebh,0ddh,0b3h,0d0h,0deh,0f9h,0cfh,0feh,06bh,0edh,0b4h,0edh,0eeh,0dfh,0efh	; a7f0  .........k......
	defb 0fdh,0e0h,0fch,0fbh,0d1h,0feh,08ah,0edh,073h,0abh,0ach,08eh,09eh,08fh,090h,091h	; a800  ........s.......
	defb 092h,0cbh,0cah,081h,0feh,0aah,0edh,074h,0aeh,0afh,093h,09eh,094h,095h,096h,097h	; a810  .......t........
	defb 0ceh,0cdh,082h,0feh,0cah,0edh,075h,076h,0b2h,098h,099h,09ah,09bh,09ch,09dh,0d1h	; a820  ......uv........
	defb 084h,083h,0feh,0eah,0edh,077h,078h,0b5h,0b6h,09eh,09eh,09eh,09eh,0d5h,0d4h,086h	; a830  .....wx.........
	defb 085h,0ffh	; a840

; ----------------------------------------------------------------------
; DATOS tiras_A842: 9 punteros a tiras de bytes para la RAM; la indexa
;   p01:7C32 y p01:7CCC con (0xE531)*6 + (0xE532)*2
;   0xa842..0xa854  (18 bytes)
DATA_tiras_A842:
	defb 054h,0a8h	; a842
	defb 0aah,0a8h	; a844
	defb 000h,0a9h	; a846
	defb 056h,0a9h	; a848
	defb 0adh,0a9h	; a84a
	defb 004h,0aah	; a84c
	defb 05bh,0aah	; a84e
	defb 0b2h,0aah	; a850
	defb 009h,0abh	; a852

; ----------------------------------------------------------------------
; DATOS tira_A854: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final. La carga tambien tal cual p01:7C5A
;   0xa854..0xa8aa  (86 bytes)
DATA_tira_A854:
	defb 000h,0e2h,0e3h,0e4h,0f2h,0f1h,0f0h,0feh,019h,0b2h,0ebh,0ddh,0b3h,0d0h,0deh,0f9h	; a854  ................
	defb 0cfh,0feh,017h,0b4h,0edh,0eeh,0dfh,0efh,0fdh,0e0h,0fch,0fbh,0d1h,0feh,015h,073h	; a864  ...............s
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; a874  .............t..
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,082h,0feh,014h,075h,076h,0b2h,098h,099h	; a884  ...........uv...
	defb 09ah,09bh,09ch,09dh,0d1h,084h,083h,0feh,014h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; a894  .........wx.....
	defb 09eh,0d5h,0d4h,086h,085h,0ffh	; a8a4

; ----------------------------------------------------------------------
; DATOS tira_A8AA: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xa8aa..0xa900  (86 bytes)
DATA_tira_A8AA:
	defb 000h,0e2h,0d4h,0d3h,0d2h,0f1h,0f0h,0feh,019h,0b2h,0d9h,0d8h,0d7h,0d6h,0d5h,0f9h	; a8aa  ................
	defb 0cfh,0feh,017h,0b4h,0dch,0dbh,0dah,0a0h,0a1h,0a2h,0fch,0fbh,0d1h,0feh,015h,073h	; a8ba  ...............s
	defb 0abh,0ach,05fh,060h,061h,062h,063h,092h,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; a8ca  .._`abc......t..
	defb 093h,09eh,066h,095h,096h,097h,0ceh,0cdh,082h,0feh,014h,075h,076h,0b2h,098h,099h	; a8da  ..f........uv...
	defb 09ah,09bh,09ch,09dh,0d1h,084h,083h,0feh,014h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; a8ea  .........wx.....
	defb 09eh,0d5h,0d4h,086h,085h,0ffh	; a8fa

; ----------------------------------------------------------------------
; DATOS tira_A900: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xa900..0xa956  (86 bytes)
DATA_tira_A900:
	defb 000h,0e2h,0e3h,0b5h,0b6h,0b7h,0f0h,0feh,019h,0b2h,0ebh,0b8h,0b9h,0bah,0bbh,0bch	; a900  ................
	defb 0cfh,0feh,017h,0b4h,0edh,0eeh,09dh,09eh,09fh,0bdh,0beh,0bfh,0d1h,0feh,015h,073h	; a910  ...............s
	defb 0abh,0ach,08eh,09eh,09eh,05ch,05dh,05eh,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; a920  .....\]^.....t..
	defb 093h,09eh,094h,064h,065h,097h,0ceh,0cdh,082h,0feh,014h,075h,076h,0b2h,098h,099h	; a930  ...de......uv...
	defb 09ah,09bh,09ch,09dh,0d1h,084h,083h,0feh,014h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; a940  .........wx.....
	defb 09eh,0d5h,0d4h,086h,085h,0ffh	; a950

; ----------------------------------------------------------------------
; DATOS tira_A956: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xa956..0xa9ad  (87 bytes)
DATA_tira_A956:
	defb 000h,0e2h,0e3h,0e4h,0f2h,0f1h,0f0h,0feh,019h,0b2h,0ebh,0ddh,0b3h,0d0h,0deh,0f9h	; a956  ................
	defb 0cfh,0feh,017h,0b4h,0edh,0eeh,0dfh,0efh,0fdh,0e0h,0fch,0fbh,0d1h,0feh,015h,073h	; a966  ...............s
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; a976  .............t..
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,082h,0feh,014h,079h,07ah,07bh,098h,099h	; a986  ...........yz{..
	defb 09ah,09bh,09ch,09dh,0d1h,084h,083h,0feh,013h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; a996  .........wx.....
	defb 09eh,09eh,0d5h,0d4h,086h,085h,0ffh	; a9a6

; ----------------------------------------------------------------------
; DATOS tira_A9AD: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xa9ad..0xaa04  (87 bytes)
DATA_tira_A9AD:
	defb 000h,0e2h,0d4h,0d3h,0d2h,0f1h,0f0h,0feh,019h,0b2h,0d9h,0d8h,0d7h,0d6h,0d5h,0f9h	; a9ad  ................
	defb 0cfh,0feh,017h,0b4h,0dch,0dbh,0dah,0a0h,0a1h,0a2h,0fch,0fbh,0d1h,0feh,015h,073h	; a9bd  ...............s
	defb 0abh,0ach,05fh,060h,061h,062h,063h,092h,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; a9cd  .._`abc......t..
	defb 093h,09eh,066h,095h,096h,097h,0ceh,0cdh,082h,0feh,014h,079h,07ah,07bh,098h,099h	; a9dd  ..f........yz{..
	defb 09ah,09bh,09ch,09dh,0d1h,084h,083h,0feh,013h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; a9ed  .........wx.....
	defb 09eh,09eh,0d5h,0d4h,086h,085h,0ffh	; a9fd

; ----------------------------------------------------------------------
; DATOS tira_AA04: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xaa04..0xaa5b  (87 bytes)
DATA_tira_AA04:
	defb 000h,0e2h,0e3h,0b5h,0b6h,0b7h,0f0h,0feh,019h,0b2h,0ebh,0b8h,0b9h,0bah,0bbh,0bch	; aa04  ................
	defb 0cfh,0feh,017h,0b4h,0edh,0eeh,09dh,09eh,09fh,0bdh,0beh,0bfh,0d1h,0feh,015h,073h	; aa14  ...............s
	defb 0abh,0ach,08eh,09eh,09eh,05ch,05dh,05eh,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; aa24  .....\]^.....t..
	defb 093h,09eh,094h,064h,065h,097h,0ceh,0cdh,082h,0feh,014h,079h,07ah,07bh,098h,099h	; aa34  ...de......yz{..
	defb 09ah,09bh,09ch,09dh,0d1h,084h,083h,0feh,013h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; aa44  .........wx.....
	defb 09eh,09eh,0d5h,0d4h,086h,085h,0ffh	; aa54

; ----------------------------------------------------------------------
; DATOS tira_AA5B: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xaa5b..0xaab2  (87 bytes)
DATA_tira_AA5B:
	defb 000h,0e2h,0e3h,0e4h,0f2h,0f1h,0f0h,0feh,019h,0b2h,0ebh,0ddh,0b3h,0d0h,0deh,0f9h	; aa5b  ................
	defb 0cfh,0feh,017h,0b4h,0edh,0eeh,0dfh,0efh,0fdh,0e0h,0fch,0fbh,0d1h,0feh,015h,073h	; aa6b  ...............s
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; aa7b  .............t..
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,082h,0feh,014h,075h,076h,0b2h,098h,099h	; aa8b  ...........uv...
	defb 09ah,09bh,09ch,09dh,089h,088h,087h,0feh,014h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; aa9b  .........wx.....
	defb 09eh,09eh,0d5h,0d4h,086h,085h,0ffh	; aaab

; ----------------------------------------------------------------------
; DATOS tira_AAB2: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xaab2..0xab09  (87 bytes)
DATA_tira_AAB2:
	defb 000h,0e2h,0d4h,0d3h,0d2h,0f1h,0f0h,0feh,019h,0b2h,0d9h,0d8h,0d7h,0d6h,0d5h,0f9h	; aab2  ................
	defb 0cfh,0feh,017h,0b4h,0dch,0dbh,0dah,0a0h,0a1h,0a2h,0fch,0fbh,0d1h,0feh,015h,073h	; aac2  ...............s
	defb 0abh,0ach,05fh,060h,061h,062h,063h,092h,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; aad2  .._`abc......t..
	defb 093h,09eh,066h,095h,096h,097h,0ceh,0cdh,082h,0feh,014h,075h,076h,0b2h,098h,099h	; aae2  ..f........uv...
	defb 09ah,09bh,09ch,09dh,089h,088h,087h,0feh,014h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; aaf2  .........wx.....
	defb 09eh,09eh,0d5h,0d4h,086h,085h,0ffh	; ab02

; ----------------------------------------------------------------------
; DATOS tira_AB09: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xab09..0xab60  (87 bytes)
DATA_tira_AB09:
	defb 000h,0e2h,0e3h,0b5h,0b6h,0b7h,0f0h,0feh,019h,0b2h,0ebh,0b8h,0b9h,0bah,0bbh,0bch	; ab09  ................
	defb 0cfh,0feh,017h,0b4h,0edh,0eeh,09dh,09eh,09fh,0bdh,0beh,0bfh,0d1h,0feh,015h,073h	; ab19  ...............s
	defb 0abh,0ach,08eh,09eh,09eh,05ch,05dh,05eh,0cbh,0cah,081h,0feh,014h,074h,0aeh,0afh	; ab29  .....\]^.....t..
	defb 093h,09eh,094h,064h,065h,097h,0ceh,0cdh,082h,0feh,014h,075h,076h,0b2h,098h,099h	; ab39  ...de......uv...
	defb 09ah,09bh,09ch,09dh,089h,088h,087h,0feh,014h,077h,078h,0b5h,0b6h,09eh,09eh,09eh	; ab49  .........wx.....
	defb 09eh,09eh,0d5h,0d4h,086h,085h,0ffh	; ab59

; ----------------------------------------------------------------------
; DATOS tiras_AB60: 11 punteros a tiras de bytes para la RAM; la indexa
;   p01:7C6A con (0xE531)*2
;   0xab60..0xab76  (22 bytes)
DATA_tiras_AB60:
	defb 076h,0abh	; ab60
	defb 0cch,0abh	; ab62
	defb 022h,0ach	; ab64
	defb 078h,0ach	; ab66
	defb 0c0h,0ach	; ab68
	defb 0fah,0ach	; ab6a
	defb 026h,0adh	; ab6c
	defb 044h,0adh	; ab6e
	defb 056h,0adh	; ab70
	defb 05eh,0adh	; ab72
	defb 060h,0adh	; ab74

; ----------------------------------------------------------------------
; DATOS tira_AB76: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xab76..0xabcc  (86 bytes)
DATA_tira_AB76:
	defb 000h,0e2h,0e3h,0e4h,0f2h,0f1h,0f0h,0feh,019h,0e5h,0ebh,0ddh,0b3h,0d0h,0deh,0f9h	; ab76  ................
	defb 0f3h,0feh,017h,0ech,0edh,0eeh,0dfh,0efh,0fdh,0e0h,0fch,0fbh,0fah,0feh,015h,0aah	; ab86  ................
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,0c9h,0feh,014h,0adh,0aeh,0afh	; ab96  ................
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,0cch,0feh,014h,0b0h,0b1h,0b2h,098h,099h	; aba6  ................
	defb 09ah,09bh,09ch,09dh,0d1h,0d0h,0cfh,0feh,014h,0b3h,0b4h,0b5h,0b6h,09eh,09eh,09eh	; abb6  ................
	defb 09eh,0d5h,0d4h,0d3h,0d2h,0ffh	; abc6

; ----------------------------------------------------------------------
; DATOS tira_ABCC: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xabcc..0xac22  (86 bytes)
DATA_tira_ABCC:
	defb 000h,0e6h,0e7h,0e4h,0f2h,0f5h,0f4h,0feh,019h,0e8h,0ebh,0ddh,0b3h,0d0h,0deh,0f9h	; abcc  ................
	defb 0f6h,0feh,017h,0a6h,0a7h,0a8h,08ch,0a9h,0c8h,08dh,0c7h,0c6h,0c5h,0feh,015h,0aah	; abdc  ................
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,0c9h,0feh,014h,0adh,0aeh,0afh	; abec  ................
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,0cch,0feh,014h,0b0h,0b1h,0b2h,098h,099h	; abfc  ................
	defb 09ah,09bh,09ch,09dh,0d1h,0d0h,0cfh,0feh,014h,0b3h,0b4h,0b5h,0b6h,09eh,09eh,09eh	; ac0c  ................
	defb 09eh,0d5h,0d4h,0d3h,0d2h,0ffh	; ac1c

; ----------------------------------------------------------------------
; DATOS tira_AC22: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xac22..0xac78  (86 bytes)
DATA_tira_AC22:
	defb 000h,0e9h,0eah,0e4h,0f2h,0f8h,0f7h,0feh,019h,0a2h,0a5h,08ah,09fh,0a0h,08bh,0c4h	; ac22  ................
	defb 0c1h,0feh,017h,0a6h,0a7h,0a8h,08ch,0a9h,0c8h,08dh,0c7h,0c6h,0c5h,0feh,015h,0aah	; ac32  ................
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,0c9h,0feh,014h,0adh,0aeh,0afh	; ac42  ................
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,0cch,0feh,014h,0b0h,0b1h,0b2h,098h,099h	; ac52  ................
	defb 09ah,09bh,09ch,09dh,0d1h,0d0h,0cfh,0feh,014h,0b3h,0b4h,0b5h,0b6h,09eh,09eh,09eh	; ac62  ................
	defb 09eh,0d5h,0d4h,0d3h,0d2h,0ffh	; ac72

; ----------------------------------------------------------------------
; DATOS tira_AC78: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xac78..0xacc0  (72 bytes)
DATA_tira_AC78:
	defb 000h,0a3h,0a4h,0a1h,0c0h,0c3h,0c2h,0feh,019h,0a2h,0a5h,08ah,09fh,0a0h,08bh,0c4h	; ac78  ................
	defb 0c1h,0feh,017h,0a6h,0a7h,0a8h,08ch,0a9h,0c8h,08dh,0c7h,0c6h,0c5h,0feh,015h,0aah	; ac88  ................
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,0c9h,0feh,014h,0adh,0aeh,0afh	; ac98  ................
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,0cch,0feh,014h,0b0h,0b1h,0b2h,098h,099h	; aca8  ................
	defb 09ah,09bh,09ch,09dh,0d1h,0d0h,0cfh,0ffh	; acb8  ........

; ----------------------------------------------------------------------
; DATOS tira_ACC0: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xacc0..0xacfa  (58 bytes)
DATA_tira_ACC0:
	defb 000h,0a3h,0a4h,0a1h,0c0h,0c3h,0c2h,0feh,019h,0a2h,0a5h,08ah,09fh,0a0h,08bh,0c4h	; acc0  ................
	defb 0c1h,0feh,017h,0a6h,0a7h,0a8h,08ch,0a9h,0c8h,08dh,0c7h,0c6h,0c5h,0feh,015h,0aah	; acd0  ................
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,0c9h,0feh,014h,0adh,0aeh,0afh	; ace0  ................
	defb 093h,09eh,094h,095h,096h,097h,0ceh,0cdh,0cch,0ffh	; acf0  ..........

; ----------------------------------------------------------------------
; DATOS tira_ACFA: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xacfa..0xad26  (44 bytes)
DATA_tira_ACFA:
	defb 000h,0a3h,0a4h,0a1h,0c0h,0c3h,0c2h,0feh,019h,0a2h,0a5h,08ah,09fh,0a0h,08bh,0c4h	; acfa  ................
	defb 0c1h,0feh,017h,0a6h,0a7h,0a8h,08ch,0a9h,0c8h,08dh,0c7h,0c6h,0c5h,0feh,015h,0aah	; ad0a  ................
	defb 0abh,0ach,08eh,09eh,08fh,090h,091h,092h,0cbh,0cah,0c9h,0ffh	; ad1a  ............

; ----------------------------------------------------------------------
; DATOS tira_AD26: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xad26..0xad44  (30 bytes)
DATA_tira_AD26:
	defb 000h,0a3h,0a4h,0a1h,0c0h,0c3h,0c2h,0feh,019h,0a2h,0a5h,08ah,09fh,0a0h,08bh,0c4h	; ad26  ................
	defb 0c1h,0feh,017h,0a6h,0a7h,0a8h,08ch,0a9h,0c8h,08dh,0c7h,0c6h,0c5h,0ffh	; ad36  ..............

; ----------------------------------------------------------------------
; DATOS tira_AD44: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xad44..0xad56  (18 bytes)
DATA_tira_AD44:
	defb 000h,0a3h,0a4h,0a1h,0c0h,0c3h,0c2h,0feh,019h,0a2h,0a5h,08ah,09fh,0a0h,08bh,0c4h	; ad44  ................
	defb 0c1h,0ffh	; ad54

; ----------------------------------------------------------------------
; DATOS tira_AD56: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xad56..0xad5e  (8 bytes)
DATA_tira_AD56:
	defb 000h,0a3h,0a4h,0a1h,0c0h,0c3h,0c2h,0ffh	; ad56  ........

; ----------------------------------------------------------------------
; DATOS tira_AD5E: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xad5e..0xad60  (2 bytes)
DATA_tira_AD5E:
	defb 000h,0ffh	; ad5e

; ----------------------------------------------------------------------
; DATOS tira_AD60: una tira que copia p01:7C74 (o marca con unos p01:7CD7): un
;   byte de desplazamiento sobre (0xE538), bytes, 0xFE y otro desplazamiento,
;   y 0xFF al final
;   0xad60..0xad62  (2 bytes)
DATA_tira_AD60:
	defb 000h,0ffh	; ad60

; ----------------------------------------------------------------------
; DATOS tiras_AD62: 4 punteros que p01:7D28 indexa con el byte de 0xE550 menos
;   dos
;   0xad62..0xad6a  (8 bytes)
DATA_tiras_AD62:
	defb 06ah,0adh	; ad62
	defb 072h,0adh	; ad64
	defb 07eh,0adh	; ad66
	defb 08eh,0adh	; ad68

; ----------------------------------------------------------------------
; DATOS tira_larga_AD6A: una tira que copia p01:7D35 sobre DE (de 0x7D6C): una
;   palabra de desplazamiento, bytes, 0xFE y otra palabra, y 0xFF al final
;   0xad6a..0xad72  (8 bytes)
DATA_tira_larga_AD6A:
	defb 000h,000h,06ah,0feh,01fh,000h,069h,0ffh	; ad6a  ..j...i.

; ----------------------------------------------------------------------
; DATOS tira_larga_AD72: una tira que copia p01:7D35 sobre DE (de 0x7D6C): una
;   palabra de desplazamiento, bytes, 0xFE y otra palabra, y 0xFF al final
;   0xad72..0xad7e  (12 bytes)
DATA_tira_larga_AD72:
	defb 0ffh,0ffh,068h,06bh,068h,0feh,01dh,000h,067h,069h,067h,0ffh	; ad72  ..hkh...gig.

; ----------------------------------------------------------------------
; DATOS tira_larga_AD7E: una tira que copia p01:7D35 sobre DE (de 0x7D6C): una
;   palabra de desplazamiento, bytes, 0xFE y otra palabra, y 0xFF al final
;   0xad7e..0xad8e  (16 bytes)
DATA_tira_larga_AD7E:
	defb 0feh,0ffh,068h,068h,06ch,068h,068h,0feh,01bh,000h,067h,067h,069h,067h,067h,0ffh	; ad7e  ..hhlhh...ggigg.

; ----------------------------------------------------------------------
; DATOS tira_larga_AD8E: una tira que copia p01:7D35 sobre DE (de 0x7D6C): una
;   palabra de desplazamiento, bytes, 0xFE y otra palabra, y 0xFF al final
;   0xad8e..0xada2  (20 bytes)
DATA_tira_larga_AD8E:
	defb 0fdh,0ffh,068h,068h,068h,06dh,068h,068h,068h,0feh,019h,000h,067h,067h,067h,069h	; ad8e  ..hhhmhhh...gggi
	defb 067h,067h,067h,0ffh	; ad9e

; ----------------------------------------------------------------------
; DATOS guion_ADA2: guion comprimido que lee descomprime; lo cargan p01:7C62
;   (104 bytes)
;   0xada2..0xae0a  (104 bytes)
DATA_guion_ADA2:
	defb 02bh,0edh,00ah,001h,080h,047h,0edh,092h,001h,09eh,090h,08fh,090h,08fh,090h,08fh	; ada2  +....G..........
	defb 090h,08fh,090h,08fh,090h,08fh,090h,08fh,097h,001h,080h,066h,0edh,083h,098h,09ch	; adb2  ...........f....
	defb 09dh,00eh,0e1h,083h,096h,095h,091h,080h,084h,0edh,083h,0d8h,0d7h,0d6h,012h,09eh	; adc2  ................
	defb 083h,0b7h,0b8h,0b9h,080h,0a3h,0edh,083h,0dbh,0dah,0d9h,014h,09eh,083h,0bah,0bbh	; add2  ................
	defb 0bch,080h,0c2h,0edh,082h,0dch,0d6h,018h,09eh,082h,0b7h,0bdh,080h,0e0h,0edh,083h	; ade2  ................
	defb 0d8h,0d7h,0d6h,01ah,09eh,085h,0b7h,0b8h,0b9h,0ddh,0d9h,01ch,09eh,083h,0bah,0beh	; adf2  ................
	defb 0deh,01eh,09eh,081h,0bfh,020h,067h,000h	; ae02  ..... g.

; ----------------------------------------------------------------------
; DATOS escrituras_a_la_ram_AE0A: 40 entradas de 3 bytes -una direccion de RAM
;   y el byte que se escribe en ella- que p01:7D88 va sacando de una en una
;   con (0xE53A), y una ultima con 0xFF en el tercer byte que la corta. La
;   cargan p01:77E8 y p03:B4CB
;   0xae0a..0xae85  (123 bytes)
DATA_escrituras_a_la_ram_AE0A:
	defb 021h,0eeh,068h	; ae0a
	defb 041h,0eeh,067h	; ae0d
	defb 05eh,0eeh,067h	; ae10
	defb 03eh,0eeh,068h	; ae13
	defb 020h,0eeh,068h	; ae16
	defb 040h,0eeh,067h	; ae19
	defb 05fh,0eeh,067h	; ae1c
	defb 03fh,0eeh,068h	; ae1f
	defb 0e0h,0edh,05bh	; ae22
	defb 0ffh,0edh,057h	; ae25
	defb 0e1h,0edh,05ch	; ae28
	defb 0feh,0edh,058h	; ae2b
	defb 0c2h,0edh,05dh	; ae2e
	defb 0ddh,0edh,059h	; ae31
	defb 0a3h,0edh,05eh	; ae34
	defb 0bch,0edh,05ah	; ae37
	defb 084h,0edh,05bh	; ae3a
	defb 09bh,0edh,057h	; ae3d
	defb 085h,0edh,05ch	; ae40
	defb 09ah,0edh,058h	; ae43
	defb 066h,0edh,099h	; ae46
	defb 079h,0edh,092h	; ae49
	defb 047h,0edh,09ah	; ae4c
	defb 058h,0edh,093h	; ae4f
	defb 048h,0edh,09bh	; ae52
	defb 057h,0edh,094h	; ae55
	defb 049h,0edh,08eh	; ae58
	defb 056h,0edh,08dh	; ae5b
	defb 04ah,0edh,08dh	; ae5e
	defb 055h,0edh,08eh	; ae61
	defb 04bh,0edh,08eh	; ae64
	defb 054h,0edh,08dh	; ae67
	defb 04ch,0edh,08dh	; ae6a
	defb 053h,0edh,08eh	; ae6d
	defb 04dh,0edh,08eh	; ae70
	defb 052h,0edh,08dh	; ae73
	defb 04eh,0edh,08dh	; ae76
	defb 051h,0edh,08eh	; ae79
	defb 04fh,0edh,08eh	; ae7c
	defb 050h,0edh,08dh	; ae7f
	defb 050h,0edh,0ffh	; ae82

; ----------------------------------------------------------------------
; DATOS tira_de_p03_AE85: una tira de p01:7C78 (un byte de desplazamiento,
;   bytes, 0xFE y otro desplazamiento, 0xFF): la carga en HL el banco 3
;   (p03:A5F8, A651, A699, A69E o A6EE) para p01:7D9C
;   0xae85..0xae94  (15 bytes)
DATA_tira_de_p03_AE85:
	defb 000h,09eh,09eh,09eh,0feh,01dh,0ech,0e7h,0f5h,0feh,01dh,0f9h,0e9h,0f0h,0ffh	; ae85  ...............

; ----------------------------------------------------------------------
; DATOS tira_de_p03_AE94: una tira de p01:7C78 (un byte de desplazamiento,
;   bytes, 0xFE y otro desplazamiento, 0xFF): la carga en HL el banco 3
;   (p03:A5F8, A651, A699, A69E o A6EE) para p01:7D9C
;   0xae94..0xaea3  (15 bytes)
DATA_tira_de_p03_AE94:
	defb 000h,09eh,09eh,09eh,0feh,01dh,0ech,0e6h,0f5h,0feh,01dh,0ebh,0e4h,0eah,0ffh	; ae94  ...............

; ----------------------------------------------------------------------
; DATOS tira_de_p03_AEA3: una tira de p01:7C78 (un byte de desplazamiento,
;   bytes, 0xFE y otro desplazamiento, 0xFF): la carga en HL el banco 3
;   (p03:A5F8, A651, A699, A69E o A6EE) para p01:7D9C
;   0xaea3..0xaeb2  (15 bytes)
DATA_tira_de_p03_AEA3:
	defb 000h,09eh,09eh,0e3h,0feh,01dh,0f7h,0fah,0f6h,0feh,01dh,0fdh,0fch,0fbh,0ffh	; aea3  ...............

; ----------------------------------------------------------------------
; DATOS tira_de_p03_AEB2: una tira de p01:7C78 (un byte de desplazamiento,
;   bytes, 0xFE y otro desplazamiento, 0xFF): la carga en HL el banco 3
;   (p03:A5F8, A651, A699, A69E o A6EE) para p01:7D9C
;   0xaeb2..0xaec1  (15 bytes)
DATA_tira_de_p03_AEB2:
	defb 000h,0e3h,09eh,09eh,0feh,01dh,0edh,0f1h,0eeh,0feh,01dh,0f2h,0f3h,0f4h,0ffh	; aeb2  ...............

; ----------------------------------------------------------------------
; DATOS tira_de_p03_AEC1: una tira de p01:7C78 (un byte de desplazamiento,
;   bytes, 0xFE y otro desplazamiento, 0xFF): la carga en HL el banco 3
;   (p03:A5F8, A651, A699, A69E o A6EE) para p01:7D9C
;   0xaec1..0xaed0  (15 bytes)
DATA_tira_de_p03_AEC1:
	defb 000h,09eh,09eh,09eh,0feh,01dh,0efh,0e8h,0f8h,0feh,01dh,0f2h,0e5h,0fbh,0ffh	; aec1  ...............

; ----------------------------------------------------------------------
; DATOS cuadros_de_cuatro_AED0: 16 entradas de 4 bytes que p01:6BD8 copia con
;   ldir segun su contador, que da la vuelta a los 16; BC la pone p01:6BB1,
;   6BB7 o 6BBD
;   0xaed0..0xaf10  (64 bytes)
DATA_cuadros_de_cuatro_AED0:
	defb 084h,065h,084h,00fh	; aed0
	defb 085h,064h,084h,00fh	; aed4
	defb 086h,063h,084h,00fh	; aed8
	defb 088h,061h,084h,00fh	; aedc
	defb 08ah,05fh,084h,00fh	; aee0
	defb 08ch,05dh,084h,00fh	; aee4
	defb 08eh,05bh,084h,00fh	; aee8
	defb 091h,058h,088h,00fh	; aeec
	defb 094h,056h,088h,00fh	; aef0
	defb 099h,054h,088h,00fh	; aef4
	defb 09dh,050h,08ch,00fh	; aef8
	defb 0a2h,04eh,08ch,00fh	; aefc
	defb 0a7h,04bh,08ch,00fh	; af00
	defb 0ach,048h,08ch,00fh	; af04
	defb 0b2h,045h,08ch,00fh	; af08
	defb 0b9h,042h,08ch,00fh	; af0c

; ----------------------------------------------------------------------
; DATOS cuadros_de_cuatro_AF10: 16 entradas de 4 bytes que p01:6BD8 copia con
;   ldir segun su contador, que da la vuelta a los 16; BC la pone p01:6BB1,
;   6BB7 o 6BBD
;   0xaf10..0xaf50  (64 bytes)
DATA_cuadros_de_cuatro_AF10:
	defb 084h,07bh,084h,00fh	; af10
	defb 085h,07bh,084h,00fh	; af14
	defb 086h,07bh,084h,00fh	; af18
	defb 088h,07bh,084h,00fh	; af1c
	defb 08ah,07bh,084h,00fh	; af20
	defb 08ch,07bh,084h,00fh	; af24
	defb 08eh,07bh,084h,00fh	; af28
	defb 091h,079h,088h,00fh	; af2c
	defb 094h,079h,088h,00fh	; af30
	defb 099h,079h,088h,00fh	; af34
	defb 09dh,078h,08ch,00fh	; af38
	defb 0a2h,078h,08ch,00fh	; af3c
	defb 0a7h,078h,08ch,00fh	; af40
	defb 0ach,078h,08ch,00fh	; af44
	defb 0b2h,078h,08ch,00fh	; af48
	defb 0b9h,078h,08ch,00fh	; af4c

; ----------------------------------------------------------------------
; DATOS cuadros_de_cuatro_AF50: 16 entradas de 4 bytes que p01:6BD8 copia con
;   ldir segun su contador, que da la vuelta a los 16; BC la pone p01:6BB1,
;   6BB7 o 6BBD
;   0xaf50..0xaf90  (64 bytes)
DATA_cuadros_de_cuatro_AF50:
	defb 084h,092h,084h,00fh	; af50
	defb 085h,093h,084h,00fh	; af54
	defb 086h,094h,084h,00fh	; af58
	defb 088h,097h,084h,00fh	; af5c
	defb 08ah,098h,084h,00fh	; af60
	defb 08ch,09ah,084h,00fh	; af64
	defb 08eh,09ch,084h,00fh	; af68
	defb 091h,09bh,088h,00fh	; af6c
	defb 094h,09dh,088h,00fh	; af70
	defb 099h,09fh,088h,00fh	; af74
	defb 09dh,0a0h,08ch,00fh	; af78
	defb 0a2h,0a2h,08ch,00fh	; af7c
	defb 0a7h,0a4h,08ch,00fh	; af80
	defb 0ach,0a8h,08ch,00fh	; af84
	defb 0b2h,0abh,08ch,00fh	; af88
	defb 0b9h,0adh,08ch,00fh	; af8c

; ----------------------------------------------------------------------
; DATOS listas_por_fase_AF90: 24 entradas de 7 bytes, una por fase: p01:6CE9
;   salta a (0xE092 - 1) * 7 y lee bytes hasta un cero, cada uno un indice en
;   la tabla de 0xE160 y en la de IX (0x6FD5, 0x6FE5 o 0x6FF5 segun el modo).
;   Estaba mal atribuida al banco 13: p01:6CC6 pone antes el 10 y el 11; SON
;   LOS ARTICULOS QUE VENDE LA TIENDA DE CADA FASE, hasta seis (catorce
;   distintos en total; el 13, el que deja acabar las fases 12, 18 y 24, solo
;   en las listas de esas tres)
;   0xaf90..0xb038  (168 bytes)
DATA_listas_por_fase_AF90:
	defb 001h,002h,003h,007h,010h,000h,000h	; af90
	defb 001h,002h,003h,00ah,010h,009h,000h	; af97
	defb 001h,002h,003h,00ah,005h,000h,000h	; af9e
	defb 000h,000h,000h,000h,000h,000h,000h	; afa5
	defb 000h,000h,000h,000h,000h,000h,000h	; afac
	defb 001h,002h,003h,008h,007h,010h,000h	; afb3
	defb 001h,002h,003h,010h,00bh,009h,000h	; afba
	defb 000h,000h,000h,000h,000h,000h,000h	; afc1
	defb 007h,004h,00ch,005h,00bh,009h,000h	; afc8
	defb 000h,000h,000h,000h,000h,000h,000h	; afcf
	defb 000h,000h,000h,000h,000h,000h,000h	; afd6
	defb 00dh,004h,001h,002h,00ah,010h,000h	; afdd
	defb 001h,002h,003h,008h,007h,00ah,000h	; afe4
	defb 001h,004h,002h,008h,003h,010h,000h	; afeb
	defb 001h,003h,002h,006h,007h,010h,000h	; aff2
	defb 001h,004h,002h,009h,00bh,005h,000h	; aff9
	defb 000h,000h,000h,000h,000h,000h,000h	; b000
	defb 00dh,004h,00ch,006h,00bh,005h,000h	; b007
	defb 000h,000h,000h,000h,000h,000h,000h	; b00e
	defb 000h,000h,000h,000h,000h,000h,000h	; b015
	defb 001h,002h,003h,006h,00ah,009h,000h	; b01c
	defb 001h,004h,00ch,009h,00bh,005h,000h	; b023
	defb 000h,000h,000h,000h,000h,000h,000h	; b02a
	defb 00dh,001h,002h,006h,00ah,010h,000h	; b031

; ----------------------------------------------------------------------
; DATOS tira_B038: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   primera mitad del rotulo del modo 3 (0xE119)) que lee
;   pinta_guion_lee_destino (p01:6F32); lo cargan p01:6E4E (45 bytes); el
;   saludo del tendero de siempre: MAY I HELP YOU? GET WHATEVER YOU LIKE. (la
;   tienda lo pinta cada cuadro y al cerrarse lo borra con la mascara a cero)
;   0xb038..0xb065  (45 bytes)
DATA_tira_B038:
	defb 0cch,038h,02dh,021h,039h,000h,029h,000h,028h,025h,02ch,030h,000h,039h,02fh,035h	; b038  .8-!9.).(%,0.9/5
	defb 03ch,0feh,0ech,038h,027h,025h,034h,000h,037h,028h,021h,034h,025h,036h,025h,032h	; b048  <..8'%4.7(!4%6%2
	defb 0feh,00ch,039h,039h,02fh,035h,000h,02ch,029h,02bh,025h,03dh,0ffh	; b058  ..99/5.,)+%=.

; ----------------------------------------------------------------------
; DATOS tira_B065: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   primera mitad del rotulo del modo 4 (0xE119)) que lee
;   pinta_guion_lee_destino (p01:6F32); lo cargan p01:6E4E (47 bytes); el
;   saludo del que cobra el doble: HEY YOU! YOU MUST BUY SOMETHING FROM ME!!
;   0xb065..0xb094  (47 bytes)
DATA_tira_B065:
	defb 0cch,038h,028h,025h,039h,000h,039h,02fh,035h,01fh,0feh,0ech,038h,039h,02fh,035h	; b065  .8(%9.9/5...89/5
	defb 001h,02dh,035h,033h,034h,000h,022h,035h,039h,0feh,00ch,039h,033h,02fh,02dh,025h	; b075  .-534."59..93/-%
	defb 034h,028h,029h,02eh,027h,000h,026h,032h,02fh,02dh,000h,02dh,025h,03bh,0ffh	; b085  4().'.&2/-.-%;.

; ----------------------------------------------------------------------
; DATOS tira_B094: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   segunda mitad (0xE11B)) que lee pinta_guion_con_mascara (p01:6F39); lo
;   cargan p01:6E52 (42 bytes); la despedida del tendero de siempre, al pulsar
;   END: THANK YOU VERY MUCH. SEE YOU AGAIN!
;   0xb094..0xb0be  (42 bytes)
DATA_tira_B094:
	defb 0cch,038h,034h,028h,021h,02eh,02bh,001h,039h,02fh,035h,0feh,0ech,038h,036h,025h	; b094  .84(!.+.9/5..86%
	defb 032h,039h,000h,02dh,035h,023h,028h,03dh,0feh,00ch,039h,033h,025h,025h,000h,039h	; b0a4  29.-5#(=..93%%.9
	defb 02fh,035h,000h,021h,027h,021h,029h,02eh,01fh,0ffh	; b0b4  /5.!'!)...

; ----------------------------------------------------------------------
; DATOS tira_B0BE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   segunda mitad (0xE11B)) que lee pinta_guion_con_mascara (p01:6F39); lo
;   cargan p01:6E52 (31 bytes); la despedida del que cobra el doble: BUY MORE!
;   WAIT! DAMN IT!!
;   0xb0be..0xb0dd  (31 bytes)
DATA_tira_B0BE:
	defb 0cch,038h,022h,035h,039h,000h,02dh,02fh,032h,025h,01fh,0feh,0ech,038h,037h,021h	; b0be  .8"59.-/2%...87!
	defb 029h,034h,01fh,0feh,00ch,039h,024h,021h,02dh,02eh,000h,029h,034h,03bh,0ffh	; b0ce  )4...9$!-..)4;.

; ----------------------------------------------------------------------
; DATOS tira_B0DD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   primera mitad del rotulo del otro modo (0xE119)) que lee
;   pinta_guion_con_mascara (por el puente de 6E59) y pinta_guion_lee_destino
;   (p01:6F32); lo cargan p01:6E4E, p01:6E59 (40 bytes); el saludo de Santa
;   Claus: WELCOME! I WILL GIVE YOU A JEWEL.
;   0xb0dd..0xb105  (40 bytes)
DATA_tira_B0DD:
	defb 0cch,038h,037h,025h,02ch,023h,02fh,02dh,025h,01fh,0feh,0ech,038h,029h,000h,037h	; b0dd  .87%,#/-%...8).7
	defb 029h,02ch,02ch,000h,027h,029h,036h,025h,000h,039h,02fh,035h,0feh,00ch,039h,021h	; b0ed  ),,.')6%.9/5..9!
	defb 000h,02ah,025h,037h,025h,02ch,03dh,0ffh	; b0fd  .*%7%,=.

; ----------------------------------------------------------------------
; DATOS tira_B105: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   segunda mitad (0xE11B)) que lee pinta_guion_con_mascara (p01:6F39); lo
;   cargan p01:6E52 (31 bytes); la despedida de Santa Claus: OK! BE CAREFUL!
;   SEE YOU!
;   0xb105..0xb124  (31 bytes)
DATA_tira_B105:
	defb 0cch,038h,02fh,02bh,01fh,0feh,0ech,038h,022h,025h,000h,023h,021h,032h,025h,026h	; b105  .8/+...8"%.#!2%&
	defb 035h,02ch,01fh,0feh,00ch,039h,033h,025h,025h,000h,039h,02fh,035h,01fh,0ffh	; b115  5,...93%%.9/5..

; ----------------------------------------------------------------------
; DATOS tira_B124: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 6E10) y
;   pinta_guion_lee_destino (por el puente de 6E0D); lo cargan p01:6E0D,
;   p01:6E10 (10 bytes); la bolsa de apostar (los caracteres 0x5A a 0x5D,
;   filas 18 y 19): solo se pinta con puntos (0xE134), y el cursor sobre ella
;   lleva a la maquina de apostar
;   0xb124..0xb12e  (10 bytes)
DATA_tira_B124:
	defb 045h,03ah,05ah,05bh,0feh,065h,03ah,05ch,05dh,0ffh	; b124  E:Z[.e:\].

; ----------------------------------------------------------------------
; DATOS guion_B12E: guion comprimido que lee pinta_sin_color; lo cargan
;   p01:6E62 (48 bytes); el bocadillo del tendero: el marco de las filas 5 a
;   9, columnas 11 a 30
;   0xb12e..0xb15e  (48 bytes)
DATA_guion_B12E:
	defb 0abh,038h,081h,05eh,012h,046h,081h,06dh,080h,0cbh,038h,081h,047h,080h,0deh,038h	; b12e  .8.^.F.m..8.G..8
	defb 081h,047h,080h,0ebh,038h,081h,047h,080h,0feh,038h,081h,047h,080h,00bh,039h,081h	; b13e  .G..8.G..8.G..9.
	defb 047h,080h,01eh,039h,081h,047h,080h,02bh,039h,081h,05fh,012h,046h,081h,06eh,000h	; b14e  G..9.G.+9._.F.n.

; ----------------------------------------------------------------------
; DATOS tira_B15E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 783E) y
;   pinta_guion_lee_destino (por el puente de 78A1); lo cargan p01:783E,
;   p01:78A1 (44 bytes)
;   0xb15e..0xb18a  (44 bytes)
DATA_tira_B15E:
	defb 022h,039h,037h,029h,02ch,02ch,000h,039h,02fh,035h,000h,022h,025h,034h,0feh,042h	; b15e  "97),,.9/5."%4.B
	defb 039h,039h,02fh,035h,032h,000h,026h,029h,033h,028h,03ch,0feh,084h,039h,039h,025h	; b16e  99/52.&)3(<..99%
	defb 033h,0feh,08ah,039h,02eh,02fh,0feh,0a4h,039h,000h,000h,0ffh	; b17e  3..9./..9...

; ----------------------------------------------------------------------
; DATOS tira_B18A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 78A7) y
;   pinta_guion_lee_destino (por el puente de 795B); lo cargan p01:78A7,
;   p01:795B (51 bytes)
;   0xb18a..0xb1bd  (51 bytes)
DATA_tira_B18A:
	defb 022h,039h,028h,02fh,037h,000h,02dh,021h,02eh,039h,000h,0feh,042h,039h,037h,029h	; b18a  "9(/7.-!.9..B97)
	defb 02ch,02ch,000h,039h,02fh,035h,000h,022h,025h,034h,03ch,0feh,086h,039h,01bh,01ch	; b19a  ,,.9/5."%4<..9..
	defb 01eh,000h,000h,000h,0feh,0c2h,039h,033h,034h,021h,032h,034h,020h,033h,030h,021h	; b1aa  ......934!24 30!
	defb 023h,025h,0ffh	; b1ba

; ----------------------------------------------------------------------
; DATOS tira_B1BD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 7961) y
;   pinta_guion_lee_destino (por el puente de 7A3C); lo cargan p01:7961,
;   p01:7A3C (13 bytes)
;   0xb1bd..0xb1ca  (13 bytes)
DATA_tira_B1BD:
	defb 022h,039h,033h,034h,02fh,030h,020h,033h,030h,021h,023h,025h,0ffh	; b1bd  "934/0 30!#%.

; ----------------------------------------------------------------------
; DATOS tira_B1CA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 7A42) y
;   pinta_guion_lee_destino (por el puente de 782C); lo cargan p01:782C,
;   p01:7A42 (19 bytes)
;   0xb1ca..0xb1dd  (19 bytes)
DATA_tira_B1CA:
	defb 022h,039h,039h,02fh,035h,000h,027h,02fh,034h,0feh,044h,039h,01bh,01ch,01eh,000h	; b1ca  "99/5.'/4.D9....
	defb 000h,000h,0ffh	; b1da

; ----------------------------------------------------------------------
; DATOS tira_B1DD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (p01:7A49); lo cargan 0xE137 (8 bytes)
;   0xb1dd..0xb1e5  (8 bytes)
DATA_tira_B1DD:
	defb 082h,039h,027h,02fh,02fh,024h,01fh,0ffh	; b1dd  .9'//$..

; ----------------------------------------------------------------------
; DATOS tira_B1E5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (p01:7A49) y pinta_guion_lee_destino (por el
;   puente de 7832); lo cargan 0xE137, p01:7832 (9 bytes)
;   0xb1e5..0xb1ee  (9 bytes)
DATA_tira_B1E5:
	defb 082h,039h,033h,02fh,032h,032h,039h,01fh,0ffh	; b1e5  .93/229..

; ----------------------------------------------------------------------
; DATOS tira_B1EE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 7A4F) y
;   pinta_guion_lee_destino (por el puente de 7838); lo cargan p01:7838,
;   p01:7A4F (13 bytes)
;   0xb1ee..0xb1fb  (13 bytes)
DATA_tira_B1EE:
	defb 0a2h,039h,034h,028h,021h,02eh,02bh,000h,039h,02fh,035h,01fh,0ffh	; b1ee  .94(!.+.9/5..

; ----------------------------------------------------------------------
; DATOS tira_B1FB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 780F); lo cargan p01:780F
;   (396 bytes)
;   0xb1fb..0xb387  (396 bytes)
DATA_tira_B1FB:
	defb 082h,038h,020h,020h,033h,02ch,02fh,034h,000h,02dh,021h,023h,028h,029h,02eh,025h	; b1fb  .8  3,/4.-!#().%
	defb 020h,020h,0feh,0b1h,038h,084h,085h,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch,089h	; b20b    ..8..||||||||.
	defb 088h,0feh,0d1h,038h,086h,087h,07dh,07eh,07fh,07eh,07fh,080h,081h,082h,08bh,08ah	; b21b  ...8..}~.~......
	defb 0feh,0f1h,038h,086h,087h,07dh,07eh,07dh,07eh,07fh,080h,081h,083h,08bh,08ah,0feh	; b22b  ..8..}~}~.......
	defb 001h,039h,094h,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch,07ch	; b23b  .9.|||||||||||||
	defb 09bh,0feh,011h,039h,098h,097h,07fh,085h,07fh,085h,07fh,089h,08ah,08bh,09eh,09fh	; b24b  ...9............
	defb 0feh,021h,039h,096h,0feh,02fh,039h,09dh,0feh,031h,039h,098h,097h,080h,085h,080h	; b25b  .!9../9..19.....
	defb 085h,080h,089h,08ah,08ch,09eh,09fh,0feh,041h,039h,096h,0feh,04fh,039h,09dh,0feh	; b26b  ........A9..O9..
	defb 051h,039h,098h,097h,081h,085h,081h,085h,081h,089h,08ah,08dh,08eh,09fh,0feh,061h	; b27b  Q9.............a
	defb 039h,096h,0feh,06fh,039h,09dh,0feh,071h,039h,098h,097h,082h,085h,082h,085h,082h	; b28b  9..o9..q9.......
	defb 089h,08ah,08fh,090h,09fh,0feh,081h,039h,096h,0feh,08fh,039h,09dh,0feh,091h,039h	; b29b  .......9...9...9
	defb 098h,097h,083h,085h,083h,085h,083h,089h,08ah,091h,08eh,09fh,0feh,0a1h,039h,096h	; b2ab  ..............9.
	defb 0feh,0afh,039h,09dh,0feh,0b1h,039h,098h,097h,084h,085h,084h,085h,084h,089h,08ah	; b2bb  ..9...9.........
	defb 092h,09eh,09fh,0feh,0c1h,039h,096h,0feh,0cfh,039h,09dh,0feh,0d1h,039h,099h,088h	; b2cb  .....9...9...9..
	defb 088h,088h,088h,088h,088h,088h,088h,088h,088h,0a0h,0feh,0e1h,039h,095h,07eh,07eh	; b2db  ............9.~~
	defb 07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,07eh,09ch,0feh,0f1h,039h,09ah	; b2eb  ~~~~~~~~~~~...9.
	defb 086h,087h,0a1h,09ah,086h,087h,0a1h,09ah,086h,087h,0a1h,0feh,011h,03ah,0a6h,0feh	; b2fb  .............:..
	defb 014h,03ah,0ach,0a6h,0feh,018h,03ah,0ach,0a6h,0feh,01ch,03ah,0ach,0feh,031h,03ah	; b30b  .:....:....:..1:
	defb 0a7h,0feh,034h,03ah,0adh,0a7h,0feh,038h,03ah,0adh,0a7h,0feh,03ch,03ah,0adh,0feh	; b31b  ..4:...8:...<:..
	defb 051h,03ah,0a8h,094h,094h,0aeh,0a8h,094h,094h,0aeh,0a8h,094h,094h,0aeh,0feh,071h	; b32b  Q:.............q
	defb 03ah,0a3h,095h,096h,0a4h,0a3h,095h,096h,0a4h,0a3h,095h,096h,0a4h,0feh,091h,03ah	; b33b  :..............:
	defb 098h,097h,09bh,09bh,09bh,09bh,09bh,09bh,09bh,09bh,097h,098h,0feh,0b1h,03ah,099h	; b34b  ..............:.
	defb 0aah,0a2h,0a2h,0a2h,0a2h,0a2h,0a2h,0a2h,0a2h,0b0h,099h,0feh,0d1h,03ah,099h,0a5h	; b35b  .............:..
	defb 09ch,09ch,09ch,09ch,09ch,09ch,09ch,09ch,0abh,099h,0feh,0f0h,03ah,0a9h,09ah,09ah	; b36b  ............:...
	defb 09ah,09ah,09ah,09ah,09ah,09ah,09ah,09ah,09ah,09ah,0afh,0ffh	; b37b  ............

; ----------------------------------------------------------------------
; DATOS tira_B387: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 7815) y
;   pinta_guion_con_mascara (por el puente de 798C); lo cargan p01:7815,
;   p01:798C (24 bytes)
;   0xb387..0xb39f  (24 bytes)
DATA_tira_B387:
	defb 0ddh,039h,07dh,0feh,0fdh,039h,093h,0feh,01dh,03ah,09dh,0feh,03dh,03ah,09dh,0feh	; b387  .9}..9...:..=:..
	defb 05dh,03ah,09eh,0feh,07dh,03ah,09fh,0ffh	; b397  ]:..}:..

; ----------------------------------------------------------------------
; DATOS tira_B39F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara (por el puente de 7986); lo cargan p01:7986
;   (24 bytes)
;   0xb39f..0xb3b7  (24 bytes)
DATA_tira_B39F:
	defb 0ddh,039h,000h,0feh,0fdh,039h,07dh,0feh,01dh,03ah,09dh,0feh,03dh,03ah,09dh,0feh	; b39f  .9...9}..:..=:..
	defb 05dh,03ah,0a0h,0feh,07dh,03ah,0a1h,0ffh	; b3af  ]:..}:..

; ----------------------------------------------------------------------
; DATOS tira_B3B7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (dibujo 0 de la presentacion; dibujo 8 de la presentacion) que lee
;   pinta_guion_con_mascara (p01:7DF7); lo cargan p00:5DB3 por 0x5E3C[0],
;   p00:5DB3 por 0x5E3C[8] (10 bytes)
;   0xb3b7..0xb3c1  (10 bytes)
DATA_tira_B3B7:
	defb 0fbh,038h,0a5h,0a6h,0feh,01bh,039h,000h,0bfh,0ffh	; b3b7  .8....9...

; ----------------------------------------------------------------------
; DATOS tira_B3C1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (dibujo 1 de la presentacion; dibujo 7 de la presentacion) que lee
;   pinta_guion_con_mascara (p01:7DF7); lo cargan p00:5DB3 por 0x5E3C[1],
;   p00:5DB3 por 0x5E3C[7] (10 bytes)
;   0xb3c1..0xb3cb  (10 bytes)
DATA_tira_B3C1:
	defb 0fbh,038h,0a7h,0a8h,0feh,01bh,039h,0c0h,0c1h,0ffh	; b3c1  .8....9...

; ----------------------------------------------------------------------
; DATOS tira_B3CB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (dibujo 2 de la presentacion; dibujo 6 de la presentacion) que lee
;   pinta_guion_con_mascara (p01:7DF7); lo cargan p00:5DB3 por 0x5E3C[2],
;   p00:5DB3 por 0x5E3C[6] (11 bytes)
;   0xb3cb..0xb3d6  (11 bytes)
DATA_tira_B3CB:
	defb 0fbh,038h,0b1h,0b2h,000h,0feh,01bh,039h,0c3h,0c2h,0ffh	; b3cb  .8.....9...

; ----------------------------------------------------------------------
; DATOS tira_B3D6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (dibujo 3 de la presentacion; dibujo 5 de la presentacion) que lee
;   pinta_guion_con_mascara (p01:7DF7); lo cargan p00:5DB3 por 0x5E3C[3],
;   p00:5DB3 por 0x5E3C[5] (20 bytes)
;   0xb3d6..0xb3ea  (20 bytes)
DATA_tira_B3D6:
	defb 0dch,038h,000h,0feh,0fah,038h,000h,0afh,0b0h,0a9h,0feh,01bh,039h,0c4h,0c8h,0feh	; b3d6  .8...8......9...
	defb 03ch,039h,000h,0ffh	; b3e6

; ----------------------------------------------------------------------
; DATOS tira_B3EA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (dibujo 4 de la presentacion) que lee pinta_guion_con_mascara (p01:7DF7);
;   lo cargan p00:5DB3 por 0x5E3C[4] (20 bytes)
;   0xb3ea..0xb3fe  (20 bytes)
DATA_tira_B3EA:
	defb 0dch,038h,0aah,0feh,0fah,038h,0abh,0adh,0aeh,0ach,0feh,01bh,039h,0c5h,0c7h,0feh	; b3ea  .8...8......9...
	defb 03ch,039h,0c6h,0ffh	; b3fa

; ----------------------------------------------------------------------
; DATOS tira_B3FE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (dibujo 9 de la presentacion) que lee pinta_guion_con_mascara (p01:7DF7);
;   lo cargan p00:5DB3 por 0x5E3C[9] (50 bytes)
;   0xb3fe..0xb430  (50 bytes)
DATA_tira_B3FE:
	defb 0b9h,038h,0b4h,08eh,08fh,090h,091h,0b3h,0feh,0d9h,038h,092h,093h,09ah,09bh,096h	; b3fe  .8........8.....
	defb 097h,0feh,0f9h,038h,098h,099h,09ch,09dh,094h,095h,0feh,019h,039h,0b3h,0b4h,0bbh	; b40e  ...8........9...
	defb 0bch,0b5h,0b6h,0feh,039h,039h,0c9h,0b7h,0bdh,0beh,0b8h,0cah,0feh,05bh,039h,0b9h	; b41e  ....99.......[9.
	defb 0bah,0ffh	; b42e

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_13: la partida grabada de la demo en la fase 13:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (199 bytes)
;   0xb430..0xb4f7  (199 bytes)
DATA_partida_grabada_fase_13:
	defb 000h,000h	; b430
	defb 000h,056h	; b432
	defb 001h,06dh	; b434
	defb 009h,02ah	; b436
	defb 001h,008h	; b438
	defb 005h,052h	; b43a
	defb 001h,006h	; b43c
	defb 009h,036h	; b43e
	defb 001h,006h	; b440
	defb 005h,031h	; b442
	defb 001h,007h	; b444
	defb 009h,022h	; b446
	defb 001h,003h	; b448
	defb 005h,023h	; b44a
	defb 001h,004h	; b44c
	defb 009h,01eh	; b44e
	defb 001h,002h	; b450
	defb 005h,029h	; b452
	defb 001h,007h	; b454
	defb 009h,03ch	; b456
	defb 001h,008h	; b458
	defb 005h,039h	; b45a
	defb 001h,00bh	; b45c
	defb 009h,019h	; b45e
	defb 001h,004h	; b460
	defb 005h,04ah	; b462
	defb 001h,005h	; b464
	defb 009h,017h	; b466
	defb 001h,006h	; b468
	defb 005h,018h	; b46a
	defb 001h,008h	; b46c
	defb 009h,007h	; b46e
	defb 001h,005h	; b470
	defb 005h,046h	; b472
	defb 001h,007h	; b474
	defb 009h,015h	; b476
	defb 001h,007h	; b478
	defb 005h,028h	; b47a
	defb 001h,012h	; b47c
	defb 005h,029h	; b47e
	defb 001h,007h	; b480
	defb 009h,008h	; b482
	defb 001h,012h	; b484
	defb 005h,018h	; b486
	defb 001h,007h	; b488
	defb 009h,007h	; b48a
	defb 001h,01ah	; b48c
	defb 009h,00ah	; b48e
	defb 001h,008h	; b490
	defb 005h,067h	; b492
	defb 015h,004h	; b494
	defb 011h,005h	; b496
	defb 019h,001h	; b498
	defb 009h,0b0h	; b49a
	defb 001h,002h	; b49c
	defb 005h,004h	; b49e
	defb 015h,006h	; b4a0
	defb 005h,002h	; b4a2
	defb 025h,005h	; b4a4
	defb 005h,048h	; b4a6
	defb 001h,003h	; b4a8
	defb 009h,053h	; b4aa
	defb 001h,007h	; b4ac
	defb 005h,029h	; b4ae
	defb 015h,010h	; b4b0
	defb 005h,006h	; b4b2
	defb 025h,006h	; b4b4
	defb 005h,041h	; b4b6
	defb 001h,003h	; b4b8
	defb 009h,066h	; b4ba
	defb 001h,001h	; b4bc
	defb 005h,02dh	; b4be
	defb 001h,009h	; b4c0
	defb 009h,008h	; b4c2
	defb 001h,002h	; b4c4
	defb 005h,015h	; b4c6
	defb 001h,003h	; b4c8
	defb 009h,033h	; b4ca
	defb 001h,019h	; b4cc
	defb 009h,00ch	; b4ce
	defb 019h,00eh	; b4d0
	defb 009h,007h	; b4d2
	defb 001h,007h	; b4d4
	defb 005h,063h	; b4d6
	defb 001h,006h	; b4d8
	defb 009h,018h	; b4da
	defb 001h,005h	; b4dc
	defb 005h,026h	; b4de
	defb 001h,004h	; b4e0
	defb 009h,016h	; b4e2
	defb 001h,005h	; b4e4
	defb 005h,02eh	; b4e6
	defb 001h,00fh	; b4e8
	defb 009h,00eh	; b4ea
	defb 001h,002h	; b4ec
	defb 005h,051h	; b4ee
	defb 001h,001h	; b4f0
	defb 009h,001h	; b4f2
	defb 019h,007h	; b4f4
	defb 0ffh	; b4f6

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_14: la partida grabada de la demo en la fase 14:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (185 bytes)
;   0xb4f7..0xb5b0  (185 bytes)
DATA_partida_grabada_fase_14:
	defb 000h,000h	; b4f7
	defb 000h,02fh	; b4f9
	defb 001h,0ffh	; b4fb
	defb 001h,040h	; b4fd
	defb 005h,029h	; b4ff
	defb 001h,017h	; b501
	defb 021h,008h	; b503
	defb 001h,017h	; b505
	defb 009h,036h	; b507
	defb 029h,001h	; b509
	defb 021h,001h	; b50b
	defb 025h,004h	; b50d
	defb 005h,016h	; b50f
	defb 001h,014h	; b511
	defb 021h,008h	; b513
	defb 001h,00dh	; b515
	defb 009h,032h	; b517
	defb 029h,004h	; b519
	defb 009h,007h	; b51b
	defb 001h,001h	; b51d
	defb 005h,04eh	; b51f
	defb 025h,005h	; b521
	defb 005h,00dh	; b523
	defb 001h,003h	; b525
	defb 009h,016h	; b527
	defb 001h,002h	; b529
	defb 005h,003h	; b52b
	defb 001h,010h	; b52d
	defb 005h,029h	; b52f
	defb 001h,008h	; b531
	defb 009h,024h	; b533
	defb 029h,007h	; b535
	defb 009h,025h	; b537
	defb 001h,006h	; b539
	defb 005h,024h	; b53b
	defb 001h,00ch	; b53d
	defb 009h,062h	; b53f
	defb 001h,002h	; b541
	defb 005h,022h	; b543
	defb 001h,002h	; b545
	defb 009h,020h	; b547
	defb 029h,009h	; b549
	defb 009h,069h	; b54b
	defb 019h,00bh	; b54d
	defb 009h,037h	; b54f
	defb 001h,006h	; b551
	defb 005h,018h	; b553
	defb 001h,005h	; b555
	defb 009h,00dh	; b557
	defb 001h,003h	; b559
	defb 005h,003h	; b55b
	defb 001h,00ch	; b55d
	defb 005h,00ch	; b55f
	defb 001h,006h	; b561
	defb 009h,009h	; b563
	defb 001h,004h	; b565
	defb 005h,05ah	; b567
	defb 025h,00bh	; b569
	defb 015h,014h	; b56b
	defb 005h,062h	; b56d
	defb 001h,004h	; b56f
	defb 009h,064h	; b571
	defb 001h,008h	; b573
	defb 005h,03fh	; b575
	defb 001h,002h	; b577
	defb 009h,005h	; b579
	defb 008h,047h	; b57b
	defb 028h,006h	; b57d
	defb 008h,014h	; b57f
	defb 009h,005h	; b581
	defb 001h,002h	; b583
	defb 005h,022h	; b585
	defb 001h,006h	; b587
	defb 009h,04ch	; b589
	defb 001h,002h	; b58b
	defb 005h,032h	; b58d
	defb 015h,00ch	; b58f
	defb 005h,008h	; b591
	defb 001h,002h	; b593
	defb 008h,09fh	; b595
	defb 018h,00ch	; b597
	defb 008h,023h	; b599
	defb 000h,001h	; b59b
	defb 005h,086h	; b59d
	defb 001h,001h	; b59f
	defb 009h,01eh	; b5a1
	defb 001h,014h	; b5a3
	defb 005h,065h	; b5a5
	defb 001h,040h	; b5a7
	defb 005h,02bh	; b5a9
	defb 015h,008h	; b5ab
	defb 005h,010h	; b5ad
	defb 0ffh	; b5af

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_15: la partida grabada de la demo en la fase 15:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (207 bytes)
;   0xb5b0..0xb67f  (207 bytes)
DATA_partida_grabada_fase_15:
	defb 000h,000h	; b5b0
	defb 000h,024h	; b5b2
	defb 001h,0b3h	; b5b4
	defb 005h,044h	; b5b6
	defb 001h,008h	; b5b8
	defb 009h,00ah	; b5ba
	defb 019h,007h	; b5bc
	defb 009h,008h	; b5be
	defb 001h,010h	; b5c0
	defb 005h,01dh	; b5c2
	defb 001h,04bh	; b5c4
	defb 009h,007h	; b5c6
	defb 001h,01ah	; b5c8
	defb 005h,033h	; b5ca
	defb 001h,009h	; b5cc
	defb 009h,011h	; b5ce
	defb 001h,014h	; b5d0
	defb 005h,001h	; b5d2
	defb 015h,007h	; b5d4
	defb 005h,004h	; b5d6
	defb 001h,004h	; b5d8
	defb 009h,07eh	; b5da
	defb 001h,00ch	; b5dc
	defb 009h,01ah	; b5de
	defb 001h,003h	; b5e0
	defb 005h,005h	; b5e2
	defb 001h,002h	; b5e4
	defb 009h,00eh	; b5e6
	defb 001h,00ch	; b5e8
	defb 005h,03bh	; b5ea
	defb 001h,00bh	; b5ec
	defb 009h,006h	; b5ee
	defb 001h,018h	; b5f0
	defb 009h,01dh	; b5f2
	defb 001h,001h	; b5f4
	defb 005h,00dh	; b5f6
	defb 015h,006h	; b5f8
	defb 005h,00fh	; b5fa
	defb 001h,001h	; b5fc
	defb 009h,02ch	; b5fe
	defb 001h,007h	; b600
	defb 009h,054h	; b602
	defb 001h,079h	; b604
	defb 009h,02fh	; b606
	defb 019h,006h	; b608
	defb 009h,001h	; b60a
	defb 001h,02fh	; b60c
	defb 009h,009h	; b60e
	defb 001h,005h	; b610
	defb 009h,004h	; b612
	defb 001h,001h	; b614
	defb 005h,008h	; b616
	defb 001h,027h	; b618
	defb 009h,05dh	; b61a
	defb 019h,017h	; b61c
	defb 009h,002h	; b61e
	defb 001h,00dh	; b620
	defb 005h,00fh	; b622
	defb 001h,001h	; b624
	defb 009h,009h	; b626
	defb 019h,009h	; b628
	defb 009h,010h	; b62a
	defb 001h,00ah	; b62c
	defb 000h,003h	; b62e
	defb 004h,086h	; b630
	defb 005h,011h	; b632
	defb 001h,014h	; b634
	defb 009h,05ah	; b636
	defb 001h,03ah	; b638
	defb 009h,08bh	; b63a
	defb 001h,00fh	; b63c
	defb 005h,03ch	; b63e
	defb 001h,026h	; b640
	defb 005h,01bh	; b642
	defb 001h,006h	; b644
	defb 009h,009h	; b646
	defb 001h,02ah	; b648
	defb 005h,014h	; b64a
	defb 001h,015h	; b64c
	defb 009h,00ch	; b64e
	defb 019h,016h	; b650
	defb 009h,037h	; b652
	defb 019h,006h	; b654
	defb 009h,00ah	; b656
	defb 019h,005h	; b658
	defb 009h,010h	; b65a
	defb 001h,010h	; b65c
	defb 009h,02fh	; b65e
	defb 001h,003h	; b660
	defb 009h,007h	; b662
	defb 001h,00ch	; b664
	defb 009h,039h	; b666
	defb 001h,003h	; b668
	defb 005h,02dh	; b66a
	defb 001h,009h	; b66c
	defb 009h,058h	; b66e
	defb 001h,003h	; b670
	defb 005h,015h	; b672
	defb 001h,004h	; b674
	defb 009h,01ah	; b676
	defb 001h,006h	; b678
	defb 005h,012h	; b67a
	defb 004h,005h	; b67c
	defb 0ffh	; b67e

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_17: la partida grabada de la demo en la fase 17:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (185 bytes)
;   0xb67f..0xb738  (185 bytes)
DATA_partida_grabada_fase_17:
	defb 000h,000h	; b67f
	defb 000h,02fh	; b681
	defb 001h,095h	; b683
	defb 009h,021h	; b685
	defb 001h,002h	; b687
	defb 005h,023h	; b689
	defb 001h,009h	; b68b
	defb 009h,084h	; b68d
	defb 001h,004h	; b68f
	defb 005h,008h	; b691
	defb 015h,001h	; b693
	defb 011h,008h	; b695
	defb 001h,015h	; b697
	defb 009h,00ah	; b699
	defb 001h,020h	; b69b
	defb 009h,062h	; b69d
	defb 019h,022h	; b69f
	defb 009h,029h	; b6a1
	defb 001h,00fh	; b6a3
	defb 009h,012h	; b6a5
	defb 001h,005h	; b6a7
	defb 011h,01ah	; b6a9
	defb 001h,02bh	; b6ab
	defb 009h,02bh	; b6ad
	defb 019h,01dh	; b6af
	defb 009h,017h	; b6b1
	defb 001h,005h	; b6b3
	defb 005h,005h	; b6b5
	defb 001h,006h	; b6b7
	defb 005h,023h	; b6b9
	defb 001h,004h	; b6bb
	defb 009h,004h	; b6bd
	defb 001h,00ch	; b6bf
	defb 005h,012h	; b6c1
	defb 001h,00bh	; b6c3
	defb 011h,001h	; b6c5
	defb 015h,006h	; b6c7
	defb 005h,006h	; b6c9
	defb 025h,004h	; b6cb
	defb 005h,01ah	; b6cd
	defb 001h,006h	; b6cf
	defb 009h,01ch	; b6d1
	defb 001h,00fh	; b6d3
	defb 005h,027h	; b6d5
	defb 001h,003h	; b6d7
	defb 009h,007h	; b6d9
	defb 019h,009h	; b6db
	defb 009h,01ch	; b6dd
	defb 001h,012h	; b6df
	defb 005h,02fh	; b6e1
	defb 001h,003h	; b6e3
	defb 009h,004h	; b6e5
	defb 001h,00bh	; b6e7
	defb 005h,018h	; b6e9
	defb 015h,00bh	; b6eb
	defb 005h,005h	; b6ed
	defb 025h,006h	; b6ef
	defb 005h,01dh	; b6f1
	defb 001h,004h	; b6f3
	defb 009h,021h	; b6f5
	defb 001h,007h	; b6f7
	defb 005h,06fh	; b6f9
	defb 001h,002h	; b6fb
	defb 009h,002h	; b6fd
	defb 019h,010h	; b6ff
	defb 009h,005h	; b701
	defb 001h,005h	; b703
	defb 005h,0b5h	; b705
	defb 001h,002h	; b707
	defb 009h,01fh	; b709
	defb 001h,002h	; b70b
	defb 005h,038h	; b70d
	defb 015h,006h	; b70f
	defb 005h,007h	; b711
	defb 025h,004h	; b713
	defb 005h,04fh	; b715
	defb 001h,003h	; b717
	defb 009h,01bh	; b719
	defb 001h,00bh	; b71b
	defb 009h,04fh	; b71d
	defb 019h,008h	; b71f
	defb 009h,01ah	; b721
	defb 001h,007h	; b723
	defb 005h,019h	; b725
	defb 015h,005h	; b727
	defb 005h,055h	; b729
	defb 001h,002h	; b72b
	defb 009h,002h	; b72d
	defb 019h,007h	; b72f
	defb 009h,006h	; b731
	defb 029h,004h	; b733
	defb 009h,00dh	; b735
	defb 0ffh	; b737

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_18: la partida grabada de la demo en la fase 18:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (239 bytes)
;   0xb738..0xb827  (239 bytes)
DATA_partida_grabada_fase_18:
	defb 000h,000h	; b738
	defb 000h,054h	; b73a
	defb 001h,0a9h	; b73c
	defb 009h,021h	; b73e
	defb 001h,006h	; b740
	defb 005h,039h	; b742
	defb 001h,006h	; b744
	defb 009h,014h	; b746
	defb 001h,008h	; b748
	defb 009h,02fh	; b74a
	defb 001h,002h	; b74c
	defb 005h,039h	; b74e
	defb 015h,00ch	; b750
	defb 005h,009h	; b752
	defb 001h,00dh	; b754
	defb 009h,019h	; b756
	defb 019h,00bh	; b758
	defb 009h,057h	; b75a
	defb 001h,002h	; b75c
	defb 005h,01eh	; b75e
	defb 001h,003h	; b760
	defb 009h,01dh	; b762
	defb 001h,003h	; b764
	defb 005h,028h	; b766
	defb 001h,010h	; b768
	defb 005h,00bh	; b76a
	defb 001h,002h	; b76c
	defb 011h,01ah	; b76e
	defb 001h,001h	; b770
	defb 009h,02bh	; b772
	defb 001h,00fh	; b774
	defb 005h,002h	; b776
	defb 025h,006h	; b778
	defb 005h,025h	; b77a
	defb 001h,00ah	; b77c
	defb 009h,004h	; b77e
	defb 001h,002h	; b780
	defb 021h,006h	; b782
	defb 001h,023h	; b784
	defb 021h,002h	; b786
	defb 025h,003h	; b788
	defb 004h,002h	; b78a
	defb 005h,001h	; b78c
	defb 025h,003h	; b78e
	defb 005h,013h	; b790
	defb 001h,007h	; b792
	defb 009h,007h	; b794
	defb 001h,002h	; b796
	defb 005h,00ah	; b798
	defb 001h,002h	; b79a
	defb 009h,008h	; b79c
	defb 029h,005h	; b79e
	defb 009h,04ch	; b7a0
	defb 021h,005h	; b7a2
	defb 025h,002h	; b7a4
	defb 005h,013h	; b7a6
	defb 001h,009h	; b7a8
	defb 009h,008h	; b7aa
	defb 001h,011h	; b7ac
	defb 025h,006h	; b7ae
	defb 005h,01dh	; b7b0
	defb 001h,002h	; b7b2
	defb 009h,004h	; b7b4
	defb 001h,01ah	; b7b6
	defb 005h,04bh	; b7b8
	defb 021h,003h	; b7ba
	defb 029h,001h	; b7bc
	defb 009h,028h	; b7be
	defb 001h,004h	; b7c0
	defb 005h,01bh	; b7c2
	defb 015h,009h	; b7c4
	defb 005h,048h	; b7c6
	defb 015h,008h	; b7c8
	defb 005h,03fh	; b7ca
	defb 001h,004h	; b7cc
	defb 009h,00bh	; b7ce
	defb 001h,00eh	; b7d0
	defb 005h,032h	; b7d2
	defb 015h,009h	; b7d4
	defb 005h,009h	; b7d6
	defb 001h,009h	; b7d8
	defb 009h,045h	; b7da
	defb 001h,002h	; b7dc
	defb 005h,013h	; b7de
	defb 001h,018h	; b7e0
	defb 019h,039h	; b7e2
	defb 009h,015h	; b7e4
	defb 001h,04eh	; b7e6
	defb 005h,027h	; b7e8
	defb 001h,00fh	; b7ea
	defb 005h,03bh	; b7ec
	defb 001h,006h	; b7ee
	defb 009h,006h	; b7f0
	defb 001h,002h	; b7f2
	defb 005h,02fh	; b7f4
	defb 001h,005h	; b7f6
	defb 009h,02fh	; b7f8
	defb 001h,00ah	; b7fa
	defb 005h,00ah	; b7fc
	defb 001h,012h	; b7fe
	defb 005h,005h	; b800
	defb 015h,009h	; b802
	defb 005h,001h	; b804
	defb 001h,026h	; b806
	defb 009h,024h	; b808
	defb 029h,006h	; b80a
	defb 009h,01ch	; b80c
	defb 001h,00bh	; b80e
	defb 009h,00eh	; b810
	defb 001h,008h	; b812
	defb 005h,00dh	; b814
	defb 001h,004h	; b816
	defb 009h,004h	; b818
	defb 019h,00ch	; b81a
	defb 009h,018h	; b81c
	defb 001h,002h	; b81e
	defb 005h,037h	; b820
	defb 001h,004h	; b822
	defb 009h,04ch	; b824
	defb 0ffh	; b826

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_19: la partida grabada de la demo en la fase 19:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (331 bytes)
;   0xb827..0xb972  (331 bytes)
DATA_partida_grabada_fase_19:
	defb 000h,000h	; b827
	defb 000h,031h	; b829
	defb 010h,007h	; b82b
	defb 011h,001h	; b82d
	defb 001h,029h	; b82f
	defb 011h,007h	; b831
	defb 001h,005h	; b833
	defb 011h,004h	; b835
	defb 001h,03bh	; b837
	defb 009h,003h	; b839
	defb 019h,004h	; b83b
	defb 009h,007h	; b83d
	defb 019h,002h	; b83f
	defb 009h,007h	; b841
	defb 001h,00dh	; b843
	defb 005h,020h	; b845
	defb 015h,007h	; b847
	defb 005h,009h	; b849
	defb 001h,00bh	; b84b
	defb 009h,019h	; b84d
	defb 019h,003h	; b84f
	defb 009h,007h	; b851
	defb 019h,003h	; b853
	defb 009h,006h	; b855
	defb 001h,00dh	; b857
	defb 005h,01bh	; b859
	defb 015h,006h	; b85b
	defb 005h,01eh	; b85d
	defb 001h,019h	; b85f
	defb 011h,006h	; b861
	defb 001h,003h	; b863
	defb 009h,003h	; b865
	defb 019h,002h	; b867
	defb 009h,01eh	; b869
	defb 001h,016h	; b86b
	defb 005h,00eh	; b86d
	defb 001h,00ah	; b86f
	defb 009h,00dh	; b871
	defb 019h,003h	; b873
	defb 009h,004h	; b875
	defb 019h,001h	; b877
	defb 009h,003h	; b879
	defb 019h,001h	; b87b
	defb 009h,002h	; b87d
	defb 019h,002h	; b87f
	defb 009h,004h	; b881
	defb 019h,002h	; b883
	defb 009h,004h	; b885
	defb 019h,001h	; b887
	defb 009h,001h	; b889
	defb 019h,002h	; b88b
	defb 011h,001h	; b88d
	defb 001h,003h	; b88f
	defb 011h,002h	; b891
	defb 001h,001h	; b893
	defb 011h,002h	; b895
	defb 001h,002h	; b897
	defb 011h,002h	; b899
	defb 001h,003h	; b89b
	defb 011h,005h	; b89d
	defb 009h,003h	; b89f
	defb 019h,001h	; b8a1
	defb 009h,00ah	; b8a3
	defb 019h,003h	; b8a5
	defb 009h,002h	; b8a7
	defb 019h,002h	; b8a9
	defb 009h,003h	; b8ab
	defb 019h,006h	; b8ad
	defb 021h,002h	; b8af
	defb 025h,002h	; b8b1
	defb 005h,00bh	; b8b3
	defb 015h,003h	; b8b5
	defb 005h,01eh	; b8b7
	defb 001h,00dh	; b8b9
	defb 009h,016h	; b8bb
	defb 001h,00fh	; b8bd
	defb 005h,00eh	; b8bf
	defb 015h,004h	; b8c1
	defb 005h,00bh	; b8c3
	defb 011h,002h	; b8c5
	defb 009h,005h	; b8c7
	defb 019h,003h	; b8c9
	defb 009h,003h	; b8cb
	defb 019h,005h	; b8cd
	defb 009h,003h	; b8cf
	defb 019h,001h	; b8d1
	defb 009h,002h	; b8d3
	defb 019h,001h	; b8d5
	defb 011h,001h	; b8d7
	defb 001h,003h	; b8d9
	defb 011h,002h	; b8db
	defb 001h,004h	; b8dd
	defb 005h,001h	; b8df
	defb 015h,001h	; b8e1
	defb 005h,026h	; b8e3
	defb 015h,002h	; b8e5
	defb 005h,01dh	; b8e7
	defb 001h,002h	; b8e9
	defb 011h,001h	; b8eb
	defb 001h,001h	; b8ed
	defb 005h,00ch	; b8ef
	defb 001h,010h	; b8f1
	defb 009h,020h	; b8f3
	defb 001h,002h	; b8f5
	defb 011h,00ah	; b8f7
	defb 019h,003h	; b8f9
	defb 009h,03ah	; b8fb
	defb 001h,006h	; b8fd
	defb 011h,006h	; b8ff
	defb 001h,005h	; b901
	defb 011h,003h	; b903
	defb 001h,004h	; b905
	defb 009h,008h	; b907
	defb 001h,008h	; b909
	defb 005h,032h	; b90b
	defb 015h,004h	; b90d
	defb 005h,00ch	; b90f
	defb 015h,002h	; b911
	defb 005h,005h	; b913
	defb 015h,004h	; b915
	defb 001h,006h	; b917
	defb 011h,001h	; b919
	defb 001h,016h	; b91b
	defb 011h,002h	; b91d
	defb 001h,005h	; b91f
	defb 011h,002h	; b921
	defb 015h,005h	; b923
	defb 005h,007h	; b925
	defb 001h,006h	; b927
	defb 009h,04dh	; b929
	defb 019h,004h	; b92b
	defb 009h,00ah	; b92d
	defb 019h,003h	; b92f
	defb 001h,002h	; b931
	defb 011h,002h	; b933
	defb 001h,004h	; b935
	defb 011h,002h	; b937
	defb 001h,004h	; b939
	defb 011h,003h	; b93b
	defb 001h,004h	; b93d
	defb 011h,002h	; b93f
	defb 001h,004h	; b941
	defb 011h,002h	; b943
	defb 001h,004h	; b945
	defb 011h,001h	; b947
	defb 019h,001h	; b949
	defb 009h,004h	; b94b
	defb 001h,001h	; b94d
	defb 011h,002h	; b94f
	defb 001h,001h	; b951
	defb 005h,004h	; b953
	defb 015h,001h	; b955
	defb 005h,043h	; b957
	defb 001h,00bh	; b959
	defb 009h,005h	; b95b
	defb 001h,005h	; b95d
	defb 005h,01fh	; b95f
	defb 001h,014h	; b961
	defb 009h,009h	; b963
	defb 001h,00ah	; b965
	defb 009h,005h	; b967
	defb 001h,006h	; b969
	defb 009h,006h	; b96b
	defb 001h,003h	; b96d
	defb 005h,01bh	; b96f
	defb 0ffh	; b971

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_20: la partida grabada de la demo en la fase 20:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (149 bytes)
;   0xb972..0xba07  (149 bytes)
DATA_partida_grabada_fase_20:
	defb 000h,000h	; b972
	defb 000h,04dh	; b974
	defb 001h,045h	; b976
	defb 009h,03fh	; b978
	defb 001h,003h	; b97a
	defb 005h,00ch	; b97c
	defb 015h,00ch	; b97e
	defb 005h,05bh	; b980
	defb 001h,005h	; b982
	defb 009h,014h	; b984
	defb 019h,01bh	; b986
	defb 009h,05eh	; b988
	defb 001h,001h	; b98a
	defb 005h,009h	; b98c
	defb 015h,008h	; b98e
	defb 005h,004h	; b990
	defb 025h,004h	; b992
	defb 005h,006h	; b994
	defb 025h,004h	; b996
	defb 005h,005h	; b998
	defb 025h,004h	; b99a
	defb 005h,006h	; b99c
	defb 025h,003h	; b99e
	defb 005h,065h	; b9a0
	defb 001h,031h	; b9a2
	defb 009h,02bh	; b9a4
	defb 019h,00fh	; b9a6
	defb 029h,005h	; b9a8
	defb 009h,030h	; b9aa
	defb 001h,011h	; b9ac
	defb 009h,004h	; b9ae
	defb 001h,003h	; b9b0
	defb 005h,06bh	; b9b2
	defb 025h,003h	; b9b4
	defb 005h,01fh	; b9b6
	defb 025h,004h	; b9b8
	defb 005h,08fh	; b9ba
	defb 001h,00ah	; b9bc
	defb 009h,037h	; b9be
	defb 001h,006h	; b9c0
	defb 005h,072h	; b9c2
	defb 001h,001h	; b9c4
	defb 009h,022h	; b9c6
	defb 029h,005h	; b9c8
	defb 009h,020h	; b9ca
	defb 001h,005h	; b9cc
	defb 005h,046h	; b9ce
	defb 001h,001h	; b9d0
	defb 009h,014h	; b9d2
	defb 001h,004h	; b9d4
	defb 005h,05ah	; b9d6
	defb 001h,002h	; b9d8
	defb 009h,04bh	; b9da
	defb 001h,003h	; b9dc
	defb 005h,030h	; b9de
	defb 001h,00ch	; b9e0
	defb 009h,030h	; b9e2
	defb 001h,005h	; b9e4
	defb 005h,02eh	; b9e6
	defb 025h,007h	; b9e8
	defb 005h,00dh	; b9ea
	defb 001h,002h	; b9ec
	defb 009h,009h	; b9ee
	defb 021h,001h	; b9f0
	defb 025h,003h	; b9f2
	defb 005h,011h	; b9f4
	defb 001h,001h	; b9f6
	defb 009h,017h	; b9f8
	defb 029h,004h	; b9fa
	defb 001h,002h	; b9fc
	defb 005h,042h	; b9fe
	defb 015h,008h	; ba00
	defb 005h,01ah	; ba02
	defb 001h,026h	; ba04
	defb 0ffh	; ba06

; ----------------------------------------------------------------------
; DATOS partida_grabada_fase_24: la partida grabada de la demo en la fase 24:
;   parejas (mandos, cuadros que duran) que p01:7F26 lee desde el tercer byte
;   -avanza dos antes de leer- hasta el 0xFF del final (185 bytes)
;   0xba07..0xbac0  (185 bytes)
DATA_partida_grabada_fase_24:
	defb 000h,000h	; ba07
	defb 000h,087h	; ba09
	defb 001h,093h	; ba0b
	defb 005h,02dh	; ba0d
	defb 001h,007h	; ba0f
	defb 009h,046h	; ba11
	defb 001h,008h	; ba13
	defb 005h,01dh	; ba15
	defb 001h,018h	; ba17
	defb 009h,021h	; ba19
	defb 001h,001h	; ba1b
	defb 005h,002h	; ba1d
	defb 025h,007h	; ba1f
	defb 005h,02ch	; ba21
	defb 021h,001h	; ba23
	defb 029h,002h	; ba25
	defb 009h,026h	; ba27
	defb 001h,017h	; ba29
	defb 005h,024h	; ba2b
	defb 001h,023h	; ba2d
	defb 009h,01eh	; ba2f
	defb 001h,007h	; ba31
	defb 005h,017h	; ba33
	defb 001h,00eh	; ba35
	defb 009h,018h	; ba37
	defb 001h,008h	; ba39
	defb 005h,011h	; ba3b
	defb 001h,017h	; ba3d
	defb 009h,005h	; ba3f
	defb 001h,007h	; ba41
	defb 009h,001h	; ba43
	defb 019h,00bh	; ba45
	defb 011h,001h	; ba47
	defb 001h,002h	; ba49
	defb 005h,006h	; ba4b
	defb 001h,03ch	; ba4d
	defb 011h,008h	; ba4f
	defb 001h,009h	; ba51
	defb 011h,007h	; ba53
	defb 001h,009h	; ba55
	defb 005h,02dh	; ba57
	defb 015h,013h	; ba59
	defb 005h,010h	; ba5b
	defb 015h,006h	; ba5d
	defb 005h,00eh	; ba5f
	defb 001h,011h	; ba61
	defb 009h,00dh	; ba63
	defb 001h,001h	; ba65
	defb 011h,00bh	; ba67
	defb 001h,037h	; ba69
	defb 009h,004h	; ba6b
	defb 019h,028h	; ba6d
	defb 009h,024h	; ba6f
	defb 019h,007h	; ba71
	defb 009h,00ch	; ba73
	defb 019h,007h	; ba75
	defb 009h,003h	; ba77
	defb 001h,00bh	; ba79
	defb 005h,042h	; ba7b
	defb 001h,012h	; ba7d
	defb 009h,030h	; ba7f
	defb 029h,007h	; ba81
	defb 009h,013h	; ba83
	defb 001h,019h	; ba85
	defb 005h,010h	; ba87
	defb 001h,019h	; ba89
	defb 011h,006h	; ba8b
	defb 001h,004h	; ba8d
	defb 009h,004h	; ba8f
	defb 019h,006h	; ba91
	defb 009h,023h	; ba93
	defb 001h,006h	; ba95
	defb 005h,00ch	; ba97
	defb 001h,007h	; ba99
	defb 005h,014h	; ba9b
	defb 015h,005h	; ba9d
	defb 005h,048h	; ba9f
	defb 015h,007h	; baa1
	defb 005h,007h	; baa3
	defb 015h,005h	; baa5
	defb 005h,045h	; baa7
	defb 001h,015h	; baa9
	defb 009h,027h	; baab
	defb 029h,006h	; baad
	defb 009h,02fh	; baaf
	defb 001h,003h	; bab1
	defb 005h,009h	; bab3
	defb 001h,001h	; bab5
	defb 009h,067h	; bab7
	defb 001h,005h	; bab9
	defb 005h,013h	; babb
	defb 004h,011h	; babd
	defb 0ffh	; babf

; ----------------------------------------------------------------------
; DATOS guion_BAC0: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F63[4],
;   p00:5E9E por 0x5F6D[4] (15 bytes)
;   0xbac0..0xbacf  (15 bytes)
DATA_guion_BAC0:
	defb 005h,08bh,0eeh,08ah,020h,025h,030h,029h,02ch,02fh,027h,035h,025h,020h,000h	; bac0  .... %0),/'5% .

; ----------------------------------------------------------------------
; DATOS guion_BACF: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F63[3]
;   (26 bytes)
;   0xbacf..0xbae9  (26 bytes)
DATA_guion_BACF:
	defb 001h,082h,0eeh,095h,039h,02fh,035h,000h,028h,021h,036h,025h,000h,033h,035h,023h	; bacf  ....9/5.(!6%.35#
	defb 023h,025h,025h,024h,025h,024h,000h,029h,02eh,000h	; badf  #%%$%$.)..

; ----------------------------------------------------------------------
; DATOS guion_BAE9: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F63[2]
;   (30 bytes)
;   0xbae9..0xbb07  (30 bytes)
DATA_guion_BAE9:
	defb 001h,082h,0eeh,099h,032h,025h,033h,023h,035h,029h,02eh,027h,000h,034h,028h,025h	; bae9  ....2%3#5).'.4(%
	defb 000h,030h,032h,029h,02eh,023h,025h,033h,033h,000h,021h,02eh,024h,000h	; baf9  .02).#%33.!.$.

; ----------------------------------------------------------------------
; DATOS guion_BB07: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F63[1]
;   (32 bytes)
;   0xbb07..0xbb27  (32 bytes)
DATA_guion_BB07:
	defb 001h,082h,0eeh,09bh,033h,021h,036h,029h,02eh,027h,000h,034h,028h,025h,000h,030h	; bb07  ....3!6).'.4(%.0
	defb 025h,02eh,027h,035h,029h,02eh,000h,02bh,029h,02eh,027h,024h,02fh,02dh,03dh,000h	; bb17  %.'5)..+).'$/-=.

; ----------------------------------------------------------------------
; DATOS guion_BB27: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F63[0]
;   (21 bytes)
;   0xbb27..0xbb3c  (21 bytes)
DATA_guion_BB27:
	defb 009h,082h,0eeh,090h,023h,02fh,02eh,027h,032h,021h,034h,035h,02ch,021h,034h,029h	; bb27  ....#/.'2!45,!4)
	defb 02fh,02eh,033h,03dh,000h	; bb37

; ----------------------------------------------------------------------
; DATOS guion_BB3C: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F6D[3]
;   (23 bytes)
;   0xbb3c..0xbb53  (23 bytes)
DATA_guion_BB3C:
	defb 001h,086h,0eeh,092h,039h,02fh,035h,000h,028h,021h,036h,025h,000h,026h,021h,029h	; bb3c  ....9/5.(!6%.&!)
	defb 02ch,025h,024h,000h,034h,02fh,000h	; bb4c

; ----------------------------------------------------------------------
; DATOS guion_BB53: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F6D[2]
;   (25 bytes)
;   0xbb53..0xbb6c  (25 bytes)
DATA_guion_BB53:
	defb 001h,086h,0eeh,094h,032h,025h,033h,023h,035h,025h,000h,034h,028h,025h,000h,030h	; bb53  ....2%3#5%.4(%.0
	defb 032h,029h,02eh,023h,025h,033h,033h,03dh,000h	; bb63  2).#%33=.

; ----------------------------------------------------------------------
; DATOS guion_BB6C: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F6D[1]
;   (22 bytes)
;   0xbb6c..0xbb82  (22 bytes)
DATA_guion_BB6C:
	defb 001h,086h,0eeh,091h,030h,02ch,025h,021h,033h,025h,000h,034h,032h,039h,000h,021h	; bb6c  ....0,%!3%.429.!
	defb 027h,021h,029h,02eh,03dh,000h	; bb7c

; ----------------------------------------------------------------------
; DATOS guion_BB82: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F6D[0] (4
;   bytes)
;   0xbb82..0xbb86  (4 bytes)
DATA_guion_BB82:
	defb 009h,086h,0eeh,000h	; bb82

; ----------------------------------------------------------------------
; DATOS guion_BB86: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[22]
;   (14 bytes)
;   0xbb86..0xbb94  (14 bytes)
DATA_guion_BB86:
	defb 005h,08bh,0eeh,089h,020h,020h,033h,034h,021h,026h,026h,020h,020h,000h	; bb86  ....  34!&&  .

; ----------------------------------------------------------------------
; DATOS guion_BB94: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[21]
;   (22 bytes)
;   0xbb94..0xbbaa  (22 bytes)
DATA_guion_BB94:
	defb 002h,087h,0eeh,091h,020h,02dh,021h,029h,02eh,000h,030h,032h,02fh,027h,032h,021h	; bb94  .... -!)..02/'2!
	defb 02dh,02dh,025h,032h,020h,000h	; bba4

; ----------------------------------------------------------------------
; DATOS guion_BBAA: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[20]
;   (12 bytes)
;   0xbbaa..0xbbb6  (12 bytes)
DATA_guion_BBAA:
	defb 004h,08ch,0eeh,087h,028h,03dh,026h,035h,02bh,035h,029h,000h	; bbaa  ....(=&5+5).

; ----------------------------------------------------------------------
; DATOS guion_BBB6: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[19]
;   (21 bytes)
;   0xbbb6..0xbbcb  (21 bytes)
DATA_guion_BBB6:
	defb 002h,088h,0eeh,090h,020h,033h,035h,022h,000h,030h,032h,02fh,027h,032h,021h,02dh	; bbb6  .... 35".02/'2!-
	defb 02dh,025h,032h,020h,000h	; bbc6

; ----------------------------------------------------------------------
; DATOS guion_BBCB: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[18]
;   (12 bytes)
;   0xbbcb..0xbbd7  (12 bytes)
DATA_guion_BBCB:
	defb 002h,08ch,0eeh,087h,02dh,03dh,02fh,03ah,021h,037h,021h,000h	; bbcb  ....-=/:!7!.

; ----------------------------------------------------------------------
; DATOS guion_BBD7: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[17]
;   (11 bytes)
;   0xbbd7..0xbbe2  (11 bytes)
DATA_guion_BBD7:
	defb 004h,08ch,0eeh,086h,039h,03dh,02fh,028h,034h,021h,000h	; bbd7  ....9=/(4!.

; ----------------------------------------------------------------------
; DATOS guion_BBE2: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[16]
;   (19 bytes)
;   0xbbe2..0xbbf5  (19 bytes)
DATA_guion_BBE2:
	defb 002h,089h,0eeh,08eh,020h,02dh,021h,029h,02eh,000h,030h,02ch,021h,02eh,02eh,025h	; bbe2  .... -!)..0,!..%
	defb 032h,020h,000h	; bbf2

; ----------------------------------------------------------------------
; DATOS guion_BBF5: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[15]
;   (14 bytes)
;   0xbbf5..0xbc03  (14 bytes)
DATA_guion_BBF5:
	defb 004h,08bh,0eeh,089h,032h,03dh,033h,028h,02fh,027h,021h,02bh,029h,000h	; bbf5  ....2=3(/'!+).

; ----------------------------------------------------------------------
; DATOS guion_BC03: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[14]
;   (23 bytes)
;   0xbc03..0xbc1a  (23 bytes)
DATA_guion_BC03:
	defb 002h,087h,0eeh,092h,020h,027h,032h,021h,030h,028h,029h,023h,000h,024h,025h,033h	; bc03  .... '2!0()#.$%3
	defb 029h,027h,02eh,025h,032h,020h,000h	; bc13

; ----------------------------------------------------------------------
; DATOS guion_BC1A: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[13],
;   p00:5E9E por 0x5F35[5] (14 bytes)
;   0xbc1a..0xbc28  (14 bytes)
DATA_guion_BC1A:
	defb 002h,08bh,0eeh,089h,032h,03dh,033h,028h,02fh,027h,021h,02bh,029h,000h	; bc1a  ....2=3(/'!+).

; ----------------------------------------------------------------------
; DATOS guion_BC28: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[12]
;   (11 bytes)
;   0xbc28..0xbc33  (11 bytes)
DATA_guion_BC28:
	defb 002h,08ch,0eeh,086h,039h,03dh,02fh,028h,034h,021h,000h	; bc28  ....9=/(4!.

; ----------------------------------------------------------------------
; DATOS guion_BC33: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[11]
;   (15 bytes)
;   0xbc33..0xbc42  (15 bytes)
DATA_guion_BC33:
	defb 002h,08bh,0eeh,08ah,023h,03dh,034h,021h,02eh,029h,027h,021h,02bh,029h,000h	; bc33  ....#=4!.)'!+).

; ----------------------------------------------------------------------
; DATOS guion_BC42: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[10]
;   (15 bytes)
;   0xbc42..0xbc51  (15 bytes)
DATA_guion_BC42:
	defb 004h,08bh,0eeh,08ah,028h,03dh,02dh,021h,02bh,029h,034h,021h,02eh,029h,000h	; bc42  ....(=-!+)4!.).

; ----------------------------------------------------------------------
; DATOS guion_BC51: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[9]
;   (20 bytes)
;   0xbc51..0xbc65  (20 bytes)
DATA_guion_BC51:
	defb 002h,088h,0eeh,08fh,020h,033h,02fh,035h,02eh,024h,000h,023h,032h,025h,021h,034h	; bc51  .... 3/5.$.#2%!4
	defb 02fh,032h,020h,000h	; bc61

; ----------------------------------------------------------------------
; DATOS guion_BC65: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[8]
;   (13 bytes)
;   0xbc65..0xbc72  (13 bytes)
DATA_guion_BC65:
	defb 002h,08ch,0eeh,088h,039h,03dh,033h,021h,033h,021h,02bh,029h,000h	; bc65  ....9=3!3!+).

; ----------------------------------------------------------------------
; DATOS guion_BC72: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[7]
;   (16 bytes)
;   0xbc72..0xbc82  (16 bytes)
DATA_guion_BC72:
	defb 004h,08ah,0eeh,08bh,02bh,03dh,02dh,021h,034h,033h,035h,022h,021h,032h,021h,000h	; bc72  ....+=-!435"!2!.

; ----------------------------------------------------------------------
; DATOS guion_BC82: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[6]
;   (15 bytes)
;   0xbc82..0xbc91  (15 bytes)
DATA_guion_BC82:
	defb 002h,08bh,0eeh,08ah,020h,024h,029h,032h,025h,023h,034h,02fh,032h,020h,000h	; bc82  .... $)2%#4/2 .

; ----------------------------------------------------------------------
; DATOS guion_BC91: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[4]
;   (12 bytes)
;   0xbc91..0xbc9d  (12 bytes)
DATA_guion_BC91:
	defb 017h,08ch,0eeh,087h,028h,03dh,026h,035h,02bh,035h,029h,000h	; bc91  ....(=&5+5).

; ----------------------------------------------------------------------
; DATOS guion_BC9D: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[3]
;   (27 bytes)
;   0xbc9d..0xbcb8  (27 bytes)
DATA_guion_BC9D:
	defb 001h,084h,0eeh,096h,037h,025h,000h,030h,032h,02fh,02dh,029h,033h,025h,000h,034h	; bc9d  ....7%.02/-)3%.4
	defb 02fh,000h,023h,02fh,02eh,034h,029h,02eh,035h,025h,000h	; bcad  /.#/.4).5%.

; ----------------------------------------------------------------------
; DATOS guion_BCB8: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[2]
;   (26 bytes)
;   0xbcb8..0xbcd2  (26 bytes)
DATA_guion_BCB8:
	defb 001h,084h,0eeh,095h,033h,025h,02eh,024h,029h,02eh,027h,000h,032h,02fh,02dh,021h	; bcb8  ....3%.$).'.2/-!
	defb 02eh,034h,029h,023h,000h,027h,021h,02dh,025h,000h	; bcc8  .4)#.'!-%.

; ----------------------------------------------------------------------
; DATOS guion_BCD2: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[1]
;   (14 bytes)
;   0xbcd2..0xbce0  (14 bytes)
DATA_guion_BCD2:
	defb 004h,084h,0eeh,089h,02dh,025h,033h,033h,021h,027h,025h,033h,03dh,000h	; bcd2  ....-%33!'%3=.

; ----------------------------------------------------------------------
; DATOS guion_BCE0: guion comprimido (linea del texto que sube: un byte de
;   duracion delante) que lee descomprime; lo cargan p00:5E9E por 0x5F35[0]
;   (24 bytes)
;   0xbce0..0xbcf8  (24 bytes)
DATA_guion_BCE0:
	defb 00ah,086h,0eeh,093h,030h,032h,025h,033h,025h,02eh,034h,025h,024h,000h,022h,039h	; bce0  ....02%3%.4%$."9
	defb 000h,02bh,02fh,02eh,021h,02dh,029h,000h	; bcf0  .+/.!-).

; ----------------------------------------------------------------------
; DATOS guion_BCF8: guion comprimido que lee descomprime (por el puente de
;   5E8D) y descomprime (por el puente de 5F13); lo cargan p00:5E8D, p00:5F13
;   (5 bytes)
;   0xbcf8..0xbcfd  (5 bytes)
DATA_guion_BCF8:
	defb 080h,0eeh,020h,000h,000h	; bcf8

; ----------------------------------------------------------------------
; DATOS relleno_del_banco_11: 771 bytes a 0xFF hasta el final de los 8 KB del
;   banco: espacio libre
;   0xbcfd..0xc000  (771 bytes)
DATA_relleno_del_banco_11:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcfd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd0d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd1d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd2d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd3d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd4d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd5d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd6d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd7d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd8d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd9d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdad  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdbd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdcd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bddd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bded  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdfd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be0d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be1d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be2d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be3d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be4d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be5d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be6d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be7d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be8d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be9d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bead  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bebd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; becd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bedd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beed  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; befd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9d  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfad  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfbd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfcd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdd  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfed  ................
	defb 0ffh,0ffh,0ffh	; bffd
