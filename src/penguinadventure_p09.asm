; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 09 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
labb3h:	equ 0x0abb3

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
	ld (0e301h),hl		;a894   ; lo andado en la fase
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
	defw 0b581h	; a8d1  -> monta_clase_1
	defw 0b60ah	; a8d3  -> monta_clase_2
	defw 0b60ch	; a8d5  -> monta_clase_3
	defw 0b60eh	; a8d7  -> monta_clase_4
	defw 0b610h	; a8d9  -> monta_clase_5
	defw 0b6f4h	; a8db  -> monta_clase_6
	defw 0b873h	; a8dd  -> monta_clase_7
	defw 0b909h	; a8df  -> monta_clase_8
	defw 0b90bh	; a8e1  -> monta_clase_9
	defw 0bae0h	; a8e3  -> monta_clase_10
	defw 0bb9bh	; a8e5  -> monta_clase_11
	defw 0bcbfh	; a8e7  -> monta_clase_12
	defw 0bd0fh	; a8e9  -> monta_clase_13
	defw 0be01h	; a8eb  -> monta_clase_14
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
; DATOS tabla_de_atender: La hermana de la de 0xA8D1: alli esta la rutina que
;   MONTA cada clase de objeto y aqui la que la atiende en cada cuadro. Y
;   tiene DIECISEIS entradas, una mas que la de montar: 0xB5AD, 0xB60B,
;   0xB60D, 0xB60F, 0xB6C8, 0xB71B, 0xB8AE, 0xB90A, 0xB9C0, 0xBB1E, 0xBC3C,
;   0xBCFB, 0xBD33, 0xBE51, 0xBE7E y 0xAAC9. La decimosexta clase existe -su
;   rutina de atender es codigo de verdad- pero el guion de la fase no puede
;   sacarla, porque en el mismo hueco de la tabla de montar hay un 0x0F21 que
;   no es ni una direccion del cartucho: a esa clase la crea otra rutina,
;   escribiendo el numero directamente en el hueco.
;   0xa98a..0xa9aa  (32 bytes)
DATA_tabla_de_atender:
	defw 0b5adh	; a98a  -> atiende_clase_1
	defw 0b60bh	; a98c  -> atiende_clase_2
	defw 0b60dh	; a98e  -> atiende_clase_3
	defw 0b60fh	; a990  -> atiende_clase_4
	defw 0b6c8h	; a992  -> atiende_clase_5
	defw 0b71bh	; a994  -> atiende_clase_6
	defw 0b8aeh	; a996  -> atiende_clase_7
	defw 0b90ah	; a998  -> atiende_clase_8
	defw 0b9c0h	; a99a  -> atiende_clase_9
	defw 0bb1eh	; a99c  -> atiende_clase_10
	defw 0bc3ch	; a99e  -> atiende_clase_11
	defw 0bcfbh	; a9a0  -> atiende_clase_12
	defw 0bd33h	; a9a2  -> atiende_clase_13
	defw 0be51h	; a9a4  -> L_BE51
	defw 0be7eh	; a9a6  -> L_BE7E
	defw 0aac9h	; a9a8  -> L_AAC9

; ======================================================================
; CODIGO 0xa9aa..0xab15  (363 bytes)
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
L_AA86:
	ld a,(ix+007h)		;aa86
	cp 060h		;aa89
	ret c			;aa8b
	cp 078h		;aa8c
	jr c,L_AA9E		;aa8e
	inc c			;aa90
	inc c			;aa91
	cp 090h		;aa92
	jr c,L_AA9E		;aa94
	inc c			;aa96
	inc c			;aa97
	cp 0a8h		;aa98
	jr c,L_AA9E		;aa9a
	inc c			;aa9c
	inc c			;aa9d
L_AA9E:
	ld a,(0e003h)		;aa9e   ; el contador de cuadros
	and 004h		;aaa1
	jr nz,L_AAA6		;aaa3
	inc c			;aaa5
L_AAA6:
	ld a,c			;aaa6
	add a,a			;aaa7
	add a,a			;aaa8
	ld (ix+004h),a		;aaa9
	ret			;aaac
L_AAAD:
	ld a,(ix+007h)		;aaad
	cp 060h		;aab0
	ret c			;aab2
	cp 078h		;aab3
	jr c,L_AAC2		;aab5
	inc c			;aab7
	cp 090h		;aab8
	jr c,L_AAC2		;aaba
	inc c			;aabc
	cp 0a8h		;aabd
	jr c,L_AAC2		;aabf
	inc c			;aac1
L_AAC2:
	ld a,c			;aac2
	add a,a			;aac3
	add a,a			;aac4
	ld (ix+004h),a		;aac5
	ret			;aac8
L_AAC9:
	ld a,(ix+01fh)		;aac9
	and a			;aacc
	jr z,L_AAD0		;aacd
	ret			;aacf
L_AAD0:
	ld a,(ix+01dh)		;aad0
	and a			;aad3
	jr z,L_AADA		;aad4
	ld (ix+005h),005h		;aad6
L_AADA:
	ld a,r		;aada
	and 001h		;aadc
	ld (ix+01eh),a		;aade
	xor a			;aae1
	ld (ix+00ch),a		;aae2
	ld (ix+00dh),a		;aae5
	ld (ix+00eh),a		;aae8
	ld (ix+010h),a		;aaeb
	ld (ix+012h),001h		;aaee
	inc (ix+01fh)		;aaf2
	ld hl,0ab15h		;aaf5
	ld a,r		;aaf8
	and 007h		;aafa
	add a,l			;aafc
	ld l,a			;aafd
	jr nc,L_AB01		;aafe
	inc h			;ab00
L_AB01:
	ld a,(hl)			;ab01
	ld (ix+011h),a		;ab02
	inc hl			;ab05
	ld a,(hl)			;ab06
	ld b,a			;ab07
	ld a,(ix+01eh)		;ab08
	and a			;ab0b
	ld a,b			;ab0c
	jr z,L_AB11		;ab0d
	neg		;ab0f
L_AB11:
	ld (ix+00fh),a		;ab11
	ret			;ab14

; ----------------------------------------------------------------------
; DATOS sin identificar  0xab15..0xab1e  (9 bytes)
DATA_AB15:
	defb 008h,004h,005h,005h,003h,006h,009h,002h,007h	; ab15  .........

; ======================================================================
; CODIGO 0xab1e..0xabb4  (150 bytes)
; ======================================================================


L_AB1E:
	ld hl,0e370h		;ab1e
	ld a,(hl)			;ab21
	and a			;ab22
	jr z,L_AB30		;ab23
	ld l,080h		;ab25
	ld a,(hl)			;ab27
	and a			;ab28
	jr z,L_AB30		;ab29
	ld l,090h		;ab2b
	ld a,(hl)			;ab2d
	and a			;ab2e
	ret nz			;ab2f
L_AB30:
	ld a,(ix+000h)		;ab30
	ld de,labb3h		;ab33
	add a,e			;ab36
	ld e,a			;ab37
	jr nc,L_AB3B		;ab38
	inc d			;ab3a
L_AB3B:
	ld a,(de)			;ab3b
	ld (hl),a			;ab3c
	xor a			;ab3d
	ld (0e4e0h),a		;ab3e   ; la tabla de cambio de color, nibble alto
	inc l			;ab41
	ld (hl),000h		;ab42
	inc l			;ab44
	ld a,(ix+002h)		;ab45
	ld (hl),a			;ab48
	ld c,a			;ab49
	ld a,(0e204h)		;ab4a   ; la X en la pantalla de lo que se maneja
	cp (hl)			;ab4d
	jr c,L_AB99		;ab4e
	inc l			;ab50
	ld (hl),000h		;ab51
	inc l			;ab53
	ld a,(ix+003h)		;ab54
	ld (hl),a			;ab57
	ld b,a			;ab58
	call L_AB9E		;ab59
	jr c,L_AB97		;ab5c
	inc l			;ab5e
	inc l			;ab5f
	inc l			;ab60
	push hl			;ab61
	call L_AC75		;ab62
	call L_AD27		;ab65
	push de			;ab68
	ld e,c			;ab69
	ld d,b			;ab6a
	call L_AD0E		;ab6b
	ld c,l			;ab6e
	ld b,h			;ab6f
	pop de			;ab70
	pop hl			;ab71
	ld (hl),c			;ab72
	inc l			;ab73
	ld (hl),b			;ab74
	inc l			;ab75
	push hl			;ab76
	call L_AD0E		;ab77
	ex de,hl			;ab7a
	pop hl			;ab7b
	ld (hl),e			;ab7c
	inc l			;ab7d
	ld (hl),d			;ab7e
	ld a,l			;ab7f
	sub 00ah		;ab80
	ld l,a			;ab82
	ld a,(hl)			;ab83
	cp 006h		;ab84
	jr nz,L_AB8E		;ab86
	ld a,013h		;ab88
	call 0413ah		;ab8a   ; banco 0: pide_sonido_si_esta_activo
	ret			;ab8d
L_AB8E:
	cp 004h		;ab8e
	ret nz			;ab90
	ld a,00fh		;ab91
	call 0413ah		;ab93   ; banco 0: pide_sonido_si_esta_activo
	ret			;ab96
L_AB97:
	dec l			;ab97
	dec l			;ab98
L_AB99:
	dec l			;ab99
	dec l			;ab9a
	ld (hl),000h		;ab9b
	ret			;ab9d
L_AB9E:
	ld a,(0e204h)		;ab9e   ; la X en la pantalla de lo que se maneja
	cp c			;aba1
	jr nc,L_ABA6		;aba2
	neg		;aba4
L_ABA6:
	cp 020h		;aba6
	ret c			;aba8
	ld a,(0e205h)		;aba9   ; la Y en la pantalla de lo que se maneja
	cp b			;abac
	jr nc,L_ABB1		;abad
	neg		;abaf
L_ABB1:
	cp 020h		;abb1
L_ABB3:
	ret			;abb3

; ----------------------------------------------------------------------
; DATOS sin identificar  0xabb4..0xabc3  (15 bytes)
DATA_ABB4:
	defb 001h,000h,000h,002h,000h,000h,000h,000h,003h,000h,004h,000h,005h,000h,006h	; abb4  ...............

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
; CODIGO 0xabf5..0xad77  (386 bytes)
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
	ld a,(0e0dch)		;ac14   ; la pausa que se hace al perder o al cambiar de fase
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
L_AC75:
	ld a,(0e204h)		;ac75   ; la X en la pantalla de lo que se maneja
	ld l,a			;ac78
	ld a,(0e205h)		;ac79   ; la Y en la pantalla de lo que se maneja
	add a,010h		;ac7c
	ld h,a			;ac7e
	ld d,001h		;ac7f
	ld a,l			;ac81
	sub (ix+002h)		;ac82
	ld b,000h		;ac85
	jr z,L_AC90		;ac87
	ld b,a			;ac89
	jr nc,L_AC90		;ac8a
	dec d			;ac8c
	neg		;ac8d
	ld b,a			;ac8f
L_AC90:
	ld a,h			;ac90
	sub (ix+003h)		;ac91
	ld e,000h		;ac94
	ld c,000h		;ac96
	jr z,L_ACA1		;ac98
	ld c,a			;ac9a
	jr nc,L_ACA1		;ac9b
	inc e			;ac9d
	neg		;ac9e
	ld c,a			;aca0
L_ACA1:
	ld a,d			;aca1
	add a,e			;aca2
	cp 001h		;aca3
	jr nz,L_ACAC		;aca5
	dec d			;aca7
	jr nz,L_ACAC		;aca8
	ld a,003h		;acaa
L_ACAC:
	ld d,a			;acac
	ld l,b			;acad
	ld h,000h		;acae
	ld b,c			;acb0
	push de			;acb1
	call L_ACF8		;acb2
	ld hl,0adb8h		;acb5
	ld b,040h		;acb8
L_ACBA:
	ld a,(hl)			;acba
	inc hl			;acbb
	push hl			;acbc
	ld h,(hl)			;acbd
	ld l,a			;acbe
	and a			;acbf
	sbc hl,de		;acc0
	pop hl			;acc2
	jr c,L_ACCC		;acc3
	inc hl			;acc5
	ld a,b			;acc6
	sub 008h		;acc7
	ld b,a			;acc9
	jr nz,L_ACBA		;acca
L_ACCC:
	pop de			;accc
	dec d			;accd
	jr nz,L_ACD6		;acce
	ld a,040h		;acd0
	sub b			;acd2
	add a,040h		;acd3
	ret			;acd5
L_ACD6:
	dec d			;acd6
	jr nz,L_ACDD		;acd7
	ld a,080h		;acd9
	add a,b			;acdb
	ret			;acdc
