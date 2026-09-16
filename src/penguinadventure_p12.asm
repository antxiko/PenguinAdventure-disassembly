; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 12 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS animacion_por_decorado_8000: un puntero por decorado (0xE0A1) a una
;   tabla de cuatro cuadros de animacion; la lee p01:655A y el cuadro lo da
;   (0xE4C2) & 3
;   0x8000..0x8014  (20 bytes)
DATA_animacion_por_decorado_8000:
	defb 033h,080h	; 8000
	defb 0ffh,081h	; 8002
	defb 038h,087h	; 8004
	defb 0c3h,089h	; 8006
	defb 0ffh,08eh	; 8008
	defb 002h,091h	; 800a
	defb 056h,097h	; 800c
	defb 085h,09dh	; 800e
	defb 0ddh,0a3h	; 8010
	defb 056h,097h	; 8012

; ----------------------------------------------------------------------
; DATOS guion_8014: guion comprimido que lee descomprime; lo cargan p01:6041
;   (31 bytes)
;   0x8014..0x8033  (31 bytes)
DATA_guion_8014:
	defb 0e0h,0ebh,060h,001h,040h,001h,040h,002h,029h,003h,00eh,001h,00fh,003h,014h,001h	; 8014  ..`.@.@.).......
	defb 009h,003h,01ah,001h,003h,003h,040h,001h,060h,001h,060h,001h,040h,001h,000h	; 8024  ......@.`.`.@..

; ----------------------------------------------------------------------
; DATOS cuadros_8033: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x8033..0x803b  (8 bytes)
DATA_cuadros_8033:
	defb 03bh,080h	; 8033
	defb 0adh,080h	; 8035
	defb 010h,081h	; 8037
	defb 07ah,081h	; 8039

; ----------------------------------------------------------------------
; DATOS tira_803B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8033[0] (114 bytes)
;   0x803b..0x80ad  (114 bytes)
DATA_tira_803B:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,015h,03eh,041h	; 803b  ..............>A
	defb 03fh,001h,001h,074h,076h,073h,04ah,003h,003h,003h,003h,003h,003h,003h,003h,003h	; 804b  ?..tvsJ.........
	defb 003h,003h,0feh,0e9h,0ech,017h,016h,02ah,026h,0feh,0f3h,0ech,05bh,05fh,04bh,04ch	; 805b  .......*&...[_KL
	defb 0feh,006h,0edh,003h,02ch,02dh,027h,001h,0feh,015h,0edh,001h,05ch,062h,061h,003h	; 806b  ....,-'.....\ba.
	defb 0feh,023h,0edh,019h,018h,005h,005h,004h,0feh,038h,0edh,004h,005h,005h,04dh,04eh	; 807b  .#.......8....MN
	defb 0feh,040h,0edh,01ch,01bh,01ah,001h,001h,001h,001h,0feh,059h,0edh,001h,001h,001h	; 808b  .@.........Y....
	defb 001h,04fh,050h,051h,001h,001h,001h,001h,001h,0feh,07bh,0edh,001h,001h,001h,001h	; 809b  .OPQ......{.....
	defb 001h,0ffh	; 80ab

; ----------------------------------------------------------------------
; DATOS tira_80AD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8033[1] (99 bytes)
;   0x80ad..0x8110  (99 bytes)
DATA_tira_80AD:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,015h,03eh,042h	; 80ad  ..............>B
	defb 03fh,001h,001h,074h,077h,073h,04ah,003h,003h,003h,003h,003h,003h,003h,003h,003h	; 80bd  ?..twsJ.........
	defb 003h,003h,0feh,0e9h,0ech,01dh,030h,02fh,001h,0feh,0f3h,0ech,001h,064h,065h,052h	; 80cd  ......0/.....deR
	defb 0feh,006h,0edh,017h,01fh,01eh,001h,001h,0feh,015h,0edh,001h,001h,053h,054h,04ch	; 80dd  .............STL
	defb 0feh,023h,0edh,003h,003h,031h,029h,028h,0feh,038h,0edh,05dh,05eh,066h,003h,003h	; 80ed  .#...1)(.8.]^f..
	defb 0feh,040h,0edh,01ch,01bh,005h,005h,004h,020h,0feh,05ah,0edh,055h,004h,005h,005h	; 80fd  .@...... .Z.U...
	defb 050h,051h,0ffh	; 810d

; ----------------------------------------------------------------------
; DATOS tira_8110: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8033[2] (106 bytes)
;   0x8110..0x817a  (106 bytes)
DATA_tira_8110:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,015h,040h,043h	; 8110  ..............@C
	defb 024h,001h,001h,059h,078h,075h,04ah,003h,003h,003h,003h,003h,003h,003h,003h,003h	; 8120  $..YxuJ.........
	defb 003h,003h,0feh,0e9h,0ech,034h,033h,021h,0feh,0f4h,0ech,056h,068h,069h,0feh,006h	; 8130  .....43!...Vhi..
	defb 0edh,017h,01fh,022h,020h,001h,0feh,015h,0edh,001h,055h,057h,054h,04ch,0feh,023h	; 8140  ..." .....UWTL.#
	defb 0edh,036h,035h,01ah,001h,001h,0feh,038h,0edh,001h,001h,04fh,06ah,06bh,0feh,040h	; 8150  .65....8...Ojk.@
	defb 0edh,003h,003h,003h,02eh,038h,037h,025h,0feh,059h,0edh,05ah,06ch,06dh,063h,003h	; 8160  .....87%.Y.Zlmc.
	defb 003h,003h,004h,004h,0feh,07eh,0edh,004h,004h,0ffh	; 8170  .....~....

; ----------------------------------------------------------------------
; DATOS tira_817A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8033[3] (114 bytes)
;   0x817a..0x81ec  (114 bytes)
DATA_tira_817A:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,015h,03eh,044h	; 817a  ..............>D
	defb 045h,001h,001h,07ah,079h,073h,04ah,003h,003h,003h,003h,003h,003h,003h,003h,003h	; 818a  E..zysJ.........
	defb 003h,003h,0feh,0e9h,0ech,017h,023h,046h,047h,0feh,0f3h,0ech,07ch,07bh,058h,04ch	; 819a  ......#FG...|{XL
	defb 0feh,006h,0edh,017h,008h,03bh,03ah,025h,0feh,015h,0edh,05ah,06fh,070h,008h,04ch	; 81aa  .....;:%...Zop.L
	defb 0feh,023h,0edh,019h,018h,01ah,001h,001h,0feh,038h,0edh,001h,001h,04fh,04dh,04eh	; 81ba  .#.......8...OMN
	defb 0feh,040h,0edh,003h,03ch,02bh,001h,001h,001h,001h,0feh,059h,0edh,001h,001h,001h	; 81ca  .@..<+.....Y....
	defb 001h,060h,071h,003h,003h,032h,03dh,039h,025h,0feh,07bh,0edh,05ah,06eh,072h,067h	; 81da  .`q..2=9%.{.Znrg
	defb 003h,0ffh	; 81ea

; ----------------------------------------------------------------------
; DATOS guion_81EC: guion comprimido que lee descomprime; lo cargan p01:6073
;   (19 bytes)
;   0x81ec..0x81ff  (19 bytes)
DATA_guion_81EC:
	defb 0e0h,0ebh,060h,001h,040h,001h,060h,001h,060h,001h,040h,001h,060h,001h,060h,001h	; 81ec  ..`.@.`.`.@.`.`.
	defb 040h,001h,000h	; 81fc

; ----------------------------------------------------------------------
; DATOS cuadros_81FF: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x81ff..0x8207  (8 bytes)
DATA_cuadros_81FF:
	defb 007h,082h	; 81ff
	defb 04ch,083h	; 8201
	defb 095h,084h	; 8203
	defb 0dch,085h	; 8205

; ----------------------------------------------------------------------
; DATOS tira_8207: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x81FF[0] (325 bytes)
;   0x8207..0x834c  (325 bytes)
DATA_tira_8207:
	defb 0e0h,0ebh,058h,00fh,056h,05eh,00fh,049h,0feh,0fah,0ebh,06ch,00fh,081h,079h,00fh	; 8207  ..X.V^.I...l..y.
	defb 07bh,053h,075h,057h,05ch,061h,04ah,043h,048h,0feh,018h,0ech,06bh,066h,06dh,084h	; 8217  {SuW\aJCH...kfm.
	defb 07fh,07ah,052h,076h,061h,060h,075h,05dh,083h,04bh,064h,04ah,042h,045h,0feh,036h	; 8227  .zRva`u].KdJBE.6
	defb 0ech,068h,065h,06dh,087h,06eh,060h,080h,052h,083h,084h,052h,041h,075h,05dh,041h	; 8237  .hem.n`.R..RAu]A
	defb 05fh,051h,04bh,064h,049h,0feh,056h,0ech,06ch,087h,06eh,074h,082h,041h,080h,052h	; 8247  _QKdI.V.l.nt.A.R
	defb 041h,075h,052h,00fh,056h,05eh,060h,055h,050h,055h,053h,04bh,043h,048h,0feh,074h	; 8257  AuR.V^`UPUSKCH.t
	defb 0ech,06bh,066h,06eh,076h,078h,073h,078h,083h,081h,079h,00fh,075h,013h,006h,00ch	; 8267  .kfnvxsx..y.u...
	defb 013h,05ah,00ah,052h,00ch,054h,00ah,04ch,01eh,020h,002h,002h,002h,002h,002h,002h	; 8277  .Z.R.T.L. ......
	defb 062h,060h,00ah,04ch,012h,04eh,010h,04ch,018h,055h,04eh,006h,055h,04eh,018h,00bh	; 8287  b`.L.N.L.UN.UN..
	defb 010h,04bh,00bh,013h,00ah,052h,00ah,052h,00ah,016h,020h,002h,002h,002h,002h,062h	; 8297  .K...R.R.. ....b
	defb 058h,04ch,010h,04ch,010h,04ch,055h,04dh,009h,052h,04dh,05ah,00ch,013h,006h,019h	; 82a7  XL.L.LUM.RMZ....
	defb 012h,04eh,00ch,054h,00bh,013h,016h,013h,016h,016h,02dh,02fh,005h,005h,071h,06fh	; 82b7  .N.T......-/..qo
	defb 058h,058h,055h,058h,055h,04dh,012h,04ch,00ch,054h,05bh,006h,055h,04eh,003h,00bh	; 82c7  XXUXUM.L.T[.UN..
	defb 010h,04bh,003h,055h,019h,055h,015h,032h,033h,034h,0feh,0f3h,0ech,076h,075h,074h	; 82d7  .K.U.U.234...vut
	defb 057h,013h,05bh,013h,003h,009h,052h,04dh,003h,00ch,04eh,019h,00bh,010h,052h,015h	; 82e7  W.[...RM..N...R.
	defb 004h,008h,032h,033h,034h,0feh,015h,0edh,076h,075h,074h,008h,004h,057h,010h,052h	; 82f7  ..234...vut..W.R
	defb 04dh,05bh,00ch,057h,003h,00ah,004h,004h,004h,032h,033h,034h,0feh,037h,0edh,076h	; 8307  M[.W.....234.7.v
	defb 075h,074h,004h,004h,004h,04ch,003h,015h,004h,008h,004h,004h,032h,033h,034h,0feh	; 8317  ut...L......234.
	defb 059h,0edh,076h,075h,074h,004h,004h,008h,004h,004h,004h,032h,033h,034h,0feh,07bh	; 8327  Y.vut......234.{
	defb 0edh,076h,075h,074h,004h,004h,002h,003h,004h,0feh,09dh,0edh,010h,00fh,00eh,004h	; 8337  .vut............
	defb 0feh,0bfh,0edh,010h,0ffh	; 8347

; ----------------------------------------------------------------------
; DATOS tira_834C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x81FF[1] (329 bytes)
;   0x834c..0x8495  (329 bytes)
DATA_tira_834C:
	defb 0e0h,0ebh,00fh,00fh,05ah,058h,04eh,007h,046h,0feh,0f9h,0ebh,069h,007h,071h,07bh	; 834c  ....ZXN.F...i.q{
	defb 07dh,00fh,00fh,060h,054h,05bh,059h,083h,04ch,04bh,045h,0feh,018h,0ech,068h,06eh	; 835c  }..`T[Y.LKE...hn
	defb 06fh,060h,07ch,07eh,077h,083h,00fh,075h,05ch,041h,040h,04fh,00fh,04dh,047h,007h	; 836c  o`|~w..u\A@O.MG.
	defb 0feh,036h,0ech,007h,06ah,070h,00fh,072h,040h,041h,07fh,052h,00fh,041h,075h,05ah	; 837c  .6..jp.r@A.R.AuZ
	defb 078h,057h,05eh,083h,04fh,04eh,045h,046h,0feh,055h,0ech,069h,068h,071h,072h,060h	; 838c  xW^.ONEF.U.ihqr`
	defb 081h,07ah,055h,07dh,052h,041h,060h,041h,05fh,058h,041h,081h,041h,080h,00fh,04fh	; 839c  .zU}RA`A_XA.A..O
	defb 04bh,045h,0feh,074h,0ech,068h,06eh,072h,00fh,05dh,041h,05eh,041h,07bh,082h,041h	; 83ac  KE.t.hnr.]A^A{.A
	defb 083h,006h,019h,010h,057h,006h,013h,05ah,012h,00dh,055h,018h,01fh,021h,002h,002h	; 83bc  ....W..Z..U..!..
	defb 002h,002h,002h,002h,063h,061h,05ah,013h,04fh,054h,018h,055h,006h,015h,052h,05bh	; 83cc  ....caZ.OT.U..R[
	defb 006h,019h,003h,00eh,013h,00ch,013h,05ah,013h,00bh,013h,05ah,013h,017h,021h,002h	; 83dc  .......Z...Z..!.
	defb 002h,002h,002h,063h,059h,055h,018h,055h,04dh,055h,018h,055h,04eh,055h,050h,003h	; 83ec  ...cYU.UMU.UNUP.
	defb 05bh,006h,019h,009h,052h,019h,013h,00bh,012h,00dh,055h,00dh,055h,017h,02eh,02fh	; 83fc  [...R.....U.U../
	defb 005h,005h,071h,070h,059h,013h,04fh,013h,04fh,054h,04dh,055h,05bh,010h,04bh,05bh	; 840c  ..qpY.O.OTMU[.K[
	defb 006h,003h,003h,00eh,013h,00bh,013h,019h,013h,00ah,00fh,030h,035h,038h,0feh,0f3h	; 841c  ...........058..
	defb 0ech,07ah,077h,072h,051h,04ch,055h,05bh,055h,04dh,055h,050h,003h,003h,019h,018h	; 842c  .zwrQLU[UMUP....
	defb 00eh,013h,04fh,00fh,007h,004h,036h,037h,038h,0feh,015h,0edh,07ah,079h,078h,004h	; 843c  ..O...678...zyx.
	defb 007h,051h,00dh,055h,050h,05ah,05bh,003h,00ah,004h,004h,004h,004h,036h,037h,038h	; 844c  .Q.UPZ[......678
	defb 0feh,037h,0edh,07ah,079h,078h,004h,004h,004h,004h,04ch,003h,007h,004h,004h,004h	; 845c  .7.zyx....L.....
	defb 036h,037h,038h,0feh,059h,0edh,07ah,079h,078h,004h,004h,004h,007h,004h,004h,036h	; 846c  678.Y.zyx......6
	defb 037h,038h,0feh,07bh,0edh,07ah,079h,078h,004h,004h,005h,006h,007h,0feh,09dh,0edh	; 847c  78.{.zyx........
	defb 013h,012h,011h,007h,0feh,0bfh,0edh,013h,0ffh	; 848c  .........

; ----------------------------------------------------------------------
; DATOS tira_8495: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x81FF[2] (327 bytes)
;   0x8495..0x85dc  (327 bytes)
DATA_tira_8495:
	defb 0e0h,0ebh,00fh,05ah,058h,00fh,049h,06ah,045h,0feh,0f9h,0ebh,068h,047h,06ch,00fh	; 8495  ...ZX.IjE...hGl.
	defb 07bh,07dh,00fh,054h,05bh,059h,061h,04ah,06eh,049h,007h,0feh,018h,0ech,007h,06ch	; 84a5  {}.T[YaJnI.....l
	defb 04bh,06dh,084h,07ch,07eh,077h,075h,05ch,041h,083h,063h,071h,04ah,043h,048h,0feh	; 84b5  Km.|~wu\A.cqJCH.
	defb 037h,0ech,06bh,066h,06dh,04eh,086h,060h,041h,07fh,052h,075h,05ah,078h,041h,05fh	; 84c5  7.kfmN.`A.RuZxA_
	defb 051h,04bh,064h,04ah,042h,065h,0feh,055h,0ech,042h,065h,06dh,087h,06eh,074h,082h	; 84d5  QKdJBe.U.Bem.nt.
	defb 041h,055h,07dh,052h,041h,05fh,058h,060h,055h,050h,055h,053h,04bh,064h,049h,044h	; 84e5  AU}RA_X`UPUSKdID
	defb 0feh,074h,0ech,067h,06ch,087h,06eh,076h,078h,073h,078h,083h,07bh,082h,041h,019h	; 84f5  .t.gl.nvxsx.{.A.
	defb 010h,052h,006h,00ah,052h,009h,052h,05ah,054h,022h,060h,020h,002h,002h,002h,002h	; 8505  .R..R.RZT"` ....
	defb 002h,002h,062h,01eh,064h,012h,018h,010h,04bh,010h,04ch,006h,010h,052h,05bh,003h	; 8515  ..b.d...K.L..R[.
	defb 00eh,013h,05ah,00eh,013h,00ah,052h,00ah,054h,00ah,016h,016h,020h,002h,002h,002h	; 8525  ..Z...R.T... ...
	defb 002h,062h,058h,058h,04ch,012h,04ch,010h,04ch,055h,050h,018h,055h,050h,003h,05bh	; 8535  .bXXL.L.LUP.UP.[
	defb 009h,052h,006h,009h,052h,00ch,013h,00ah,052h,00ah,052h,016h,02dh,02fh,005h,005h	; 8545  .R..R...R.R.-/..
	defb 071h,06fh,058h,010h,04ch,010h,04ch,055h,04eh,010h,04bh,006h,010h,04bh,019h,003h	; 8555  qoX.L.LUN.K..K..
	defb 00eh,013h,00bh,010h,050h,00ah,052h,009h,051h,031h,03ch,039h,0feh,0f3h,0ech,07bh	; 8565  ....P.R.Q1<9...{
	defb 07eh,073h,00fh,04bh,010h,04ch,00eh,052h,04dh,055h,050h,003h,018h,00eh,013h,003h	; 8575  ~s.K.L.RMUP.....
	defb 009h,051h,00fh,03ah,03bh,03ch,03dh,0feh,015h,0edh,07fh,07eh,07dh,07ch,051h,00fh	; 8585  .Q.:;<=....~}|Q.
	defb 04bh,003h,055h,050h,05ah,00ah,004h,004h,007h,004h,03ah,03bh,03ch,03dh,0feh,037h	; 8595  K.UPZ.....:;<=.7
	defb 0edh,07fh,07eh,07dh,07ch,004h,007h,004h,004h,04ch,004h,004h,004h,03ah,03bh,03ch	; 85a5  ..~}|....L...:;<
	defb 03dh,0feh,059h,0edh,07fh,07eh,07dh,07ch,004h,004h,004h,004h,03ah,03bh,03ch,03dh	; 85b5  =.Y..~}|....:;<=
	defb 0feh,07bh,0edh,07fh,07eh,07dh,07ch,004h,008h,009h,00ah,0feh,09dh,0edh,016h,015h	; 85c5  .{..~}|.........
	defb 014h,00ah,0feh,0bfh,0edh,016h,0ffh	; 85d5

