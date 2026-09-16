; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS cola_95C1: la cola del partitura de sonido (voz del sonido 0x3B; voz
;   del sonido 0x3C; voz del sonido 0x3D; voz del sonido 0x3E; ...) de 0x95C1
;   del banco 14, que pasa de ranura sin cambiar de banco; se entra por
;   0xA000, 0xA042, 0xA0D1, 0xA14D, 0xA18D, 0xA23B, 0xA31A, 0xA3A5, 0xA41B,
;   0xA484, 0xA4ED, 0xA56C, 0xA60E, 0xA673, 0xA6FB, 0xA800; lo cargan
;   0x873A[58], 0x873A[59], 0x873A[60], 0x873A[61], 0x873A[62], 0x873A[63] y
;   21 sitios mas (2266 bytes)
;   0xa000..0xa8da  (2266 bytes)
DATA_cola_95C1:
	defb 000h,000h,040h,000h,000h,000h,0feh,00dh,0f7h,09fh,000h,000h,000h,000h,040h,000h	; a000  ..@...........@.
	defb 080h,081h,000h,000h,000h,040h,000h,000h,000h,070h,070h,070h,070h,060h,060h,060h	; a010  .....@...pppp```
	defb 060h,080h,080h,080h,080h,0d5h,040h,040h,040h,040h,040h,0efh,0f8h,013h,0e0h,0c1h	; a020  `.....@@@@@.....
	defb 000h,0c1h,0f6h,013h,000h,0c1h,0f4h,013h,000h,0c1h,0f2h,013h,000h,0c0h,0feh,0feh	; a030  ................
	defb 0cah,09fh,0efh,0d7h,0fah,016h,0e2h,0c2h,040h,0c0h,040h,0c2h,040h,0c1h,0c2h,050h	; a040  ........@.@.@..P
	defb 0c0h,050h,0c2h,050h,0c1h,0feh,002h,046h,0a0h,0fah,025h,0e1h,049h,0c1h,054h,0c0h	; a050  .P.P...F..%.I.T.
	defb 051h,070h,091h,07ah,0c0h,042h,020h,007h,0c0h,0feh,002h,05bh,0a0h,0e1h,052h,052h	; a060  Qp.z.B ....[..RR
	defb 051h,023h,081h,091h,0c0h,0a1h,0c0h,0b1h,0c0h,0e0h,000h,0e1h,091h,050h,0e2h,050h	; a070  Q#...........P.P
	defb 0c0h,050h,050h,0c0h,050h,022h,080h,0c0h,070h,0c1h,050h,0c1h,020h,001h,020h,0feh	; a080  .PP.P"..p.P. . .
	defb 002h,06dh,0a0h,0e1h,049h,0c1h,054h,0c0h,051h,070h,091h,07ah,0c0h,042h,020h,007h	; a090  .m..I.T.Qp.z.B .
	defb 0c0h,0feh,002h,093h,0a0h,0e0h,052h,001h,0c0h,000h,0c0h,002h,022h,000h,0e1h,0a2h	; a0a0  ......R....."...
	defb 0a1h,0e0h,000h,021h,002h,0e1h,050h,0e2h,050h,0c0h,050h,0c1h,020h,001h,020h,080h	; a0b0  ...!..P.P.P. . .
	defb 0c0h,090h,0c1h,0a0h,0c1h,0b0h,0c1h,0e1h,000h,0feh,002h,0a5h,0a0h,0feh,0feh,05bh	; a0c0  ...............[
	defb 0a0h,0efh,0d7h,0fbh,014h,0e4h,002h,0e3h,000h,0c0h,000h,0e4h,070h,0c0h,070h,0e3h	; a0d0  ............p.p.
	defb 003h,0c1h,0e4h,090h,0c0h,090h,091h,070h,052h,0feh,006h,0d5h,0a0h,0e4h,0c2h,050h	; a0e0  .......pR......P
	defb 0c0h,050h,050h,0c0h,050h,092h,0c2h,0a0h,0c0h,0a0h,0a0h,0c0h,0a0h,0e3h,002h,0feh	; a0f0  .PP.P...........
	defb 004h,0edh,0a0h,0e4h,002h,0e3h,000h,0c0h,000h,0e4h,070h,0c0h,070h,0e3h,003h,0c1h	; a100  ..........p.p...
	defb 0e4h,090h,0c0h,090h,091h,070h,052h,0feh,004h,003h,0a1h,0e4h,0c2h,050h,0c0h,050h	; a110  .....pR......P.P
	defb 050h,0c0h,050h,092h,0c2h,0a0h,0c0h,0a0h,0a0h,0c0h,0a0h,0e3h,002h,0feh,004h,01bh	; a120  P.P.............
	defb 0a1h,0e4h,002h,0e3h,000h,0c0h,000h,0e4h,070h,0c0h,070h,0e3h,003h,0c1h,0e4h,090h	; a130  ........p.p.....
	defb 0c0h,090h,091h,070h,052h,0feh,004h,031h,0a1h,0feh,0feh,0edh,0a0h,0d7h,0e9h,001h	; a140  ...pR..1........
	defb 000h,001h,000h,040h,000h,000h,071h,000h,001h,000h,001h,000h,070h,081h,081h,080h	; a150  ...@..q.....p...
	defb 001h,000h,001h,000h,040h,000h,000h,071h,000h,001h,000h,001h,000h,070h,070h,070h	; a160  ....@..q.....ppp
	defb 080h,080h,080h,001h,000h,001h,000h,030h,000h,000h,071h,000h,001h,000h,001h,000h	; a170  .......0..q.....
	defb 070h,080h,080h,081h,030h,0feh,007h,073h,0a1h,0feh,0feh,04fh,0a1h,0d7h,0eah,051h	; a180  p...0..s...O...Q
	defb 001h,091h,051h,001h,091h,031h,001h,091h,031h,001h,091h,0a0h,090h,056h,051h,050h	; a190  ..Q..1..1....VQP
	defb 0e9h,070h,070h,070h,070h,070h,070h,080h,081h,081h,080h,0efh,0fah,023h,0e2h,055h	; a1a0  .pppppp......#.U
	defb 001h,050h,001h,0e1h,006h,0e2h,001h,050h,001h,0e1h,006h,001h,0e2h,0a0h,091h,0a6h	; a1b0  .P.....P........
	defb 0a1h,0e1h,000h,0e2h,0a1h,095h,053h,0a2h,084h,053h,0a2h,090h,070h,059h,021h,0e3h	; a1c0  ......S..S..pY!.
	defb 0a0h,0e2h,021h,053h,042h,0e2h,055h,001h,051h,0e1h,001h,055h,051h,0e2h,050h,0e1h	; a1d0  ..!SB.U.Q..UQ.P.
	defb 051h,036h,0e2h,031h,081h,0e1h,031h,035h,011h,060h,011h,006h,0e2h,001h,051h,0e1h	; a1e0  Q6.1..15.`....Q.
	defb 001h,0e2h,090h,070h,053h,001h,051h,091h,0a0h,090h,053h,001h,051h,0e1h,001h,0e2h	; a1f0  ...pS.Q...S.Q...
	defb 0a0h,090h,050h,021h,072h,070h,070h,090h,070h,0e2h,085h,031h,080h,031h,0e1h,036h	; a200  ..P!rpp.p..1.1.6
	defb 0e2h,031h,080h,031h,0e1h,036h,031h,010h,001h,015h,010h,041h,030h,011h,005h,0e2h	; a210  .1.1.61....A0...
	defb 083h,032h,0e1h,034h,0e2h,0b3h,082h,0e1h,050h,030h,019h,0e2h,0a1h,0e1h,000h,011h	; a220  .2.4....P0......
	defb 032h,030h,0e2h,090h,0e1h,000h,040h,0feh,0feh,08eh,0a1h,0efh,0d7h,0fah,025h,0e3h	; a230  20....@.......%.
	defb 051h,050h,0feh,004h,03fh,0a2h,031h,030h,0feh,004h,046h,0a2h,021h,020h,0feh,004h	; a240  QP..?.10..F.! ..
	defb 04ch,0a2h,0fbh,015h,0e4h,071h,090h,0a1h,0e3h,002h,0fah,015h,000h,000h,020h,040h	; a250  L....q........ @
	defb 051h,050h,0feh,004h,060h,0a2h,031h,030h,0feh,004h,066h,0a2h,021h,020h,0feh,004h	; a260  QP..`.10..f.! ..
	defb 06ch,0a2h,011h,010h,0feh,004h,072h,0a2h,001h,000h,0feh,004h,078h,0a2h,0e4h,0b1h	; a270  l.....r.....x...
	defb 0b0h,0feh,004h,07eh,0a2h,0a1h,0a0h,0feh,004h,085h,0a2h,071h,090h,0a1h,0e3h,002h	; a280  ...~.......q....
	defb 000h,000h,020h,040h,051h,050h,0feh,004h,094h,0a2h,031h,030h,0feh,004h,09ah,0a2h	; a290  .. @QP....10....
	defb 081h,080h,0feh,004h,0a0h,0a2h,061h,060h,060h,060h,060h,0feh,002h,0a6h,0a2h,001h	; a2a0  ......a````.....
	defb 000h,0e2h,000h,0e3h,000h,000h,0feh,002h,0afh,0a2h,0e4h,0b1h,0b0h,0e3h,0b0h,0e4h	; a2b0  ................
	defb 0b0h,0b0h,0feh,002h,0bah,0a2h,0e4h,0a1h,0a0h,0e3h,0a0h,0e4h,0a0h,0a0h,0feh,002h	; a2c0  ................
	defb 0c6h,0a2h,071h,070h,070h,090h,0a0h,0e3h,001h,000h,000h,020h,040h,081h,080h,0feh	; a2d0  ..qpp...... @...
	defb 004h,0ddh,0a2h,061h,060h,061h,060h,061h,060h,061h,050h,051h,050h,0feh,004h,0ebh	; a2e0  ...a`a`a`aPQP...
	defb 0a2h,041h,040h,041h,040h,041h,060h,041h,030h,031h,030h,0feh,004h,0f9h,0a2h,021h	; a2f0  .A@A@A`A010....!
	defb 020h,021h,020h,021h,040h,021h,010h,011h,010h,0feh,004h,007h,0a3h,0e4h,071h,080h	; a300   ! !@!........q.
	defb 0a1h,0e3h,002h,000h,041h,040h,0feh,0feh,03fh,0a2h,0efh,0d7h,0fah,023h,0e2h,050h	; a310  ....A@..?....#.P
	defb 0e1h,000h,0e2h,050h,050h,0e1h,050h,0e2h,050h,0feh,008h,01ah,0a3h,0e9h,001h,000h	; a320  ...PP.P.P.......
	defb 041h,000h,001h,000h,041h,000h,001h,000h,041h,000h,001h,000h,040h,081h,0feh,003h	; a330  A...A...A...@...
	defb 02eh,0a3h,001h,000h,041h,000h,001h,000h,041h,000h,070h,070h,070h,070h,070h,070h	; a340  ....A...A.pppppp
	defb 080h,080h,080h,080h,091h,001h,000h,041h,000h,001h,000h,041h,000h,001h,000h,041h	; a350  .......A...A...A
	defb 000h,001h,000h,040h,080h,080h,0feh,003h,055h,0a3h,001h,000h,040h,021h,001h,000h	; a360  ...@....U...@!..
	defb 040h,021h,001h,000h,040h,000h,000h,040h,081h,080h,081h,001h,000h,041h,000h,001h	; a370  @!..@..@.....A..
	defb 000h,041h,000h,001h,000h,041h,000h,001h,000h,040h,081h,0feh,003h,07bh,0a3h,001h	; a380  .A...A...@...{..
	defb 000h,041h,000h,001h,000h,041h,000h,001h,000h,041h,000h,070h,070h,070h,080h,080h	; a390  .A...A...A.ppp..
	defb 080h,0feh,0feh,01ah,0a3h,0efh,0dah,0fbh,033h,0e1h,070h,0d7h,000h,0dah,0f8h,033h	; a3a0  ........3.p....3
	defb 070h,0f8h,000h,001h,0f9h,000h,001h,0fah,000h,001h,0fbh,004h,002h,0d3h,0c0h,0dah	; a3b0  p...............
	defb 000h,030h,020h,050h,0f7h,066h,0e0h,0c0h,000h,0f8h,066h,000h,0f9h,066h,000h,0fah	; a3c0  .0 P.f....f..f..
	defb 066h,000h,0fbh,066h,000h,0fbh,033h,000h,000h,000h,0e1h,0b0h,0f8h,033h,0e0h,000h	; a3d0  f..f..3......3..
	defb 0e1h,0b0h,0f6h,033h,0e0h,000h,0e1h,0b0h,0c1h,0feh,004h,0a5h,0a3h,0dah,0fah,004h	; a3e0  ...3............
	defb 0e1h,071h,0e0h,001h,0e1h,0b1h,071h,0a1h,091h,051h,081h,0fah,004h,070h,080h,070h	; a3f0  .q....q..Q...p.p
	defb 080h,070h,080h,070h,080h,070h,0c0h,0f7h,004h,070h,0c0h,0f5h,004h,070h,0c0h,0f4h	; a400  .p.p.p...p...p..
	defb 004h,070h,0c0h,0feh,002h,0edh,0a3h,0feh,0feh,0a5h,0a3h,0efh,0dah,0fah,004h,0e3h	; a410  .p..............
	defb 000h,020h,030h,050h,000h,020h,030h,050h,000h,020h,030h,050h,000h,020h,030h,050h	; a420  . 0P. 0P. 0P. 0P
	defb 0e4h,0b0h,0e3h,000h,020h,030h,0e4h,0b0h,0e3h,000h,020h,030h,0e4h,0b0h,0e3h,000h	; a430  .... 0.... 0....
	defb 020h,030h,0e4h,0b0h,0e3h,000h,020h,030h,0feh,002h,01bh,0a4h,0dah,0fah,006h,0e3h	; a440   0.... 0........
	defb 000h,0e2h,000h,0e3h,0a0h,080h,070h,050h,030h,020h,000h,0e2h,000h,0e3h,0a0h,080h	; a450  ......pP0 ......
	defb 070h,050h,030h,020h,0e4h,0b0h,0e3h,020h,050h,020h,050h,080h,0b0h,0e2h,020h,0c0h	; a460  pP0 ... P P... .
	defb 0f8h,006h,020h,0c0h,0f6h,006h,020h,0c0h,0f5h,006h,020h,0c1h,0feh,004h,04ch,0a4h	; a470  .. ... ... ...L.
	defb 0feh,0feh,01bh,0a4h,0efh,0dah,0fah,004h,0e4h,000h,020h,030h,050h,000h,020h,030h	; a480  .......... 0P. 0
	defb 050h,000h,020h,030h,050h,000h,020h,030h,050h,0e5h,0b0h,0e4h,000h,020h,030h,0e5h	; a490  P. 0P. 0P.... 0.
	defb 0b0h,0e4h,000h,020h,030h,0e5h,0b0h,0e4h,000h,020h,030h,0e5h,0b0h,0e4h,000h,020h	; a4a0  ... 0.... 0....
	defb 030h,0feh,002h,084h,0a4h,0dah,0fah,006h,0e4h,000h,0e3h,000h,0e4h,0a0h,080h,070h	; a4b0  0..............p
	defb 050h,030h,020h,000h,0e3h,000h,0e4h,0a0h,080h,070h,050h,030h,020h,0e5h,0b0h,0e4h	; a4c0  P0 ......pP0 ...
	defb 020h,050h,020h,050h,080h,0b0h,0e3h,020h,0c0h,0f8h,006h,020h,0c0h,0f6h,006h,020h	; a4d0   P P... ... ...
	defb 0c0h,0f5h,006h,020h,0c1h,0feh,004h,0b5h,0a4h,0feh,0feh,084h,0a4h,0efh,0dbh,0fah	; a4e0  ... ............
	defb 022h,0e0h,001h,0e1h,0a2h,0fah,033h,070h,075h,0fah,022h,081h,072h,0fah,033h,030h	; a4f0  ".....3pu.".r.30
	defb 0fah,022h,035h,081h,072h,0fah,033h,030h,0fah,022h,032h,052h,022h,052h,0fah,023h	; a500  ."5.r.30."2R"R.#
	defb 070h,070h,070h,0fah,033h,091h,0fah,033h,0b0h,0e0h,000h,000h,000h,0fah,022h,021h	; a510  ppp.3..3......"!
	defb 030h,003h,0fah,023h,020h,000h,0fah,022h,0e1h,0a5h,0fah,033h,0b0h,0b0h,0b0h,0fah	; a520  0..# .."...3....
	defb 023h,0e0h,001h,020h,0fah,033h,000h,000h,000h,0fah,022h,021h,0fah,033h,030h,0fah	; a530  #.. .3...."!.30.
	defb 022h,003h,0fah,033h,020h,030h,0fah,022h,025h,0fah,033h,0e1h,0b0h,0b0h,0b0h,0fah	; a540  "..3 0."%.3.....
	defb 023h,0b2h,0fah,033h,0e1h,020h,0c1h,030h,0c1h,0e0h,020h,0c0h,030h,0c0h,0e1h,020h	; a550  #..3. .0.. .0..
	defb 0c1h,030h,0c1h,0e0h,030h,030h,020h,0c0h,0feh,0feh,0efh,0a4h,0efh,0dbh,0f9h,011h	; a560  .0..00 .........
	defb 0e3h,000h,050h,070h,0a0h,070h,0a0h,000h,050h,070h,0a0h,070h,0a0h,010h,050h,080h	; a570  ..Pp.p..Pp.p..P.
	defb 0e2h,010h,0e3h,080h,0e2h,010h,0e3h,010h,050h,080h,0e2h,010h,0e3h,080h,0e2h,010h	; a580  ........P.......
	defb 0e3h,050h,080h,0e2h,000h,030h,000h,0e3h,080h,050h,080h,0e2h,000h,020h,000h,0e3h	; a590  .P...0...P... ..
	defb 080h,070h,0e2h,000h,020h,070h,020h,000h,0e3h,070h,0e2h,000h,020h,070h,020h,000h	; a5a0  .p.. p ..p.. p .
	defb 0e3h,000h,070h,0a0h,030h,070h,0a0h,000h,070h,0a0h,030h,070h,0a0h,070h,0e2h,020h	; a5b0  ..p.0p..p.0p.p.
	defb 050h,0e3h,0a0h,0e2h,020h,050h,0e3h,070h,0e2h,070h,0e3h,070h,091h,0b0h,0f9h,022h	; a5c0  P... P.p.p.p..."
	defb 000h,000h,070h,000h,000h,070h,080h,080h,0e2h,030h,0e3h,080h,080h,0e2h,030h,0e3h	; a5d0  ..p..p...0....0.
	defb 070h,070h,0e2h,020h,0e3h,070h,070h,0e2h,020h,0e3h,070h,070h,0e2h,020h,0e3h,070h	; a5e0  pp. .pp. .pp. .p
	defb 070h,0e2h,020h,0f9h,032h,0e3h,000h,000h,000h,000h,000h,000h,050h,050h,050h,050h	; a5f0  p. .2.......PPPP
	defb 000h,000h,000h,000h,000h,000h,050h,050h,050h,050h,0feh,0feh,06eh,0a5h,0efh,0dbh	; a600  ......PPPP..n...
	defb 0f9h,023h,0e1h,031h,023h,0c1h,000h,020h,030h,000h,0f9h,023h,001h,0e2h,0a2h,080h	; a610  .#.1#.. 0..#....
	defb 0f9h,023h,081h,080h,0a0h,0e1h,000h,0e2h,080h,0e1h,001h,0e2h,0a2h,0f9h,033h,080h	; a620  .#............3.
	defb 0f9h,023h,082h,0e1h,002h,002h,002h,0f9h,033h,000h,000h,000h,021h,020h,030h,030h	; a630  .#......3...! 00
	defb 030h,051h,070h,033h,050h,030h,025h,020h,020h,020h,031h,050h,030h,030h,030h,051h	; a640  0Qp3P0%   1P000Q
	defb 070h,033h,050h,070h,055h,020h,020h,020h,022h,0f9h,033h,0e2h,090h,0c1h,090h,0c1h	; a650  p3PpU   ".3.....
	defb 0e1h,090h,0c0h,090h,0c0h,0e2h,090h,0c1h,090h,0c1h,0e1h,050h,050h,070h,0c0h,0feh	; a660  ...........PPp..
	defb 0feh,010h,0a6h,0efh,0d8h,0f9h,013h,0e2h,070h,0c0h,061h,040h,026h,000h,020h,049h	; a670  ........p.a@&. I
	defb 070h,0c0h,061h,040h,026h,000h,020h,040h,098h,0b1h,090h,0e1h,021h,000h,0d4h,0e2h	; a680  p.a@&. @....!...
	defb 0b0h,0e1h,000h,0e2h,0b0h,092h,0d8h,0b1h,090h,0e1h,021h,000h,0e2h,0b0h,0e1h,000h	; a690  ..........!.....
	defb 0e2h,0b2h,090h,0e1h,021h,000h,051h,030h,0d4h,020h,030h,020h,002h,0d8h,021h,000h	; a6a0  ....!.Q0. 0 ..!.
	defb 051h,030h,020h,030h,022h,000h,070h,020h,001h,070h,020h,060h,020h,000h,070h,020h	; a6b0  Q0 0".p .p ` .p
	defb 001h,070h,020h,060h,020h,000h,0e0h,000h,0e1h,090h,041h,0e0h,000h,0e1h,090h,0b0h	; a6c0  .p ` .....A.....
	defb 060h,020h,0e0h,000h,0e1h,090h,041h,0e0h,000h,0e1h,090h,0b0h,060h,020h,021h,000h	; a6d0  ` ....A.....` !.
	defb 055h,0d4h,050h,030h,020h,032h,0d8h,021h,000h,028h,021h,000h,055h,0d4h,050h,030h	; a6e0  U.P0 2.!.(!.U.P0
	defb 020h,032h,0d8h,021h,090h,0e0h,028h,0feh,0feh,073h,0a6h,0efh,0d8h,0f9h,013h,0e2h	; a6f0   2.!..(..s......
	defb 000h,0c0h,000h,000h,0c0h,000h,000h,0c0h,000h,000h,0c0h,000h,0e3h,090h,0c0h,090h	; a700  ................
	defb 090h,0c0h,090h,090h,0c0h,090h,090h,0c0h,090h,0e2h,000h,0c0h,000h,000h,0c0h,000h	; a710  ................
	defb 000h,0c0h,000h,000h,0c0h,000h,0e3h,090h,0c0h,090h,090h,0c0h,090h,090h,0c0h,090h	; a720  ................
	defb 090h,0c0h,090h,050h,0e2h,000h,050h,0e3h,050h,0e2h,000h,050h,0e3h,050h,0e2h,000h	; a730  ...P..P.P..P.P..
	defb 050h,0e3h,050h,0e2h,000h,050h,0e3h,050h,0e2h,000h,050h,0e3h,050h,0e2h,000h,050h	; a740  P.P..P.P..P.P..P
	defb 0e3h,050h,0e2h,000h,050h,0e3h,030h,0a0h,0e2h,030h,0e3h,030h,0a0h,0e2h,030h,0e3h	; a750  .P..P.0..0.0..0.
	defb 030h,0a0h,0e2h,030h,0e3h,030h,0a0h,0e2h,030h,0e3h,030h,0a0h,0e2h,030h,0e3h,030h	; a760  0..0.0..0.0..0.0
	defb 0a0h,0e2h,030h,0e3h,030h,0a0h,0e2h,030h,0e4h,090h,0e3h,040h,0e2h,000h,040h,090h	; a770  ..0.0..0...@..@.
	defb 040h,020h,060h,090h,0e4h,090h,0e3h,040h,0e2h,000h,040h,090h,040h,020h,060h,090h	; a780  @ `....@..@.@ `.
	defb 0e4h,090h,0e3h,040h,0e2h,000h,040h,090h,040h,0e3h,090h,0e2h,020h,060h,0e4h,090h	; a790  ...@..@.@... `..
	defb 0e3h,040h,0e2h,000h,040h,090h,040h,0e3h,090h,0e2h,020h,060h,0e3h,030h,0a0h,0e2h	; a7a0  .@..@.@... `.0..
	defb 050h,0e3h,030h,0a0h,0e2h,070h,0e3h,030h,0a0h,0e2h,050h,0e3h,030h,0a0h,0e2h,070h	; a7b0  P.0..p.0..P.0..p
	defb 0e3h,050h,0e2h,000h,070h,0e3h,050h,0e2h,000h,090h,0e3h,050h,0e2h,000h,070h,0e3h	; a7c0  .P..p.P....P..p.
	defb 050h,0e2h,000h,090h,0e3h,030h,0a0h,0e2h,050h,0e3h,030h,0a0h,0e2h,070h,0e3h,030h	; a7d0  P....0..P.0..p.0
	defb 0a0h,0e2h,050h,0e3h,030h,0a0h,0e2h,070h,0e3h,050h,0e2h,000h,070h,0e3h,050h,0e2h	; a7e0  ..P.0..p.P..p.P.
	defb 000h,090h,0e3h,050h,0e2h,000h,070h,0e3h,050h,0e2h,000h,090h,0feh,0feh,0fbh,0a6h	; a7f0  ...P..p.P.......
	defb 0efh,0d8h,0f9h,013h,0e1h,070h,0c0h,061h,040h,020h,0eah,071h,061h,040h,020h,0efh	; a800  .....p.a@ .qa@ .
	defb 0f9h,013h,000h,020h,0f8h,010h,040h,0f6h,000h,040h,0f5h,000h,040h,0f4h,000h,040h	; a810  ... ..@..@..@..@
	defb 0eah,000h,020h,043h,0efh,0f9h,013h,070h,0c0h,061h,040h,020h,0eah,071h,061h,040h	; a820  .. C...p.a@ .qa@
	defb 020h,0efh,0f9h,013h,0e1h,000h,020h,040h,0f8h,010h,090h,0f6h,000h,090h,0f5h,001h	; a830   ..... @........
	defb 090h,0eah,000h,020h,040h,092h,0efh,0f9h,013h,0e2h,071h,0c0h,0b1h,090h,071h,0c0h	; a840  ... @.....q...q.
	defb 071h,0c0h,0b1h,090h,073h,0c1h,0a1h,070h,0e1h,021h,000h,0d4h,0e2h,0a0h,0e1h,000h	; a850  q...s..p.!......
	defb 0e2h,0a0h,092h,0d8h,0a1h,070h,0e1h,021h,000h,0e2h,0a0h,0e1h,000h,0e2h,0a2h,090h	; a860  .....p.!........
	defb 0e1h,040h,0e2h,0b0h,091h,0e1h,040h,0e2h,0b0h,0eah,060h,020h,000h,0efh,0f9h,013h	; a870  .@....@...` ....
	defb 0e1h,040h,0e2h,0b0h,091h,0e1h,040h,0e2h,0b0h,0eah,060h,020h,000h,0efh,0f9h,013h	; a880  .@....@...` ....
	defb 0e1h,040h,000h,0e2h,091h,0e1h,040h,000h,0eah,020h,060h,020h,0efh,0f9h,013h,040h	; a890  .@....@.. ` ...@
	defb 000h,0e2h,091h,0e1h,040h,000h,0eah,020h,060h,020h,0efh,0f9h,013h,0e2h,0a1h,090h	; a8a0  ....@.. ` ......
	defb 0e1h,025h,0d4h,020h,000h,0e2h,0a0h,0e1h,002h,0d8h,0e2h,092h,0c2h,0eah,021h,090h	; a8b0  .%. ..........!.
	defb 022h,0efh,0f9h,013h,0a1h,090h,0e1h,025h,0d4h,020h,000h,0e2h,0a0h,0e1h,002h,0d8h	; a8c0  "......%. ......
	defb 0e2h,091h,0e1h,020h,098h,0feh,0feh,000h,0a8h,0ffh	; a8d0  ... ......

; ----------------------------------------------------------------------
; DATOS tira_A8DA: partitura de sonido (voz del sonido 0x5C; voz del sonido
;   0x5D; voz del sonido 0x5E; voz del sonido 0x5F) que lee pide_un_efecto; se
;   entra por 0xA8DA, 0xA93E, 0xA9FB, 0xAA43; lo cargan 0x873A[91],
;   0x873A[92], 0x873A[93], 0x873A[94] (448 bytes)
;   0xa8da..0xaa9a  (448 bytes)
DATA_tira_A8DA:
	defb 0efh,0d6h,0fah,024h,0e1h,040h,000h,000h,051h,000h,000h,041h,000h,000h,051h,000h	; a8da  ...$.@..Q..A..Q.
	defb 001h,0feh,003h,0dbh,0a8h,040h,000h,000h,051h,000h,001h,000h,0e2h,0a0h,0e1h,000h	; a8ea  .....@..Q.......
	defb 020h,030h,020h,030h,050h,0dch,0fah,023h,0e2h,073h,070h,0e1h,000h,0e2h,070h,0a4h	; a8fa   0 0P..#.sp...p.
	defb 0e1h,000h,020h,040h,051h,040h,020h,003h,031h,020h,000h,051h,032h,0feh,002h,0ffh	; a90a  .. @Q@ .1 .Q2...
	defb 0a8h,0e2h,083h,080h,0a0h,0e1h,000h,022h,0e2h,0a1h,0e1h,020h,051h,042h,00dh,0e1h	; a91a  ......."... QB..
	defb 033h,030h,020h,000h,053h,0d6h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; a92a  30 .S...........
	defb 0feh,0feh,0dbh,0a8h,0efh,0d6h,0fbh,025h,0e3h,001h,000h,000h,0feh,003h,03fh,0a9h	; a93a  .......%......?.
	defb 001h,0e4h,0a3h,0a0h,0a0h,0a1h,0a0h,0a0h,0feh,002h,04fh,0a9h,0a1h,093h,090h,090h	; a94a  ..........O.....
	defb 091h,090h,090h,0feh,002h,05ah,0a9h,091h,083h,080h,080h,081h,080h,080h,0fch,015h	; a95a  .....Z..........
	defb 080h,070h,080h,0a0h,0e3h,000h,0e4h,0a0h,0e3h,000h,020h,0fah,015h,0e3h,001h,000h	; a96a  .p........ .....
	defb 000h,0feh,004h,077h,0a9h,0e4h,0a1h,0a0h,0a0h,0feh,004h,07fh,0a9h,091h,090h,090h	; a97a  ...w............
	defb 0feh,004h,087h,0a9h,081h,080h,080h,081h,080h,080h,0a1h,0a0h,0a0h,0a1h,0a0h,0a0h	; a98a  ................
	defb 0e3h,001h,000h,000h,0feh,004h,09ah,0a9h,0e4h,0a1h,0a0h,0a0h,0feh,004h,0a2h,0a9h	; a99a  ................
	defb 091h,090h,090h,0feh,004h,0aah,0a9h,081h,080h,080h,081h,080h,080h,0a1h,0a0h,0a0h	; a9aa  ................
	defb 0a1h,0a0h,0a0h,081h,080h,080h,0feh,004h,0bdh,0a9h,0a1h,0a0h,0a0h,0feh,004h,0c4h	; a9ba  ................
	defb 0a9h,0e3h,001h,000h,000h,0feh,004h,0cbh,0a9h,001h,0e4h,070h,0e3h,000h,041h,000h	; a9ca  ...........p..A.
	defb 040h,070h,040h,000h,041h,000h,0e4h,070h,0a0h,0e4h,081h,080h,080h,0feh,004h,0e3h	; a9da  @p@.A..p........
	defb 0a9h,0a1h,0a0h,0a0h,0a1h,0e9h,080h,080h,080h,071h,071h,070h,091h,0feh,0feh,03eh	; a9ea  .........qqp...>
	defb 0a9h,0d6h,0e9h,001h,000h,000h,031h,000h,000h,0feh,003h,0fdh,0a9h,001h,000h,000h	; a9fa  ......1.........
	defb 031h,080h,082h,000h,000h,031h,000h,000h,001h,000h,000h,031h,023h,000h,000h,031h	; aa0a  1....1.....1#..1
	defb 000h,000h,070h,070h,070h,070h,080h,080h,090h,090h,001h,000h,000h,031h,000h,000h	; aa1a  ..pppp.......1..
	defb 0feh,00fh,024h,0aah,001h,000h,000h,031h,000h,000h,0feh,00bh,02eh,0aah,030h,030h	; aa2a  ..$....1......00
	defb 030h,030h,041h,0efh,0c9h,0feh,0feh,0fbh,0a9h,0d6h,0f9h,013h,0e1h,030h,0e2h,0a0h	; aa3a  00A..........0..
	defb 030h,0e1h,010h,0e2h,080h,010h,0a0h,060h,030h,0e1h,030h,0e2h,0a0h,060h,010h,0a0h	; aa4a  0......`0.0..`..
	defb 080h,030h,030h,0feh,002h,046h,0aah,0e1h,010h,0e2h,080h,010h,0b0h,060h,0e3h,0b0h	; aa5a  .00..F.......`..
	defb 0e2h,080h,040h,010h,0e1h,010h,0e2h,080h,040h,0e3h,010h,0e2h,080h,060h,010h,010h	; aa6a  ..@.....@....`..
	defb 0feh,002h,061h,0aah,0e1h,030h,0e2h,0a0h,030h,0e1h,010h,0e2h,080h,010h,0a0h,060h	; aa7a  ..a..0..0......`
	defb 030h,0e1h,030h,0e2h,0a0h,060h,010h,0a0h,080h,030h,030h,0feh,002h,07eh,0aah,0ffh	; aa8a  0.0..`...00..~..

; ----------------------------------------------------------------------
; DATOS tira_AA9A: partitura de sonido (voz del sonido 0x60) que lee
;   pide_un_efecto; lo cargan 0x873A[95] (147 bytes)
;   0xaa9a..0xab2d  (147 bytes)
DATA_tira_AA9A:
	defb 0d6h,0f9h,013h,0c0h,0e1h,030h,0e2h,0a0h,030h,0e1h,010h,0e2h,080h,010h,0a0h,060h	; aa9a  .....0..0......`
	defb 030h,0e1h,030h,0e2h,0a0h,060h,010h,0a0h,080h,030h,030h,0e1h,0c0h,030h,0e2h,0a0h	; aaaa  0.0..`...00..0..
	defb 030h,0e1h,010h,0e2h,080h,010h,0a0h,060h,030h,0e1h,030h,0e2h,0a0h,060h,010h,0a0h	; aaba  0......`0.0..`..
	defb 080h,030h,0e1h,010h,0e2h,080h,010h,0b0h,060h,0e3h,0b0h,0e2h,080h,040h,010h,0e1h	; aaca  .0......`....@..
	defb 010h,0e2h,080h,040h,0e3h,010h,0e2h,080h,060h,010h,010h,0e1h,0c0h,010h,0e2h,080h	; aada  ...@....`.......
	defb 010h,0b0h,060h,0e3h,0b0h,0e2h,080h,040h,010h,0e1h,010h,0e2h,080h,040h,0e3h,010h	; aaea  ..`....@.....@..
	defb 0e2h,080h,060h,010h,0e1h,030h,0e2h,0a0h,030h,0e1h,010h,0e2h,080h,010h,0a0h,060h	; aafa  ..`..0..0......`
	defb 030h,0e1h,030h,0e2h,0a0h,060h,010h,0a0h,080h,030h,030h,0e1h,0c0h,030h,0e2h,0a0h	; ab0a  0.0..`...00..0..
	defb 030h,0e1h,010h,0e2h,080h,010h,0a0h,060h,030h,0e1h,030h,0e2h,0a0h,060h,010h,0a0h	; ab1a  0......`0.0..`..
	defb 080h,030h,0ffh	; ab2a

; ----------------------------------------------------------------------
; DATOS tira_AB2D: partitura de sonido (voz del sonido 0x61) que lee
;   pide_un_efecto; lo cargan 0x873A[96] (42 bytes)
;   0xab2d..0xab57  (42 bytes)
DATA_tira_AB2D:
	defb 0d6h,0fah,014h,0e3h,031h,031h,010h,030h,060h,080h,0feh,004h,030h,0abh,031h,010h	; ab2d  ....11.0`...0.1.
	defb 010h,0c0h,010h,0c0h,010h,010h,010h,0feh,004h,03ch,0abh,010h,010h,0e3h,031h,031h	; ab3d  .........<....11
	defb 010h,030h,060h,080h,0feh,004h,04ah,0abh,031h,0ffh	; ab4d  .0`...J.1.

; ----------------------------------------------------------------------
; DATOS tira_AB57: partitura de sonido (voz del sonido 0x62; voz del sonido
;   0x63; voz del sonido 0x64; voz del sonido 0x65; ...) que lee
;   pide_un_efecto; se entra por 0xAB57, 0xAB61, 0xAB9A, 0xABAF, 0xABE8,
;   0xABEA, 0xAC4E, 0xACDF, 0xAD68, 0xAE2A, 0xAE99, 0xAEE3, 0xAF56, 0xAF84,
;   0xAFB4, 0xB06E, 0xB08A, 0xB0AA, 0xB0C4, 0xB0E8, 0xB117, 0xB130; lo cargan
;   0x873A[100], 0x873A[101], 0x873A[102], 0x873A[103], 0x873A[104],
;   0x873A[105] y 16 sitios mas (1686 bytes)
;   0xab57..0xb1ed  (1686 bytes)
DATA_tira_AB57:
	defb 0d3h,0cfh,0c7h,0e9h,060h,060h,060h,060h,011h,011h,0efh,0d6h,0fch,033h,0e4h,000h	; ab57  ....````.....3..
	defb 000h,030h,000h,050h,000h,000h,070h,000h,000h,080h,000h,070h,050h,030h,020h,0feh	; ab67  .0.P..p....pP0 .
	defb 004h,066h,0abh,0fbh,033h,050h,050h,080h,050h,0a0h,050h,050h,0e3h,000h,0e4h,050h	; ab77  .f..3PP.P.PP...P
	defb 050h,0e3h,010h,0e4h,050h,0e3h,000h,0e4h,0a0h,080h,070h,0feh,004h,07ch,0abh,0feh	; ab87  P...P.....p..|..
	defb 0feh,066h,0abh,0d3h,0e9h,070h,070h,071h,071h,071h,060h,060h,061h,061h,061h,080h	; ab97  .f...ppqqq``aaa.
	defb 080h,081h,081h,081h,031h,041h,091h,091h,0efh,0d6h,0fbh,034h,0e3h,000h,000h,030h	; aba7  ....1A.....4...0
	defb 000h,050h,000h,000h,070h,000h,000h,080h,000h,070h,050h,030h,020h,0feh,004h,0b4h	; abb7  .P..p....pP0 ...
	defb 0abh,0fah,034h,050h,050h,080h,050h,0a0h,050h,050h,0e2h,000h,0e3h,050h,050h,0e2h	; abc7  ..4PP.P.PP...PP.
	defb 010h,0e3h,050h,0e2h,000h,0e3h,0a0h,080h,070h,0feh,004h,0cah,0abh,0feh,0feh,0b4h	; abd7  ..P.....p.......
	defb 0abh,0d6h,0cfh,0d6h,0e9h,000h,000h,000h,000h,040h,000h,000h,000h,0feh,003h,0ech	; abe7  .........@......
	defb 0abh,040h,000h,000h,000h,000h,000h,000h,000h,040h,000h,000h,000h,0feh,003h,0fch	; abf7  .@.......@......
	defb 0abh,040h,000h,000h,000h,060h,060h,060h,060h,0d3h,060h,060h,0d6h,060h,060h,060h	; ac07  .@...````.``.```
	defb 000h,000h,000h,000h,040h,000h,000h,000h,0feh,003h,017h,0ach,040h,000h,080h,081h	; ac17  ....@.......@...
	defb 000h,000h,000h,040h,000h,000h,000h,000h,000h,000h,000h,040h,000h,000h,000h,000h	; ac27  ...@.......@....
	defb 000h,000h,000h,040h,000h,000h,000h,040h,000h,000h,000h,070h,070h,070h,070h,050h	; ac37  ...@...@...ppppP
	defb 050h,060h,060h,0feh,0feh,0ech,0abh,0efh,0d5h,0f9h,022h,0e2h,097h,0b7h,0fah,023h	; ac47  P``......."....#
	defb 091h,071h,061h,041h,0fah,022h,063h,0fah,023h,023h,0f9h,022h,097h,0b7h,0fah,023h	; ac57  .qaA."c.##."...#
	defb 091h,071h,061h,041h,0fah,022h,024h,0c2h,0feh,002h,04eh,0ach,0fah,032h,0e2h,091h	; ac67  .qaA."$...N..2..
	defb 0c1h,091h,0c1h,0e1h,021h,0c1h,061h,0c1h,0fah,022h,097h,0fbh,032h,045h,0c1h,021h	; ac77  ....!.a.."..2E.!
	defb 0c1h,041h,0c1h,061h,0c1h,071h,0c1h,0fah,022h,067h,0fbh,032h,045h,0c1h,0feh,002h	; ac87  .A.a.q.."g.2E...
	defb 073h,0ach,0f9h,012h,0e1h,097h,0fah,022h,0b1h,091h,071h,061h,075h,0fah,022h,041h	; ac97  s......"..qau."A
	defb 0fah,012h,093h,073h,067h,0fah,022h,071h,061h,041h,021h,047h,0c0h,0f9h,000h,0e2h	; aca7  ...sg."qaA!G....
	defb 090h,0b0h,0e1h,010h,020h,040h,060h,070h,0f9h,012h,097h,0fah,022h,0b1h,091h,071h	; acb7  .... @`p...."..q
	defb 061h,075h,0fah,022h,041h,0fah,012h,093h,073h,067h,0fah,021h,071h,061h,041h,021h	; acc7  au."A...sg.!qaA!
	defb 04ah,0c0h,0e2h,093h,0feh,0feh,04eh,0ach,0efh,0d5h,0fah,033h,0e3h,021h,0c1h,021h	; acd7  J.....N....3.!.!
	defb 0c1h,073h,0c1h,093h,091h,093h,023h,023h,021h,0c1h,021h,0c1h,073h,0c1h,093h,091h	; ace7  .s....##!.!.s...
	defb 093h,023h,0c3h,0feh,002h,0dfh,0ach,0fah,032h,0e3h,021h,091h,0e2h,021h,0c1h,0e3h	; acf7  .#......2.!..!..
	defb 022h,020h,091h,0e2h,021h,0e4h,091h,0e3h,041h,0e2h,011h,0c1h,0e4h,092h,090h,0e3h	; ad07  " ..!...A.......
	defb 041h,0e2h,011h,0e4h,0b1h,0e3h,061h,0e2h,021h,0c1h,0e4h,0b2h,0b0h,0e3h,061h,0e2h	; ad17  A.....a.!.....a.
	defb 021h,0e4h,091h,0e3h,041h,0e2h,011h,0c1h,0e4h,092h,090h,0e3h,041h,0e2h,011h,0feh	; ad27  !...A.......A...
	defb 002h,0feh,0ach,0e3h,021h,021h,021h,021h,0e2h,065h,0e3h,021h,0e4h,091h,091h,091h	; ad37  ....!!!!.e.!....
	defb 091h,0e2h,015h,0e4h,091h,0e4h,0b1h,0b1h,0b1h,0b1h,0e2h,025h,0e4h,0b1h,091h,091h	; ad47  ...........%....
	defb 0e3h,091h,0e4h,091h,091h,091h,0e3h,091h,091h,0feh,002h,03ah,0adh,0feh,0feh,0dfh	; ad57  ...........:....
	defb 0ach,0efh,0d5h,0fah,022h,0e2h,061h,041h,061h,041h,073h,061h,043h,021h,041h,011h	; ad67  ....".aAaAsaC!A.
	defb 021h,0c1h,0eah,023h,0efh,0fah,022h,0e2h,061h,041h,061h,041h,073h,061h,043h,021h	; ad77  !..#..".aAaAsaC!
	defb 041h,011h,0e3h,091h,0eah,021h,023h,0feh,002h,068h,0adh,0ebh,033h,033h,033h,033h	; ad87  A....!#..h..3333
	defb 013h,013h,013h,013h,033h,033h,033h,033h,063h,063h,053h,053h,033h,033h,033h,033h	; ad97  ....3333ccSS3333
	defb 013h,013h,013h,013h,033h,033h,033h,033h,063h,063h,053h,053h,0efh,0d5h,0f8h,014h	; ada7  ....3333ccSS....
	defb 0e0h,020h,0c0h,020h,0c0h,020h,0c0h,020h,0c0h,020h,0c0h,020h,0c0h,020h,0c0h,020h	; adb7  . . . . . . . .
	defb 0c0h,090h,0c0h,090h,0c0h,090h,0c0h,090h,0c0h,040h,0c0h,040h,0c0h,040h,0c0h,040h	; adc7  .........@.@.@.@
	defb 0c0h,0e1h,0b0h,0c0h,0b0h,0c0h,0b0h,0c0h,0b0h,0c0h,0e0h,020h,0c0h,020h,0c0h,020h	; add7  ........... . .
	defb 0c0h,020h,0c0h,040h,0c0h,040h,0c0h,040h,0c0h,040h,0c0h,0f9h,000h,0e2h,090h,0b0h	; ade7  . .@.@.@.@......
	defb 0e1h,010h,020h,040h,060h,070h,080h,0fah,023h,0e2h,061h,061h,0e1h,021h,0e2h,061h	; adf7  .. @`p..#.aa.!.a
	defb 061h,0e1h,023h,091h,0e2h,041h,041h,0e1h,011h,0e2h,041h,041h,0e1h,013h,041h,0e2h	; ae07  a.#..AA...AA..A.
	defb 021h,021h,0b1h,021h,071h,0b3h,0e1h,071h,0e2h,091h,091h,0e1h,011h,095h,073h,0feh	; ae17  !!.!q..q......s.
	defb 0feh,068h,0adh,0efh,0dah,0eah,051h,001h,091h,001h,051h,000h,091h,090h,001h,0feh	; ae27  .h....Q...Q.....
	defb 002h,02dh,0aeh,031h,001h,091h,001h,031h,000h,091h,090h,001h,0feh,002h,03ah,0aeh	; ae37  .-.1...1......:.
	defb 051h,001h,091h,001h,051h,000h,091h,090h,001h,0feh,002h,047h,0aeh,031h,001h,091h	; ae47  Q...Q......G.1..
	defb 001h,031h,000h,091h,090h,001h,0feh,002h,054h,0aeh,051h,001h,071h,001h,051h,000h	; ae57  .1......T.Q.q.Q.
	defb 091h,090h,001h,0feh,002h,061h,0aeh,031h,001h,071h,001h,031h,000h,091h,090h,001h	; ae67  .....a.1.q.1....
	defb 0feh,002h,06eh,0aeh,051h,001h,091h,001h,051h,000h,091h,090h,001h,0feh,002h,07bh	; ae77  ..n.Q...Q......{
	defb 0aeh,031h,001h,071h,001h,031h,000h,071h,070h,001h,0feh,002h,088h,0aeh,0feh,0feh	; ae87  .1.q.1.qp.......
	defb 047h,0aeh,0efh,0dah,0f9h,004h,0e3h,0cfh,0cfh,0cfh,0cfh,055h,000h,000h,0c9h,0a0h	; ae97  G..........U....
	defb 090h,0a0h,090h,0c5h,0e4h,0a0h,090h,0a0h,090h,0e3h,035h,0e3h,0a0h,0a0h,0cfh,0c1h	; aea7  ..........5.....
	defb 0d5h,0b0h,0e2h,004h,0e3h,080h,094h,0dah,055h,000h,000h,0cfh,0c7h,0e3h,035h,0e4h	; aeb7  ........U.....5.
	defb 0a0h,0a0h,0cfh,0a0h,0e3h,000h,020h,030h,050h,0c0h,070h,0a0h,095h,050h,050h,0cfh	; aec7  ...... 0P.p..PP.
	defb 0c7h,075h,030h,030h,0cfh,0c5h,020h,030h,0feh,0feh,0a2h,0aeh,0efh,0dah,0f0h,000h	; aed7  .u00.. 0........
	defb 0e0h,0c0h,0eah,051h,001h,091h,001h,051h,000h,091h,090h,001h,0feh,002h,0eah,0aeh	; aee7  ...Q...Q........
	defb 031h,001h,091h,001h,031h,000h,091h,090h,001h,0feh,002h,0f7h,0aeh,051h,001h,091h	; aef7  1...1........Q..
	defb 001h,051h,000h,091h,090h,001h,0feh,002h,004h,0afh,031h,001h,091h,001h,031h,000h	; af07  .Q........1...1.
	defb 091h,090h,001h,0feh,002h,011h,0afh,051h,001h,091h,001h,051h,000h,091h,090h,001h	; af17  .......Q...Q....
	defb 0feh,002h,01eh,0afh,031h,001h,091h,001h,031h,000h,091h,090h,001h,0feh,002h,02bh	; af27  ....1...1......+
	defb 0afh,051h,001h,091h,001h,051h,000h,091h,090h,001h,0feh,002h,038h,0afh,031h,001h	; af37  .Q...Q......8.1.
	defb 071h,001h,031h,000h,071h,070h,001h,0feh,002h,045h,0afh,0feh,0feh,004h,0afh,0efh	; af47  q.1.qp...E......
	defb 0d9h,0f9h,013h,0e3h,071h,0c3h,0b1h,0e2h,020h,021h,021h,020h,041h,0e3h,071h,0c9h	; af57  ....q... !! A.q.
	defb 0e2h,0a0h,0b0h,0a0h,0b0h,0feh,002h,05ah,0afh,0e2h,001h,0c3h,041h,070h,071h,071h	; af67  .......Z....Apqq
	defb 070h,091h,001h,0c9h,0e1h,030h,040h,030h,040h,0feh,0feh,05ah,0afh,0efh,0d9h,0f9h	; af77  p....0@0@..Z....
	defb 013h,0e4h,071h,0c3h,0b1h,0e3h,020h,021h,021h,020h,041h,0e4h,071h,0c9h,0e3h,060h	; af87  ..q... !! A.q..`
	defb 070h,060h,070h,0feh,002h,088h,0afh,0e3h,001h,0c3h,041h,070h,071h,071h,070h,091h	; af97  p`p.......Apqqp.
	defb 001h,0c9h,0b0h,0e2h,000h,0e3h,0b0h,0e2h,000h,0feh,0feh,088h,0afh,0feh,000h,021h	; afa7  ...............!
	defb 001h,012h,080h,000h,030h,000h,080h,000h,030h,000h,090h,000h,030h,000h,090h,000h	; afb7  ....0...0...0...
	defb 030h,000h,090h,000h,030h,000h,0a0h,000h,030h,000h,0a0h,000h,030h,000h,0a0h,000h	; afc7  0...0...0...0...
	defb 030h,000h,0b0h,000h,030h,000h,0b0h,000h,030h,000h,0b0h,000h,030h,000h,0a0h,000h	; afd7  0...0...0...0...
	defb 030h,000h,0a0h,000h,030h,000h,090h,000h,030h,000h,080h,000h,030h,000h,020h,008h	; afe7  0...0...0...0. .
	defb 021h,001h,010h,0d0h,000h,020h,010h,021h,001h,010h,0d0h,000h,020h,010h,0feh,003h	; aff7  !.... .!.... ...
	defb 0b6h,0afh,021h,001h,012h,080h,000h,030h,000h,080h,000h,030h,000h,090h,000h,030h	; b007  ..!....0...0...0
	defb 000h,090h,000h,030h,000h,090h,000h,030h,000h,0a0h,000h,030h,000h,0a0h,000h,030h	; b017  ...0...0...0...0
	defb 000h,0a0h,000h,030h,000h,0b0h,000h,030h,000h,0b0h,000h,030h,000h,0b0h,000h,030h	; b027  ...0...0...0...0
	defb 000h,0a0h,000h,030h,000h,0a0h,000h,030h,000h,090h,000h,030h,000h,080h,000h,030h	; b037  ...0...0...0...0
	defb 000h,020h,004h,02ah,001h,001h,000h,091h,0a0h,022h,003h,091h,0a0h,0a1h,09ah,0a1h	; b047  . .*....."......
	defb 095h,0b1h,090h,0b1h,095h,0c1h,09ah,0b1h,0a0h,0b1h,0a5h,0a1h,0aah,0a1h,0b0h,091h	; b057  ................
	defb 0b5h,020h,004h,0feh,0feh,0b6h,0afh,0e8h,0d7h,0fah,042h,0e2h,001h,040h,0c2h,040h	; b067  . ........B..@.@
	defb 0c4h,050h,0c3h,076h,0fbh,042h,001h,000h,0c2h,000h,0c4h,0e3h,090h,0c3h,0b6h,0feh	; b077  .P.v.B..........
	defb 0feh,072h,0b0h,0efh,0d7h,0fch,042h,0e3h,001h,000h,0e4h,0b2h,092h,072h,052h,042h	; b087  .r....B......rRB
	defb 021h,072h,070h,0e3h,001h,000h,0e4h,0b2h,092h,072h,052h,042h,021h,072h,070h,0feh	; b097  !rp......rRB!rp.
	defb 0feh,08eh,0b0h,0efh,0d7h,0fah,032h,0e1h,001h,040h,0c2h,040h,0c4h,050h,0c3h,076h	; b0a7  ......2..@.@.P.v
	defb 001h,0e2h,040h,0c2h,040h,0c4h,050h,0c3h,076h,0feh,0feh,0aeh,0b0h,0d9h,0eah,051h	; b0b7  ..@.@.P.v......Q
	defb 001h,091h,001h,051h,000h,091h,090h,001h,031h,001h,091h,001h,031h,000h,091h,090h	; b0c7  ...Q....1...1...
	defb 001h,021h,0ebh,091h,0eah,051h,0ebh,091h,0eah,021h,051h,0a1h,0ebh,020h,020h,024h	; b0d7  .!...Q...!Q..  $
	defb 0ffh,0d9h,0f8h,012h,0e1h,051h,0e0h,001h,0e1h,001h,0e0h,001h,0e1h,051h,0e0h,000h	; b0e7  .....Q.......Q..
	defb 0e1h,001h,000h,0e0h,001h,0e1h,031h,0e0h,001h,0e1h,001h,0e0h,001h,0e1h,031h,0e0h	; b0f7  ......1.......1.
	defb 000h,0e1h,001h,000h,000h,010h,021h,0a1h,051h,0a1h,021h,051h,0a1h,0e0h,022h,0ffh	; b107  ......!.Q.!Q..".
	defb 0d9h,0f8h,012h,0e2h,055h,003h,001h,093h,091h,033h,003h,001h,091h,091h,0a1h,051h	; b117  ....U....3.....Q
	defb 021h,051h,0e3h,0a1h,0e2h,021h,051h,0a2h,0ffh,0feh,000h,020h,06ah,022h,001h,0c0h	; b127  !Q...!Q.... j"..
	defb 08dh,0d1h,01ah,0c0h,08ah,0d1h,014h,0c0h,0dah,0c0h,06ch,0d0h,0dah,0c0h,080h,0c0h	; b137  ..........l.....
	defb 070h,0d0h,0e0h,0feh,003h,046h,0b1h,020h,008h,022h,001h,0a0h,070h,0a0h,0e0h,0a0h	; b147  p....F. ."..p...
	defb 070h,0a0h,0e0h,020h,009h,022h,001h,080h,070h,080h,0e0h,080h,070h,080h,0e0h,020h	; b157  p.. ."..p...p..
	defb 00ah,022h,001h,060h,070h,060h,0e0h,060h,070h,060h,0e0h,020h,01ah,022h,001h,0a1h	; b167  .".`p`.`p`. ."..
	defb 020h,0c0h,048h,0d0h,090h,0c0h,048h,0d0h,090h,0c0h,04bh,0d0h,096h,0c0h,04bh,0d0h	; b177   .H...H...K...K.
	defb 096h,020h,008h,022h,001h,0a0h,04bh,0a0h,096h,0a0h,04bh,0a0h,096h,020h,009h,022h	; b187  . ."..K...K.. ."
	defb 001h,080h,04bh,080h,096h,080h,04bh,080h,096h,020h,00ah,022h,001h,060h,04bh,060h	; b197  ..K...K.. .".`K`
	defb 096h,060h,04bh,060h,096h,020h,030h,022h,001h,0c0h,070h,0d0h,0e0h,0c0h,071h,0d0h	; b1a7  .`K`. 0"..p...q.
	defb 0e2h,0feh,005h,0b0h,0b1h,0c0h,077h,0d0h,0eeh,0c0h,07ch,0d0h,0f0h,0c0h,081h,0d0h	; b1b7  ......w...|.....
	defb 0fah,0c0h,085h,0d1h,002h,0b0h,070h,0c0h,0e0h,0b0h,071h,0c0h,0e2h,0feh,005h,0cch	; b1c7  ......p...q.....
	defb 0b1h,0b0h,077h,0c0h,0eeh,0b0h,07ch,0c0h,0f0h,0b0h,081h,0c0h,0fah,0b0h,085h,0c1h	; b1d7  ..w...|.........
	defb 002h,0b0h,08ah,0c1h,014h,0ffh	; b1e7

; ----------------------------------------------------------------------
; DATOS tira_B1ED: partitura de sonido (voz del sonido 0x7B) que lee
;   pide_un_efecto; lo cargan 0x873A[122] (128 bytes)
;   0xb1ed..0xb26d  (128 bytes)
DATA_tira_B1ED:
	defb 0feh,000h,023h,001h,01fh,0b7h,000h,000h,000h,0b8h,000h,000h,000h,0bfh,000h,000h	; b1ed  ..#.............
	defb 000h,0bch,000h,020h,002h,023h,001h,0b6h,000h,000h,000h,0bbh,000h,000h,000h,0b9h	; b1fd  ... .#..........
	defb 000h,000h,000h,0beh,000h,000h,000h,020h,002h,023h,001h,0bch,000h,000h,000h,0b6h	; b20d  ....... .#......
	defb 000h,000h,000h,0feh,004h,0f2h,0b1h,020h,030h,022h,001h,0b7h,000h,000h,000h,0b8h	; b21d  ....... 0"......
	defb 000h,000h,000h,0bfh,000h,000h,000h,0bch,000h,000h,000h,0b6h,000h,000h,000h,0bbh	; b22d  ................
	defb 000h,000h,000h,0b9h,000h,000h,000h,0beh,000h,000h,000h,0bch,000h,000h,000h,0b6h	; b23d  ................
	defb 000h,000h,000h,0feh,007h,028h,0b2h,0cah,000h,000h,000h,0ceh,000h,000h,000h,0c9h	; b24d  .....(..........
	defb 000h,000h,000h,0cdh,000h,000h,000h,0cfh,000h,000h,000h,0feh,00ah,054h,0b2h,0ffh	; b25d  .............T..

; ----------------------------------------------------------------------
; DATOS tira_B26D: partitura de sonido (voz del sonido 0x7C) que lee
;   pide_un_efecto; lo cargan 0x873A[123] (57 bytes)
;   0xb26d..0xb2a6  (57 bytes)
DATA_tira_B26D:
	defb 0feh,000h,020h,06ah,022h,001h,000h,000h,0bfh,000h,000h,000h,0bch,000h,000h,000h	; b26d  .. j"...........
	defb 0b7h,000h,000h,000h,0b9h,000h,020h,002h,022h,001h,0bfh,000h,000h,000h,0b7h,000h	; b27d  ...... .".......
	defb 000h,000h,0beh,000h,000h,000h,0b8h,000h,000h,000h,020h,002h,022h,001h,0b8h,000h	; b28d  .......... ."...
	defb 000h,000h,0bdh,000h,0feh,004h,073h,0b2h,0ffh	; b29d  ......s..

; ----------------------------------------------------------------------
; DATOS tira_B2A6: partitura de sonido (voz del sonido 0x89) que lee
;   pide_un_efecto; lo cargan 0x873A[136] (33 bytes)
;   0xb2a6..0xb2c7  (33 bytes)
DATA_tira_B2A6:
	defb 0feh,000h,022h,001h,0a0h,030h,080h,030h,060h,030h,020h,004h,0feh,016h,0a8h,0b2h	; b2a6  .."..0.0`0 .....
	defb 020h,015h,022h,001h,0a0h,030h,080h,030h,060h,030h,020h,004h,0feh,014h,0b8h,0b2h	; b2b6   ."..0.0`0 .....
	defb 0ffh	; b2c6

; ----------------------------------------------------------------------
; DATOS tira_B2C7: partitura de sonido (voz del sonido 0x8A) que lee
;   pide_un_efecto; lo cargan 0x873A[137] (63 bytes)
;   0xb2c7..0xb306  (63 bytes)
DATA_tira_B2C7:
	defb 0feh,000h,021h,001h,014h,070h,000h,01ah,050h,000h,01fh,030h,000h,020h,004h,0feh	; b2c7  ..!..p..P..0. ..
	defb 016h,0c9h,0b2h,022h,002h,0d0h,07fh,0b0h,070h,0b0h,077h,0a0h,062h,090h,050h,080h	; b2d7  ..."....p.w.b.P.
	defb 043h,020h,003h,022h,001h,070h,043h,020h,004h,022h,001h,060h,043h,021h,001h,014h	; b2e7  C .".pC .".`C!..
	defb 070h,000h,01ah,050h,000h,01fh,030h,000h,020h,004h,0feh,014h,0f4h,0b2h,0ffh	; b2f7  p..P..0. ......

; ----------------------------------------------------------------------
; DATOS tira_B306: partitura de sonido (voz del sonido 0x8C) que lee
;   pide_un_efecto; lo cargan 0x873A[139] (33 bytes)
;   0xb306..0xb327  (33 bytes)
DATA_tira_B306:
	defb 0feh,000h,022h,001h,0e3h,000h,0d3h,0a0h,0c4h,050h,0e5h,000h,0e4h,080h,0d4h,000h	; b306  .."......P......
	defb 0d3h,080h,0d3h,000h,0d2h,0a0h,0d2h,050h,0d2h,000h,0d1h,0c0h,0d1h,090h,0c2h,000h	; b316  .......P........
	defb 0ffh	; b326

; ----------------------------------------------------------------------
; DATOS tira_B327: partitura de sonido (voz del sonido 0x8D) que lee
;   pide_un_efecto; lo cargan 0x873A[140] (25 bytes)
;   0xb327..0xb340  (25 bytes)
DATA_tira_B327:
	defb 0feh,000h,020h,002h,022h,001h,0d0h,020h,0d0h,021h,0d0h,022h,0c0h,023h,0c0h,024h	; b327  .. .".. .!.".#.$
	defb 0c0h,025h,0c0h,026h,0c0h,027h,0c0h,028h,0ffh	; b337  .%.&.'.(.

; ----------------------------------------------------------------------
; DATOS tira_B340: partitura de sonido (voz del sonido 0x8F) que lee
;   pide_un_efecto; lo cargan 0x873A[142] (13 bytes)
;   0xb340..0xb34d  (13 bytes)
DATA_tira_B340:
	defb 0feh,000h,022h,001h,0d3h,000h,020h,002h,022h,001h,0e2h,000h,0ffh	; b340  .."... ."....

; ----------------------------------------------------------------------
; DATOS tira_B34D: partitura de sonido (voz del sonido 0x90) que lee
;   pide_un_efecto; lo cargan 0x873A[143] (13 bytes)
;   0xb34d..0xb35a  (13 bytes)
DATA_tira_B34D:
	defb 0feh,000h,022h,001h,0d4h,000h,020h,002h,022h,001h,0e3h,000h,0ffh	; b34d  .."... ."....

; ----------------------------------------------------------------------
; DATOS tira_B35A: partitura de sonido (voz del sonido 0x91) que lee
;   pide_un_efecto; lo cargan 0x873A[144] (39 bytes)
;   0xb35a..0xb381  (39 bytes)
DATA_tira_B35A:
	defb 0feh,000h,020h,00dh,022h,001h,0b4h,000h,020h,002h,022h,001h,0c3h,000h,020h,009h	; b35a  .. ."... ."... .
	defb 022h,001h,094h,000h,020h,002h,022h,001h,0a3h,000h,020h,009h,022h,001h,074h,000h	; b36a  "... ."... .".t.
	defb 020h,002h,022h,001h,083h,000h,0ffh	; b37a

; ----------------------------------------------------------------------
; DATOS tira_B381: partitura de sonido (voz del sonido 0x9B) que lee
;   pide_un_efecto; lo cargan 0x873A[154] (35 bytes)
;   0xb381..0xb3a4  (35 bytes)
DATA_tira_B381:
	defb 0feh,000h,020h,003h,022h,004h,0c0h,06ah,0d0h,06ah,0c0h,06bh,0b0h,06ah,0a0h,06bh	; b381  .. ."..j.j.k.j.k
	defb 090h,06ah,080h,06bh,070h,06ah,060h,06bh,050h,06ah,050h,06bh,050h,06ah,050h,06bh	; b391  .j.kpj`kPjPkPjPk
	defb 020h,01ah,0ffh	; b3a1

; ----------------------------------------------------------------------
; DATOS tira_B3A4: partitura de sonido (voz del sonido 0x9C) que lee
;   pide_un_efecto; lo cargan 0x873A[155] (29 bytes)
;   0xb3a4..0xb3c1  (29 bytes)
DATA_tira_B3A4:
	defb 0feh,000h,020h,00bh,022h,004h,0c0h,054h,0b0h,055h,0b0h,054h,0a0h,055h,0a0h,054h	; b3a4  .. ."..T.U.T.U.T
	defb 090h,055h,090h,054h,080h,055h,080h,054h,070h,055h,060h,054h,0ffh	; b3b4  .U.T.U.TpU`T.

; ----------------------------------------------------------------------
; DATOS tira_B3C1: partitura de sonido (voz del sonido 0x9D) que lee
;   pide_un_efecto; lo cargan 0x873A[156] (29 bytes)
;   0xb3c1..0xb3de  (29 bytes)
DATA_tira_B3C1:
	defb 0feh,000h,020h,012h,022h,004h,0c0h,047h,0b0h,048h,0b0h,047h,0a0h,048h,0a0h,047h	; b3c1  .. ."..G.H.G.H.G
	defb 090h,048h,090h,047h,080h,048h,080h,047h,070h,048h,060h,047h,0ffh	; b3d1  .H.G.H.GpH`G.

; ----------------------------------------------------------------------
; DATOS tira_B3DE: partitura de sonido (voz del sonido 0x9E) que lee
;   pide_un_efecto; lo cargan 0x873A[157] (35 bytes)
;   0xb3de..0xb401  (35 bytes)
DATA_tira_B3DE:
	defb 0feh,000h,020h,004h,022h,004h,0e4h,076h,0d4h,086h,0c4h,076h,0b4h,086h,0a4h,086h	; b3de  .. ."..v...v....
	defb 094h,076h,084h,086h,074h,076h,064h,086h,054h,076h,054h,086h,054h,076h,054h,086h	; b3ee  .v..tvd.TvT.TvT.
	defb 020h,025h,0ffh	; b3fe

; ----------------------------------------------------------------------
; DATOS tira_B401: partitura de sonido (voz del sonido 0x9F) que lee
;   pide_un_efecto; lo cargan 0x873A[158] (29 bytes)
;   0xb401..0xb41e  (29 bytes)
DATA_tira_B401:
	defb 0feh,000h,020h,00bh,022h,004h,0c5h,04eh,0b5h,05eh,0b5h,04eh,0a5h,05eh,0a5h,04eh	; b401  .. ."..N.^.N.^.N
	defb 095h,05eh,095h,04eh,085h,05eh,085h,04eh,075h,05eh,065h,04eh,0ffh	; b411  .^.N.^.Nu^eN.

; ----------------------------------------------------------------------
; DATOS tira_B41E: partitura de sonido (voz del sonido 0xA0) que lee
;   pide_un_efecto; lo cargan 0x873A[159] (29 bytes)
;   0xb41e..0xb43b  (29 bytes)
DATA_tira_B41E:
	defb 0feh,000h,020h,012h,022h,004h,0c6h,0aeh,0b6h,0beh,0b6h,0aeh,0a6h,0beh,0a6h,0aeh	; b41e  .. ."...........
	defb 096h,0beh,096h,0aeh,086h,0beh,086h,0aeh,076h,0beh,066h,0aeh,0ffh	; b42e  ........v.f..

; ----------------------------------------------------------------------
; DATOS tira_B43B: partitura de sonido (voz del sonido 0xAA) que lee
;   pide_un_efecto; lo cargan 0x873A[169] (63 bytes)
;   0xb43b..0xb47a  (63 bytes)
DATA_tira_B43B:
	defb 0feh,000h,020h,004h,022h,001h,0b0h,030h,0c0h,030h,0d0h,030h,0e0h,030h,0e0h,020h	; b43b  .. ."..0.0.0.0.
	defb 0e0h,020h,0c0h,020h,0b0h,020h,020h,004h,022h,002h,0a0h,020h,090h,020h,020h,003h	; b44b  . . .  .".. .  .
	defb 022h,002h,090h,020h,080h,020h,020h,003h,022h,003h,080h,020h,070h,020h,020h,003h	; b45b  ".. .  .".. p  .
	defb 022h,003h,070h,020h,060h,020h,020h,003h,022h,002h,060h,020h,050h,020h,0ffh	; b46b  ".p `  .".` P .

; ----------------------------------------------------------------------
; DATOS tira_B47A: partitura de sonido (voz del sonido 0xAB) que lee
;   pide_un_efecto; lo cargan 0x873A[170] (61 bytes)
;   0xb47a..0xb4b7  (61 bytes)
DATA_tira_B47A:
	defb 0feh,000h,022h,001h,0b0h,040h,0c0h,040h,0d0h,040h,0e0h,040h,0e0h,010h,0d0h,010h	; b47a  .."..@.@.@.@....
	defb 0c0h,010h,0b0h,010h,020h,004h,022h,002h,0a0h,010h,090h,010h,020h,003h,022h,002h	; b48a  .... ."..... .".
	defb 090h,010h,080h,010h,020h,003h,022h,003h,080h,010h,070h,010h,020h,003h,022h,003h	; b49a  .... ."...p. .".
	defb 070h,010h,060h,010h,020h,003h,022h,002h,060h,010h,050h,010h,0ffh	; b4aa  p.`. .".`.P..

; ----------------------------------------------------------------------
; DATOS tira_B4B7: partitura de sonido (voz del sonido 0xA3) que lee
;   pide_un_efecto; lo cargan 0x873A[162] (41 bytes)
;   0xb4b7..0xb4e0  (41 bytes)
DATA_tira_B4B7:
	defb 0feh,000h,020h,014h,022h,002h,0a0h,017h,0a0h,018h,0a0h,019h,0a0h,01ah,0a0h,01bh	; b4b7  .. ."...........
	defb 0a0h,01ch,0a0h,01dh,0a0h,02bh,0a0h,02ah,022h,003h,0a0h,029h,0a0h,028h,0a0h,027h	; b4c7  .....+.*"..).(.'
	defb 022h,001h,0a0h,026h,0a0h,025h,0a0h,024h,0ffh	; b4d7  "..&.%.$.

; ----------------------------------------------------------------------
; DATOS tira_B4E0: partitura de sonido (voz del sonido 0xA4) que lee
;   pide_un_efecto; lo cargan 0x873A[163] (65 bytes)
;   0xb4e0..0xb521  (65 bytes)
DATA_tira_B4E0:
	defb 0feh,000h,020h,025h,02ah,003h,003h,045h,090h,06ah,022h,001h,0f0h,047h,0e0h,04ah	; b4e0  .. %*..E.j"..G.J
	defb 0d0h,047h,0c0h,04ah,0b0h,049h,0a0h,04ah,090h,04bh,080h,04ch,070h,04dh,020h,017h	; b4f0  .G.J.I.J.K.LpM .
	defb 022h,001h,0d0h,06ah,0c0h,065h,0b0h,060h,0a0h,05bh,0d0h,054h,0c0h,05ch,0b0h,064h	; b500  "..j.e.`.[.T.\.d
	defb 0a0h,06ch,090h,074h,0d0h,048h,0d0h,040h,0c0h,038h,0c0h,030h,0b0h,028h,0b0h,020h	; b510  .l.t.H.@.8.0.(.
	defb 0ffh	; b520

; ----------------------------------------------------------------------
; DATOS tira_B521: partitura de sonido (voz del sonido 0xA5) que lee
;   pide_un_efecto; lo cargan 0x873A[164] (49 bytes)
;   0xb521..0xb552  (49 bytes)
DATA_tira_B521:
	defb 0feh,000h,020h,025h,022h,003h,0d0h,0d5h,02ah,010h,003h,022h,090h,08eh,020h,011h	; b521  .. %"...*..".. .
	defb 022h,001h,0d0h,06ah,0c0h,065h,0b0h,060h,0a0h,05bh,0d0h,054h,0c0h,05ch,0b0h,064h	; b531  "..j.e.`.[.T.\.d
	defb 0a0h,06ch,090h,074h,0d0h,048h,0d0h,040h,0c0h,038h,0c0h,030h,0b0h,028h,0b0h,020h	; b541  .l.t.H.@.8.0.(.
	defb 0ffh	; b551

; ----------------------------------------------------------------------
; DATOS tira_B552: partitura de sonido (voz del sonido 0x92) que lee
;   pide_un_efecto; lo cargan 0x873A[145] (23 bytes)
;   0xb552..0xb569  (23 bytes)
DATA_tira_B552:
	defb 0feh,000h,022h,005h,0a1h,002h,0b1h,012h,0c1h,022h,022h,006h,0b1h,032h,0a1h,042h	; b552  .."......""..2.B
	defb 091h,052h,081h,062h,081h,072h,0ffh	; b562

; ----------------------------------------------------------------------
; DATOS tira_B569: partitura de sonido (voz del sonido 0x93) que lee
;   pide_un_efecto; lo cargan 0x873A[146] (23 bytes)
;   0xb569..0xb580  (23 bytes)
DATA_tira_B569:
	defb 0feh,000h,022h,005h,0a1h,000h,0b1h,010h,0c1h,020h,022h,006h,0b1h,030h,0a1h,040h	; b569  .."...... "..0.@
	defb 091h,050h,081h,060h,081h,06ah,0ffh	; b579

; ----------------------------------------------------------------------
; DATOS tira_B580: partitura de sonido (voz del sonido 0x95) que lee
;   pide_un_efecto; lo cargan 0x873A[148] (43 bytes)
;   0xb580..0xb5ab  (43 bytes)
DATA_tira_B580:
	defb 0feh,000h,020h,018h,022h,002h,091h,0c4h,091h,0a4h,091h,083h,0a1h,062h,0b1h,052h	; b580  .. ."........b.R
	defb 091h,0a4h,0a1h,083h,0a1h,062h,0a1h,042h,0b1h,032h,0a1h,083h,0a1h,062h,091h,042h	; b590  .....b.B.2...b.B
	defb 091h,022h,081h,012h,022h,001h,081h,00ah,081h,002h,0ffh	; b5a0  .".."......

; ----------------------------------------------------------------------
; DATOS tira_B5AB: partitura de sonido (voz del sonido 0x96) que lee
;   pide_un_efecto; lo cargan 0x873A[149] (43 bytes)
;   0xb5ab..0xb5d6  (43 bytes)
DATA_tira_B5AB:
	defb 0feh,000h,020h,017h,022h,002h,091h,0c0h,091h,0a0h,0a1h,080h,0a1h,060h,0b1h,050h	; b5ab  .. ."........`.P
	defb 091h,0a0h,0a1h,080h,0a1h,060h,0a1h,040h,0b1h,030h,0a1h,080h,0a1h,060h,091h,040h	; b5bb  .....`.@.0...`.@
	defb 091h,020h,091h,010h,022h,001h,091h,008h,081h,000h,0ffh	; b5cb  . .."......

; ----------------------------------------------------------------------
; DATOS tira_B5D6: partitura de sonido (voz del sonido 0x98; voz del sonido
;   0xAD) que lee pide_un_efecto; se entra por 0xB5D6, 0xB604; lo cargan
;   0x873A[151], 0x873A[172] (133 bytes)
;   0xb5d6..0xb65b  (133 bytes)
DATA_tira_B5D6:
	defb 0feh,000h,021h,004h,019h,070h,000h,021h,002h,01ah,060h,000h,01bh,060h,000h,01ch	; b5d6  ..!..p.!..`..`..
	defb 050h,000h,01dh,050h,000h,01eh,050h,000h,01fh,050h,000h,01eh,060h,000h,01dh,060h	; b5e6  P..P..P..P..`..`
	defb 000h,01ch,060h,000h,01bh,060h,000h,01ah,070h,000h,0feh,0feh,0d8h,0b5h,0efh,0d8h	; b5f6  ..`..`..p.......
	defb 0eah,051h,001h,091h,001h,051h,000h,091h,090h,001h,0feh,002h,007h,0b6h,051h,001h	; b606  .Q...Q........Q.
	defb 091h,001h,0d1h,050h,060h,070h,080h,0feh,000h,022h,006h,090h,01fh,022h,001h,080h	; b616  ...P`p..."..."..
	defb 020h,080h,021h,070h,022h,070h,023h,060h,025h,060h,027h,050h,02ah,050h,02dh,090h	; b626   .!p"p#`%`'P*P-.
	defb 031h,0feh,000h,0d1h,0eah,005h,0c0h,050h,060h,070h,080h,090h,0a0h,0b0h,0ebh,0b7h	; b636  1......P`p......
	defb 0eah,040h,030h,020h,0feh,000h,022h,001h,090h,032h,0feh,000h,0d1h,0eah,000h,0c0h	; b646  .@0 .."..2......
	defb 010h,0ebh,080h,070h,0ffh	; b656

; ----------------------------------------------------------------------
; DATOS tira_B65B: partitura de sonido (voz del sonido 0xAE) que lee
;   pide_un_efecto; lo cargan 0x873A[173] (32 bytes)
;   0xb65b..0xb67b  (32 bytes)
DATA_tira_B65B:
	defb 0efh,0d8h,0f0h,000h,0e0h,0c0h,0eah,051h,001h,091h,001h,051h,000h,091h,090h,001h	; b65b  .......Q...Q....
	defb 051h,001h,091h,001h,051h,000h,091h,0efh,0d8h,0fbh,022h,0e3h,000h,020h,03eh,0ffh	; b66b  Q...Q.....".. >.

; ----------------------------------------------------------------------
; DATOS tira_B67B: partitura de sonido (voz del sonido 0xAF) que lee
;   pide_un_efecto; lo cargan 0x873A[174] (35 bytes)
;   0xb67b..0xb69e  (35 bytes)
DATA_tira_B67B:
	defb 0efh,0d8h,0fch,000h,0e3h,0c7h,0c7h,0d4h,0e9h,070h,070h,071h,071h,071h,060h,060h	; b67b  .........ppqqq``
	defb 061h,061h,061h,080h,080h,081h,081h,081h,091h,091h,0efh,0d8h,0fbh,022h,0e4h,000h	; b68b  aaa.........."..
	defb 020h,03eh,0ffh	; b69b

; ----------------------------------------------------------------------
; DATOS tira_B69E: partitura de sonido (voz del sonido 0xB0) que lee
;   pide_un_efecto; lo cargan 0x873A[175] (81 bytes)
;   0xb69e..0xb6ef  (81 bytes)
DATA_tira_B69E:
	defb 0efh,0d8h,0fbh,022h,0c1h,0e2h,031h,0c0h,031h,0c0h,051h,0c0h,051h,0c0h,031h,0c0h	; b69e  ..."..1.1.Q.Q.1.
	defb 031h,0c0h,021h,0c0h,021h,0c0h,0d4h,0f7h,000h,0e3h,080h,090h,0a0h,0e2h,000h,020h	; b6ae  1.!.!..........
	defb 0f8h,000h,030h,050h,070h,080h,0a0h,0e1h,000h,0f9h,000h,020h,030h,050h,070h,080h	; b6be  ..0Pp...... 0Pp.
	defb 0a0h,0fah,000h,0e0h,000h,020h,030h,050h,070h,080h,0a0h,0d8h,0fbh,022h,0e1h,070h	; b6ce  ..... 0Pp....".p
	defb 050h,040h,0c0h,070h,050h,042h,0d1h,0fah,000h,0c0h,0e1h,070h,080h,090h,0a0h,0b0h	; b6de  P@.pPB.....p....
	defb 0ffh	; b6ee

; ----------------------------------------------------------------------
; DATOS tira_B6EF: partitura de sonido (voz del sonido 0xB1) que lee
;   pide_un_efecto; lo cargan 0x873A[176] (27 bytes)
;   0xb6ef..0xb70a  (27 bytes)
DATA_tira_B6EF:
	defb 0efh,0d8h,0fbh,033h,0e3h,0c0h,000h,051h,000h,051h,000h,071h,000h,071h,0feh,003h	; b6ef  ...3...Q.Q.q.q..
	defb 0f5h,0b6h,000h,000h,000h,000h,0c0h,000h,000h,002h,0ffh	; b6ff  ...........

; ----------------------------------------------------------------------
; DATOS tira_B70A: partitura de sonido (voz del sonido 0xB2) que lee
;   pide_un_efecto; lo cargan 0x873A[177] (81 bytes)
;   0xb70a..0xb75b  (81 bytes)
DATA_tira_B70A:
	defb 0efh,0d8h,0fbh,022h,0c1h,0e3h,081h,0c0h,081h,0c0h,0a1h,0c0h,0a1h,0c0h,081h,0c0h	; b70a  ..."............
	defb 081h,0c0h,0a1h,0c0h,0a1h,0c0h,0d4h,0f7h,000h,0c0h,0e3h,080h,090h,0a0h,0e2h,000h	; b71a  ................
	defb 020h,0f8h,000h,030h,050h,070h,080h,0a0h,0e1h,000h,0f9h,000h,020h,030h,050h,070h	; b72a   ..0Pp...... 0Pp
	defb 080h,0a0h,0fah,000h,0e0h,000h,020h,030h,050h,070h,080h,0d8h,0eah,000h,040h,070h	; b73a  ...... 0Pp....@p
	defb 0feh,003h,047h,0b7h,0efh,0d1h,0fah,000h,0e1h,070h,080h,090h,0a0h,0b0h,0e0h,002h	; b74a  ..G......p......
	defb 0ffh	; b75a

; ----------------------------------------------------------------------
; DATOS tira_B75B: partitura de sonido (voz del sonido 0xB3) que lee
;   pide_un_efecto; lo cargan 0x873A[178] (69 bytes)
;   0xb75b..0xb7a0  (69 bytes)
DATA_tira_B75B:
	defb 0d8h,0c0h,0dbh,0c3h,0d3h,0e9h,0c0h,0feh,008h,061h,0b7h,0b0h,0feh,004h,066h,0b7h	; b75b  .........a....f.
	defb 010h,0feh,008h,06bh,0b7h,0efh,0d8h,0fah,014h,0e1h,001h,0e2h,070h,0a2h,090h,070h	; b76b  ...k........p..p
	defb 050h,08bh,0a1h,0a0h,09bh,080h,0e1h,000h,030h,0e2h,0a0h,0e1h,020h,050h,000h,040h	; b77b  P.......0... P.@
	defb 070h,0d4h,0f8h,001h,0e0h,050h,070h,050h,070h,050h,070h,050h,070h,050h,070h,050h	; b78b  p....PpPpPpPpPpP
	defb 070h,050h,070h,050h,0ffh	; b79b

; ----------------------------------------------------------------------
; DATOS tira_B7A0: partitura de sonido (voz del sonido 0xB4) que lee
;   pide_un_efecto; lo cargan 0x873A[179] (61 bytes)
;   0xb7a0..0xb7dd  (61 bytes)
DATA_tira_B7A0:
	defb 0d2h,0c3h,0e9h,031h,031h,037h,033h,033h,033h,033h,0feh,002h,0a5h,0b7h,0efh,0d8h	; b7a0  ...1173333......
	defb 0fah,014h,0e3h,071h,070h,070h,070h,070h,071h,070h,081h,080h,080h,080h,080h,081h	; b7b0  ...qppppqp......
	defb 080h,080h,080h,080h,071h,070h,0e2h,000h,050h,000h,0e1h,008h,0e2h,030h,080h,0e1h	; b7c0  ....qp..P....0..
	defb 000h,0e2h,050h,0a0h,0e1h,020h,0e2h,070h,0e1h,000h,040h,007h,0ffh	; b7d0  ..P.. .p..@..

; ----------------------------------------------------------------------
; DATOS tira_B7DD: partitura de sonido (voz del sonido 0xB5) que lee
;   pide_un_efecto; lo cargan 0x873A[180] (51 bytes)
;   0xb7dd..0xb810  (51 bytes)
DATA_tira_B7DD:
	defb 0efh,0d8h,0c0h,0fbh,023h,0cch,0e3h,001h,000h,000h,000h,000h,001h,000h,011h,010h	; b7dd  ....#...........
	defb 010h,010h,010h,011h,010h,010h,010h,010h,031h,030h,051h,050h,050h,050h,050h,051h	; b7ed  ........10QPPPPQ
	defb 050h,050h,050h,050h,081h,080h,0a1h,0a0h,001h,000h,051h,050h,0fbh,018h,050h,050h	; b7fd  PPPP......QP..PP
	defb 050h,051h,0ffh	; b80d

; ----------------------------------------------------------------------
; DATOS ff_de_mas_B810: un 0xFF de mas: la partitura de 0xB7DD (sonido 0xB5)
;   ya se cierra con el de 0xB80F y la del sonido 0xB6 empieza en 0xB811. A
;   este no llega nadie
;   0xb810..0xb811  (1 bytes)
DATA_ff_de_mas_B810:
	defb 0ffh	; b810

; ----------------------------------------------------------------------
; DATOS tira_B811: partitura de sonido (voz del sonido 0xB6) que lee
;   pide_un_efecto; lo cargan 0x873A[181] (79 bytes)
;   0xb811..0xb860  (79 bytes)
DATA_tira_B811:
	defb 0d3h,0c3h,0e9h,0c0h,0feh,010h,014h,0b8h,0b0h,0feh,008h,019h,0b8h,010h,0feh,008h	; b811  ................
	defb 01eh,0b8h,0efh,0d6h,0f9h,011h,0e0h,000h,0c0h,000h,020h,000h,0c0h,020h,0c0h,000h	; b821  .......... .. ..
	defb 0e1h,040h,070h,0e0h,000h,0e1h,0b0h,0c0h,090h,0c0h,0d3h,0f8h,000h,070h,090h,070h	; b831  .@p..........p.p
	defb 090h,070h,090h,071h,0d6h,0f9h,011h,041h,051h,073h,043h,021h,041h,051h,071h,091h	; b841  .p.q...AQsC!AQq.
	defb 071h,091h,0b1h,0d3h,0f8h,000h,0e0h,000h,020h,0feh,008h,058h,0b8h,002h,0ffh	; b851  q....... ..X...

; ----------------------------------------------------------------------
; DATOS tira_B860: partitura de sonido (voz del sonido 0xB7) que lee
;   pide_un_efecto; lo cargan 0x873A[182] (37 bytes)
;   0xb860..0xb885  (37 bytes)
DATA_tira_B860:
	defb 0d6h,0c1h,0e9h,031h,031h,030h,030h,030h,030h,0feh,002h,063h,0b8h,0efh,0fbh,028h	; b860  ...110000..c...(
	defb 0e3h,003h,0e4h,073h,0feh,004h,070h,0b8h,053h,023h,073h,0fah,015h,091h,0b1h,0e3h	; b870  ...s..p.S#s.....
	defb 003h,002h,000h,002h,0ffh	; b880

; ----------------------------------------------------------------------
; DATOS tira_B885: partitura de sonido (voz del sonido 0xB8) que lee
;   pide_un_efecto; lo cargan 0x873A[183] (55 bytes)
;   0xb885..0xb8bc  (55 bytes)
DATA_tira_B885:
	defb 0d6h,0cfh,0c1h,0e9h,033h,030h,030h,030h,010h,033h,0d2h,0e9h,0b0h,0feh,00ch,091h	; b885  ....3000.3......
	defb 0b8h,0d6h,033h,030h,030h,010h,010h,033h,0d2h,0e9h,0b0h,0feh,00ch,09fh,0b8h,0d6h	; b895  ..300..3........
	defb 031h,000h,000h,041h,000h,000h,031h,000h,000h,041h,010h,010h,0efh,0fah,01fh,0e1h	; b8a5  1..A..1..A......
	defb 003h,0fah,023h,042h,040h,042h,0ffh	; b8b5

; ----------------------------------------------------------------------
; DATOS tira_B8BC: partitura de sonido (voz del sonido 0xB9) que lee
;   pide_un_efecto; lo cargan 0x873A[184] (69 bytes)
;   0xb8bc..0xb901  (69 bytes)
DATA_tira_B8BC:
	defb 0efh,0d8h,0fah,021h,0e0h,0c2h,002h,0fah,022h,0e1h,000h,070h,0e0h,000h,0fah,021h	; b8bc  ...!...."..p...!
	defb 022h,0fah,022h,001h,0e1h,0a0h,0fah,021h,0e0h,002h,0fah,022h,0e1h,000h,070h,0e0h	; b8cc  "."....!..."..p.
	defb 000h,0fah,021h,022h,0fah,022h,001h,0e1h,0a0h,0fah,021h,0e0h,002h,0fah,022h,0e1h	; b8dc  ..!"."....!...".
	defb 000h,050h,0e0h,030h,0fah,021h,022h,051h,0fah,022h,020h,020h,040h,020h,000h,0e1h	; b8ec  .P.0.!"Q."  @ ..
	defb 070h,020h,046h,0c1h,0ffh	; b8fc

; ----------------------------------------------------------------------
; DATOS tira_B901: partitura de sonido (voz del sonido 0xBA) que lee
;   pide_un_efecto; lo cargan 0x873A[185] (16 bytes)
;   0xb901..0xb911  (16 bytes)
DATA_tira_B901:
	defb 0efh,0d8h,0fch,032h,0e3h,0c2h,00bh,0e4h,0abh,0c0h,0e3h,034h,0c0h,054h,00ch,0ffh	; b901  ...2.......4.T..

; ----------------------------------------------------------------------
; DATOS tira_B911: partitura de sonido (voz del sonido 0xBB) que lee
;   pide_un_efecto; lo cargan 0x873A[186] (30 bytes)
;   0xb911..0xb92f  (30 bytes)
DATA_tira_B911:
	defb 0efh,0d8h,0fbh,032h,0e3h,0c3h,070h,0e2h,049h,0c0h,0e3h,050h,0e2h,029h,0e4h,080h	; b911  ...2..p.I..P.)..
	defb 0c0h,0e2h,003h,0e4h,0a0h,0c0h,0e2h,023h,0c0h,0e3h,070h,0e2h,04ah,0ffh	; b921  .......#..p.J.

; ----------------------------------------------------------------------
; DATOS tira_B92F: partitura de sonido (voz del sonido 0x77; voz del sonido
;   0x78; voz del sonido 0x79) que lee pide_un_efecto; se entra por 0xB92F,
;   0xB931, 0xB933; lo cargan 0x873A[118], 0x873A[119], 0x873A[120] (26 bytes)
;   0xb92f..0xb949  (26 bytes)
DATA_tira_B92F:
	defb 0dah,0c0h,0dah,0c0h,0dch,0eah,051h,001h,091h,001h,051h,000h,091h,090h,001h,031h	; b92f  ......Q...Q....1
	defb 001h,091h,001h,031h,000h,091h,090h,001h,001h,0ffh	; b93f  ...1......

; ----------------------------------------------------------------------
; DATOS tira_B949: partitura de sonido (voz del sonido 0xBF) que lee
;   pide_un_efecto; lo cargan 0x873A[190] (287 bytes)
;   0xb949..0xba68  (287 bytes)
DATA_tira_B949:
	defb 0efh,0d6h,0fah,014h,0e3h,073h,053h,021h,031h,053h,001h,003h,001h,0e2h,003h,0e3h	; b949  .....sS!1S......
	defb 001h,001h,0e4h,0a1h,0a3h,0a1h,0e3h,0a3h,0e4h,0a1h,0a1h,081h,083h,081h,0e3h,083h	; b959  ................
	defb 0e4h,081h,081h,0a1h,0a3h,0a1h,0e3h,0a3h,0e4h,0a1h,0a1h,0e3h,001h,001h,0f9h,014h	; b969  ................
	defb 0e2h,001h,0fah,014h,0e3h,001h,0f9h,014h,0e2h,003h,0fah,014h,0e3h,001h,001h,0e4h	; b979  ................
	defb 0a1h,0a3h,0a1h,0f9h,014h,0e2h,021h,031h,021h,0e3h,0a1h,0fah,014h,0e4h,081h,083h	; b989  ......!1!.......
	defb 081h,0e3h,083h,0e4h,081h,081h,0a1h,0a3h,0a1h,0e3h,0a3h,0e4h,0a1h,0a1h,0e1h,001h	; b999  ................
	defb 0e2h,071h,0e1h,021h,0e2h,0a1h,0e1h,031h,001h,051h,021h,0e2h,001h,0e1h,003h,0e2h	; b9a9  .q.!...1.Q!.....
	defb 001h,0f9h,001h,0e1h,005h,0d1h,0f8h,000h,000h,010h,020h,030h,040h,050h,060h,070h	; b9b9  .......... 0@P`p
	defb 080h,090h,0a0h,0b0h,0d6h,0f8h,014h,0e0h,009h,0f9h,014h,0e1h,0a1h,071h,051h,0f8h	; b9c9  .............qQ.
	defb 000h,071h,0d1h,070h,060h,050h,040h,030h,020h,010h,000h,0e2h,0b0h,0a0h,090h,080h	; b9d9  .q.p`P@0 .......
	defb 0d6h,0f9h,014h,071h,0f7h,000h,0e1h,071h,0d1h,070h,060h,050h,040h,030h,020h,010h	; b9e9  ...q...q.p`P@0 .
	defb 000h,0e2h,0b0h,0a0h,090h,080h,0d6h,0f8h,014h,071h,0f5h,000h,0e1h,071h,0d1h,070h	; b9f9  .........q...q.p
	defb 060h,050h,040h,030h,020h,010h,000h,0e2h,0b0h,0a0h,090h,080h,0d6h,0f6h,014h,071h	; ba09  `P@0 ..........q
	defb 0f3h,000h,0e1h,071h,0d1h,070h,060h,050h,040h,030h,020h,010h,000h,0e2h,0b0h,0a0h	; ba19  ...q.p`P@0 .....
	defb 090h,080h,0d6h,0fah,014h,0e4h,0a1h,0e3h,0a3h,0e4h,0a1h,0a1h,0fah,014h,0e3h,001h	; ba29  ................
	defb 071h,021h,071h,031h,021h,001h,021h,0f9h,014h,0a1h,051h,0e2h,021h,0e3h,051h,0e2h	; ba39  q!q1!.!...Q.!.Q.
	defb 031h,021h,001h,0e3h,071h,0f9h,022h,0e2h,075h,050h,070h,0f8h,022h,055h,030h,050h	; ba49  1!..q.".uPp."U0P
	defb 0f7h,022h,035h,020h,030h,0f6h,022h,021h,001h,0e3h,071h,0f5h,022h,031h,0ffh	; ba59  ."5 0."!..q."1.

; ----------------------------------------------------------------------
; DATOS tira_BA68: partitura de sonido (voz del sonido 0xC0) que lee
;   pide_un_efecto; lo cargan 0x873A[191] (135 bytes)
;   0xba68..0xbaef  (135 bytes)
DATA_tira_BA68:
	defb 0efh,0d6h,0fah,014h,0e4h,073h,053h,021h,031h,053h,0e4h,001h,003h,001h,0e3h,003h	; ba68  .....sS!1S......
	defb 0e4h,001h,001h,0e5h,0a1h,0a3h,0a1h,0e4h,0a3h,0e5h,0a1h,0a1h,081h,083h,081h,0e4h	; ba78  ................
	defb 083h,0e5h,081h,081h,0a1h,0a3h,0a1h,0e4h,0a3h,0e5h,0a1h,0a1h,0feh,002h,072h,0bah	; ba88  ..............r.
	defb 0e4h,073h,053h,021h,031h,053h,0fbh,014h,0e4h,001h,003h,001h,0e3h,003h,0e4h,001h	; ba98  .sS!1S..........
	defb 001h,0e5h,0a1h,0a3h,0a1h,0e4h,0a3h,0e5h,0a1h,0a1h,081h,083h,081h,0e4h,083h,0e5h	; baa8  ................
	defb 081h,081h,0a1h,0a3h,0a1h,0e4h,0a3h,0e5h,0a1h,0a1h,0fah,014h,0e4h,001h,003h,001h	; bab8  ................
	defb 0e3h,003h,0e4h,001h,001h,0e5h,0a1h,0a3h,0a1h,0e4h,0a3h,0e5h,0a1h,0a1h,0f9h,014h	; bac8  ................
	defb 081h,083h,081h,0e4h,083h,0f8h,014h,0e5h,081h,081h,0a1h,0a3h,0a1h,0f7h,014h,0e4h	; bad8  ................
	defb 0a3h,0e5h,0a1h,0f6h,014h,0a1h,0ffh	; bae8

; ----------------------------------------------------------------------
; DATOS tira_BAEF: partitura de sonido (voz del sonido 0xC1) que lee
;   pide_un_efecto; lo cargan 0x873A[192] (287 bytes)
;   0xbaef..0xbc0e  (287 bytes)
DATA_tira_BAEF:
	defb 0d6h,0e9h,093h,093h,0a1h,0a1h,031h,0a1h,001h,001h,001h,001h,041h,001h,041h,001h	; baef  ......1.....A.A.
	defb 001h,001h,001h,001h,041h,001h,090h,090h,0a1h,001h,001h,001h,001h,041h,001h,081h	; baff  ....A........A..
	defb 081h,001h,001h,001h,001h,081h,081h,091h,0a1h,0feh,002h,0f7h,0bah,0efh,0fah,014h	; bb0f  ................
	defb 0e3h,073h,053h,021h,031h,053h,0e9h,001h,001h,001h,001h,041h,001h,041h,001h,001h	; bb1f  .sS!1S.....A.A..
	defb 001h,001h,001h,041h,001h,090h,090h,0a1h,001h,001h,001h,001h,041h,001h,081h,081h	; bb2f  ...A........A...
	defb 001h,001h,001h,001h,081h,081h,091h,0a1h,001h,001h,001h,001h,041h,001h,041h,001h	; bb3f  ............A.A.
	defb 001h,001h,001h,001h,041h,001h,0feh,000h,022h,001h,0c3h,000h,0c3h,00ah,0b3h,015h	; bb4f  ....A...".......
	defb 0b3h,020h,0a3h,02ah,0a3h,035h,0a3h,040h,0a3h,04ah,093h,055h,093h,060h,093h,06ah	; bb5f  . .*.5.@.J.U.`.j
	defb 093h,075h,0feh,002h,057h,0bbh,021h,001h,010h,0a0h,000h,020h,00bh,0feh,004h,075h	; bb6f  .u..W.!.... ...u
	defb 0bbh,023h,001h,013h,0a1h,030h,022h,001h,0a1h,0a0h,072h,020h,052h,0f0h,020h,008h	; bb7f  .#...0"...r R. .
	defb 021h,001h,010h,090h,000h,020h,00bh,022h,001h,082h,001h,072h,00bh,072h,016h,062h	; bb8f  !.... ."...r.r.b
	defb 021h,062h,02bh,062h,036h,052h,041h,052h,04bh,052h,057h,052h,062h,042h,06ch,042h	; bb9f  !b+b6RARKRWRbBlB
	defb 077h,0feh,002h,096h,0bbh,021h,001h,010h,080h,000h,020h,00bh,0feh,004h,0b4h,0bbh	; bbaf  w....!.... .....
	defb 022h,001h,072h,001h,062h,00bh,062h,016h,052h,021h,052h,02bh,052h,036h,042h,041h	; bbbf  ".r.b.b.R!R+R6BA
	defb 042h,04bh,042h,057h,042h,062h,032h,06ch,032h,077h,0feh,002h,0bfh,0bbh,073h,003h	; bbcf  BKBWBb2l2w....s.
	defb 063h,00dh,063h,018h,053h,023h,053h,02dh,053h,038h,043h,043h,043h,04dh,043h,058h	; bbdf  c.c.S#S-S8CCCMCX
	defb 043h,063h,033h,06dh,033h,078h,064h,000h,054h,015h,054h,030h,054h,045h,044h,060h	; bbef  Cc3m3xd.T.T0TED`
	defb 044h,075h,044h,090h,044h,0b0h,044h,0d0h,044h,0f0h,045h,010h,045h,030h,0ffh	; bbff  DuD.D.D.D.E.E0.

; ----------------------------------------------------------------------
; DATOS tira_BC0E: partitura de sonido (voz del sonido 0xC2) que lee
;   pide_un_efecto; lo cargan 0x873A[193] (308 bytes)
;   0xbc0e..0xbd42  (308 bytes)
DATA_tira_BC0E:
	defb 0efh,0dah,0f9h,002h,0e0h,0c0h,021h,001h,0e1h,091h,0a1h,091h,051h,071h,051h,021h	; bc0e  ......!.....QqQ!
	defb 031h,021h,0e2h,0a1h,0f9h,003h,0a3h,0a1h,0feh,007h,022h,0bch,0e1h,031h,021h,0e2h	; bc1e  1!........"..1!.
	defb 0a1h,0f8h,003h,0a3h,0a1h,0feh,007h,031h,0bch,0e1h,021h,0e2h,0a1h,051h,0ebh,090h	; bc2e  .......1..!..Q..
	defb 0eah,050h,0a0h,050h,0d9h,0a1h,0ebh,090h,0eah,050h,0a0h,050h,0a1h,0feh,003h,044h	; bc3e  .P.P.....P.P...D
	defb 0bch,0efh,0f9h,003h,0e3h,035h,0e2h,001h,0e3h,0a1h,0e2h,001h,0e2h,025h,031h,021h	; bc4e  .....5.......%1!
	defb 0e3h,0a1h,0f7h,002h,0e2h,001h,021h,051h,0a3h,051h,071h,051h,021h,0a3h,0e1h,001h	; bc5e  ......!Q.QqQ!...
	defb 0f9h,002h,035h,051h,031h,001h,0e2h,053h,0a1h,0e1h,053h,0a1h,0e8h,0f9h,002h,0e2h	; bc6e  ..5Q1..S..S.....
	defb 0c0h,083h,0e1h,011h,08bh,081h,061h,050h,015h,0e2h,0a3h,0e1h,011h,05bh,0e2h,0c0h	; bc7e  ......aP.....[..
	defb 083h,0e1h,011h,08ch,0a1h,081h,085h,0b2h,0d4h,0a0h,0d5h,090h,0d9h,081h,005h,001h	; bc8e  ................
	defb 0e2h,081h,031h,0e3h,080h,0e2h,000h,030h,080h,0e1h,000h,030h,080h,030h,000h,0e2h	; bc9e  ..1....0...0.0..
	defb 080h,030h,000h,0e3h,070h,0a0h,0e2h,030h,070h,0a0h,0e1h,030h,070h,030h,0e2h,0a0h	; bcae  .0..p..0p..0p0..
	defb 070h,030h,0e3h,0a0h,0e1h,005h,001h,0e2h,0a1h,081h,07bh,0f9h,022h,0e2h,080h,080h	; bcbe  p0........{."...
	defb 010h,010h,0feh,003h,0cch,0bch,0e1h,030h,030h,0e2h,080h,080h,0feh,003h,0d4h,0bch	; bcce  .......00.......
	defb 0e1h,050h,030h,010h,030h,010h,000h,010h,000h,0e2h,0a0h,0e1h,000h,0e2h,0a0h,080h	; bcde  .P0.0...........
	defb 0a0h,080h,070h,080h,070h,050h,030h,050h,070h,080h,0a0h,0b0h,0f9h,011h,0e1h,000h	; bcee  ..p.pP0Pp.......
	defb 0e2h,0a0h,080h,0a0h,080h,070h,080h,070h,050h,070h,050h,030h,0a0h,080h,070h,080h	; bcfe  .....p.pPpP0..p.
	defb 070h,050h,070h,050h,030h,050h,030h,010h,000h,010h,030h,0f8h,011h,050h,070h,080h	; bd0e  pPpP0P0...0..Pp.
	defb 0f7h,011h,0a0h,0e1h,000h,010h,0f6h,011h,030h,050h,070h,080h,0f5h,011h,070h,050h	; bd1e  ........0Pp...pP
	defb 030h,010h,0f4h,011h,000h,0e2h,0a0h,080h,0f3h,011h,070h,050h,0f2h,011h,030h,0f1h	; bd2e  0.........pP..0.
	defb 011h,010h,0c2h,0ffh	; bd3e

; ----------------------------------------------------------------------
; DATOS tira_BD42: partitura de sonido (voz del sonido 0xC3) que lee
;   pide_un_efecto; lo cargan 0x873A[194] (211 bytes)
;   0xbd42..0xbe15  (211 bytes)
DATA_tira_BD42:
	defb 0efh,0dah,0f9h,002h,0e3h,0cch,031h,021h,0e4h,0a1h,0e3h,001h,0e4h,0a1h,081h,0e4h	; bd42  ......1!........
	defb 01bh,03bh,069h,081h,05bh,08bh,07bh,06bh,05bh,081h,081h,0d9h,081h,081h,081h,081h	; bd52  .;i.[.{k[.......
	defb 071h,0feh,006h,062h,0bdh,061h,061h,061h,081h,081h,081h,0a1h,0feh,006h,06dh,0bdh	; bd62  q..b.aaa......m.
	defb 081h,0feh,006h,072h,0bdh,071h,0feh,006h,077h,0bdh,061h,061h,061h,081h,081h,081h	; bd72  ...r.q..w.aaa...
	defb 0a1h,0feh,005h,082h,0bdh,0e3h,001h,011h,0feh,006h,089h,0bdh,001h,0feh,006h,08eh	; bd82  ................
	defb 0bdh,0e4h,0a1h,0feh,006h,094h,0bdh,081h,0feh,006h,099h,0bdh,061h,0feh,006h,09eh	; bd92  ............a...
	defb 0bdh,051h,051h,051h,051h,081h,0e3h,011h,0e4h,091h,091h,091h,091h,091h,0b1h,0e3h	; bda2  .QQQQ...........
	defb 001h,001h,001h,001h,011h,031h,0e4h,081h,0feh,006h,0b9h,0bdh,071h,0feh,006h,0beh	; bdb2  .....1......q...
	defb 0bdh,051h,0feh,006h,0c3h,0bdh,0e3h,001h,001h,001h,0e4h,0a1h,0a1h,081h,051h,0feh	; bdc2  .Q............Q.
	defb 006h,0d0h,0bdh,081h,0feh,006h,0d5h,0bdh,0e3h,011h,0feh,006h,0dbh,0bdh,0f9h,011h	; bdd2  ................
	defb 080h,070h,050h,070h,050h,030h,010h,030h,010h,000h,0e4h,0a0h,090h,081h,0feh,006h	; bde2  .pPpP0.0........
	defb 0efh,0bdh,071h,0feh,006h,0f4h,0bdh,051h,051h,0f8h,002h,051h,051h,0f7h,002h,051h	; bdf2  ..q....QQ..QQ..Q
	defb 051h,0f6h,012h,0e3h,001h,001h,0f5h,012h,001h,0f4h,012h,001h,0f3h,012h,001h,0f2h	; be02  Q...............
	defb 002h,001h,0ffh	; be12

; ----------------------------------------------------------------------
; DATOS tira_BE15: partitura de sonido (voz del sonido 0xC4) que lee
;   pide_un_efecto; lo cargan 0x873A[195] (303 bytes)
;   0xbe15..0xbf44  (303 bytes)
DATA_tira_BE15:
	defb 0dah,0c0h,0ebh,021h,0feh,000h,022h,004h,090h,01bh,080h,01bh,070h,01bh,060h,01bh	; be15  ...!..".....p.`.
	defb 050h,01bh,0feh,000h,0dah,0eah,091h,0a1h,091h,051h,071h,051h,021h,031h,021h,0ebh	; be25  P........QqQ!1!.
	defb 091h,093h,091h,093h,091h,091h,0efh,0d4h,0f4h,000h,0e1h,0a0h,0f5h,000h,0a0h,0f6h	; be35  ................
	defb 000h,0a0h,0f7h,000h,0a0h,0d6h,0f8h,000h,0a0h,0dah,0f8h,000h,0a5h,0d1h,0f7h,000h	; be45  ................
	defb 090h,080h,070h,060h,050h,040h,0f6h,000h,030h,020h,010h,000h,0e2h,0b0h,0a0h,0f6h	; be55  ..p`P@..0 ......
	defb 000h,0e1h,0c8h,0aah,090h,080h,070h,060h,050h,040h,030h,020h,010h,000h,0e2h,0b0h	; be65  ......p`P@0 ....
	defb 0a0h,0f5h,000h,0e1h,0c9h,0aah,090h,080h,070h,060h,050h,040h,030h,020h,010h,000h	; be75  ........p`P@0 ..
	defb 0e2h,0b0h,0a0h,0e1h,0c9h,0aah,090h,080h,070h,060h,050h,040h,030h,020h,010h,000h	; be85  ........p`P@0 ..
	defb 0e2h,0b0h,0dah,0f4h,000h,0e1h,030h,0f5h,000h,030h,0f6h,000h,030h,0f7h,000h,030h	; be95  ......0..0..0..0
	defb 0f8h,000h,030h,0f9h,002h,033h,071h,051h,031h,055h,0abh,071h,051h,031h,0e3h,055h	; bea5  ..0..3qQ1U.qQ1.U
	defb 0a3h,0e2h,031h,025h,051h,021h,0e3h,0a1h,0f9h,012h,0e2h,071h,051h,0d9h,021h,0a3h	; beb5  ..1%Q!.....qQ.!.
	defb 0e1h,001h,035h,023h,0e2h,0a1h,0e1h,0a5h,081h,061h,031h,02bh,0e1h,071h,051h,021h	; bec5  ..5#.....a1+.qQ!
	defb 0a3h,0e0h,001h,035h,023h,0e1h,0a1h,0e0h,0a5h,081h,061h,031h,02bh,0e2h,083h,0e1h	; bed5  ...5#.....a1+...
	defb 011h,08bh,081h,061h,051h,065h,063h,0a1h,08bh,0e2h,083h,0e1h,011h,08bh,081h,061h	; bee5  ...aQec........a
	defb 051h,045h,043h,061h,075h,071h,081h,0a1h,0e0h,003h,0e1h,081h,0e0h,035h,0e1h,0a3h	; bef5  QECauq.......5..
	defb 071h,0e0h,035h,0e1h,085h,081h,071h,051h,00bh,0e1h,013h,051h,083h,0a1h,0e0h,015h	; bf05  q.5...qQ...Q....
	defb 003h,0e1h,081h,085h,053h,081h,085h,0a5h,0e0h,003h,0e1h,081h,0e0h,035h,0e1h,0a3h	; bf15  ....S........5..
	defb 071h,0f9h,010h,0e0h,035h,0f8h,010h,0e1h,082h,0f7h,002h,082h,0f7h,012h,081h,0f6h	; bf25  q...5...........
	defb 012h,071h,0f5h,012h,051h,0f4h,000h,003h,0f3h,000h,003h,0f2h,000h,003h,0ffh	; bf35  .q..Q..........

; ----------------------------------------------------------------------
; DATOS tira_BF44: partitura de sonido (voz del sonido 0xC5) que lee
;   pide_un_efecto; lo cargan 0x873A[196] (13 bytes)
;   0xbf44..0xbf51  (13 bytes)
DATA_tira_BF44:
	defb 0dch,0ebh,041h,081h,0eah,0c1h,041h,081h,0d8h,0b0h,0b0h,0b4h,0ffh	; bf44  ..A...A......

; ----------------------------------------------------------------------
; DATOS tira_BF51: partitura de sonido (voz del sonido 0xC6) que lee
;   pide_un_efecto; lo cargan 0x873A[197] (11 bytes)
;   0xbf51..0xbf5c  (11 bytes)
DATA_tira_BF51:
	defb 0d8h,0c0h,0dch,0ebh,041h,081h,0eah,0c1h,041h,081h,0ffh	; bf51  ....A...A..

; ----------------------------------------------------------------------
; DATOS tira_BF5C: partitura de sonido (voz del sonido 0xC7) que lee
;   pide_un_efecto; lo cargan 0x873A[198] (12 bytes)
;   0xbf5c..0xbf68  (12 bytes)
DATA_tira_BF5C:
	defb 0dfh,0c0h,0dch,0ebh,041h,081h,0eah,0c1h,041h,0d8h,081h,0ffh	; bf5c  ....A...A...

; ----------------------------------------------------------------------
; DATOS tira_BF68: partitura de sonido (voz del sonido 0xC8) que lee
;   pide_un_efecto; lo cargan 0x873A[199] (48 bytes)
;   0xbf68..0xbf98  (48 bytes)
DATA_tira_BF68:
	defb 0efh,0d6h,0fah,022h,0e1h,073h,0a3h,0e0h,005h,0fah,023h,0e1h,0a3h,0fah,022h,073h	; bf68  ...".s....#..."s
	defb 0fah,023h,051h,0fah,022h,025h,0fah,023h,003h,0fah,032h,021h,031h,051h,0fah,022h	; bf78  .#Q."%.#..2!1Q."
	defb 0e0h,005h,0fah,023h,0e1h,0a3h,0fah,032h,051h,071h,0a1h,0fah,022h,0e0h,00ch,0ffh	; bf88  ...#...2Qq.."...

; ----------------------------------------------------------------------
; DATOS tira_BF98: partitura de sonido (voz del sonido 0xC9) que lee
;   pide_un_efecto; lo cargan 0x873A[200] (51 bytes)
;   0xbf98..0xbfcb  (51 bytes)
DATA_tira_BF98:
	defb 0efh,0d6h,0f8h,022h,0e1h,003h,053h,0fah,044h,0e4h,081h,081h,0e2h,001h,0e4h,081h	; bf98  ..."..S.D.......
	defb 0a1h,0a1h,0e2h,021h,0e4h,0a1h,0e3h,001h,001h,0e2h,031h,0e3h,001h,001h,001h,0e2h	; bfa8  ...!......1.....
	defb 031h,0e3h,001h,0e4h,081h,081h,0e2h,001h,0e4h,081h,0a1h,0a1h,0e2h,021h,0e4h,0a1h	; bfb8  1............!..
	defb 0e3h,00ch,0ffh	; bfc8

; ----------------------------------------------------------------------
; DATOS tira_BFCB: partitura de sonido (voz del sonido 0xCA; voz del sonido
;   0xCE) que lee pide_un_efecto; se entra por 0xBFCB, 0xBFFE; lo cargan
;   0x873A[201], 0x873A[205] (52 bytes)
;   0xbfcb..0xbfff  (52 bytes)
DATA_tira_BFCB:
	defb 0efh,0d6h,0f8h,022h,0e2h,073h,0a3h,0fah,044h,0e3h,031h,031h,0e9h,071h,0efh,031h	; bfcb  ...".s..D.11.q.1
	defb 051h,051h,0e9h,071h,0efh,051h,071h,071h,0e9h,071h,0efh,071h,071h,071h,0e9h,071h	; bfdb  QQ.q.Qqq.q.qqq.q
	defb 0efh,071h,0e3h,031h,031h,0e9h,071h,0efh,031h,051h,051h,0e9h,071h,0efh,051h,0f9h	; bfeb  .q.11.q.1QQ.q.Q.
	defb 022h,0e2h,04ch,0ffh	; bffb

; ----------------------------------------------------------------------
; DATOS relleno_del_banco_15: 1 bytes a 0xFF hasta el final de los 8 KB del
;   banco, detras del 0xFF que cierra el ultimo guion: espacio libre
;   0xbfff..0xc000  (1 bytes)
DATA_relleno_del_banco_15:
	defb 0ffh	; bfff