L_ACDD:
	ld a,b			;acdd
	dec d			;acde
	ret nz			;acdf
	neg		;ace0
	ret			;ace2
L_ACE3:
	ld c,008h		;ace3
	xor a			;ace5
L_ACE6:
	adc hl,hl		;ace6
	ld a,h			;ace8
	jr c,L_ACEE		;ace9
	cp b			;aceb
	jr c,L_ACF1		;acec
L_ACEE:
	sub b			;acee
	ld h,a			;acef
	xor a			;acf0
L_ACF1:
	ccf			;acf1
	dec c			;acf2
	jr nz,L_ACE6		;acf3
	rl l		;acf5
	ret			;acf7
L_ACF8:
	ld a,b			;acf8
	or a			;acf9
	jr z,L_AD0A		;acfa
	ld de,00000h		;acfc
	call L_ACE3		;acff
	ld d,l			;ad02
	ld l,000h		;ad03
	call L_ACE3		;ad05
	ld e,l			;ad08
	ret			;ad09
L_AD0A:
	dec a			;ad0a
	ld d,a			;ad0b
	ld e,a			;ad0c
	ret			;ad0d
L_AD0E:
	bit 7,d		;ad0e
	push af			;ad10
	jr z,L_AD1A		;ad11
	ld a,e			;ad13
	cpl			;ad14
	ld e,a			;ad15
	ld a,d			;ad16
	cpl			;ad17
	ld d,a			;ad18
	inc de			;ad19
L_AD1A:
	ld l,e			;ad1a
	ld h,d			;ad1b
	add hl,de			;ad1c
	pop af			;ad1d
	ret z			;ad1e
	ld a,l			;ad1f
	cpl			;ad20
	ld l,a			;ad21
	ld a,h			;ad22
	cpl			;ad23
	ld h,a			;ad24
	inc hl			;ad25
	ret			;ad26
L_AD27:
	ld b,a			;ad27
	ld c,000h		;ad28
	cp 041h		;ad2a
	jr c,L_AD44		;ad2c
	inc c			;ad2e
	cp 080h		;ad2f
	jr nc,L_AD38		;ad31
	ld a,080h		;ad33
	sub b			;ad35
	jr L_AD44		;ad36
L_AD38:
	inc c			;ad38
	cp 0c0h		;ad39
	jr nc,L_AD41		;ad3b
	sub 080h		;ad3d
	jr L_AD44		;ad3f
L_AD41:
	inc c			;ad41
	neg		;ad42
L_AD44:
	ld b,a			;ad44
	ex af,af'			;ad45
	ld a,b			;ad46
	ex af,af'			;ad47
	ld hl,0ad77h		;ad48
	add a,l			;ad4b
	ld l,a			;ad4c
	jr nc,L_AD50		;ad4d
	inc h			;ad4f
L_AD50:
	ld d,000h		;ad50
	ld e,(hl)			;ad52
	ld a,c			;ad53
	sub 001h		;ad54
	cp 002h		;ad56
	ld a,e			;ad58
	jr nc,L_AD5E		;ad59
	dec d			;ad5b
	neg		;ad5c
L_AD5E:
	ld e,a			;ad5e
	ld hl,0ad77h		;ad5f
	ld a,040h		;ad62
	sub b			;ad64
	add a,l			;ad65
	ld l,a			;ad66
	jr nc,L_AD6A		;ad67
	inc h			;ad69
L_AD6A:
	ld b,000h		;ad6a
	ld a,c			;ad6c
	cp 002h		;ad6d
	ld a,(hl)			;ad6f
	jr nc,L_AD75		;ad70
	dec b			;ad72
	neg		;ad73
L_AD75:
	ld c,a			;ad75
	ret			;ad76