; ----------------------------------------------------------------------
; DATOS tira_85DC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x81FF[3] (329 bytes)
;   0x85dc..0x8725  (329 bytes)
DATA_tira_85DC:
	defb 0e0h,0ebh,05ah,058h,00fh,00fh,04fh,04ah,007h,0feh,0f9h,0ebh,007h,06dh,072h,00fh	; 85dc  ..ZX..OJ.....mr.
	defb 00fh,07bh,07dh,05bh,053h,041h,083h,05dh,00fh,04dh,047h,0feh,018h,0ech,06ah,070h	; 85ec  .{}[SA.].MG...jp
	defb 00fh,080h,060h,041h,076h,07eh,05ch,061h,060h,075h,05dh,083h,04fh,04eh,007h,067h	; 85fc  ..`Av~\a`u].ON.g
	defb 0feh,036h,0ech,044h,007h,071h,072h,060h,080h,052h,083h,084h,07fh,05ch,041h,075h	; 860c  .6.D.qr`.R...\Au
	defb 075h,05dh,041h,080h,00fh,04fh,04ah,007h,0feh,055h,0ech,007h,06dh,072h,00fh,05dh	; 861c  u]A..OJ..U..mr.]
	defb 041h,080h,052h,052h,041h,07fh,05fh,058h,060h,041h,05ch,041h,062h,041h,080h,00fh	; 862c  A.RRA._X`A\AbA..
	defb 04dh,047h,0feh,074h,0ech,06ah,070h,00fh,05dh,041h,085h,041h,07fh,041h,083h,07bh	; 863c  MG.t.jp.]A.A.A.{
	defb 082h,010h,013h,006h,00ch,013h,05bh,055h,05bh,012h,016h,01fh,022h,021h,002h,002h	; 864c  ......[U[..."!..
	defb 002h,002h,002h,002h,063h,064h,061h,058h,054h,019h,013h,019h,055h,04eh,006h,055h	; 865c  ....cdaXT...UN.U
	defb 052h,00eh,013h,018h,00bh,010h,04ch,013h,05ah,013h,006h,013h,04fh,017h,021h,002h	; 866c  R.....L.Z...O.!.
	defb 002h,002h,002h,063h,059h,00dh,055h,006h,055h,018h,055h,00ah,052h,04dh,05ah,055h	; 867c  ...cY.U.U.U.RMZU
	defb 050h,009h,04bh,006h,019h,012h,04eh,013h,00dh,055h,00dh,055h,04fh,017h,02eh,02fh	; 868c  P.K...N..U.UO../
	defb 005h,005h,071h,070h,059h,00dh,013h,04fh,013h,04fh,055h,00ch,054h,05bh,006h,009h	; 869c  ..qpY..O.OU.T[..
	defb 04bh,00eh,013h,003h,00bh,010h,04ch,010h,014h,010h,011h,03eh,03fh,040h,0feh,0f3h	; 86ac  K.....L....>?@..
	defb 0ech,082h,081h,080h,053h,052h,056h,052h,00ah,052h,04dh,003h,055h,050h,00eh,054h	; 86bc  ....SRVR.RM.UP.T
	defb 018h,00ah,004h,011h,00fh,004h,03eh,03fh,040h,0feh,015h,0edh,082h,081h,080h,004h	; 86cc  ......>?@.......
	defb 051h,053h,004h,04ch,05ah,012h,050h,004h,004h,011h,00fh,004h,004h,03eh,03fh,040h	; 86dc  QS.LZ.P......>?@
	defb 0feh,037h,0edh,082h,081h,080h,004h,004h,051h,053h,004h,004h,004h,004h,004h,004h	; 86ec  .7......QS......
	defb 03eh,03fh,040h,0feh,059h,0edh,082h,081h,080h,004h,004h,004h,004h,004h,004h,03eh	; 86fc  >?@.Y..........>
	defb 03fh,040h,0feh,07bh,0edh,082h,081h,080h,004h,004h,00bh,00ch,00dh,0feh,09dh,0edh	; 870c  ?@.{............
	defb 019h,018h,017h,00dh,0feh,0bfh,0edh,019h,0ffh	; 871c  .........

; ----------------------------------------------------------------------
; DATOS guion_8725: guion comprimido que lee descomprime; lo cargan p01:60A2
;   (19 bytes)
;   0x8725..0x8738  (19 bytes)
DATA_guion_8725:
	defb 0e0h,0ebh,060h,001h,040h,001h,040h,002h,060h,001h,060h,001h,060h,001h,060h,001h	; 8725  ..`.@.@.`.`.`.`.
	defb 040h,001h,000h	; 8735

; ----------------------------------------------------------------------
; DATOS cuadros_8738: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x8738..0x8740  (8 bytes)
DATA_cuadros_8738:
	defb 040h,087h	; 8738
	defb 0dch,087h	; 873a
	defb 078h,088h	; 873c
	defb 014h,089h	; 873e

; ----------------------------------------------------------------------
; DATOS tira_8740: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8738[0] (156 bytes)
;   0x8740..0x87dc  (156 bytes)
DATA_tira_8740:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,029h,02ah,02ch,00ch,00ch,031h	; 8740  ..........)*,..1
	defb 030h,005h,005h,071h,072h,04dh,04dh,06dh,06bh,06ah,003h,003h,003h,003h,003h,003h	; 8750  0..qrMMmkj......
	defb 003h,003h,003h,003h,003h,003h,003h,01fh,032h,02fh,025h,01eh,033h,08ch,027h,001h	; 8760  ........2/%.3.'.
	defb 0feh,0f2h,0ech,001h,068h,04bh,074h,05fh,066h,070h,073h,060h,003h,003h,003h,003h	; 8770  ....hKt_fps`....
	defb 003h,003h,01fh,032h,02fh,02eh,025h,022h,018h,02dh,023h,01ch,0feh,015h,0edh,05dh	; 8780  ...2/.%".-#....]
	defb 064h,06eh,059h,063h,066h,06fh,070h,073h,060h,003h,003h,003h,022h,018h,02dh,02fh	; 8790  dnYcfops`...".-/
	defb 021h,024h,05ch,0feh,037h,0edh,01bh,065h,062h,070h,06eh,059h,063h,003h,003h,02eh	; 87a0  !$\.7..ebpnYc...
	defb 025h,022h,01ah,017h,028h,049h,0feh,059h,0edh,08ah,069h,058h,05bh,063h,066h,06fh	; 87b0  %"..(I.Y..iX[cfo
	defb 02dh,02fh,021h,024h,05ch,0feh,07bh,0edh,01bh,065h,062h,070h,06eh,002h,00dh,009h	; 87c0  -/!$\.{..ebpn...
	defb 0feh,09dh,0edh,016h,01ah,00fh,003h,0feh,0bfh,0edh,010h,0ffh	; 87d0  ............

; ----------------------------------------------------------------------
; DATOS tira_87DC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8738[1] (156 bytes)
;   0x87dc..0x8878  (156 bytes)
DATA_tira_87DC:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,029h,02ah,02ch,00fh,010h,00eh,034h	; 87dc  .........)*,...4
	defb 030h,005h,005h,071h,075h,04fh,051h,050h,06dh,06bh,06ah,003h,003h,003h,003h,003h	; 87ec  0..quOQPmkj.....
	defb 003h,003h,003h,003h,003h,003h,02bh,02ah,02ch,025h,01eh,033h,02fh,036h,035h,001h	; 87fc  ......+*,%.3/65.
	defb 0feh,0f2h,0ech,001h,076h,077h,070h,074h,05fh,066h,06dh,06bh,06ch,003h,003h,003h	; 880c  ....vwpt_fmkl...
	defb 003h,02bh,02ah,02ch,025h,022h,01eh,033h,02eh,021h,024h,006h,0feh,015h,0edh,006h	; 881c  .+*,%".3.!$.....
	defb 065h,062h,06fh,074h,05fh,063h,066h,06dh,06bh,06ch,022h,01eh,033h,02eh,025h,022h	; 882c  ebot_cfmkl".3.%"
	defb 019h,028h,027h,0feh,037h,0edh,068h,069h,05ah,063h,066h,06fh,074h,05fh,063h,003h	; 883c  .('.7.hiZcfot_c.
	defb 022h,01ah,02dh,02fh,023h,01ch,0feh,059h,0edh,05dh,064h,070h,06eh,05bh,063h,003h	; 884c  ".-/#..Y.]dpn[c.
	defb 025h,003h,01dh,05ch,001h,0feh,07bh,0edh,001h,01bh,05eh,003h,066h,00eh,00ah,004h	; 885c  %..\..{...^.f...
	defb 0feh,09dh,0edh,011h,017h,01bh,005h,0feh,0bfh,0edh,012h,0ffh	; 886c  ............

; ----------------------------------------------------------------------
; DATOS tira_8878: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8738[2] (156 bytes)
;   0x8878..0x8914  (156 bytes)
DATA_tira_8878:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,004h,02ah,02ch,003h,00dh,00ch,00ch,031h	; 8878  .........*,....1
	defb 030h,005h,005h,071h,072h,04dh,04dh,04eh,003h,06dh,06bh,004h,003h,003h,003h,003h	; 8888  0..qrMMN.mk.....
	defb 003h,003h,003h,003h,003h,02bh,02ah,02ch,025h,01eh,033h,02fh,013h,038h,027h,001h	; 8898  .....+*,%.3/.8'.
	defb 0feh,0f2h,0ech,001h,068h,079h,054h,070h,074h,05fh,066h,06dh,06bh,06ch,003h,003h	; 88a8  ....hyTpt_fmkl..
	defb 003h,003h,003h,003h,022h,01eh,033h,02eh,025h,01ah,017h,027h,0feh,015h,0edh,068h	; 88b8  ....".3.%..'...h
	defb 058h,05bh,066h,06fh,074h,05fh,063h,003h,003h,003h,032h,02fh,02eh,025h,022h,01ah	; 88c8  X[fot_c...2/.%".
	defb 026h,028h,01ch,0feh,037h,0edh,05dh,069h,067h,05bh,063h,066h,06fh,070h,073h,022h	; 88d8  &(..7.]ig[cfops"
	defb 018h,02dh,02fh,021h,024h,05ch,0feh,059h,0edh,01bh,065h,062h,070h,06eh,059h,063h	; 88e8  .-/!$\.Y..ebpnYc
	defb 022h,01ah,017h,028h,049h,0feh,07bh,0edh,08ah,069h,058h,05bh,063h,00ch,008h,003h	; 88f8  "..(I.{..iX[c...
	defb 0feh,09dh,0edh,010h,015h,019h,009h,0feh,0bfh,0edh,016h,0ffh	; 8908  ............

; ----------------------------------------------------------------------
; DATOS tira_8914: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8738[3] (156 bytes)
;   0x8914..0x89b0  (156 bytes)
DATA_tira_8914:
	defb 0c0h,0ech,003h,003h,003h,003h,003h,003h,003h,003h,003h,012h,003h,010h,00eh,034h	; 8914  ...............4
	defb 030h,005h,005h,071h,075h,04fh,051h,003h,053h,003h,003h,003h,003h,003h,003h,003h	; 8924  0..quOQ.S.......
	defb 003h,003h,003h,003h,02bh,02ah,02ch,025h,01fh,032h,02fh,025h,011h,037h,035h,001h	; 8934  ....+*,%.2/%.75.
	defb 0feh,0f2h,0ech,001h,076h,078h,052h,066h,070h,073h,060h,066h,06dh,06bh,06ch,003h	; 8944  ....vxRfps`fmkl.
	defb 003h,003h,003h,022h,01eh,033h,02eh,025h,022h,018h,026h,035h,0feh,015h,0edh,076h	; 8954  ...".3.%".&5...v
	defb 067h,059h,063h,066h,06fh,074h,05fh,063h,003h,003h,02ch,025h,003h,022h,01ah,02dh	; 8964  gYcfot_c..,%.".-
	defb 02fh,023h,01ch,0feh,037h,0edh,05dh,064h,070h,06eh,05bh,063h,003h,066h,06dh,033h	; 8974  /#..7.]dpn[c.fm3
	defb 02eh,025h,003h,01dh,05ch,001h,0feh,059h,0edh,001h,01bh,05eh,003h,066h,06fh,074h	; 8984  .%..\..Y...^.fot
	defb 01ah,02dh,02fh,023h,01ch,0feh,07bh,0edh,05dh,064h,070h,06eh,05bh,00bh,006h,005h	; 8994  .-/#..{.]dpn[...
	defb 0feh,09dh,0edh,012h,013h,018h,007h,0feh,0bfh,0edh,014h,0ffh	; 89a4  ............

; ----------------------------------------------------------------------
; DATOS guion_89B0: guion comprimido que lee descomprime; lo cargan p01:60D4
;   (19 bytes)
;   0x89b0..0x89c3  (19 bytes)
DATA_guion_89B0:
	defb 0e0h,0ebh,060h,001h,040h,001h,060h,001h,060h,001h,040h,001h,060h,001h,060h,001h	; 89b0  ..`.@.`.`.@.`.`.
	defb 040h,001h,000h	; 89c0

; ----------------------------------------------------------------------
; DATOS cuadros_89C3: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x89c3..0x89cb  (8 bytes)
DATA_cuadros_89C3:
	defb 0cbh,089h	; 89c3
	defb 010h,08bh	; 89c5
	defb 059h,08ch	; 89c7
	defb 0a0h,08dh	; 89c9

; ----------------------------------------------------------------------
; DATOS tira_89CB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x89C3[0] (325 bytes)
;   0x89cb..0x8b10  (325 bytes)
DATA_tira_89CB:
	defb 0e0h,0ebh,058h,00ch,056h,05eh,00ch,049h,0feh,0fah,0ebh,06ch,00ch,081h,079h,00ch	; 89cb  ..X.V^.I...l..y.
	defb 07bh,053h,075h,057h,05ch,061h,04ah,043h,048h,0feh,018h,0ech,06bh,066h,06dh,084h	; 89db  {SuW\aJCH...kfm.
	defb 07fh,07ah,052h,076h,061h,060h,075h,05dh,083h,04bh,064h,04ah,042h,045h,0feh,036h	; 89eb  .zRva`u].KdJBE.6
	defb 0ech,068h,065h,06dh,087h,06eh,060h,080h,052h,083h,084h,052h,041h,075h,05dh,041h	; 89fb  .hem.n`.R..RAu]A
	defb 05fh,051h,04bh,064h,049h,0feh,056h,0ech,06ch,087h,06eh,074h,082h,041h,080h,052h	; 8a0b  _QKdI.V.l.nt.A.R
	defb 041h,075h,052h,00ch,056h,05eh,060h,055h,050h,055h,053h,04bh,043h,048h,0feh,074h	; 8a1b  AuR.V^`UPUSKCH.t
	defb 0ech,06bh,066h,06eh,076h,078h,073h,078h,083h,081h,079h,00ch,075h,013h,006h,00ch	; 8a2b  .kfnvxsx..y.u...
	defb 013h,05ah,00ah,052h,00ch,054h,00ah,04ch,01eh,020h,002h,002h,002h,002h,002h,002h	; 8a3b  .Z.R.T.L. ......
	defb 062h,060h,00ah,04ch,012h,04eh,010h,04ch,018h,055h,04eh,006h,055h,04eh,018h,00bh	; 8a4b  b`.L.N.L.UN.UN..
	defb 010h,04bh,00bh,013h,00ah,052h,00ah,052h,00ah,016h,020h,002h,002h,002h,002h,062h	; 8a5b  .K...R.R.. ....b
	defb 058h,04ch,010h,04ch,010h,04ch,055h,04dh,009h,052h,04dh,05ah,00ch,013h,006h,019h	; 8a6b  XL.L.LUM.RMZ....
	defb 012h,04eh,00ch,054h,00bh,013h,016h,013h,016h,016h,02dh,02fh,005h,005h,071h,06fh	; 8a7b  .N.T......-/..qo
	defb 058h,058h,055h,058h,055h,04dh,012h,04ch,00ch,054h,05bh,006h,055h,04eh,003h,00bh	; 8a8b  XXUXUM.L.T[.UN..
	defb 010h,04bh,003h,055h,019h,055h,015h,032h,033h,034h,0feh,0f3h,0ech,076h,075h,074h	; 8a9b  .K.U.U.234...vut
	defb 057h,013h,05bh,013h,003h,009h,052h,04dh,003h,00ch,04eh,019h,00bh,010h,052h,015h	; 8aab  W.[...RM..N...R.
	defb 004h,008h,032h,033h,034h,0feh,015h,0edh,076h,075h,074h,008h,004h,057h,010h,052h	; 8abb  ..234...vut..W.R
	defb 04dh,05bh,00ch,057h,003h,00ah,004h,004h,004h,032h,033h,034h,0feh,037h,0edh,076h	; 8acb  M[.W.....234.7.v
	defb 075h,074h,004h,004h,004h,04ch,003h,015h,004h,008h,004h,004h,032h,033h,034h,0feh	; 8adb  ut...L......234.
	defb 059h,0edh,076h,075h,074h,004h,004h,008h,004h,004h,004h,032h,033h,034h,0feh,07bh	; 8aeb  Y.vut......234.{
	defb 0edh,076h,075h,074h,004h,004h,002h,003h,004h,0feh,09dh,0edh,010h,00fh,00eh,004h	; 8afb  .vut............
	defb 0feh,0bfh,0edh,010h,0ffh	; 8b0b

; ----------------------------------------------------------------------
; DATOS tira_8B10: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x89C3[1] (329 bytes)
;   0x8b10..0x8c59  (329 bytes)
DATA_tira_8B10:
	defb 0e0h,0ebh,00ch,00ch,05ah,058h,04eh,007h,046h,0feh,0f9h,0ebh,069h,007h,071h,07bh	; 8b10  ....ZXN.F...i.q{
	defb 07dh,00ch,00ch,060h,054h,05bh,059h,083h,04ch,04bh,045h,0feh,018h,0ech,068h,06eh	; 8b20  }..`T[Y.LKE...hn
	defb 06fh,060h,07ch,07eh,077h,083h,00ch,075h,05ch,041h,040h,04fh,00ch,04dh,047h,007h	; 8b30  o`|~w..u\A@O.MG.
	defb 0feh,036h,0ech,007h,06ah,070h,00ch,072h,040h,041h,07fh,052h,00ch,041h,075h,05ah	; 8b40  .6..jp.r@A.R.AuZ
	defb 078h,057h,05eh,083h,04fh,04eh,045h,046h,0feh,055h,0ech,069h,068h,071h,072h,060h	; 8b50  xW^.ONEF.U.ihqr`
	defb 081h,07ah,055h,07dh,052h,041h,060h,041h,05fh,058h,041h,081h,041h,080h,00ch,04fh	; 8b60  .zU}RA`A_XA.A..O
	defb 04bh,045h,0feh,074h,0ech,068h,06eh,072h,00ch,05dh,041h,05eh,041h,07bh,082h,041h	; 8b70  KE.t.hnr.]A^A{.A
	defb 083h,006h,019h,010h,057h,006h,013h,05ah,012h,00dh,055h,018h,01fh,021h,002h,002h	; 8b80  ....W..Z..U..!..
	defb 002h,002h,002h,002h,063h,061h,05ah,013h,04fh,054h,018h,055h,006h,015h,052h,05bh	; 8b90  ....caZ.OT.U..R[
	defb 006h,019h,003h,00eh,013h,00ch,013h,05ah,013h,00bh,013h,05ah,013h,017h,021h,002h	; 8ba0  .......Z...Z..!.
	defb 002h,002h,002h,063h,059h,055h,018h,055h,04dh,055h,018h,055h,04eh,055h,050h,003h	; 8bb0  ...cYU.UMU.UNUP.
	defb 05bh,006h,019h,009h,052h,019h,013h,00bh,012h,00dh,055h,00dh,055h,017h,02eh,02fh	; 8bc0  [...R.....U.U../
	defb 005h,005h,071h,070h,059h,013h,04fh,013h,04fh,054h,04dh,055h,05bh,010h,04bh,05bh	; 8bd0  ..qpY.O.OTMU[.K[
	defb 006h,003h,003h,00eh,013h,00bh,013h,019h,013h,00ah,00fh,030h,035h,038h,0feh,0f3h	; 8be0  ...........058..
	defb 0ech,07ah,077h,072h,051h,04ch,055h,05bh,055h,04dh,055h,050h,003h,003h,019h,018h	; 8bf0  .zwrQLU[UMUP....
	defb 00eh,013h,04fh,00fh,007h,004h,036h,037h,038h,0feh,015h,0edh,07ah,079h,078h,004h	; 8c00  ..O...678...zyx.
	defb 007h,051h,00dh,055h,050h,05ah,05bh,003h,00ah,004h,004h,004h,004h,036h,037h,038h	; 8c10  .Q.UPZ[......678
	defb 0feh,037h,0edh,07ah,079h,078h,004h,004h,004h,004h,04ch,003h,007h,004h,004h,004h	; 8c20  .7.zyx....L.....
	defb 036h,037h,038h,0feh,059h,0edh,07ah,079h,078h,004h,004h,004h,007h,004h,004h,036h	; 8c30  678.Y.zyx......6
	defb 037h,038h,0feh,07bh,0edh,07ah,079h,078h,004h,004h,005h,006h,007h,0feh,09dh,0edh	; 8c40  78.{.zyx........
	defb 013h,012h,011h,007h,0feh,0bfh,0edh,013h,0ffh	; 8c50  .........

; ----------------------------------------------------------------------
; DATOS tira_8C59: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x89C3[2] (327 bytes)
;   0x8c59..0x8da0  (327 bytes)
DATA_tira_8C59:
	defb 0e0h,0ebh,00ch,05ah,058h,00ch,049h,06ah,045h,0feh,0f9h,0ebh,068h,047h,06ch,00ch	; 8c59  ...ZX.IjE...hGl.
	defb 07bh,07dh,00ch,054h,05bh,059h,061h,04ah,06eh,049h,007h,0feh,018h,0ech,007h,06ch	; 8c69  {}.T[YaJnI.....l
	defb 04bh,06dh,084h,07ch,07eh,077h,075h,05ch,041h,083h,063h,071h,04ah,043h,048h,0feh	; 8c79  Km.|~wu\A.cqJCH.
	defb 037h,0ech,06bh,066h,06dh,04eh,086h,060h,041h,07fh,052h,075h,05ah,078h,041h,05fh	; 8c89  7.kfmN.`A.RuZxA_
	defb 051h,04bh,064h,04ah,042h,065h,0feh,055h,0ech,042h,065h,06dh,087h,06eh,074h,082h	; 8c99  QKdJBe.U.Bem.nt.
	defb 041h,055h,07dh,052h,041h,05fh,058h,060h,055h,050h,055h,053h,04bh,064h,049h,044h	; 8ca9  AU}RA_X`UPUSKdID
	defb 0feh,074h,0ech,067h,06ch,087h,06eh,076h,078h,073h,078h,083h,07bh,082h,041h,019h	; 8cb9  .t.gl.nvxsx.{.A.
	defb 010h,052h,006h,00ah,052h,009h,052h,05ah,054h,022h,060h,020h,002h,002h,002h,002h	; 8cc9  .R..R.RZT"` ....
	defb 002h,002h,062h,01eh,064h,012h,018h,010h,04bh,010h,04ch,006h,010h,052h,05bh,003h	; 8cd9  ..b.d...K.L..R[.
	defb 00eh,013h,05ah,00eh,013h,00ah,052h,00ah,054h,00ah,016h,016h,020h,002h,002h,002h	; 8ce9  ..Z...R.T... ...
	defb 002h,062h,058h,058h,04ch,012h,04ch,010h,04ch,055h,050h,018h,055h,050h,003h,05bh	; 8cf9  .bXXL.L.LUP.UP.[
	defb 009h,052h,006h,009h,052h,00ch,013h,00ah,052h,00ah,052h,016h,02dh,02fh,005h,005h	; 8d09  .R..R...R.R.-/..
	defb 071h,06fh,058h,010h,04ch,010h,04ch,055h,04eh,010h,04bh,006h,010h,04bh,019h,003h	; 8d19  qoX.L.LUN.K..K..
	defb 00eh,013h,00bh,010h,050h,00ah,052h,009h,051h,031h,03ch,039h,0feh,0f3h,0ech,07bh	; 8d29  ....P.R.Q1<9...{
	defb 07eh,073h,00fh,04bh,010h,04ch,00eh,052h,04dh,055h,050h,003h,018h,00eh,013h,003h	; 8d39  ~s.K.L.RMUP.....
	defb 009h,051h,00fh,03ah,03bh,03ch,03dh,0feh,015h,0edh,07fh,07eh,07dh,07ch,051h,00fh	; 8d49  .Q.:;<=....~}|Q.
	defb 04bh,003h,055h,050h,05ah,00ah,004h,004h,007h,004h,03ah,03bh,03ch,03dh,0feh,037h	; 8d59  K.UPZ.....:;<=.7
	defb 0edh,07fh,07eh,07dh,07ch,004h,007h,004h,004h,04ch,004h,004h,004h,03ah,03bh,03ch	; 8d69  ..~}|....L...:;<
	defb 03dh,0feh,059h,0edh,07fh,07eh,07dh,07ch,004h,004h,004h,004h,03ah,03bh,03ch,03dh	; 8d79  =.Y..~}|....:;<=
	defb 0feh,07bh,0edh,07fh,07eh,07dh,07ch,004h,008h,009h,00ah,0feh,09dh,0edh,016h,015h	; 8d89  .{..~}|.........
	defb 014h,00ah,0feh,0bfh,0edh,016h,0ffh	; 8d99

; ----------------------------------------------------------------------
; DATOS tira_8DA0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x89C3[3] (329 bytes)
;   0x8da0..0x8ee9  (329 bytes)
DATA_tira_8DA0:
	defb 0e0h,0ebh,05ah,058h,00ch,00ch,04fh,04ah,007h,0feh,0f9h,0ebh,007h,06dh,072h,00ch	; 8da0  ..ZX..OJ.....mr.
	defb 00ch,07bh,07dh,05bh,053h,041h,083h,05dh,00ch,04dh,047h,0feh,018h,0ech,06ah,070h	; 8db0  .{}[SA.].MG...jp
	defb 00ch,080h,060h,041h,076h,07eh,05ch,061h,060h,075h,05dh,083h,04fh,04eh,007h,067h	; 8dc0  ..`Av~\a`u].ON.g
	defb 0feh,036h,0ech,044h,007h,071h,072h,060h,080h,052h,083h,084h,07fh,05ch,041h,075h	; 8dd0  .6.D.qr`.R...\Au
	defb 075h,05dh,041h,080h,00ch,04fh,04ah,007h,0feh,055h,0ech,007h,06dh,072h,00ch,05dh	; 8de0  u]A..OJ..U..mr.]
	defb 041h,080h,052h,052h,041h,07fh,05fh,058h,060h,041h,05ch,041h,062h,041h,080h,00ch	; 8df0  A.RRA._X`A\AbA..
	defb 04dh,047h,0feh,074h,0ech,06ah,070h,00ch,05dh,041h,085h,041h,07fh,041h,083h,07bh	; 8e00  MG.t.jp.]A.A.A.{
	defb 082h,010h,013h,006h,00ch,013h,05bh,055h,05bh,012h,016h,01fh,022h,021h,002h,002h	; 8e10  ......[U[..."!..
	defb 002h,002h,002h,002h,063h,064h,061h,058h,054h,019h,013h,019h,055h,04eh,006h,055h	; 8e20  ....cdaXT...UN.U
	defb 052h,00eh,013h,018h,00bh,010h,04ch,013h,05ah,013h,006h,013h,04fh,017h,021h,002h	; 8e30  R.....L.Z...O.!.
	defb 002h,002h,002h,063h,059h,00dh,055h,006h,055h,018h,055h,00ah,052h,04dh,05ah,055h	; 8e40  ...cY.U.U.U.RMZU
	defb 050h,009h,04bh,006h,019h,012h,04eh,013h,00dh,055h,00dh,055h,04fh,017h,02eh,02fh	; 8e50  P.K...N..U.UO../
	defb 005h,005h,071h,070h,059h,00dh,013h,04fh,013h,04fh,055h,00ch,054h,05bh,006h,009h	; 8e60  ..qpY..O.OU.T[..
	defb 04bh,00eh,013h,003h,00bh,010h,04ch,010h,014h,010h,011h,03eh,03fh,040h,0feh,0f3h	; 8e70  K.....L....>?@..
	defb 0ech,082h,081h,080h,053h,052h,056h,052h,00ah,052h,04dh,003h,055h,050h,00eh,054h	; 8e80  ....SRVR.RM.UP.T
	defb 018h,00ah,004h,011h,00fh,004h,03eh,03fh,040h,0feh,015h,0edh,082h,081h,080h,004h	; 8e90  ......>?@.......
	defb 051h,053h,004h,04ch,05ah,012h,050h,004h,004h,011h,00fh,004h,004h,03eh,03fh,040h	; 8ea0  QS.LZ.P......>?@
	defb 0feh,037h,0edh,082h,081h,080h,004h,004h,051h,053h,004h,004h,004h,004h,004h,004h	; 8eb0  .7......QS......
	defb 03eh,03fh,040h,0feh,059h,0edh,082h,081h,080h,004h,004h,004h,004h,004h,004h,03eh	; 8ec0  >?@.Y..........>
	defb 03fh,040h,0feh,07bh,0edh,082h,081h,080h,004h,004h,00bh,00ch,00dh,0feh,09dh,0edh	; 8ed0  ?@.{............
	defb 019h,018h,017h,00dh,0feh,0bfh,0edh,019h,0ffh	; 8ee0  .........

; ----------------------------------------------------------------------
; DATOS guion_8EE9: guion comprimido que lee descomprime; lo cargan p01:6103
;   (22 bytes)
;   0x8ee9..0x8eff  (22 bytes)
DATA_guion_8EE9:
	defb 0e0h,0ebh,060h,001h,040h,001h,020h,003h,080h,0c0h,0ech,060h,001h,060h,001h,060h	; 8ee9  ..`.@. ....`.`.`
	defb 001h,060h,001h,040h,001h,000h	; 8ef9

; ----------------------------------------------------------------------
; DATOS cuadros_8EFF: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x8eff..0x8f07  (8 bytes)
DATA_cuadros_8EFF:
	defb 007h,08fh	; 8eff
	defb 07eh,08fh	; 8f01
	defb 0f5h,08fh	; 8f03
	defb 075h,090h	; 8f05

; ----------------------------------------------------------------------
; DATOS tira_8F07: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8EFF[0] (119 bytes)
;   0x8f07..0x8f7e  (119 bytes)
DATA_tira_8F07:
	defb 0c0h,0ech,001h,001h,001h,001h,001h,001h,01fh,06ch,001h,001h,001h,03ch,034h,030h	; 8f07  .........l...<40
	defb 001h,001h,001h,001h,07dh,081h,089h,001h,001h,001h,01fh,06ch,001h,001h,001h,001h	; 8f17  ....}......l....
	defb 001h,001h,0feh,0e5h,0ech,014h,01bh,002h,01dh,001h,001h,0feh,0ech,0ech,001h,0feh	; 8f27  ................
	defb 0f3h,0ech,001h,0feh,0f5h,0ech,001h,001h,06ah,002h,068h,061h,0feh,000h,0edh,001h	; 8f37  ........j.ha....
	defb 0feh,005h,0edh,029h,00ah,00ah,076h,001h,0feh,016h,0edh,001h,029h,00ah,00ah,076h	; 8f47  ...)..v.....)..v
	defb 0feh,01fh,0edh,001h,001h,0feh,026h,0edh,05eh,011h,0feh,038h,0edh,05eh,011h,0feh	; 8f57  ......&.^..8.^..
	defb 03fh,0edh,001h,001h,001h,0feh,05eh,0edh,001h,001h,001h,001h,0feh,07eh,0edh,001h	; 8f67  ?.....^......~..
	defb 001h,001h,0feh,09fh,0edh,001h,0ffh	; 8f77

; ----------------------------------------------------------------------
; DATOS tira_8F7E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8EFF[1] (119 bytes)
;   0x8f7e..0x8ff5  (119 bytes)
DATA_tira_8F7E:
	defb 0c0h,0ech,001h,001h,001h,001h,00bh,0feh,0c6h,0ech,001h,001h,001h,001h,044h,025h	; 8f7e  ..............D%
	defb 035h,030h,001h,001h,001h,001h,07dh,082h,072h,091h,001h,001h,001h,001h,0feh,0dbh	; 8f8e  50....}.r.......
	defb 0ech,00bh,001h,001h,001h,001h,0feh,0e2h,0ech,014h,055h,002h,019h,001h,001h,001h	; 8f9e  ..........U.....
	defb 0feh,0ebh,0ech,00eh,0feh,0f4h,0ech,00eh,0feh,0f7h,0ech,001h,001h,001h,066h,002h	; 8fae  ..............f.
	defb 0a2h,061h,0feh,001h,0edh,012h,013h,01eh,002h,002h,019h,001h,001h,0feh,017h,0edh	; 8fbe  .a..............
	defb 001h,001h,066h,002h,002h,06bh,060h,05fh,0feh,022h,0edh,02fh,00ah,00ah,00ah,02dh	; 8fce  ..f..k`_."./...-
	defb 001h,0feh,038h,0edh,001h,07ah,00ah,00ah,00ah,07ch,0feh,043h,0edh,05eh,00fh,011h	; 8fde  ..8..z...|.C.^..
	defb 0feh,05ah,0edh,05eh,00fh,011h,0ffh	; 8fee

; ----------------------------------------------------------------------
; DATOS tira_8FF5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8EFF[2] (128 bytes)
;   0x8ff5..0x9075  (128 bytes)
DATA_tira_8FF5:
	defb 0c0h,0ech,001h,069h,001h,001h,001h,0feh,0c6h,0ech,001h,001h,001h,015h,01ah,001h	; 8ff5  ...i............
	defb 035h,030h,001h,001h,001h,001h,07dh,082h,001h,067h,062h,001h,001h,001h,0feh,0dbh	; 9005  50....}..gb.....
	defb 0ech,001h,001h,001h,01ch,001h,014h,075h,019h,001h,001h,001h,0feh,0e7h,0ech,001h	; 9015  .......u........
	defb 001h,02eh,05ch,031h,0feh,0f4h,0ech,07eh,0a9h,07bh,001h,001h,0feh,0fah,0ech,001h	; 9025  ..\1...~.{......
	defb 001h,001h,066h,028h,061h,055h,002h,002h,019h,001h,001h,001h,0feh,019h,0edh,001h	; 9035  ..f(aU..........
	defb 001h,001h,066h,002h,002h,0a2h,01eh,002h,002h,002h,019h,001h,001h,0feh,039h,0edh	; 9045  ..f...........9.
	defb 001h,001h,066h,002h,002h,002h,06bh,00ah,00ah,00ah,038h,024h,001h,0feh,05ah,0edh	; 9055  ..f...k...8$..Z.
	defb 001h,071h,085h,00ah,00ah,00ah,05eh,00fh,011h,0feh,07dh,0edh,05eh,00fh,011h,0ffh	; 9065  .q....^...}.^...

; ----------------------------------------------------------------------
; DATOS tira_9075: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x8EFF[3] (122 bytes)
;   0x9075..0x90ef  (122 bytes)
DATA_tira_9075:
	defb 0c0h,0ech,001h,001h,001h,001h,001h,001h,001h,001h,01fh,06ch,001h,001h,035h,030h	; 9075  ...........l..50
	defb 001h,001h,001h,001h,07dh,082h,001h,001h,01fh,06ch,001h,001h,001h,001h,001h,001h	; 9085  ....}....l......
	defb 001h,001h,001h,001h,001h,0feh,0e7h,0ech,037h,027h,00dh,02ah,001h,001h,0feh,0f4h	; 9095  ........7'.*....
	defb 0ech,001h,077h,00dh,074h,084h,0feh,0fdh,0ech,001h,001h,001h,021h,001h,001h,001h	; 90a5  ..w.t.......!...
	defb 0feh,008h,0edh,05eh,011h,0feh,016h,0edh,05eh,011h,0feh,01ch,0edh,001h,001h,001h	; 90b5  ...^....^.......
	defb 06eh,019h,001h,001h,001h,001h,0feh,03bh,0edh,001h,001h,001h,001h,066h,002h,020h	; 90c5  n......;.....f.
	defb 001h,001h,001h,0feh,05bh,0edh,001h,001h,001h,06dh,002h,009h,032h,001h,0feh,07dh	; 90d5  ....[....m..2..}
	defb 0edh,001h,07fh,009h,002h,0feh,09fh,0edh,003h,0ffh	; 90e5  ..........

; ----------------------------------------------------------------------
; DATOS guion_90EF: guion comprimido que lee descomprime; lo cargan p01:6135
;   (19 bytes)
;   0x90ef..0x9102  (19 bytes)
DATA_guion_90EF:
	defb 0e0h,0ebh,060h,001h,040h,001h,060h,001h,060h,001h,040h,001h,060h,001h,060h,001h	; 90ef  ..`.@.`.`.@.`.`.
	defb 040h,001h,000h	; 90ff

; ----------------------------------------------------------------------
; DATOS cuadros_9102: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x9102..0x910a  (8 bytes)
DATA_cuadros_9102:
	defb 00ah,091h	; 9102
	defb 096h,092h	; 9104
	defb 020h,094h	; 9106
	defb 0abh,095h	; 9108

; ----------------------------------------------------------------------
; DATOS tira_910A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9102[0] (396 bytes)
;   0x910a..0x9296  (396 bytes)
DATA_tira_910A:
	defb 0e0h,0ebh,04dh,04fh,055h,040h,040h,069h,042h,042h,042h,042h,042h,042h,042h,06dh	; 910a  ..MOU@@iBBBBBBBm
	defb 043h,063h,088h,043h,092h,042h,042h,042h,042h,042h,042h,042h,08eh,040h,040h,07ah	; 911a  Cc.C.BBBBBBB.@@z
	defb 04fh,04dh,05fh,052h,052h,040h,040h,040h,067h,069h,042h,042h,042h,042h,042h,042h	; 912a  OM_RR@@@giBBBBBB
	defb 043h,044h,045h,043h,042h,042h,042h,042h,042h,042h,08eh,08ch,040h,040h,040h,052h	; 913a  CDECBBBBBB..@@@R
	defb 052h,084h,05eh,052h,056h,061h,062h,04dh,04fh,054h,069h,067h,068h,042h,042h,042h	; 914a  R.^RVabMOTighBBB
	defb 06dh,046h,047h,092h,042h,042h,042h,08dh,08ch,08eh,079h,04fh,04dh,087h,086h,07bh	; 915a  mFG.BBB...yOM..{
	defb 052h,083h,05eh,052h,05dh,066h,04eh,05eh,052h,057h,040h,040h,069h,069h,042h,042h	; 916a  R.^R]fN^RW@@iiBB
	defb 042h,048h,049h,042h,042h,042h,08eh,08eh,040h,040h,07ch,052h,083h,04eh,08bh,082h	; 917a  BHIBBB..@@|R.N..
	defb 052h,083h,05eh,052h,05dh,065h,04eh,05eh,052h,05dh,064h,04ch,051h,058h,069h,042h	; 918a  R.^R]eN^R]dLQXiB
	defb 042h,04ah,04bh,042h,042h,08eh,07dh,051h,04ch,089h,082h,052h,083h,04eh,08ah,082h	; 919a  BJKBB.}QL..R.N..
	defb 052h,083h,05dh,004h,01eh,027h,005h,05dh,004h,01bh,027h,014h,004h,01dh,02dh,055h	; 91aa  R.]..'.]..'...-U
	defb 054h,008h,009h,0a3h,0a4h,07ch,06ch,004h,063h,076h,06ah,004h,00eh,005h,076h,06dh	; 91ba  T....|l.cvj...vm
	defb 004h,00eh,004h,004h,004h,028h,005h,014h,004h,01eh,027h,011h,004h,01eh,019h,016h	; 91ca  .....(....'.....
	defb 041h,00ah,00bh,090h,065h,068h,06dh,004h,060h,076h,06dh,004h,063h,005h,077h,004h	; 91da  A...ehm.`vm.c.w.
	defb 004h,004h,004h,004h,004h,01eh,005h,011h,004h,004h,028h,025h,014h,004h,018h,03bh	; 91ea  ..........(%...;
	defb 049h,00fh,05eh,098h,08ah,067h,004h,063h,074h,077h,004h,004h,060h,005h,06dh,004h	; 91fa  I.^..g.ctw..`.m.
	defb 004h,004h,014h,004h,004h,004h,028h,025h,014h,004h,021h,043h,034h,036h,037h,001h	; 920a  ......(%..!C467.
	defb 0feh,0f2h,0ech,001h,086h,085h,083h,092h,070h,004h,063h,074h,077h,004h,004h,004h	; 921a  ........p.ctw...
	defb 063h,011h,004h,004h,004h,021h,043h,02fh,006h,034h,037h,032h,001h,0feh,014h,0edh	; 922a  c....!C/.472....
	defb 001h,081h,086h,083h,006h,07eh,092h,070h,004h,004h,004h,060h,005h,014h,004h,012h	; 923a  .....~.p...`....
	defb 05ch,034h,036h,037h,032h,001h,0feh,036h,0edh,001h,081h,086h,085h,083h,05ch,061h	; 924a  \4672..6......\a
	defb 004h,063h,005h,02bh,006h,006h,034h,037h,032h,001h,001h,001h,0feh,057h,0edh,001h	; 925a  .c.+..472....W..
	defb 001h,001h,081h,086h,083h,006h,006h,07ah,006h,034h,037h,032h,001h,001h,0feh,07ah	; 926a  .......z.472...z
	defb 0edh,001h,001h,081h,086h,083h,006h,003h,002h,001h,001h,0feh,09ch,0edh,001h,001h	; 927a  ................
	defb 00ah,00bh,001h,001h,001h,0feh,0bdh,0edh,001h,001h,001h,0ffh	; 928a  ............

; ----------------------------------------------------------------------
; DATOS tira_9296: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9102[1] (394 bytes)
;   0x9296..0x9420  (394 bytes)
DATA_tira_9296:
	defb 0e0h,0ebh,050h,059h,040h,040h,041h,067h,042h,042h,042h,042h,042h,042h,042h,06ah	; 9296  ..PY@@AgBBBBBBBj
	defb 043h,063h,088h,043h,08fh,042h,042h,042h,042h,042h,042h,042h,08ch,041h,040h,040h	; 92a6  Cc.C.BBBBBBB.A@@
	defb 07eh,050h,052h,052h,040h,040h,040h,040h,041h,069h,067h,068h,042h,042h,042h,042h	; 92b6  ~PRR@@@@AighBBBB
	defb 043h,044h,045h,043h,042h,042h,042h,042h,08dh,08ch,08eh,041h,040h,040h,040h,040h	; 92c6  CDECBBBB...A@@@@
	defb 052h,052h,052h,056h,064h,04eh,05fh,051h,058h,040h,040h,069h,042h,042h,042h,042h	; 92d6  RRRVdN_QX@@iBBBB
	defb 06ah,046h,047h,08fh,042h,042h,042h,042h,08eh,040h,040h,07dh,051h,084h,04eh,089h	; 92e6  jFG.BBBB.@@}Q.N.
	defb 07bh,052h,052h,05dh,066h,04eh,05eh,052h,057h,040h,040h,040h,041h,068h,042h,042h	; 92f6  {RR]fN^RW@@@AhBB
	defb 042h,048h,049h,042h,042h,042h,08dh,041h,040h,040h,040h,07ch,052h,083h,04eh,08bh	; 9306  BHIBBB.A@@@|R.N.
	defb 082h,052h,052h,05dh,065h,04eh,05eh,052h,05dh,064h,05eh,052h,058h,040h,067h,042h	; 9316  .RR]eN^R]d^RX@gB
	defb 042h,04ah,04bh,042h,042h,08ch,040h,07dh,052h,084h,089h,082h,052h,083h,04eh,08ah	; 9326  BJKBB.@}R...R.N.
	defb 082h,052h,004h,01eh,027h,005h,05dh,004h,01bh,027h,014h,004h,01dh,02eh,020h,055h	; 9336  .R..'.]..'.... U
	defb 054h,008h,009h,0a3h,0a4h,06fh,07dh,06ch,004h,063h,076h,06ah,004h,00eh,005h,076h	; 9346  T....o}l.cvj...v
	defb 06dh,004h,004h,004h,028h,005h,014h,004h,01eh,027h,011h,004h,00eh,010h,030h,038h	; 9356  m...(....'....08
	defb 045h,00ah,00bh,094h,087h,07fh,05fh,05dh,004h,060h,076h,06dh,004h,063h,005h,077h	; 9366  E....._].`vm.c.w
	defb 004h,004h,004h,004h,01eh,005h,011h,004h,004h,028h,025h,012h,004h,00dh,015h,039h	; 9376  .........(%....9
	defb 046h,00fh,05eh,095h,088h,064h,05ch,004h,061h,074h,077h,004h,004h,060h,005h,06dh	; 9386  F.^..d\.atw..`.m
	defb 004h,004h,004h,004h,004h,026h,025h,014h,004h,021h,043h,017h,040h,044h,037h,032h	; 9396  .....&%..!C.@D72
	defb 0feh,0f2h,0ech,081h,086h,093h,08fh,066h,092h,070h,004h,063h,074h,075h,004h,004h	; 93a6  .......f.p.ctu..
	defb 004h,004h,004h,004h,021h,043h,022h,007h,012h,034h,037h,032h,001h,0feh,014h,0edh	; 93b6  ....!C"..472....
	defb 001h,081h,086h,083h,061h,007h,071h,092h,070h,004h,004h,004h,014h,004h,004h,01ah	; 93c6  ....a.q.p.......
	defb 035h,006h,034h,037h,032h,001h,0feh,036h,0edh,001h,081h,086h,083h,006h,084h,069h	; 93d6  5.472..6.......i
	defb 004h,004h,063h,02bh,006h,006h,03fh,04ah,032h,001h,001h,001h,0feh,057h,0edh,001h	; 93e6  ..c+..?J2....W..
	defb 001h,001h,081h,099h,08eh,006h,006h,07ah,006h,03fh,044h,032h,001h,001h,0feh,07ah	; 93f6  .......z.?D2...z
	defb 0edh,001h,001h,081h,093h,08eh,006h,005h,004h,001h,001h,0feh,09ch,0edh,001h,001h	; 9406  ................
	defb 00ch,00dh,001h,001h,0feh,0beh,0edh,001h,001h,0ffh	; 9416  ..........

; ----------------------------------------------------------------------
; DATOS tira_9420: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9102[2] (395 bytes)
;   0x9420..0x95ab  (395 bytes)
DATA_tira_9420:
	defb 0e0h,0ebh,040h,040h,040h,040h,041h,069h,042h,042h,042h,042h,042h,042h,042h,06dh	; 9420  ..@@@@AiBBBBBBBm
	defb 043h,063h,088h,043h,092h,042h,042h,042h,042h,042h,042h,042h,08eh,041h,040h,040h	; 9430  Cc.C.BBBBBBB.A@@
	defb 040h,040h,040h,061h,04dh,04fh,04fh,054h,041h,067h,068h,042h,042h,042h,042h,042h	; 9440  @@@aMOOTAghBBBBB
	defb 043h,044h,045h,043h,042h,042h,042h,042h,042h,08dh,08ch,041h,079h,04fh,04fh,04dh	; 9450  CDECBBBBB..AyOOM
	defb 086h,040h,064h,04eh,04eh,052h,052h,057h,040h,040h,069h,067h,042h,042h,042h,042h	; 9460  .@dNNRRW@@igBBBB
	defb 06dh,046h,047h,092h,042h,042h,042h,042h,08ch,08eh,040h,040h,07ch,052h,052h,04eh	; 9470  mFG.BBBB..@@|RRN
	defb 04eh,089h,066h,04eh,05eh,052h,052h,05bh,061h,04dh,04fh,054h,041h,069h,042h,042h	; 9480  N.fN^RR[aMOTAiBB
	defb 042h,048h,049h,042h,042h,042h,08eh,041h,079h,04fh,04dh,086h,080h,052h,052h,083h	; 9490  BHIBBB.AyOM..RR.
	defb 04eh,08bh,066h,04eh,05eh,052h,052h,05dh,066h,05eh,052h,057h,040h,040h,041h,042h	; 94a0  N.fN^RR]f^RW@@AB
	defb 042h,04ah,04bh,042h,042h,041h,040h,040h,07ch,052h,083h,08bh,082h,052h,052h,083h	; 94b0  BJKBBA@@|R...RR.
	defb 04eh,08bh,027h,005h,011h,004h,004h,01bh,027h,014h,004h,01bh,027h,004h,01ch,056h	; 94c0  N.'.....'...'..V
	defb 054h,008h,009h,0a3h,0a5h,06bh,004h,076h,06ah,004h,063h,076h,06ah,004h,004h,060h	; 94d0  T....k.vj.cvj..`
	defb 005h,076h,027h,005h,014h,004h,004h,01eh,027h,011h,004h,01eh,027h,014h,03ah,03ah	; 94e0  .v'.....'...'.::
	defb 041h,00ah,00bh,090h,089h,089h,063h,076h,06dh,004h,060h,076h,06dh,004h,004h,063h	; 94f0  A.....cvm.`vm..c
	defb 005h,076h,028h,005h,011h,004h,004h,004h,028h,025h,014h,004h,028h,024h,00ch,03dh	; 9500  .v(.....(%..($.=
	defb 049h,00fh,05eh,098h,08ch,05bh,073h,077h,004h,063h,074h,077h,004h,004h,004h,060h	; 9510  I.^..[sw.ctw...`
	defb 005h,077h,01eh,005h,005h,014h,004h,004h,021h,043h,02fh,012h,034h,036h,037h,001h	; 9520  .w......!C/.467.
	defb 0feh,0f2h,0ech,001h,086h,085h,083h,061h,07eh,092h,070h,004h,004h,063h,005h,005h	; 9530  .......a~.p..c..
	defb 06dh,004h,028h,025h,005h,014h,004h,012h,006h,03fh,037h,032h,001h,0feh,014h,0edh	; 9540  m.(%.....?72....
	defb 001h,081h,086h,08eh,006h,061h,004h,063h,005h,075h,077h,004h,004h,021h,043h,02fh	; 9550  .....a.c.uw..!C/
	defb 006h,034h,036h,037h,032h,001h,0feh,036h,0edh,001h,081h,086h,085h,083h,006h,076h	; 9560  .4672..6.......v
	defb 092h,070h,004h,004h,012h,006h,034h,037h,032h,001h,001h,001h,0feh,057h,0edh,001h	; 9570  .p....472....W..
	defb 001h,001h,081h,086h,083h,006h,061h,004h,006h,034h,037h,032h,001h,001h,0feh,07ah	; 9580  ......a..472...z
	defb 0edh,001h,001h,081h,086h,083h,006h,007h,006h,001h,001h,0feh,09ch,0edh,001h,001h	; 9590  ................
	defb 00eh,00fh,001h,001h,001h,0feh,0beh,0edh,001h,001h,0ffh	; 95a0  ...........

; ----------------------------------------------------------------------
; DATOS tira_95AB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9102[3] (394 bytes)
;   0x95ab..0x9735  (394 bytes)
DATA_tira_95AB:
	defb 0e0h,0ebh,040h,040h,040h,040h,069h,067h,068h,042h,042h,042h,042h,042h,042h,06ah	; 95ab  ..@@@@ighBBBBBBj
	defb 043h,063h,088h,043h,08fh,042h,042h,042h,042h,042h,042h,08dh,08ch,08eh,040h,040h	; 95bb  Cc.C.BBBBBB...@@
	defb 040h,040h,05fh,051h,051h,05ch,040h,040h,041h,069h,042h,042h,042h,042h,042h,042h	; 95cb  @@_QQ\@@AiBBBBBB
	defb 043h,044h,045h,043h,042h,042h,042h,042h,042h,042h,08eh,041h,040h,040h,081h,051h	; 95db  CDECBBBBBB.A@@.Q
	defb 051h,084h,05eh,052h,052h,053h,040h,040h,040h,040h,041h,069h,042h,042h,042h,042h	; 95eb  Q.^RRS@@@@AiBBBB
	defb 06ah,046h,047h,08fh,042h,042h,042h,042h,08eh,041h,040h,040h,040h,040h,078h,052h	; 95fb  jFG.BBBB.A@@@@xR
	defb 052h,083h,060h,052h,052h,05dh,064h,04eh,05eh,051h,058h,040h,067h,068h,042h,042h	; 960b  R.`RR]dN^QX@ghBB
	defb 042h,048h,049h,042h,042h,042h,08dh,08ch,040h,07dh,051h,083h,04eh,089h,082h,052h	; 961b  BHIBBB..@}Q.N..R
	defb 052h,085h,052h,052h,052h,05dh,065h,04eh,05eh,052h,05dh,061h,04fh,055h,041h,042h	; 962b  R.RRR]eN^R]aOUAB
	defb 042h,04ah,04bh,042h,042h,041h,07ah,04fh,086h,082h,052h,083h,04eh,08ah,082h,052h	; 963b  BJKBBAzO..R.N..R
	defb 052h,052h,004h,004h,004h,01eh,027h,005h,05dh,004h,01bh,027h,012h,01fh,02ch,055h	; 964b  RR....'.]..'..,U
	defb 054h,008h,009h,0a3h,0a4h,07bh,06eh,061h,076h,06ah,004h,00eh,005h,076h,06dh,004h	; 965b  T....{navj...vm.
	defb 004h,004h,014h,004h,004h,004h,028h,005h,014h,004h,01eh,025h,014h,004h,010h,033h	; 966b  ......(....%...3
	defb 045h,00ah,00bh,094h,082h,05fh,004h,063h,074h,06dh,004h,063h,005h,077h,004h,004h	; 967b  E...._.ctm.c.w..
	defb 004h,063h,011h,004h,004h,004h,00eh,005h,011h,004h,004h,029h,011h,004h,02ah,031h	; 968b  .c.........)..*1
	defb 046h,00fh,05eh,095h,080h,079h,004h,060h,078h,004h,004h,060h,005h,05dh,004h,004h	; 969b  F.^..y.`x..`.]..
	defb 004h,060h,005h,014h,004h,004h,004h,029h,026h,014h,004h,023h,03fh,044h,032h,001h	; 96ab  .`.....)&..#?D2.
	defb 0feh,0f2h,0ech,001h,081h,093h,08eh,072h,004h,063h,075h,078h,004h,004h,004h,063h	; 96bb  .......r.cux...c
	defb 005h,026h,005h,014h,004h,004h,023h,047h,022h,034h,037h,032h,001h,0feh,014h,0edh	; 96cb  .&....#G"472....
	defb 001h,081h,086h,083h,071h,096h,072h,004h,004h,063h,005h,075h,047h,022h,005h,014h	; 96db  ....q.r..c.uG"..
	defb 01ah,040h,034h,037h,032h,001h,0feh,036h,0edh,001h,081h,086h,083h,08fh,069h,063h	; 96eb  .@472..6......ic
	defb 005h,071h,096h,012h,006h,006h,03fh,04ah,032h,001h,001h,001h,0feh,057h,0edh,001h	; 96fb  .q....?J2....W..
	defb 001h,001h,081h,099h,08eh,006h,006h,061h,006h,034h,044h,032h,001h,001h,0feh,07ah	; 970b  .......a.4D2...z
	defb 0edh,001h,001h,081h,093h,083h,006h,009h,008h,001h,001h,0feh,09ch,0edh,001h,001h	; 971b  ................
	defb 010h,011h,001h,001h,0feh,0beh,0edh,001h,001h,0ffh	; 972b  ..........

; ----------------------------------------------------------------------
; DATOS guion_9735: guion comprimido que lee descomprime; lo cargan p01:6164
;   (33 bytes)
;   0x9735..0x9756  (33 bytes)
DATA_guion_9735:
	defb 0e0h,0ebh,060h,001h,04dh,001h,006h,005h,01bh,001h,084h,008h,005h,005h,02ch,01ch	; 9735  ..`.M.........,.
	defb 001h,084h,00eh,003h,003h,032h,02eh,001h,060h,001h,060h,001h,060h,001h,060h,001h	; 9745  .....2..`.`.`.`.
	defb 000h	; 9755

; ----------------------------------------------------------------------
; DATOS cuadros_9756: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x9756..0x975e  (8 bytes)
DATA_cuadros_9756:
	defb 05eh,097h	; 9756
	defb 0e5h,098h	; 9758
	defb 068h,09ah	; 975a
	defb 0ebh,09bh	; 975c

; ----------------------------------------------------------------------
; DATOS tira_975E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9756[0] (391 bytes)
;   0x975e..0x98e5  (391 bytes)
DATA_tira_975E:
	defb 0e0h,0ebh,040h,040h,054h,05eh,048h,040h,040h,040h,058h,040h,040h,040h,040h,040h	; 975e  ..@@T^H@@@X@@@@@
	defb 040h,040h,040h,040h,040h,040h,040h,040h,040h,088h,040h,040h,040h,078h,08eh,084h	; 976e  @@@@@@@@@.@@@x..
	defb 040h,040h,040h,054h,05eh,048h,040h,040h,057h,06ah,063h,064h,065h,066h,065h,066h	; 977e  @@@T^H@@Wjcdefef
	defb 067h,097h,067h,097h,096h,095h,096h,095h,094h,093h,09ah,087h,040h,040h,078h,08eh	; 978e  g.g.........@@x.
	defb 084h,040h,062h,05eh,048h,040h,055h,05ah,05dh,048h,040h,040h,058h,040h,040h,040h	; 979e  .@b^H@UZ]H@@X@@@
	defb 040h,040h,040h,040h,040h,040h,040h,088h,040h,040h,078h,08dh,084h,085h,040h,078h	; 97ae  @@@@@@@.@@x...@x
	defb 08eh,092h,05eh,001h,07ah,052h,062h,05eh,048h,040h,057h,06ah,063h,064h,065h,066h	; 97be  ..^.zRb^H@Wjcdef
	defb 067h,097h,067h,097h,096h,095h,094h,093h,09ah,087h,040h,078h,08eh,092h,082h,04ah	; 97ce  g.g.......@x...J
	defb 001h,08eh,060h,049h,040h,056h,05fh,049h,040h,057h,061h,048h,057h,062h,063h,069h	; 97de  ..`I@V_I@WaHWbci
	defb 047h,047h,047h,047h,099h,093h,092h,087h,078h,091h,087h,040h,079h,08fh,086h,040h	; 97ee  GGGG....x..@y..@
	defb 079h,090h,051h,007h,003h,003h,051h,007h,04fh,050h,009h,04fh,050h,029h,00ah,00bh	; 97fe  y.Q...Q.OP.OP)..
	defb 00ch,00ch,057h,057h,056h,055h,074h,09bh,09ah,054h,09bh,09ah,052h,09ch,003h,003h	; 980e  ..WWVUt..T..R...
	defb 052h,09ch,031h,04ah,007h,003h,031h,028h,04fh,04eh,004h,008h,04eh,00eh,00fh,00dh	; 981e  R.1J..1(ON..N...
	defb 010h,005h,005h,05bh,058h,05ah,059h,099h,053h,004h,099h,09ah,073h,07ch,003h,052h	; 982e  ...[XZY.S...s|.R
	defb 095h,07ch,051h,048h,007h,003h,04ch,048h,007h,04ch,02ah,007h,04ch,02ah,011h,038h	; 983e  .|QH..LH.L*.L*.8
	defb 039h,002h,002h,084h,083h,05ch,075h,097h,052h,075h,097h,052h,093h,097h,003h,052h	; 984e  9....\u.Ru.R...R
	defb 093h,09ch,031h,049h,004h,008h,051h,049h,007h,04fh,051h,04ah,008h,02ch,002h,0feh	; 985e  ..1I..QI.OQJ.,..
	defb 0f3h,0ech,002h,077h,053h,095h,09ch,09ah,052h,094h,09ch,053h,004h,094h,07ch,04fh	; 986e  ...wS...R..S..|O
	defb 04ch,004h,008h,008h,04ch,04ah,008h,031h,02ch,001h,0feh,015h,0edh,001h,077h,07ch	; 987e  L...LJ.1,.....w|
	defb 053h,095h,097h,053h,053h,004h,097h,09ah,003h,031h,04ah,007h,003h,031h,030h,001h	; 988e  S..SS....1J..10.
	defb 001h,0feh,037h,0edh,001h,001h,07bh,07ch,003h,052h,095h,07ch,003h,008h,003h,051h	; 989e  ..7...{|.R.|...Q
	defb 04ah,033h,045h,02fh,0feh,059h,0edh,07ah,090h,07eh,095h,09ch,003h,053h,007h,003h	; 98ae  J3E/.Y.z.~...S..
	defb 032h,02dh,001h,0feh,07bh,0edh,001h,078h,07dh,003h,052h,002h,016h,00dh,006h,001h	; 98be  2-..{..x}.R.....
	defb 0feh,09bh,0edh,001h,01dh,024h,02dh,002h,017h,015h,00ah,0feh,0bdh,0edh,021h,02ch	; 98ce  .....$-.......!,
	defb 02eh,001h,0feh,0dfh,0edh,001h,0ffh	; 98de

; ----------------------------------------------------------------------
; DATOS tira_98E5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9756[1] (387 bytes)
;   0x98e5..0x9a68  (387 bytes)
DATA_tira_98E5:
	defb 0e0h,0ebh,054h,05eh,001h,048h,040h,040h,059h,05ah,05bh,070h,05ch,071h,05ch,071h	; 98e5  ..T^.H@@YZ[p\q\q
	defb 082h,052h,082h,052h,0a1h,08ch,0a1h,08ch,0a0h,08bh,08ah,089h,040h,040h,078h,001h	; 98f5  .R.R........@@x.
	defb 08eh,084h,05eh,001h,048h,040h,040h,054h,073h,074h,07ch,04bh,04ch,07ch,04ch,04dh	; 9905  ..^.H@@Tst|KL|LM
	defb 06eh,09eh,06eh,09eh,07dh,07ch,04ch,07ch,07bh,04ch,0a4h,0a3h,084h,040h,040h,078h	; 9915  n.n.}|L|{L...@@x
	defb 001h,08eh,001h,048h,040h,055h,054h,05dh,048h,040h,040h,059h,05bh,070h,05ch,071h	; 9925  ...H@UT]H@@Y[p\q
	defb 082h,052h,082h,052h,0a1h,08ch,0a0h,08bh,089h,040h,040h,078h,08dh,084h,085h,040h	; 9935  .R.R.....@@x...@
	defb 078h,001h,001h,07ah,052h,062h,05eh,048h,040h,040h,072h,073h,074h,04bh,04ch,04dh	; 9945  x..zRb^H@@rstKLM
	defb 06eh,09eh,06eh,09eh,07dh,07ch,07bh,0a4h,0a3h,0a2h,040h,040h,078h,08eh,092h,082h	; 9955  n.n.}|{...@@x...
	defb 04ah,001h,048h,040h,056h,05fh,049h,040h,052h,062h,05dh,06bh,062h,06ch,06dh,06fh	; 9965  J.H@V_I@Rb]kblmo
	defb 041h,041h,041h,041h,09fh,09dh,09ch,092h,09bh,08dh,092h,082h,040h,079h,08fh,086h	; 9975  AAAA........@y..
	defb 040h,078h,008h,003h,003h,051h,007h,008h,04ch,04bh,007h,050h,029h,012h,013h,014h	; 9985  @x...Q..LK.P)...
	defb 015h,015h,060h,060h,05fh,05eh,05dh,074h,09bh,052h,096h,097h,053h,052h,09ch,003h	; 9995  ..``_^]t.R..SR..
	defb 003h,053h,007h,008h,003h,031h,04ah,007h,031h,048h,007h,04eh,028h,016h,017h,018h	; 99a5  .S...1J.1H.N(...
	defb 019h,006h,006h,064h,063h,062h,061h,073h,099h,052h,093h,07ch,052h,095h,07ch,003h	; 99b5  ...dcbas.R.|R.|.
	defb 053h,052h,04ah,007h,003h,04ch,048h,007h,051h,049h,009h,031h,051h,00eh,01ah,03ah	; 99c5  SRJ..LH.QI.1Q..:
	defb 03bh,002h,002h,086h,085h,065h,059h,09ch,07ch,054h,094h,09ch,052h,093h,097h,003h	; 99d5  ;....eY.|T..R...
	defb 052h,095h,048h,007h,008h,051h,049h,007h,008h,04ch,04ah,008h,031h,02bh,034h,0feh	; 99e5  R.H..QI..LJ.1+4.
	defb 0f3h,0ech,07fh,076h,07ch,053h,095h,097h,053h,052h,094h,09ch,053h,052h,093h,051h	; 99f5  ...v|S..SR..SR.Q
	defb 007h,008h,008h,04ch,04ah,008h,031h,030h,001h,0feh,016h,0edh,001h,07bh,07ch,053h	; 9a05  ...LJ.10.....{|S
	defb 095h,097h,053h,053h,052h,09ch,032h,04ah,007h,003h,04fh,049h,046h,045h,02fh,0feh	; 9a15  ..SSR.2J..OIFE/.
	defb 037h,0edh,07ah,090h,091h,094h,09ah,003h,052h,095h,07dh,003h,051h,04ah,00eh,032h	; 9a25  7.z.....R.}.QJ.2
	defb 033h,02eh,0feh,059h,0edh,079h,07eh,07dh,059h,095h,09ch,003h,003h,032h,047h,08fh	; 9a35  3..Y.y~}Y....2G.
	defb 03dh,0feh,07bh,0edh,088h,044h,092h,07dh,003h,01ah,00dh,008h,001h,0feh,09ch,0edh	; 9a45  =.{..D.}........
	defb 001h,01fh,024h,031h,019h,00bh,004h,0feh,0bdh,0edh,01bh,022h,030h,012h,0feh,0dfh	; 9a55  ..$1......."0...
	defb 0edh,029h,0ffh	; 9a65

; ----------------------------------------------------------------------
; DATOS tira_9A68: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 2 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9756[2] (387 bytes)
;   0x9a68..0x9beb  (387 bytes)
DATA_tira_9A68:
	defb 0e0h,0ebh,001h,001h,048h,040h,040h,054h,06ah,063h,064h,065h,066h,064h,065h,066h	; 9a68  ....H@@Tjcdefdef
	defb 067h,097h,067h,097h,096h,095h,094h,096h,095h,094h,093h,09ah,084h,040h,040h,078h	; 9a78  g.g..........@@x
	defb 001h,001h,001h,048h,040h,040h,054h,05eh,048h,040h,040h,040h,058h,040h,040h,040h	; 9a88  ...H@@T^H@@@X@@@
	defb 040h,040h,040h,040h,040h,040h,040h,088h,040h,040h,040h,078h,08eh,084h,040h,040h	; 9a98  @@@@@@@.@@@x..@@
	defb 078h,001h,048h,040h,055h,054h,05dh,048h,040h,040h,052h,06ah,063h,064h,065h,066h	; 9aa8  x.H@UT]H@@Rjcdef
	defb 067h,097h,067h,097h,096h,095h,094h,093h,09ah,082h,040h,040h,078h,08dh,084h,085h	; 9ab8  g.g.......@@x...
	defb 040h,078h,040h,052h,062h,05eh,048h,040h,052h,053h,061h,048h,052h,075h,04eh,04fh	; 9ac8  @x@Rb^H@RSaHRuNO
	defb 046h,046h,046h,046h,07fh,07eh,0a5h,082h,078h,091h,083h,082h,040h,078h,08eh,092h	; 9ad8  FFFF.~..x...@x..
	defb 082h,040h,040h,056h,05fh,049h,040h,040h,057h,061h,048h,053h,061h,07ch,050h,076h	; 9ae8  .@@V_I@@WaHSa|Pv
	defb 045h,045h,045h,045h,0a6h,080h,04ch,091h,083h,078h,091h,087h,040h,040h,079h,08fh	; 9af8  EEEE..L..x..@@y.
	defb 086h,040h,003h,003h,051h,007h,008h,04fh,050h,009h,04fh,04dh,009h,00ah,00ah,00bh	; 9b08  .@..Q..OP.OM....
	defb 00ch,00ch,057h,057h,056h,055h,055h,054h,098h,09ah,054h,09bh,09ah,053h,052h,09ch	; 9b18  ..WWVUUT..T..SR.
	defb 003h,003h,008h,003h,031h,04ah,007h,04fh,04eh,007h,031h,047h,00eh,01bh,00fh,00dh	; 9b28  ....1J.ON.1G....
	defb 010h,005h,005h,05bh,058h,05ah,066h,059h,092h,07ch,052h,099h,09ah,052h,095h,07ch	; 9b38  ...[XZfY.|R..R.|
	defb 003h,053h,007h,003h,04ch,048h,007h,032h,04ch,02ah,008h,04ch,02ah,01ch,011h,038h	; 9b48  .S..LH.2L*.L*..8
	defb 039h,002h,002h,084h,083h,05ch,067h,075h,097h,053h,075h,097h,07dh,052h,093h,097h	; 9b58  9....\gu.Su.}R..
	defb 003h,052h,007h,008h,051h,049h,007h,008h,031h,048h,007h,04fh,051h,03ch,002h,0feh	; 9b68  .R..QI..1H.OQ<..
	defb 0f3h,0ech,002h,087h,09ch,09ah,052h,093h,07ch,053h,052h,094h,09ch,053h,052h,007h	; 9b78  ......R.|SR..SR.
	defb 008h,04fh,04ch,04ah,008h,04fh,051h,046h,045h,02fh,0feh,015h,0edh,07ah,090h,091h	; 9b88  .OLJ.OQFE/...z..
	defb 09ch,09ah,053h,095h,097h,09ah,053h,052h,004h,007h,003h,031h,051h,04ah,003h,033h	; 9b98  ..S...SR...1QJ.3
	defb 02eh,0feh,037h,0edh,079h,07eh,003h,095h,09ch,07ch,003h,052h,004h,04ah,004h,008h	; 9ba8  ..7.y~...|.R.J..
	defb 003h,031h,02eh,001h,0feh,059h,0edh,001h,079h,07ch,003h,053h,004h,095h,051h,04ah	; 9bb8  .1...Y..y|.S..QJ
	defb 009h,033h,02fh,0feh,07bh,0edh,07ah,07eh,054h,095h,09ch,00eh,00fh,014h,0feh,09dh	; 9bc8  .3/.{.z~T.......
	defb 0edh,02bh,026h,025h,00dh,009h,001h,0feh,0bdh,0edh,001h,020h,024h,00ah,0feh,0dfh	; 9bd8  .+&%....... $...
	defb 0edh,021h,0ffh	; 9be8

; ----------------------------------------------------------------------
; DATOS tira_9BEB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 3 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9756[3] (391 bytes)
;   0x9beb..0x9d72  (391 bytes)
DATA_tira_9BEB:
	defb 0e0h,0ebh,001h,048h,040h,040h,054h,073h,074h,07ch,04bh,040h,040h,040h,040h,040h	; 9beb  ...H@@Tst|K@@@@@
	defb 040h,040h,040h,040h,040h,040h,040h,040h,040h,07bh,04ch,0a4h,0a3h,084h,040h,040h	; 9bfb  @@@@@@@@@{L...@@
	defb 078h,001h,048h,040h,040h,054h,05dh,048h,040h,040h,059h,05bh,05ch,071h,05ch,071h	; 9c0b  x.H@@T]H@@Y[\q\q
	defb 082h,052h,082h,052h,0a1h,08ch,0a1h,08ch,08bh,089h,040h,040h,078h,08dh,084h,040h	; 9c1b  .R.R......@@x..@
	defb 040h,078h,040h,055h,054h,05dh,048h,040h,040h,072h,073h,074h,04ch,07ch,04ch,04dh	; 9c2b  @x@UT]H@@rstL|LM
	defb 06eh,09eh,06eh,09eh,07dh,07ch,04ch,07ch,0a4h,0a3h,0a2h,040h,040h,078h,08dh,084h	; 9c3b  n.n.}|L|...@@x..
	defb 085h,040h,052h,054h,05eh,048h,040h,052h,053h,05dh,048h,052h,06ah,063h,094h,077h	; 9c4b  .@RT^H@RS]HRjc.w
	defb 044h,044h,044h,044h,0a7h,064h,093h,09ah,082h,078h,08dh,083h,082h,040h,078h,08eh	; 9c5b  DDDD.d...x...@x.
	defb 084h,082h,056h,05fh,049h,040h,040h,057h,061h,048h,052h,061h,048h,04fh,051h,042h	; 9c6b  ..V_I@@WaHRaHOQB
	defb 043h,043h,043h,043h,042h,081h,07fh,078h,091h,082h,078h,091h,087h,040h,040h,079h	; 9c7b  CCCCB..x..x..@@y
	defb 08fh,086h,003h,051h,007h,003h,04fh,050h,009h,04fh,050h,009h,003h,013h,013h,014h	; 9c8b  ...Q..OP.OP.....
	defb 015h,015h,060h,060h,05fh,05eh,05eh,003h,054h,09bh,09ah,054h,09bh,09ah,003h,052h	; 9c9b  ..``_^^.T..T...R
	defb 09ch,003h,003h,031h,04ah,007h,04fh,04eh,007h,04fh,04eh,007h,003h,01eh,017h,018h	; 9cab  ...1J.ON.ON.....
	defb 019h,006h,006h,064h,063h,062h,069h,003h,052h,099h,09ah,052h,099h,09ah,052h,095h	; 9cbb  ...dcbi.R..R..R.
	defb 07ch,003h,003h,04ch,048h,007h,032h,04ch,04ah,007h,04ch,048h,00eh,01dh,01ah,03ah	; 9ccb  |..LH.2LJ.LH...:
	defb 03bh,002h,002h,086h,085h,065h,068h,059h,093h,097h,052h,095h,097h,07dh,052h,093h	; 9cdb  ;....ehY..R..}R.
	defb 097h,003h,008h,031h,049h,007h,04fh,031h,048h,007h,04fh,051h,046h,03dh,034h,0feh	; 9ceb  ...1I.O1H.OQF=4.
	defb 0f3h,0ech,07fh,088h,091h,09ch,09ah,052h,093h,07ch,09ah,052h,094h,07ch,053h,008h	; 9cfb  .......R.|.R.|S.
	defb 04fh,04ch,004h,008h,04fh,051h,04ah,008h,033h,02eh,0feh,015h,0edh,079h,07eh,053h	; 9d0b  OL..OQJ.3....y~S
	defb 095h,09ch,09ah,053h,004h,097h,09ah,053h,007h,003h,031h,04ah,008h,003h,031h,02ch	; 9d1b  ...S...S..1J..1,
	defb 001h,0feh,037h,0edh,001h,077h,07ch,003h,053h,095h,07ch,003h,052h,004h,008h,003h	; 9d2b  ..7..w|.S.|.R...
	defb 051h,046h,045h,02fh,0feh,059h,0edh,07ah,090h,091h,09ch,003h,053h,004h,004h,007h	; 9d3b  QFE/.Y.z....S...
	defb 003h,031h,02dh,0feh,07bh,0edh,078h,07ch,003h,052h,004h,010h,018h,00dh,00ch,005h	; 9d4b  .1-.{.x|.R......
	defb 0feh,09bh,0edh,01ch,023h,024h,02fh,027h,011h,003h,013h,0feh,0bdh,0edh,02ah,003h	; 9d5b  ....#$/'......*.
	defb 028h,007h,0feh,0dfh,0edh,01eh,0ffh	; 9d6b

; ----------------------------------------------------------------------
; DATOS guion_9D72: guion comprimido que lee descomprime; lo cargan p01:6193
;   (19 bytes)
;   0x9d72..0x9d85  (19 bytes)
DATA_guion_9D72:
	defb 0e0h,0ebh,060h,001h,040h,001h,040h,002h,060h,001h,060h,001h,060h,001h,060h,001h	; 9d72  ..`.@.@.`.`.`.`.
	defb 040h,001h,000h	; 9d82

; ----------------------------------------------------------------------
; DATOS cuadros_9D85: los cuatro guiones de copia_bloques de un decorado, uno
;   por cuadro
;   0x9d85..0x9d8d  (8 bytes)
DATA_cuadros_9D85:
	defb 08dh,09dh	; 9d85
	defb 0e9h,09eh	; 9d87
	defb 044h,0a0h	; 9d89
	defb 0a5h,0a1h	; 9d8b

; ----------------------------------------------------------------------
; DATOS tira_9D8D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 0 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9D85[0] (348 bytes)
;   0x9d8d..0x9ee9  (348 bytes)
DATA_tira_9D8D:
	defb 0e2h,0ebh,042h,043h,044h,045h,046h,041h,045h,046h,041h,045h,046h,041h,045h,046h	; 9d8d  ..BCDEFAEFAEFAEF
	defb 041h,045h,046h,041h,045h,046h,041h,045h,046h,041h,045h,046h,047h,048h,049h,0feh	; 9d9d  AEFAEFAEFAEFGHI.
	defb 003h,0ech,042h,043h,04ah,04bh,04ch,04ah,04bh,04ch,04ah,04bh,04ch,04ah,04bh,04ch	; 9dad  ..BCJKLJKLJKLJKL
	defb 04ah,04bh,04ch,04ah,04bh,04ch,04ah,04bh,04ch,04dh,048h,049h,0feh,024h,0ech,042h	; 9dbd  JKLJKLJKLMHI.$.B
	defb 043h,04fh,051h,04eh,04fh,051h,04eh,04fh,051h,04eh,04fh,051h,04eh,04fh,051h,04eh	; 9dcd  COQNOQNOQNOQNOQN
	defb 04fh,051h,04eh,050h,052h,040h,040h,0feh,046h,0ech,042h,053h,054h,053h,054h,053h	; 9ddd  OQNPR@@.F.BSTSTS
	defb 054h,053h,054h,053h,054h,053h,054h,053h,054h,053h,054h,053h,052h,040h,0feh,068h	; 9ded  TSTSTSTSTSTSR@.h
	defb 0ech,055h,056h,057h,055h,056h,057h,055h,056h,057h,055h,056h,057h,055h,056h,057h	; 9dfd  .UVWUVWUVWUVWUVW
	defb 055h,0feh,080h,0ech,025h,002h,0feh,084h,0ech,023h,002h,0feh,09ah,0ech,002h,063h	; 9e0d  U...%....#.....c
	defb 0feh,09eh,0ech,002h,065h,026h,002h,0feh,0a4h,0ech,025h,002h,0feh,0a8h,0ech,025h	; 9e1d  ....e&....%....%
	defb 0feh,0abh,0ech,024h,0feh,0b4h,0ech,064h,0feh,0b7h,0ech,065h,0feh,0bah,0ech,002h	; 9e2d  ...$...d...e....
	defb 065h,0feh,0beh,0ech,002h,066h,027h,02ah,0feh,0c4h,0ech,028h,001h,001h,0feh,0c8h	; 9e3d  e....f'*...(....
	defb 0ech,029h,02ah,005h,02dh,00ah,011h,010h,004h,004h,050h,051h,04ah,06dh,005h,06ah	; 9e4d  .)*.-.....PQJm.j
	defb 069h,0feh,0d9h,0ech,001h,001h,068h,0feh,0deh,0ech,06ah,067h,028h,001h,001h,0feh	; 9e5d  i.....h...jg(...
	defb 0e4h,0ech,029h,02ah,042h,043h,02ch,032h,037h,01ch,009h,00dh,0feh,0f2h,0ech,04dh	; 9e6d  ..)*BC,27......M
	defb 049h,05ch,077h,072h,06ch,083h,082h,06ah,069h,0feh,0fdh,0ech,001h,001h,068h,029h	; 9e7d  I\wrl..ji.....h)
	defb 02ah,008h,007h,02ch,001h,001h,037h,01ch,01ch,010h,0feh,015h,0edh,050h,05ch,05ch	; 9e8d  *..,..7......P\\
	defb 077h,001h,001h,06ch,007h,008h,06ah,069h,02ch,001h,032h,035h,03eh,01dh,01bh,021h	; 9e9d  w..l..ji,.25>..!
	defb 01fh,0feh,037h,0edh,05fh,061h,05bh,05dh,07eh,075h,072h,001h,06ch,019h,019h,018h	; 9ead  ..7._a[]~ur.l...
	defb 001h,03bh,01eh,01fh,0feh,059h,0edh,05fh,05eh,07bh,001h,058h,059h,059h,003h,01dh	; 9ebd  .;...Y._^{.XYY..
	defb 01bh,021h,01fh,0feh,07bh,0edh,05fh,061h,05bh,05dh,003h,002h,003h,004h,0feh,09dh	; 9ecd  .!..{._a[]......
	defb 0edh,017h,016h,015h,005h,006h,0feh,0beh,0edh,019h,018h,0ffh	; 9edd  ............

; ----------------------------------------------------------------------
; DATOS tira_9EE9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino)
;   (cuadro 1 de la animacion del fondo) que lee copia_bloques; lo cargan
;   p01:655A por 0x9D85[1]; sigue en el banco 13, en la ranura de al lado (279
;   bytes)
;   0x9ee9..0xa000  (279 bytes)
DATA_tira_9EE9:
	defb 0e2h,0ebh,058h,04ch,059h,05ah,05bh,041h,05ah,05bh,041h,05ah,05bh,041h,05ah,05bh	; 9ee9  ..XLYZ[AZ[AZ[AZ[
	defb 041h,05ah,05bh,041h,05ah,05bh,041h,05ah,05bh,041h,05ah,05ch,05dh,05eh,05fh,060h	; 9ef9  AZ[AZ[AZ[AZ\]^_`
	defb 0feh,003h,0ech,058h,04ch,059h,05eh,061h,062h,05eh,061h,062h,05eh,061h,062h,05eh	; 9f09  ...XLY^ab^ab^ab^
	defb 061h,062h,05eh,061h,062h,05eh,061h,062h,05eh,061h,062h,05eh,05fh,0feh,024h,0ech	; 9f19  ab^ab^ab^ab^_.$.
	defb 058h,063h,064h,065h,063h,064h,065h,063h,064h,065h,063h,064h,065h,063h,064h,065h	; 9f29  Xcdecdecdecdecde
	defb 063h,064h,065h,063h,064h,065h,0feh,046h,0ech,042h,066h,067h,066h,067h,066h,067h	; 9f39  cdecde.F.Bfgfgfg
	defb 066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,065h,0feh,067h,0ech,058h	; 9f49  fgfgfgfgfgfe.g.X
	defb 068h,069h,06ah,068h,069h,06ah,068h,069h,06ah,068h,069h,06ah,068h,069h,06ah,06bh	; 9f59  hijhijhijhijhijk
	defb 0feh,080h,0ech,002h,0feh,083h,0ech,063h,002h,0feh,09bh,0ech,002h,023h,0feh,09fh	; 9f69  .......c.....#..
	defb 0ech,002h,002h,0feh,0a3h,0ech,065h,002h,0feh,0a7h,0ech,025h,002h,0feh,0aah,0ech	; 9f79  ......e....%....
	defb 063h,002h,0feh,0b4h,0ech,002h,023h,0feh,0b7h,0ech,002h,065h,0feh,0bbh,0ech,002h	; 9f89  c.....#....e....
	defb 025h,0feh,0bfh,0ech,002h,001h,001h,0feh,0c3h,0ech,027h,02ah,0feh,0c7h,0ech,028h	; 9f99  %.........'*...(
	defb 001h,005h,02fh,042h,00ch,00eh,00fh,004h,004h,04fh,04eh,04ch,082h,06fh,005h,001h	; 9fa9  ../B.....ONL.o..
	defb 068h,0feh,0dbh,0ech,06ah,067h,0feh,0deh,0ech,001h,001h,001h,0feh,0e3h,0ech,028h	; 9fb9  h...jg.........(
	defb 001h,008h,007h,02eh,032h,037h,040h,021h,00bh,00dh,0feh,0f2h,0ech,04dh,04bh,061h	; 9fc9  ....27@!.....MKa
	defb 080h,077h,072h,06eh,007h,008h,001h,068h,0feh,0ffh,0ech,001h,001h,001h,001h,02eh	; 9fd9  .wrn...h........
	defb 001h,032h,035h,03eh,01dh,021h,020h,0feh,015h,0edh,060h,061h,05dh,07eh,075h,072h	; 9fe9  .25>.! ...`a]~ur
	defb 001h,06eh,001h,001h,001h,001h,033h	; 9ff9
