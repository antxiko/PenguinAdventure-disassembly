; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 13 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS cola_9EE9: la cola del guion de bytes sueltos (0xFF acaba, 0xFE otro
;   destino) (cuadro 1 de la animacion del fondo) de 0x9EE9 del banco 12, que
;   pasa de ranura sin cambiar de banco; lo cargan p01:655A por 0x9D85[1] (68
;   bytes)
;   0xa000..0xa044  (68 bytes)
DATA_cola_9EE9:
	defb 03ah,03ch,01dh,019h,018h,03bh,01fh,0feh,037h,0edh,05fh,07bh,058h,059h,05dh,07ch	; a000  :<...;..7._{XY]|
	defb 07ah,073h,001h,018h,001h,001h,037h,003h,01ch,010h,0feh,059h,0edh,050h,05ch,003h	; a010  zs....7....Y.P\.
	defb 077h,001h,001h,058h,019h,018h,001h,011h,00bh,0feh,07bh,0edh,04bh,051h,001h,058h	; a020  w..X......{.KQ.X
	defb 059h,007h,008h,009h,00ah,0feh,09ch,0edh,01dh,01ch,01bh,01ah,00bh,006h,0feh,0beh	; a030  Y...............
	defb 0edh,019h,01eh,0ffh	; a040

; ----------------------------------------------------------------------
; DATOS tira_A044: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9D85[2] (353 bytes)
;   0xa044..0xa1a5  (353 bytes)
DATA_tira_A044:
	defb 0e2h,0ebh,040h,06ch,06dh,06eh,06fh,070h,06eh,06fh,070h,06eh,06fh,070h,06eh,06fh	; a044  ..@lmnopnopnopno
	defb 070h,06eh,06fh,070h,06eh,06fh,070h,06eh,06fh,070h,06eh,06fh,070h,06eh,071h,072h	; a054  pnopnopnopnopnqr
	defb 0feh,003h,0ech,040h,06ch,06dh,06eh,073h,074h,06eh,073h,074h,06eh,073h,074h,06eh	; a064  ...@lmnstnstnstn
	defb 073h,074h,06eh,073h,074h,06eh,073h,074h,06eh,075h,076h,077h,078h,079h,0feh,024h	; a074  stnstnstnuvwxy.$
	defb 0ech,040h,07ah,07bh,07ch,07dh,07eh,07fh,07dh,07eh,07fh,07dh,07eh,07fh,07dh,07eh	; a084  .@z{|}~.}~.}~.}~
	defb 07fh,07dh,07eh,07fh,07dh,080h,077h,072h,0feh,046h,0ech,040h,081h,082h,081h,083h	; a094  .}~.}.wr.F.@....
	defb 082h,081h,083h,082h,081h,083h,082h,081h,083h,082h,081h,083h,082h,069h,084h,0feh	; a0a4  .............i..
	defb 067h,0ech,040h,085h,086h,087h,085h,086h,087h,085h,086h,087h,085h,086h,087h,085h	; a0b4  g.@.............
	defb 086h,087h,040h,0feh,082h,0ech,063h,002h,0feh,086h,0ech,062h,0feh,099h,0ech,022h	; a0c4  ..@...c....b..."
	defb 0feh,09ch,0ech,002h,023h,0feh,0a2h,0ech,025h,002h,0feh,0a6h,0ech,025h,002h,0feh	; a0d4  ....#...%....%..
	defb 0a9h,0ech,023h,002h,022h,0feh,0b4h,0ech,062h,002h,063h,0feh,0b8h,0ech,002h,065h	; a0e4  ..#."...b.c....e
	defb 0feh,0bch,0ech,002h,065h,0feh,0c2h,0ech,028h,001h,001h,0feh,0c6h,0ech,029h,02ah	; a0f4  ....e...(.....)*
	defb 0feh,0c9h,0ech,02fh,001h,034h,00ah,011h,010h,004h,004h,050h,051h,04ah,074h,001h	; a104  .../.4.....PQJt.
	defb 06fh,0feh,0d8h,0ech,06ah,069h,0feh,0dbh,0ech,001h,001h,068h,0feh,0e2h,0ech,029h	; a114  o...ji.....h...)
	defb 02ah,0feh,0e5h,0ech,001h,02bh,001h,033h,036h,01ah,03dh,009h,00dh,0feh,0f2h,0ech	; a124  *....+.36.=.....
	defb 04dh,049h,07dh,05ah,076h,073h,001h,06bh,001h,0feh,0fch,0ech,06ah,069h,0feh,002h	; a134  MI}Zvs.k....ji..
	defb 0edh,02bh,001h,033h,03ah,03ch,019h,018h,03dh,01fh,0feh,015h,0edh,05fh,07dh,058h	; a144  .+.3:<..=...._}X
	defb 059h,07ch,07ah,073h,001h,06bh,0feh,020h,0edh,006h,006h,019h,018h,001h,001h,037h	; a154  Y|zs.k. .......7
	defb 01eh,00bh,0feh,037h,0edh,04bh,05eh,077h,001h,001h,058h,059h,006h,006h,032h,037h	; a164  ...7.K^w..XY..27
	defb 040h,01dh,019h,00eh,020h,0feh,059h,0edh,060h,04eh,059h,05dh,080h,077h,072h,001h	; a174  @... .Y.`NY].wr.
	defb 001h,037h,01ch,010h,00dh,0feh,07ah,0edh,04dh,050h,05ch,077h,001h,001h,00ch,00dh	; a184  .7....z.MP\w....
	defb 00eh,00fh,0feh,09ch,0edh,022h,021h,020h,01fh,010h,011h,0feh,0beh,0edh,024h,023h	; a194  ....."! ......$#
	defb 0ffh	; a1a4

; ----------------------------------------------------------------------
; DATOS tira_A1A5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9D85[3] (367 bytes)
;   0xa1a5..0xa314  (367 bytes)
DATA_tira_A1A5:
	defb 0e2h,0ebh,088h,089h,08ah,08bh,08ch,08dh,08bh,08ch,08dh,08bh,08ch,08dh,08bh,08ch	; a1a5  ................
	defb 08dh,08bh,08ch,08dh,08bh,08ch,08dh,08bh,08ch,08dh,08bh,08eh,08fh,05eh,05fh,040h	; a1b5  .............^_@
	defb 0feh,003h,0ech,088h,089h,090h,091h,092h,093h,091h,092h,093h,091h,092h,093h,091h	; a1c5  ................
	defb 092h,093h,091h,092h,093h,091h,092h,093h,091h,094h,095h,096h,097h,040h,0feh,025h	; a1d5  .............@.%
	defb 0ech,098h,099h,09ah,09bh,09ch,09dh,09bh,09ch,09dh,09bh,09ch,09dh,09bh,09ch,09dh	; a1e5  ................
	defb 09bh,09ch,09dh,09bh,09ch,09dh,09eh,097h,0feh,047h,0ech,09fh,0a0h,0a1h,0a0h,0a2h	; a1f5  .........G......
	defb 0a3h,0a0h,0a2h,0a3h,0a0h,0a2h,0a3h,0a0h,0a2h,0a3h,0a0h,0a2h,0a3h,0a4h,0feh,068h	; a205  ...............h
	defb 0ech,098h,0a5h,0a6h,0a7h,0a5h,0a6h,0a7h,0a5h,0a6h,0a7h,0a5h,0a6h,0a7h,0a5h,0a6h	; a215  ................
	defb 0a7h,0feh,081h,0ech,063h,002h,0feh,085h,0ech,022h,002h,0feh,099h,0ech,002h,062h	; a225  ....c....".....b
	defb 0feh,09dh,0ech,002h,023h,0feh,0a1h,0ech,025h,002h,0feh,0a5h,0ech,065h,002h,0feh	; a235  ....#...%....e..
	defb 0a8h,0ech,025h,002h,0feh,0abh,0ech,022h,0feh,0b4h,0ech,062h,0feh,0b6h,0ech,002h	; a245  ..%...."...b....
	defb 065h,0feh,0b9h,0ech,002h,025h,0feh,0bdh,0ech,002h,065h,0feh,0c1h,0ech,029h,001h	; a255  e....%....e...).
	defb 0feh,0c5h,0ech,027h,02ah,001h,028h,001h,044h,030h,00ch,00eh,00fh,004h,004h,050h	; a265  ...'*.(.D0.....P
	defb 04eh,04ch,070h,084h,001h,068h,001h,06ah,067h,0feh,0ddh,0ech,001h,069h,0feh,0e1h	; a275  NLp..h.jg....i..
	defb 0ech,027h,02ah,001h,0feh,0e5h,0ech,028h,001h,033h,031h,01ah,032h,039h,00bh,00dh	; a285  .'*....(.31.29..
	defb 0feh,0f2h,0ech,04dh,04bh,079h,072h,05ah,071h,073h,001h,068h,0feh,0fch,0ech,001h	; a295  ...MKyrZqs.h....
	defb 06ah,067h,0feh,001h,0edh,028h,001h,033h,03ah,038h,018h,001h,032h,039h,01fh,0feh	; a2a5  jg...(.3:8..29..
	defb 015h,0edh,05fh,079h,072h,001h,058h,078h,07ah,073h,001h,068h,0feh,020h,0edh,007h	; a2b5  .._yr.Xxzs.h. ..
	defb 02eh,018h,001h,0feh,025h,0edh,037h,01ch,01ch,010h,0feh,037h,0edh,050h,05ch,05ch	; a2c5  ....%.7....7.P\\
	defb 077h,0feh,03ch,0edh,001h,058h,06eh,007h,03ah,03ch,01dh,019h,018h,021h,01fh,0feh	; a2d5  w.<..Xn.:<...!..
	defb 059h,0edh,05fh,061h,058h,059h,05dh,07ch,07ah,0feh,061h,0edh,037h,01ch,01eh,01fh	; a2e5  Y._aXY]|z.a.7...
	defb 001h,0feh,07ah,0edh,001h,05fh,05eh,05ch,077h,0feh,080h,0edh,001h,012h,013h,001h	; a2f5  ..z.._^\w.......
	defb 0feh,09ch,0edh,001h,026h,025h,001h,014h,006h,0feh,0beh,0edh,019h,027h,0ffh	; a305  ....&%.......'.

; ----------------------------------------------------------------------
; DATOS guion_A314: guion comprimido que lee descomprime; lo cargan p01:61C2
;   (201 bytes)
;   0xa314..0xa3dd  (201 bytes)
DATA_guion_A314:
	defb 0e0h,0ebh,060h,001h,040h,001h,060h,001h,060h,001h,045h,001h,088h,005h,014h,006h	; a314  ..`.@.`.`.E.....
	defb 00ah,00bh,0b5h,0b6h,0deh,006h,0ddh,088h,0dch,0b6h,0b2h,00ch,00dh,010h,013h,011h	; a324  ................
	defb 006h,001h,08bh,005h,007h,008h,0b3h,0d9h,0d8h,0ebh,0f5h,0e2h,0c4h,0f3h,008h,06ch	; a334  ...............l
	defb 090h,0fah,0d5h,0e4h,0fch,0e8h,0e5h,0dah,0b4h,00eh,012h,011h,001h,009h,0d7h,0e1h	; a344  ................
	defb 0e0h,080h,0c8h,0edh,087h,022h,026h,021h,022h,016h,018h,016h,005h,004h,083h,023h	; a354  ....."&!"......#
	defb 024h,016h,080h,0dch,0edh,087h,0ech,0e3h,0dbh,00fh,0fbh,09ah,003h,080h,0e8h,0edh	; a364  $...............
	defb 007h,002h,081h,020h,003h,004h,082h,019h,01dh,003h,002h,002h,01fh,080h,0ffh,0edh	; a374  ... ............
	defb 081h,0f4h,002h,003h,080h,007h,0eeh,082h,017h,01ch,002h,002h,004h,027h,085h,002h	; a384  .............'..
	defb 01fh,004h,026h,028h,005h,002h,080h,020h,0eeh,002h,003h,080h,026h,0eeh,085h,004h	; a394  ..&(... ....&...
	defb 019h,01dh,002h,020h,003h,004h,085h,02ch,01bh,002h,016h,01dh,008h,002h,080h,040h	; a3a4  ... ...,.......@
	defb 0eeh,081h,003h,080h,046h,0eeh,082h,016h,02ah,002h,002h,081h,017h,003h,004h,082h	; a3b4  ....F...*.......
	defb 023h,02ah,00bh,002h,080h,060h,0eeh,081h,003h,080h,066h,0eeh,002h,002h,002h,02bh	; a3c4  #*...`....f....+
	defb 002h,004h,083h,019h,026h,028h,00dh,002h,000h	; a3d4  ....&(...

; ----------------------------------------------------------------------
; DATOS cuadros_A3DD: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa3dd..0xa3e5  (8 bytes)
DATA_cuadros_A3DD:
	defb 0e5h,0a3h	; a3dd
	defb 045h,0a4h	; a3df
	defb 0a5h,0a4h	; a3e1
	defb 005h,0a5h	; a3e3

; ----------------------------------------------------------------------
; DATOS tira_A3E5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0xA3DD[0] (96 bytes)
;   0xa3e5..0xa445  (96 bytes)
DATA_tira_A3E5:
	defb 0c4h,0edh,0dfh,061h,069h,0c8h,0feh,0d7h,0edh,089h,091h,098h,09ch,0edh,0feh,0e3h	; a3e5  ...ai...........
	defb 0edh,003h,034h,035h,0f1h,015h,0feh,0f9h,0edh,0cbh,0f2h,07eh,0f8h,07bh,0d4h,0feh	; a3f5  ..45.......~.{..
	defb 002h,0eeh,003h,043h,044h,004h,004h,0feh,019h,0eeh,002h,0a9h,0cfh,07ah,06dh,07dh	; a405  ...CD........zm}
	defb 07ch,0feh,022h,0eeh,052h,053h,054h,055h,0feh,03bh,0eeh,0a8h,0c2h,06eh,06fh,03fh	; a415  |.".RSTU.;...no?
	defb 0feh,041h,0eeh,061h,062h,063h,033h,0beh,0feh,05bh,0eeh,002h,0ach,0d0h,05ch,045h	; a425  .A.abc3..[....\E
	defb 0feh,061h,0eeh,064h,060h,042h,0bch,002h,0feh,07ch,0eeh,0afh,09dh,0b8h,02fh,0ffh	; a435  .a.d`B...|..../.

; ----------------------------------------------------------------------
; DATOS tira_A445: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0xA3DD[1] (96 bytes)
;   0xa445..0xa4a5  (96 bytes)
DATA_tira_A445:
	defb 0c4h,0edh,0eeh,02dh,02eh,0c6h,0feh,0d7h,0edh,025h,083h,086h,094h,0eah,0feh,0e3h	; a445  ...-.....%......
	defb 0edh,061h,03ch,03dh,03eh,015h,0feh,0f9h,0edh,01fh,093h,092h,087h,07bh,0d4h,0feh	; a455  .a<=>........{..
	defb 002h,0eeh,044h,04bh,04ch,04dh,04eh,0feh,019h,0eeh,0aah,0a0h,0c3h,07fh,004h,08fh	; a465  ..DKLMN.........
	defb 030h,0feh,022h,0eeh,05ah,05bh,0f9h,05dh,0feh,03bh,0eeh,0a1h,047h,046h,031h,032h	; a475  0.".Z[.].;..GF12
	defb 0feh,041h,0eeh,056h,05eh,05fh,004h,01ah,0feh,05bh,0eeh,002h,0a6h,081h,067h,093h	; a485  .A.V^_...[....g.
	defb 0feh,061h,0eeh,057h,04fh,08bh,0bah,0a2h,0feh,07ch,0eeh,09eh,0a7h,0c1h,089h,0ffh	; a495  .a.WO....|......

; ----------------------------------------------------------------------
; DATOS tira_A4A5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0xA3DD[2] (96 bytes)
;   0xa4a5..0xa505  (96 bytes)
DATA_tira_A4A5:
	defb 0c4h,0edh,0e6h,0f7h,06ah,0cah,0feh,0d7h,0edh,025h,0f6h,082h,0f0h,0e7h,0feh,0e3h	; a4a5  ....j....%......
	defb 0edh,08eh,038h,039h,04eh,015h,0feh,0f9h,0edh,01fh,0b7h,099h,036h,037h,0d1h,0feh	; a4b5  ..89N.......67..
	defb 002h,0eeh,061h,048h,049h,054h,08ch,0feh,019h,0eeh,0b0h,0aeh,095h,076h,077h,079h	; a4c5  ..aHIT.......vwy
	defb 078h,0feh,022h,0eeh,003h,058h,059h,03eh,0feh,03bh,0eeh,0a4h,092h,081h,070h,068h	; a4d5  x."..XY>.;....ph
	defb 0feh,041h,0eeh,003h,040h,041h,042h,01ah,0feh,05bh,0eeh,0a9h,0c7h,0bfh,090h,06bh	; a4e5  .A..@AB..[.....k
	defb 0feh,061h,0eeh,003h,050h,0f9h,0f1h,002h,0feh,07ch,0eeh,09fh,0a5h,0c5h,0efh,0ffh	; a4f5  .a..P....|......

; ----------------------------------------------------------------------
; DATOS tira_A505: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0xA3DD[3] (94 bytes)
;   0xa505..0xa563  (94 bytes)
DATA_tira_A505:
	defb 0c4h,0edh,0e6h,058h,039h,01eh,0feh,0d8h,0edh,004h,088h,084h,0e9h,0feh,0e3h,0edh	; a505  ...X9...........
	defb 085h,096h,066h,042h,0bbh,0feh,0f9h,0edh,0c9h,0d6h,09bh,08dh,08ah,0d2h,0feh,002h	; a515  ..fB............
	defb 0eeh,003h,03ah,03bh,0f9h,067h,0feh,019h,0eeh,002h,09fh,0ceh,074h,081h,073h,075h	; a525  ..:;.g......t.su
	defb 0feh,022h,0eeh,04ah,065h,039h,004h,0feh,03bh,0eeh,0b1h,0cch,072h,071h,08fh,0feh	; a535  .".Je9..;...rq..
	defb 041h,0eeh,003h,050h,051h,0f1h,0b9h,0feh,05bh,0eeh,0a3h,0abh,0c0h,046h,097h,0feh	; a545  A..PQ...[....F..
	defb 061h,0eeh,003h,056h,080h,01eh,0feh,07ch,0eeh,0aah,0adh,0cdh,029h,0ffh	; a555  a..V...|....).

; ----------------------------------------------------------------------
; DATOS tira_A563: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (LA
;   PANTALLA DE LA TIENDA del modo 3: ---BARTER---, el tendero de siempre en
;   las filas 6 a 9 y END) que lee pinta_guion_con_mascara; lo cargan p01:6C61
;   (58 bytes)
;   0xa563..0xa59d  (58 bytes)
DATA_tira_A563:
	defb 08ah,038h,020h,020h,020h,022h,021h,032h,034h,025h,032h,020h,020h,020h,0feh,0c5h	; a563  .8   "!24%2   ..
	defb 038h,048h,060h,061h,070h,06fh,0feh,0e5h,038h,049h,04ch,062h,071h,04fh,0feh,005h	; a573  8H`apo..8ILbqO..
	defb 039h,04ah,04dh,063h,072h,050h,052h,0feh,025h,039h,04bh,04eh,064h,073h,051h,0feh	; a583  9JMcrPR.%9KNdsQ.
	defb 058h,03ah,040h,041h,0feh,078h,03ah,042h,043h,0ffh	; a593  X:@A.x:BC.

; ----------------------------------------------------------------------
; DATOS tira_A59D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   del modo 4: el mismo tendero con la cara del que cobra el doble) que lee
;   pinta_guion_con_mascara; lo cargan p01:6C61 (58 bytes)
;   0xa59d..0xa5d7  (58 bytes)
DATA_tira_A59D:
	defb 08ah,038h,020h,020h,020h,022h,021h,032h,034h,025h,032h,020h,020h,020h,0feh,0c5h	; a59d  .8   "!24%2   ..
	defb 038h,048h,060h,065h,074h,06fh,0feh,0e5h,038h,049h,04ch,066h,075h,04fh,0feh,005h	; a5ad  8H`eto..8ILfuO..
	defb 039h,04ah,04dh,063h,072h,050h,052h,0feh,025h,039h,04bh,04eh,064h,073h,051h,0feh	; a5bd  9JMcrPR.%9KNdsQ.
	defb 058h,03ah,040h,041h,0feh,078h,03ah,042h,043h,0ffh	; a5cd  X:@A.x:BC.

; ----------------------------------------------------------------------
; DATOS tira_A5D7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (la
;   de Santa Claus, el modo 5) que lee pinta_guion_con_mascara; lo cargan
;   p01:6C61 (60 bytes)
;   0xa5d7..0xa613  (60 bytes)
DATA_tira_A5D7:
	defb 08ah,038h,020h,020h,020h,022h,021h,032h,034h,025h,032h,020h,020h,020h,0feh,0a7h	; a5d7  .8   "!24%2   ..
	defb 038h,053h,054h,0feh,0c6h,038h,060h,067h,076h,055h,0feh,0e6h,038h,068h,069h,078h	; a5e7  8ST..8`gvU..8hix
	defb 077h,0feh,005h,039h,06ah,06bh,056h,057h,07ah,079h,0feh,026h,039h,06ch,058h,059h	; a5f7  w..9jkVWzy.&9lXY
	defb 07bh,0feh,058h,03ah,040h,041h,0feh,078h,03ah,042h,043h,0ffh	; a607  {.X:@A.x:BC.

; ----------------------------------------------------------------------
; DATOS animacion_por_decorado_A613: un puntero por decorado (0xE0A1) a una
;   tabla de cuatro cuadros de animacion; la lee p01:6576 con (0xE0A6) = 1 y
;   el cuadro lo da (0xE4C2) & 3
;   0xa613..0xa627  (20 bytes)
DATA_animacion_por_decorado_A613:
	defb 03bh,0a6h	; a613
	defb 091h,0a6h	; a615
	defb 091h,0a7h	; a617
	defb 05bh,0a8h	; a619
	defb 083h,0a8h	; a61b
	defb 02ch,0aah	; a61d
	defb 02ch,0abh	; a61f
	defb 092h,0abh	; a621
	defb 0eeh,0abh	; a623
	defb 02ch,0abh	; a625

; ----------------------------------------------------------------------
; DATOS animacion_por_decorado_A627: un puntero por decorado (0xE0A1) a una
;   tabla de cuatro cuadros de animacion; la lee p01:6576 con (0xE0A6) = 2 y
;   el cuadro lo da (0xE4C2) & 3
;   0xa627..0xa63b  (20 bytes)
DATA_animacion_por_decorado_A627:
	defb 066h,0a6h	; a627
	defb 011h,0a7h	; a629
	defb 0f6h,0a7h	; a62b
	defb 06fh,0a8h	; a62d
	defb 05eh,0a9h	; a62f
	defb 0ach,0aah	; a631
	defb 05fh,0abh	; a633
	defb 0c0h,0abh	; a635
	defb 002h,0ach	; a637
	defb 05fh,0abh	; a639

; ----------------------------------------------------------------------
; DATOS cuadros_A63B: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa63b..0xa643  (8 bytes)
DATA_cuadros_A63B:
	defb 043h,0a6h	; a63b
	defb 043h,0a6h	; a63d
	defb 043h,0a6h	; a63f
	defb 043h,0a6h	; a641

; ----------------------------------------------------------------------
; DATOS tira_A643: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 1 de la animacion del fondo;
;   cuadro 2 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xA63B[0],
;   p01:6576 con (0xE0A6) = 1 por 0xA63B[1], p01:6576 con (0xE0A6) = 1 por
;   0xA63B[2], p01:6576 con (0xE0A6) = 1 por 0xA63B[3] (35 bytes)
;   0xa643..0xa666  (35 bytes)
DATA_tira_A643:
	defb 0c0h,0ech,009h,009h,009h,009h,009h,00ah,00ah,00ah,00ah,00bh,00bh,013h,001h,004h	; a643  ................
	defb 004h,005h,006h,007h,014h,052h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h	; a653  .....R..........
	defb 003h,003h,0ffh	; a663

; ----------------------------------------------------------------------
; DATOS cuadros_A666: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa666..0xa66e  (8 bytes)
DATA_cuadros_A666:
	defb 06eh,0a6h	; a666
	defb 06eh,0a6h	; a668
	defb 06eh,0a6h	; a66a
	defb 06eh,0a6h	; a66c

; ----------------------------------------------------------------------
; DATOS tira_A66E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 1 de la animacion del fondo;
;   cuadro 2 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xA666[0],
;   p01:6576 con (0xE0A6) = 2 por 0xA666[1], p01:6576 con (0xE0A6) = 2 por
;   0xA666[2], p01:6576 con (0xE0A6) = 2 por 0xA666[3] (35 bytes)
;   0xa66e..0xa691  (35 bytes)
DATA_tira_A66E:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,01dh,049h	; a66e  ...............I
	defb 007h,006h,005h,004h,004h,001h,048h,00bh,00bh,00ah,00ah,00ah,00ah,009h,009h,009h	; a67e  ......H.........
	defb 009h,009h,0ffh	; a68e

; ----------------------------------------------------------------------
; DATOS cuadros_A691: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa691..0xa699  (8 bytes)
DATA_cuadros_A691:
	defb 099h,0a6h	; a691
	defb 0b4h,0a6h	; a693
	defb 0cfh,0a6h	; a695
	defb 0eeh,0a6h	; a697

; ----------------------------------------------------------------------
; DATOS tira_A699: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA691[0], p01:6576 con (0xE0A6) = 1 por
;   0xA85B[0] (27 bytes)
;   0xa699..0xa6b4  (27 bytes)
DATA_tira_A699:
	defb 08dh,0ech,002h,002h,002h,002h,002h,05eh,0feh,0adh,0ech,069h,068h,067h,066h,065h	; a699  .......^...ihgfe
	defb 065h,0feh,0cdh,0ech,087h,086h,085h,084h,083h,05ch,0ffh	; a6a9  e........\.

; ----------------------------------------------------------------------
; DATOS tira_A6B4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA691[1], p01:6576 con (0xE0A6) = 1 por
;   0xA85B[1] (27 bytes)
;   0xa6b4..0xa6cf  (27 bytes)
DATA_tira_A6B4:
	defb 08dh,0ech,002h,002h,002h,002h,002h,05fh,0feh,0adh,0ech,06eh,06dh,06ch,06bh,06ah	; a6b4  ......._...nmlkj
	defb 06ah,0feh,0cdh,0ech,08ch,08bh,08ah,089h,088h,05dh,0ffh	; a6c4  j........].

; ----------------------------------------------------------------------
; DATOS tira_A6CF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA691[2], p01:6576 con (0xE0A6) = 1 por
;   0xA85B[2] (31 bytes)
;   0xa6cf..0xa6ee  (31 bytes)
DATA_tira_A6CF:
	defb 08dh,0ech,002h,002h,002h,002h,002h,05eh,0feh,0adh,0ech,069h,068h,067h,066h,065h	; a6cf  .......^...ihgfe
	defb 065h,0feh,0cdh,0ech,087h,086h,085h,084h,083h,05ch,0feh,0f3h,0ech,076h,0ffh	; a6df  e........\...v.

; ----------------------------------------------------------------------
; DATOS tira_A6EE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA691[3], p01:6576 con (0xE0A6) = 1 por
;   0xA85B[3] (35 bytes)
;   0xa6ee..0xa711  (35 bytes)
DATA_tira_A6EE:
	defb 08dh,0ech,002h,002h,002h,002h,002h,05fh,0feh,0adh,0ech,06eh,06dh,06ch,06bh,06ah	; a6ee  ......._...nmlkj
	defb 06ah,0feh,0cdh,0ech,08ch,08bh,08ah,089h,088h,05dh,0feh,0ech,0ech,034h,0feh,0f3h	; a6fe  j........]...4..
	defb 0ech,076h,0ffh	; a70e

; ----------------------------------------------------------------------
; DATOS cuadros_A711: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa711..0xa719  (8 bytes)
DATA_cuadros_A711:
	defb 019h,0a7h	; a711
	defb 034h,0a7h	; a713
	defb 04fh,0a7h	; a715
	defb 06eh,0a7h	; a717

; ----------------------------------------------------------------------
; DATOS tira_A719: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA711[0], p01:6576 con (0xE0A6) = 2 por
;   0xA86F[0] (27 bytes)
;   0xa719..0xa734  (27 bytes)
DATA_tira_A719:
	defb 08dh,0ech,01ch,002h,002h,002h,002h,002h,0feh,0adh,0ech,023h,023h,024h,025h,026h	; a719  ...........##$%&
	defb 027h,0feh,0cdh,0ech,01ah,041h,042h,043h,044h,045h,0ffh	; a729  '....ABCDE.

; ----------------------------------------------------------------------
; DATOS tira_A734: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA711[1], p01:6576 con (0xE0A6) = 2 por
;   0xA86F[1] (27 bytes)
;   0xa734..0xa74f  (27 bytes)
DATA_tira_A734:
	defb 08dh,0ech,01dh,002h,002h,002h,002h,002h,0feh,0adh,0ech,028h,028h,029h,02ah,02bh	; a734  ...........(()*+
	defb 02ch,0feh,0cdh,0ech,01bh,046h,047h,048h,049h,04ah,0ffh	; a744  ,....FGHIJ.

; ----------------------------------------------------------------------
; DATOS tira_A74F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA711[2], p01:6576 con (0xE0A6) = 2 por
;   0xA86F[2] (31 bytes)
;   0xa74f..0xa76e  (31 bytes)
DATA_tira_A74F:
	defb 08dh,0ech,01ch,002h,002h,002h,002h,002h,0feh,0adh,0ech,023h,023h,024h,025h,026h	; a74f  ...........##$%&
	defb 027h,0feh,0cdh,0ech,01ah,041h,042h,043h,044h,045h,0feh,0ech,0ech,034h,0ffh	; a75f  '....ABCDE...4.

; ----------------------------------------------------------------------
; DATOS tira_A76E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA711[3], p01:6576 con (0xE0A6) = 2 por
;   0xA86F[3] (35 bytes)
;   0xa76e..0xa791  (35 bytes)
DATA_tira_A76E:
	defb 08dh,0ech,01dh,002h,002h,002h,002h,002h,0feh,0adh,0ech,028h,028h,029h,02ah,02bh	; a76e  ...........(()*+
	defb 02ch,0feh,0cdh,0ech,01bh,046h,047h,048h,049h,04ah,0feh,0ech,0ech,034h,0feh,0f3h	; a77e  ,....FGHIJ...4..
	defb 0ech,076h,0ffh	; a78e

; ----------------------------------------------------------------------
; DATOS cuadros_A791: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa791..0xa799  (8 bytes)
DATA_cuadros_A791:
	defb 099h,0a7h	; a791
	defb 0b1h,0a7h	; a793
	defb 0c8h,0a7h	; a795
	defb 0e0h,0a7h	; a797

; ----------------------------------------------------------------------
; DATOS tira_A799: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA791[0] (24 bytes)
;   0xa799..0xa7b1  (24 bytes)
DATA_tira_A799:
	defb 0cbh,0ech,080h,07fh,07eh,07dh,07ch,07bh,07ah,04fh,055h,04dh,0feh,0ebh,0ech,083h	; a799  ....~}|{zOUM....
	defb 001h,0feh,0f2h,0ech,082h,081h,057h,0ffh	; a7a9  ......W.

; ----------------------------------------------------------------------
; DATOS tira_A7B1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA791[1] (23 bytes)
;   0xa7b1..0xa7c8  (23 bytes)
DATA_tira_A7B1:
	defb 0cah,0ech,056h,088h,07fh,07eh,087h,086h,085h,084h,04dh,04dh,0feh,0ebh,0ech,08bh	; a7b1  ..V..~....MM....
	defb 001h,0feh,0f2h,0ech,08ah,089h,0ffh	; a7c1

; ----------------------------------------------------------------------
; DATOS tira_A7C8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA791[2] (24 bytes)
;   0xa7c8..0xa7e0  (24 bytes)
DATA_tira_A7C8:
	defb 0cah,0ech,003h,080h,07fh,07eh,07dh,07ch,07bh,07ah,04fh,055h,0feh,0eah,0ech,011h	; a7c8  .....~}|{zOU....
	defb 083h,001h,0feh,0f2h,0ech,082h,081h,0ffh	; a7d8  ........

; ----------------------------------------------------------------------
; DATOS tira_A7E0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA791[3] (22 bytes)
;   0xa7e0..0xa7f6  (22 bytes)
DATA_tira_A7E0:
	defb 0cbh,0ech,088h,07fh,07eh,087h,086h,085h,084h,04dh,04dh,0feh,0ebh,0ech,08ch,001h	; a7e0  ....~....MM.....
	defb 0feh,0f2h,0ech,08ah,089h,0ffh	; a7f0

; ----------------------------------------------------------------------
; DATOS cuadros_A7F6: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa7f6..0xa7fe  (8 bytes)
DATA_cuadros_A7F6:
	defb 0feh,0a7h	; a7f6
	defb 016h,0a8h	; a7f8
	defb 02dh,0a8h	; a7fa
	defb 045h,0a8h	; a7fc

; ----------------------------------------------------------------------
; DATOS tira_A7FE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA7F6[0] (24 bytes)
;   0xa7fe..0xa816  (24 bytes)
DATA_tira_A7FE:
	defb 0cbh,0ech,00ch,014h,00eh,039h,03ah,03bh,03ch,03dh,03eh,03fh,0feh,0ebh,0ech,016h	; a7fe  .....9:;<=>?....
	defb 040h,041h,0feh,0f3h,0ech,001h,042h,0ffh	; a80e  @A....B.

; ----------------------------------------------------------------------
; DATOS tira_A816: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA7F6[1] (23 bytes)
;   0xa816..0xa82d  (23 bytes)
DATA_tira_A816:
	defb 0cch,0ech,00ch,00ch,043h,044h,045h,046h,03dh,03eh,047h,015h,0feh,0ech,0ech,048h	; a816  ....CDEF=>G....H
	defb 049h,0feh,0f3h,0ech,001h,04ah,0ffh	; a826

; ----------------------------------------------------------------------
; DATOS tira_A82D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA7F6[2] (24 bytes)
;   0xa82d..0xa845  (24 bytes)
DATA_tira_A82D:
	defb 0cch,0ech,014h,00eh,039h,03ah,03bh,03ch,03dh,03eh,03fh,003h,0feh,0ech,0ech,040h	; a82d  ....9:;<=>?....@
	defb 041h,0feh,0f3h,0ech,001h,042h,052h,0ffh	; a83d  A....BR.

; ----------------------------------------------------------------------
; DATOS tira_A845: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA7F6[3] (22 bytes)
;   0xa845..0xa85b  (22 bytes)
DATA_tira_A845:
	defb 0cch,0ech,00ch,00ch,043h,044h,045h,046h,03dh,03eh,047h,0feh,0ech,0ech,048h,049h	; a845  ....CDEF=>G...HI
	defb 0feh,0f3h,0ech,001h,04bh,0ffh	; a855

; ----------------------------------------------------------------------
; DATOS cuadros_A85B: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa85b..0xa863  (8 bytes)
DATA_cuadros_A85B:
	defb 099h,0a6h	; a85b
	defb 0b4h,0a6h	; a85d
	defb 0cfh,0a6h	; a85f
	defb 0eeh,0a6h	; a861

; ----------------------------------------------------------------------
; DATOS guiones_vacios_A863: cuatro guiones de copia_bloques vacios, `80 EB
;   FF` -el destino 0xEB80 y el 0xFF que acaba- detras de la tabla de cuadros
;   de al lado. Ninguna palabra de la ROM apunta a ellos
;   0xa863..0xa86f  (12 bytes)
DATA_guiones_vacios_A863:
	defb 080h,0ebh,0ffh	; a863
	defb 080h,0ebh,0ffh	; a866
	defb 080h,0ebh,0ffh	; a869
	defb 080h,0ebh,0ffh	; a86c

; ----------------------------------------------------------------------
; DATOS cuadros_A86F: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa86f..0xa877  (8 bytes)
DATA_cuadros_A86F:
	defb 019h,0a7h	; a86f
	defb 034h,0a7h	; a871
	defb 04fh,0a7h	; a873
	defb 06eh,0a7h	; a875

; ----------------------------------------------------------------------
; DATOS guiones_vacios_A877: cuatro guiones de copia_bloques vacios, `80 EB
;   FF` -el destino 0xEB80 y el 0xFF que acaba- detras de la tabla de cuadros
;   de al lado. Ninguna palabra de la ROM apunta a ellos
;   0xa877..0xa883  (12 bytes)
DATA_guiones_vacios_A877:
	defb 080h,0ebh,0ffh	; a877
	defb 080h,0ebh,0ffh	; a87a
	defb 080h,0ebh,0ffh	; a87d
	defb 080h,0ebh,0ffh	; a880

; ----------------------------------------------------------------------
; DATOS cuadros_A883: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa883..0xa88b  (8 bytes)
DATA_cuadros_A883:
	defb 08bh,0a8h	; a883
	defb 0beh,0a8h	; a885
	defb 0f7h,0a8h	; a887
	defb 031h,0a9h	; a889

; ----------------------------------------------------------------------
; DATOS tira_A88B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA883[0] (51 bytes)
;   0xa88b..0xa8be  (51 bytes)
DATA_tira_A88B:
	defb 0c0h,0ech,041h,041h,041h,090h,08fh,08ch,0feh,0c7h,0ech,08ah,08bh,0feh,0cah,0ech	; a88b  ..AAA...........
	defb 08eh,08eh,08eh,08eh,08dh,001h,08ch,001h,088h,087h,001h,001h,0feh,0d7h,0ech,001h	; a89b  ................
	defb 01fh,0feh,0dah,0ech,001h,001h,001h,001h,001h,001h,0feh,0edh,0ech,001h,0feh,0f3h	; a8ab  ................
	defb 0ech,05dh,0ffh	; a8bb

; ----------------------------------------------------------------------
; DATOS tira_A8BE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA883[1] (57 bytes)
;   0xa8be..0xa8f7  (57 bytes)
DATA_tira_A8BE:
	defb 0c0h,0ech,08eh,08eh,08eh,043h,00ch,001h,098h,095h,094h,09ch,09ch,09ch,09ch,04eh	; a8be  .....C.........N
	defb 09bh,09ah,099h,098h,001h,001h,092h,063h,001h,001h,001h,001h,0feh,0dbh,0ech,00bh	; a8ce  .......c........
	defb 001h,001h,001h,001h,0feh,0e7h,0ech,064h,011h,0feh,0ebh,0ech,001h,001h,0feh,0f3h	; a8de  .......d........
	defb 0ech,001h,093h,0feh,0f7h,0ech,001h,001h,0ffh	; a8ee  .........

; ----------------------------------------------------------------------
; DATOS tira_A8F7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA883[2] (58 bytes)
;   0xa8f7..0xa931  (58 bytes)
DATA_tira_A8F7:
	defb 0c0h,0ech,09ch,0a8h,09ch,08dh,086h,001h,096h,023h,026h,065h,04fh,04fh,04fh,04fh	; a8f7  .........#&eOOOO
	defb 040h,0a5h,001h,0a4h,0a3h,001h,001h,018h,073h,070h,001h,001h,0feh,0dbh,0ech,001h	; a907  @.......sp......
	defb 001h,001h,01ch,001h,0feh,0e7h,0ech,0a6h,09fh,09eh,001h,001h,0feh,0efh,0ech,001h	; a917  ................
	defb 0feh,0f3h,0ech,001h,001h,051h,052h,059h,001h,0ffh	; a927  .....QRY..

; ----------------------------------------------------------------------
; DATOS tira_A931: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xA883[3] (45 bytes)
;   0xa931..0xa95e  (45 bytes)
DATA_tira_A931:
	defb 0c0h,0ech,04fh,04fh,04fh,04fh,039h,03fh,088h,02ch,0feh,0cah,0ech,041h,041h,041h	; a931  ..OOOO9?.,...AAA
	defb 041h,043h,097h,083h,001h,079h,03bh,001h,001h,0feh,0d8h,0ech,001h,001h,001h,001h	; a941  AC...y;.........
	defb 001h,001h,001h,001h,0feh,0ech,0ech,001h,0feh,0f3h,0ech,001h,0ffh	; a951  .............

; ----------------------------------------------------------------------
; DATOS cuadros_A95E: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xa95e..0xa966  (8 bytes)
DATA_cuadros_A95E:
	defb 066h,0a9h	; a95e
	defb 095h,0a9h	; a960
	defb 0cdh,0a9h	; a962
	defb 003h,0aah	; a964

; ----------------------------------------------------------------------
; DATOS tira_A966: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA95E[0] (47 bytes)
;   0xa966..0xa995  (47 bytes)
DATA_tira_A966:
	defb 0c0h,0ech,001h,001h,001h,001h,001h,001h,0feh,0c7h,0ech,06ch,001h,0feh,0cah,0ech	; a966  ...........l....
	defb 001h,001h,03ah,03bh,001h,03fh,001h,040h,041h,041h,041h,041h,0feh,0d7h,0ech,03eh	; a976  ..:;.?.@AAAA...>
	defb 03dh,0feh,0dah,0ech,03fh,042h,043h,08eh,08eh,08eh,0feh,0ech,0ech,010h,0ffh	; a986  =...?BC........

; ----------------------------------------------------------------------
; DATOS tira_A995: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA95E[1] (56 bytes)
;   0xa995..0xa9cd  (56 bytes)
DATA_tira_A995:
	defb 0c0h,0ech,001h,001h,001h,001h,00bh,0feh,0c6h,0ech,001h,001h,001h,001h,016h,045h	; a995  ...............E
	defb 001h,001h,04bh,04ch,04dh,04eh,09bh,04fh,04fh,04fh,04fh,047h,048h,04bh,001h,00ch	; a9a5  ..KLMN.OOOOGHK..
	defb 090h,041h,041h,041h,0feh,0e7h,0ech,001h,001h,0feh,0ebh,0ech,046h,001h,0feh,0f4h	; a9b5  .AAA........F...
	defb 0ech,001h,0feh,0f7h,0ech,05eh,017h,0ffh	; a9c5  .....^..

; ----------------------------------------------------------------------
; DATOS tira_A9CD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA95E[2] (54 bytes)
;   0xa9cd..0xaa03  (54 bytes)
DATA_tira_A9CD:
	defb 0c0h,0ech,001h,069h,001h,001h,001h,0feh,0c6h,0ech,001h,001h,023h,026h,065h,001h	; a9cd  ...i........#&e.
	defb 001h,056h,057h,001h,058h,08dh,09ch,09ch,09ch,09ch,018h,073h,070h,049h,001h,039h	; a9dd  .VW.X......spI.9
	defb 040h,04fh,05bh,04fh,0feh,0e7h,0ech,001h,0a6h,09fh,09eh,001h,001h,0feh,0f4h,0ech	; a9ed  @O[O............
	defb 001h,001h,051h,052h,059h,0ffh	; a9fd

; ----------------------------------------------------------------------
; DATOS tira_AA03: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xA95E[3] (41 bytes)
;   0xaa03..0xaa2c  (41 bytes)
DATA_tira_AA03:
	defb 0c0h,0ech,001h,001h,001h,001h,001h,001h,001h,001h,0feh,0cah,0ech,001h,001h,088h	; aa03  ................
	defb 02ch,001h,036h,04ah,090h,08eh,08eh,08eh,08eh,0feh,0d8h,0ech,079h,03bh,08ch,086h	; aa13  ,.6J........y;..
	defb 09ch,09ch,09ch,09ch,0feh,0ech,0ech,001h,0ffh	; aa23  .........

; ----------------------------------------------------------------------
; DATOS cuadros_AA2C: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xaa2c..0xaa34  (8 bytes)
DATA_cuadros_AA2C:
	defb 034h,0aah	; aa2c
	defb 070h,0aah	; aa2e
	defb 034h,0aah	; aa30
	defb 070h,0aah	; aa32

; ----------------------------------------------------------------------
; DATOS tira_AA34: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 2 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xAA2C[0],
;   p01:6576 con (0xE0A6) = 1 por 0xAA2C[2] (60 bytes)
;   0xaa34..0xaa70  (60 bytes)
DATA_tira_AA34:
	defb 0ech,0ebh,06ah,043h,09ch,09bh,043h,043h,092h,0feh,00dh,0ech,06ah,099h,09ah,043h	; aa34  ..jC..CC....j..C
	defb 043h,0feh,02eh,0ech,097h,098h,043h,092h,0feh,04eh,0ech,095h,096h,043h,0feh,06eh	; aa44  C.....C..N...C.n
	defb 0ech,093h,042h,094h,0feh,08dh,0ech,0a9h,0a0h,003h,0a1h,0feh,0adh,0ech,003h,0a2h	; aa54  ..B.............
	defb 0a6h,0a7h,08dh,0feh,0cdh,0ech,097h,09ah,09bh,09ch,091h,0ffh	; aa64  ............

; ----------------------------------------------------------------------
; DATOS tira_AA70: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xAA2C[1],
;   p01:6576 con (0xE0A6) = 1 por 0xAA2C[3] (60 bytes)
;   0xaa70..0xaaac  (60 bytes)
DATA_tira_AA70:
	defb 0ech,0ebh,06dh,043h,09ch,09bh,043h,043h,08fh,0feh,00dh,0ech,06dh,099h,09ah,043h	; aa70  ..mC..CC....m..C
	defb 043h,0feh,02eh,0ech,097h,098h,043h,08fh,0feh,04eh,0ech,095h,096h,043h,0feh,06eh	; aa80  C.....C..N...C.n
	defb 0ech,093h,042h,094h,0feh,08dh,0ech,0a9h,0a0h,003h,0a1h,0feh,0adh,0ech,003h,0a2h	; aa90  ..B.............
	defb 0a6h,0a8h,08bh,0feh,0cdh,0ech,097h,09ah,09dh,09eh,09fh,0ffh	; aaa0  ............

; ----------------------------------------------------------------------
; DATOS cuadros_AAAC: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xaaac..0xaab4  (8 bytes)
DATA_cuadros_AAAC:
	defb 0b4h,0aah	; aaac
	defb 0f0h,0aah	; aaae
	defb 0b4h,0aah	; aab0
	defb 0f0h,0aah	; aab2

; ----------------------------------------------------------------------
; DATOS tira_AAB4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 2 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xAAAC[0],
;   p01:6576 con (0xE0A6) = 2 por 0xAAAC[2] (60 bytes)
;   0xaab4..0xaaf0  (60 bytes)
DATA_tira_AAB4:
	defb 0edh,0ebh,06dh,043h,043h,076h,077h,043h,08fh,0feh,00eh,0ech,043h,043h,075h,074h	; aab4  ..mCCvwC....CCut
	defb 08fh,0feh,02eh,0ech,06dh,043h,073h,072h,0feh,04fh,0ech,043h,071h,070h,0feh,06fh	; aac4  ....mCsr.O.Cqp.o
	defb 0ech,06fh,042h,06eh,0feh,08fh,0ech,052h,003h,051h,05ah,0feh,0aeh,0ech,03eh,058h	; aad4  .oBn...R.QZ...>X
	defb 057h,053h,003h,0feh,0ceh,0ech,042h,04dh,04ch,04bh,048h,0ffh	; aae4  WS....BMLKH.

; ----------------------------------------------------------------------
; DATOS tira_AAF0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xAAAC[1],
;   p01:6576 con (0xE0A6) = 2 por 0xAAAC[3] (60 bytes)
;   0xaaf0..0xab2c  (60 bytes)
DATA_tira_AAF0:
	defb 0edh,0ebh,06ah,043h,043h,076h,077h,043h,092h,0feh,00eh,0ech,043h,043h,075h,074h	; aaf0  ..jCCvwC....CCut
	defb 092h,0feh,02eh,0ech,06ah,043h,073h,072h,0feh,04fh,0ech,043h,071h,070h,0feh,06fh	; ab00  ....jCsr.O.Cqp.o
	defb 0ech,06fh,042h,06eh,0feh,08fh,0ech,052h,003h,051h,05ah,0feh,0aeh,0ech,03ch,059h	; ab10  .oBn...R.QZ...<Y
	defb 057h,053h,003h,0feh,0ceh,0ech,050h,04fh,04eh,04bh,048h,0ffh	; ab20  WS....PONKH.

; ----------------------------------------------------------------------
; DATOS cuadros_AB2C: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xab2c..0xab34  (8 bytes)
DATA_cuadros_AB2C:
	defb 034h,0abh	; ab2c
	defb 04dh,0abh	; ab2e
	defb 034h,0abh	; ab30
	defb 04dh,0abh	; ab32

; ----------------------------------------------------------------------
; DATOS tira_AB34: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 2 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xAB2C[0],
;   p01:6576 con (0xE0A6) = 1 por 0xAB2C[2] (25 bytes)
;   0xab34..0xab4d  (25 bytes)
DATA_tira_AB34:
	defb 08dh,0ech,023h,0feh,091h,0ech,024h,0feh,0adh,0ech,025h,025h,025h,026h,027h,0feh	; ab34  ..#...$...%%%&'.
	defb 0cdh,0ech,035h,036h,03eh,03fh,040h,041h,0ffh	; ab44  ..56>?@A.

; ----------------------------------------------------------------------
; DATOS tira_AB4D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xAB2C[1],
;   p01:6576 con (0xE0A6) = 1 por 0xAB2C[3] (18 bytes)
;   0xab4d..0xab5f  (18 bytes)
DATA_tira_AB4D:
	defb 0adh,0ech,01fh,01fh,01fh,020h,021h,022h,0feh,0cdh,0ech,037h,036h,03eh,042h,043h	; ab4d  ..... !"...76>BC
	defb 044h,0ffh	; ab5d

; ----------------------------------------------------------------------
; DATOS cuadros_AB5F: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xab5f..0xab67  (8 bytes)
DATA_cuadros_AB5F:
	defb 067h,0abh	; ab5f
	defb 080h,0abh	; ab61
	defb 067h,0abh	; ab63
	defb 080h,0abh	; ab65

; ----------------------------------------------------------------------
; DATOS tira_AB67: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 2 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xAB5F[0],
;   p01:6576 con (0xE0A6) = 2 por 0xAB5F[2] (25 bytes)
;   0xab67..0xab80  (25 bytes)
DATA_tira_AB67:
	defb 08eh,0ech,06fh,0feh,092h,0ech,06eh,0feh,0aeh,0ech,072h,071h,070h,070h,070h,0feh	; ab67  ..o...n...rqppp.
	defb 0cdh,0ech,08ch,08bh,08ah,089h,081h,080h,0ffh	; ab77  .........

; ----------------------------------------------------------------------
; DATOS tira_AB80: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xAB5F[1],
;   p01:6576 con (0xE0A6) = 2 por 0xAB5F[3] (18 bytes)
;   0xab80..0xab92  (18 bytes)
DATA_tira_AB80:
	defb 0adh,0ech,06dh,06ch,06bh,06ah,06ah,06ah,0feh,0cdh,0ech,08fh,08eh,08dh,089h,081h	; ab80  ..mlkjjj........
	defb 082h,0ffh	; ab90

; ----------------------------------------------------------------------
; DATOS cuadros_AB92: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xab92..0xab9a  (8 bytes)
DATA_cuadros_AB92:
	defb 09ah,0abh	; ab92
	defb 0adh,0abh	; ab94
	defb 09ah,0abh	; ab96
	defb 0adh,0abh	; ab98

; ----------------------------------------------------------------------
; DATOS tira_AB9A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 2 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xAB92[0],
;   p01:6576 con (0xE0A6) = 1 por 0xAB92[2] (19 bytes)
;   0xab9a..0xabad  (19 bytes)
DATA_tira_AB9A:
	defb 0cch,0ech,087h,088h,085h,057h,053h,052h,051h,0feh,0ech,0ech,03fh,001h,0feh,0f2h	; ab9a  .....WSRQ...?...
	defb 0ech,04dh,0ffh	; abaa

; ----------------------------------------------------------------------
; DATOS tira_ABAD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 1 por 0xAB92[1],
;   p01:6576 con (0xE0A6) = 1 por 0xAB92[3] (19 bytes)
;   0xabad..0xabc0  (19 bytes)
DATA_tira_ABAD:
	defb 0cch,0ech,086h,088h,085h,057h,056h,055h,054h,0feh,0ech,0ech,081h,001h,0feh,0f2h	; abad  .....WVUT.......
	defb 0ech,04dh,0ffh	; abbd

; ----------------------------------------------------------------------
; DATOS cuadros_ABC0: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xabc0..0xabc8  (8 bytes)
DATA_cuadros_ABC0:
	defb 0c8h,0abh	; abc0
	defb 0dbh,0abh	; abc2
	defb 0c8h,0abh	; abc4
	defb 0dbh,0abh	; abc6

; ----------------------------------------------------------------------
; DATOS tira_ABC8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo; cuadro 2 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xABC0[0],
;   p01:6576 con (0xE0A6) = 2 por 0xABC0[2] (19 bytes)
;   0xabc8..0xabdb  (19 bytes)
DATA_tira_ABC8:
	defb 0cdh,0ech,011h,012h,013h,017h,045h,048h,047h,0feh,0edh,0ech,00dh,0feh,0f2h,0ech	; abc8  ......EHG.......
	defb 001h,07fh,0ffh	; abd8

; ----------------------------------------------------------------------
; DATOS tira_ABDB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo; cuadro 3 de la animacion del fondo)
;   que lee copia_bloques; lo cargan p01:6576 con (0xE0A6) = 2 por 0xABC0[1],
;   p01:6576 con (0xE0A6) = 2 por 0xABC0[3] (19 bytes)
;   0xabdb..0xabee  (19 bytes)
DATA_tira_ABDB:
	defb 0cdh,0ech,014h,015h,016h,017h,045h,048h,046h,0feh,0edh,0ech,00dh,0feh,0f2h,0ech	; abdb  ......EHF.......
	defb 001h,041h,0ffh	; abeb

; ----------------------------------------------------------------------
; DATOS cuadros_ABEE: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xabee..0xabf6  (8 bytes)
DATA_cuadros_ABEE:
	defb 0f6h,0abh	; abee
	defb 0f9h,0abh	; abf0
	defb 0fch,0abh	; abf2
	defb 0ffh,0abh	; abf4

; ----------------------------------------------------------------------
; DATOS tira_ABF6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xABEE[0] (3 bytes)
;   0xabf6..0xabf9  (3 bytes)
DATA_tira_ABF6:
	defb 080h,0ebh,0ffh	; abf6

; ----------------------------------------------------------------------
; DATOS tira_ABF9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xABEE[1] (3 bytes)
;   0xabf9..0xabfc  (3 bytes)
DATA_tira_ABF9:
	defb 080h,0ebh,0ffh	; abf9

; ----------------------------------------------------------------------
; DATOS tira_ABFC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xABEE[2] (3 bytes)
;   0xabfc..0xabff  (3 bytes)
DATA_tira_ABFC:
	defb 080h,0ebh,0ffh	; abfc

; ----------------------------------------------------------------------
; DATOS tira_ABFF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 1 por 0xABEE[3] (3 bytes)
;   0xabff..0xac02  (3 bytes)
DATA_tira_ABFF:
	defb 080h,0ebh,0ffh	; abff

; ----------------------------------------------------------------------
; DATOS cuadros_AC02: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0xac02..0xac0a  (8 bytes)
DATA_cuadros_AC02:
	defb 00ah,0ach	; ac02
	defb 00dh,0ach	; ac04
	defb 010h,0ach	; ac06
	defb 013h,0ach	; ac08

; ----------------------------------------------------------------------
; DATOS tira_AC0A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xAC02[0] (3 bytes)
;   0xac0a..0xac0d  (3 bytes)
DATA_tira_AC0A:
	defb 080h,0ebh,0ffh	; ac0a

; ----------------------------------------------------------------------
; DATOS tira_AC0D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xAC02[1] (3 bytes)
;   0xac0d..0xac10  (3 bytes)
DATA_tira_AC0D:
	defb 080h,0ebh,0ffh	; ac0d

; ----------------------------------------------------------------------
; DATOS tira_AC10: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xAC02[2] (3 bytes)
;   0xac10..0xac13  (3 bytes)
DATA_tira_AC10:
	defb 080h,0ebh,0ffh	; ac10

; ----------------------------------------------------------------------
; DATOS tira_AC13: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:6576 con (0xE0A6) = 2 por 0xAC02[3] (3 bytes)
;   0xac13..0xac16  (3 bytes)
DATA_tira_AC13:
	defb 080h,0ebh,0ffh	; ac13

; ----------------------------------------------------------------------
; DATOS fila_por_decorado: diez punteros, uno por decorado (0xE0A1), a una
;   fila de 32 bytes que p01:61E1 copia con ldir a 0xE510 y de ahi a 0xECA0.
;   Los decorados 5 a 9 apuntan a 0xAC8A, que es la tabla de distancias de las
;   fases: esos 32 bytes los leen las dos rutinas
;   0xac16..0xac2a  (20 bytes)
DATA_fila_por_decorado:
	defb 02ah,0ach	; ac16
	defb 04ah,0ach	; ac18
	defb 04ah,0ach	; ac1a
	defb 06ah,0ach	; ac1c
	defb 06ah,0ach	; ac1e
	defb 08ah,0ach	; ac20
	defb 08ah,0ach	; ac22
	defb 08ah,0ach	; ac24
	defb 08ah,0ach	; ac26
	defb 08ah,0ach	; ac28

; ----------------------------------------------------------------------
; DATOS fila_de_decorado_AC2A: 32 bytes que p01:61F1 copia a 0xE510 para los
;   decorados 0
;   0xac2a..0xac4a  (32 bytes)
DATA_fila_de_decorado_AC2A:
	defb 002h,002h,002h,002h,00ch,00dh,00eh,00fh,010h,011h,010h,011h,012h,002h,002h,002h	; ac2a  ................
	defb 002h,002h,002h,002h,00ch,00dh,00eh,00fh,010h,011h,010h,011h,012h,002h,002h,002h	; ac3a  ................

; ----------------------------------------------------------------------
; DATOS fila_de_decorado_AC4A: 32 bytes que p01:61F1 copia a 0xE510 para los
;   decorados 1, 2
;   0xac4a..0xac6a  (32 bytes)
DATA_fila_de_decorado_AC4A:
	defb 002h,002h,00bh,008h,009h,00ah,008h,00ah,007h,008h,009h,00ah,04ch,002h,002h,002h	; ac4a  ............L...
	defb 002h,002h,002h,00bh,008h,009h,00ah,008h,00ah,007h,008h,009h,00ah,04ch,002h,002h	; ac5a  .............L..

; ----------------------------------------------------------------------
; DATOS fila_de_decorado_AC6A: 32 bytes que p01:61F1 copia a 0xE510 para los
;   decorados 3, 4
;   0xac6a..0xac8a  (32 bytes)
DATA_fila_de_decorado_AC6A:
	defb 004h,004h,004h,078h,005h,006h,007h,008h,005h,006h,007h,02bh,004h,004h,004h,004h	; ac6a  ...x.......+....
	defb 004h,004h,004h,004h,078h,005h,006h,007h,008h,005h,006h,007h,02bh,004h,004h,004h	; ac7a  ....x.......+...

; ----------------------------------------------------------------------
; DATOS distancia_de_salida_por_fase: 24 palabras, una por fase: p01:6456 la
;   pone en 0xE301 (la distancia a la que toca el objeto siguiente). Sus
;   primeros 32 bytes son tambien la fila que p01:61E1 copia para los
;   decorados 5 a 9
;   0xac8a..0xacba  (48 bytes)
DATA_distancia_de_salida_por_fase:
	defb 0ffh,0ffh	; ac8a
	defb 0ffh,0ffh	; ac8c
	defb 080h,005h	; ac8e
	defb 0ffh,0ffh	; ac90
	defb 080h,003h	; ac92
	defb 060h,005h	; ac94
	defb 020h,007h	; ac96
	defb 030h,005h	; ac98
	defb 000h,006h	; ac9a
	defb 050h,006h	; ac9c
	defb 070h,006h	; ac9e
	defb 060h,007h	; aca0
	defb 090h,004h	; aca2
	defb 060h,005h	; aca4
	defb 060h,007h	; aca6
	defb 040h,010h	; aca8
	defb 090h,005h	; acaa
	defb 000h,010h	; acac
	defb 050h,011h	; acae
	defb 060h,007h	; acb0
	defb 050h,013h	; acb2
	defb 060h,012h	; acb4
	defb 000h,009h	; acb6
	defb 060h,013h	; acb8

; ----------------------------------------------------------------------
; DATOS largo_de_cada_fase: 24 entradas de 4 bytes, una por fase: el byte bajo
;   y el nibble bajo del siguiente son los doce bits del TIEMPO que queda
;   (0xE08B), y el nibble alto va aparte; la leen p00:47BA y p01:6217
;   0xacba..0xad1a  (96 bytes)
DATA_largo_de_cada_fase:
	defb 000h,032h,000h,006h	; acba
	defb 000h,062h,000h,006h	; acbe
	defb 050h,002h,000h,008h	; acc2
	defb 050h,051h,000h,005h	; acc6
	defb 050h,071h,000h,005h	; acca
	defb 000h,022h,000h,006h	; acce
	defb 050h,002h,000h,008h	; acd2
	defb 000h,042h,000h,006h	; acd6
	defb 050h,012h,000h,007h	; acda
	defb 000h,072h,000h,007h	; acde
	defb 000h,052h,000h,007h	; ace2
	defb 050h,002h,000h,009h	; ace6
	defb 000h,012h,000h,007h	; acea
	defb 000h,062h,000h,006h	; acee
	defb 000h,022h,000h,008h	; acf2
	defb 000h,063h,000h,011h	; acf6
	defb 000h,052h,000h,007h	; acfa
	defb 000h,033h,000h,011h	; acfe
	defb 000h,073h,000h,012h	; ad02
	defb 000h,042h,000h,008h	; ad06
	defb 030h,023h,000h,014h	; ad0a
	defb 000h,063h,000h,013h	; ad0e
	defb 050h,072h,000h,010h	; ad12
	defb 000h,003h,000h,014h	; ad16

; ----------------------------------------------------------------------
; DATOS salida_por_decorado: diez entradas de 3 bytes, una por decorado (o la
;   9 a partir de la segunda vuelta, p01:6273): la Y en pantalla de lo que se
;   maneja (0xE204) y por donde va la rotacion de sus sprites (0xE203),
;   p01:627A
;   0xad1a..0xad38  (30 bytes)
DATA_salida_por_decorado:
	defb 090h,070h,000h	; ad1a
	defb 090h,070h,000h	; ad1d
	defb 090h,070h,000h	; ad20
	defb 090h,070h,000h	; ad23
	defb 0a0h,070h,005h	; ad26
	defb 0a0h,070h,005h	; ad29
	defb 090h,070h,000h	; ad2c
	defb 090h,070h,009h	; ad2f
	defb 070h,070h,019h	; ad32
	defb 092h,070h,00ch	; ad35

; ----------------------------------------------------------------------
; DATOS copia_a_E570: 48 bytes que p01:6303 copia de un tiron con ldir a
;   0xE570
;   0xad38..0xad68  (48 bytes)
DATA_copia_a_E570:
	defb 020h,002h,0efh,0ebh,018h,002h,01ch,0ech,010h,002h,024h,0ech,018h,002h,02ah,0ech	; ad38   .........$...*.
	defb 008h,002h,052h,0ech,000h,0f3h,09ah,0ech,000h,0f3h,0a4h,0ech,010h,0f1h,0d0h,0ech	; ad48  ..R.............
	defb 020h,0f1h,0d7h,0ech,008h,0f1h,0e9h,0ech,010h,0f1h,0feh,0ech,018h,0f1h,013h,0edh	; ad58   ...............

; ----------------------------------------------------------------------
; DATOS atributos_de_sprite_iniciales: los atributos de los 32 sprites (Y, X,
;   patron, color): p01:6337 copia los 128 bytes con ldir a 0xEE80, la tabla
;   de atributos en RAM
;   0xad68..0xade8  (128 bytes)
DATA_atributos_de_sprite_iniciales:
	defb 0e0h,000h,000h,001h	; ad68
	defb 0e0h,000h,000h,001h	; ad6c
	defb 0e0h,000h,000h,001h	; ad70
	defb 0e0h,000h,000h,001h	; ad74
	defb 0e0h,000h,000h,000h	; ad78
	defb 0e0h,000h,000h,000h	; ad7c
	defb 0e0h,000h,07ch,00ah	; ad80
	defb 0e0h,000h,000h,000h	; ad84
	defb 0e0h,000h,078h,00dh	; ad88
	defb 0e0h,000h,084h,00dh	; ad8c
	defb 0e0h,000h,000h,008h	; ad90
	defb 0e0h,000h,000h,000h	; ad94
	defb 0e0h,000h,000h,000h	; ad98
	defb 0e0h,000h,000h,000h	; ad9c
	defb 0e0h,000h,000h,000h	; ada0
	defb 0e0h,000h,000h,000h	; ada4
	defb 0e0h,000h,000h,000h	; ada8
	defb 0e0h,000h,028h,007h	; adac
	defb 0e0h,000h,030h,004h	; adb0
	defb 0e0h,000h,030h,004h	; adb4
	defb 0e0h,000h,040h,001h	; adb8
	defb 0e0h,000h,040h,001h	; adbc
	defb 0e0h,000h,040h,001h	; adc0
	defb 0e0h,000h,000h,000h	; adc4
	defb 0e0h,000h,000h,000h	; adc8
	defb 0e0h,000h,000h,000h	; adcc
	defb 0e0h,000h,000h,000h	; add0
	defb 0e0h,000h,000h,000h	; add4
	defb 0e0h,000h,000h,000h	; add8
	defb 0e0h,000h,000h,000h	; addc
	defb 0e0h,000h,000h,000h	; ade0
	defb 0e0h,000h,000h,000h	; ade4

; ----------------------------------------------------------------------
; DATOS segundo_guion_por_fase: 24 punteros, uno por fase, al segundo guion
;   (el_segundo_guion, p01:66DA): lo que pasa a cada distancia
;   0xade8..0xae18  (48 bytes)
DATA_segundo_guion_por_fase:
	defb 018h,0aeh	; ade8
	defb 01bh,0aeh	; adea
	defb 01eh,0aeh	; adec
	defb 02dh,0aeh	; adee
	defb 042h,0aeh	; adf0
	defb 045h,0aeh	; adf2
	defb 05ah,0aeh	; adf4
	defb 075h,0aeh	; adf6
	defb 078h,0aeh	; adf8
	defb 087h,0aeh	; adfa
	defb 096h,0aeh	; adfc
	defb 0b1h,0aeh	; adfe
	defb 0cch,0aeh	; ae00
	defb 0e7h,0aeh	; ae02
	defb 002h,0afh	; ae04
	defb 011h,0afh	; ae06
	defb 026h,0afh	; ae08
	defb 03bh,0afh	; ae0a
	defb 062h,0afh	; ae0c
	defb 089h,0afh	; ae0e
	defb 09eh,0afh	; ae10
	defb 0cbh,0afh	; ae12
	defb 0f2h,0afh	; ae14
	defb 019h,0b0h	; ae16

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_1: el segundo guion de la fase 1: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae18..0xae1b  (3 bytes)
DATA_segundo_guion_fase_1:
	defb 0ffh,0ffh,000h	; ae18

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_2: el segundo guion de la fase 2: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae1b..0xae1e  (3 bytes)
DATA_segundo_guion_fase_2:
	defb 0ffh,0ffh,000h	; ae1b

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_3: el segundo guion de la fase 3: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae1e..0xae2d  (15 bytes)
DATA_segundo_guion_fase_3:
	defb 000h,005h,000h	; ae1e
	defb 004h,004h,002h	; ae21
	defb 036h,002h,000h	; ae24
	defb 008h,001h,001h	; ae27
	defb 0ffh,0ffh,000h	; ae2a

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_4: el segundo guion de la fase 4: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae2d..0xae42  (21 bytes)
DATA_segundo_guion_fase_4:
	defb 050h,003h,000h	; ae2d
	defb 018h,003h,002h	; ae30
	defb 050h,002h,000h	; ae33
	defb 018h,002h,002h	; ae36
	defb 000h,002h,000h	; ae39
	defb 036h,001h,001h	; ae3c
	defb 0ffh,0ffh,000h	; ae3f

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_5: el segundo guion de la fase 5: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae42..0xae45  (3 bytes)
DATA_segundo_guion_fase_5:
	defb 0ffh,0ffh,000h	; ae42

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_6: el segundo guion de la fase 6: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae45..0xae5a  (21 bytes)
DATA_segundo_guion_fase_6:
	defb 064h,004h,000h	; ae45
	defb 000h,004h,001h	; ae48
	defb 064h,002h,000h	; ae4b
	defb 000h,002h,002h	; ae4e
	defb 032h,001h,000h	; ae51
	defb 000h,001h,001h	; ae54
	defb 0ffh,0ffh,000h	; ae57

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_7: el segundo guion de la fase 7: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae5a..0xae75  (27 bytes)
DATA_segundo_guion_fase_7:
	defb 064h,006h,000h	; ae5a
	defb 000h,006h,001h	; ae5d
	defb 032h,004h,000h	; ae60
	defb 036h,003h,002h	; ae63
	defb 010h,002h,000h	; ae66
	defb 046h,001h,001h	; ae69
	defb 040h,001h,000h	; ae6c
	defb 008h,001h,001h	; ae6f
	defb 0ffh,0ffh,000h	; ae72

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_8: el segundo guion de la fase 8: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae75..0xae78  (3 bytes)
DATA_segundo_guion_fase_8:
	defb 0ffh,0ffh,000h	; ae75

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_9: el segundo guion de la fase 9: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae78..0xae87  (15 bytes)
DATA_segundo_guion_fase_9:
	defb 032h,005h,000h	; ae78
	defb 068h,004h,002h	; ae7b
	defb 032h,002h,000h	; ae7e
	defb 036h,001h,001h	; ae81
	defb 0ffh,0ffh,000h	; ae84

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_10: el segundo guion de la fase 10: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae87..0xae96  (15 bytes)
DATA_segundo_guion_fase_10:
	defb 050h,004h,000h	; ae87
	defb 090h,002h,002h	; ae8a
	defb 050h,002h,000h	; ae8d
	defb 022h,001h,001h	; ae90
	defb 0ffh,0ffh,000h	; ae93

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_11: el segundo guion de la fase 11: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xae96..0xaeb1  (27 bytes)
DATA_segundo_guion_fase_11:
	defb 000h,005h,000h	; ae96
	defb 036h,004h,001h	; ae99
	defb 032h,004h,000h	; ae9c
	defb 036h,003h,002h	; ae9f
	defb 064h,002h,000h	; aea2
	defb 000h,002h,001h	; aea5
	defb 086h,001h,000h	; aea8
	defb 022h,001h,002h	; aeab
	defb 0ffh,0ffh,000h	; aeae

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_12: el segundo guion de la fase 12: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaeb1..0xaecc  (27 bytes)
DATA_segundo_guion_fase_12:
	defb 000h,007h,000h	; aeb1
	defb 036h,006h,001h	; aeb4
	defb 032h,006h,000h	; aeb7
	defb 036h,005h,002h	; aeba
	defb 080h,003h,000h	; aebd
	defb 052h,002h,001h	; aec0
	defb 050h,002h,000h	; aec3
	defb 022h,001h,002h	; aec6
	defb 0ffh,0ffh,000h	; aec9

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_13: el segundo guion de la fase 13: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaecc..0xaee7  (27 bytes)
DATA_segundo_guion_fase_13:
	defb 000h,006h,000h	; aecc
	defb 004h,005h,001h	; aecf
	defb 032h,003h,000h	; aed2
	defb 068h,002h,001h	; aed5
	defb 060h,002h,000h	; aed8
	defb 028h,002h,002h	; aedb
	defb 068h,001h,000h	; aede
	defb 004h,001h,001h	; aee1
	defb 0ffh,0ffh,000h	; aee4

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_14: el segundo guion de la fase 14: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaee7..0xaf02  (27 bytes)
DATA_segundo_guion_fase_14:
	defb 064h,004h,000h	; aee7
	defb 000h,004h,002h	; aeea
	defb 080h,003h,000h	; aeed
	defb 048h,003h,001h	; aef0
	defb 000h,003h,000h	; aef3
	defb 036h,002h,002h	; aef6
	defb 032h,002h,000h	; aef9
	defb 068h,001h,001h	; aefc
	defb 0ffh,0ffh,000h	; aeff

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_15: el segundo guion de la fase 15: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf02..0xaf11  (15 bytes)
DATA_segundo_guion_fase_15:
	defb 020h,007h,000h	; af02
	defb 092h,005h,002h	; af05
	defb 028h,003h,000h	; af08
	defb 000h,002h,001h	; af0b
	defb 0ffh,0ffh,000h	; af0e

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_16: el segundo guion de la fase 16: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf11..0xaf26  (21 bytes)
DATA_segundo_guion_fase_16:
	defb 028h,007h,000h	; af11
	defb 000h,006h,002h	; af14
	defb 090h,005h,000h	; af17
	defb 026h,005h,001h	; af1a
	defb 041h,003h,000h	; af1d
	defb 049h,001h,002h	; af20
	defb 0ffh,0ffh,000h	; af23

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_17: el segundo guion de la fase 17: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf26..0xaf3b  (21 bytes)
DATA_segundo_guion_fase_17:
	defb 076h,006h,000h	; af26
	defb 080h,005h,002h	; af29
	defb 016h,005h,000h	; af2c
	defb 020h,004h,001h	; af2f
	defb 036h,003h,000h	; af32
	defb 080h,000h,002h	; af35
	defb 0ffh,0ffh,000h	; af38

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_18: el segundo guion de la fase 18: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf3b..0xaf62  (39 bytes)
DATA_segundo_guion_fase_18:
	defb 014h,009h,000h	; af3b
	defb 050h,008h,001h	; af3e
	defb 048h,007h,000h	; af41
	defb 020h,006h,002h	; af44
	defb 014h,006h,000h	; af47
	defb 050h,005h,001h	; af4a
	defb 032h,005h,000h	; af4d
	defb 000h,005h,002h	; af50
	defb 094h,003h,000h	; af53
	defb 030h,003h,001h	; af56
	defb 028h,003h,000h	; af59
	defb 000h,002h,002h	; af5c
	defb 0ffh,0ffh,000h	; af5f

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_19: el segundo guion de la fase 19: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf62..0xaf89  (39 bytes)
DATA_segundo_guion_fase_19:
	defb 064h,009h,000h	; af62
	defb 036h,008h,002h	; af65
	defb 030h,008h,000h	; af68
	defb 098h,007h,001h	; af6b
	defb 002h,007h,000h	; af6e
	defb 070h,006h,002h	; af71
	defb 064h,006h,000h	; af74
	defb 000h,006h,001h	; af77
	defb 028h,005h,000h	; af7a
	defb 000h,004h,002h	; af7d
	defb 098h,003h,000h	; af80
	defb 070h,002h,001h	; af83
	defb 0ffh,0ffh,000h	; af86

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_20: el segundo guion de la fase 20: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf89..0xaf9e  (21 bytes)
DATA_segundo_guion_fase_20:
	defb 000h,007h,000h	; af89
	defb 072h,005h,001h	; af8c
	defb 032h,004h,000h	; af8f
	defb 000h,004h,002h	; af92
	defb 094h,003h,000h	; af95
	defb 030h,003h,002h	; af98
	defb 0ffh,0ffh,000h	; af9b

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_21: el segundo guion de la fase 21: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaf9e..0xafcb  (45 bytes)
DATA_segundo_guion_fase_21:
	defb 020h,012h,000h	; af9e
	defb 056h,011h,002h	; afa1
	defb 050h,011h,000h	; afa4
	defb 018h,011h,001h	; afa7
	defb 042h,008h,000h	; afaa
	defb 010h,008h,002h	; afad
	defb 000h,008h,000h	; afb0
	defb 072h,006h,001h	; afb3
	defb 070h,006h,000h	; afb6
	defb 006h,006h,002h	; afb9
	defb 032h,003h,000h	; afbc
	defb 000h,003h,001h	; afbf
	defb 090h,002h,000h	; afc2
	defb 058h,002h,002h	; afc5
	defb 0ffh,0ffh,000h	; afc8

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_22: el segundo guion de la fase 22: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xafcb..0xaff2  (39 bytes)
DATA_segundo_guion_fase_22:
	defb 014h,008h,000h	; afcb
	defb 050h,007h,001h	; afce
	defb 042h,007h,000h	; afd1
	defb 010h,007h,002h	; afd4
	defb 008h,007h,000h	; afd7
	defb 080h,005h,001h	; afda
	defb 040h,005h,000h	; afdd
	defb 008h,005h,002h	; afe0
	defb 000h,005h,000h	; afe3
	defb 036h,004h,001h	; afe6
	defb 030h,004h,000h	; afe9
	defb 002h,003h,002h	; afec
	defb 0ffh,0ffh,000h	; afef

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_23: el segundo guion de la fase 23: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xaff2..0xb019  (39 bytes)
DATA_segundo_guion_fase_23:
	defb 020h,009h,000h	; aff2
	defb 056h,008h,002h	; aff5
	defb 050h,008h,000h	; aff8
	defb 018h,008h,002h	; affb
	defb 000h,008h,000h	; affe
	defb 004h,007h,002h	; b001
	defb 012h,003h,000h	; b004
	defb 080h,002h,001h	; b007
	defb 070h,002h,000h	; b00a
	defb 006h,002h,002h	; b00d
	defb 096h,001h,000h	; b010
	defb 000h,001h,001h	; b013
	defb 0ffh,0ffh,000h	; b016

; ----------------------------------------------------------------------
; DATOS segundo_guion_fase_24: el segundo guion de la fase 24: entradas de 3
;   bytes -la distancia en BCD (0xE0A7) y el byte que dice que pasa (0xE0A6)-
;   que p01:6713 lee con (0xE0A9), y una ultima FF FF 00 a la que no se llega
;   0xb019..0xb046  (45 bytes)
DATA_segundo_guion_fase_24:
	defb 064h,010h,000h	; b019
	defb 000h,010h,001h	; b01c
	defb 090h,009h,000h	; b01f
	defb 058h,009h,002h	; b022
	defb 000h,009h,000h	; b025
	defb 004h,008h,001h	; b028
	defb 004h,004h,000h	; b02b
	defb 040h,003h,002h	; b02e
	defb 038h,003h,000h	; b031
	defb 010h,002h,002h	; b034
	defb 004h,002h,000h	; b037
	defb 040h,001h,001h	; b03a
	defb 032h,001h,000h	; b03d
	defb 000h,001h,002h	; b040
	defb 0ffh,0ffh,000h	; b043

; ----------------------------------------------------------------------
; DATOS tabla_por_fase_B046: 24 punteros, uno por fase, a listas de entradas
;   de 4 bytes que p01:638F indexa con (0xE0B6): una palabra a 0xE0AF y dos
;   bytes a 0xE0B1 y 0xE0B2; ES EL GUION DE AVISOS: cada entrada es una
;   distancia (0xE08D) a la que p03:B8AB convierte en grieta la siguiente cosa
;   que sale, con el modo y la lista en los dos bytes: modo 2, un atajo
;   (WARP); modos 3, 4 y 5, una tienda con ese tendero (normal, caro, Santa
;   Claus). Salen 6 atajos y 41 tiendas
;   0xb046..0xb076  (48 bytes)
DATA_tabla_por_fase_B046:
	defb 076h,0b0h	; b046
	defb 08ah,0b0h	; b048
	defb 09ah,0b0h	; b04a
	defb 0aeh,0b0h	; b04c
	defb 0b2h,0b0h	; b04e
	defb 0b6h,0b0h	; b050
	defb 0c6h,0b0h	; b052
	defb 0d2h,0b0h	; b054
	defb 0d6h,0b0h	; b056
	defb 0e6h,0b0h	; b058
	defb 0eah,0b0h	; b05a
	defb 0eeh,0b0h	; b05c
	defb 002h,0b1h	; b05e
	defb 016h,0b1h	; b060
	defb 022h,0b1h	; b062
	defb 032h,0b1h	; b064
	defb 03ah,0b1h	; b066
	defb 03eh,0b1h	; b068
	defb 052h,0b1h	; b06a
	defb 056h,0b1h	; b06c
	defb 05ah,0b1h	; b06e
	defb 06eh,0b1h	; b070
	defb 082h,0b1h	; b072
	defb 086h,0b1h	; b074

; ----------------------------------------------------------------------
; DATOS lista_B046_B076: entradas de 4 bytes de la fase 1
;   (tabla_por_fase_B046)
;   0xb076..0xb08a  (20 bytes)
DATA_lista_B046_B076:
	defb 000h,005h,000h,003h	; b076
	defb 050h,003h,000h,013h	; b07a
	defb 060h,002h,00ah,002h	; b07e
	defb 000h,002h,000h,014h	; b082
	defb 0ffh,0ffh,000h,000h	; b086

; ----------------------------------------------------------------------
; DATOS lista_B046_B08A: entradas de 4 bytes de la fase 2
;   (tabla_por_fase_B046)
;   0xb08a..0xb09a  (16 bytes)
DATA_lista_B046_B08A:
	defb 000h,004h,000h,004h	; b08a
	defb 000h,002h,000h,003h	; b08e
	defb 000h,001h,000h,014h	; b092
	defb 0ffh,0ffh,000h,000h	; b096

; ----------------------------------------------------------------------
; DATOS lista_B046_B09A: entradas de 4 bytes de la fase 3
;   (tabla_por_fase_B046)
;   0xb09a..0xb0ae  (20 bytes)
DATA_lista_B046_B09A:
	defb 000h,007h,000h,014h	; b09a
	defb 080h,006h,000h,014h	; b09e
	defb 020h,004h,000h,013h	; b0a2
	defb 000h,001h,000h,004h	; b0a6
	defb 0ffh,0ffh,000h,000h	; b0aa

; ----------------------------------------------------------------------
; DATOS lista_B046_B0AE: entradas de 4 bytes de la fase 4
;   (tabla_por_fase_B046)
;   0xb0ae..0xb0b2  (4 bytes)
DATA_lista_B046_B0AE:
	defb 0ffh,0ffh,000h,000h	; b0ae

; ----------------------------------------------------------------------
; DATOS lista_B046_B0B2: entradas de 4 bytes de la fase 5
;   (tabla_por_fase_B046)
;   0xb0b2..0xb0b6  (4 bytes)
DATA_lista_B046_B0B2:
	defb 0ffh,0ffh,000h,000h	; b0b2

; ----------------------------------------------------------------------
; DATOS lista_B046_B0B6: entradas de 4 bytes de la fase 6
;   (tabla_por_fase_B046)
;   0xb0b6..0xb0c6  (16 bytes)
DATA_lista_B046_B0B6:
	defb 050h,003h,000h,003h	; b0b6
	defb 015h,003h,000h,005h	; b0ba
	defb 060h,001h,00bh,002h	; b0be
	defb 0ffh,0ffh,000h,000h	; b0c2

; ----------------------------------------------------------------------
; DATOS lista_B046_B0C6: entradas de 4 bytes de la fase 7
;   (tabla_por_fase_B046)
;   0xb0c6..0xb0d2  (12 bytes)
DATA_lista_B046_B0C6:
	defb 080h,005h,000h,004h	; b0c6
	defb 080h,002h,000h,014h	; b0ca
	defb 0ffh,0ffh,000h,000h	; b0ce

; ----------------------------------------------------------------------
; DATOS lista_B046_B0D2: entradas de 4 bytes de la fase 8
;   (tabla_por_fase_B046)
;   0xb0d2..0xb0d6  (4 bytes)
DATA_lista_B046_B0D2:
	defb 0ffh,0ffh,000h,000h	; b0d2

; ----------------------------------------------------------------------
; DATOS lista_B046_B0D6: entradas de 4 bytes de la fase 9
;   (tabla_por_fase_B046)
;   0xb0d6..0xb0e6  (16 bytes)
DATA_lista_B046_B0D6:
	defb 020h,004h,000h,013h	; b0d6
	defb 050h,003h,00ch,002h	; b0da
	defb 000h,002h,000h,003h	; b0de
	defb 0ffh,0ffh,000h,000h	; b0e2

; ----------------------------------------------------------------------
; DATOS lista_B046_B0E6: entradas de 4 bytes de la fase 10
;   (tabla_por_fase_B046)
;   0xb0e6..0xb0ea  (4 bytes)
DATA_lista_B046_B0E6:
	defb 0ffh,0ffh,000h,000h	; b0e6

; ----------------------------------------------------------------------
; DATOS lista_B046_B0EA: entradas de 4 bytes de la fase 11
;   (tabla_por_fase_B046)
;   0xb0ea..0xb0ee  (4 bytes)
DATA_lista_B046_B0EA:
	defb 0ffh,0ffh,000h,000h	; b0ea

; ----------------------------------------------------------------------
; DATOS lista_B046_B0EE: entradas de 4 bytes de la fase 12
;   (tabla_por_fase_B046)
;   0xb0ee..0xb102  (20 bytes)
DATA_lista_B046_B0EE:
	defb 000h,008h,000h,014h	; b0ee
	defb 000h,005h,000h,004h	; b0f2
	defb 050h,004h,000h,013h	; b0f6
	defb 000h,002h,000h,005h	; b0fa
	defb 0ffh,0ffh,000h,000h	; b0fe

; ----------------------------------------------------------------------
; DATOS lista_B046_B102: entradas de 4 bytes de la fase 13
;   (tabla_por_fase_B046)
;   0xb102..0xb116  (20 bytes)
DATA_lista_B046_B102:
	defb 080h,003h,000h,004h	; b102
	defb 070h,003h,00dh,002h	; b106
	defb 004h,002h,000h,013h	; b10a
	defb 095h,001h,000h,004h	; b10e
	defb 0ffh,0ffh,000h,000h	; b112

; ----------------------------------------------------------------------
; DATOS lista_B046_B116: entradas de 4 bytes de la fase 14
;   (tabla_por_fase_B046)
;   0xb116..0xb122  (12 bytes)
DATA_lista_B046_B116:
	defb 095h,001h,000h,003h	; b116
	defb 009h,001h,000h,014h	; b11a
	defb 0ffh,0ffh,000h,000h	; b11e

; ----------------------------------------------------------------------
; DATOS lista_B046_B122: entradas de 4 bytes de la fase 15
;   (tabla_por_fase_B046)
;   0xb122..0xb132  (16 bytes)
DATA_lista_B046_B122:
	defb 095h,004h,000h,013h	; b122
	defb 050h,004h,000h,003h	; b126
	defb 095h,000h,00eh,002h	; b12a
	defb 0ffh,0ffh,000h,000h	; b12e

; ----------------------------------------------------------------------
; DATOS lista_B046_B132: entradas de 4 bytes de la fase 16
;   (tabla_por_fase_B046)
;   0xb132..0xb13a  (8 bytes)
DATA_lista_B046_B132:
	defb 056h,003h,000h,004h	; b132
	defb 0ffh,0ffh,000h,000h	; b136

; ----------------------------------------------------------------------
; DATOS lista_B046_B13A: entradas de 4 bytes de la fase 17
;   (tabla_por_fase_B046)
;   0xb13a..0xb13e  (4 bytes)
DATA_lista_B046_B13A:
	defb 0ffh,0ffh,000h,000h	; b13a

; ----------------------------------------------------------------------
; DATOS lista_B046_B13E: entradas de 4 bytes de la fase 18
;   (tabla_por_fase_B046)
;   0xb13e..0xb152  (20 bytes)
DATA_lista_B046_B13E:
	defb 030h,008h,000h,003h	; b13e
	defb 060h,004h,000h,004h	; b142
	defb 046h,004h,000h,013h	; b146
	defb 032h,004h,00fh,002h	; b14a
	defb 0ffh,0ffh,000h,000h	; b14e

; ----------------------------------------------------------------------
; DATOS lista_B046_B152: entradas de 4 bytes de la fase 19
;   (tabla_por_fase_B046)
;   0xb152..0xb156  (4 bytes)
DATA_lista_B046_B152:
	defb 0ffh,0ffh,000h,000h	; b152

; ----------------------------------------------------------------------
; DATOS lista_B046_B156: entradas de 4 bytes de la fase 20
;   (tabla_por_fase_B046)
;   0xb156..0xb15a  (4 bytes)
DATA_lista_B046_B156:
	defb 0ffh,0ffh,000h,000h	; b156

; ----------------------------------------------------------------------
; DATOS lista_B046_B15A: entradas de 4 bytes de la fase 21
;   (tabla_por_fase_B046)
;   0xb15a..0xb16e  (20 bytes)
DATA_lista_B046_B15A:
	defb 099h,009h,000h,015h	; b15a
	defb 080h,008h,000h,004h	; b15e
	defb 000h,004h,000h,004h	; b162
	defb 098h,001h,000h,013h	; b166
	defb 0ffh,0ffh,000h,000h	; b16a

; ----------------------------------------------------------------------
; DATOS lista_B046_B16E: entradas de 4 bytes de la fase 22
;   (tabla_por_fase_B046)
;   0xb16e..0xb182  (20 bytes)
DATA_lista_B046_B16E:
	defb 049h,009h,000h,014h	; b16e
	defb 083h,008h,000h,013h	; b172
	defb 051h,008h,000h,003h	; b176
	defb 082h,002h,000h,004h	; b17a
	defb 0ffh,0ffh,000h,000h	; b17e

; ----------------------------------------------------------------------
; DATOS lista_B046_B182: entradas de 4 bytes de la fase 23
;   (tabla_por_fase_B046)
;   0xb182..0xb186  (4 bytes)
DATA_lista_B046_B182:
	defb 0ffh,0ffh,000h,000h	; b182

; ----------------------------------------------------------------------
; DATOS lista_B046_B186: entradas de 4 bytes de la fase 24
;   (tabla_por_fase_B046)
;   0xb186..0xb192  (12 bytes)
DATA_lista_B046_B186:
	defb 025h,011h,000h,004h	; b186
	defb 001h,006h,000h,013h	; b18a
	defb 0ffh,0ffh,000h,000h	; b18e

; ----------------------------------------------------------------------
; DATOS tabla_por_fase_B192: 24 punteros, uno por fase, a listas de palabras
;   que p01:63DB indexa con (0xE0D4) y lleva a 0xE0D5
;   0xb192..0xb1c2  (48 bytes)
DATA_tabla_por_fase_B192:
	defb 0c2h,0b1h	; b192
	defb 0c8h,0b1h	; b194
	defb 0cch,0b1h	; b196
	defb 0d2h,0b1h	; b198
	defb 0d6h,0b1h	; b19a
	defb 0dch,0b1h	; b19c
	defb 0e2h,0b1h	; b19e
	defb 0e8h,0b1h	; b1a0
	defb 0eeh,0b1h	; b1a2
	defb 0f6h,0b1h	; b1a4
	defb 0feh,0b1h	; b1a6
	defb 006h,0b2h	; b1a8
	defb 00eh,0b2h	; b1aa
	defb 014h,0b2h	; b1ac
	defb 01ah,0b2h	; b1ae
	defb 024h,0b2h	; b1b0
	defb 02eh,0b2h	; b1b2
	defb 036h,0b2h	; b1b4
	defb 042h,0b2h	; b1b6
	defb 04eh,0b2h	; b1b8
	defb 058h,0b2h	; b1ba
	defb 064h,0b2h	; b1bc
	defb 072h,0b2h	; b1be
	defb 07eh,0b2h	; b1c0

; ----------------------------------------------------------------------
; DATOS lista_B192_B1C2: palabras de la fase 1 (tabla_por_fase_B192)
;   0xb1c2..0xb1c8  (6 bytes)
DATA_lista_B192_B1C2:
	defb 010h,005h	; b1c2
	defb 000h,003h	; b1c4
	defb 0ffh,0ffh	; b1c6

; ----------------------------------------------------------------------
; DATOS lista_B192_B1C8: palabras de la fase 2 (tabla_por_fase_B192)
;   0xb1c8..0xb1cc  (4 bytes)
DATA_lista_B192_B1C8:
	defb 080h,003h	; b1c8
	defb 0ffh,0ffh	; b1ca

; ----------------------------------------------------------------------
; DATOS lista_B192_B1CC: palabras de la fase 3 (tabla_por_fase_B192)
;   0xb1cc..0xb1d2  (6 bytes)
DATA_lista_B192_B1CC:
	defb 050h,005h	; b1cc
	defb 000h,003h	; b1ce
	defb 0ffh,0ffh	; b1d0

; ----------------------------------------------------------------------
; DATOS lista_B192_B1D2: palabras de la fase 4 (tabla_por_fase_B192)
;   0xb1d2..0xb1d6  (4 bytes)
DATA_lista_B192_B1D2:
	defb 080h,002h	; b1d2
	defb 0ffh,0ffh	; b1d4

; ----------------------------------------------------------------------
; DATOS lista_B192_B1D6: palabras de la fase 5 (tabla_por_fase_B192)
;   0xb1d6..0xb1dc  (6 bytes)
DATA_lista_B192_B1D6:
	defb 020h,004h	; b1d6
	defb 050h,002h	; b1d8
	defb 0ffh,0ffh	; b1da

; ----------------------------------------------------------------------
; DATOS lista_B192_B1DC: palabras de la fase 6 (tabla_por_fase_B192)
;   0xb1dc..0xb1e2  (6 bytes)
DATA_lista_B192_B1DC:
	defb 010h,005h	; b1dc
	defb 020h,003h	; b1de
	defb 0ffh,0ffh	; b1e0

; ----------------------------------------------------------------------
; DATOS lista_B192_B1E2: palabras de la fase 7 (tabla_por_fase_B192)
;   0xb1e2..0xb1e8  (6 bytes)
DATA_lista_B192_B1E2:
	defb 000h,005h	; b1e2
	defb 050h,002h	; b1e4
	defb 0ffh,0ffh	; b1e6

; ----------------------------------------------------------------------
; DATOS lista_B192_B1E8: palabras de la fase 8 (tabla_por_fase_B192)
;   0xb1e8..0xb1ee  (6 bytes)
DATA_lista_B192_B1E8:
	defb 080h,004h	; b1e8
	defb 060h,002h	; b1ea
	defb 0ffh,0ffh	; b1ec

; ----------------------------------------------------------------------
; DATOS lista_B192_B1EE: palabras de la fase 9 (tabla_por_fase_B192)
;   0xb1ee..0xb1f6  (8 bytes)
DATA_lista_B192_B1EE:
	defb 020h,006h	; b1ee
	defb 010h,004h	; b1f0
	defb 050h,002h	; b1f2
	defb 0ffh,0ffh	; b1f4

; ----------------------------------------------------------------------
; DATOS lista_B192_B1F6: palabras de la fase 10 (tabla_por_fase_B192)
;   0xb1f6..0xb1fe  (8 bytes)
DATA_lista_B192_B1F6:
	defb 020h,006h	; b1f6
	defb 030h,004h	; b1f8
	defb 030h,002h	; b1fa
	defb 0ffh,0ffh	; b1fc

; ----------------------------------------------------------------------
; DATOS lista_B192_B1FE: palabras de la fase 11 (tabla_por_fase_B192)
;   0xb1fe..0xb206  (8 bytes)
DATA_lista_B192_B1FE:
	defb 090h,005h	; b1fe
	defb 090h,003h	; b200
	defb 090h,001h	; b202
	defb 0ffh,0ffh	; b204

; ----------------------------------------------------------------------
; DATOS lista_B192_B206: palabras de la fase 12 (tabla_por_fase_B192)
;   0xb206..0xb20e  (8 bytes)
DATA_lista_B192_B206:
	defb 000h,007h	; b206
	defb 000h,006h	; b208
	defb 000h,003h	; b20a
	defb 0ffh,0ffh	; b20c

; ----------------------------------------------------------------------
; DATOS lista_B192_B20E: palabras de la fase 13 (tabla_por_fase_B192)
;   0xb20e..0xb214  (6 bytes)
DATA_lista_B192_B20E:
	defb 020h,005h	; b20e
	defb 080h,002h	; b210
	defb 0ffh,0ffh	; b212

; ----------------------------------------------------------------------
; DATOS lista_B192_B214: palabras de la fase 14 (tabla_por_fase_B192)
;   0xb214..0xb21a  (6 bytes)
DATA_lista_B192_B214:
	defb 030h,004h	; b214
	defb 080h,002h	; b216
	defb 0ffh,0ffh	; b218

; ----------------------------------------------------------------------
; DATOS lista_B192_B21A: palabras de la fase 15 (tabla_por_fase_B192)
;   0xb21a..0xb224  (10 bytes)
DATA_lista_B192_B21A:
	defb 086h,007h	; b21a
	defb 000h,006h	; b21c
	defb 080h,003h	; b21e
	defb 020h,002h	; b220
	defb 0ffh,0ffh	; b222

; ----------------------------------------------------------------------
; DATOS lista_B192_B224: palabras de la fase 16 (tabla_por_fase_B192)
;   0xb224..0xb22e  (10 bytes)
DATA_lista_B192_B224:
	defb 080h,008h	; b224
	defb 050h,006h	; b226
	defb 050h,004h	; b228
	defb 050h,002h	; b22a
	defb 0ffh,0ffh	; b22c

; ----------------------------------------------------------------------
; DATOS lista_B192_B22E: palabras de la fase 17 (tabla_por_fase_B192)
;   0xb22e..0xb236  (8 bytes)
DATA_lista_B192_B22E:
	defb 020h,006h	; b22e
	defb 000h,004h	; b230
	defb 040h,002h	; b232
	defb 0ffh,0ffh	; b234

; ----------------------------------------------------------------------
; DATOS lista_B192_B236: palabras de la fase 18 (tabla_por_fase_B192)
;   0xb236..0xb242  (12 bytes)
DATA_lista_B192_B236:
	defb 020h,010h	; b236
	defb 090h,007h	; b238
	defb 000h,006h	; b23a
	defb 000h,004h	; b23c
	defb 030h,002h	; b23e
	defb 0ffh,0ffh	; b240

; ----------------------------------------------------------------------
; DATOS lista_B192_B242: palabras de la fase 19 (tabla_por_fase_B192)
;   0xb242..0xb24e  (12 bytes)
DATA_lista_B192_B242:
	defb 000h,011h	; b242
	defb 030h,009h	; b244
	defb 030h,007h	; b246
	defb 010h,005h	; b248
	defb 000h,003h	; b24a
	defb 0ffh,0ffh	; b24c

; ----------------------------------------------------------------------
; DATOS lista_B192_B24E: palabras de la fase 20 (tabla_por_fase_B192)
;   0xb24e..0xb258  (10 bytes)
DATA_lista_B192_B24E:
	defb 010h,007h	; b24e
	defb 020h,005h	; b250
	defb 060h,003h	; b252
	defb 000h,002h	; b254
	defb 0ffh,0ffh	; b256

; ----------------------------------------------------------------------
; DATOS lista_B192_B258: palabras de la fase 21 (tabla_por_fase_B192)
;   0xb258..0xb264  (12 bytes)
DATA_lista_B192_B258:
	defb 060h,012h	; b258
	defb 080h,009h	; b25a
	defb 090h,007h	; b25c
	defb 000h,006h	; b25e
	defb 040h,003h	; b260
	defb 0ffh,0ffh	; b262

; ----------------------------------------------------------------------
; DATOS lista_B192_B264: palabras de la fase 22 (tabla_por_fase_B192)
;   0xb264..0xb272  (14 bytes)
DATA_lista_B192_B264:
	defb 083h,011h	; b264
	defb 000h,010h	; b266
	defb 030h,008h	; b268
	defb 020h,006h	; b26a
	defb 000h,004h	; b26c
	defb 030h,002h	; b26e
	defb 0ffh,0ffh	; b270

; ----------------------------------------------------------------------
; DATOS lista_B192_B272: palabras de la fase 23 (tabla_por_fase_B192)
;   0xb272..0xb27e  (12 bytes)
DATA_lista_B192_B272:
	defb 070h,008h	; b272
	defb 000h,007h	; b274
	defb 030h,005h	; b276
	defb 050h,003h	; b278
	defb 000h,002h	; b27a
	defb 0ffh,0ffh	; b27c

; ----------------------------------------------------------------------
; DATOS lista_B192_B27E: palabras de la fase 24 (tabla_por_fase_B192)
;   0xb27e..0xb28c  (14 bytes)
DATA_lista_B192_B27E:
	defb 078h,012h	; b27e
	defb 080h,010h	; b280
	defb 000h,009h	; b282
	defb 050h,006h	; b284
	defb 070h,004h	; b286
	defb 020h,003h	; b288
	defb 0ffh,0ffh	; b28a

; ----------------------------------------------------------------------
; DATOS tabla_por_fase_B28C: 24 entradas de 4 bytes, una por fase, que
;   p01:6414 reparte: una palabra a 0xE0AB y dos bytes a 0xE0AD y 0xE0AE
;   0xb28c..0xb2ec  (96 bytes)
DATA_tabla_por_fase_B28C:
	defb 020h,004h,000h,001h	; b28c
	defb 0ffh,0ffh,000h,001h	; b290
	defb 080h,003h,001h,001h	; b294
	defb 0ffh,0ffh,000h,001h	; b298
	defb 0ffh,0ffh,000h,001h	; b29c
	defb 0ffh,0ffh,000h,001h	; b2a0
	defb 000h,007h,002h,001h	; b2a4
	defb 0ffh,0ffh,000h,001h	; b2a8
	defb 000h,003h,003h,001h	; b2ac
	defb 0ffh,0ffh,000h,001h	; b2b0
	defb 000h,003h,004h,001h	; b2b4
	defb 020h,005h,005h,001h	; b2b8
	defb 0ffh,0ffh,000h,001h	; b2bc
	defb 080h,005h,006h,001h	; b2c0
	defb 0ffh,0ffh,000h,001h	; b2c4
	defb 020h,010h,007h,001h	; b2c8
	defb 050h,005h,008h,001h	; b2cc
	defb 0ffh,0ffh,000h,001h	; b2d0
	defb 0ffh,0ffh,000h,001h	; b2d4
	defb 0ffh,0ffh,000h,001h	; b2d8
	defb 010h,005h,009h,001h	; b2dc
	defb 0ffh,0ffh,000h,001h	; b2e0
	defb 0ffh,0ffh,000h,001h	; b2e4
	defb 0ffh,0ffh,000h,001h	; b2e8

; ----------------------------------------------------------------------
; DATOS columnas_B2EC: 32 columnas de 21 bytes que p01:7B85 copia de una en
;   una a la tabla de nombres en RAM, un byte por fila; el puntero lo deja
;   p03:AA96 en 0xE4E0
;   0xb2ec..0xb58c  (672 bytes)
DATA_columnas_B2EC:
	defb 044h,044h,051h,079h,067h,074h,06eh,063h,064h,055h,05bh,05ch,05dh,0ceh,0cfh,022h,0bah,041h,0b3h,040h,0b0h	; b2ec  DDQygtncdU[\]..".A.@.
	defb 05ah,04eh,073h,056h,079h,040h,061h,059h,054h,058h,056h,05ah,057h,0cbh,0cfh,022h,092h,039h,049h,042h,085h	; b301  ZNsVy@aYTXVZW..".9IB.
	defb 044h,044h,05bh,067h,05ch,079h,07ah,066h,062h,051h,000h,000h,077h,0cdh,0cfh,022h,0b9h,0b4h,0b2h,0b1h,0afh	; b316  DD[g\yzfbQ..w..".....
	defb 05fh,059h,072h,078h,067h,079h,07ah,060h,065h,050h,000h,000h,078h,0cah,0cfh,022h,093h,03ah,048h,0a7h,084h	; b32b  _Yrxgyz`eP..x..".:H..
	defb 044h,044h,04fh,051h,076h,03fh,05fh,05eh,07ah,03eh,000h,000h,07ch,0cch,0c6h,0beh,0b8h,078h,088h,07ah,08ah	; b340  DDOQv?_^z>..|....x.z.
	defb 046h,047h,071h,051h,079h,038h,075h,067h,07bh,04fh,000h,000h,07ch,0c9h,0c6h,030h,09eh,04ch,047h,03fh,0a9h	; b355  FGqQy8ug{O..|..0.LG?.
	defb 044h,044h,044h,04ah,053h,076h,079h,07ah,03dh,03ch,000h,000h,081h,0c8h,0c5h,0bdh,0b7h,077h,087h,001h,089h	; b36a  DDDJSvyz=<.......w...
	defb 045h,071h,045h,052h,056h,079h,04ah,07bh,068h,04eh,000h,000h,087h,0c8h,0c4h,031h,09fh,04bh,044h,038h,0a8h	; b37f  EqERVyJ{hN.....1.KD8.
	defb 044h,044h,044h,04ch,051h,079h,03fh,047h,039h,049h,000h,000h,082h,0d5h,0c1h,0bbh,0b6h,063h,073h,001h,08ch	; b394  DDDLQy?G9I.......cs..
	defb 054h,074h,075h,076h,06ch,06bh,042h,06dh,043h,000h,000h,000h,088h,0dbh,09dh,032h,0a0h,03dh,046h,037h,0a5h	; b3a9  TtuvlkBmC......2.=F7.
	defb 044h,044h,044h,048h,055h,03fh,079h,036h,048h,000h,000h,000h,083h,0c3h,0bch,021h,0b5h,062h,072h,001h,08bh	; b3be  DDDHU?y6H......!.br..
	defb 058h,076h,076h,061h,067h,06ah,079h,03ah,04dh,000h,000h,000h,089h,0c7h,09ch,033h,0a1h,03eh,08dh,082h,0a4h	; b3d3  Xvvagjy:M......3.>...
	defb 043h,04bh,050h,045h,078h,073h,046h,035h,053h,030h,02fh,02eh,025h,0d4h,01ch,020h,02fh,061h,071h,035h,08fh	; b3e8  CKPExsF5S0/.%.. /aq5.
	defb 06bh,06ah,06bh,06fh,079h,069h,06ch,03bh,000h,007h,00eh,010h,004h,0dah,010h,011h,0a2h,04ah,0c2h,083h,097h	; b3fd  kjkoyil;.........J...
	defb 045h,070h,045h,071h,045h,072h,045h,037h,00ch,003h,00fh,021h,024h,018h,01bh,01fh,076h,043h,073h,034h,08eh	; b412  EpEqErE7...!$...vCs4.
	defb 062h,06bh,06bh,06dh,06bh,047h,04bh,04ch,032h,033h,02dh,01eh,005h,014h,012h,05fh,00bh,045h,05bh,038h,096h	; b427  bkkmkGKL23-...._.E[8.
	defb 046h,071h,045h,071h,052h,06fh,070h,000h,000h,008h,031h,022h,023h,017h,01ah,01eh,075h,043h,06fh,036h,07dh	; b43c  FqEqRop...1"#...uCo6}
	defb 057h,06eh,06bh,068h,063h,041h,052h,000h,000h,00ah,017h,01ah,006h,015h,013h,009h,00ch,04dh,086h,03bh,0c0h	; b451  WnkhcAR..........M.;.
	defb 04dh,049h,05dh,052h,060h,071h,000h,08bh,08ah,01bh,020h,01ch,018h,016h,019h,01dh,074h,043h,06eh,081h,09ah	; b466  MI]R`q.... .....tCn..
	defb 040h,065h,066h,064h,069h,044h,000h,085h,084h,009h,016h,01fh,01dh,09bh,0a3h,00ah,05eh,05ch,07eh,03ch,0bfh	; b47b  @efdiD..........^\~<.
	defb 040h,040h,077h,04dh,05eh,000h,000h,085h,084h,009h,016h,01fh,01dh,06dh,05dh,00ah,05eh,05ch,06ch,080h,099h	; b490  @@wM^........m].^\l..
	defb 040h,040h,040h,040h,040h,000h,000h,08bh,08ah,01bh,020h,01ch,018h,02ch,029h,01dh,074h,043h,07fh,094h,060h	; b4a5  @@@@@..... ..,).tC..`
	defb 042h,042h,042h,042h,042h,02ah,02ah,02ah,02ah,019h,017h,01ah,00dh,001h,004h,009h,00ch,0d3h,06bh,00dh,098h	; b4ba  BBBBB****.........k..
	defb 041h,041h,041h,041h,041h,001h,001h,001h,001h,00bh,031h,022h,026h,02dh,028h,01eh,075h,0d9h,07bh,050h,04fh	; b4cf  AAAAA.....1"&-(.u.{PO
	defb 041h,041h,041h,041h,041h,001h,001h,001h,001h,011h,012h,002h,015h,002h,005h,008h,00bh,05ah,06ah,001h,091h	; b4e4  AAAAA............Zj..
	defb 042h,042h,042h,042h,042h,02ah,02ah,02ah,02ah,029h,02ch,02bh,027h,02eh,027h,01fh,076h,051h,07ch,095h,04eh	; b4f9  BBBBB****),+'.'.vQ|.N
	defb 040h,040h,040h,040h,040h,000h,000h,000h,000h,000h,000h,000h,014h,003h,006h,007h,064h,059h,069h,001h,090h	; b50e  @@@@@...........dYi..
	defb 040h,040h,040h,040h,040h,000h,000h,000h,000h,000h,000h,034h,028h,0a6h,026h,02ah,054h,05ch,079h,001h,052h	; b523  @@@@@......4(.&*T\y.R
	defb 042h,042h,042h,042h,042h,02ah,02ah,02ah,02ah,02ah,02ah,02ah,02ah,023h,024h,056h,066h,058h,068h,001h,0d0h	; b538  BBBBB********#$VfXh..
	defb 041h,041h,041h,041h,041h,001h,001h,001h,001h,001h,001h,001h,001h,00eh,00fh,0ach,02bh,053h,0aeh,001h,046h	; b54d  AAAAA...........+S..F
	defb 041h,041h,041h,041h,041h,001h,001h,001h,001h,001h,001h,001h,001h,00eh,00fh,055h,065h,057h,067h,0d7h,0d2h	; b562  AAAAA..........UeWg..
	defb 042h,042h,042h,042h,042h,02ah,02ah,02ah,02ah,02ah,02ah,02ah,02ah,023h,024h,025h,0abh,0aah,0adh,0d1h,0d8h	; b577  BBBBB********#$%.....

; ----------------------------------------------------------------------
; DATOS guion_B58C: guion comprimido que lee descomprime (por el puente de
;   AB3D); lo cargan p03:AB3D (101 bytes)
;   0xb58c..0xb5f1  (101 bytes)
DATA_guion_B58C:
	defb 006h,0ech,081h,07eh,012h,07ah,081h,080h,080h,026h,0ech,081h,07dh,002h,040h,08dh	; b58c  ...~.z...&..}.@.
	defb 039h,02fh,035h,040h,02dh,021h,024h,025h,040h,029h,034h,040h,01fh,003h,040h,081h	; b59c  9/5@-!$%@)4@..@.
	defb 07fh,080h,046h,0ech,094h,07dh,022h,035h,034h,040h,034h,028h,029h,033h,040h,021h	; b5ac  ..F..}"54@4()3@!
	defb 024h,036h,025h,02eh,034h,035h,032h,025h,07fh,080h,066h,0ech,094h,07dh,029h,033h	; b5bc  $6%.452%..f..})3
	defb 040h,02eh,02fh,034h,040h,02fh,036h,025h,032h,040h,039h,025h,034h,040h,03bh,040h	; b5cc  @./4@/6%2@9%4@;@
	defb 07fh,080h,086h,0ech,081h,086h,012h,07dh,081h,08ch,080h,0a8h,0ech,081h,07fh,080h	; b5dc  .......}........
	defb 0c8h,0ech,081h,080h,000h	; b5ec

; ----------------------------------------------------------------------
; DATOS columnas_B5F1: 32 columnas de 21 bytes que p01:7B85 copia de una en
;   una a la tabla de nombres en RAM, un byte por fila; el puntero lo deja
;   p03:AB6F en 0xE4E0
;   0xb5f1..0xb891  (672 bytes)
DATA_columnas_B5F1:
	defb 047h,048h,083h,041h,06fh,009h,009h,02eh,009h,030h,02bh,02bh,063h,005h,005h,005h,005h,005h,005h,005h,005h	; b5f1  GH.Ao....0++c........
	defb 046h,048h,09fh,041h,06fh,009h,009h,02eh,009h,033h,02bh,02bh,063h,005h,005h,005h,005h,005h,005h,005h,005h	; b606  FH.Ao....3++c........
	defb 047h,07ch,052h,06ah,06fh,009h,009h,02dh,027h,02fh,02bh,02bh,063h,005h,005h,005h,005h,005h,005h,005h,005h	; b61b  G|Rjo..-'/++c........
	defb 064h,098h,052h,041h,06fh,009h,009h,039h,038h,034h,03ah,05bh,060h,007h,005h,005h,005h,005h,005h,005h,005h	; b630  d.RAo..984:[`........
	defb 046h,048h,052h,06ah,06fh,009h,009h,009h,029h,02ah,02bh,02bh,063h,005h,005h,005h,005h,005h,005h,005h,005h	; b645  FHRjo...)*++c........
	defb 060h,048h,052h,06ah,06fh,009h,009h,0c1h,06bh,035h,054h,05ch,058h,008h,005h,005h,005h,005h,005h,005h,005h	; b65a  `HRjo...k5T\X........
	defb 046h,04ch,051h,041h,070h,0a2h,009h,009h,028h,02ch,02bh,02bh,063h,005h,005h,005h,005h,005h,005h,005h,005h	; b66f  FLQAp...(,++c........
	defb 045h,064h,067h,06ah,062h,0f8h,009h,03bh,06ch,06ah,057h,05dh,059h,009h,005h,005h,005h,005h,005h,005h,005h	; b684  Edgjb..;ljW]Y........
	defb 045h,04bh,050h,059h,05fh,004h,007h,007h,06eh,02bh,02bh,02bh,063h,005h,005h,005h,005h,005h,005h,005h,005h	; b699  EKPY_...n+++c........
	defb 063h,04bh,050h,059h,05fh,004h,017h,06dh,068h,036h,056h,05eh,05ah,00ah,005h,005h,005h,005h,005h,005h,005h	; b6ae  cKPY_..mh6V^Z........
	defb 044h,04ah,04fh,058h,05eh,006h,006h,00ah,010h,03eh,03fh,03fh,064h,005h,005h,005h,005h,005h,005h,005h,005h	; b6c3  DJOX^....>??d........
	defb 043h,049h,04eh,057h,05dh,016h,016h,00fh,020h,037h,031h,05fh,061h,00bh,005h,005h,005h,005h,005h,005h,005h	; b6d8  CINW]... 71_a........
	defb 043h,049h,04eh,057h,05dh,003h,003h,003h,013h,013h,0b7h,04eh,04bh,024h,005h,005h,005h,005h,005h,005h,005h	; b6ed  CINW]......NK$.......
	defb 044h,04ah,068h,058h,05eh,018h,018h,01bh,00eh,00dh,0efh,04dh,04ch,052h,005h,005h,005h,005h,005h,005h,005h	; b702  DJhX^......MLR.......
	defb 041h,048h,082h,056h,05ch,002h,005h,008h,0adh,0b3h,0b6h,0bdh,0c4h,02ah,022h,005h,005h,005h,005h,005h,005h	; b717  AH.V\........*"......
	defb 041h,048h,09eh,06bh,06ch,015h,019h,09ah,0e5h,0ebh,0eeh,0f5h,0fch,058h,050h,005h,005h,005h,005h,005h,005h	; b72c  AH.kl........XP......
	defb 046h,07bh,081h,087h,05bh,096h,09eh,0a6h,009h,009h,0b5h,0bch,0c3h,00eh,02ch,022h,005h,005h,005h,005h,005h	; b741  F{..[.........,".....
	defb 061h,097h,09dh,0a3h,06dh,0ceh,0d6h,0deh,009h,009h,0edh,0f4h,0fbh,03ch,05ah,050h,005h,005h,005h,005h,005h	; b756  a...m........<ZP.....
	defb 041h,07ah,080h,055h,05ah,001h,09dh,0a5h,0ach,0b2h,0b4h,0c5h,0c2h,017h,02dh,030h,021h,005h,005h,005h,005h	; b76b  Az.UZ.........-0!....
	defb 062h,096h,09ch,09dh,06eh,014h,0d5h,0ddh,0e4h,0eah,0ech,0fdh,0fah,045h,05bh,05eh,04fh,005h,005h,005h,005h	; b780  b...n........E[^O....
	defb 075h,095h,07fh,079h,08ch,095h,09ch,0a4h,0abh,0b1h,0b3h,0bbh,04ah,027h,04ch,038h,002h,022h,005h,005h,005h	; b795  u..y........J'L8."...
	defb 091h,079h,09bh,095h,0a8h,0cdh,0d4h,0dch,0e3h,0e9h,0ebh,0f3h,047h,055h,01dh,066h,002h,050h,005h,005h,005h	; b7aa  .y..........GU.f.P...
	defb 074h,079h,07eh,086h,08bh,094h,09bh,0a3h,00bh,0b0h,009h,009h,049h,034h,018h,032h,013h,02bh,023h,005h,005h	; b7bf  ty~.........I4.2.+#..
	defb 090h,095h,09ah,0a2h,0a7h,0cch,0d3h,0dbh,00ch,0e8h,009h,067h,048h,062h,046h,060h,041h,059h,051h,005h,005h	; b7d4  ...........gHbF`AYQ..
	defb 042h,078h,07dh,085h,08ah,093h,09ah,0a2h,0aah,0afh,0a2h,009h,0c1h,00dh,02eh,037h,012h,031h,02fh,022h,005h	; b7e9  Bx}............7.1/".
	defb 042h,094h,099h,0a1h,0a6h,0cbh,0d2h,0dah,0e2h,0e7h,009h,01fh,0f9h,03bh,05ch,065h,040h,05fh,05dh,050h,005h	; b7fe  B............;\e@_]P.
	defb 042h,077h,095h,054h,089h,092h,099h,0a1h,0a9h,011h,0b8h,0bah,0c0h,00ch,016h,035h,01ah,033h,015h,029h,022h	; b813  Bw.T...........5.3.)"
	defb 042h,093h,069h,066h,0a5h,0cah,0d1h,0d9h,0e1h,01ah,0f0h,0f2h,0f8h,03ah,044h,063h,048h,061h,043h,057h,050h	; b828  B.if.........:DcHaCWP
	defb 040h,076h,042h,053h,088h,091h,098h,0a0h,0a8h,0aeh,093h,099h,0bfh,020h,00fh,011h,028h,01dh,014h,026h,002h	; b83d  @vBS......... ..(..&.
	defb 040h,092h,042h,09ch,0a4h,0c9h,0d0h,0d8h,0e0h,0e6h,01ch,0b9h,0f7h,04eh,03dh,03fh,056h,04bh,042h,054h,002h	; b852  @.B..........N=?VKBT.
	defb 073h,07dh,04dh,084h,042h,090h,097h,09fh,0a7h,012h,0cbh,0b9h,0beh,01fh,001h,010h,016h,019h,01bh,01ch,025h	; b867  s}M.B...............%
	defb 08fh,065h,095h,0a0h,042h,0c8h,0cfh,0d7h,0dfh,01dh,093h,0f1h,0f6h,04dh,001h,03eh,044h,047h,049h,04ah,053h	; b87c  .e..B........M.>DGIJS