; ----------------------------------------------------------------------
; DATOS sin identificar  0xad77..0xb581  (2058 bytes)
DATA_AD77:
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0fdh,0fch,0fbh,0f9h,0f8h,0f6h,0f4h,0f3h,0f1h,0eeh	; ad77  ................
	defb 0ech,0eah,0e7h,0e4h,0e1h,0deh,0dch,0d9h,0d4h,0d1h,0cdh,0c9h,0c5h,0c1h,0bdh,0b9h	; ad87  ................
	defb 0b5h,0b0h,0abh,0a7h,0a2h,09dh,098h,093h,08eh,088h,083h,07eh,078h,073h,069h,067h	; ad97  ...........~xsig
	defb 061h,05ch,056h,050h,04ah,044h,03eh,038h,02eh,02bh,02fh,01fh,019h,012h,00ch,006h	; ada7  a\VPJD>8.+/.....
	defb 001h,0f6h,004h,066h,002h,07dh,001h,0ffh,000h,0aah,000h,069h,000h,032h,000h,000h	; adb7  ...f.}.....i.2..
	defb 000h,0ffh,0ffh,00ah,010h,00ah,010h,00ah,030h,00ah,015h,00ah,010h,00ah,015h,00ah	; adc7  ........0.......
	defb 060h,00ah,020h,00ah,010h,00ah,010h,00ah,020h,00ah,010h,00ah,010h,00ah,020h,00ah	; add7  `. ..... ..... .
	defb 010h,00ah,010h,00ah,010h,00ah,050h,000h,070h,00ah,010h,00ah,010h,00ah,010h,00ah	; ade7  ......P.p.......
	defb 020h,00ah,010h,00ah,010h,00ah,0ffh,0ffh,00ch,010h,00ch,020h,00ch,020h,00ch,010h	; adf7   .......... . ..
	defb 00ch,010h,00ch,010h,00ch,020h,00ch,020h,00ch,020h,00ch,010h,00ch,020h,00ch,010h	; ae07  ..... . . ... ..
	defb 00ch,040h,00ch,010h,00ch,010h,00ch,010h,00ch,040h,00ch,0ffh,00ah,010h,00ah,010h	; ae17  .@.......@......
	defb 00ah,010h,00ah,030h,00ah,010h,00ah,010h,00ah,010h,00ah,010h,00ah,030h,00ah,010h	; ae27  ...0.........0..
	defb 00ah,010h,00ah,010h,00ah,070h,005h,005h,005h,015h,00ah,010h,00ah,015h,005h,015h	; ae37  .....p..........
	defb 005h,030h,005h,040h,00ah,010h,005h,010h,00ah,020h,005h,010h,00ah,010h,00ah,010h	; ae47  .0.@..... ......
	defb 00ah,010h,005h,010h,00ah,010h,005h,0ffh,00ah,005h,00ah,005h,00ah,060h,000h,045h	; ae57  .............`.E
	defb 00ah,005h,00ah,010h,00ah,020h,00ah,010h,00ah,050h,000h,060h,00ah,005h,00ah,005h	; ae67  ..... ...P.`....
	defb 00ah,010h,00ah,010h,00ah,025h,00ah,005h,00ah,080h,00ah,010h,00ah,010h,00ah,005h	; ae77  .....%..........
	defb 00ah,015h,00ah,010h,00ah,060h,00ah,010h,00ah,010h,00ah,010h,00ah,0ffh,007h,005h	; ae87  .....`..........
	defb 007h,025h,007h,010h,007h,040h,007h,005h,007h,005h,007h,040h,001h,010h,001h,005h	; ae97  .%...@.....@....
	defb 001h,015h,001h,030h,007h,005h,007h,015h,001h,010h,001h,030h,007h,010h,001h,020h	; aea7  ...0.......0...
	defb 001h,010h,007h,005h,007h,035h,001h,005h,001h,005h,001h,010h,001h,040h,007h,005h	; aeb7  .....5.......@..
	defb 007h,005h,001h,005h,007h,015h,001h,0ffh,00fh,020h,00fh,030h,00fh,010h,00ah,010h	; aec7  ......... .0....
	defb 00ah,020h,00fh,010h,00ah,010h,00ah,075h,00fh,015h,00ah,010h,00ah,010h,00ah,010h	; aed7  . .....u........
	defb 00ah,030h,005h,010h,005h,005h,00fh,015h,005h,005h,005h,015h,00fh,010h,005h,010h	; aee7  .0..............
	defb 005h,005h,00fh,075h,005h,010h,00ah,010h,005h,010h,00fh,020h,00ah,010h,00ah,005h	; aef7  ...u....... ....
	defb 00fh,005h,00fh,030h,005h,0ffh,00ch,010h,00ch,010h,00ch,030h,007h,005h,007h,010h	; af07  ...0.......0....
	defb 007h,090h,00bh,015h,00bh,030h,00bh,030h,00ch,010h,00ch,010h,007h,005h,007h,035h	; af17  .....0.0.......5
	defb 00ch,005h,00ch,005h,007h,040h,00ch,010h,00ch,005h,00ch,010h,00bh,055h,00ch,010h	; af27  .....@.......U..
	defb 00ch,005h,00bh,025h,007h,010h,007h,005h,00bh,015h,00ch,005h,00ch,005h,00ch,010h	; af37  ...%............
	defb 007h,005h,007h,015h,00ch,010h,00ch,010h,00ch,0ffh,007h,010h,007h,010h,007h,030h	; af47  ...............0
	defb 006h,010h,006h,010h,006h,020h,007h,080h,007h,010h,007h,010h,006h,010h,006h,010h	; af57  ..... ..........
	defb 006h,050h,007h,010h,007h,030h,006h,010h,006h,010h,007h,030h,007h,010h,006h,020h	; af67  .P...0.....0...
	defb 006h,005h,007h,055h,006h,010h,006h,050h,007h,010h,007h,010h,007h,020h,006h,020h	; af77  ...U...P..... .
	defb 006h,010h,007h,005h,007h,0ffh,00fh,010h,00fh,040h,00ah,010h,00ah,010h,00ah,020h	; af87  .........@.....
	defb 00ah,010h,00fh,010h,00ah,020h,001h,005h,001h,015h,001h,040h,00ah,005h,00ah,005h	; af97  ..... .....@....
	defb 00fh,010h,005h,010h,005h,010h,005h,050h,001h,010h,001h,010h,001h,010h,00fh,010h	; afa7  .......P........
	defb 001h,010h,005h,010h,005h,035h,005h,025h,005h,010h,005h,030h,00fh,030h,005h,010h	; afb7  .....5.%...0.0..
	defb 005h,030h,00fh,010h,00ah,010h,001h,010h,001h,020h,00ah,010h,00ah,010h,001h,005h	; afc7  .0....... ......
	defb 001h,005h,001h,020h,00fh,005h,00ah,005h,00ah,010h,001h,010h,001h,020h,00ah,010h	; afd7  ... ......... ..
	defb 001h,0ffh,009h,010h,009h,030h,009h,010h,009h,020h,009h,020h,009h,010h,009h,060h	; afe7  .....0... . ...`
	defb 009h,010h,009h,010h,009h,040h,009h,010h,009h,010h,009h,070h,009h,010h,009h,020h	; aff7  .....@.....p...
	defb 009h,010h,009h,010h,009h,040h,009h,0ffh,00ah,010h,00ah,010h,00ah,010h,001h,010h	; b007  .....@..........
	defb 001h,010h,00fh,010h,00fh,005h,001h,005h,001h,030h,00ah,005h,00ah,005h,00fh,005h	; b017  .........0......
	defb 00ah,050h,00eh,005h,00eh,005h,00eh,005h,00eh,010h,00eh,040h,00fh,005h,001h,005h	; b027  .P.........@....
	defb 001h,020h,001h,010h,00fh,020h,00ah,020h,001h,005h,001h,015h,00eh,020h,00eh,010h	; b037  . ... . ..... ..
	defb 005h,010h,005h,010h,001h,010h,005h,010h,00fh,020h,001h,010h,00fh,010h,00ah,010h	; b047  ......... ......
	defb 005h,020h,005h,005h,005h,0ffh,001h,010h,001h,010h,001h,005h,001h,005h,00eh,010h	; b057  . ..............
	defb 00eh,010h,00eh,005h,00eh,035h,005h,010h,005h,020h,005h,010h,005h,005h,00ah,005h	; b067  .....5... ......
	defb 00ah,030h,00dh,010h,00dh,010h,001h,010h,00dh,010h,001h,020h,00eh,030h,00eh,010h	; b077  .0......... .0..
	defb 001h,010h,00ah,010h,00ah,010h,005h,010h,005h,010h,001h,010h,001h,005h,00eh,005h	; b087  ................
	defb 00eh,045h,00eh,005h,005h,020h,005h,010h,005h,020h,005h,030h,001h,010h,00ah,010h	; b097  .E... ... .0....
	defb 00ah,010h,00ah,010h,00dh,010h,00ah,020h,001h,005h,001h,005h,00dh,010h,00ah,020h	; b0a7  ....... .......
	defb 00dh,010h,00dh,010h,00ah,005h,00ah,025h,001h,010h,001h,010h,001h,020h,005h,010h	; b0b7  .......%..... ..
	defb 00eh,0ffh,007h,010h,007h,010h,007h,010h,007h,010h,00ah,010h,00fh,010h,00fh,010h	; b0c7  ................
	defb 00ah,010h,007h,010h,007h,010h,007h,010h,007h,010h,00ah,020h,00fh,020h,007h,010h	; b0d7  ........... . ..
	defb 00ah,010h,007h,010h,00ah,010h,00ah,005h,00ah,005h,007h,010h,00fh,090h,007h,010h	; b0e7  ................
	defb 007h,005h,00ah,005h,00ah,010h,00ah,020h,00fh,020h,00fh,020h,00ah,010h,00ah,005h	; b0f7  ....... . . ....
	defb 007h,045h,007h,020h,007h,010h,007h,005h,00fh,045h,00ah,010h,00ah,010h,00ah,005h	; b107  .E. .....E......
	defb 007h,010h,007h,035h,00fh,010h,00ah,010h,00ah,010h,00fh,080h,00ah,010h,00ah,005h	; b117  ...5............
	defb 00ah,005h,00fh,010h,007h,010h,007h,010h,007h,010h,00ah,015h,00ah,005h,00fh,010h	; b127  ................
	defb 007h,020h,007h,010h,00ah,005h,00ah,005h,00ah,060h,00ah,005h,007h,005h,00ah,005h	; b137  . .......`......
	defb 007h,005h,00fh,010h,007h,010h,007h,0ffh,006h,010h,006h,010h,006h,030h,006h,010h	; b147  .............0..
	defb 006h,010h,006h,060h,009h,010h,009h,010h,006h,010h,006h,050h,009h,010h,006h,010h	; b157  ...`.......P....
	defb 006h,020h,009h,030h,009h,010h,009h,010h,006h,010h,006h,010h,009h,020h,009h,020h	; b167  . .0......... .
	defb 006h,010h,006h,010h,006h,010h,009h,020h,009h,010h,006h,010h,006h,010h,009h,010h	; b177  ....... ........
	defb 009h,005h,006h,005h,006h,020h,009h,010h,006h,010h,006h,0ffh,00ah,010h,00ah,010h	; b187  ..... ..........
	defb 00ah,010h,001h,005h,001h,015h,00ah,010h,001h,010h,001h,010h,00ah,060h,000h,065h	; b197  .............`.e
	defb 001h,005h,001h,010h,001h,010h,00dh,010h,00dh,010h,001h,010h,00dh,020h,001h,070h	; b1a7  ............. .p
	defb 000h,060h,009h,010h,009h,005h,00ah,015h,00ah,010h,009h,010h,00ah,010h,00ah,010h	; b1b7  .`..............
	defb 009h,010h,009h,060h,000h,060h,00dh,010h,00dh,010h,001h,010h,001h,010h,001h,010h	; b1c7  ...`.`..........
	defb 001h,005h,001h,005h,00dh,010h,001h,020h,00ah,020h,00ah,020h,00dh,020h,001h,030h	; b1d7  ....... . . . .0
	defb 001h,010h,009h,030h,009h,020h,00ah,020h,00ah,020h,009h,020h,00dh,010h,009h,0ffh	; b1e7  ...0. . . . ....
	defb 00bh,010h,00ch,010h,00ch,010h,00bh,010h,00ch,010h,00ch,010h,00ch,090h,007h,010h	; b1f7  ................
	defb 007h,010h,00bh,010h,007h,010h,007h,010h,00bh,010h,00ch,010h,00ch,010h,00bh,005h	; b207  ................
	defb 00ch,005h,00bh,010h,00ch,080h,00ch,020h,00ch,005h,00ch,015h,00ch,005h,00ch,015h	; b217  ....... ........
	defb 007h,005h,007h,005h,007h,010h,00ch,010h,00ch,005h,00ch,005h,00ch,020h,00ah,010h	; b227  ............. ..
	defb 00ah,010h,00ah,010h,007h,010h,007h,010h,00ah,010h,00ah,010h,007h,010h,007h,020h	; b237  ...............
	defb 00ah,005h,00ch,005h,00ch,010h,006h,010h,006h,010h,00ch,020h,00ch,010h,006h,010h	; b247  ........... ....
	defb 006h,010h,006h,010h,00ch,010h,00ch,010h,00ch,010h,007h,010h,007h,010h,00ch,010h	; b257  ................
	defb 00ch,010h,00ah,010h,00ah,010h,00ah,010h,00ch,010h,00ch,085h,006h,015h,006h,010h	; b267  ................
	defb 00bh,005h,006h,005h,00bh,010h,006h,010h,00bh,010h,006h,010h,006h,010h,006h,010h	; b277  ................
	defb 00ch,010h,00ch,010h,007h,010h,007h,010h,00bh,010h,007h,010h,00ch,010h,00bh,005h	; b287  ................
	defb 00ch,005h,00bh,030h,00ch,010h,00ch,005h,00ch,0ffh,009h,010h,00fh,020h,00fh,010h	; b297  ...0......... ..
	defb 009h,020h,009h,010h,001h,010h,001h,010h,001h,010h,001h,010h,009h,010h,00fh,010h	; b2a7  . ..............
	defb 001h,010h,001h,010h,001h,010h,009h,010h,009h,010h,00fh,030h,00fh,010h,001h,005h	; b2b7  ...........0....
	defb 001h,015h,009h,010h,00fh,010h,00fh,080h,009h,030h,009h,010h,00fh,010h,001h,010h	; b2c7  .........0......
	defb 001h,060h,001h,010h,001h,010h,009h,010h,00fh,010h,009h,020h,009h,010h,009h,020h	; b2d7  .`......... ...
	defb 00fh,020h,009h,010h,001h,010h,001h,010h,001h,010h,001h,010h,00fh,010h,00fh,020h	; b2e7  . .............
	defb 001h,010h,009h,020h,009h,0ffh,00eh,010h,00eh,010h,00eh,040h,00eh,090h,00ah,010h	; b2f7  ... .......@....
	defb 00ah,010h,00ah,050h,001h,010h,001h,010h,001h,010h,001h,010h,005h,010h,005h,040h	; b307  ...P...........@
	defb 00ah,010h,00ah,010h,00ah,020h,005h,010h,005h,020h,005h,060h,001h,010h,001h,010h	; b317  ..... ... .`....
	defb 001h,010h,001h,010h,00ah,010h,00ah,010h,001h,010h,001h,010h,00eh,010h,00eh,040h	; b327  ...............@
	defb 00dh,010h,00dh,010h,00ah,010h,00ah,020h,001h,010h,001h,030h,00eh,010h,00eh,010h	; b337  ....... ...0....
	defb 00ah,010h,00eh,010h,00ah,010h,00ah,020h,00eh,030h,005h,020h,005h,010h,00dh,010h	; b347  ....... .0. ....
	defb 00dh,020h,005h,010h,005h,030h,00eh,010h,00dh,010h,00eh,020h,00ah,010h,00ah,010h	; b357  . ...0..... ....
	defb 00ah,010h,00dh,030h,001h,010h,001h,010h,00eh,010h,00eh,030h,001h,010h,001h,010h	; b367  ...0.......0....
	defb 001h,010h,00dh,020h,00ah,010h,00ah,010h,001h,010h,00ah,010h,001h,010h,00eh,010h	; b377  ... ............
	defb 00eh,020h,00eh,030h,00dh,010h,001h,010h,001h,010h,00eh,010h,00eh,010h,00dh,010h	; b387  . .0............
	defb 001h,010h,001h,020h,00eh,010h,00eh,0ffh,00fh,010h,00ah,010h,00ah,010h,00ah,010h	; b397  ... ............
	defb 00ah,020h,00fh,010h,00fh,010h,00ah,010h,00ah,010h,00fh,010h,00ah,010h,00fh,020h	; b3a7  . .............
	defb 00ah,010h,00ah,050h,00fh,010h,001h,010h,001h,010h,001h,010h,00fh,030h,001h,010h	; b3b7  ...P.........0..
	defb 001h,010h,00fh,010h,00ah,010h,00ah,010h,001h,010h,00fh,010h,001h,020h,00fh,010h	; b3c7  ............. ..
	defb 001h,010h,001h,060h,00ah,010h,009h,030h,009h,010h,00ah,010h,00fh,010h,00ah,010h	; b3d7  ...`...0........
	defb 00fh,010h,001h,010h,001h,010h,009h,010h,009h,010h,001h,010h,001h,050h,00ah,005h	; b3e7  .............P..
	defb 001h,015h,001h,010h,00ah,010h,00ah,020h,001h,020h,001h,020h,00ah,010h,00ah,010h	; b3f7  ....... . . ....
	defb 001h,010h,00fh,020h,00fh,010h,00ah,010h,009h,020h,00ah,010h,009h,010h,001h,010h	; b407  ... ..... ......
	defb 001h,020h,001h,010h,001h,010h,00ah,010h,001h,010h,00ah,010h,009h,010h,00ah,010h	; b417  . ..............
	defb 009h,080h,00fh,015h,00ah,005h,00fh,010h,00ah,010h,00ah,010h,009h,010h,00ah,020h	; b427  ...............
	defb 009h,010h,001h,010h,00ah,010h,00ah,010h,00ah,010h,009h,010h,001h,010h,001h,010h	; b437  ................
	defb 001h,0ffh,006h,010h,006h,010h,006h,020h,00ch,010h,00ch,010h,00ch,010h,006h,010h	; b447  ....... ........
	defb 006h,010h,00ch,040h,006h,010h,00ch,010h,00ch,010h,00ch,030h,00bh,030h,006h,010h	; b457  ...@.......0.0..
	defb 00bh,010h,006h,010h,006h,010h,006h,010h,00bh,010h,006h,020h,00bh,020h,00ah,020h	; b467  ........... . .
	defb 00ah,020h,00ah,015h,00bh,015h,00bh,020h,006h,010h,006h,010h,00ah,010h,00ah,010h	; b477  . ..... ........
	defb 00ch,010h,00ch,010h,007h,010h,007h,010h,007h,020h,00ah,010h,00ah,020h,007h,020h	; b487  ......... ... .
	defb 00ah,010h,00ah,010h,00ah,030h,00bh,010h,00bh,010h,00ch,010h,00ch,010h,00ch,010h	; b497  .....0..........
	defb 00ch,010h,00bh,050h,00bh,010h,00ch,010h,007h,010h,00ch,010h,00ch,010h,007h,010h	; b4a7  ...P............
	defb 00ah,010h,007h,010h,00ah,010h,007h,010h,007h,0ffh,001h,010h,001h,010h,001h,040h	; b4b7  ...............@
	defb 005h,010h,005h,020h,001h,020h,001h,010h,001h,005h,005h,025h,001h,010h,001h,020h	; b4c7  ... . .....%...
	defb 00eh,010h,00eh,010h,001h,010h,001h,010h,00eh,010h,001h,030h,001h,030h,001h,010h	; b4d7  ...........0.0..
	defb 001h,010h,00ah,010h,00ah,010h,001h,010h,001h,020h,00ah,020h,00ah,010h,00eh,020h	; b4e7  ......... . ...
	defb 00ah,010h,00eh,010h,00eh,020h,001h,020h,005h,010h,001h,010h,001h,010h,00dh,015h	; b4f7  ..... . ........
	defb 005h,015h,00dh,010h,005h,010h,001h,030h,00dh,010h,00dh,010h,00ah,010h,00ah,010h	; b507  .......0........
	defb 001h,010h,001h,010h,00ah,010h,001h,010h,001h,020h,00ah,010h,00ah,010h,00eh,020h	; b517  ......... .....
	defb 00eh,010h,00eh,010h,001h,010h,001h,020h,001h,010h,00dh,010h,00dh,020h,00dh,010h	; b527  ....... ..... ..
	defb 001h,020h,001h,010h,001h,020h,005h,010h,00ah,020h,00ah,010h,005h,010h,00ah,010h	; b537  . ... ... ......
	defb 00ah,010h,00ah,010h,001h,020h,001h,010h,001h,010h,001h,010h,00eh,010h,00eh,010h	; b547  ..... ..........
	defb 00eh,030h,00dh,010h,00dh,010h,001h,010h,001h,010h,00ah,010h,00ah,020h,001h,010h	; b557  .0........... ..
	defb 00ah,020h,00ah,010h,00dh,010h,001h,010h,001h,010h,001h,010h,00eh,010h,00ah,010h	; b567  . ..............
	defb 001h,010h,001h,010h,00dh,020h,00eh,010h,00eh,0ffh	; b577  ..... ....

