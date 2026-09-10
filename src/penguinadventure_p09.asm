; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 09 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS sin identificar  0xa000..0xa83f  (2111 bytes)
DATA_A000:
	defb 080h,005h,000h,084h,0ffh,0f8h,0e0h,0e0h,003h,0c0h,086h,080h,0fch,0f0h,0e0h,0c0h	; a000  ................
	defb 0c0h,003h,080h,081h,001h,007h,000h,081h,080h,00ch,000h,084h,042h,000h,040h,080h	; a010  ............B.@.
	defb 007h,000h,081h,010h,007h,000h,010h,0ffh,080h,008h,00ah,008h,041h,010h,046h,008h	; a020  ............A.F.
	defb 0f0h,008h,070h,010h,060h,038h,041h,008h,090h,008h,0f5h,030h,040h,028h,0f4h,03fh	; a030  ..p.`8A....0@(.?
	defb 096h,081h,066h,040h,096h,010h,065h,010h,0f6h,005h,060h,003h,0f0h,010h,0f5h,020h	; a040  ..f@..e...`....
	defb 054h,018h,074h,01fh,087h,081h,075h,006h,087h,002h,075h,007h,087h,081h,075h,007h	; a050  T.t...u...u...u.
	defb 087h,081h,075h,004h,087h,003h,075h,081h,074h,007h,087h,081h,074h,007h,087h,081h	; a060  ..u...u.t...t...
	defb 075h,003h,0f6h,005h,0f5h,003h,096h,081h,066h,004h,0f6h,006h,096h,002h,0f6h,007h	; a070  u.......f.......
	defb 096h,081h,065h,004h,096h,004h,090h,081h,060h,005h,090h,002h,060h,002h,096h,004h	; a080  ..e.....`...`...
	defb 0f9h,002h,0f0h,002h,065h,006h,0f5h,003h,065h,005h,0f5h,002h,065h,006h,0f5h,004h	; a090  ....e...e...e...
	defb 065h,004h,0f5h,081h,0f6h,007h,0f5h,006h,040h,084h,070h,040h,040h,070h,009h,040h	; a0a0  e.......@.p@@p.@
	defb 081h,070h,005h,040h,081h,070h,008h,040h,081h,070h,006h,040h,081h,070h,007h,040h	; a0b0  .p.@.p.@.p.@.p.@
	defb 081h,070h,009h,040h,081h,0b4h,004h,040h,002h,041h,006h,0f1h,003h,075h,005h,054h	; a0c0  .p.@...@.A...u.T
	defb 005h,075h,003h,074h,003h,075h,005h,054h,081h,075h,007h,074h,081h,054h,007h,074h	; a0d0  .u.t.u.T.u.t.T.t
	defb 002h,0f5h,082h,045h,075h,004h,045h,002h,0f0h,004h,074h,087h,075h,074h,0f5h,0f5h	; a0e0  ...Eu.E...t.ut..
	defb 045h,075h,074h,003h,045h,002h,0f4h,004h,074h,086h,075h,074h,0f8h,0f8h,084h,087h	; a0f0  Eut.E...t.ut....
	defb 004h,075h,002h,0f8h,081h,084h,005h,087h,083h,0ffh,0f8h,084h,005h,087h,002h,0f8h	; a100  .u..............
	defb 081h,084h,005h,087h,002h,0f8h,081h,084h,005h,087h,002h,0f8h,081h,084h,005h,087h	; a110  ................
	defb 002h,0f8h,081h,084h,005h,087h,002h,0ffh,081h,084h,005h,087h,002h,0f8h,081h,084h	; a120  ................
	defb 005h,087h,002h,0ffh,081h,044h,005h,087h,003h,0f4h,081h,074h,004h,087h,083h,075h	; a130  .....D.....t...u
	defb 074h,074h,005h,084h,004h,0f1h,004h,0a1h,002h,0f4h,006h,0a4h,004h,096h,084h,066h	; a140  tt.............f
	defb 065h,065h,0f5h,004h,096h,081h,065h,003h,0f5h,002h,096h,002h,065h,004h,0f5h,008h	; a150  ee....e.....e...
	defb 0a0h,010h,0a6h,008h,0a0h,002h,0a6h,006h,0a0h,002h,0a6h,016h,0a0h,014h,0f6h,002h	; a160  ................
	defb 0a6h,002h,0a0h,004h,0f6h,002h,0a6h,002h,0a0h,008h,0b0h,018h,0f0h,020h,070h,006h	; a170  ............. p.
	defb 0f0h,002h,070h,004h,0f0h,004h,070h,010h,0a0h,008h,040h,008h,0a0h,008h,000h,010h	; a180  ..p...p...@.....
	defb 066h,080h,008h,032h,008h,000h,008h,0ffh,00ch,000h,004h,0ffh,005h,000h,003h,0ffh	; a190  f..2............
	defb 006h,000h,002h,0ffh,007h,000h,081h,0ffh,007h,000h,081h,0f8h,006h,000h,083h,080h	; a1a0  ................
	defb 0feh,000h,007h,0ffh,002h,000h,082h,00fh,03fh,004h,0ffh,081h,00fh,007h,0ffh,004h	; a1b0  ........?.......
	defb 000h,084h,001h,01fh,0ffh,0ffh,006h,000h,082h,001h,01fh,003h,000h,006h,0ffh,082h	; a1c0  ................
	defb 0f8h,0c0h,005h,000h,006h,0ffh,082h,0fch,0e0h,003h,0ffh,083h,0feh,0f0h,080h,004h	; a1d0  ................
	defb 000h,081h,0fch,005h,0ffh,002h,000h,006h,0ffh,008h,0fch,083h,0ffh,000h,000h,00ch	; a1e0  ................
	defb 0ffh,081h,07fh,003h,03fh,005h,0ffh,008h,03fh,007h,0ffh,081h,000h,003h,0fch,005h	; a1f0  ....?...?.......
	defb 0ffh,082h,0f0h,080h,006h,0ffh,007h,0f7h,084h,0efh,0ffh,0feh,0fch,008h,0ffh,081h	; a200  ................
	defb 0f8h,004h,0ffh,082h,0f0h,0fch,006h,0ffh,006h,0e0h,002h,0c0h,008h,0f0h,003h,004h	; a210  ................
	defb 003h,002h,002h,001h,006h,000h,002h,080h,003h,007h,003h,003h,002h,001h,002h,0c0h	; a220  ................
	defb 002h,080h,004h,000h,002h,080h,093h,040h,030h,009h,007h,007h,003h,00fh,006h,003h	; a230  .......@0.......
	defb 000h,007h,00fh,00fh,007h,0fch,0f8h,0f8h,0f0h,0c0h,003h,000h,083h,001h,007h,03fh	; a240  ...............?
	defb 00ch,0ffh,081h,0feh,008h,0f8h,084h,080h,0c0h,0e0h,0e0h,004h,0ffh,003h,000h,089h	; a250  ................
	defb 080h,0c0h,0f0h,0ffh,0ffh,080h,080h,0c0h,0c0h,004h,0ffh,003h,000h,086h,0e0h,0fch	; a260  ................
	defb 0feh,0f8h,003h,0fch,007h,0ffh,083h,0f0h,006h,05bh,005h,0ffh,088h,0feh,0f8h,005h	; a270  .........[......
	defb 06bh,007h,0f0h,0ffh,0ffh,003h,000h,089h,07fh,0ffh,00fh,007h,0b0h,017h,02bh,03fh	; a280  k.............+?
	defb 0f8h,004h,0ffh,002h,0f0h,006h,0f7h,004h,000h,08eh,001h,003h,007h,00fh,00fh,0f0h	; a290  ................
	defb 0c0h,07fh,0c0h,0c0h,0e0h,0e0h,003h,001h,005h,000h,08bh,003h,0efh,00fh,01fh,03fh	; a2a0  ...............?
	defb 03fh,07fh,01fh,01fh,0f0h,0fch,006h,0ffh,083h,000h,007h,01fh,005h,000h,08ah,03fh	; a2b0  ?..............?
	defb 0ffh,087h,000h,000h,001h,01fh,0ffh,00fh,00fh,003h,07fh,002h,0ffh,081h,0feh,006h	; a2c0  ................
	defb 0ffh,084h,0feh,0f8h,0e0h,080h,004h,000h,082h,081h,0ffh,005h,000h,087h,01fh,0ffh	; a2d0  ................
	defb 0ffh,000h,000h,001h,01fh,004h,0ffh,082h,001h,01fh,006h,0ffh,080h,008h,012h,010h	; a2e0  ................
	defb 0f4h,008h,0f1h,07fh,0f4h,009h,0f4h,038h,0f0h,010h,0f7h,018h,0f5h,010h,0f1h,008h	; a2f0  .......8........
	defb 041h,008h,0a1h,008h,0e1h,008h,0f1h,004h,041h,004h,0e1h,003h,0a1h,081h,0f1h,004h	; a300  A.......A.......
	defb 0e1h,003h,0f1h,005h,0f4h,081h,0a1h,007h,041h,008h,0f1h,004h,041h,004h,0f1h,004h	; a310  ........A...A...
	defb 074h,004h,0f7h,006h,074h,002h,0ffh,004h,074h,00ah,0f4h,083h,0f7h,075h,075h,008h	; a320  t...t...t....uu.
	defb 0f5h,003h,075h,004h,0f5h,082h,0f4h,0f7h,003h,075h,003h,0f7h,005h,0f4h,002h,0f5h	; a330  ..u......u......
	defb 004h,075h,005h,0f7h,002h,0f4h,006h,0f7h,005h,0f4h,003h,074h,088h,041h,0a4h,0a4h	; a340  .u.........t.A..
	defb 041h,0e4h,0e4h,0f4h,0f4h,007h,0e1h,084h,0a1h,0f7h,0feh,0feh,003h,0f1h,083h,0fah	; a350  A...............
	defb 0f1h,0a1h,007h,041h,002h,0a1h,081h,0a4h,005h,0f4h,083h,0a1h,0aah,0a4h,005h,0f4h	; a360  ...A............
	defb 003h,0fah,004h,0f4h,081h,0f0h,028h,0f4h,080h,080h,018h,017h,000h,081h,0c0h,00eh	; a370  ......(.........
	defb 000h,002h,001h,00eh,000h,002h,0c0h,00eh,000h,083h,001h,003h,001h,00dh,000h,083h	; a380  ................
	defb 0c0h,0e0h,0c0h,00eh,000h,081h,001h,00ch,000h,003h,080h,081h,0c0h,003h,080h,00bh	; a390  ................
	defb 000h,083h,001h,007h,001h,009h,000h,004h,080h,083h,0c0h,0f0h,0c0h,004h,080h,009h	; a3a0  ................
	defb 000h,083h,001h,01fh,001h,007h,000h,006h,080h,083h,0c0h,0fch,0c0h,006h,080h,00ah	; a3b0  ................
	defb 000h,084h,080h,020h,002h,009h,00fh,000h,08bh,040h,0a0h,00ch,000h,000h,010h,000h	; a3c0  ... .....@......
	defb 000h,002h,020h,005h,00eh,000h,086h,020h,000h,021h,004h,040h,002h,005h,000h,084h	; a3d0  .. .... .!.@....
	defb 01eh,00ch,003h,001h,00ch,000h,098h,00fh,07fh,0ffh,0feh,0f8h,03dh,07fh,07fh,03fh	; a3e0  ............=..?
	defb 03eh,030h,003h,01fh,0ffh,07fh,07eh,03eh,03eh,03fh,01fh,01fh,013h,007h,001h,008h	; a3f0  >0....~>>?......
	defb 000h,08dh,03fh,03eh,07fh,0ffh,0fch,0f8h,0f0h,0e3h,04fh,03fh,0ffh,07fh,01eh,008h	; a400  ..?>......O?....
	defb 000h,098h,001h,003h,007h,00fh,037h,077h,0ebh,0ffh,0ffh,0feh,0fch,03fh,03fh,07fh	; a410  ......7w.....??.
	defb 07fh,0ffh,0ffh,0feh,0fch,0f8h,0f0h,0e0h,0c0h,080h,003h,000h,002h,0fch,08bh,0feh	; a420  ................
	defb 0fch,0fdh,0fdh,07ah,03fh,01fh,00fh,007h,003h,001h,008h,000h,086h,080h,0c0h,0e0h	; a430  ...z?...........
	defb 0f0h,0fch,0feh,003h,0ffh,082h,07fh,03fh,006h,000h,002h,001h,003h,003h,003h,007h	; a440  .......?........
	defb 002h,00fh,083h,060h,07ch,07fh,004h,0ffh,089h,0f9h,0f3h,0f3h,0f7h,0e7h,0efh,0ffh	; a450  ...`|...........
	defb 0ffh,0beh,000h,008h,022h,088h,07eh,03dh,01eh,01eh,01fh,01bh,01bh,019h,080h,0a0h	; a460  ....".~=........
	defb 022h,088h,0a5h,01ah,052h,048h,000h,0bdh,01ah,094h,080h,0e8h,022h,004h,000h,084h	; a470  "...RH......"...
	defb 048h,000h,0c0h,000h,008h,034h,002h,040h,006h,000h,008h,034h,008h,028h,082h,083h	; a480  H....4.@...4.(..
	defb 003h,004h,083h,002h,003h,089h,0d2h,0eah,06ah,072h,032h,03ah,05eh,05eh,001h,004h	; a490  ........jr2:^^..
	defb 000h,083h,0a3h,04eh,09ch,005h,000h,08bh,0f8h,01dh,0eah,00ah,004h,080h,0fdh,01ah	; a4a0  ...N............
	defb 07ah,01ah,01ah,010h,000h,002h,0d0h,091h,0d2h,0feh,0c2h,0dch,0d0h,0d0h,0fdh,01ah	; a4b0  z...............
	defb 0eah,084h,080h,094h,0f4h,014h,01eh,00dh,00dh,003h,016h,08fh,023h,0a3h,0d1h,0d3h	; a4c0  ............#...
	defb 0ffh,000h,0feh,000h,001h,007h,034h,07ah,0fdh,001h,07fh,003h,000h,08ch,01eh,01fh	; a4d0  ......4z........
	defb 01bh,01bh,019h,019h,01ah,01ah,0fdh,01ah,06ah,044h,004h,040h,084h,0ffh,063h,05fh	; a4e0  ........jD.@..c_
	defb 023h,004h,003h,008h,000h,088h,05fh,08eh,086h,086h,006h,006h,00fh,016h,008h,000h	; a4f0  #....._.........
	defb 085h,034h,07ah,0fdh,001h,07fh,004h,000h,084h,001h,003h,000h,001h,003h,000h,083h	; a500  .4z.............
	defb 083h,001h,000h,003h,080h,085h,060h,0d0h,0fch,0c7h,0d9h,005h,0d0h,084h,01fh,00eh	; a510  ......`.........
	defb 0a6h,0d7h,003h,0d3h,089h,0d1h,043h,082h,082h,046h,045h,045h,0adh,0aah,008h,000h	; a520  ......C..FEE....
	defb 002h,074h,083h,034h,004h,01ch,003h,000h,082h,081h,0d0h,003h,0e8h,095h,0d0h,0a0h	; a530  .t.4............
	defb 041h,0ffh,0e1h,06eh,068h,068h,069h,0ffh,061h,03fh,0f1h,06eh,068h,068h,069h,067h	; a540  A..nhhi.a?.nhhig
	defb 0ffh,07ah,034h,006h,028h,080h,000h,024h,082h,0fah,074h,006h,034h,002h,04eh,083h	; a550  .z4.(..$..t.4.N.
	defb 0a6h,020h,0e3h,003h,000h,085h,01ah,0ddh,0feh,000h,0ffh,003h,000h,085h,09dh,08eh	; a560  . ..............
	defb 083h,084h,083h,003h,000h,004h,034h,084h,07fh,0b8h,077h,034h,003h,068h,084h,0c9h	; a570  ......4...w4.h..
	defb 012h,061h,080h,011h,000h,081h,099h,006h,0bah,08eh,09ah,043h,047h,0afh,020h,007h	; a580  .a.........CG. .
	defb 0a0h,0a0h,040h,028h,050h,090h,060h,080h,003h,000h,088h,094h,054h,054h,094h,094h	; a590  ..@(P.`.....TT..
	defb 0d4h,0f4h,0f4h,008h,000h,085h,0c0h,0a0h,0a0h,040h,000h,003h,040h,080h,0a8h,025h	; a5a0  .........@..@..%
	defb 005h,000h,093h,07ah,034h,028h,000h,000h,042h,000h,000h,0fdh,07ah,034h,057h,0a9h	; a5b0  ...z4(..B...z4W.
	defb 080h,052h,000h,07eh,03dh,01eh,005h,000h,083h,0ffh,070h,036h,005h,000h,083h,023h	; a5c0  .R.~=.....p6...#
	defb 0d1h,068h,005h,000h,083h,0ffh,0c3h,0ddh,005h,000h,083h,0afh,047h,043h,005h,000h	; a5d0  .h..........GC..
	defb 088h,0d7h,0a3h,0d2h,014h,01ah,08fh,080h,087h,003h,000h,085h,01ah,03ah,07dh,001h	; a5e0  .............:}.
	defb 03fh,003h,000h,088h,0bdh,01ah,094h,094h,054h,054h,094h,094h,005h,000h,083h,07ah	; a5f0  ?.......TT.....z
	defb 074h,034h,080h,008h,002h,008h,0a0h,080h,0a0h,002h,004h,040h,004h,0a0h,080h,0e8h	; a600  t4.........@....
	defb 002h,008h,040h,008h,0a0h,008h,040h,020h,0a0h,004h,0f0h,07fh,0a0h,05dh,0a0h,080h	; a610  ..@...@ .....]..
	defb 000h,004h,070h,0a0h,080h,0a8h,005h,008h,0a0h,004h,040h,004h,0a0h,004h,040h,04ch	; a620  ..p.......@...@L
	defb 0a0h,080h,018h,02ah,088h,0e4h,080h,080h,08ah,09ah,0fdh,001h,0ffh,080h,030h,02ah	; a630  ...*..........0*
	defb 084h,040h,0a0h,020h,0c0h,004h,000h,088h,061h,057h,04dh,0cah,084h,0a1h,0a0h,040h	; a640  .@. ....aWM....@
	defb 080h,078h,02ah,008h,000h,080h,0e0h,02ah,003h,034h,086h,014h,01ah,00fh,000h,007h	; a650  .x*....*.4......
	defb 029h,003h,028h,094h,050h,091h,060h,080h,063h,0edh,069h,068h,0e8h,0f4h,004h,0fch	; a660  ).(.P.`.c.ih....
	defb 040h,0a0h,0a0h,0d0h,0d0h,0e9h,068h,074h,003h,0a0h,085h,0d0h,0d1h,0ebh,008h,0f9h	; a670  @.....ht........
	defb 003h,0d0h,095h,0d1h,0d7h,0fch,001h,0feh,0d1h,0d1h,0d0h,0a0h,020h,041h,080h,000h	; a680  ............ A..
	defb 0aah,0dah,0d4h,0d4h,0f4h,0fah,002h,0feh,010h,000h,081h,00eh,003h,006h,084h,00eh	; a690  ................
	defb 01fh,000h,00fh,018h,000h,085h,03ah,034h,028h,010h,020h,003h,000h,004h,040h,08dh	; a6a0  ......:4(. ...@.
	defb 0a0h,0d0h,010h,0f0h,0d4h,0f4h,0f4h,074h,074h,034h,004h,01ch,019h,003h,01ah,084h	; a6b0  .......tt4......
	defb 03ah,07dh,001h,01fh,006h,000h,085h,01ch,07eh,090h,0f8h,0fch,005h,0ffh,005h,000h	; a6c0  :}......~.......
	defb 002h,00fh,081h,01fh,080h,0d0h,02bh,01fh,0ffh,081h,0f8h,006h,0ffh,082h,0efh,0f3h	; a6d0  ......+.........
	defb 007h,0ffh,081h,08fh,007h,0ffh,081h,0c1h,004h,0ffh,084h,0cfh,0f3h,0c9h,007h,007h	; a6e0  ................
	defb 0ffh,081h,08eh,007h,0ffh,089h,003h,0e0h,0f0h,0fah,07bh,03bh,077h,0ffh,0ffh,004h	; a6f0  ..........{;w...
	defb 000h,084h,080h,0c0h,0e0h,0f9h,006h,000h,082h,080h,0c0h,007h,000h,082h,003h,0eeh	; a700  ................
	defb 003h,068h,084h,0e9h,0ffh,000h,0ffh,00ah,000h,002h,0c0h,088h,0f0h,0f8h,0fch,0feh	; a710  .h..............
	defb 01fh,01fh,08eh,0dfh,004h,0ffh,09bh,003h,00fh,03fh,007h,007h,0d1h,0ffh,0ffh,007h	; a720  .........?......
	defb 00fh,0f1h,0e1h,0c3h,0ceh,019h,0ffh,00fh,00fh,01fh,03fh,006h,01ch,0bch,071h,0e6h	; a730  ..........?...q.
	defb 0f7h,0efh,004h,0ffh,081h,0feh,080h,010h,02dh,007h,0ffh,081h,091h,050h,0ffh,088h	; a740  ........-....P..
	defb 00fh,01fh,007h,003h,003h,001h,000h,000h,080h,080h,02dh,005h,000h,083h,01fh,03fh	; a750  ..........-....?
	defb 017h,004h,000h,082h,00fh,007h,002h,0ffh,002h,000h,086h,003h,01fh,005h,08fh,0dfh	; a760  ................
	defb 0ffh,080h,058h,02eh,005h,000h,002h,001h,002h,003h,085h,007h,006h,008h,003h,00ch	; a770  ..X.............
	defb 002h,000h,081h,040h,002h,000h,002h,0a0h,083h,0d0h,010h,0f0h,004h,003h,084h,007h	; a780  ...@............
	defb 00fh,000h,00fh,008h,000h,080h,018h,00ah,008h,0a0h,080h,030h,00ah,010h,0a0h,080h	; a790  ...........0....
	defb 078h,00ah,008h,0a0h,080h,0e0h,00ah,070h,0a0h,020h,0a0h,018h,0f0h,080h,0d0h,00bh	; a7a0  x......p. ......
	defb 002h,0ffh,081h,044h,03ch,075h,009h,074h,008h,075h,003h,0f0h,005h,0f5h,010h,0f0h	; a7b0  ...D<u.t.u......
	defb 008h,050h,010h,0a0h,008h,0f0h,002h,050h,006h,0f5h,003h,050h,005h,0f5h,002h,050h	; a7c0  .P.....P...P...P
	defb 006h,0f5h,004h,050h,004h,0f5h,081h,0f0h,007h,0f5h,080h,010h,00dh,002h,0ffh,081h	; a7d0  ...P............
	defb 044h,005h,075h,002h,0ffh,081h,044h,005h,077h,002h,0ffh,081h,044h,005h,077h,002h	; a7e0  D.u...D.w...D.w.
	defb 0ffh,081h,044h,005h,077h,002h,0ffh,081h,044h,005h,077h,002h,0ffh,081h,044h,005h	; a7f0  ..D.w...D.w...D.
	defb 077h,002h,0ffh,081h,044h,005h,077h,002h,0ffh,081h,044h,005h,077h,002h,0ffh,081h	; a800  w...D.w...D.w...
	defb 044h,005h,077h,002h,0ffh,081h,044h,005h,077h,002h,0ffh,081h,044h,005h,077h,081h	; a810  D.w...D.w...D.w.
	defb 075h,007h,074h,080h,080h,00dh,007h,050h,081h,0f5h,005h,050h,003h,0f5h,004h,050h	; a820  u.t....P...P...P
	defb 004h,0f5h,080h,058h,00eh,028h,0a0h,080h,080h,019h,060h,000h,040h,000h,000h	; a830  ...X.(....`.@..

; ======================================================================
; CODIGO 0xa83f..0xa8d1  (146 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL GUION DE LA FASE: QUE SALE Y CUANDO. Aqui esta escrito lo que uno se encuentra al avanzar. La tabla de 0xA8FB lleva un puntero por fase y detras va una lista de PAREJAS -que objeto y cuanto hay que andar hasta el siguiente-, cerrada con 0xFF. La distancia va en BCD, y de ahi el `daa` de 0xA88B: se resta en decimal, no en binario.
; Lo que dispara todo es la comparacion de 0xA84B: (0xE08D) es la distancia a la que toca el objeto siguiente y (0xE301) lo andado; cuando coinciden, sale. Y hay tres huecos de objeto, de 0x20 bytes cada uno, a partir de 0xE310: si los tres estan ocupados, el objeto sencillamente no aparece.
; ----------------------------------------------------------------------
saca_lo_que_toque:
	ld a,(0e0a2h)		;a83f   ; el modo en el que esta el juego
	and a			;a842
	ret nz			;a843   ; si no es el de jugar, no sale nada
	ld de,(0e08dh)		;a844   ; la distancia a la que toca el objeto siguiente
	ld hl,(0e301h)		;a848   ; y lo andado
	rst 20h			;a84b   ; DCOMPR: ¿hemos llegado?
	ret nz			;a84c   ; si no, a esperar
	ld a,(0e092h)		;a84d   ; la fase, de 1 a 13
	dec a			;a850   ; las tablas van desde 1
	ld l,a			;a851
	ld h,000h		;a852
	ld de,0a8fbh		;a854   ; la tabla de guiones, un puntero por fase
	add hl,hl			;a857   ; dos bytes por entrada
	add hl,de			;a858
	ld e,(hl)			;a859   ; y ahi esta el guion de esta fase
	inc hl			;a85a
	ld d,(hl)			;a85b
	ld hl,0e300h		;a85c   ; por que pareja del guion va
	ld a,(hl)			;a85f
	inc (hl)			;a860   ; la siguiente, para la proxima
	add a,a			;a861   ; dos bytes por pareja
	add a,e			;a862
	ld e,a			;a863
	jr nc,L_A867		;a864
	inc d			;a866
L_A867:
	ld a,(de)			;a867   ; el primer byte: QUE objeto
	ld c,a			;a868
	push de			;a869
	ld hl,0e310h		;a86a   ; los tres huecos de objeto
	ld de,00020h		;a86d   ; 0x20 bytes cada uno
	xor a			;a870
	ld b,003h		;a871   ; tres
busca_hueco_libre:
	cp (hl)			;a873   ; ¿esta libre?
	jr nz,L_A87B		;a874
	call mete_el_objeto		;a876   ; si lo esta, se mete ahi
	jr lee_la_distancia_siguiente		;a879
L_A87B:
	add hl,de			;a87b   ; y si no, al hueco siguiente
	djnz busca_hueco_libre		;a87c
lee_la_distancia_siguiente:
	pop de			;a87e
	inc de			;a87f   ; el segundo byte de la pareja
	ld a,(de)			;a880
	cp 0ffh		;a881   ; 0xFF cierra el guion: ya no sale nada mas
	jr z,se_acabo_el_guion		;a883
	ld c,a			;a885   ; y si no, es cuanto hay que andar
	ld hl,(0e08dh)		;a886   ; la distancia de ahora
	ld a,l			;a889
	sub c			;a88a   ; menos la que dice el guion
	daa			;a88b   ; EN BCD: por eso el `daa`
	ld l,a			;a88c
	jr nc,L_A894		;a88d
	ld a,h			;a88f   ; y el byte alto, con su acarreo
	sub 001h		;a890
	daa			;a892
	ld h,a			;a893
L_A894:
	ld (0e301h),hl		;a894
	ret			;a897
se_acabo_el_guion:
	ld hl,0ffffh		;a898   ; 0xFFFF: una distancia a la que no se llega nunca
	ld (0e301h),hl		;a89b   ; y con eso el guion no vuelve a disparar
	ret			;a89e

; ----------------------------------------------------------------------
; METER UN OBJETO EN SU HUECO. Los huecos son de 0x20 bytes y empiezan en 0xE310. Se borra el hueco entero menos el primer byte -que lleva el tipo- y se salta a la rutina del objeto por la tabla de 0xA8D1, que son las QUINCE clases que este cartucho sabe sacar.
; ----------------------------------------------------------------------
mete_el_objeto:
	push hl			;a89f   ; IX apunta al hueco
	pop ix		;a8a0
	ld a,c			;a8a2   ; el tipo de objeto
	and a			;a8a3   ; el cero no es ningun objeto
	ret z			;a8a4
	cp 005h		;a8a5   ; el 5 y el 11 no se apuntan en el primer byte
	jr z,borra_el_hueco		;a8a7
	cp 00bh		;a8a9
	jr z,borra_el_hueco		;a8ab
	ld (hl),c			;a8ad   ; y los demas si
borra_el_hueco:
	inc l			;a8ae
	xor a			;a8af
	ld b,01fh		;a8b0   ; los 31 bytes que quedan del hueco
borra_el_hueco_bucle:
	ld (hl),a			;a8b2
	inc l			;a8b3
	djnz borra_el_hueco_bucle		;a8b4
	ld a,c			;a8b6   ; el tipo otra vez
	cp 005h		;a8b7   ; el 5 se salta este paso
	jr z,salta_a_la_rutina_del_objeto		;a8b9
	ld a,l			;a8bb
	sub 00eh		;a8bc   ; catorce bytes atras
	ld l,a			;a8be
	ld (hl),001h		;a8bf   ; y ahi una marca de que el hueco esta vivo
salta_a_la_rutina_del_objeto:
	ld a,c			;a8c1   ; el tipo
	dec a			;a8c2   ; la tabla va desde 1
	add a,a			;a8c3   ; dos bytes por entrada
	ld hl,0a8d1h		;a8c4   ; LA TABLA DE LAS QUINCE CLASES DE OBJETO
L_A8C7:
	add a,l			;a8c7
	ld l,a			;a8c8
	jr nc,L_A8CC		;a8c9
	inc h			;a8cb
L_A8CC:
	ld e,(hl)			;a8cc   ; y de ahi sale a que rutina hay que ir
	inc hl			;a8cd
	ld d,(hl)			;a8ce
	ex de,hl			;a8cf
	jp (hl)			;a8d0

; ----------------------------------------------------------------------
; DATOS tabla_de_objetos: Las QUINCE clases de objeto que el guion puede
;   sacar, cada una con la rutina que la monta: 0xB581, 0xB60A, 0xB60C,
;   0xB60E, 0xB610, 0xB6F4, 0xB873, 0xB909, 0xB90B, 0xBAE0, 0xBB9B, 0xBCBF,
;   0xBD0F, 0xBE01 y 0xBE52. Que son quince y no mas lo dice la propia tabla:
;   la palabra numero dieciseis vale 0x0F21, que no es ni una direccion del
;   cartucho.
;   0xa8d1..0xa8ef  (30 bytes)
DATA_tabla_de_objetos:
	defw 0b581h	; a8d1  -> L_B581
	defw 0b60ah	; a8d3  -> L_B60A
	defw 0b60ch	; a8d5  -> L_B60C
	defw 0b60eh	; a8d7  -> L_B60E
	defw 0b610h	; a8d9  -> L_B610
	defw 0b6f4h	; a8db  -> L_B6F4
	defw 0b873h	; a8dd  -> L_B873
	defw 0b909h	; a8df  -> L_B909
	defw 0b90bh	; a8e1  -> L_B90B
	defw 0bae0h	; a8e3  -> L_BAE0
	defw 0bb9bh	; a8e5  -> L_BB9B
	defw 0bcbfh	; a8e7  -> L_BCBF
	defw 0bd0fh	; a8e9  -> L_BD0F
	defw 0be01h	; a8eb  -> L_BE01
	defw 0be52h	; a8ed  -> L_BE52

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa8ef..0xa92b  (60 bytes)
DATA_A8EF:
	defb 021h,00fh,0e3h,07eh,0a7h,0c8h,036h,000h,04fh,0c3h,06ah,0a8h,0c8h,0adh,0c9h,0adh	; a8ef  !..~..6.O.j.....
	defb 0cah,0adh,0feh,0adh,0ffh,0adh,023h,0aeh,05fh,0aeh,095h,0aeh,0cfh,0aeh,00dh,0afh	; a8ff  ......#._.......
	defb 051h,0afh,08dh,0afh,0e9h,0afh,00fh,0b0h,05dh,0b0h,0c9h,0b0h,04fh,0b1h,093h,0b1h	; a90f  Q.......]...O...
	defb 0f7h,0b1h,0a1h,0b2h,0fdh,0b2h,09fh,0b3h,049h,0b4h,0c1h,0b4h	; a91f  ........I...

; ======================================================================
; CODIGO 0xa92b..0xa98a  (95 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LOS TRES OBJETOS. Cuatro pasos por objeto y en este orden: la rutina propia de su clase, mover, calcular donde cae en la pantalla y mirar si se ha ido. Los tres huecos se recorren con IX, sumandole 0x20.
; ----------------------------------------------------------------------
atiende_los_objetos:
	ld ix,0e310h		;a92b   ; el primer hueco
	ld b,003h		;a92f   ; tres
atiende_los_objetos_vuelta:
	push bc			;a931
	ld a,(ix+000h)		;a932   ; la clase
	and a			;a935   ; cero es hueco libre
	jr z,L_A944		;a936
	call rutina_propia_de_la_clase		;a938   ; lo que sea propio de su clase
	call mueve_el_objeto		;a93b   ; moverlo
	call calcula_la_posicion		;a93e   ; donde cae en la pantalla
	call quita_si_se_ha_ido		;a941   ; y si se ha ido, quitarlo
L_A944:
	pop bc			;a944
	ld de,00020h		;a945   ; 0x20 bytes de un hueco al siguiente
	add ix,de		;a948
	djnz atiende_los_objetos_vuelta		;a94a
	ret			;a94c

; ----------------------------------------------------------------------
; ¿SE HA IDO? Tres topes, uno por coordenada: 0xC000 en X, 0xF000 en Y y 0xA800 en Z. Basta con pasarse de uno para que el hueco quede libre. Ojo con la Z: pasarse por ARRIBA es alejarse tanto que ya no se ve.
; ----------------------------------------------------------------------
quita_si_se_ha_ido:
	ld a,(ix+007h)		;a94d   ; la X, byte alto
	cp 0c0h		;a950   ; el tope
	jr nc,quita_el_objeto		;a952
	ld a,(ix+009h)		;a954   ; la Y
	cp 0f0h		;a957
	jr nc,quita_el_objeto		;a959
	ld a,(ix+00bh)		;a95b   ; y la Z, la profundidad
	cp 0a8h		;a95e
	ret c			;a960   ; dentro de los tres topes, se queda
quita_el_objeto:
	ld (ix+000h),000h		;a961   ; hueco libre
	ret			;a965

; ----------------------------------------------------------------------
; DONDE CAE EN LA PANTALLA. La columna sale de restarle la profundidad a la X y quedarse con el byte alto, que es lo que da la perspectiva: cuanto mas lejos esta una cosa, mas se va hacia el centro. La fila es el byte alto de la Y, sin mas.
; ----------------------------------------------------------------------
calcula_la_posicion:
	ld l,(ix+006h)		;a966   ; la X
	ld h,(ix+007h)		;a969
	ld e,(ix+00ah)		;a96c   ; y la Z
	ld d,(ix+00bh)		;a96f
	and a			;a972
	sbc hl,de		;a973   ; X menos profundidad
	ld (ix+002h),h		;a975   ; el byte alto es la columna
	ld a,(ix+009h)		;a978   ; y la Y, byte alto
	ld (ix+003h),a		;a97b
	ret			;a97e
rutina_propia_de_la_clase:
	ld a,(ix+000h)		;a97f   ; la clase
	dec a			;a982   ; la tabla va desde 1
	add a,a			;a983   ; dos bytes por entrada
	ld hl,0a98ah		;a984   ; la SEGUNDA tabla de quince, la de atender
	jp L_A8C7		;a987   ; y se salta a la que toque

; ----------------------------------------------------------------------
; DATOS tabla_de_atender: La segunda tabla de quince, hermana de la de 0xA8D1:
;   alli esta la rutina que MONTA cada clase de objeto y aqui la que la
;   atiende en cada cuadro. Los quince destinos son 0xB5AD, 0xB60B, 0xB60D,
;   0xB60F, 0xB6C8, 0xB71B, 0xB8AE, 0xB90A, 0xB9C0, 0xBB1E, 0xBC3C, 0xBCFB,
;   0xBD33, 0xBE51 y 0xBE7E.
;   0xa98a..0xa9a8  (30 bytes)
DATA_tabla_de_atender:
	defw 0b5adh	; a98a
	defw 0b60bh	; a98c
	defw 0b60dh	; a98e
	defw 0b60fh	; a990
	defw 0b6c8h	; a992
	defw 0b71bh	; a994
	defw 0b8aeh	; a996
	defw 0b90ah	; a998
	defw 0b9c0h	; a99a
	defw 0bb1eh	; a99c
	defw 0bc3ch	; a99e
	defw 0bcfbh	; a9a0
	defw 0bd33h	; a9a2
	defw 0be51h	; a9a4
	defw 0be7eh	; a9a6

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa9a8..0xa9aa  (2 bytes)
DATA_A9A8:
	defb 0c9h,0aah	; a9a8

; ======================================================================
; CODIGO 0xa9aa..0xaa86  (220 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; MOVER. Le suma a cada coordenada su velocidad, las tres de 16 bits. Es todo lo que hay: no hay gravedad ni rozamiento aqui, lo que cambie las velocidades lo hace la rutina propia de cada clase.
; ----------------------------------------------------------------------
mueve_el_objeto:
	ld a,(ix+012h)		;a9aa   ; ¿se mueve solo?
	and a			;a9ad
	ret z			;a9ae   ; si no, no hay nada que hacer
	ld l,(ix+006h)		;a9af   ; la X
	ld h,(ix+007h)		;a9b2
	ld e,(ix+00ch)		;a9b5   ; y su velocidad
	ld d,(ix+00dh)		;a9b8
	add hl,de			;a9bb   ; sumadas
	ld (ix+006h),l		;a9bc
	ld (ix+007h),h		;a9bf
	ld l,(ix+008h)		;a9c2   ; la Y
	ld h,(ix+009h)		;a9c5
	ld e,(ix+00eh)		;a9c8   ; y la suya
	ld d,(ix+00fh)		;a9cb
	add hl,de			;a9ce
	ld (ix+008h),l		;a9cf
	ld (ix+009h),h		;a9d2
	ld l,(ix+00ah)		;a9d5   ; y la Z
	ld h,(ix+00bh)		;a9d8
	ld e,(ix+010h)		;a9db   ; con la suya
	ld d,(ix+011h)		;a9de
	add hl,de			;a9e1
	ld (ix+00ah),l		;a9e2
	ld (ix+00bh),h		;a9e5
	ret			;a9e8

; ----------------------------------------------------------------------
; LOS OBJETOS, A LA TABLA DE SPRITES. Dos pasadas, una por cada capa de color: la primera lleva los tres objetos a 0xEEDC y la segunda su copia de 0xE2A0 a 0xEEE0. Cuatro bytes mas alla es justo el otro hueco de la pareja, que es como este cartucho pinta una figura de dos colores.
; ----------------------------------------------------------------------
los_objetos_a_los_sprites:
	ld de,0eedch		;a9e9   ; el hueco de sprite de la primera capa
	ld hl,0e310h		;a9ec   ; y los tres objetos
	call copia_tres_objetos_a_sprites		;a9ef
	ld de,0eee0h		;a9f2   ; el hueco de la segunda capa, cuatro bytes mas alla
	ld hl,0e2a0h		;a9f5   ; y la copia de los objetos
copia_tres_objetos_a_sprites:
	ld bc,003ffh		;a9f8   ; tres objetos, y B se queda con el 3
copia_un_objeto_a_sprite:
	ld a,(hl)			;a9fb   ; la clase
	inc l			;a9fc
	inc l			;a9fd
	and a			;a9fe   ; cero es hueco libre
	ld a,(hl)			;a9ff   ; la fila
	jr nz,copia_un_objeto_sigue		;aa00
	ld a,0e0h		;aa02   ; y si el hueco esta libre, 0xE0: fuera de la pantalla
copia_un_objeto_sigue:
	ld (de),a			;aa04   ; la Y del sprite
	inc l			;aa05
	inc e			;aa06
	ldi		;aa07   ; columna, patron y color, de un tiron
	ldi		;aa09
	ldi		;aa0b
	ld a,01ah		;aa0d   ; 0x1A: lo que queda del hueco de 32 bytes
	add a,l			;aa0f
	ld l,a			;aa10
	inc e			;aa11   ; y cuatro bytes al sprite siguiente
	inc e			;aa12
	inc e			;aa13
	inc e			;aa14
	djnz copia_un_objeto_a_sprite		;aa15
	ret			;aa17

; ----------------------------------------------------------------------
; QUE DIBUJO LE TOCA, SEGUN LO CERCA QUE ESTE. Aqui esta la perspectiva del juego: el byte alto de la X dice a que distancia esta el objeto, y de ahi salen cuatro dibujos distintos -0x40, 0x44, 0x48 y 0x30- que son el mismo bicho de mayor a menor. Por debajo de 0x60 ni se dibuja: esta demasiado cerca y ya ha pasado de largo.
; ----------------------------------------------------------------------
elige_el_dibujo_por_la_distancia:
	ld ix,0e310h		;aa18   ; los tres objetos
	ld iy,0e2a0h		;aa1c   ; y su copia
	ld b,003h		;aa20
L_AA22:
	ld a,(ix+000h)		;aa22   ; la clase
	ld (iy+000h),a		;aa25
	and a			;aa28   ; hueco libre, nada que hacer
	jr z,elige_el_dibujo_siguiente		;aa29
	ld a,(ix+003h)		;aa2b   ; la fila
	ld (iy+003h),a		;aa2e
	ld a,(ix+007h)		;aa31   ; la distancia
	cp 060h		;aa34   ; por debajo de 0x60 no se dibuja
	jr c,demasiado_cerca		;aa36
	ld c,a			;aa38
	and 0c0h		;aa39   ; los dos bits de arriba de la distancia
	rra			;aa3b   ; seis vueltas: bajan a los dos de abajo
	rra			;aa3c
	rra			;aa3d
	rra			;aa3e
	rra			;aa3f
	rra			;aa40
	add a,c			;aa41   ; y se le suman a la propia distancia: eso separa las columnas
	ld (iy+002h),a		;aa42
	ld a,c			;aa45
	cp 070h		;aa46   ; primera banda
	ld c,040h		;aa48   ; el dibujo grande
	jr c,guarda_el_dibujo		;aa4a
	cp 088h		;aa4c   ; segunda banda
	ld c,044h		;aa4e
	jr c,guarda_el_dibujo		;aa50
	cp 0a8h		;aa52   ; tercera
	ld c,048h		;aa54
	jr c,guarda_el_dibujo		;aa56
	ld c,030h		;aa58   ; y la de mas lejos, el mas pequeno
guarda_el_dibujo:
	ld (iy+004h),c		;aa5a   ; el patron que le toca
	ld (iy+005h),001h		;aa5d   ; y color 1
elige_el_dibujo_siguiente:
	ld de,00020h		;aa61   ; 0x20 de un hueco al siguiente
	add ix,de		;aa64
	add iy,de		;aa66
	djnz L_AA22		;aa68
	ret			;aa6a
demasiado_cerca:
	ld (iy+000h),000h		;aa6b   ; no se dibuja
	jr elige_el_dibujo_siguiente		;aa6f
L_AA71:
	ld (ix+00ch),e		;aa71
	ld (ix+00dh),d		;aa74
	ret			;aa77
L_AA78:
	ld (ix+00eh),e		;aa78
	ld (ix+00fh),d		;aa7b
	ret			;aa7e
L_AA7F:
	ld (ix+010h),e		;aa7f
	ld (ix+011h),d		;aa82
	ret			;aa85

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaa86..0xabc3  (317 bytes)
DATA_AA86:
	defb 0ddh,07eh,007h,0feh,060h,0d8h,0feh,078h,038h,00eh,00ch,00ch,0feh,090h,038h,008h	; aa86  .~..`..x8.....8.
	defb 00ch,00ch,0feh,0a8h,038h,002h,00ch,00ch,03ah,003h,0e0h,0e6h,004h,020h,001h,00ch	; aa96  ....8...:.... ..
	defb 079h,087h,087h,0ddh,077h,004h,0c9h,0ddh,07eh,007h,0feh,060h,0d8h,0feh,078h,038h	; aaa6  y...w...~..`..x8
	defb 00bh,00ch,0feh,090h,038h,006h,00ch,0feh,0a8h,038h,001h,00ch,079h,087h,087h,0ddh	; aab6  ....8....8..y...
	defb 077h,004h,0c9h,0ddh,07eh,01fh,0a7h,028h,001h,0c9h,0ddh,07eh,01dh,0a7h,028h,004h	; aac6  w...~..(...~..(.
	defb 0ddh,036h,005h,005h,0edh,05fh,0e6h,001h,0ddh,077h,01eh,0afh,0ddh,077h,00ch,0ddh	; aad6  .6..._...w...w..
	defb 077h,00dh,0ddh,077h,00eh,0ddh,077h,010h,0ddh,036h,012h,001h,0ddh,034h,01fh,021h	; aae6  w..w..w..6...4.!
	defb 015h,0abh,0edh,05fh,0e6h,007h,085h,06fh,030h,001h,024h,07eh,0ddh,077h,011h,023h	; aaf6  ..._...o0.$~.w.#
	defb 07eh,047h,0ddh,07eh,01eh,0a7h,078h,028h,002h,0edh,044h,0ddh,077h,00fh,0c9h,008h	; ab06  ~G.~..x(..D.w...
	defb 004h,005h,005h,003h,006h,009h,002h,007h,021h,070h,0e3h,07eh,0a7h,028h,00bh,02eh	; ab16  ........!p.~.(..
	defb 080h,07eh,0a7h,028h,005h,02eh,090h,07eh,0a7h,0c0h,0ddh,07eh,000h,011h,0b3h,0abh	; ab26  .~.(...~...~....
	defb 083h,05fh,030h,001h,014h,01ah,077h,0afh,032h,0e0h,0e4h,02ch,036h,000h,02ch,0ddh	; ab36  ._0...w.2..,6.,.
	defb 07eh,002h,077h,04fh,03ah,004h,0e2h,0beh,038h,049h,02ch,036h,000h,02ch,0ddh,07eh	; ab46  ~.wO:...8I,6.,.~
	defb 003h,077h,047h,0cdh,09eh,0abh,038h,039h,02ch,02ch,02ch,0e5h,0cdh,075h,0ach,0cdh	; ab56  .wG...89,,,..u..
	defb 027h,0adh,0d5h,059h,050h,0cdh,00eh,0adh,04dh,044h,0d1h,0e1h,071h,02ch,070h,02ch	; ab66  '..YP...MD..q,p,
	defb 0e5h,0cdh,00eh,0adh,0ebh,0e1h,073h,02ch,072h,07dh,0d6h,00ah,06fh,07eh,0feh,006h	; ab76  ......s,r}..o~..
	defb 020h,006h,03eh,013h,0cdh,03ah,041h,0c9h,0feh,004h,0c0h,03eh,00fh,0cdh,03ah,041h	; ab86   .>..:A....>..:A
	defb 0c9h,02dh,02dh,02dh,02dh,036h,000h,0c9h,03ah,004h,0e2h,0b9h,030h,002h,0edh,044h	; ab96  .----6..:...0..D
	defb 0feh,020h,0d8h,03ah,005h,0e2h,0b8h,030h,002h,0edh,044h,0feh,020h,0c9h,001h,000h	; aba6  . .:...0..D. ...
	defb 000h,002h,000h,000h,000h,000h,003h,000h,004h,000h,005h,000h,006h	; abb6  .............

; ======================================================================
; CODIGO 0xabc3..0xabdd  (26 bytes)
; ======================================================================


L_ABC3:
	ld ix,0e370h		;abc3
	ld b,003h		;abc7
L_ABC9:
	ld a,(ix+000h)		;abc9
	and a			;abcc
	jr z,L_ABD5		;abcd
	call L_ABF5		;abcf
	call L_AC1E		;abd2
L_ABD5:
	ld de,00010h		;abd5
	add ix,de		;abd8
	djnz L_ABC9		;abda
	ret			;abdc

; ----------------------------------------------------------------------
; DATOS sin identificar  0xabdd..0xabf5  (24 bytes)
DATA_ABDD:
	defb 09ch,001h,0a0h,001h,09ch,001h,0a0h,001h,09ch,001h,0a0h,001h,0ach,001h,0ach,001h	; abdd  ................
	defb 09ch,001h,0a0h,001h,0ach,006h,0ach,006h	; abed  ........

; ======================================================================
; CODIGO 0xabf5..0xac75  (128 bytes)
; ======================================================================


L_ABF5:
	ld a,(ix+000h)		;abf5
	add a,a			;abf8
	add a,a			;abf9
	ld hl,0abd9h		;abfa
	add a,l			;abfd
	ld l,a			;abfe
	jr nc,L_AC02		;abff
	inc h			;ac01
L_AC02:
	ld a,(ix+006h)		;ac02
	cp 080h		;ac05
	jr nc,L_AC0B		;ac07
	inc hl			;ac09
	inc hl			;ac0a
L_AC0B:
	ld a,(hl)			;ac0b
	ld (ix+005h),a		;ac0c
	inc hl			;ac0f
	ld a,(hl)			;ac10
	ld (ix+006h),a		;ac11
	ld a,(0e0dch)		;ac14
	and a			;ac17
	ret z			;ac18
	ld (ix+006h),004h		;ac19
	ret			;ac1d
L_AC1E:
	ld l,(ix+001h)		;ac1e
	ld h,(ix+002h)		;ac21
	ld e,(ix+007h)		;ac24
	ld d,(ix+008h)		;ac27
	add hl,de			;ac2a
	ld (ix+001h),l		;ac2b
	ld (ix+002h),h		;ac2e
	ld a,h			;ac31
	cp 0c0h		;ac32
	jr nc,L_AC4D		;ac34
	ld l,(ix+003h)		;ac36
	ld h,(ix+004h)		;ac39
	ld e,(ix+009h)		;ac3c
	ld d,(ix+00ah)		;ac3f
	add hl,de			;ac42
	ld (ix+003h),l		;ac43
	ld (ix+004h),h		;ac46
	ld a,h			;ac49
	cp 0f0h		;ac4a
	ret c			;ac4c
L_AC4D:
	ld (ix+000h),000h		;ac4d
	ret			;ac51
L_AC52:
	ld hl,0e370h		;ac52
	ld de,0eef4h		;ac55
	ld bc,003ffh		;ac58
L_AC5B:
	ld a,(hl)			;ac5b
	inc l			;ac5c
	inc l			;ac5d
	and a			;ac5e
	ld a,(hl)			;ac5f
	jr nz,L_AC64		;ac60
	ld a,0e0h		;ac62
L_AC64:
	ld (de),a			;ac64
	inc l			;ac65
	inc l			;ac66
	inc e			;ac67
	ldi		;ac68
	ldi		;ac6a
	ldi		;ac6c
	ld a,009h		;ac6e
	add a,l			;ac70
	ld l,a			;ac71
	djnz L_AC5B		;ac72
	ret			;ac74

; ----------------------------------------------------------------------
; DATOS sin identificar  0xac75..0xb581  (2316 bytes)
DATA_AC75:
	defb 03ah,004h,0e2h,06fh,03ah,005h,0e2h,0c6h,010h,067h,016h,001h,07dh,0ddh,096h,002h	; ac75  :..o:....g..}...
	defb 006h,000h,028h,007h,047h,030h,004h,015h,0edh,044h,047h,07ch,0ddh,096h,003h,01eh	; ac85  ..(.G0...DG|....
	defb 000h,00eh,000h,028h,007h,04fh,030h,004h,01ch,0edh,044h,04fh,07ah,083h,0feh,001h	; ac95  ...(.O0...DOz...
	defb 020h,005h,015h,020h,002h,03eh,003h,057h,068h,026h,000h,041h,0d5h,0cdh,0f8h,0ach	; aca5   .. .>.Wh&.A....
	defb 021h,0b8h,0adh,006h,040h,07eh,023h,0e5h,066h,06fh,0a7h,0edh,052h,0e1h,038h,007h	; acb5  !...@~#.fo..R.8.
	defb 023h,078h,0d6h,008h,047h,020h,0eeh,0d1h,015h,020h,006h,03eh,040h,090h,0c6h,040h	; acc5  #x..G ... .>@..@
	defb 0c9h,015h,020h,004h,03eh,080h,080h,0c9h,078h,015h,0c0h,0edh,044h,0c9h,00eh,008h	; acd5  .. .>...x...D...
	defb 0afh,0edh,06ah,07ch,038h,003h,0b8h,038h,003h,090h,067h,0afh,03fh,00dh,020h,0f1h	; ace5  ..j|8..8..g.?. .
	defb 0cbh,015h,0c9h,078h,0b7h,028h,00eh,011h,000h,000h,0cdh,0e3h,0ach,055h,02eh,000h	; acf5  ...x.(.......U..
	defb 0cdh,0e3h,0ach,05dh,0c9h,03dh,057h,05fh,0c9h,0cbh,07ah,0f5h,028h,007h,07bh,02fh	; ad05  ...].=W_..z.(.{/
	defb 05fh,07ah,02fh,057h,013h,06bh,062h,019h,0f1h,0c8h,07dh,02fh,06fh,07ch,02fh,067h	; ad15  _z/W.kb...}/o|/g
	defb 023h,0c9h,047h,00eh,000h,0feh,041h,038h,016h,00ch,0feh,080h,030h,005h,03eh,080h	; ad25  #.G...A8....0.>.
	defb 090h,018h,00ch,00ch,0feh,0c0h,030h,004h,0d6h,080h,018h,003h,00ch,0edh,044h,047h	; ad35  ......0.......DG
	defb 008h,078h,008h,021h,077h,0adh,085h,06fh,030h,001h,024h,016h,000h,05eh,079h,0d6h	; ad45  .x.!w..o0.$..^y.
	defb 001h,0feh,002h,07bh,030h,003h,015h,0edh,044h,05fh,021h,077h,0adh,03eh,040h,090h	; ad55  ...{0...D_!w.>@.
	defb 085h,06fh,030h,001h,024h,006h,000h,079h,0feh,002h,07eh,030h,003h,005h,0edh,044h	; ad65  .o0.$..y..~0...D
	defb 04fh,0c9h,0ffh,0ffh,0ffh,0ffh,0feh,0feh,0fdh,0fch,0fbh,0f9h,0f8h,0f6h,0f4h,0f3h	; ad75  O...............
	defb 0f1h,0eeh,0ech,0eah,0e7h,0e4h,0e1h,0deh,0dch,0d9h,0d4h,0d1h,0cdh,0c9h,0c5h,0c1h	; ad85  ................
	defb 0bdh,0b9h,0b5h,0b0h,0abh,0a7h,0a2h,09dh,098h,093h,08eh,088h,083h,07eh,078h,073h	; ad95  .............~xs
	defb 069h,067h,061h,05ch,056h,050h,04ah,044h,03eh,038h,02eh,02bh,02fh,01fh,019h,012h	; ada5  iga\VPJD>8.+/...
	defb 00ch,006h,001h,0f6h,004h,066h,002h,07dh,001h,0ffh,000h,0aah,000h,069h,000h,032h	; adb5  .....f.}.....i.2
	defb 000h,000h,000h,0ffh,0ffh,00ah,010h,00ah,010h,00ah,030h,00ah,015h,00ah,010h,00ah	; adc5  ..........0.....
	defb 015h,00ah,060h,00ah,020h,00ah,010h,00ah,010h,00ah,020h,00ah,010h,00ah,010h,00ah	; add5  ..`. ..... .....
	defb 020h,00ah,010h,00ah,010h,00ah,010h,00ah,050h,000h,070h,00ah,010h,00ah,010h,00ah	; ade5   .......P.p.....
	defb 010h,00ah,020h,00ah,010h,00ah,010h,00ah,0ffh,0ffh,00ch,010h,00ch,020h,00ch,020h	; adf5  .. .......... .
	defb 00ch,010h,00ch,010h,00ch,010h,00ch,020h,00ch,020h,00ch,020h,00ch,010h,00ch,020h	; ae05  ....... . . ...
	defb 00ch,010h,00ch,040h,00ch,010h,00ch,010h,00ch,010h,00ch,040h,00ch,0ffh,00ah,010h	; ae15  ...@.......@....
	defb 00ah,010h,00ah,010h,00ah,030h,00ah,010h,00ah,010h,00ah,010h,00ah,010h,00ah,030h	; ae25  .....0.........0
	defb 00ah,010h,00ah,010h,00ah,010h,00ah,070h,005h,005h,005h,015h,00ah,010h,00ah,015h	; ae35  .......p........
	defb 005h,015h,005h,030h,005h,040h,00ah,010h,005h,010h,00ah,020h,005h,010h,00ah,010h	; ae45  ...0.@..... ....
	defb 00ah,010h,00ah,010h,005h,010h,00ah,010h,005h,0ffh,00ah,005h,00ah,005h,00ah,060h	; ae55  ...............`
	defb 000h,045h,00ah,005h,00ah,010h,00ah,020h,00ah,010h,00ah,050h,000h,060h,00ah,005h	; ae65  .E..... ...P.`..
	defb 00ah,005h,00ah,010h,00ah,010h,00ah,025h,00ah,005h,00ah,080h,00ah,010h,00ah,010h	; ae75  .......%........
	defb 00ah,005h,00ah,015h,00ah,010h,00ah,060h,00ah,010h,00ah,010h,00ah,010h,00ah,0ffh	; ae85  .......`........
	defb 007h,005h,007h,025h,007h,010h,007h,040h,007h,005h,007h,005h,007h,040h,001h,010h	; ae95  ...%...@.....@..
	defb 001h,005h,001h,015h,001h,030h,007h,005h,007h,015h,001h,010h,001h,030h,007h,010h	; aea5  .....0.......0..
	defb 001h,020h,001h,010h,007h,005h,007h,035h,001h,005h,001h,005h,001h,010h,001h,040h	; aeb5  . .....5.......@
	defb 007h,005h,007h,005h,001h,005h,007h,015h,001h,0ffh,00fh,020h,00fh,030h,00fh,010h	; aec5  ........... .0..
	defb 00ah,010h,00ah,020h,00fh,010h,00ah,010h,00ah,075h,00fh,015h,00ah,010h,00ah,010h	; aed5  ... .....u......
	defb 00ah,010h,00ah,030h,005h,010h,005h,005h,00fh,015h,005h,005h,005h,015h,00fh,010h	; aee5  ...0............
	defb 005h,010h,005h,005h,00fh,075h,005h,010h,00ah,010h,005h,010h,00fh,020h,00ah,010h	; aef5  .....u....... ..
	defb 00ah,005h,00fh,005h,00fh,030h,005h,0ffh,00ch,010h,00ch,010h,00ch,030h,007h,005h	; af05  .....0.......0..
	defb 007h,010h,007h,090h,00bh,015h,00bh,030h,00bh,030h,00ch,010h,00ch,010h,007h,005h	; af15  .......0.0......
	defb 007h,035h,00ch,005h,00ch,005h,007h,040h,00ch,010h,00ch,005h,00ch,010h,00bh,055h	; af25  .5.....@.......U
	defb 00ch,010h,00ch,005h,00bh,025h,007h,010h,007h,005h,00bh,015h,00ch,005h,00ch,005h	; af35  .....%..........
	defb 00ch,010h,007h,005h,007h,015h,00ch,010h,00ch,010h,00ch,0ffh,007h,010h,007h,010h	; af45  ................
	defb 007h,030h,006h,010h,006h,010h,006h,020h,007h,080h,007h,010h,007h,010h,006h,010h	; af55  .0..... ........
	defb 006h,010h,006h,050h,007h,010h,007h,030h,006h,010h,006h,010h,007h,030h,007h,010h	; af65  ...P...0.....0..
	defb 006h,020h,006h,005h,007h,055h,006h,010h,006h,050h,007h,010h,007h,010h,007h,020h	; af75  . ...U...P.....
	defb 006h,020h,006h,010h,007h,005h,007h,0ffh,00fh,010h,00fh,040h,00ah,010h,00ah,010h	; af85  . .........@....
	defb 00ah,020h,00ah,010h,00fh,010h,00ah,020h,001h,005h,001h,015h,001h,040h,00ah,005h	; af95  . ..... .....@..
	defb 00ah,005h,00fh,010h,005h,010h,005h,010h,005h,050h,001h,010h,001h,010h,001h,010h	; afa5  .........P......
	defb 00fh,010h,001h,010h,005h,010h,005h,035h,005h,025h,005h,010h,005h,030h,00fh,030h	; afb5  .......5.%...0.0
	defb 005h,010h,005h,030h,00fh,010h,00ah,010h,001h,010h,001h,020h,00ah,010h,00ah,010h	; afc5  ...0....... ....
	defb 001h,005h,001h,005h,001h,020h,00fh,005h,00ah,005h,00ah,010h,001h,010h,001h,020h	; afd5  ..... .........
	defb 00ah,010h,001h,0ffh,009h,010h,009h,030h,009h,010h,009h,020h,009h,020h,009h,010h	; afe5  .......0... . ..
	defb 009h,060h,009h,010h,009h,010h,009h,040h,009h,010h,009h,010h,009h,070h,009h,010h	; aff5  .`.....@.....p..
	defb 009h,020h,009h,010h,009h,010h,009h,040h,009h,0ffh,00ah,010h,00ah,010h,00ah,010h	; b005  . .....@........
	defb 001h,010h,001h,010h,00fh,010h,00fh,005h,001h,005h,001h,030h,00ah,005h,00ah,005h	; b015  ...........0....
	defb 00fh,005h,00ah,050h,00eh,005h,00eh,005h,00eh,005h,00eh,010h,00eh,040h,00fh,005h	; b025  ...P.........@..
	defb 001h,005h,001h,020h,001h,010h,00fh,020h,00ah,020h,001h,005h,001h,015h,00eh,020h	; b035  ... ... . .....
	defb 00eh,010h,005h,010h,005h,010h,001h,010h,005h,010h,00fh,020h,001h,010h,00fh,010h	; b045  ........... ....
	defb 00ah,010h,005h,020h,005h,005h,005h,0ffh,001h,010h,001h,010h,001h,005h,001h,005h	; b055  ... ............
	defb 00eh,010h,00eh,010h,00eh,005h,00eh,035h,005h,010h,005h,020h,005h,010h,005h,005h	; b065  .......5... ....
	defb 00ah,005h,00ah,030h,00dh,010h,00dh,010h,001h,010h,00dh,010h,001h,020h,00eh,030h	; b075  ...0......... .0
	defb 00eh,010h,001h,010h,00ah,010h,00ah,010h,005h,010h,005h,010h,001h,010h,001h,005h	; b085  ................
	defb 00eh,005h,00eh,045h,00eh,005h,005h,020h,005h,010h,005h,020h,005h,030h,001h,010h	; b095  ...E... ... .0..
	defb 00ah,010h,00ah,010h,00ah,010h,00dh,010h,00ah,020h,001h,005h,001h,005h,00dh,010h	; b0a5  ......... ......
	defb 00ah,020h,00dh,010h,00dh,010h,00ah,005h,00ah,025h,001h,010h,001h,010h,001h,020h	; b0b5  . .......%.....
	defb 005h,010h,00eh,0ffh,007h,010h,007h,010h,007h,010h,007h,010h,00ah,010h,00fh,010h	; b0c5  ................
	defb 00fh,010h,00ah,010h,007h,010h,007h,010h,007h,010h,007h,010h,00ah,020h,00fh,020h	; b0d5  ............. .
	defb 007h,010h,00ah,010h,007h,010h,00ah,010h,00ah,005h,00ah,005h,007h,010h,00fh,090h	; b0e5  ................
	defb 007h,010h,007h,005h,00ah,005h,00ah,010h,00ah,020h,00fh,020h,00fh,020h,00ah,010h	; b0f5  ......... . . ..
	defb 00ah,005h,007h,045h,007h,020h,007h,010h,007h,005h,00fh,045h,00ah,010h,00ah,010h	; b105  ...E. .....E....
	defb 00ah,005h,007h,010h,007h,035h,00fh,010h,00ah,010h,00ah,010h,00fh,080h,00ah,010h	; b115  .....5..........
	defb 00ah,005h,00ah,005h,00fh,010h,007h,010h,007h,010h,007h,010h,00ah,015h,00ah,005h	; b125  ................
	defb 00fh,010h,007h,020h,007h,010h,00ah,005h,00ah,005h,00ah,060h,00ah,005h,007h,005h	; b135  ... .......`....
	defb 00ah,005h,007h,005h,00fh,010h,007h,010h,007h,0ffh,006h,010h,006h,010h,006h,030h	; b145  ...............0
	defb 006h,010h,006h,010h,006h,060h,009h,010h,009h,010h,006h,010h,006h,050h,009h,010h	; b155  .....`.......P..
	defb 006h,010h,006h,020h,009h,030h,009h,010h,009h,010h,006h,010h,006h,010h,009h,020h	; b165  ... .0.........
	defb 009h,020h,006h,010h,006h,010h,006h,010h,009h,020h,009h,010h,006h,010h,006h,010h	; b175  . ....... ......
	defb 009h,010h,009h,005h,006h,005h,006h,020h,009h,010h,006h,010h,006h,0ffh,00ah,010h	; b185  ....... ........
	defb 00ah,010h,00ah,010h,001h,005h,001h,015h,00ah,010h,001h,010h,001h,010h,00ah,060h	; b195  ...............`
	defb 000h,065h,001h,005h,001h,010h,001h,010h,00dh,010h,00dh,010h,001h,010h,00dh,020h	; b1a5  .e.............
	defb 001h,070h,000h,060h,009h,010h,009h,005h,00ah,015h,00ah,010h,009h,010h,00ah,010h	; b1b5  .p.`............
	defb 00ah,010h,009h,010h,009h,060h,000h,060h,00dh,010h,00dh,010h,001h,010h,001h,010h	; b1c5  .....`.`........
	defb 001h,010h,001h,005h,001h,005h,00dh,010h,001h,020h,00ah,020h,00ah,020h,00dh,020h	; b1d5  ......... . . .
	defb 001h,030h,001h,010h,009h,030h,009h,020h,00ah,020h,00ah,020h,009h,020h,00dh,010h	; b1e5  .0...0. . . . ..
	defb 009h,0ffh,00bh,010h,00ch,010h,00ch,010h,00bh,010h,00ch,010h,00ch,010h,00ch,090h	; b1f5  ................
	defb 007h,010h,007h,010h,00bh,010h,007h,010h,007h,010h,00bh,010h,00ch,010h,00ch,010h	; b205  ................
	defb 00bh,005h,00ch,005h,00bh,010h,00ch,080h,00ch,020h,00ch,005h,00ch,015h,00ch,005h	; b215  ......... ......
	defb 00ch,015h,007h,005h,007h,005h,007h,010h,00ch,010h,00ch,005h,00ch,005h,00ch,020h	; b225  ...............
	defb 00ah,010h,00ah,010h,00ah,010h,007h,010h,007h,010h,00ah,010h,00ah,010h,007h,010h	; b235  ................
	defb 007h,020h,00ah,005h,00ch,005h,00ch,010h,006h,010h,006h,010h,00ch,020h,00ch,010h	; b245  . ........... ..
	defb 006h,010h,006h,010h,006h,010h,00ch,010h,00ch,010h,00ch,010h,007h,010h,007h,010h	; b255  ................
	defb 00ch,010h,00ch,010h,00ah,010h,00ah,010h,00ah,010h,00ch,010h,00ch,085h,006h,015h	; b265  ................
	defb 006h,010h,00bh,005h,006h,005h,00bh,010h,006h,010h,00bh,010h,006h,010h,006h,010h	; b275  ................
	defb 006h,010h,00ch,010h,00ch,010h,007h,010h,007h,010h,00bh,010h,007h,010h,00ch,010h	; b285  ................
	defb 00bh,005h,00ch,005h,00bh,030h,00ch,010h,00ch,005h,00ch,0ffh,009h,010h,00fh,020h	; b295  .....0.........
	defb 00fh,010h,009h,020h,009h,010h,001h,010h,001h,010h,001h,010h,001h,010h,009h,010h	; b2a5  ... ............
	defb 00fh,010h,001h,010h,001h,010h,001h,010h,009h,010h,009h,010h,00fh,030h,00fh,010h	; b2b5  .............0..
	defb 001h,005h,001h,015h,009h,010h,00fh,010h,00fh,080h,009h,030h,009h,010h,00fh,010h	; b2c5  ...........0....
	defb 001h,010h,001h,060h,001h,010h,001h,010h,009h,010h,00fh,010h,009h,020h,009h,010h	; b2d5  ...`......... ..
	defb 009h,020h,00fh,020h,009h,010h,001h,010h,001h,010h,001h,010h,001h,010h,00fh,010h	; b2e5  . . ............
	defb 00fh,020h,001h,010h,009h,020h,009h,0ffh,00eh,010h,00eh,010h,00eh,040h,00eh,090h	; b2f5  . ... .......@..
	defb 00ah,010h,00ah,010h,00ah,050h,001h,010h,001h,010h,001h,010h,001h,010h,005h,010h	; b305  .....P..........
	defb 005h,040h,00ah,010h,00ah,010h,00ah,020h,005h,010h,005h,020h,005h,060h,001h,010h	; b315  .@..... ... .`..
	defb 001h,010h,001h,010h,001h,010h,00ah,010h,00ah,010h,001h,010h,001h,010h,00eh,010h	; b325  ................
	defb 00eh,040h,00dh,010h,00dh,010h,00ah,010h,00ah,020h,001h,010h,001h,030h,00eh,010h	; b335  .@....... ...0..
	defb 00eh,010h,00ah,010h,00eh,010h,00ah,010h,00ah,020h,00eh,030h,005h,020h,005h,010h	; b345  ......... .0. ..
	defb 00dh,010h,00dh,020h,005h,010h,005h,030h,00eh,010h,00dh,010h,00eh,020h,00ah,010h	; b355  ... ...0..... ..
	defb 00ah,010h,00ah,010h,00dh,030h,001h,010h,001h,010h,00eh,010h,00eh,030h,001h,010h	; b365  .....0.......0..
	defb 001h,010h,001h,010h,00dh,020h,00ah,010h,00ah,010h,001h,010h,00ah,010h,001h,010h	; b375  ..... ..........
	defb 00eh,010h,00eh,020h,00eh,030h,00dh,010h,001h,010h,001h,010h,00eh,010h,00eh,010h	; b385  ... .0..........
	defb 00dh,010h,001h,010h,001h,020h,00eh,010h,00eh,0ffh,00fh,010h,00ah,010h,00ah,010h	; b395  ..... ..........
	defb 00ah,010h,00ah,020h,00fh,010h,00fh,010h,00ah,010h,00ah,010h,00fh,010h,00ah,010h	; b3a5  ... ............
	defb 00fh,020h,00ah,010h,00ah,050h,00fh,010h,001h,010h,001h,010h,001h,010h,00fh,030h	; b3b5  . ...P.........0
	defb 001h,010h,001h,010h,00fh,010h,00ah,010h,00ah,010h,001h,010h,00fh,010h,001h,020h	; b3c5  ...............
	defb 00fh,010h,001h,010h,001h,060h,00ah,010h,009h,030h,009h,010h,00ah,010h,00fh,010h	; b3d5  .....`...0......
	defb 00ah,010h,00fh,010h,001h,010h,001h,010h,009h,010h,009h,010h,001h,010h,001h,050h	; b3e5  ...............P
	defb 00ah,005h,001h,015h,001h,010h,00ah,010h,00ah,020h,001h,020h,001h,020h,00ah,010h	; b3f5  ......... . . ..
	defb 00ah,010h,001h,010h,00fh,020h,00fh,010h,00ah,010h,009h,020h,00ah,010h,009h,010h	; b405  ..... ..... ....
	defb 001h,010h,001h,020h,001h,010h,001h,010h,00ah,010h,001h,010h,00ah,010h,009h,010h	; b415  ... ............
	defb 00ah,010h,009h,080h,00fh,015h,00ah,005h,00fh,010h,00ah,010h,00ah,010h,009h,010h	; b425  ................
	defb 00ah,020h,009h,010h,001h,010h,00ah,010h,00ah,010h,00ah,010h,009h,010h,001h,010h	; b435  . ..............
	defb 001h,010h,001h,0ffh,006h,010h,006h,010h,006h,020h,00ch,010h,00ch,010h,00ch,010h	; b445  ......... ......
	defb 006h,010h,006h,010h,00ch,040h,006h,010h,00ch,010h,00ch,010h,00ch,030h,00bh,030h	; b455  .....@.......0.0
	defb 006h,010h,00bh,010h,006h,010h,006h,010h,006h,010h,00bh,010h,006h,020h,00bh,020h	; b465  ............. .
	defb 00ah,020h,00ah,020h,00ah,015h,00bh,015h,00bh,020h,006h,010h,006h,010h,00ah,010h	; b475  . . ..... ......
	defb 00ah,010h,00ch,010h,00ch,010h,007h,010h,007h,010h,007h,020h,00ah,010h,00ah,020h	; b485  ........... ...
	defb 007h,020h,00ah,010h,00ah,010h,00ah,030h,00bh,010h,00bh,010h,00ch,010h,00ch,010h	; b495  . .....0........
	defb 00ch,010h,00ch,010h,00bh,050h,00bh,010h,00ch,010h,007h,010h,00ch,010h,00ch,010h	; b4a5  .....P..........
	defb 007h,010h,00ah,010h,007h,010h,00ah,010h,007h,010h,007h,0ffh,001h,010h,001h,010h	; b4b5  ................
	defb 001h,040h,005h,010h,005h,020h,001h,020h,001h,010h,001h,005h,005h,025h,001h,010h	; b4c5  .@... . .....%..
	defb 001h,020h,00eh,010h,00eh,010h,001h,010h,001h,010h,00eh,010h,001h,030h,001h,030h	; b4d5  . ...........0.0
	defb 001h,010h,001h,010h,00ah,010h,00ah,010h,001h,010h,001h,020h,00ah,020h,00ah,010h	; b4e5  ........... . ..
	defb 00eh,020h,00ah,010h,00eh,010h,00eh,020h,001h,020h,005h,010h,001h,010h,001h,010h	; b4f5  . ..... . ......
	defb 00dh,015h,005h,015h,00dh,010h,005h,010h,001h,030h,00dh,010h,00dh,010h,00ah,010h	; b505  .........0......
	defb 00ah,010h,001h,010h,001h,010h,00ah,010h,001h,010h,001h,020h,00ah,010h,00ah,010h	; b515  ........... ....
	defb 00eh,020h,00eh,010h,00eh,010h,001h,010h,001h,020h,001h,010h,00dh,010h,00dh,020h	; b525  . ....... .....
	defb 00dh,010h,001h,020h,001h,010h,001h,020h,005h,010h,00ah,020h,00ah,010h,005h,010h	; b535  ... ... ... ....
	defb 00ah,010h,00ah,010h,00ah,010h,001h,020h,001h,010h,001h,010h,001h,010h,00eh,010h	; b545  ....... ........
	defb 00eh,010h,00eh,030h,00dh,010h,00dh,010h,001h,010h,001h,010h,00ah,010h,00ah,020h	; b555  ...0...........
	defb 001h,010h,00ah,020h,00ah,010h,00dh,010h,001h,010h,001h,010h,001h,010h,00eh,010h	; b565  ... ............
	defb 00ah,010h,001h,010h,001h,010h,00dh,020h,00eh,010h,00eh,0ffh	; b575  ....... ....

; ======================================================================
; CODIGO 0xb581..0xb59c  (27 bytes)
; ======================================================================


L_B581:
	push ix		;b581
	pop de			;b583
	ld a,004h		;b584
	add a,e			;b586
	ld e,a			;b587
	ld hl,0b59ch		;b588
	ld bc,0000fh		;b58b
	ldir		;b58e
	ld a,(0e205h)		;b590
	cp 070h		;b593
	ret nc			;b595
	ld de,0ffc0h		;b596
	jp L_AA78		;b599

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb59c..0xb60a  (110 bytes)
DATA_B59C:
	defb 098h,001h,000h,040h,000h,078h,000h,000h,0a0h,000h,040h,000h,0a0h,000h,001h,000h	; b59c  ...@.x....@.....
	defb 000h,00eh,030h,0cdh,086h,0aah,03ah,003h,0e0h,0e6h,007h,020h,005h,03eh,001h,0cdh	; b5ac  ..0...:.... .>..
	defb 03ah,041h,0ddh,07eh,001h,03dh,028h,00dh,03dh,028h,032h,0ddh,07eh,007h,0feh,074h	; b5bc  :A.~.=(.=(2.~..t
	defb 0d8h,0ddh,034h,001h,0c9h,0ddh,06eh,010h,0ddh,066h,011h,011h,0f2h,0ffh,019h,0ddh	; b5cc  ..4...n..f......
	defb 075h,010h,0ddh,074h,011h,0ddh,07eh,007h,0feh,084h,038h,004h,0ddh,034h,001h,0c9h	; b5dc  u..t..~...8..4..
	defb 0ddh,0cbh,014h,046h,0c0h,0cdh,01eh,0abh,0ddh,036h,014h,001h,0c9h,0ddh,06eh,010h	; b5ec  ...F.....6....n.
	defb 0ddh,066h,011h,011h,002h,000h,019h,0ddh,075h,010h,0ddh,074h,011h,0c9h	; b5fc  .f......u..t..

; ======================================================================
; CODIGO 0xb60a..0xb60b  (1 bytes)
; ======================================================================


L_B60A:
	ret			;b60a

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb60b..0xb60c  (1 bytes)
DATA_B60B:
	defb 0c9h	; b60b

; ======================================================================
; CODIGO 0xb60c..0xb60d  (1 bytes)
; ======================================================================


L_B60C:
	ret			;b60c

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb60d..0xb60e  (1 bytes)
DATA_B60D:
	defb 0c9h	; b60d

; ======================================================================
; CODIGO 0xb60e..0xb60f  (1 bytes)
; ======================================================================


L_B60E:
	ret			;b60e

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb60f..0xb610  (1 bytes)
DATA_B60F:
	defb 0c9h	; b60f

; ======================================================================
; CODIGO 0xb610..0xb6c4  (180 bytes)
; ======================================================================


L_B610:
	ld a,001h		;b610
	ld (0e282h),a		;b612
	ret			;b615
L_B616:
	ld a,(0e282h)		;b616
	and a			;b619
	ret z			;b61a
	ld hl,0e440h		;b61b
	ld b,005h		;b61e
L_B620:
	ld a,(hl)			;b620
	and a			;b621
	ld c,010h		;b622
	jr z,L_B63B		;b624
	inc l			;b626
	inc l			;b627
	ld a,(hl)			;b628
	cp 008h		;b629
	ld c,00eh		;b62b
	jr nz,L_B63B		;b62d
	dec l			;b62f
	ld a,(hl)			;b630
	cp 00ch		;b631
	jr z,L_B644		;b633
	cp 00dh		;b635
	jr z,L_B644		;b637
	ld c,00fh		;b639
L_B63B:
	ld a,c			;b63b
	add a,l			;b63c
	ld l,a			;b63d
	jr nc,L_B641		;b63e
	inc h			;b640
L_B641:
	djnz L_B620		;b641
	ret			;b643
L_B644:
	ld c,a			;b644
	ld hl,0e310h		;b645
	ld b,003h		;b648
L_B64A:
	ld a,(hl)			;b64a
	and a			;b64b
	jr z,L_B655		;b64c
	ld a,020h		;b64e
	add a,l			;b650
	ld l,a			;b651
	djnz L_B64A		;b652
	ret			;b654
L_B655:
	push hl			;b655
	ld b,020h		;b656
L_B658:
	ld (hl),000h		;b658
	inc l			;b65a
	djnz L_B658		;b65b
	pop ix		;b65d
	ld (ix+000h),005h		;b65f
	ld (ix+012h),001h		;b663
	xor a			;b667
	ld (0e282h),a		;b668
	ld (ix+007h),070h		;b66b
	ld (ix+00dh),002h		;b66f
	ld (ix+00bh),000h		;b673
	ld de,00500h		;b677
	call L_AA7F		;b67a
	ld (ix+013h),000h		;b67d
	ld (ix+004h),0b0h		;b681
	ld (ix+005h),00ah		;b685
	ld a,014h		;b689
	call 0413ah		;b68b
	ld hl,0e281h		;b68e
	ld a,(hl)			;b691
	inc (hl)			;b692
	and 003h		;b693
	ld de,0b6c4h		;b695
	add a,e			;b698
	ld e,a			;b699
	jr nc,L_B69D		;b69a
	inc d			;b69c
L_B69D:
	ld a,(de)			;b69d
	ld b,a			;b69e
	ld a,c			;b69f
	sub 00ch		;b6a0
	ld a,058h		;b6a2
	jr z,L_B6A8		;b6a4
	ld a,078h		;b6a6
L_B6A8:
	add a,b			;b6a8
	ld (ix+009h),a		;b6a9
	ld hl,0e205h		;b6ac
	sub (hl)			;b6af
	jr c,L_B6BB		;b6b0
	cp 030h		;b6b2
	ret c			;b6b4
	ld de,0ff00h		;b6b5
	jp L_AA78		;b6b8
L_B6BB:
	add a,020h		;b6bb
	ret c			;b6bd
	ld de,00100h		;b6be
	jp L_AA78		;b6c1

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb6c4..0xb6f4  (48 bytes)
DATA_B6C4:
	defb 000h,018h,008h,010h,0cdh,0dch,0b6h,011h,0c0h,0ffh,0ddh,06eh,010h,0ddh,066h,011h	; b6c4  ...........n..f.
	defb 019h,0ddh,075h,010h,0ddh,074h,011h,0c9h,0ddh,07eh,007h,0feh,080h,0d8h,00eh,0b4h	; b6d4  ..u..t...~......
	defb 0feh,090h,038h,008h,00eh,0b8h,0feh,0a0h,038h,002h,00eh,0bch,0ddh,071h,004h,0c9h	; b6e4  ..8.....8....q..

; ======================================================================
; CODIGO 0xb6f4..0xb704  (16 bytes)
; ======================================================================


L_B6F4:
	push ix		;b6f4
	pop de			;b6f6
	ld a,004h		;b6f7
	add a,e			;b6f9
	ld e,a			;b6fa
	ld hl,0b704h		;b6fb
	ld bc,00017h		;b6fe
	ldir		;b701
	ret			;b703

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb704..0xb873  (367 bytes)
DATA_B704:
	defb 098h,008h,000h,04eh,000h,078h,000h,018h,004h,000h,000h,0ffh,020h,000h,001h,000h	; b704  ...N.x...... ...
	defb 000h,000h,001h,000h,000h,000h,001h,00eh,030h,0cdh,086h,0aah,0ddh,06eh,00ch,0ddh	; b714  ........0....n..
	defb 066h,00dh,011h,002h,000h,019h,0ebh,0cdh,071h,0aah,0ddh,034h,013h,0ddh,07eh,013h	; b724  f.......q..4..~.
	defb 0feh,080h,020h,007h,0ddh,036h,013h,000h,0ddh,034h,016h,0ddh,034h,015h,0ddh,07eh	; b734  .. ..6...4..4..~
	defb 015h,0feh,040h,020h,00bh,0ddh,036h,015h,000h,0ddh,07eh,014h,02fh,0ddh,077h,014h	; b744  ..@ ..6...~./.w.
	defb 0ddh,07eh,015h,087h,021h,0cdh,0b7h,085h,06fh,030h,001h,024h,05eh,023h,056h,0ddh	; b754  .~..!...o0.$^#V.
	defb 07eh,014h,0a7h,028h,007h,0afh,093h,05fh,03eh,000h,09ah,057h,0ddh,046h,016h,021h	; b764  ~..(..._>..W.F.!
	defb 000h,000h,019h,010h,0fdh,0ebh,0cdh,078h,0aah,0ddh,034h,017h,0ddh,07eh,017h,0feh	; b774  .......x..4..~..
	defb 022h,020h,004h,0ddh,036h,017h,000h,0ddh,034h,019h,0ddh,07eh,019h,0feh,011h,020h	; b784  " ..6...4..~...
	defb 00eh,0ddh,034h,01ah,0ddh,036h,019h,000h,0ddh,07eh,018h,02fh,0ddh,077h,018h,0ddh	; b794  ..4..6...~./.w..
	defb 07eh,019h,087h,021h,051h,0b8h,085h,06fh,030h,001h,024h,05eh,023h,056h,0ddh,07eh	; b7a4  ~..!Q..o0.$^#V.~
	defb 018h,0a7h,028h,007h,0afh,093h,05fh,03eh,000h,09ah,057h,0ddh,046h,01ah,021h,000h	; b7b4  ..(..._>..W.F.!.
	defb 000h,019h,010h,0fdh,0ebh,0cdh,07fh,0aah,0c9h,000h,0ffh,008h,0ffh,010h,0ffh,018h	; b7c4  ................
	defb 0ffh,020h,0ffh,028h,0ffh,030h,0ffh,038h,0ffh,040h,0ffh,048h,0ffh,050h,0ffh,058h	; b7d4  . .(.0.8.@.H.P.X
	defb 0ffh,060h,0ffh,068h,0ffh,070h,0ffh,078h,0ffh,080h,0ffh,088h,0ffh,090h,0ffh,09ah	; b7e4  .`.h.p.x........
	defb 0ffh,0a0h,0ffh,0a8h,0ffh,0b0h,0ffh,0b8h,0ffh,0c0h,0ffh,0c8h,0ffh,0d0h,0ffh,0d8h	; b7f4  ................
	defb 0ffh,0e0h,0ffh,0e8h,0ffh,0f0h,0ffh,0f8h,0ffh,000h,000h,000h,000h,008h,000h,010h	; b804  ................
	defb 000h,018h,000h,020h,000h,028h,000h,030h,000h,038h,000h,040h,000h,048h,000h,050h	; b814  ... .(.0.8.@.H.P
	defb 000h,058h,000h,060h,000h,068h,000h,070h,000h,078h,000h,080h,000h,088h,000h,090h	; b824  .X.`.h.p.x......
	defb 000h,09ah,000h,0a0h,000h,0a8h,000h,0b0h,000h,0b8h,000h,0c0h,000h,0c8h,000h,0d0h	; b834  ................
	defb 000h,0d8h,000h,0e0h,000h,0e8h,000h,0f0h,000h,0f8h,000h,000h,001h,080h,0ffh,090h	; b844  ................
	defb 0ffh,0a0h,0ffh,0b0h,0ffh,0c0h,0ffh,0d0h,0ffh,0e0h,0ffh,0f0h,0ffh,000h,000h,010h	; b854  ................
	defb 000h,020h,000h,030h,000h,040h,000h,050h,000h,060h,000h,070h,000h,080h,000h	; b864  . .0.@.P.`.p...

; ======================================================================
; CODIGO 0xb873..0xb89f  (44 bytes)
; ======================================================================


L_B873:
	push ix		;b873
	pop de			;b875
	ld a,004h		;b876
	add a,e			;b878
	ld e,a			;b879
	ld hl,0b89fh		;b87a
	ld bc,0000fh		;b87d
	ldir		;b880
	ld a,(0e205h)		;b882
	cp 050h		;b885
	ld c,001h		;b887
	jr c,L_B892		;b889
	dec c			;b88b
	cp 090h		;b88c
	jr c,L_B892		;b88e
	ld c,002h		;b890
L_B892:
	ld (ix+013h),c		;b892
	ld (ix+01dh),001h		;b895
	ld a,016h		;b899
	call 0413ah		;b89b
	ret			;b89e

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb89f..0xb909  (106 bytes)
DATA_B89F:
	defb 098h,00eh,000h,04eh,000h,078h,000h,030h,000h,000h,000h,000h,000h,0feh,001h,00eh	; b89f  ...N.x.0........
	defb 02ch,0cdh,0adh,0aah,03ah,06ah,0e1h,0a7h,03eh,005h,020h,001h,0afh,0ddh,077h,005h	; b8af  ,...:j..>. ...w.
	defb 0ddh,07eh,001h,03dh,028h,036h,0ddh,07eh,00bh,0feh,00bh,0d0h,0ddh,036h,00bh,00bh	; b8bf  .~.=(6.~.....6..
	defb 0ddh,07eh,013h,021h,000h,000h,011h,000h,000h,0a7h,028h,00fh,021h,000h,000h,011h	; b8cf  .~.!......(.!...
	defb 080h,0ffh,03dh,028h,006h,021h,000h,000h,011h,080h,000h,0cdh,078h,0aah,0ebh,0cdh	; b8df  ..=(.!......x...
	defb 07fh,0aah,011h,0a0h,000h,0cdh,071h,0aah,0ddh,034h,001h,0c9h,0ddh,06eh,00ch,0ddh	; b8ef  ......q..4...n..
	defb 066h,00dh,023h,0ddh,075h,00ch,0ddh,074h,00dh,0c9h	; b8ff  f.#.u..t..

; ======================================================================
; CODIGO 0xb909..0xb90a  (1 bytes)
; ======================================================================


L_B909:
	ret			;b909

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb90a..0xb90b  (1 bytes)
DATA_B90A:
	defb 0c9h	; b90a

; ======================================================================
; CODIGO 0xb90b..0xb9a7  (156 bytes)
; ======================================================================


L_B90B:
	ld hl,0e310h		;b90b
	ld b,003h		;b90e
	xor a			;b910
	ld de,00020h		;b911
L_B914:
	cp (hl)			;b914
	jr z,L_B91F		;b915
	add hl,de			;b917
	djnz L_B914		;b918
	ld (ix+000h),000h		;b91a
	ret			;b91e
L_B91F:
	push hl			;b91f
	pop iy		;b920
	ld (hl),009h		;b922
	inc l			;b924
	ld b,01fh		;b925
	xor a			;b927
L_B928:
	ld (hl),a			;b928
	inc l			;b929
	djnz L_B928		;b92a
	push ix		;b92c
	pop de			;b92e
	ld a,004h		;b92f
	add a,e			;b931
	ld e,a			;b932
	ld hl,0b9a7h		;b933
	ld bc,00019h		;b936
	ldir		;b939
	dec e			;b93b
	dec e			;b93c
	dec e			;b93d
	dec e			;b93e
	xor a			;b93f
	ld (de),a			;b940
	ld hl,0e280h		;b941
	inc (hl)			;b944
	ld a,(hl)			;b945
	rra			;b946
	ld c,000h		;b947
	jr nc,L_B950		;b949
	inc c			;b94b
	rra			;b94c
	jr c,L_B950		;b94d
	inc c			;b94f
L_B950:
	ld (ix+01ah),c		;b950
	ld a,c			;b953
	ld de,00000h		;b954
	and a			;b957
	jr z,L_B963		;b958
	ld de,0fff0h		;b95a
	dec a			;b95d
	jr z,L_B963		;b95e
	ld de,00010h		;b960
L_B963:
	ld (ix+017h),e		;b963
	ld (ix+018h),d		;b966
	push iy		;b969
	pop de			;b96b
	ld a,004h		;b96c
	add a,e			;b96e
	ld e,a			;b96f
	ld hl,0b9a7h		;b970
	ld bc,00019h		;b973
	ldir		;b976
	dec e			;b978
	dec e			;b979
	dec e			;b97a
	dec e			;b97b
	ld a,00ch		;b97c
	ld (de),a			;b97e
	ld hl,0e280h		;b97f
	ld a,(hl)			;b982
	rra			;b983
	ld c,000h		;b984
	jr nc,L_B98D		;b986
	inc c			;b988
	rra			;b989
	jr c,L_B98D		;b98a
	inc c			;b98c
L_B98D:
	ld (iy+01ah),c		;b98d
	ld a,c			;b990
	ld de,00000h		;b991
	and a			;b994
	jr z,L_B9A0		;b995
	ld de,0fff0h		;b997
	dec a			;b99a
	jr z,L_B9A0		;b99b
	ld de,00010h		;b99d
L_B9A0:
	ld (iy+017h),e		;b9a0
	ld (iy+018h),d		;b9a3
	ret			;b9a6

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb9a7..0xbae0  (313 bytes)
DATA_B9A7:
	defb 098h,00ah,000h,04eh,000h,078h,000h,010h,010h,000h,000h,000h,000h,000h,001h,000h	; b9a7  ...N.x..........
	defb 078h,000h,010h,000h,000h,000h,000h,000h,001h,00eh,02ch,0cdh,0adh,0aah,0ddh,06eh	; b9b7  x.........,....n
	defb 00ch,0ddh,066h,00dh,011h,001h,000h,019h,0ddh,075h,00ch,0ddh,074h,00dh,0ddh,07eh	; b9c7  ..f......u..t..~
	defb 01ah,011h,000h,000h,0a7h,028h,009h,011h,0ffh,0ffh,03dh,028h,003h,011h,001h,000h	; b9d7  .....(....=(....
	defb 0ddh,06eh,017h,0ddh,066h,018h,019h,0ddh,075h,017h,0ddh,074h,018h,0ddh,05eh,013h	; b9e7  .n..f...u..t..^.
	defb 0ddh,056h,014h,019h,0ddh,075h,013h,0ddh,074h,014h,0ddh,06eh,015h,0ddh,066h,016h	; b9f7  .V...u..t..n..f.
	defb 011h,040h,000h,019h,0ddh,075h,015h,0ddh,074h,016h,0ddh,034h,01bh,0ddh,07eh,01bh	; ba07  .@...u..t..4..~.
	defb 0feh,018h,020h,011h,0ddh,034h,01ch,0ddh,036h,01bh,000h,0ddh,07eh,01ch,0feh,008h	; ba17  .. ..4..6...~...
	defb 020h,003h,0cdh,01eh,0abh,0ddh,034h,019h,0ddh,07eh,019h,0feh,018h,020h,004h,0ddh	; ba27   .....4..~... ..
	defb 036h,019h,000h,0ddh,07eh,019h,087h,087h,021h,080h,0bah,085h,06fh,030h,001h,024h	; ba37  6...~...!...o0.$
	defb 05eh,023h,056h,023h,04eh,023h,046h,0ddh,07eh,01ch,021h,000h,000h,009h,03dh,020h	; ba47  ^#V#N#F.~.!...=
	defb 0fch,04dh,044h,0ddh,07eh,01ch,021h,000h,000h,019h,03dh,020h,0fch,0ebh,0ddh,06eh	; ba57  .MD.~.!...= ...n
	defb 013h,0ddh,066h,014h,009h,0ddh,075h,008h,0ddh,074h,009h,0ddh,06eh,015h,0ddh,066h	; ba67  ..f...u..t..n..f
	defb 016h,019h,0ddh,075h,00ah,0ddh,074h,00bh,0c9h,000h,0feh,000h,000h,000h,0feh,080h	; ba77  ...u..t.........
	defb 0ffh,040h,0feh,000h,0ffh,080h,0feh,080h,0feh,000h,0ffh,040h,0feh,080h,0ffh,000h	; ba87  .@.........@....
	defb 0feh,000h,000h,000h,0feh,080h,000h,000h,0feh,000h,001h,040h,0feh,080h,001h,080h	; ba97  ...........@....
	defb 0feh,0c0h,001h,000h,0ffh,000h,002h,080h,0ffh,000h,002h,000h,000h,000h,002h,080h	; baa7  ................
	defb 000h,0c0h,001h,000h,001h,080h,001h,080h,001h,000h,001h,0c0h,001h,080h,000h,000h	; bab7  ................
	defb 002h,000h,000h,000h,002h,080h,0ffh,000h,002h,000h,0ffh,0c0h,001h,080h,0feh,080h	; bac7  ................
	defb 001h,040h,0feh,000h,001h,000h,0feh,080h,000h	; bad7  .@.......

; ======================================================================
; CODIGO 0xbae0..0xbb05  (37 bytes)
; ======================================================================


L_BAE0:
	push ix		;bae0
	pop de			;bae2
	ld a,004h		;bae3
	add a,e			;bae5
	ld e,a			;bae6
	ld hl,0bb05h		;bae7
	ld bc,00011h		;baea
	ldir		;baed
	ld hl,0e286h		;baef
	ld a,(hl)			;baf2
	inc (hl)			;baf3
	and 003h		;baf4
	ld hl,0bb16h		;baf6
	add a,a			;baf9
	add a,l			;bafa
	ld l,a			;bafb
	jr nc,L_BAFF		;bafc
	inc h			;bafe
L_BAFF:
	ld e,(hl)			;baff
	inc hl			;bb00
	ld d,(hl)			;bb01
	jp L_AA78		;bb02

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbb05..0xbb9b  (150 bytes)
DATA_BB05:
	defb 098h,001h,000h,04eh,000h,078h,000h,00bh,010h,000h,000h,000h,000h,000h,001h,000h	; bb05  ...N.x..........
	defb 001h,0b0h,0ffh,020h,000h,0e0h,0ffh,050h,000h,00eh,038h,0cdh,086h,0aah,0ddh,06eh	; bb15  ... ...P..8....n
	defb 00ch,0ddh,066h,00dh,011h,002h,000h,019h,0ebh,0cdh,071h,0aah,0ddh,034h,013h,0ddh	; bb25  ..f.......q..4..
	defb 07eh,013h,0feh,020h,020h,007h,0ddh,034h,014h,0afh,0ddh,077h,013h,021h,05bh,0bbh	; bb35  ~..  ..4...w.![.
	defb 087h,085h,06fh,030h,001h,024h,05eh,023h,056h,0ddh,046h,014h,021h,000h,000h,019h	; bb45  ..o0.$^#V.F.!...
	defb 010h,0fdh,0ebh,0c3h,07fh,0aah,000h,000h,000h,001h,0c0h,000h,080h,000h,070h,000h	; bb55  ..............p.
	defb 060h,000h,050h,000h,040h,000h,038h,000h,030h,000h,028h,000h,020h,000h,018h,000h	; bb65  `.P.@.8.0.(. ...
	defb 010h,000h,008h,000h,000h,000h,000h,000h,0f8h,0ffh,0f0h,0ffh,0e8h,0ffh,0e0h,0ffh	; bb75  ................
	defb 0d8h,0ffh,0d0h,0ffh,0c8h,0ffh,0c0h,0ffh,0b0h,0ffh,0a0h,0ffh,090h,0ffh,080h,0ffh	; bb85  ................
	defb 040h,0ffh,000h,0ffh,000h,000h	; bb95

; ======================================================================
; CODIGO 0xbb9b..0xbc3c  (161 bytes)
; ======================================================================


L_BB9B:
	ld a,001h		;bb9b
	ld (0e283h),a		;bb9d
	ret			;bba0
L_BBA1:
	ld a,(0e283h)		;bba1
	and a			;bba4
	ret z			;bba5
	ld hl,0e440h		;bba6
	ld b,005h		;bba9
L_BBAB:
	ld a,(hl)			;bbab
	and a			;bbac
	ld c,010h		;bbad
	jr z,L_BBCA		;bbaf
	inc l			;bbb1
	inc l			;bbb2
	ld a,(hl)			;bbb3
	cp 00eh		;bbb4
	ld c,00eh		;bbb6
	jr nz,L_BBCA		;bbb8
	dec l			;bbba
	ld a,(hl)			;bbbb
	cp 00eh		;bbbc
	jr z,L_BBD3		;bbbe
	cp 00fh		;bbc0
	jr z,L_BBD3		;bbc2
	cp 010h		;bbc4
	jr z,L_BBD3		;bbc6
	ld c,00fh		;bbc8
L_BBCA:
	ld a,c			;bbca
	add a,l			;bbcb
	ld l,a			;bbcc
	jr nc,L_BBD0		;bbcd
	inc h			;bbcf
L_BBD0:
	djnz L_BBAB		;bbd0
	ret			;bbd2
L_BBD3:
	ld c,a			;bbd3
	ld hl,0e310h		;bbd4
	ld b,003h		;bbd7
L_BBD9:
	ld a,(hl)			;bbd9
	and a			;bbda
	jr z,L_BBE4		;bbdb
	ld a,020h		;bbdd
	add a,l			;bbdf
	ld l,a			;bbe0
	djnz L_BBD9		;bbe1
	ret			;bbe3
L_BBE4:
	push hl			;bbe4
	ld b,020h		;bbe5
L_BBE7:
	ld (hl),000h		;bbe7
	inc l			;bbe9
	djnz L_BBE7		;bbea
	pop ix		;bbec
	ld (ix+000h),00bh		;bbee
	ld (ix+012h),001h		;bbf2
	xor a			;bbf6
	ld (0e283h),a		;bbf7
	ld (ix+007h),0a4h		;bbfa
	ld de,00000h		;bbfe
	call L_AA71		;bc01
	call L_AA78		;bc04
	ld de,00300h		;bc07
	call L_AA7F		;bc0a
	ld (ix+013h),003h		;bc0d
	ld (ix+004h),0a4h		;bc11
	ld (ix+005h),00fh		;bc15
	ld a,c			;bc19
	sub 00eh		;bc1a
	ld c,078h		;bc1c
	jr z,L_BC27		;bc1e
	dec a			;bc20
	ld c,040h		;bc21
	jr z,L_BC27		;bc23
	ld c,0b8h		;bc25
L_BC27:
	ld (ix+009h),c		;bc27
	ld (ix+00bh),00bh		;bc2a
	ld (ix+014h),000h		;bc2e
	ld (ix+015h),000h		;bc32
	ld a,011h		;bc36
	call 0413ah		;bc38
	ret			;bc3b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbc3c..0xbcbf  (131 bytes)
DATA_BC3C:
	defb 0ddh,034h,015h,0ddh,07eh,015h,0feh,080h,020h,007h,0ddh,036h,015h,000h,0cdh,01eh	; bc3c  .4..~... ..6....
	defb 0abh,0ddh,07eh,001h,03dh,028h,014h,0ddh,07eh,00bh,0feh,080h,0d8h,0ddh,036h,00fh	; bc4c  ..~.=(..~.....6.
	defb 001h,011h,000h,000h,0cdh,07fh,0aah,0ddh,034h,001h,0c9h,0ddh,0cbh,014h,05eh,03eh	; bc5c  ........4.....^>
	defb 0a4h,020h,002h,03eh,0a8h,0ddh,077h,004h,0ddh,07eh,009h,0feh,020h,038h,004h,0feh	; bc6c  . .>..w..~.. 8..
	defb 0d0h,038h,011h,0ddh,07eh,013h,0a7h,028h,00bh,0ddh,035h,013h,0ddh,07eh,00fh,0edh	; bc7c  .8..~..(..5..~..
	defb 044h,0ddh,077h,00fh,0ddh,04eh,014h,0ddh,034h,014h,0ddh,07eh,014h,0feh,010h,020h	; bc8c  D.w..N..4..~...
	defb 004h,0ddh,036h,014h,000h,021h,0afh,0bch,079h,085h,06fh,030h,001h,024h,07eh,0ddh	; bc9c  ..6..!..y.o0.$~.
	defb 077h,011h,0c9h,001h,002h,001h,000h,0ffh,0feh,0ffh,0ffh,0ffh,0feh,0ffh,000h,001h	; bcac  w...............
	defb 002h,001h,001h	; bcbc

; ======================================================================
; CODIGO 0xbcbf..0xbcec  (45 bytes)
; ======================================================================


L_BCBF:
	push ix		;bcbf
	pop de			;bcc1
	ld a,004h		;bcc2
	add a,e			;bcc4
	ld e,a			;bcc5
	ld hl,0bcech		;bcc6
	ld bc,0000fh		;bcc9
	ldir		;bccc
	ld a,(0e204h)		;bcce
	ld c,a			;bcd1
	ld a,0a0h		;bcd2
	sub c			;bcd4
	ld (ix+00bh),a		;bcd5
	ld c,0f0h		;bcd8
	ld de,0fe00h		;bcda
	bit 0,a		;bcdd
	jr nz,L_BCE6		;bcdf
	ld c,002h		;bce1
	ld de,00200h		;bce3
L_BCE6:
	ld (ix+009h),c		;bce6
	jp L_AA78		;bce9

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbcec..0xbd0f  (35 bytes)
DATA_BCEC:
	defb 0d8h,008h,000h,0a8h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,00eh	; bcec  ................
	defb 030h,0cdh,086h,0aah,0ddh,07eh,009h,0feh,002h,038h,003h,0feh,0f8h,0d8h,0ddh,036h	; bcfc  0....~...8.....6
	defb 000h,000h,0c9h	; bd0c

; ======================================================================
; CODIGO 0xbd0f..0xbd24  (21 bytes)
; ======================================================================


L_BD0F:
	push ix		;bd0f
	pop de			;bd11
	ld a,004h		;bd12
	add a,e			;bd14
	ld e,a			;bd15
	ld hl,0bd24h		;bd16
	ld bc,00010h		;bd19
	ldir		;bd1c
	ld a,012h		;bd1e
	call 0413ah		;bd20
	ret			;bd23

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbd24..0xbe01  (221 bytes)
DATA_BD24:
	defb 0a4h,00ah,000h,0a8h,000h,078h,000h,098h,000h,000h,000h,0feh,000h,000h,001h,0ddh	; bd24  .....x..........
	defb 034h,014h,0ddh,0cbh,014h,05eh,03eh,0a4h,020h,002h,03eh,0a8h,0ddh,077h,004h,0ddh	; bd34  4....^>. .>..w..
	defb 07eh,001h,03dh,028h,036h,03dh,028h,062h,03dh,0cah,0ddh,0bdh,0ddh,06eh,010h,0ddh	; bd44  ~.=(6=(b=....n..
	defb 066h,011h,011h,0f8h,0ffh,019h,0ebh,0cdh,07fh,0aah,0ddh,06eh,00eh,0ddh,066h,00fh	; bd54  f..........n..f.
	defb 011h,008h,000h,019h,0ebh,0cdh,078h,0aah,0cbh,012h,0d8h,011h,000h,000h,0cdh,078h	; bd64  ......x........x
	defb 0aah,011h,000h,0feh,0cdh,07fh,0aah,0ddh,034h,001h,0c9h,0ddh,06eh,00eh,0ddh,066h	; bd74  ........4...n..f
	defb 00fh,011h,008h,000h,019h,0ebh,0cdh,078h,0aah,0ddh,06eh,010h,0ddh,066h,011h,011h	; bd84  .......x..n..f..
	defb 008h,000h,019h,0ebh,0cdh,07fh,0aah,0cbh,012h,0d8h,011h,000h,002h,0cdh,078h,0aah	; bd94  ..............x.
	defb 011h,000h,000h,0cdh,07fh,0aah,0ddh,034h,001h,0c9h,0ddh,06eh,010h,0ddh,066h,011h	; bda4  .......4...n..f.
	defb 011h,008h,000h,019h,0ebh,0cdh,07fh,0aah,0ddh,06eh,00eh,0ddh,066h,00fh,011h,0f8h	; bdb4  .........n..f...
	defb 0ffh,019h,0ebh,0cdh,078h,0aah,0cbh,012h,0d0h,011h,000h,000h,0cdh,078h,0aah,011h	; bdc4  ....x........x..
	defb 000h,002h,0cdh,07fh,0aah,0ddh,034h,001h,0c9h,0ddh,06eh,00eh,0ddh,066h,00fh,011h	; bdd4  ......4...n..f..
	defb 0f8h,0ffh,019h,0ebh,0cdh,078h,0aah,0ddh,06eh,010h,0ddh,066h,011h,011h,0f8h,0ffh	; bde4  .....x..n..f....
	defb 019h,0ebh,0cdh,07fh,0aah,0cbh,012h,0d0h,0ddh,036h,000h,000h,0c9h	; bdf4  .........6...

; ======================================================================
; CODIGO 0xbe01..0xbe3a  (57 bytes)
; ======================================================================


L_BE01:
	push ix		;be01
	pop de			;be03
	ld a,004h		;be04
	add a,e			;be06
	ld e,a			;be07
	ld hl,0be3ah		;be08
	ld bc,0000fh		;be0b
	ldir		;be0e
	ld hl,0e284h		;be10
	ld a,(hl)			;be13
	inc (hl)			;be14
	ld hl,0be49h		;be15
	and 007h		;be18
	add a,l			;be1a
	ld l,a			;be1b
	jr nc,L_BE1F		;be1c
	inc h			;be1e
L_BE1F:
	ld a,(hl)			;be1f
	ld (ix+009h),a		;be20
	ld a,(0e205h)		;be23
	cp (ix+009h)		;be26
	ld de,0fe00h		;be29
	jr c,L_BE31		;be2c
	ld de,00200h		;be2e
L_BE31:
	call L_AA78		;be31
	ld a,015h		;be34
	call 0413ah		;be36
	ret			;be39

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe3a..0xbe52  (24 bytes)
DATA_BE3A:
	defb 0bch,00ah,000h,0a8h,000h,000h,000h,098h,000h,000h,000h,000h,000h,0fdh,001h,020h	; be3a  ...............
	defb 080h,0c0h,060h,0e0h,0a0h,040h,070h,0c9h	; be4a  ..`..@p.

; ======================================================================
; CODIGO 0xbe52..0xbe7e  (44 bytes)
; ======================================================================


L_BE52:
	ld (ix+005h),00fh		;be52
	ld (ix+007h),0a4h		;be56
	ld (ix+00bh),070h		;be5a
	ld (ix+012h),001h		;be5e
	ld (ix+013h),080h		;be62
	ld hl,0e303h		;be66
	inc (hl)			;be69
	bit 0,(hl)		;be6a
	ld a,002h		;be6c
	ld de,00100h		;be6e
	jr nz,L_BE78		;be71
	ld a,0f0h		;be73
	ld de,0ff00h		;be75
L_BE78:
	ld (ix+009h),a		;be78
	jp L_AA78		;be7b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe7e..0xc000  (386 bytes)
DATA_BE7E:
	defb 03ah,003h,0e0h,0e6h,004h,00eh,0a4h,028h,002h,00eh,0a8h,0ddh,071h,004h,0ddh,07eh	; be7e  :......(....q..~
	defb 001h,03dh,028h,017h,03dh,0c8h,03ah,005h,0e2h,0ddh,096h,009h,030h,002h,0edh,044h	; be8e  .=(.=.:.....0..D
	defb 0feh,008h,0d0h,0ddh,034h,001h,0ddh,036h,012h,000h,0c9h,0ddh,035h,013h,028h,009h	; be9e  ....4..6....5.(.
	defb 0ddh,07eh,013h,0feh,040h,0c0h,0c3h,01eh,0abh,0ddh,034h,001h,0ddh,036h,012h,001h	; beae  .~..@.....4..6..
	defb 0c9h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bebe  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bece  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bede  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beee  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; befe  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfae  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfbe  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfce  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfde  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfee  ................
	defb 0ffh,0ffh	; bffe