; ----------------------------------------------------------------------
; DATOS guion_B891: guion comprimido que lee descomprime (por el puente de
;   AC34); lo cargan p03:AC34 (124 bytes)
;   0xb891..0xb90d  (124 bytes)
DATA_guion_B891:
	defb 002h,0ech,081h,08dh,01ah,072h,081h,0a9h,080h,022h,0ech,09ch,08eh,034h,028h,021h	; b891  .....r..."...4(!
	defb 02eh,02bh,000h,039h,02fh,035h,01fh,000h,028h,02fh,037h,000h,023h,02fh,035h,032h	; b8a1  .+.9/5..(/7.#/52
	defb 021h,027h,025h,02fh,035h,033h,000h,0aah,080h,042h,0ech,09ch,08eh,000h,039h,02fh	; b8b1  !'%/53...B....9/
	defb 035h,000h,021h,032h,025h,000h,03bh,000h,02eh,02fh,037h,000h,030h,025h,021h,023h	; b8c1  5.!2%.;../7.0%!#
	defb 025h,000h,028h,021h,033h,000h,000h,0aah,080h,062h,0ech,093h,08eh,000h,023h,02fh	; b8d1  %.(!3....b....#/
	defb 02dh,025h,000h,022h,021h,023h,02bh,000h,034h,02fh,000h,035h,033h,000h,03bh,008h	; b8e1  -%."!#+.4/.53.;.
	defb 000h,081h,0aah,080h,082h,0ech,081h,0c7h,01ah,074h,081h,0ffh,080h,0b5h,0ech,081h	; b8f1  .........t......
	defb 077h,080h,0d5h,0ech,081h,078h,080h,0f5h,0ech,081h,079h,000h	; b901  w....x....y.

; ----------------------------------------------------------------------
; DATOS guion_B90D: guion comprimido que lee descomprime (por el puente de
;   AB9B); lo cargan p03:AB9B (35 bytes)
;   0xb90d..0xb930  (35 bytes)
DATA_guion_B90D:
	defb 031h,0edh,084h,069h,054h,055h,056h,080h,051h,0edh,085h,04fh,050h,051h,052h,053h	; b90d  1..iTUV.Q..OPQRS
	defb 080h,071h,0edh,085h,062h,0feh,066h,0c6h,065h,080h,091h,0edh,085h,039h,004h,003h	; b91d  .q..b.f.e....9..
	defb 006h,067h,000h	; b92d

; ----------------------------------------------------------------------
; DATOS guion_B930: guion comprimido que lee descomprime (por el puente de
;   ABD7); lo cargan p03:ABD7 (12 bytes)
;   0xb930..0xb93c  (12 bytes)
DATA_guion_B930:
	defb 0efh,0ech,082h,070h,06fh,080h,00fh,0edh,082h,03ch,042h,000h	; b930  ...po....<B.

; ----------------------------------------------------------------------
; DATOS guion_B93C: guion comprimido que lee descomprime (por el puente de
;   ABFC); lo cargan p03:ABFC (39 bytes)
;   0xb93c..0xb963  (39 bytes)
DATA_guion_B93C:
	defb 0aeh,0ech,085h,022h,023h,046h,040h,041h,080h,0ceh,0ech,086h,024h,03dh,043h,044h	; b93c  ..."#F@A....$=CD
	defb 045h,026h,080h,0eeh,0ech,087h,027h,070h,071h,072h,073h,021h,027h,080h,00fh,0edh	; b94c  E&....'pqrs!'...
	defb 085h,03ch,042h,034h,035h,025h,000h	; b95c

; ----------------------------------------------------------------------
; DATOS columnas_B963: 10 columnas de 5 bytes que p01:7BC4 copia de una en una
;   a la tabla de nombres en RAM, un byte por fila; el puntero lo deja
;   p03:AC4E en 0xE4E2
;   0xb963..0xb995  (50 bytes)
DATA_columnas_B963:
	defb 01eh,07bh,07fh,085h,08ch	; b963
	defb 01eh,07ch,080h,086h,08dh	; b968
	defb 009h,07ah,07ah,084h,08bh	; b96d
	defb 01eh,07dh,081h,087h,08eh	; b972
	defb 009h,009h,009h,083h,08ah	; b977
	defb 009h,07eh,07eh,088h,08fh	; b97c
	defb 0a2h,009h,009h,082h,089h	; b981
	defb 0f8h,009h,026h,021h,025h	; b986
	defb 004h,007h,007h,06eh,02bh	; b98b
	defb 004h,017h,06dh,009h,036h	; b990

; ----------------------------------------------------------------------
; DATOS guion_B995: guion comprimido que lee descomprime (por el puente de
;   ACB2); lo cargan p03:ACB2 (118 bytes)
;   0xb995..0xba0b  (118 bytes)
DATA_guion_B995:
	defb 002h,0ech,081h,08dh,01ah,072h,081h,0a9h,080h,022h,0ech,09ch,08eh,000h,033h,02fh	; b995  .....r..."....3/
	defb 032h,032h,039h,01fh,000h,039h,02fh,035h,000h,021h,032h,025h,000h,034h,02fh,02fh	; b9a5  229..9/5.!2%.4//
	defb 000h,02ch,021h,034h,025h,03dh,000h,0aah,080h,042h,0ech,09ch,08eh,000h,023h,028h	; b9b5  .,!4%=...B....#(
	defb 021h,02ch,02ch,025h,02eh,027h,025h,000h,034h,028h,025h,000h,021h,024h,036h,025h	; b9c5  !,,%.'%.4(%.!$6%
	defb 02eh,034h,035h,032h,025h,000h,000h,0aah,080h,062h,0ech,08dh,08eh,000h,02fh,02eh	; b9d5  .452%....b..../.
	defb 023h,025h,000h,02dh,02fh,032h,025h,000h,03bh,00eh,000h,081h,0aah,080h,082h,0ech	; b9e5  #%.-/2%.;.......
	defb 081h,0c7h,01ah,074h,081h,0ffh,080h,0b5h,0ech,081h,077h,080h,0d5h,0ech,081h,078h	; b9f5  ...t......w....x
	defb 080h,0f5h,0ech,081h,079h,000h	; ba05

; ----------------------------------------------------------------------
; DATOS ocho_guiones_al_azar: ocho punteros a guiones de
;   pinta_guion_con_mascara; p01:7B72 elige uno con `ld a,r / and 7`
;   (p01:7B7F)
;   0xba0b..0xba1b  (16 bytes)
DATA_ocho_guiones_al_azar:
	defb 01bh,0bah	; ba0b
	defb 028h,0bah	; ba0d
	defb 039h,0bah	; ba0f
	defb 047h,0bah	; ba11
	defb 057h,0bah	; ba13
	defb 06ch,0bah	; ba15
	defb 07dh,0bah	; ba17
	defb 08bh,0bah	; ba19

; ----------------------------------------------------------------------
; DATOS tira_BA1B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[0] (13 bytes)
;   0xba1b..0xba28  (13 bytes)
DATA_tira_BA1B:
	defb 0ebh,038h,027h,02fh,02fh,024h,000h,02ch,035h,023h,02bh,01fh,0ffh	; ba1b  .8'//$.,5#+..

; ----------------------------------------------------------------------
; DATOS tira_BA28: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[1] (17 bytes)
;   0xba28..0xba39  (17 bytes)
DATA_tira_BA28:
	defb 0e9h,038h,027h,02fh,024h,000h,022h,02ch,025h,033h,033h,000h,039h,02fh,035h,01fh	; ba28  .8'/$.",%33.9/5.
	defb 0ffh	; ba38

; ----------------------------------------------------------------------
; DATOS tira_BA39: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[2] (14 bytes)
;   0xba39..0xba47  (14 bytes)
DATA_tira_BA39:
	defb 0eah,038h,022h,025h,000h,023h,021h,032h,025h,026h,035h,02ch,01fh,0ffh	; ba39  .8"%.#!2%&5,..

; ----------------------------------------------------------------------
; DATOS tira_BA47: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[3] (16 bytes)
;   0xba47..0xba57  (16 bytes)
DATA_tira_BA47:
	defb 0e9h,038h,024h,02fh,000h,039h,02fh,035h,032h,000h,022h,025h,033h,034h,01fh,0ffh	; ba47  .8$/.9/52."%34..

; ----------------------------------------------------------------------
; DATOS tira_BA57: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[4] (21 bytes)
;   0xba57..0xba6c  (21 bytes)
DATA_tira_BA57:
	defb 0e7h,038h,022h,02fh,039h,033h,00bh,022h,025h,000h,021h,02dh,022h,029h,034h,029h	; ba57  .8"/93."%.!-")4)
	defb 02fh,035h,033h,01fh,0ffh	; ba67

; ----------------------------------------------------------------------
; DATOS tira_BA6C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[5] (17 bytes)
;   0xba6c..0xba7d  (17 bytes)
DATA_tira_BA6C:
	defb 0e9h,038h,028h,021h,033h,034h,025h,02eh,000h,033h,02ch,02fh,037h,02ch,039h,01fh	; ba6c  .8(!34%..3,/7,9.
	defb 0ffh	; ba7c

; ----------------------------------------------------------------------
; DATOS tira_BA7D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[6] (14 bytes)
;   0xba7d..0xba8b  (14 bytes)
DATA_tira_BA7D:
	defb 0ebh,038h,02eh,025h,036h,025h,032h,000h,02dh,029h,02eh,024h,01fh,0ffh	; ba7d  .8.%6%2.-).$..

; ----------------------------------------------------------------------
; DATOS tira_BA8B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (uno
;   de ocho elegidos con el registro R) que lee pinta_guion_con_mascara; lo
;   cargan p01:7B7F por 0xBA0B[7] (19 bytes)
;   0xba8b..0xba9e  (19 bytes)
DATA_tira_BA8B:
	defb 0e8h,038h,02eh,02fh,000h,030h,021h,029h,02eh,00bh,02eh,02fh,000h,027h,021h,029h	; ba8b  .8./.0!).../.'!)
	defb 02eh,01fh,0ffh	; ba9b

; ----------------------------------------------------------------------
; DATOS sprites_de_la_presentacion: cinco atributos de sprite (Y, X, patron,
;   color) que p00:5C88 copia con ldir a 0xEE80 al montar el rotulo de la
;   presentacion
;   0xba9e..0xbab2  (20 bytes)
DATA_sprites_de_la_presentacion:
	defb 037h,038h,030h,009h	; ba9e
	defb 047h,040h,034h,009h	; baa2
	defb 037h,070h,038h,009h	; baa6
	defb 037h,080h,03ch,009h	; baaa
	defb 027h,098h,040h,009h	; baae

; ----------------------------------------------------------------------
; DATOS guion_BAB2: guion comprimido que lee pinta_sin_color; lo cargan
;   p00:5C82 (487 bytes)
;   0xbab2..0xbc99  (487 bytes)
DATA_guion_BAB2:
	defb 000h,038h,017h,000h,089h,051h,000h,000h,044h,043h,049h,052h,048h,053h,011h,000h	; bab2  .8...Q..DCIRHS..
	defb 085h,042h,000h,0a0h,000h,051h,004h,000h,086h,051h,049h,055h,04eh,053h,05ch,007h	; bac2  .B...Q...QIUNS\.
	defb 000h,085h,0a0h,000h,042h,000h,051h,006h,000h,08eh,043h,000h,000h,042h,049h,04dh	; bad2  ....B.Q...C..BIM
	defb 055h,055h,048h,04eh,053h,05ah,05bh,053h,00bh,000h,081h,042h,004h,000h,081h,042h	; bae2  UUHNSZ[S...B...B
	defb 003h,000h,08ch,042h,055h,04eh,04eh,059h,053h,057h,05bh,057h,04bh,04bh,058h,00ah	; baf2  ...BUNNYSW[WKKX.
	defb 000h,08eh,0b8h,0b9h,0bah,0bbh,0bch,064h,065h,0c0h,0b5h,0b6h,0b7h,054h,04fh,059h	; bb02  .......de....TOY
	defb 003h,04bh,089h,056h,04ch,052h,043h,04ah,000h,042h,000h,051h,004h,000h,091h,071h	; bb12  .K.VLRCJ.B.Q...q
	defb 086h,084h,085h,069h,062h,063h,088h,066h,060h,061h,05eh,06eh,08bh,05fh,04ah,045h	; bb22  ...ibc.f`a^n._JE
	defb 006h,000h,09ah,042h,044h,000h,042h,000h,043h,051h,000h,067h,087h,073h,074h,075h	; bb32  ...BD.B.CQ.g.stu
	defb 06ch,089h,081h,083h,082h,0bdh,08ah,06dh,0beh,07bh,07ah,08ch,068h,007h,000h,099h	; bb42  l......m.{z.h...
	defb 046h,047h,044h,045h,047h,055h,047h,05dh,06bh,076h,077h,078h,079h,072h,06ah,041h	; bb52  FGDEGUG]kvwxyrjA
	defb 0bfh,070h,06fh,080h,07fh,07eh,07ch,07dh,08dh,007h,000h,099h,097h,091h,092h,096h	; bb62  .po..~|}........
	defb 090h,095h,055h,0cbh,047h,060h,061h,062h,063h,066h,043h,06dh,06ch,0ceh,06bh,05ch	; bb72  ..U.G`abcfCml.k\
	defb 05dh,05eh,05fh,088h,0cdh,007h,000h,098h,051h,093h,052h,094h,053h,054h,045h,0cch	; bb82  ]^_.....Q.R.STE.
	defb 046h,0cfh,065h,064h,06eh,067h,0b0h,08eh,084h,085h,086h,087h,069h,068h,06ah,089h	; bb92  F.edng......ihj.
	defb 011h,000h,08fh,070h,0b1h,08ch,044h,08bh,072h,071h,044h,050h,08fh,08dh,06fh,0b2h	; bba2  ...p..D.rqDP..o.
	defb 08ah,04fh,008h,000h,008h,076h,090h,0a0h,0a1h,0a2h,07ah,0a6h,0a7h,0aah,0a3h,0a4h	; bbb2  .O...v....z.....
	defb 0a5h,0a8h,0a9h,0abh,0ach,09fh,09eh,008h,076h,00ah,042h,08dh,0adh,083h,082h,081h	; bbc2  ........v.B.....
	defb 080h,07fh,07eh,07bh,07dh,07ch,09ah,09bh,079h,00fh,042h,08eh,04ch,04dh,04eh,042h	; bbd2  ..~{}|..y.B.LMNB
	defb 042h,075h,077h,042h,074h,099h,078h,073h,09ch,09dh,011h,042h,085h,04bh,04ah,041h	; bbe2  BuwBt.xs...B.KJA
	defb 098h,05bh,016h,042h,08ah,057h,058h,059h,05ah,042h,049h,048h,041h,0aeh,0afh,018h	; bbf2  .[.B.WXYZBIHA...
	defb 042h,088h,05eh,072h,06fh,06ch,043h,043h,068h,078h,016h,041h,005h,042h,085h,062h	; bc02  B.^rolCChx.A.B.b
	defb 043h,063h,065h,076h,004h,054h,082h,053h,070h,010h,041h,005h,042h,085h,061h,043h	; bc12  Ccev.T.Sp.A.B.aC
	defb 043h,067h,05dh,004h,042h,084h,060h,075h,06dh,044h,003h,045h,083h,046h,047h,048h	; bc22  Cg].B.`umD.E.FGH
	defb 008h,041h,004h,042h,086h,06bh,066h,064h,043h,079h,07ah,00ch,042h,08ah,05fh,073h	; bc32  .A.B.kfdCyz.B._s
	defb 06eh,049h,041h,041h,077h,074h,04fh,044h,003h,042h,087h,051h,069h,06ah,07bh,07ch	; bc42  nIAAwtOD.B.Qij{|
	defb 07dh,07eh,00eh,05ah,0a1h,057h,05ch,04ah,042h,042h,071h,042h,042h,07fh,052h,050h	; bc52  }~.Z.W\JBBqBB.RP
	defb 041h,04eh,04dh,04bh,04ch,042h,055h,030h,035h,033h,028h,042h,033h,030h,021h,023h	; bc62  ANMKLBU053(B30!#
	defb 025h,042h,02bh,025h,039h,059h,007h,042h,084h,080h,081h,082h,083h,005h,042h,081h	; bc72  %B+%9Y.B......B.
	defb 05bh,00eh,056h,081h,058h,019h,042h,08eh,01ah,02bh,02fh,02eh,021h,02dh,029h,042h	; bc82  [.V.X.B..+/.!-)B
	defb 011h,019h,018h,016h,042h,042h,000h	; bc92

; ----------------------------------------------------------------------
; DATOS ocho_sprites_BC99: ocho atributos de sprite que p01:7DC7 copia con
;   ldir a 0xEEE0, los sprites 24 a 31
;   0xbc99..0xbcb9  (32 bytes)
DATA_ocho_sprites_BC99:
	defb 0f8h,000h,04ch,000h	; bc99
	defb 0f8h,000h,04ch,000h	; bc9d
	defb 0f8h,000h,04ch,000h	; bca1
	defb 0f8h,000h,04ch,000h	; bca5
	defb 008h,000h,04ch,000h	; bca9
	defb 008h,000h,04ch,000h	; bcad
	defb 008h,000h,04ch,000h	; bcb1
	defb 008h,000h,04ch,000h	; bcb5

; ----------------------------------------------------------------------
; DATOS ocho_sprites_BCB9: los otros ocho que p01:7DE9 copia al mismo sitio,
;   0xEEE0
;   0xbcb9..0xbcd9  (32 bytes)
DATA_ocho_sprites_BCB9:
	defb 0b4h,000h,04ch,000h	; bcb9
	defb 0b4h,000h,04ch,000h	; bcbd
	defb 0b4h,000h,04ch,000h	; bcc1
	defb 0b4h,000h,04ch,000h	; bcc5
	defb 0c4h,000h,04ch,000h	; bcc9
	defb 0c4h,000h,04ch,000h	; bccd
	defb 0c4h,000h,04ch,000h	; bcd1
	defb 0c4h,000h,04ch,000h	; bcd5

; ----------------------------------------------------------------------
; DATOS relleno_del_banco_13: 807 bytes a 0xFF hasta el final de los 8 KB del
;   banco: espacio libre
;   0xbcd9..0xc000  (807 bytes)
DATA_relleno_del_banco_13:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bce9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcf9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bda9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bde9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdf9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bea9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bec9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bed9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bee9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bef9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf09  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf29  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf39  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf49  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf59  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf69  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf79  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf89  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf99  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff9