; ======================================================================
; CODIGO 0xb581..0xb59c  (27 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; MONTAR LA CLASE 1. Copia los quince bytes de 0xB59C al hueco -de IX+4 en adelante- y, si el juego no va ya muy adelantado, le da un empujon hacia atras.
; ----------------------------------------------------------------------
monta_clase_1:
	push ix		;b581   ; DE apunta al hueco
	pop de			;b583
	ld a,004h		;b584   ; cuatro bytes mas alla: se salta el tipo y la posicion de pantalla
	add a,e			;b586
	ld e,a			;b587
	ld hl,0b59ch		;b588   ; la plantilla
	ld bc,0000fh		;b58b   ; quince bytes
	ldir		;b58e
	ld a,(0e205h)		;b590   ; por donde va la fase
	cp 070h		;b593   ; pasado 0x70 ya no se le empuja
	ret nc			;b595
	ld de,0ffc0h		;b596   ; y si no, un empujon de -0x40
	jp L_AA78		;b599

; ----------------------------------------------------------------------
; DATOS plantilla_de_la_clase_1: Los quince bytes que 0xB58E copia al hueco, y
;   que son la posicion y las velocidades con las que sale el objeto: X =
;   0x4000, Y = 0x7800, Z = 0, velocidad X = 0x00A0, velocidad Y = 0x0040,
;   velocidad Z = 0x00A0 y la marca de que se mueve solo. Los dos primeros
;   -0x98 y 0x01- caen en IX+4 e IX+5, que son los que usa la rutina de
;   atender como contador y como estado.
;   0xb59c..0xb5ab  (15 bytes)
DATA_plantilla_de_la_clase_1:
	defb 098h,001h	; b59c
	defw 04000h	; b59e
	defw 07800h	; b5a0
	defw 00000h	; b5a2
	defw 000a0h	; b5a4
	defw 00040h	; b5a6
	defw 000a0h	; b5a8
	defb 001h	; b5aa

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb5ab..0xb5ad  (2 bytes)
DATA_B5AB:
	defb 000h,000h	; b5ab

; ======================================================================
; CODIGO 0xb5ad..0xb6c4  (279 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LA CLASE 1. Un bicho en TRES tiempos, y los tres cambian su velocidad de PROFUNDIDAD: primero se acerca frenando -le va restando 14 a la velocidad Z-, pasado cierto punto cambia de tiempo, y en el tercero vuelve a acelerar sumando 2. Ademas suena uno de cada ocho cuadros mientras esta en pantalla.
; ----------------------------------------------------------------------
atiende_clase_1:
	ld c,030h		;b5ad   ; el dibujo base de esta clase
	call L_AA86		;b5af   ; ponerselo
	ld a,(0e003h)		;b5b2   ; el contador de cuadros
	and 007h		;b5b5   ; uno de cada ocho
	jr nz,atiende_clase_1_estado		;b5b7
	ld a,001h		;b5b9   ; el efecto 1
	call 0413ah		;b5bb   ; y a pedirlo al reproductor
atiende_clase_1_estado:
	ld a,(ix+001h)		;b5be   ; en que tiempo va
	dec a			;b5c1   ; el 1
	jr z,atiende_clase_1_frena		;b5c2
	dec a			;b5c4   ; el 2
	jr z,atiende_clase_1_acelera		;b5c5
	ld a,(ix+007h)		;b5c7   ; y en el 0, se mira la distancia
	cp 074h		;b5ca   ; hasta 0x74 no pasa nada
	ret c			;b5cc
	inc (ix+001h)		;b5cd   ; y ahi cambia de tiempo
	ret			;b5d0
atiende_clase_1_frena:
	ld l,(ix+010h)		;b5d1   ; la velocidad de profundidad
	ld h,(ix+011h)		;b5d4
	ld de,0fff2h		;b5d7   ; menos catorce: viene frenando
	add hl,de			;b5da
	ld (ix+010h),l		;b5db
	ld (ix+011h),h		;b5de
	ld a,(ix+007h)		;b5e1   ; la distancia
	cp 084h		;b5e4   ; pasado 0x84...
	jr c,atiende_clase_1_una_sola_vez		;b5e6
	inc (ix+001h)		;b5e8   ; ...al tiempo siguiente
	ret			;b5eb
atiende_clase_1_una_sola_vez:
	bit 0,(ix+014h)		;b5ec   ; una bandera para que esto pase una vez y no en cada cuadro
	ret nz			;b5f0
	call L_AB1E		;b5f1   ; lo que sea que hace al llegar
	ld (ix+014h),001h		;b5f4   ; y queda marcado
	ret			;b5f8
atiende_clase_1_acelera:
	ld l,(ix+010h)		;b5f9   ; la velocidad de profundidad
	ld h,(ix+011h)		;b5fc
	ld de,00002h		;b5ff   ; y ahora suma de dos en dos: se va alejando
	add hl,de			;b602
	ld (ix+010h),l		;b603
	ld (ix+011h),h		;b606
	ret			;b609
monta_clase_2:		; Un `ret`: esta clase no monta nada.
	ret			;b60a
atiende_clase_2:		; Y tampoco hace nada en cada cuadro.
	ret			;b60b
monta_clase_3:
	ret			;b60c
atiende_clase_3:
	ret			;b60d
monta_clase_4:
	ret			;b60e
atiende_clase_4:
	ret			;b60f
monta_clase_5:
	ld a,001h		;b610   ; la bandera de que hay uno pedido
	ld (0e282h),a		;b612
	ret			;b615

; ----------------------------------------------------------------------
; LO QUE SE DISPARA. Recorre las CINCO ranuras de lo que se lleva (0xE440) buscando una que tenga un 0x0C o un 0x0D, y si la encuentra saca un objeto de la clase 5. Las ranuras NO son todas del mismo tamano: el paso de una a la siguiente es 0x10, 0x0E o 0x0F segun lo que haya dentro, y esos tres saltos estan escritos en las tres ramas de 0xB622, 0xB62B y 0xB639.
; ----------------------------------------------------------------------
dispara_lo_que_se_lleva:
	ld a,(0e282h)		;b616   ; ¿hay disparo pedido?
	and a			;b619
	ret z			;b61a   ; si no, nada
	ld hl,0e440h		;b61b   ; las cinco ranuras
	ld b,005h		;b61e   ; cinco
dispara_recorre_las_ranuras:
	ld a,(hl)			;b620   ; lo que hay en la ranura
	and a			;b621   ; vacia: el salto es de 0x10
	ld c,010h		;b622
	jr z,dispara_a_la_ranura_siguiente		;b624
	inc l			;b626   ; dos bytes mas alla
	inc l			;b627
	ld a,(hl)			;b628
	cp 008h		;b629   ; con un 8 ahi, el salto es de 0x0E
	ld c,00eh		;b62b
	jr nz,dispara_a_la_ranura_siguiente		;b62d
	dec l			;b62f   ; y si no, se mira el primer byte
	ld a,(hl)			;b630
	cp 00ch		;b631   ; el 0x0C...
	jr z,dispara_busca_hueco		;b633
	cp 00dh		;b635   ; ...o el 0x0D son los que se disparan
	jr z,dispara_busca_hueco		;b637
	ld c,00fh		;b639   ; y para todo lo demas, 0x0F
dispara_a_la_ranura_siguiente:
	ld a,c			;b63b   ; el salto que toque
	add a,l			;b63c
	ld l,a			;b63d
	jr nc,dispara_siguiente		;b63e
	inc h			;b640
dispara_siguiente:
	djnz dispara_recorre_las_ranuras		;b641   ; una ranura menos
	ret			;b643
dispara_busca_hueco:
	ld c,a			;b644   ; C se queda con lo que se dispara
	ld hl,0e310h		;b645   ; los tres huecos de objeto
	ld b,003h		;b648   ; tres
dispara_mira_el_hueco:
	ld a,(hl)			;b64a   ; ¿esta libre?
	and a			;b64b
	jr z,dispara_monta_el_objeto		;b64c
	ld a,020h		;b64e   ; 0x20 bytes al hueco siguiente
	add a,l			;b650
	ld l,a			;b651
	djnz dispara_mira_el_hueco		;b652
	ret			;b654   ; si los tres estan ocupados, no se dispara
dispara_monta_el_objeto:
	push hl			;b655
	ld b,020h		;b656   ; los 32 bytes del hueco
dispara_borra_el_hueco:
	ld (hl),000h		;b658
	inc l			;b65a
	djnz dispara_borra_el_hueco		;b65b
	pop ix		;b65d
	ld (ix+000h),005h		;b65f   ; la clase 5
	ld (ix+012h),001h		;b663   ; y se mueve solo
	xor a			;b667
	ld (0e282h),a		;b668   ; la peticion, atendida
	ld (ix+007h),070h		;b66b   ; sale de la columna 0x70
	ld (ix+00dh),002h		;b66f   ; con velocidad
	ld (ix+00bh),000h		;b673   ; y la profundidad a cero
	ld de,00500h		;b677
	call L_AA7F		;b67a
	ld (ix+013h),000h		;b67d
	ld (ix+004h),0b0h		;b681
	ld (ix+005h),00ah		;b685
	ld a,014h		;b689   ; el efecto 0x14
	call 0413ah		;b68b   ; banco 0: pide_sonido_si_esta_activo
	ld hl,0e281h		;b68e   ; un contador que va girando
	ld a,(hl)			;b691
	inc (hl)			;b692   ; uno mas
	and 003h		;b693   ; de cuatro en cuatro
	ld de,0b6c4h		;b695   ; la tabla de cuatro alturas
	add a,e			;b698
	ld e,a			;b699
	jr nc,L_B69D		;b69a
	inc d			;b69c
L_B69D:
	ld a,(de)			;b69d   ; la altura que toca
	ld b,a			;b69e
	ld a,c			;b69f
	sub 00ch		;b6a0   ; y segun sea 0x0C o 0x0D...
	ld a,058h		;b6a2   ; ...sale de una fila...
	jr z,L_B6A8		;b6a4
	ld a,078h		;b6a6   ; ...o de la otra
L_B6A8:
	add a,b			;b6a8
	ld (ix+009h),a		;b6a9   ; esa es su Y
	ld hl,0e205h		;b6ac   ; la Y de lo que se maneja
	sub (hl)			;b6af   ; la diferencia
	jr c,L_B6BB		;b6b0
	cp 030h		;b6b2   ; si esta cerca, no se corrige
	ret c			;b6b4
	ld de,0ff00h		;b6b5
	jp L_AA78		;b6b8
L_B6BB:
	add a,020h		;b6bb
	ret c			;b6bd
	ld de,00100h		;b6be
	jp L_AA78		;b6c1

; ----------------------------------------------------------------------
; DATOS alturas_del_disparo: Las cuatro alturas por las que puede salir lo que
;   se dispara: 0x00, 0x18, 0x08 y 0x10. 0xB68E las va dando en circulo, asi
;   que dos disparos seguidos no salen a la misma altura.
;   0xb6c4..0xb6c8  (4 bytes)
DATA_alturas_del_disparo:
	defb 000h,018h,008h,010h	; b6c4

; ======================================================================
; CODIGO 0xb6c8..0xb704  (60 bytes)
; ======================================================================


atiende_clase_5:
	call dibujo_del_disparo		;b6c8   ; el dibujo, segun lo cerca que este
	ld de,0ffc0h		;b6cb   ; y la profundidad va bajando de 0x40 en 0x40
	ld l,(ix+010h)		;b6ce
	ld h,(ix+011h)		;b6d1
	add hl,de			;b6d4
	ld (ix+010h),l		;b6d5
	ld (ix+011h),h		;b6d8
	ret			;b6db
dibujo_del_disparo:
	ld a,(ix+007h)		;b6dc   ; la distancia
	cp 080h		;b6df   ; por debajo de 0x80 no se cambia
	ret c			;b6e1
	ld c,0b4h		;b6e2   ; primer dibujo
	cp 090h		;b6e4
	jr c,guarda_el_dibujo_del_disparo		;b6e6
	ld c,0b8h		;b6e8   ; segundo
	cp 0a0h		;b6ea
	jr c,guarda_el_dibujo_del_disparo		;b6ec
	ld c,0bch		;b6ee   ; y tercero
guarda_el_dibujo_del_disparo:
	ld (ix+004h),c		;b6f0
	ret			;b6f3
monta_clase_6:
	push ix		;b6f4   ; DE apunta al hueco
	pop de			;b6f6
	ld a,004h		;b6f7   ; cuatro bytes mas alla
	add a,e			;b6f9
	ld e,a			;b6fa
	ld hl,0b704h		;b6fb   ; la plantilla
	ld bc,00017h		;b6fe   ; veintitres bytes, mas que las otras: esta clase gasta hasta el 0x1A
	ldir		;b701
	ret			;b703

; ----------------------------------------------------------------------
; DATOS plantilla_de_la_clase_6: Los veintitres bytes de salida: X = 0x4E00, Y
;   = 0x7800, Z = 0x0418, velocidades 0xFF00, 0x0020 y 0x0001, y detras los
;   contadores de los dos vaivenes puestos a cero y a uno.
;   0xb704..0xb71b  (23 bytes)
DATA_plantilla_de_la_clase_6:
	defb 098h,008h	; b704
	defw 04e00h	; b706
	defw 07800h	; b708
	defw 01800h	; b70a
	defw 00004h	; b70c
	defw 0ff00h	; b70e
	defw 00020h	; b710
	defb 001h,000h,000h,000h,001h,000h,000h,000h,001h	; b712  .........

; ======================================================================
; CODIGO 0xb71b..0xb7cd  (178 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LA CLASE 6: DOS VAIVENES A LA VEZ. Lo que hace a este bicho distinto es que no se mueve en linea recta ni con un solo vaiven: lleva DOS osciladores independientes, uno para la Y (contadores en +0x13, +0x15 y +0x16) y otro para la Z (+0x17, +0x19 y +0x1A). Cada uno saca su paso de una tabla de rampas, le da la vuelta al signo cada media vuelta -los `cpl` de 0xB750 y 0xB79F- y multiplica el resultado por un contador que sube: eso es lo que hace que el recorrido se vaya abriendo.
; ----------------------------------------------------------------------
atiende_clase_6:
	ld c,030h		;b71b   ; el dibujo base
	call L_AA86		;b71d
	ld l,(ix+00ch)		;b720   ; la velocidad X
	ld h,(ix+00dh)		;b723
	ld de,00002h		;b726   ; mas dos
	add hl,de			;b729
	ex de,hl			;b72a
	call L_AA71		;b72b   ; y a la X
	inc (ix+013h)		;b72e   ; el contador fino del primer vaiven
	ld a,(ix+013h)		;b731
	cp 080h		;b734   ; a las 128 vueltas...
	jr nz,clase_6_primer_vaiven		;b736
	ld (ix+013h),000h		;b738   ; ...se reinicia...
	inc (ix+016h)		;b73c   ; ...y el multiplicador sube uno
clase_6_primer_vaiven:
	inc (ix+015h)		;b73f   ; el contador del paso
	ld a,(ix+015h)		;b742
	cp 040h		;b745   ; sesenta y cuatro pasos
	jr nz,clase_6_paso_del_primer_vaiven		;b747
	ld (ix+015h),000h		;b749   ; y vuelta a empezar
	ld a,(ix+014h)		;b74d
	cpl			;b750   ; dandole la vuelta al signo
	ld (ix+014h),a		;b751
clase_6_paso_del_primer_vaiven:
	ld a,(ix+015h)		;b754
	add a,a			;b757   ; dos bytes por entrada
	ld hl,0b7cdh		;b758   ; la tabla de rampas
	add a,l			;b75b
	ld l,a			;b75c
	jr nc,L_B760		;b75d
	inc h			;b75f
L_B760:
	ld e,(hl)			;b760   ; el paso, de 16 bits
	inc hl			;b761
	ld d,(hl)			;b762
	ld a,(ix+014h)		;b763   ; la bandera de signo
	and a			;b766
	jr z,clase_6_multiplica_el_primer_vaiven		;b767
	xor a			;b769   ; y si esta puesta, se niega el par entero
	sub e			;b76a
	ld e,a			;b76b
	ld a,000h		;b76c
	sbc a,d			;b76e
	ld d,a			;b76f
clase_6_multiplica_el_primer_vaiven:
	ld b,(ix+016h)		;b770   ; el multiplicador
	ld hl,00000h		;b773   ; sumando tantas veces como diga: eso es multiplicar
clase_6_multiplica_bucle:
	add hl,de			;b776
	djnz clase_6_multiplica_bucle		;b777
	ex de,hl			;b779
	call L_AA78		;b77a   ; y a la Y
	inc (ix+017h)		;b77d   ; el contador fino del segundo vaiven
	ld a,(ix+017h)		;b780
	cp 022h		;b783   ; treinta y cuatro vueltas
	jr nz,clase_6_segundo_vaiven		;b785
	ld (ix+017h),000h		;b787
clase_6_segundo_vaiven:
	inc (ix+019h)		;b78b   ; su contador de paso
	ld a,(ix+019h)		;b78e
	cp 011h		;b791   ; diecisiete pasos
	jr nz,clase_6_paso_del_segundo_vaiven		;b793
	inc (ix+01ah)		;b795   ; el multiplicador sube
	ld (ix+019h),000h		;b798
	ld a,(ix+018h)		;b79c
	cpl			;b79f   ; y el signo se da la vuelta
	ld (ix+018h),a		;b7a0
clase_6_paso_del_segundo_vaiven:
	ld a,(ix+019h)		;b7a3
	add a,a			;b7a6
	ld hl,0b851h		;b7a7   ; la segunda tabla de rampas
	add a,l			;b7aa
	ld l,a			;b7ab
	jr nc,L_B7AF		;b7ac
	inc h			;b7ae
L_B7AF:
	ld e,(hl)			;b7af
	inc hl			;b7b0
	ld d,(hl)			;b7b1
	ld a,(ix+018h)		;b7b2
	and a			;b7b5
	jr z,clase_6_multiplica_el_segundo		;b7b6
	xor a			;b7b8
	sub e			;b7b9
	ld e,a			;b7ba
	ld a,000h		;b7bb
	sbc a,d			;b7bd
	ld d,a			;b7be
clase_6_multiplica_el_segundo:
	ld b,(ix+01ah)		;b7bf
	ld hl,00000h		;b7c2
clase_6_multiplica_bucle_2:
	add hl,de			;b7c5
	djnz clase_6_multiplica_bucle_2		;b7c6
	ex de,hl			;b7c8
	call L_AA7F		;b7c9   ; y a la profundidad
	ret			;b7cc

; ----------------------------------------------------------------------
; DATOS rampa_del_primer_vaiven: Sesenta y cuatro pasos de 16 bits, y son una
;   rampa limpia: de 0xFF00 a 0xFFF8 de ocho en ocho y luego de 0x0000 a
;   0x0100. O sea que el paso crece de forma continua, y lo que hace la curva
;   es el cambio de signo de 0xB750 y la multiplicacion de 0xB776.
;   0xb7cd..0xb851  (132 bytes)
DATA_rampa_del_primer_vaiven:
	defw 0ff00h	; b7cd
	defw 0ff08h	; b7cf
	defw 0ff10h	; b7d1
	defw 0ff18h	; b7d3
	defw 0ff20h	; b7d5
	defw 0ff28h	; b7d7
	defw 0ff30h	; b7d9
	defw 0ff38h	; b7db
	defw 0ff40h	; b7dd
	defw 0ff48h	; b7df
	defw 0ff50h	; b7e1
	defw 0ff58h	; b7e3
	defw 0ff60h	; b7e5
	defw 0ff68h	; b7e7
	defw 0ff70h	; b7e9
	defw 0ff78h	; b7eb
	defw 0ff80h	; b7ed
	defw 0ff88h	; b7ef
	defw 0ff90h	; b7f1
	defw 0ff9ah	; b7f3
	defw 0ffa0h	; b7f5
	defw 0ffa8h	; b7f7
	defw 0ffb0h	; b7f9
	defw 0ffb8h	; b7fb
	defw 0ffc0h	; b7fd
	defw 0ffc8h	; b7ff
	defw 0ffd0h	; b801
	defw 0ffd8h	; b803
	defw 0ffe0h	; b805
	defw 0ffe8h	; b807
	defw 0fff0h	; b809
	defw 0fff8h	; b80b
	defw 00000h	; b80d
	defw 00000h	; b80f
	defw 00008h	; b811
	defw 00010h	; b813
	defw 00018h	; b815
	defw 00020h	; b817
	defw 00028h	; b819
	defw 00030h	; b81b
	defw 00038h	; b81d
	defw 00040h	; b81f
	defw 00048h	; b821
	defw 00050h	; b823
	defw 00058h	; b825
	defw 00060h	; b827
	defw 00068h	; b829
	defw 00070h	; b82b
	defw 00078h	; b82d
	defw 00080h	; b82f
	defw 00088h	; b831
	defw 00090h	; b833
	defw 0009ah	; b835
	defw 000a0h	; b837
	defw 000a8h	; b839
	defw 000b0h	; b83b
	defw 000b8h	; b83d
	defw 000c0h	; b83f
	defw 000c8h	; b841
	defw 000d0h	; b843
	defw 000d8h	; b845
	defw 000e0h	; b847
	defw 000e8h	; b849
	defw 000f0h	; b84b
	defw 000f8h	; b84d
	defw 00100h	; b84f

; ----------------------------------------------------------------------
; DATOS rampa_del_segundo_vaiven: Diecisiete pasos, la misma idea pero de 0x10
;   en 0x10: de 0xFF80 a 0x0080.
;   0xb851..0xb873  (34 bytes)
DATA_rampa_del_segundo_vaiven:
	defw 0ff80h	; b851
	defw 0ff90h	; b853
	defw 0ffa0h	; b855
	defw 0ffb0h	; b857
	defw 0ffc0h	; b859
	defw 0ffd0h	; b85b
	defw 0ffe0h	; b85d
	defw 0fff0h	; b85f
	defw 00000h	; b861
	defw 00010h	; b863
	defw 00020h	; b865
	defw 00030h	; b867
	defw 00040h	; b869
	defw 00050h	; b86b
	defw 00060h	; b86d
	defw 00070h	; b86f
	defw 00080h	; b871

; ======================================================================
; CODIGO 0xb873..0xb89f  (44 bytes)
; ======================================================================


monta_clase_7:
	push ix		;b873
	pop de			;b875
	ld a,004h		;b876   ; cuatro bytes mas alla del hueco
	add a,e			;b878
	ld e,a			;b879
	ld hl,0b89fh		;b87a   ; su plantilla
	ld bc,0000fh		;b87d   ; quince bytes
	ldir		;b880
	ld a,(0e205h)		;b882   ; la Y en la pantalla de lo que se maneja
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
	call 0413ah		;b89b   ; banco 0: pide_sonido_si_esta_activo
	ret			;b89e

; ----------------------------------------------------------------------
; DATOS plantilla_de_la_clase_7: Los quince bytes de salida: X = 0x4E00, Y =
;   0x7800, Z = 0x0030, las tres velocidades a cero y la marca de que se
;   mueve. Sale quieto: lo que lo pone en marcha es la rutina de atender.
;   0xb89f..0xb8ae  (15 bytes)
DATA_plantilla_de_la_clase_7:
	defb 098h,00eh	; b89f
	defw 04e00h	; b8a1
	defw 07800h	; b8a3
	defw 03000h	; b8a5
	defw 00000h	; b8a7
	defw 00000h	; b8a9
	defw 0fe00h	; b8ab
	defb 001h	; b8ad

; ======================================================================
; CODIGO 0xb8ae..0xb9a7  (249 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LA CLASE 7. Sale quieto y en el primer cuadro se decide hacia donde va: 0xB8CF mira (ix+0x13) y de ahi salen tres velocidades distintas -recto, a un lado o al otro-. Ademas cambia de instrumento segun 0xE16A, que es una de las cosas que se llevan de una fase a otra.
; ----------------------------------------------------------------------
atiende_clase_7:
	ld c,02ch		;b8ae   ; su dibujo
	call L_AAAD		;b8b0
	ld a,(0e16ah)		;b8b3   ; lo que se lleva
	and a			;b8b6
	ld a,005h		;b8b7   ; con ello, un dibujo...
	jr nz,clase_7_guarda_el_dibujo		;b8b9
	xor a			;b8bb   ; ...y sin ello, otro
clase_7_guarda_el_dibujo:
	ld (ix+005h),a		;b8bc
	ld a,(ix+001h)		;b8bf   ; en que tiempo va
	dec a			;b8c2   ; el 1 solo acelera
	jr z,clase_7_acelera		;b8c3
	ld a,(ix+00bh)		;b8c5   ; la profundidad
	cp 00bh		;b8c8   ; hasta 0x0B no arranca
	ret nc			;b8ca
	ld (ix+00bh),00bh		;b8cb   ; y ahi se le clava
	ld a,(ix+013h)		;b8cf   ; hacia donde va
	ld hl,00000h		;b8d2   ; recto...
	ld de,00000h		;b8d5
	and a			;b8d8
	jr z,clase_7_arranca		;b8d9
	ld hl,00000h		;b8db   ; ...a un lado...
	ld de,0ff80h		;b8de
	dec a			;b8e1
	jr z,clase_7_arranca		;b8e2
	ld hl,00000h		;b8e4   ; ...o al otro
	ld de,00080h		;b8e7
clase_7_arranca:
	call L_AA78		;b8ea   ; la velocidad de la Y
	ex de,hl			;b8ed
	call L_AA7F		;b8ee   ; y la de la profundidad
	ld de,000a0h		;b8f1   ; y un empujon en X
	call L_AA71		;b8f4
	inc (ix+001h)		;b8f7   ; al tiempo siguiente
	ret			;b8fa
clase_7_acelera:
	ld l,(ix+00ch)		;b8fb   ; la velocidad X
	ld h,(ix+00dh)		;b8fe
	inc hl			;b901   ; uno mas en cada cuadro
	ld (ix+00ch),l		;b902
	ld (ix+00dh),h		;b905
	ret			;b908
monta_clase_8:		; Un `ret`: esta clase no monta nada.
	ret			;b909
atiende_clase_8:
	ret			;b90a

; ----------------------------------------------------------------------
; MONTAR LA CLASE 9: SALEN DE DOS EN DOS. Esta es la unica que necesita OTRO hueco ademas del suyo: busca uno libre entre los tres, y si no lo hay se borra a si misma. Con los dos en la mano copia la misma plantilla de veinticinco bytes en los dos y les da direcciones distintas, sacadas de un contador que va girando en 0xE280.
; ----------------------------------------------------------------------
monta_clase_9:
	ld hl,0e310h		;b90b   ; los tres huecos
	ld b,003h		;b90e   ; tres
	xor a			;b910
	ld de,00020h		;b911   ; 0x20 de uno al siguiente
clase_9_busca_el_segundo_hueco:
	cp (hl)			;b914   ; ¿esta libre?
	jr z,clase_9_monta_los_dos		;b915
	add hl,de			;b917
	djnz clase_9_busca_el_segundo_hueco		;b918
	ld (ix+000h),000h		;b91a   ; y si no hay ninguno, esta se borra
	ret			;b91e
clase_9_monta_los_dos:
	push hl			;b91f   ; IY apunta al segundo
	pop iy		;b920
	ld (hl),009h		;b922   ; que pasa a ser de la clase 9
	inc l			;b924
	ld b,01fh		;b925   ; y se le borran los otros 31 bytes
	xor a			;b927
clase_9_borra_el_segundo:
	ld (hl),a			;b928
	inc l			;b929
	djnz clase_9_borra_el_segundo		;b92a
	push ix		;b92c   ; el primero
	pop de			;b92e
	ld a,004h		;b92f   ; cuatro bytes mas alla
	add a,e			;b931
	ld e,a			;b932
	ld hl,0b9a7h		;b933   ; la plantilla
	ld bc,00019h		;b936   ; veinticinco bytes
	ldir		;b939
	dec e			;b93b   ; cuatro atras
	dec e			;b93c
	dec e			;b93d
	dec e			;b93e
	xor a			;b93f
	ld (de),a			;b940
	ld hl,0e280h		;b941   ; el contador que gira
	inc (hl)			;b944   ; uno mas
	ld a,(hl)			;b945
	rra			;b946   ; y de ahi salen tres direcciones
	ld c,000h		;b947
	jr nc,clase_9_direccion_del_primero		;b949
	inc c			;b94b
	rra			;b94c
	jr c,clase_9_direccion_del_primero		;b94d
	inc c			;b94f
clase_9_direccion_del_primero:
	ld (ix+01ah),c		;b950   ; apuntada
	ld a,c			;b953
	ld de,00000h		;b954   ; recto...
	and a			;b957
	jr z,clase_9_velocidad_del_primero		;b958
	ld de,0fff0h		;b95a   ; ...a un lado...
	dec a			;b95d
	jr z,clase_9_velocidad_del_primero		;b95e
	ld de,00010h		;b960   ; ...o al otro
clase_9_velocidad_del_primero:
	ld (ix+017h),e		;b963
	ld (ix+018h),d		;b966
	push iy		;b969   ; y ahora el segundo
	pop de			;b96b
	ld a,004h		;b96c
	add a,e			;b96e
	ld e,a			;b96f
	ld hl,0b9a7h		;b970   ; la misma plantilla
	ld bc,00019h		;b973   ; veinticinco bytes
	ldir		;b976
	dec e			;b978
	dec e			;b979
	dec e			;b97a
	dec e			;b97b
	ld a,00ch		;b97c   ; con otro dibujo
	ld (de),a			;b97e
	ld hl,0e280h		;b97f   ; y el mismo contador
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
; DATOS sin identificar  0xb9a7..0xb9c0  (25 bytes)
DATA_B9A7:
	defb 098h,00ah,000h,04eh,000h,078h,000h,010h,010h,000h,000h,000h,000h,000h,001h,000h	; b9a7  ...N.x..........
	defb 078h,000h,010h,000h,000h,000h,000h,000h,001h	; b9b7  x........

; ======================================================================
; CODIGO 0xb9c0..0xba80  (192 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LA CLASE 9: DAN VUELTAS. La tabla de 0xBA80 son VEINTICUATRO entradas de cuatro bytes -dos desplazamientos de 16 bits cada una- y recorrerlas en orden es dar una vuelta entera: los valores empiezan en (0xFE00, 0x0000) y van girando. El radio no es fijo: cada veinticuatro pasos sube (ix+0x1C), y el desplazamiento se multiplica por el, asi que la vuelta se va abriendo como una espiral. A las ocho vueltas se llama a 0xAB1E.
; ----------------------------------------------------------------------
atiende_clase_9:
	ld c,02ch		;b9c0   ; su dibujo
	call L_AAAD		;b9c2
	ld l,(ix+00ch)		;b9c5   ; la velocidad X
	ld h,(ix+00dh)		;b9c8
	ld de,00001h		;b9cb
	add hl,de			;b9ce   ; uno mas: va acelerando
	ld (ix+00ch),l		;b9cf
	ld (ix+00dh),h		;b9d2
	ld a,(ix+01ah)		;b9d5   ; hacia donde gira
	ld de,00000h		;b9d8   ; recto...
	and a			;b9db
	jr z,clase_9_gira		;b9dc
	ld de,0ffffh		;b9de   ; ...a un lado...
	dec a			;b9e1
	jr z,clase_9_gira		;b9e2
	ld de,00001h		;b9e4   ; ...o al otro
clase_9_gira:
	ld l,(ix+017h)		;b9e7   ; el angulo
	ld h,(ix+018h)		;b9ea
	add hl,de			;b9ed   ; mas el paso
	ld (ix+017h),l		;b9ee
	ld (ix+018h),h		;b9f1
	ld e,(ix+013h)		;b9f4   ; el centro de la vuelta
	ld d,(ix+014h)		;b9f7
	add hl,de			;b9fa   ; que tambien se mueve
	ld (ix+013h),l		;b9fb
	ld (ix+014h),h		;b9fe
	ld l,(ix+015h)		;ba01   ; y la profundidad del centro
	ld h,(ix+016h)		;ba04
	ld de,00040h		;ba07   ; que baja de 0x40 en 0x40
	add hl,de			;ba0a
	ld (ix+015h),l		;ba0b
	ld (ix+016h),h		;ba0e
	inc (ix+01bh)		;ba11   ; el contador fino
	ld a,(ix+01bh)		;ba14
	cp 018h		;ba17   ; veinticuatro pasos: una vuelta entera
	jr nz,clase_9_paso_de_la_vuelta		;ba19
	inc (ix+01ch)		;ba1b   ; una vuelta mas
	ld (ix+01bh),000h		;ba1e
	ld a,(ix+01ch)		;ba22   ; y a las ocho vueltas...
	cp 008h		;ba25
	jr nz,clase_9_paso_de_la_vuelta		;ba27
	call L_AB1E		;ba29   ; ...pasa algo
clase_9_paso_de_la_vuelta:
	inc (ix+019h)		;ba2c   ; el paso
	ld a,(ix+019h)		;ba2f
	cp 018h		;ba32   ; veinticuatro y vuelta a empezar
	jr nz,clase_9_saca_el_desplazamiento		;ba34
	ld (ix+019h),000h		;ba36
clase_9_saca_el_desplazamiento:
	ld a,(ix+019h)		;ba3a
	add a,a			;ba3d   ; cuatro bytes por entrada
	add a,a			;ba3e
	ld hl,0ba80h		;ba3f   ; la tabla de la vuelta
	add a,l			;ba42
	ld l,a			;ba43
	jr nc,L_BA47		;ba44
	inc h			;ba46
L_BA47:
	ld e,(hl)			;ba47   ; el desplazamiento de la Y...
	inc hl			;ba48
	ld d,(hl)			;ba49
	inc hl			;ba4a
	ld c,(hl)			;ba4b   ; ...y el de la profundidad
	inc hl			;ba4c
	ld b,(hl)			;ba4d
	ld a,(ix+01ch)		;ba4e   ; el radio, que sube cada vuelta
	ld hl,00000h		;ba51
clase_9_multiplica_uno:
	add hl,bc			;ba54   ; sumando tantas veces como diga el radio
	dec a			;ba55
	jr nz,clase_9_multiplica_uno		;ba56
	ld c,l			;ba58
	ld b,h			;ba59
	ld a,(ix+01ch)		;ba5a
	ld hl,00000h		;ba5d
clase_9_multiplica_el_otro:
	add hl,de			;ba60
	dec a			;ba61
	jr nz,clase_9_multiplica_el_otro		;ba62
	ex de,hl			;ba64
	ld l,(ix+013h)		;ba65   ; el centro
	ld h,(ix+014h)		;ba68
	add hl,bc			;ba6b   ; mas el desplazamiento
	ld (ix+008h),l		;ba6c   ; y esa es la Y
	ld (ix+009h),h		;ba6f
	ld l,(ix+015h)		;ba72   ; lo mismo con la profundidad
	ld h,(ix+016h)		;ba75
	add hl,de			;ba78
	ld (ix+00ah),l		;ba79
	ld (ix+00bh),h		;ba7c
	ret			;ba7f

; ----------------------------------------------------------------------
; DATOS la_vuelta_de_la_clase_9: Veinticuatro entradas de cuatro bytes, dos
;   desplazamientos de 16 bits cada una, y recorrerlas en orden es UNA VUELTA.
;   Es la forma de dar vueltas sin senos ni cosenos: la vuelta esta dibujada
;   de antemano y lo unico que se calcula en marcha es el radio, multiplicando
;   cada desplazamiento por un contador que sube (0xBA54 y 0xBA60).
;   0xba80..0xbae0  (96 bytes)
DATA_la_vuelta_de_la_clase_9:
	defw 0fe00h	; ba80
	defw 00000h	; ba82
	defw 0fe00h	; ba84
	defw 0ff80h	; ba86
	defw 0fe40h	; ba88
	defw 0ff00h	; ba8a
	defw 0fe80h	; ba8c
	defw 0fe80h	; ba8e
	defw 0ff00h	; ba90
	defw 0fe40h	; ba92
	defw 0ff80h	; ba94
	defw 0fe00h	; ba96
	defw 00000h	; ba98
	defw 0fe00h	; ba9a
	defw 00080h	; ba9c
	defw 0fe00h	; ba9e
	defw 00100h	; baa0
	defw 0fe40h	; baa2
	defw 00180h	; baa4
	defw 0fe80h	; baa6
	defw 001c0h	; baa8
	defw 0ff00h	; baaa
	defw 00200h	; baac
	defw 0ff80h	; baae
	defw 00200h	; bab0
	defw 00000h	; bab2
	defw 00200h	; bab4
	defw 00080h	; bab6
	defw 001c0h	; bab8
	defw 00100h	; baba
	defw 00180h	; babc
	defw 00180h	; babe
	defw 00100h	; bac0
	defw 001c0h	; bac2
	defw 00080h	; bac4
	defw 00200h	; bac6
	defw 00000h	; bac8
	defw 00200h	; baca
	defw 0ff80h	; bacc
	defw 00200h	; bace
	defw 0ff00h	; bad0
	defw 001c0h	; bad2
	defw 0fe80h	; bad4
	defw 00180h	; bad6
	defw 0fe40h	; bad8
	defw 00100h	; bada
	defw 0fe00h	; badc
	defw 00080h	; bade

; ======================================================================
; CODIGO 0xbae0..0xbb05  (37 bytes)
; ======================================================================


monta_clase_10:
	push ix		;bae0
	pop de			;bae2
	ld a,004h		;bae3   ; cuatro bytes mas alla del hueco
	add a,e			;bae5
	ld e,a			;bae6
	ld hl,0bb05h		;bae7   ; su plantilla
	ld bc,00011h		;baea   ; diecisiete bytes
	ldir		;baed
	ld hl,0e286h		;baef   ; un contador que gira
	ld a,(hl)			;baf2
	inc (hl)			;baf3   ; uno mas
	and 003h		;baf4   ; de cuatro en cuatro
	ld hl,0bb16h		;baf6   ; la tabla de cuatro empujones
	add a,a			;baf9   ; dos bytes por entrada
	add a,l			;bafa
	ld l,a			;bafb
	jr nc,L_BAFF		;bafc
	inc h			;bafe
L_BAFF:
	ld e,(hl)			;baff   ; el que toca
	inc hl			;bb00
	ld d,(hl)			;bb01
	jp L_AA78		;bb02   ; y se le da

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbb05..0xbb1e  (25 bytes)
DATA_BB05:
	defb 098h,001h,000h,04eh,000h,078h,000h,00bh,010h,000h,000h,000h,000h,000h,001h,000h	; bb05  ...N.x..........
	defb 001h,0b0h,0ffh,020h,000h,0e0h,0ffh,050h,000h	; bb15  ... ...P.

; ======================================================================
; CODIGO 0xbb1e..0xbb5b  (61 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LA CLASE 10: LA CAIDA. La tabla de 0xBB5B son treinta y dos pasos que van de 0x0100 bajando hasta cero y de ahi a negativo, o sea una parabola: sube frenando y baja acelerando. El paso se multiplica por (ix+0x14), que sube cada treinta y dos cuadros, asi que cada rebote es mas grande que el anterior.
; ----------------------------------------------------------------------
atiende_clase_10:
	ld c,038h		;bb1e   ; su dibujo
	call L_AA86		;bb20
	ld l,(ix+00ch)		;bb23   ; la velocidad X
	ld h,(ix+00dh)		;bb26
	ld de,00002h		;bb29   ; mas dos
	add hl,de			;bb2c
	ex de,hl			;bb2d
	call L_AA71		;bb2e   ; y a la X
	inc (ix+013h)		;bb31   ; el paso de la parabola
	ld a,(ix+013h)		;bb34
	cp 020h		;bb37   ; treinta y dos pasos
	jr nz,clase_10_saca_el_paso		;bb39
	inc (ix+014h)		;bb3b   ; y a la vuelta siguiente
	xor a			;bb3e
	ld (ix+013h),a		;bb3f
clase_10_saca_el_paso:
	ld hl,0bb5bh		;bb42   ; la tabla de la parabola
	add a,a			;bb45   ; dos bytes por entrada
	add a,l			;bb46
	ld l,a			;bb47
	jr nc,L_BB4B		;bb48
	inc h			;bb4a
L_BB4B:
	ld e,(hl)			;bb4b   ; el paso
	inc hl			;bb4c
	ld d,(hl)			;bb4d
	ld b,(ix+014h)		;bb4e   ; el multiplicador
	ld hl,00000h		;bb51
clase_10_multiplica:
	add hl,de			;bb54   ; sumando tantas veces como diga
	djnz clase_10_multiplica		;bb55
	ex de,hl			;bb57
	jp L_AA7F		;bb58   ; y a la profundidad

; ----------------------------------------------------------------------
; DATOS la_parabola: Treinta y dos pasos de 16 bits: 0x0000, 0x0100, 0x00C0,
;   0x0080, 0x0070, 0x0060... hasta cero y luego 0xFFF8, 0xFFF0... o sea de
;   positivo grande a negativo grande pasando por cero. Es una parabola
;   dibujada de antemano, igual que la vuelta de la clase 9 es una
;   circunferencia dibujada de antemano: en este cartucho no se calcula
;   ninguna curva, se leen.
;   0xbb5b..0xbb9b  (64 bytes)
DATA_la_parabola:
	defw 00000h	; bb5b
	defw 00100h	; bb5d
	defw 000c0h	; bb5f
	defw 00080h	; bb61
	defw 00070h	; bb63
	defw 00060h	; bb65
	defw 00050h	; bb67
	defw 00040h	; bb69
	defw 00038h	; bb6b
	defw 00030h	; bb6d
	defw 00028h	; bb6f
	defw 00020h	; bb71
	defw 00018h	; bb73
	defw 00010h	; bb75
	defw 00008h	; bb77
	defw 00000h	; bb79
	defw 00000h	; bb7b
	defw 0fff8h	; bb7d
	defw 0fff0h	; bb7f
	defw 0ffe8h	; bb81
	defw 0ffe0h	; bb83
	defw 0ffd8h	; bb85
	defw 0ffd0h	; bb87
	defw 0ffc8h	; bb89
	defw 0ffc0h	; bb8b
	defw 0ffb0h	; bb8d
	defw 0ffa0h	; bb8f
	defw 0ff90h	; bb91
	defw 0ff80h	; bb93
	defw 0ff40h	; bb95
	defw 0ff00h	; bb97
	defw 00000h	; bb99

; ======================================================================
; CODIGO 0xbb9b..0xbcaf  (276 bytes)
; ======================================================================


monta_clase_11:
	ld a,001h		;bb9b   ; la bandera de que hay uno pedido
	ld (0e283h),a		;bb9d
	ret			;bba0

; ----------------------------------------------------------------------
; LO OTRO QUE SE DISPARA. Igual que 0xB616 pero para los tres objetos 0x0E, 0x0F y 0x10 de las cinco ranuras, y saca un objeto de la clase 11. Los saltos entre ranuras vuelven a ser 0x10, 0x0E y 0x0F.
; ----------------------------------------------------------------------
dispara_lo_otro:
	ld a,(0e283h)		;bba1   ; ¿hay disparo pedido?
	and a			;bba4
	ret z			;bba5
	ld hl,0e440h		;bba6   ; las cinco ranuras
	ld b,005h		;bba9   ; cinco
dispara_lo_otro_recorre:
	ld a,(hl)			;bbab   ; lo que hay
	and a			;bbac
	ld c,010h		;bbad   ; vacia: salto de 0x10
	jr z,dispara_lo_otro_siguiente		;bbaf
	inc l			;bbb1
	inc l			;bbb2
	ld a,(hl)			;bbb3
	cp 00eh		;bbb4   ; con un 0x0E ahi, salto de 0x0E
	ld c,00eh		;bbb6
	jr nz,dispara_lo_otro_siguiente		;bbb8
	dec l			;bbba
	ld a,(hl)			;bbbb
	cp 00eh		;bbbc   ; el 0x0E...
	jr z,dispara_lo_otro_busca_hueco		;bbbe
	cp 00fh		;bbc0   ; ...el 0x0F...
	jr z,dispara_lo_otro_busca_hueco		;bbc2
	cp 010h		;bbc4   ; ...y el 0x10 se disparan
	jr z,dispara_lo_otro_busca_hueco		;bbc6
	ld c,00fh		;bbc8   ; y lo demas, salto de 0x0F
dispara_lo_otro_siguiente:
	ld a,c			;bbca
	add a,l			;bbcb
	ld l,a			;bbcc
	jr nc,L_BBD0		;bbcd
	inc h			;bbcf
L_BBD0:
	djnz dispara_lo_otro_recorre		;bbd0
	ret			;bbd2
dispara_lo_otro_busca_hueco:
	ld c,a			;bbd3   ; C se queda con lo que se dispara
	ld hl,0e310h		;bbd4   ; los tres huecos
	ld b,003h		;bbd7
dispara_lo_otro_mira_el_hueco:
	ld a,(hl)			;bbd9   ; ¿esta libre?
	and a			;bbda
	jr z,dispara_lo_otro_monta		;bbdb
	ld a,020h		;bbdd   ; 0x20 al siguiente
	add a,l			;bbdf
	ld l,a			;bbe0
	djnz dispara_lo_otro_mira_el_hueco		;bbe1
	ret			;bbe3   ; y si estan los tres ocupados, nada
dispara_lo_otro_monta:
	push hl			;bbe4
	ld b,020h		;bbe5   ; los 32 bytes del hueco
dispara_lo_otro_borra:
	ld (hl),000h		;bbe7
	inc l			;bbe9
	djnz dispara_lo_otro_borra		;bbea
	pop ix		;bbec
	ld (ix+000h),00bh		;bbee   ; la clase 11
	ld (ix+012h),001h		;bbf2   ; y se mueve solo
	xor a			;bbf6
	ld (0e283h),a		;bbf7   ; la peticion, atendida
	ld (ix+007h),0a4h		;bbfa   ; sale de la columna 0xA4
	ld de,00000h		;bbfe
	call L_AA71		;bc01
	call L_AA78		;bc04
	ld de,00300h		;bc07   ; con profundidad 0x300
	call L_AA7F		;bc0a
	ld (ix+013h),003h		;bc0d
	ld (ix+004h),0a4h		;bc11
	ld (ix+005h),00fh		;bc15
	ld a,c			;bc19   ; y de cual de los tres era...
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
	call 0413ah		;bc38   ; banco 0: pide_sonido_si_esta_activo
	ret			;bc3b

; ----------------------------------------------------------------------
; ATENDER A LA CLASE 11. Dos tiempos: primero se acerca hasta que la profundidad pasa de 0x80 y ahi arranca; despues rebota. El rebote es un `neg` sobre la velocidad de la Y cuando se sale por arriba o por abajo (0xBC8B), y el dibujo alterna cada ocho cuadros con el bit 3 del contador. La tabla de 0xBCAF -1, 2, 1, 0, -1, -2, -1...- es la que le da el meneo.
; ----------------------------------------------------------------------
atiende_clase_11:
	inc (ix+015h)		;bc3c   ; un contador
	ld a,(ix+015h)		;bc3f
	cp 080h		;bc42   ; a los 0x80 cuadros...
	jr nz,clase_11_tiempo		;bc44
	ld (ix+015h),000h		;bc46
	call L_AB1E		;bc4a   ; ...pasa algo
clase_11_tiempo:
	ld a,(ix+001h)		;bc4d   ; en que tiempo va
	dec a			;bc50
	jr z,clase_11_rebota		;bc51
	ld a,(ix+00bh)		;bc53   ; la profundidad
	cp 080h		;bc56   ; hasta 0x80 no arranca
	ret c			;bc58
	ld (ix+00fh),001h		;bc59   ; y ahi se le da velocidad en Y
	ld de,00000h		;bc5d
	call L_AA7F		;bc60
	inc (ix+001h)		;bc63   ; al tiempo siguiente
	ret			;bc66
clase_11_rebota:
	bit 3,(ix+014h)		;bc67   ; el bit 3 del contador
	ld a,0a4h		;bc6b   ; un dibujo...
	jr nz,clase_11_guarda_el_dibujo		;bc6d
	ld a,0a8h		;bc6f   ; ...o el otro
clase_11_guarda_el_dibujo:
	ld (ix+004h),a		;bc71
	ld a,(ix+009h)		;bc74   ; la Y
	cp 020h		;bc77   ; por encima de 0x20...
	jr c,clase_11_da_la_vuelta		;bc79
	cp 0d0h		;bc7b   ; ...y por debajo de 0xD0 no rebota
	jr c,clase_11_menea		;bc7d
clase_11_da_la_vuelta:
	ld a,(ix+013h)		;bc7f   ; cuantos rebotes le quedan
	and a			;bc82
	jr z,clase_11_menea		;bc83
	dec (ix+013h)		;bc85   ; uno menos
	ld a,(ix+00fh)		;bc88   ; la velocidad de la Y
	neg		;bc8b   ; del reves: eso es el rebote
	ld (ix+00fh),a		;bc8d
clase_11_menea:
	ld c,(ix+014h)		;bc90   ; el paso del meneo
	inc (ix+014h)		;bc93
	ld a,(ix+014h)		;bc96
	cp 010h		;bc99   ; dieciseis pasos
	jr nz,clase_11_saca_el_meneo		;bc9b
	ld (ix+014h),000h		;bc9d
clase_11_saca_el_meneo:
	ld hl,0bcafh		;bca1   ; la tabla del meneo
	ld a,c			;bca4
	add a,l			;bca5
	ld l,a			;bca6
	jr nc,L_BCAA		;bca7
	inc h			;bca9
L_BCAA:
	ld a,(hl)			;bcaa   ; el paso
	ld (ix+011h),a		;bcab   ; y a la velocidad de la profundidad
	ret			;bcae

; ----------------------------------------------------------------------
; DATOS el_meneo_de_la_clase_11: Dieciseis pasos: 1, 2, 1, 0, -1, -2, -1, -1,
;   -1, -2, -1, 0, 1, 2, 1, 1. Suben y bajan, y por eso el bicho no viene
;   recto sino temblando.
;   0xbcaf..0xbcbf  (16 bytes)
DATA_el_meneo_de_la_clase_11:
	defb 001h,002h,001h,000h,0ffh,0feh,0ffh,0ffh,0ffh,0feh,0ffh,000h,001h,002h,001h,001h	; bcaf  ................

; ======================================================================
; CODIGO 0xbcbf..0xbcec  (45 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; MONTAR LA CLASE 12: SALE HACIA DONDE ESTES. La unica que mira donde esta el jugador para colocarse: 0xBCCE resta la X de lo que se maneja a 0xA0 y con el bit 0 de esa cuenta elige entre subir o bajar. O sea que sale por el lado contrario a donde estas.
; ----------------------------------------------------------------------
monta_clase_12:
	push ix		;bcbf
	pop de			;bcc1
	ld a,004h		;bcc2   ; cuatro bytes mas alla del hueco
	add a,e			;bcc4
	ld e,a			;bcc5
	ld hl,0bcech		;bcc6   ; su plantilla
	ld bc,0000fh		;bcc9   ; quince bytes
	ldir		;bccc
	ld a,(0e204h)		;bcce   ; la X de lo que se maneja
	ld c,a			;bcd1
	ld a,0a0h		;bcd2   ; 0xA0 menos ella
	sub c			;bcd4
	ld (ix+00bh),a		;bcd5   ; y eso es la profundidad de salida
	ld c,0f0h		;bcd8   ; sale de abajo...
	ld de,0fe00h		;bcda
	bit 0,a		;bcdd   ; el bit 0 de esa cuenta
	jr nz,clase_12_colocada		;bcdf
	ld c,002h		;bce1   ; ...o de arriba
	ld de,00200h		;bce3
clase_12_colocada:
	ld (ix+009h),c		;bce6
	jp L_AA78		;bce9

; ----------------------------------------------------------------------
; DATOS plantilla_de_la_clase_12: Quince bytes: X = 0xA800, y todo lo demas a
;   cero menos la marca de que se mueve. La Y y la profundidad las pone la
;   propia rutina de montar, que es lo que la hace distinta.
;   0xbcec..0xbcfb  (15 bytes)
DATA_plantilla_de_la_clase_12:
	defb 0d8h,008h	; bcec
	defw 0a800h	; bcee
	defw 00000h	; bcf0
	defw 00000h	; bcf2
	defw 00000h	; bcf4
	defw 00000h	; bcf6
	defw 00000h	; bcf8
	defb 001h	; bcfa

; ======================================================================
; CODIGO 0xbcfb..0xbd24  (41 bytes)
; ======================================================================


atiende_clase_12:
	ld c,030h		;bcfb   ; su dibujo
	call L_AA86		;bcfd
	ld a,(ix+009h)		;bd00   ; la Y
	cp 002h		;bd03   ; por debajo de 2...
	jr c,clase_12_se_ha_ido		;bd05
	cp 0f8h		;bd07   ; ...o por encima de 0xF8 se ha ido
	ret c			;bd09
clase_12_se_ha_ido:
	ld (ix+000h),000h		;bd0a   ; hueco libre
	ret			;bd0e
monta_clase_13:
	push ix		;bd0f
	pop de			;bd11
	ld a,004h		;bd12   ; cuatro bytes mas alla del hueco
	add a,e			;bd14
	ld e,a			;bd15
	ld hl,0bd24h		;bd16   ; su plantilla
	ld bc,00010h		;bd19   ; dieciseis bytes
	ldir		;bd1c
	ld a,012h		;bd1e   ; el efecto 0x12
	call 0413ah		;bd20   ; banco 0: pide_sonido_si_esta_activo
	ret			;bd23

; ----------------------------------------------------------------------
; DATOS plantilla_de_la_clase_13: Quince bytes: X = 0xA800, Y = 0x7800, Z =
;   0x9800, velocidad X = 0xFE00 -o sea que viene hacia ti- y la marca de que
;   se mueve.
;   0xbd24..0xbd33  (15 bytes)
DATA_plantilla_de_la_clase_13:
	defb 0a4h,00ah	; bd24
	defw 0a800h	; bd26
	defw 07800h	; bd28
	defw 09800h	; bd2a
	defw 00000h	; bd2c
	defw 0fe00h	; bd2e
	defw 00000h	; bd30
	defb 001h	; bd32

; ======================================================================
; CODIGO 0xbd33..0xbe3a  (263 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ATENDER A LA CLASE 13. Cuatro tiempos y el mismo parpadeo de dibujo cada ocho cuadros que la clase 11.
; ----------------------------------------------------------------------
atiende_clase_13:
	inc (ix+014h)		;bd33   ; el contador del parpadeo
	bit 3,(ix+014h)		;bd36   ; el bit 3
	ld a,0a4h		;bd3a   ; un dibujo...
	jr nz,clase_13_guarda_el_dibujo		;bd3c
	ld a,0a8h		;bd3e   ; ...o el otro
clase_13_guarda_el_dibujo:
	ld (ix+004h),a		;bd40
	ld a,(ix+001h)		;bd43   ; en que tiempo va
	dec a			;bd46   ; el 1...
	jr z,clase_13_tramo_1		;bd47
	dec a			;bd49   ; ...el 2...
	jr z,clase_13_tramo_2		;bd4a
	dec a			;bd4c   ; ...y el 3
	jp z,clase_13_tramo_3		;bd4d

; ----------------------------------------------------------------------
; LOS CUATRO TIEMPOS DE LA CLASE 13: UN CUADRADO. Los cuatro trozos son el mismo codigo con los signos cambiados, y leidos juntos se ve la figura: en el tiempo 0 la profundidad baja de ocho en ocho y la Y sube, en el 1 los dos suben, en el 2 la Y baja y la profundidad sube, y en el 3 los dos bajan. O sea que el bicho recorre un cuadrado. Cada tramo acaba cuando el `rl d` saca el bit de signo, que es la forma corta de preguntar "¿ya ha cambiado de sentido?".
; ----------------------------------------------------------------------
	ld l,(ix+010h)		;bd50   ; la velocidad de la profundidad
	ld h,(ix+011h)		;bd53
	ld de,0fff8h		;bd56   ; menos ocho
	add hl,de			;bd59
	ex de,hl			;bd5a
	call L_AA7F		;bd5b
	ld l,(ix+00eh)		;bd5e   ; y la de la Y
	ld h,(ix+00fh)		;bd61
	ld de,00008h		;bd64   ; mas ocho
	add hl,de			;bd67
	ex de,hl			;bd68
	call L_AA78		;bd69
	rl d		;bd6c   ; el bit de signo al acarreo
	ret c			;bd6e   ; mientras no cambie, se sigue en este tramo
	ld de,00000h		;bd6f   ; y al cambiar, se fijan las dos velocidades del tramo siguiente
	call L_AA78		;bd72
	ld de,0fe00h		;bd75
	call L_AA7F		;bd78
	inc (ix+001h)		;bd7b   ; al tiempo 1
	ret			;bd7e
clase_13_tramo_1:
	ld l,(ix+00eh)		;bd7f   ; la velocidad de la Y
	ld h,(ix+00fh)		;bd82
	ld de,00008h		;bd85   ; mas ocho
	add hl,de			;bd88
	ex de,hl			;bd89
	call L_AA78		;bd8a
	ld l,(ix+010h)		;bd8d   ; y la de la profundidad
	ld h,(ix+011h)		;bd90
	ld de,00008h		;bd93   ; tambien mas ocho
	add hl,de			;bd96
	ex de,hl			;bd97
	call L_AA7F		;bd98
	rl d		;bd9b   ; el signo
	ret c			;bd9d
	ld de,00200h		;bd9e
	call L_AA78		;bda1
	ld de,00000h		;bda4
	call L_AA7F		;bda7
	inc (ix+001h)		;bdaa   ; al tiempo 2
	ret			;bdad
clase_13_tramo_2:
	ld l,(ix+010h)		;bdae   ; la profundidad
	ld h,(ix+011h)		;bdb1
	ld de,00008h		;bdb4   ; mas ocho
	add hl,de			;bdb7
	ex de,hl			;bdb8
	call L_AA7F		;bdb9
	ld l,(ix+00eh)		;bdbc   ; y la Y
	ld h,(ix+00fh)		;bdbf
	ld de,0fff8h		;bdc2   ; menos ocho
	add hl,de			;bdc5
	ex de,hl			;bdc6
	call L_AA78		;bdc7
	rl d		;bdca   ; el signo, ahora al reves
	ret nc			;bdcc
	ld de,00000h		;bdcd
	call L_AA78		;bdd0
	ld de,00200h		;bdd3
	call L_AA7F		;bdd6
	inc (ix+001h)		;bdd9   ; al tiempo 3
	ret			;bddc
clase_13_tramo_3:
	ld l,(ix+00eh)		;bddd   ; la Y
	ld h,(ix+00fh)		;bde0
	ld de,0fff8h		;bde3   ; menos ocho
	add hl,de			;bde6
	ex de,hl			;bde7
	call L_AA78		;bde8
	ld l,(ix+010h)		;bdeb   ; y la profundidad
	ld h,(ix+011h)		;bdee
	ld de,0fff8h		;bdf1   ; tambien menos ocho
	add hl,de			;bdf4
	ex de,hl			;bdf5
	call L_AA7F		;bdf6
	rl d		;bdf9   ; y al cerrar el cuadrado...
	ret nc			;bdfb
	ld (ix+000h),000h		;bdfc   ; ...el hueco queda libre
	ret			;be00

; ----------------------------------------------------------------------
; MONTAR LA CLASE 14: TE BUSCA. Sale a una de ocho alturas -la tabla de 0xBE49, recorrida en circulo por 0xE284- y despues compara esa altura con la del jugador para decidir si sube o baja. Es la unica de las quince que se orienta hacia ti al nacer.
; ----------------------------------------------------------------------
monta_clase_14:
	push ix		;be01
	pop de			;be03
	ld a,004h		;be04   ; cuatro bytes mas alla del hueco
	add a,e			;be06
	ld e,a			;be07
	ld hl,0be3ah		;be08   ; su plantilla
	ld bc,0000fh		;be0b   ; quince bytes
	ldir		;be0e
	ld hl,0e284h		;be10   ; el contador que gira
	ld a,(hl)			;be13
	inc (hl)			;be14   ; uno mas
	ld hl,0be49h		;be15   ; la tabla de ocho alturas
	and 007h		;be18   ; de ocho en ocho
	add a,l			;be1a
	ld l,a			;be1b
	jr nc,L_BE1F		;be1c
	inc h			;be1e
L_BE1F:
	ld a,(hl)			;be1f   ; la altura que toca
	ld (ix+009h),a		;be20
	ld a,(0e205h)		;be23   ; la Y de lo que se maneja
	cp (ix+009h)		;be26   ; contra la suya
	ld de,0fe00h		;be29   ; si esta por encima, hacia arriba...
	jr c,clase_14_orientada		;be2c
	ld de,00200h		;be2e   ; ...y si no, hacia abajo
clase_14_orientada:
	call L_AA78		;be31
	ld a,015h		;be34   ; el efecto 0x15
	call 0413ah		;be36   ; banco 0: pide_sonido_si_esta_activo
	ret			;be39

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe3a..0xbe51  (23 bytes)
DATA_BE3A:
	defb 0bch,00ah,000h,0a8h,000h,000h,000h,098h,000h,000h,000h,000h,000h,0fdh,001h,020h	; be3a  ...............
	defb 080h,0c0h,060h,0e0h,0a0h,040h,070h	; be4a

; ======================================================================
; CODIGO 0xbe51..0xbebf  (110 bytes)
; ======================================================================


L_BE51:
	ret			;be51
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
L_BE7E:
	ld a,(0e003h)		;be7e   ; el contador de cuadros
	and 004h		;be81
	ld c,0a4h		;be83
	jr z,L_BE89		;be85
	ld c,0a8h		;be87
L_BE89:
	ld (ix+004h),c		;be89
	ld a,(ix+001h)		;be8c
	dec a			;be8f
	jr z,L_BEA9		;be90
	dec a			;be92
	ret z			;be93
	ld a,(0e205h)		;be94   ; la Y en la pantalla de lo que se maneja
	sub (ix+009h)		;be97
	jr nc,L_BE9E		;be9a
	neg		;be9c
L_BE9E:
	cp 008h		;be9e
	ret nc			;bea0
	inc (ix+001h)		;bea1
	ld (ix+012h),000h		;bea4
	ret			;bea8
L_BEA9:
	dec (ix+013h)		;bea9
	jr z,L_BEB7		;beac
	ld a,(ix+013h)		;beae
	cp 040h		;beb1
	ret nz			;beb3
	jp L_AB1E		;beb4
L_BEB7:
	inc (ix+001h)		;beb7
	ld (ix+012h),001h		;beba
	ret			;bebe

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbebf..0xc000  (321 bytes)
DATA_BEBF:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bebf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; becf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bedf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beef  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beff  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfaf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfbf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfcf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfef  ................
	defb 0ffh	; bfff
