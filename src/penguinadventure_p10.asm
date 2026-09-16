; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 10 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS tiras_de_terreno_un: 24 punteros, uno por fase (0xE092 - 1), a las
;   tiras de terreno con un jugador; los lee p01:6767. Van en orden y la
;   primera tira empieza donde acaba la tabla
;   0x8000..0x8030  (48 bytes)
DATA_tiras_de_terreno_un:
	defb 030h,080h	; 8000
	defb 036h,080h	; 8002
	defb 03ch,080h	; 8004
	defb 044h,080h	; 8006
	defb 049h,080h	; 8008
	defb 04eh,080h	; 800a
	defb 054h,080h	; 800c
	defb 05ch,080h	; 800e
	defb 062h,080h	; 8010
	defb 069h,080h	; 8012
	defb 070h,080h	; 8014
	defb 077h,080h	; 8016
	defb 080h,080h	; 8018
	defb 087h,080h	; 801a
	defb 08dh,080h	; 801c
	defb 095h,080h	; 801e
	defb 0a0h,080h	; 8020
	defb 0a7h,080h	; 8022
	defb 0b2h,080h	; 8024
	defb 0beh,080h	; 8026
	defb 0c6h,080h	; 8028
	defb 0d4h,080h	; 802a
	defb 0e1h,080h	; 802c
	defb 0ebh,080h	; 802e

; ----------------------------------------------------------------------
; DATOS terreno_fase_1_un: la tira de terreno de la fase 1 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x8030..0x8036  (6 bytes)
DATA_terreno_fase_1_un:
	defb 001h,004h,007h,007h,001h,004h	; 8030

; ----------------------------------------------------------------------
; DATOS terreno_fase_2_un: la tira de terreno de la fase 2 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x8036..0x803c  (6 bytes)
DATA_terreno_fase_2_un:
	defb 007h,001h,028h,001h,028h,007h	; 8036

; ----------------------------------------------------------------------
; DATOS terreno_fase_3_un: la tira de terreno de la fase 3 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x803c..0x8044  (8 bytes)
DATA_terreno_fase_3_un:
	defb 031h,027h,000h,028h,000h,028h,031h,027h	; 803c  1'.(.(1'

; ----------------------------------------------------------------------
; DATOS terreno_fase_4_un: la tira de terreno de la fase 4 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x8044..0x8049  (5 bytes)
DATA_terreno_fase_4_un:
	defb 001h,013h,012h,001h,013h	; 8044

; ----------------------------------------------------------------------
; DATOS terreno_fase_5_un: la tira de terreno de la fase 5 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x8049..0x804e  (5 bytes)
DATA_terreno_fase_5_un:
	defb 020h,000h,000h,023h,025h	; 8049

; ----------------------------------------------------------------------
; DATOS terreno_fase_6_un: la tira de terreno de la fase 6 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x804e..0x8054  (6 bytes)
DATA_terreno_fase_6_un:
	defb 000h,000h,028h,031h,028h,031h	; 804e

; ----------------------------------------------------------------------
; DATOS terreno_fase_7_un: la tira de terreno de la fase 7 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x8054..0x805c  (8 bytes)
DATA_terreno_fase_7_un:
	defb 028h,029h,028h,001h,02ch,029h,02ch,029h	; 8054  ()(.,),)

; ----------------------------------------------------------------------
; DATOS terreno_fase_8_un: la tira de terreno de la fase 8 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x805c..0x8062  (6 bytes)
DATA_terreno_fase_8_un:
	defb 013h,019h,000h,000h,001h,019h	; 805c

; ----------------------------------------------------------------------
; DATOS terreno_fase_9_un: la tira de terreno de la fase 9 con un jugador: un
;   byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin: acaba
;   donde empieza la de la fase siguiente
;   0x8062..0x8069  (7 bytes)
DATA_terreno_fase_9_un:
	defb 02ah,000h,02bh,02ah,02ch,01dh,01ch	; 8062

; ----------------------------------------------------------------------
; DATOS terreno_fase_10_un: la tira de terreno de la fase 10 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8069..0x8070  (7 bytes)
DATA_terreno_fase_10_un:
	defb 000h,022h,021h,024h,021h,022h,024h	; 8069

; ----------------------------------------------------------------------
; DATOS terreno_fase_11_un: la tira de terreno de la fase 11 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8070..0x8077  (7 bytes)
DATA_terreno_fase_11_un:
	defb 000h,013h,014h,000h,014h,015h,017h	; 8070

; ----------------------------------------------------------------------
; DATOS terreno_fase_12_un: la tira de terreno de la fase 12 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8077..0x8080  (9 bytes)
DATA_terreno_fase_12_un:
	defb 02bh,02ch,000h,02ah,02dh,01ah,01bh,01ch,003h	; 8077  +,.*-....

; ----------------------------------------------------------------------
; DATOS terreno_fase_13_un: la tira de terreno de la fase 13 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8080..0x8087  (7 bytes)
DATA_terreno_fase_13_un:
	defb 001h,02fh,000h,02eh,00ah,02fh,00ah	; 8080

; ----------------------------------------------------------------------
; DATOS terreno_fase_14_un: la tira de terreno de la fase 14 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8087..0x808d  (6 bytes)
DATA_terreno_fase_14_un:
	defb 000h,000h,000h,000h,007h,006h	; 8087

; ----------------------------------------------------------------------
; DATOS terreno_fase_15_un: la tira de terreno de la fase 15 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x808d..0x8095  (8 bytes)
DATA_terreno_fase_15_un:
	defb 02ah,02bh,000h,02ch,00eh,000h,000h,00fh	; 808d  *+.,....

; ----------------------------------------------------------------------
; DATOS terreno_fase_16_un: la tira de terreno de la fase 16 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8095..0x80a0  (11 bytes)
DATA_terreno_fase_16_un:
	defb 000h,000h,000h,00eh,01bh,01ah,000h,01eh,031h,00eh,030h	; 8095  ........1.0

; ----------------------------------------------------------------------
; DATOS terreno_fase_17_un: la tira de terreno de la fase 17 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80a0..0x80a7  (7 bytes)
DATA_terreno_fase_17_un:
	defb 019h,018h,017h,019h,000h,000h,018h	; 80a0

; ----------------------------------------------------------------------
; DATOS terreno_fase_18_un: la tira de terreno de la fase 18 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80a7..0x80b2  (11 bytes)
DATA_terreno_fase_18_un:
	defb 00fh,000h,00eh,000h,00dh,000h,030h,000h,031h,000h,00dh	; 80a7  ......0.1..

; ----------------------------------------------------------------------
; DATOS terreno_fase_19_un: la tira de terreno de la fase 19 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80b2..0x80be  (12 bytes)
DATA_terreno_fase_19_un:
	defb 023h,024h,023h,026h,000h,000h,000h,000h,025h,024h,025h,026h	; 80b2  #$#&....%$%&

; ----------------------------------------------------------------------
; DATOS terreno_fase_20_un: la tira de terreno de la fase 20 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80be..0x80c6  (8 bytes)
DATA_terreno_fase_20_un:
	defb 000h,000h,001h,017h,018h,019h,000h,000h	; 80be  ........

; ----------------------------------------------------------------------
; DATOS terreno_fase_21_un: la tira de terreno de la fase 21 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80c6..0x80d4  (14 bytes)
DATA_terreno_fase_21_un:
	defb 031h,030h,032h,00fh,00ch,00eh,00dh,00bh,032h,00fh,031h,030h,00eh,00dh	; 80c6  102.....2.10..

; ----------------------------------------------------------------------
; DATOS terreno_fase_22_un: la tira de terreno de la fase 22 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80d4..0x80e1  (13 bytes)
DATA_terreno_fase_22_un:
	defb 01fh,01dh,01ch,01eh,01ah,01bh,00eh,031h,01ch,030h,01eh,00eh,01dh	; 80d4  .......1.0...

; ----------------------------------------------------------------------
; DATOS terreno_fase_23_un: la tira de terreno de la fase 23 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x80e1..0x80eb  (10 bytes)
DATA_terreno_fase_23_un:
	defb 023h,024h,022h,026h,025h,024h,020h,021h,026h,025h	; 80e1  #$"&%$ !&%

; ----------------------------------------------------------------------
; DATOS terreno_fase_24_un: la tira de terreno de la fase 24 con un jugador:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la tabla de 0x80F9
;   0x80eb..0x80f9  (14 bytes)
DATA_terreno_fase_24_un:
	defb 005h,003h,00bh,007h,00fh,031h,00dh,032h,00eh,030h,00ch,00ah,009h,00fh	; 80eb  .....1.2.0....

; ----------------------------------------------------------------------
; DATOS tiras_de_terreno_dos: 24 punteros, uno por fase (0xE092 - 1), a las
;   tiras de terreno con dos jugadores; los lee p01:6767. Van en orden y la
;   primera tira empieza donde acaba la tabla
;   0x80f9..0x8129  (48 bytes)
DATA_tiras_de_terreno_dos:
	defb 029h,081h	; 80f9
	defb 02fh,081h	; 80fb
	defb 035h,081h	; 80fd
	defb 03dh,081h	; 80ff
	defb 042h,081h	; 8101
	defb 047h,081h	; 8103
	defb 04dh,081h	; 8105
	defb 055h,081h	; 8107
	defb 05bh,081h	; 8109
	defb 062h,081h	; 810b
	defb 069h,081h	; 810d
	defb 070h,081h	; 810f
	defb 079h,081h	; 8111
	defb 080h,081h	; 8113
	defb 086h,081h	; 8115
	defb 08eh,081h	; 8117
	defb 099h,081h	; 8119
	defb 0a0h,081h	; 811b
	defb 0abh,081h	; 811d
	defb 0b7h,081h	; 811f
	defb 0bfh,081h	; 8121
	defb 0cdh,081h	; 8123
	defb 0dah,081h	; 8125
	defb 0e4h,081h	; 8127

; ----------------------------------------------------------------------
; DATOS terreno_fase_1_dos: la tira de terreno de la fase 1 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8129..0x812f  (6 bytes)
DATA_terreno_fase_1_dos:
	defb 004h,031h,02ah,004h,031h,02ah	; 8129

; ----------------------------------------------------------------------
; DATOS terreno_fase_2_dos: la tira de terreno de la fase 2 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x812f..0x8135  (6 bytes)
DATA_terreno_fase_2_dos:
	defb 028h,007h,031h,028h,006h,027h	; 812f

; ----------------------------------------------------------------------
; DATOS terreno_fase_3_dos: la tira de terreno de la fase 3 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8135..0x813d  (8 bytes)
DATA_terreno_fase_3_dos:
	defb 027h,028h,000h,031h,001h,027h,028h,027h	; 8135  '(.1.'('

; ----------------------------------------------------------------------
; DATOS terreno_fase_4_dos: la tira de terreno de la fase 4 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x813d..0x8142  (5 bytes)
DATA_terreno_fase_4_dos:
	defb 013h,012h,015h,002h,013h	; 813d

; ----------------------------------------------------------------------
; DATOS terreno_fase_5_dos: la tira de terreno de la fase 5 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8142..0x8147  (5 bytes)
DATA_terreno_fase_5_dos:
	defb 022h,023h,020h,022h,023h	; 8142

; ----------------------------------------------------------------------
; DATOS terreno_fase_6_dos: la tira de terreno de la fase 6 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8147..0x814d  (6 bytes)
DATA_terreno_fase_6_dos:
	defb 031h,028h,02ch,031h,028h,02ch	; 8147

; ----------------------------------------------------------------------
; DATOS terreno_fase_7_dos: la tira de terreno de la fase 7 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x814d..0x8155  (8 bytes)
DATA_terreno_fase_7_dos:
	defb 029h,02ch,028h,02ah,02bh,029h,028h,02ch	; 814d  ),(*+)(,

; ----------------------------------------------------------------------
; DATOS terreno_fase_8_dos: la tira de terreno de la fase 8 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x8155..0x815b  (6 bytes)
DATA_terreno_fase_8_dos:
	defb 019h,017h,014h,013h,012h,017h	; 8155

; ----------------------------------------------------------------------
; DATOS terreno_fase_9_dos: la tira de terreno de la fase 9 con dos jugadores:
;   un byte por tramo, que p01:6773 va gastando con (0xE404). No lleva fin:
;   acaba donde empieza la de la fase siguiente
;   0x815b..0x8162  (7 bytes)
DATA_terreno_fase_9_dos:
	defb 01ch,007h,02ch,02ah,02ch,01ch,01dh	; 815b

; ----------------------------------------------------------------------
; DATOS terreno_fase_10_dos: la tira de terreno de la fase 10 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8162..0x8169  (7 bytes)
DATA_terreno_fase_10_dos:
	defb 020h,025h,021h,024h,021h,020h,025h	; 8162

; ----------------------------------------------------------------------
; DATOS terreno_fase_11_dos: la tira de terreno de la fase 11 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8169..0x8170  (7 bytes)
DATA_terreno_fase_11_dos:
	defb 014h,012h,013h,012h,016h,017h,018h	; 8169

; ----------------------------------------------------------------------
; DATOS terreno_fase_12_dos: la tira de terreno de la fase 12 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8170..0x8179  (9 bytes)
DATA_terreno_fase_12_dos:
	defb 02fh,02bh,01ah,029h,02fh,01ah,01bh,029h,02bh	; 8170  /+.)/..)+

; ----------------------------------------------------------------------
; DATOS terreno_fase_13_dos: la tira de terreno de la fase 13 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8179..0x8180  (7 bytes)
DATA_terreno_fase_13_dos:
	defb 002h,02eh,006h,02fh,00bh,002h,009h	; 8179

; ----------------------------------------------------------------------
; DATOS terreno_fase_14_dos: la tira de terreno de la fase 14 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8180..0x8186  (6 bytes)
DATA_terreno_fase_14_dos:
	defb 01fh,007h,000h,002h,007h,006h	; 8180

; ----------------------------------------------------------------------
; DATOS terreno_fase_15_dos: la tira de terreno de la fase 15 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8186..0x818e  (8 bytes)
DATA_terreno_fase_15_dos:
	defb 000h,02bh,02eh,01eh,00eh,006h,01ch,01dh	; 8186  .+......

; ----------------------------------------------------------------------
; DATOS terreno_fase_16_dos: la tira de terreno de la fase 16 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x818e..0x8199  (11 bytes)
DATA_terreno_fase_16_dos:
	defb 030h,002h,006h,031h,01ch,01dh,007h,028h,01fh,027h,028h	; 818e  0..1...(.'(

; ----------------------------------------------------------------------
; DATOS terreno_fase_17_dos: la tira de terreno de la fase 17 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x8199..0x81a0  (7 bytes)
DATA_terreno_fase_17_dos:
	defb 017h,019h,018h,013h,017h,015h,016h	; 8199

; ----------------------------------------------------------------------
; DATOS terreno_fase_18_dos: la tira de terreno de la fase 18 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x81a0..0x81ab  (11 bytes)
DATA_terreno_fase_18_dos:
	defb 01ah,032h,00ch,007h,00dh,001h,00bh,006h,009h,00ah,00bh	; 81a0  .2.........

; ----------------------------------------------------------------------
; DATOS terreno_fase_19_dos: la tira de terreno de la fase 19 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x81ab..0x81b7  (12 bytes)
DATA_terreno_fase_19_dos:
	defb 023h,026h,023h,025h,026h,024h,023h,025h,026h,024h,025h,023h	; 81ab  #&#%&$#%&$%#

; ----------------------------------------------------------------------
; DATOS terreno_fase_20_dos: la tira de terreno de la fase 20 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x81b7..0x81bf  (8 bytes)
DATA_terreno_fase_20_dos:
	defb 016h,015h,002h,018h,010h,014h,013h,010h	; 81b7  ........

; ----------------------------------------------------------------------
; DATOS terreno_fase_21_dos: la tira de terreno de la fase 21 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x81bf..0x81cd  (14 bytes)
DATA_terreno_fase_21_dos:
	defb 009h,00ah,00bh,00fh,00eh,00ch,031h,030h,032h,00fh,01bh,01ah,01eh,00bh	; 81bf  ......102.....

; ----------------------------------------------------------------------
; DATOS terreno_fase_22_dos: la tira de terreno de la fase 22 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x81cd..0x81da  (13 bytes)
DATA_terreno_fase_22_dos:
	defb 01ch,01eh,01dh,01bh,01ch,031h,030h,00eh,030h,01eh,01ch,01dh,00eh	; 81cd  .....10.0....

; ----------------------------------------------------------------------
; DATOS terreno_fase_23_dos: la tira de terreno de la fase 23 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la de la fase siguiente
;   0x81da..0x81e4  (10 bytes)
DATA_terreno_fase_23_dos:
	defb 025h,023h,022h,026h,025h,026h,025h,021h,022h,026h	; 81da  %#"&%&%!"&

; ----------------------------------------------------------------------
; DATOS terreno_fase_24_dos: la tira de terreno de la fase 24 con dos
;   jugadores: un byte por tramo, que p01:6773 va gastando con (0xE404). No
;   lleva fin: acaba donde empieza la tabla de 0x81F2
;   0x81e4..0x81f2  (14 bytes)
DATA_terreno_fase_24_dos:
	defb 006h,003h,008h,00ah,01ch,031h,01eh,02ch,028h,030h,00dh,00fh,00bh,009h	; 81e4  .....1.,(0....

; ----------------------------------------------------------------------
; DATOS listas_del_modo_1: 10 punteros a las listas de lo que sale en el modo
;   1 (0xE0A2 = 1); p01:67C5 escoge una con (0xE0A3)
;   0x81f2..0x8206  (20 bytes)
DATA_listas_del_modo_1:
	defb 006h,082h	; 81f2
	defb 047h,082h	; 81f4
	defb 088h,082h	; 81f6
	defb 0c9h,082h	; 81f8
	defb 00ah,083h	; 81fa
	defb 04bh,083h	; 81fc
	defb 08ch,083h	; 81fe
	defb 0cdh,083h	; 8200
	defb 00eh,084h	; 8202
	defb 04fh,084h	; 8204

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_0: lo que sale en el modo 1 con (0xE0A3) = 0: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x8206..0x8247  (65 bytes)
DATA_lista_del_modo_1_0:
	defb 01ah,01bh,01ah,01ch,016h,01ch,01bh,019h,01bh,015h,018h,01ah,01ch,01bh,01ah,01ch	; 8206  ................
	defb 017h,01bh,019h,01ch,01ah,01bh,01ch,01bh,018h,01ah,01bh,01fh,019h,01ah,01ch,01bh	; 8216  ................
	defb 015h,01ch,018h,016h,01bh,017h,01bh,01ch,01ah,01bh,01ch,018h,01ch,01bh,01ch,01bh	; 8226  ................
	defb 015h,01ah,01ch,019h,01dh,01ch,01ah,018h,017h,01bh,01ah,01ch,019h,01ch,01bh,01ah	; 8236  ................
	defb 0ffh	; 8246

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_1: lo que sale en el modo 1 con (0xE0A3) = 1: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x8247..0x8288  (65 bytes)
DATA_lista_del_modo_1_1:
	defb 01ch,01bh,01ah,015h,01ch,01ah,016h,01ch,019h,018h,01ah,01eh,017h,016h,01ch,01bh	; 8247  ................
	defb 01ah,01bh,018h,019h,015h,01ah,01bh,01ah,017h,018h,01bh,01ch,01ah,019h,01ch,016h	; 8257  ................
	defb 01ah,01bh,015h,018h,01bh,01ch,01bh,01ah,016h,018h,019h,01ah,01ch,01bh,018h,01fh	; 8267  ................
	defb 01bh,017h,01ah,01ch,01ah,01bh,015h,018h,019h,016h,01bh,01ah,01ch,01ah,016h,01ch	; 8277  ................
	defb 0ffh	; 8287

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_2: lo que sale en el modo 1 con (0xE0A3) = 2: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x8288..0x82c9  (65 bytes)
DATA_lista_del_modo_1_2:
	defb 018h,019h,015h,016h,017h,018h,015h,016h,018h,017h,016h,015h,019h,017h,016h,018h	; 8288  ................
	defb 019h,01fh,015h,017h,018h,015h,01eh,016h,017h,019h,018h,015h,019h,016h,018h,017h	; 8298  ................
	defb 016h,018h,017h,019h,015h,017h,016h,015h,019h,018h,015h,016h,01dh,01fh,01eh,019h	; 82a8  ................
	defb 015h,017h,018h,016h,015h,017h,018h,019h,016h,018h,017h,015h,019h,018h,015h,017h	; 82b8  ................
	defb 0ffh	; 82c8

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_3: lo que sale en el modo 1 con (0xE0A3) = 3: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x82c9..0x830a  (65 bytes)
DATA_lista_del_modo_1_3:
	defb 01bh,018h,01ah,016h,01ch,015h,01ah,019h,01ah,016h,01ch,018h,01bh,017h,01ah,016h	; 82c9  ................
	defb 01ah,018h,01bh,015h,01ch,019h,01bh,017h,01ch,018h,01ah,015h,01bh,017h,01bh,018h	; 82d9  ................
	defb 01ah,016h,01fh,019h,01ch,018h,01ah,017h,01ah,015h,01ah,016h,01ch,019h,01bh,018h	; 82e9  ................
	defb 01bh,017h,01bh,015h,01ah,016h,01ch,018h,01ch,019h,01ah,016h,01ah,015h,01bh,018h	; 82f9  ................
	defb 0ffh	; 8309

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_4: lo que sale en el modo 1 con (0xE0A3) = 4: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x830a..0x834b  (65 bytes)
DATA_lista_del_modo_1_4:
	defb 01eh,01bh,015h,018h,01ah,01ch,019h,018h,017h,01ah,01bh,01ch,015h,01ch,01bh,01ah	; 830a  ................
	defb 018h,017h,01bh,01ch,01ah,019h,016h,017h,01bh,016h,015h,01ah,01ch,01eh,019h,018h	; 831a  ................
	defb 015h,01ch,01bh,01ah,01bh,01ch,01ah,01ch,01bh,016h,01ch,018h,015h,019h,01bh,018h	; 832a  ................
	defb 015h,01ah,01bh,019h,01ch,016h,01bh,01ah,01ch,01fh,015h,018h,01ah,01bh,01ch,015h	; 833a  ................
	defb 0ffh	; 834a

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_5: lo que sale en el modo 1 con (0xE0A3) = 5: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x834b..0x838c  (65 bytes)
DATA_lista_del_modo_1_5:
	defb 01ah,01ch,01bh,01ah,019h,015h,018h,017h,01ch,01bh,01ah,01ch,017h,016h,019h,015h	; 834b  ................
	defb 01bh,01ah,01ch,01bh,019h,018h,017h,016h,01ah,01bh,01ch,01dh,015h,019h,016h,018h	; 835b  ................
	defb 015h,019h,016h,018h,01eh,01ch,01ah,01ch,017h,016h,018h,019h,01ch,01ah,01ch,01bh	; 836b  ................
	defb 019h,018h,015h,016h,01bh,01ah,01bh,01ch,016h,017h,019h,018h,01ch,01bh,01ah,01bh	; 837b  ................
	defb 0ffh	; 838b

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_6: lo que sale en el modo 1 con (0xE0A3) = 6: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x838c..0x83cd  (65 bytes)
DATA_lista_del_modo_1_6:
	defb 018h,016h,017h,019h,01ah,01bh,018h,01ch,019h,01ah,01bh,015h,01ch,01ah,016h,018h	; 838c  ................
	defb 01bh,01ch,01ah,01ch,01bh,018h,015h,01bh,016h,019h,01ah,01bh,015h,01ch,01ah,01ch	; 839c  ................
	defb 01bh,017h,015h,01ah,01ch,01ah,01bh,016h,01ch,018h,01ah,01bh,01eh,017h,018h,01ah	; 83ac  ................
	defb 016h,01ch,01bh,01ch,01bh,01ah,01ch,01bh,01ah,01bh,01ch,01bh,018h,01ah,01ch,01bh	; 83bc  ................
	defb 0ffh	; 83cc

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_7: lo que sale en el modo 1 con (0xE0A3) = 7: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x83cd..0x840e  (65 bytes)
DATA_lista_del_modo_1_7:
	defb 01ch,01ah,01ch,01bh,01ah,018h,019h,015h,01bh,01ch,01ah,01ch,017h,018h,01ah,01bh	; 83cd  ................
	defb 016h,018h,019h,01bh,01ah,01bh,015h,017h,01ch,01fh,01ah,01bh,016h,019h,018h,015h	; 83dd  ................
	defb 017h,01bh,01ah,01ch,01bh,016h,019h,01ah,01ch,01ah,01bh,018h,019h,016h,017h,015h	; 83ed  ................
	defb 01dh,018h,019h,01bh,01eh,018h,015h,01ch,01ah,01ch,016h,015h,01bh,017h,01ah,01ch	; 83fd  ................
	defb 0ffh	; 840d

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_8: lo que sale en el modo 1 con (0xE0A3) = 8: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x840e..0x844f  (65 bytes)
DATA_lista_del_modo_1_8:
	defb 01ah,01bh,01ch,016h,01ch,01bh,01ah,01bh,01ch,01bh,01ah,01bh,018h,019h,01ch,01ah	; 840e  ................
	defb 01bh,01ch,01bh,017h,01ah,01ch,01ah,01ch,018h,019h,01ah,01ch,01bh,01ah,01ch,018h	; 841e  ................
	defb 015h,01ah,01ch,01bh,01ch,01ah,01fh,01bh,01ah,01bh,01ch,01bh,01ah,016h,018h,01ah	; 842e  ................
	defb 01ch,01bh,01ch,015h,01bh,01ah,01bh,016h,019h,01ah,01ch,01bh,01ch,01ah,018h,01eh	; 843e  ................
	defb 0ffh	; 844e

; ----------------------------------------------------------------------
; DATOS lista_del_modo_1_9: lo que sale en el modo 1 con (0xE0A3) = 9: 64
;   bytes que p01:67D3 lee con (0xE403) y un 0xFF que la cierra y la hace
;   empezar otra vez (p01:67E0)
;   0x844f..0x8490  (65 bytes)
DATA_lista_del_modo_1_9:
	defb 017h,016h,015h,01ch,01bh,01ch,016h,01ch,01ah,015h,018h,01bh,017h,01bh,01ah,01bh	; 844f  ................
	defb 01ch,019h,016h,01ah,01bh,01ah,018h,01ch,016h,01ch,01bh,01ah,018h,015h,01ch,01ah	; 845f  ................
	defb 01ch,01bh,017h,018h,019h,016h,015h,01ch,01bh,01ah,018h,01ch,01bh,017h,016h,01bh	; 846f  ................
	defb 01ah,01ch,019h,016h,01ah,01bh,01ah,018h,015h,01ch,01ah,01bh,016h,019h,01ah,01bh	; 847f  ................
	defb 0ffh	; 848f

; ----------------------------------------------------------------------
; DATOS tira_de_terreno_fuera_del_juego: la tira que p01:6756 usa cuando el
;   modo (0xE0A2) no es cero, en vez de la de la fase: 16 bytes, hasta la
;   tabla de 0x84A0
;   0x8490..0x84a0  (16 bytes)
DATA_tira_de_terreno_fuera_del_juego:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 8490  ................

; ----------------------------------------------------------------------
; DATOS parejas_27: nueve parejas de bytes (C, E) que p01:6888 indexa con A -
;   0x27; si C no es 4 ni 0x0F, la X de lo que se maneja (0xE205) decide cual
;   de los dos va
;   0x84a0..0x84b2  (18 bytes)
DATA_parejas_27:
	defb 001h,002h	; 84a0
	defb 004h,005h	; 84a2
	defb 006h,007h	; 84a4
	defb 008h,009h	; 84a6
	defb 00ch,00dh	; 84a8
	defb 00fh,010h	; 84aa
	defb 011h,012h	; 84ac
	defb 013h,014h	; 84ae
	defb 00dh,00ch	; 84b0

; ----------------------------------------------------------------------
; DATOS palabras_30: 28 palabras que p01:68BB indexa con A - 0x30 y manda a
;   busca_ranura_libre en DE
;   0x84b2..0x84ea  (56 bytes)
DATA_palabras_30:
	defb 006h,007h	; 84b2
	defb 008h,009h	; 84b4
	defb 001h,002h	; 84b6
	defb 004h,005h	; 84b8
	defb 013h,014h	; 84ba
	defb 00fh,010h	; 84bc
	defb 006h,009h	; 84be
	defb 006h,002h	; 84c0
	defb 006h,005h	; 84c2
	defb 008h,007h	; 84c4
	defb 001h,007h	; 84c6
	defb 004h,007h	; 84c8
	defb 008h,002h	; 84ca
	defb 008h,005h	; 84cc
	defb 001h,009h	; 84ce
	defb 004h,009h	; 84d0
	defb 001h,005h	; 84d2
	defb 001h,014h	; 84d4
	defb 001h,010h	; 84d6
	defb 004h,002h	; 84d8
	defb 013h,002h	; 84da
	defb 00fh,002h	; 84dc
	defb 013h,010h	; 84de
	defb 013h,005h	; 84e0
	defb 00fh,014h	; 84e2
	defb 004h,014h	; 84e4
	defb 004h,010h	; 84e6
	defb 00fh,005h	; 84e8

; ----------------------------------------------------------------------
; DATOS tramos_de_terreno: 51 tramos de ocho cosas cada uno: p01:67EA salta a
;   (0xE402) * 8 y lee la cosa (0xE403), que da la vuelta a las ocho
;   (p01:67FE). Llega hasta la tabla de tablas de 0x8682
;   0x84ea..0x8682  (408 bytes)
DATA_tramos_de_terreno:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 84ea  ........
	defb 001h,002h,001h,002h,001h,002h,000h,000h	; 84f2  ........
	defb 004h,003h,005h,003h,004h,005h,000h,000h	; 84fa  ........
	defb 00ch,00dh,00ch,00dh,00ch,00dh,000h,000h	; 8502  ........
	defb 006h,007h,006h,007h,006h,007h,000h,000h	; 850a  ........
	defb 008h,009h,008h,009h,008h,009h,000h,000h	; 8512  ........
	defb 00ch,000h,00dh,000h,00ch,000h,00dh,000h	; 851a  ........
	defb 002h,000h,02bh,000h,002h,000h,02bh,000h	; 8522  ..+...+.
	defb 002h,02ah,001h,02ah,002h,02ah,001h,02ah	; 852a  .*.*.*.*
	defb 003h,029h,006h,02ah,003h,029h,004h,02ah	; 8532  .).*.).*
	defb 027h,02bh,02bh,029h,029h,02ah,027h,02ah	; 853a  '++))*'*
	defb 02ah,028h,02ah,02bh,028h,02ah,02ah,02bh	; 8542  *(*+(**+
	defb 003h,02bh,03ch,02bh,028h,028h,03eh,02bh	; 854a  .+<+((>+
	defb 003h,03bh,028h,02bh,003h,03dh,02bh,031h	; 8552  .;(+.=+1
	defb 00dh,02bh,028h,043h,02bh,028h,040h,027h	; 855a  .+(C+(@'
	defb 032h,028h,031h,02bh,028h,02bh,032h,02bh	; 8562  2(1+(+2+
	defb 011h,012h,011h,012h,011h,012h,000h,000h	; 856a  ........
	defb 002h,003h,001h,003h,002h,003h,000h,000h	; 8572  ........
	defb 011h,000h,012h,000h,011h,000h,012h,000h	; 857a  ........
	defb 02dh,000h,027h,000h,02dh,000h,027h,000h	; 8582  -.'.-.'.
	defb 033h,033h,033h,027h,033h,033h,033h,027h	; 858a  333'333'
	defb 028h,02dh,000h,02dh,028h,000h,028h,000h	; 8592  (-.-(.(.
	defb 028h,028h,028h,028h,028h,028h,028h,028h	; 859a  ((((((((
	defb 033h,033h,032h,02dh,028h,032h,033h,028h	; 85a2  332-(23(
	defb 040h,02dh,028h,043h,032h,02dh,033h,028h	; 85aa  @-(C2-3(
	defb 001h,002h,02dh,002h,001h,028h,002h,02dh	; 85b2  ..-..(.-
	defb 032h,032h,033h,02bh,02bh,028h,027h,02bh	; 85ba  223++('+
	defb 027h,027h,028h,02bh,028h,032h,02bh,02bh	; 85c2  ''(+(2++
	defb 02bh,033h,028h,032h,033h,032h,02bh,028h	; 85ca  +3(232+(
	defb 040h,02bh,043h,028h,043h,040h,02bh,033h	; 85d2  @+C(C@+3
	defb 043h,040h,02bh,040h,043h,028h,02bh,02bh	; 85da  C@+@C(++
	defb 033h,033h,033h,033h,033h,033h,033h,028h	; 85e2  3333333(
	defb 013h,014h,013h,014h,013h,014h,000h,000h	; 85ea  ........
	defb 010h,00eh,00fh,00eh,010h,00eh,000h,000h	; 85f2  ........
	defb 02eh,034h,02eh,033h,033h,041h,043h,032h	; 85fa  .4.33AC2
	defb 02ch,000h,02eh,028h,02ch,000h,027h,027h	; 8602  ,..(,.''
	defb 027h,027h,02eh,02ch,027h,027h,028h,02eh	; 860a  ''.,''(.
	defb 032h,02eh,02ch,035h,027h,02eh,02ch,02eh	; 8612  2.,5'.,.
	defb 034h,02ch,028h,02ch,032h,028h,034h,027h	; 861a  4,(,2(4'
	defb 027h,027h,02bh,027h,02bh,02bh,027h,000h	; 8622  ''+'++'.
	defb 032h,02bh,032h,02bh,002h,001h,02bh,02bh	; 862a  2+2+..++
	defb 027h,006h,007h,027h,030h,001h,030h,032h	; 8632  '..'0.02
	defb 03ah,037h,030h,02bh,037h,029h,03ah,030h	; 863a  :70+7):0
	defb 02bh,027h,030h,02bh,027h,02bh,029h,03ah	; 8642  +'0+'+):
	defb 02bh,032h,029h,029h,02bh,030h,028h,027h	; 864a  +2))+0('
	defb 029h,037h,029h,03ah,028h,030h,032h,030h	; 8652  )7):(020
	defb 006h,007h,008h,009h,006h,009h,007h,008h	; 865a  ........
	defb 002h,029h,009h,001h,02ah,029h,029h,02ah	; 8662  .)..*))*
	defb 032h,02bh,028h,027h,028h,02bh,02bh,028h	; 866a  2+('(++(
	defb 02bh,027h,027h,02bh,027h,02bh,02bh,027h	; 8672  +''+'++'
	defb 02bh,02bh,02ah,02ah,028h,028h,02ah,028h	; 867a  ++**((*(

; ----------------------------------------------------------------------
; DATOS tabla_de_tablas_8682: 38 punteros a tablas de 16 palabras (de las
;   ranuras de 0xE440), con repetidas. La indexa p00:4760, p01:6910 y p01:6985
;   con el primer byte de la ranura menos uno
;   0x8682..0x86ce  (76 bytes)
DATA_tabla_de_tablas_8682:
	defb 0ceh,086h	; 8682
	defb 0eeh,086h	; 8684
	defb 00eh,087h	; 8686
	defb 02eh,087h	; 8688
	defb 04eh,087h	; 868a
	defb 06eh,087h	; 868c
	defb 08eh,087h	; 868e
	defb 0aeh,087h	; 8690
	defb 0ceh,087h	; 8692
	defb 0eeh,087h	; 8694
	defb 00eh,088h	; 8696
	defb 02eh,088h	; 8698
	defb 04eh,088h	; 869a
	defb 06eh,088h	; 869c
	defb 08eh,088h	; 869e
	defb 0aeh,088h	; 86a0
	defb 0ceh,088h	; 86a2
	defb 0eeh,088h	; 86a4
	defb 00eh,089h	; 86a6
	defb 02eh,089h	; 86a8
	defb 04eh,089h	; 86aa
	defb 06eh,089h	; 86ac
	defb 08eh,089h	; 86ae
	defb 0aeh,089h	; 86b0
	defb 0ceh,089h	; 86b2
	defb 0eeh,089h	; 86b4
	defb 0eeh,089h	; 86b6
	defb 0eeh,089h	; 86b8
	defb 0eeh,089h	; 86ba
	defb 0eeh,089h	; 86bc
	defb 0eeh,089h	; 86be
	defb 0eeh,089h	; 86c0
	defb 00eh,08ah	; 86c2
	defb 02eh,08ah	; 86c4
	defb 04eh,08ah	; 86c6
	defb 06eh,08ah	; 86c8
	defb 08eh,08ah	; 86ca
	defb 0aeh,08ah	; 86cc

; ----------------------------------------------------------------------
; DATOS tablas_internas_8682: las 32 tablas de 16 palabras de
;   tabla_de_tablas_8682, seguidas: cada palabra apunta a un guion de bytes
;   sueltos; p00:4760, p01:6910 y p01:6985 las indexa con el segundo byte
;   menos uno
;   0x86ce..0x8ace  (1024 bytes)
DATA_tablas_internas_8682:
	defb 0ceh,08ah,0d3h,08ah,0d8h,08ah,0e0h,08ah,0e4h,08ah,0e9h,08ah,0eeh,08ah,0f3h,08ah,0f8h,08ah,003h,08bh,00ah,08bh,011h,08bh,01fh,08bh,02ch,08bh,039h,08bh,048h,08bh	; 86ce  ..........................,.9.H.
	defb 04fh,08bh,054h,08bh,059h,08bh,061h,08bh,065h,08bh,06ah,08bh,06fh,08bh,074h,08bh,079h,08bh,084h,08bh,08ah,08bh,091h,08bh,09fh,08bh,0ach,08bh,0b9h,08bh,0c8h,08bh	; 86ee  O.T.Y.a.e.j.o.t.y...............
	defb 0cfh,08bh,0d4h,08bh,0d9h,08bh,0deh,08bh,0e3h,08bh,0e8h,08bh,0edh,08bh,0f7h,08bh,001h,08ch,014h,08ch,027h,08ch,03ch,08ch,051h,08ch,072h,08ch,093h,08ch,0a8h,08ch	; 870e  ....................'.<.Q.r.....
	defb 0b1h,08ch,0b6h,08ch,0bah,08ch,0beh,08ch,0c2h,08ch,0c7h,08ch,0cch,08ch,0d6h,08ch,0e0h,08ch,0f3h,08ch,006h,08dh,01bh,08dh,030h,08dh,051h,08dh,072h,08dh,082h,08dh	; 872e  ........................0.Q.r...
	defb 089h,08dh,08eh,08dh,092h,08dh,096h,08dh,09ah,08dh,09fh,08dh,0a4h,08dh,0aeh,08dh,0b8h,08dh,0cbh,08dh,0deh,08dh,0f3h,08dh,008h,08eh,029h,08eh,04ah,08eh,05bh,08eh	; 874e  ..........................).J.[.
	defb 062h,08eh,065h,08eh,068h,08eh,06dh,08eh,072h,08eh,077h,08eh,081h,08eh,087h,08eh,08ch,08eh,092h,08eh,099h,08eh,0a5h,08eh,0b2h,08eh,0c0h,08eh,0d1h,08eh,0d4h,08eh	; 876e  b.e.h.m.r.w.....................
	defb 0d7h,08eh,0dah,08eh,0ddh,08eh,0e2h,08eh,0e7h,08eh,0ech,08eh,0f6h,08eh,0fch,08eh,001h,08fh,007h,08fh,00eh,08fh,01ah,08fh,027h,08fh,036h,08fh,047h,08fh,04ah,08fh	; 878e  ........................'.6.G.J.
	defb 062h,08eh,065h,08eh,068h,08eh,06dh,08eh,04dh,08fh,052h,08fh,05ch,08fh,062h,08fh,067h,08fh,073h,08fh,07fh,08fh,092h,08fh,0a6h,08fh,0c4h,08fh,0eah,08fh,0fch,08fh	; 87ae  b.e.h.m.M.R.\.b.g.s.............
	defb 0d7h,08eh,0dah,08eh,0ddh,08eh,0e2h,08eh,006h,090h,00bh,090h,015h,090h,01bh,090h,020h,090h,02ch,090h,038h,090h,04bh,090h,05fh,090h,07dh,090h,0a3h,090h,0b5h,090h	; 87ce  ................ .,.8.K._.}.....
	defb 0bfh,090h,0c2h,090h,0c5h,090h,0c8h,090h,0cdh,090h,0d3h,090h,0dah,090h,0e2h,090h,0eah,090h,0f3h,090h,007h,091h,01dh,091h,033h,091h,04bh,091h,065h,091h,083h,091h	; 87ee  ........................3.K.e...
	defb 091h,091h,094h,091h,097h,091h,09ah,091h,09fh,091h,0a5h,091h,0ach,091h,0b4h,091h,0bch,091h,0c5h,091h,0d9h,091h,0efh,091h,005h,092h,01dh,092h,037h,092h,055h,092h	; 880e  ............................7.U.
	defb 063h,092h,067h,092h,06bh,092h,071h,092h,077h,092h,07eh,092h,086h,092h,08fh,092h,09ah,092h,0a6h,092h,0c0h,092h,0deh,092h,0ffh,092h,023h,093h,04ah,093h,074h,093h	; 882e  c.g.k.q.w.~...............#.J.t.
	defb 08bh,093h,08fh,093h,093h,093h,099h,093h,09fh,093h,0a6h,093h,0aeh,093h,0b7h,093h,0c2h,093h,0ceh,093h,0e8h,093h,006h,094h,027h,094h,04bh,094h,072h,094h,09ch,094h	; 884e  ........................'.K.r...
	defb 0b3h,094h,0b8h,094h,0bdh,094h,0c2h,094h,0c7h,094h,0cch,094h,0dah,094h,0e1h,094h,0efh,094h,0fdh,094h,016h,095h,02fh,095h,048h,095h,067h,095h,086h,095h,0a5h,095h	; 886e  ....................../.H.g.....
	defb 0bdh,095h,0c1h,095h,0c6h,095h,0cah,095h,0cfh,095h,0d4h,095h,0e0h,095h,0e6h,095h,0f4h,095h,002h,096h,018h,096h,031h,096h,04ah,096h,069h,096h,088h,096h,0a7h,096h	; 888e  ......................1.J.i.....
	defb 0bfh,096h,0c3h,096h,0c8h,096h,0cch,096h,0d1h,096h,0d6h,096h,0e2h,096h,0e8h,096h,0f6h,096h,004h,097h,01ah,097h,033h,097h,04ch,097h,06bh,097h,08ah,097h,0a9h,097h	; 88ae  ......................3.L.k.....
	defb 0c1h,097h,0c5h,097h,0cbh,097h,0d2h,097h,0dah,097h,0e3h,097h,0edh,097h,0f8h,097h,004h,098h,010h,098h,01fh,098h,044h,098h,071h,098h,0a0h,098h,0d3h,098h,008h,099h	; 88ce  ......................D.q.......
	defb 041h,099h,045h,099h,04bh,099h,052h,099h,05ah,099h,063h,099h,06dh,099h,078h,099h,084h,099h,090h,099h,09fh,099h,0c4h,099h,0f1h,099h,020h,09ah,053h,09ah,088h,09ah	; 88ee  A.E.K.R.Z.c.m.x........... .S...
	defb 0c1h,09ah,0c4h,09ah,0c7h,09ah,0cah,09ah,0ceh,09ah,0d2h,09ah,0d6h,09ah,0deh,09ah,0e3h,09ah,0ech,09ah,0f4h,09ah,003h,09bh,019h,09bh,031h,09bh,04eh,09bh,06dh,09bh	; 890e  ..........................1.N.m.
	defb 079h,09bh,07ch,09bh,07fh,09bh,082h,09bh,086h,09bh,08ah,09bh,08eh,09bh,096h,09bh,09bh,09bh,0a4h,09bh,0ach,09bh,0bbh,09bh,0d1h,09bh,0e9h,09bh,006h,09ch,025h,09ch	; 892e  y.|...........................%.
	defb 031h,09ch,039h,09ch,041h,09ch,04bh,09ch,055h,09ch,05fh,09ch,06fh,09ch,081h,09ch,094h,09ch,0a7h,09ch,0c1h,09ch,0deh,09ch,0fch,09ch,01ah,09dh,03fh,09dh,04fh,09dh	; 894e  1.9.A.K.U._.o...............?.O.
	defb 057h,09dh,05ch,09dh,061h,09dh,066h,09dh,06bh,09dh,076h,09dh,082h,09dh,094h,09dh,0a7h,09dh,0c0h,09dh,0dbh,09dh,0f7h,09dh,015h,09eh,033h,09eh,058h,09eh,068h,09eh	; 896e  W.\.a.f.k.v...............3.X.h.
	defb 070h,09eh,07ah,09eh,084h,09eh,08eh,09eh,099h,09eh,0a5h,09eh,0b1h,09eh,0c3h,09eh,0d8h,09eh,0edh,09eh,002h,09fh,017h,09fh,034h,09fh,059h,09fh,07eh,09fh,0a5h,09fh	; 898e  p.z.....................4.Y.~...
	defb 0b9h,09fh,0c3h,09fh,0cdh,09fh,0d7h,09fh,0e1h,09fh,0ebh,09fh,0fch,09fh,010h,0a0h,024h,0a0h,03eh,0a0h,053h,0a0h,06eh,0a0h,089h,0a0h,0adh,0a0h,0d2h,0a0h,0d5h,0a0h	; 89ae  ................$.>.S.n.........
	defb 0d8h,0a0h,0ddh,0a0h,0e2h,0a0h,0ech,0a0h,0f8h,0a0h,004h,0a1h,010h,0a1h,022h,0a1h,037h,0a1h,04ch,0a1h,062h,0a1h,077h,0a1h,093h,0a1h,0b8h,0a1h,0ddh,0a1h,004h,0a2h	; 89ce  ..............".7.L.b.w.........
	defb 0cfh,08bh,0d4h,08bh,0d9h,08bh,0deh,08bh,0e3h,08bh,0e8h,08bh,0edh,08bh,0f7h,08bh,001h,08ch,014h,08ch,027h,08ch,03ch,08ch,051h,08ch,072h,08ch,01ch,0a2h,032h,0a2h	; 89ee  ....................'.<.Q.r...2.
	defb 0b1h,08ch,0b6h,08ch,0bah,08ch,0beh,08ch,0c2h,08ch,0c7h,08ch,0cch,08ch,0d6h,08ch,0e0h,08ch,0f3h,08ch,006h,08dh,01bh,08dh,030h,08dh,051h,08dh,053h,0a2h,062h,0a2h	; 8a0e  ........................0.Q.S.b.
	defb 089h,08dh,08eh,08dh,092h,08dh,096h,08dh,09ah,08dh,09fh,08dh,0a4h,08dh,0aeh,08dh,0b8h,08dh,0cbh,08dh,0deh,08dh,0f3h,08dh,008h,08eh,029h,08eh,073h,0a2h,083h,0a2h	; 8a2e  ..........................).s...
	defb 062h,08eh,065h,08eh,068h,08eh,06dh,08eh,04dh,08fh,052h,08fh,05ch,08fh,062h,08fh,067h,08fh,073h,08fh,07fh,08fh,092h,08fh,0a6h,08fh,0c4h,08fh,08eh,0a2h,0a6h,0a2h	; 8a4e  b.e.h.m.M.R.\.b.g.s.............
	defb 0d7h,08eh,0dah,08eh,0ddh,08eh,0e2h,08eh,006h,090h,00bh,090h,015h,090h,01bh,090h,020h,090h,02ch,090h,038h,090h,04bh,090h,05fh,090h,07dh,090h,0cdh,0a2h,0e5h,0a2h	; 8a6e  ................ .,.8.K._.}.....
	defb 0c1h,097h,0c5h,097h,0cbh,097h,0d2h,097h,0dah,097h,0e3h,097h,0edh,097h,0f8h,097h,004h,098h,010h,098h,01fh,098h,044h,098h,071h,098h,0a0h,098h,00ch,0a3h,04bh,0a3h	; 8a8e  ......................D.q.....K.
	defb 041h,099h,045h,099h,04bh,099h,052h,099h,05ah,099h,063h,099h,06dh,099h,078h,099h,084h,099h,090h,099h,09fh,099h,0c4h,099h,0f1h,099h,020h,09ah,096h,0a3h,0d5h,0a3h	; 8aae  A.E.K.R.Z.c.m.x........... .....

; ----------------------------------------------------------------------
; DATOS tira_8ACE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[0] (5 bytes)
;   0x8ace..0x8ad3  (5 bytes)
DATA_tira_8ACE:
	defb 0eeh,0ech,0f0h,0e4h,0ffh	; 8ace

; ----------------------------------------------------------------------
; DATOS tira_8AD3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[1] (5 bytes)
;   0x8ad3..0x8ad8  (5 bytes)
DATA_tira_8AD3:
	defb 0eeh,0ech,0f1h,0e3h,0ffh	; 8ad3

; ----------------------------------------------------------------------
; DATOS tira_8AD8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[2] (8 bytes)
;   0x8ad8..0x8ae0  (8 bytes)
DATA_tira_8AD8:
	defb 0eeh,0ech,0fbh,0feh,00eh,0edh,0fdh,0ffh	; 8ad8  ........

; ----------------------------------------------------------------------
; DATOS tira_8AE0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[3] (4 bytes)
;   0x8ae0..0x8ae4  (4 bytes)
DATA_tira_8AE0:
	defb 00eh,0edh,0f6h,0ffh	; 8ae0

; ----------------------------------------------------------------------
; DATOS tira_8AE4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[4] (5 bytes)
;   0x8ae4..0x8ae9  (5 bytes)
DATA_tira_8AE4:
	defb 00dh,0edh,0e7h,0ech,0ffh	; 8ae4

; ----------------------------------------------------------------------
; DATOS tira_8AE9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[5] (5 bytes)
;   0x8ae9..0x8aee  (5 bytes)
DATA_tira_8AE9:
	defb 02dh,0edh,0eeh,0eah,0ffh	; 8ae9

; ----------------------------------------------------------------------
; DATOS tira_8AEE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[6] (5 bytes)
;   0x8aee..0x8af3  (5 bytes)
DATA_tira_8AEE:
	defb 02dh,0edh,0f2h,0e2h,0ffh	; 8aee

; ----------------------------------------------------------------------
; DATOS tira_8AF3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[7] (5 bytes)
;   0x8af3..0x8af8  (5 bytes)
DATA_tira_8AF3:
	defb 04ch,0edh,0e8h,0f3h,0ffh	; 8af3

; ----------------------------------------------------------------------
; DATOS tira_8AF8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[8] (11 bytes)
;   0x8af8..0x8b03  (11 bytes)
DATA_tira_8AF8:
	defb 04ch,0edh,0f9h,0fch,0feh,06bh,0edh,0e0h,0efh,0ebh,0ffh	; 8af8  L....k.....

; ----------------------------------------------------------------------
; DATOS tira_8B03: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[9] (7 bytes)
;   0x8b03..0x8b0a  (7 bytes)
DATA_tira_8B03:
	defb 08ah,0edh,0bah,0c2h,0dbh,0b2h,0ffh	; 8b03

; ----------------------------------------------------------------------
; DATOS tira_8B0A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[10] (7 bytes)
;   0x8b0a..0x8b11  (7 bytes)
DATA_tira_8B0A:
	defb 0a9h,0edh,0bbh,0c3h,0dah,0b3h,0ffh	; 8b0a

; ----------------------------------------------------------------------
; DATOS tira_8B11: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[11] (14 bytes)
;   0x8b11..0x8b1f  (14 bytes)
DATA_tira_8B11:
	defb 0c8h,0edh,0b9h,0d9h,0dch,0c7h,0feh,0e8h,0edh,0b8h,0d8h,0c6h,0b1h,0ffh	; 8b11  ..............

; ----------------------------------------------------------------------
; DATOS tira_8B1F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[12] (13 bytes)
;   0x8b1f..0x8b2c  (13 bytes)
DATA_tira_8B1F:
	defb 0e8h,0edh,0bch,0ceh,0c4h,0feh,007h,0eeh,0b4h,0bdh,0cah,0cbh,0ffh	; 8b1f  .............

; ----------------------------------------------------------------------
; DATOS tira_8B2C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[13] (13 bytes)
;   0x8b2c..0x8b39  (13 bytes)
DATA_tira_8B2C:
	defb 008h,0eeh,0ddh,0deh,0feh,026h,0eeh,0b6h,0bfh,0cdh,0d0h,0afh,0ffh	; 8b2c  .....&.......

; ----------------------------------------------------------------------
; DATOS tira_8B39: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[14] (15 bytes)
;   0x8b39..0x8b48  (15 bytes)
DATA_tira_8B39:
	defb 046h,0eeh,0aeh,0d6h,0d7h,0b0h,0feh,065h,0eeh,0b7h,0d3h,0d4h,0d5h,0cch,0ffh	; 8b39  F......e.......

; ----------------------------------------------------------------------
; DATOS tira_8B48: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86CE[15] (7 bytes)
;   0x8b48..0x8b4f  (7 bytes)
DATA_tira_8B48:
	defb 065h,0eeh,0c1h,0c8h,0c8h,0c9h,0ffh	; 8b48

; ----------------------------------------------------------------------
; DATOS tira_8B4F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[0] (5 bytes)
;   0x8b4f..0x8b54  (5 bytes)
DATA_tira_8B4F:
	defb 0f0h,0ech,0e7h,0edh,0ffh	; 8b4f

; ----------------------------------------------------------------------
; DATOS tira_8B54: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[1] (5 bytes)
;   0x8b54..0x8b59  (5 bytes)
DATA_tira_8B54:
	defb 0f0h,0ech,0e5h,0e9h,0ffh	; 8b54

; ----------------------------------------------------------------------
; DATOS tira_8B59: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[2] (8 bytes)
;   0x8b59..0x8b61  (8 bytes)
DATA_tira_8B59:
	defb 0f1h,0ech,0f8h,0feh,011h,0edh,0fah,0ffh	; 8b59  ........

; ----------------------------------------------------------------------
; DATOS tira_8B61: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[3] (4 bytes)
;   0x8b61..0x8b65  (4 bytes)
DATA_tira_8B61:
	defb 011h,0edh,0f6h,0ffh	; 8b61

; ----------------------------------------------------------------------
; DATOS tira_8B65: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[4] (5 bytes)
;   0x8b65..0x8b6a  (5 bytes)
DATA_tira_8B65:
	defb 011h,0edh,0f4h,0e4h,0ffh	; 8b65

; ----------------------------------------------------------------------
; DATOS tira_8B6A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[5] (5 bytes)
;   0x8b6a..0x8b6f  (5 bytes)
DATA_tira_8B6A:
	defb 031h,0edh,0eeh,0eah,0ffh	; 8b6a

; ----------------------------------------------------------------------
; DATOS tira_8B6F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[6] (5 bytes)
;   0x8b6f..0x8b74  (5 bytes)
DATA_tira_8B6F:
	defb 031h,0edh,0e6h,0f5h,0ffh	; 8b6f

; ----------------------------------------------------------------------
; DATOS tira_8B74: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[7] (5 bytes)
;   0x8b74..0x8b79  (5 bytes)
DATA_tira_8B74:
	defb 052h,0edh,0f7h,0e1h,0ffh	; 8b74

; ----------------------------------------------------------------------
; DATOS tira_8B79: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[8] (11 bytes)
;   0x8b79..0x8b84  (11 bytes)
DATA_tira_8B79:
	defb 052h,0edh,0f9h,0fch,0feh,071h,0edh,0e0h,0efh,0ebh,0ffh	; 8b79  R....q.....

; ----------------------------------------------------------------------
; DATOS tira_8B84: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[9] (6 bytes)
;   0x8b84..0x8b8a  (6 bytes)
DATA_tira_8B84:
	defb 092h,0edh,0beh,0cfh,0c5h,0ffh	; 8b84

; ----------------------------------------------------------------------
; DATOS tira_8B8A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[10] (7 bytes)
;   0x8b8a..0x8b91  (7 bytes)
DATA_tira_8B8A:
	defb 0b2h,0edh,0b5h,0c0h,0d1h,0d2h,0ffh	; 8b8a

; ----------------------------------------------------------------------
; DATOS tira_8B91: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[11] (14 bytes)
;   0x8b91..0x8b9f  (14 bytes)
DATA_tira_8B91:
	defb 0d3h,0edh,0b9h,0d9h,0dch,0c7h,0feh,0f3h,0edh,0b8h,0d8h,0c6h,0b1h,0ffh	; 8b91  ..............

; ----------------------------------------------------------------------
; DATOS tira_8B9F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[12] (13 bytes)
;   0x8b9f..0x8bac  (13 bytes)
DATA_tira_8B9F:
	defb 0f5h,0edh,0bch,0ceh,0c4h,0feh,014h,0eeh,0b4h,0bdh,0cah,0cbh,0ffh	; 8b9f  .............

; ----------------------------------------------------------------------
; DATOS tira_8BAC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[13] (13 bytes)
;   0x8bac..0x8bb9  (13 bytes)
DATA_tira_8BAC:
	defb 016h,0eeh,0ddh,0deh,0feh,034h,0eeh,0b6h,0bfh,0cdh,0d0h,0afh,0ffh	; 8bac  .....4.......

; ----------------------------------------------------------------------
; DATOS tira_8BB9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[14] (15 bytes)
;   0x8bb9..0x8bc8  (15 bytes)
DATA_tira_8BB9:
	defb 056h,0eeh,0aeh,0d6h,0d7h,0b0h,0feh,075h,0eeh,0b7h,0d3h,0d4h,0d5h,0cch,0ffh	; 8bb9  V......u.......

; ----------------------------------------------------------------------
; DATOS tira_8BC8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x86EE[15] (7 bytes)
;   0x8bc8..0x8bcf  (7 bytes)
DATA_tira_8BC8:
	defb 077h,0eeh,0c1h,0c8h,0c8h,0c9h,0ffh	; 8bc8

; ----------------------------------------------------------------------
; DATOS tira_8BCF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[0], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[0] (5 bytes)
;   0x8bcf..0x8bd4  (5 bytes)
DATA_tira_8BCF:
	defb 0efh,0ech,0d4h,0dah,0ffh	; 8bcf

; ----------------------------------------------------------------------
; DATOS tira_8BD4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[1], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[1] (5 bytes)
;   0x8bd4..0x8bd9  (5 bytes)
DATA_tira_8BD4:
	defb 0efh,0ech,0d5h,0dbh,0ffh	; 8bd4

; ----------------------------------------------------------------------
; DATOS tira_8BD9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[2], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[2] (5 bytes)
;   0x8bd9..0x8bde  (5 bytes)
DATA_tira_8BD9:
	defb 0efh,0ech,0d6h,0dch,0ffh	; 8bd9

; ----------------------------------------------------------------------
; DATOS tira_8BDE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[3], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[3] (5 bytes)
;   0x8bde..0x8be3  (5 bytes)
DATA_tira_8BDE:
	defb 0efh,0ech,0d7h,0ddh,0ffh	; 8bde

; ----------------------------------------------------------------------
; DATOS tira_8BE3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[4], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[4] (5 bytes)
;   0x8be3..0x8be8  (5 bytes)
DATA_tira_8BE3:
	defb 00fh,0edh,0cfh,0d0h,0ffh	; 8be3

; ----------------------------------------------------------------------
; DATOS tira_8BE8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[5], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[5] (5 bytes)
;   0x8be8..0x8bed  (5 bytes)
DATA_tira_8BE8:
	defb 02fh,0edh,0cfh,0d0h,0ffh	; 8be8

; ----------------------------------------------------------------------
; DATOS tira_8BED: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[6], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[6] (10 bytes)
;   0x8bed..0x8bf7  (10 bytes)
DATA_tira_8BED:
	defb 02fh,0edh,0cbh,0c8h,0feh,04fh,0edh,0cdh,0d2h,0ffh	; 8bed  /....O....

; ----------------------------------------------------------------------
; DATOS tira_8BF7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[7], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[7] (10 bytes)
;   0x8bf7..0x8c01  (10 bytes)
DATA_tira_8BF7:
	defb 04fh,0edh,0cbh,0c8h,0feh,06fh,0edh,0cdh,0d2h,0ffh	; 8bf7  O....o....

; ----------------------------------------------------------------------
; DATOS tira_8C01: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[8], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[8] (19 bytes)
;   0x8c01..0x8c14  (19 bytes)
DATA_tira_8C01:
	defb 04fh,0edh,0c9h,0cah,0feh,06eh,0edh,0ceh,0cch,0c7h,0d1h,0feh,08eh,0edh,0e6h,0e4h	; 8c01  O....n..........
	defb 0f6h,0fch,0ffh	; 8c11

; ----------------------------------------------------------------------
; DATOS tira_8C14: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[9], p00:4760, p01:6910 y p01:6985
;   por 0x89EE[9] (19 bytes)
;   0x8c14..0x8c27  (19 bytes)
DATA_tira_8C14:
	defb 06fh,0edh,0c9h,0cah,0feh,08eh,0edh,0e5h,0f5h,0eeh,0f3h,0feh,0aeh,0edh,0e6h,0e4h	; 8c14  o...............
	defb 0f6h,0fch,0ffh	; 8c24

; ----------------------------------------------------------------------
; DATOS tira_8C27: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[10], p00:4760, p01:6910 y
;   p01:6985 por 0x89EE[10] (21 bytes)
;   0x8c27..0x8c3c  (21 bytes)
DATA_tira_8C27:
	defb 08eh,0edh,0e7h,0f4h,0efh,0f0h,0feh,0aeh,0edh,0e4h,0f7h,0eeh,0fdh,0feh,0ceh,0edh	; 8c27  ................
	defb 0e8h,0e4h,0e4h,0fbh,0ffh	; 8c37

; ----------------------------------------------------------------------
; DATOS tira_8C3C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[11], p00:4760, p01:6910 y
;   p01:6985 por 0x89EE[11] (21 bytes)
;   0x8c3c..0x8c51  (21 bytes)
DATA_tira_8C3C:
	defb 0aeh,0edh,0e7h,0f4h,0efh,0f0h,0feh,0ceh,0edh,0e4h,0f7h,0eeh,0fdh,0feh,0eeh,0edh	; 8c3c  ................
	defb 0e8h,0e4h,0e4h,0fbh,0ffh	; 8c4c

; ----------------------------------------------------------------------
; DATOS tira_8C51: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[12], p00:4760, p01:6910 y
;   p01:6985 por 0x89EE[12] (33 bytes)
;   0x8c51..0x8c72  (33 bytes)
DATA_tira_8C51:
	defb 0aeh,0edh,0e9h,0f4h,0efh,0f1h,0feh,0cdh,0edh,0eah,0e4h,0eeh,0eeh,0eeh,0f2h,0feh	; 8c51  ................
	defb 0edh,0edh,0ech,0e4h,0f8h,0f9h,0fah,0edh,0feh,00eh,0eeh,0e8h,0e4h,0e4h,0e4h,0e3h	; 8c61  ................
	defb 0ffh	; 8c71

; ----------------------------------------------------------------------
; DATOS tira_8C72: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[13], p00:4760, p01:6910 y
;   p01:6985 por 0x89EE[13] (33 bytes)
;   0x8c72..0x8c93  (33 bytes)
DATA_tira_8C72:
	defb 0ceh,0edh,0e9h,0f4h,0efh,0f1h,0feh,0edh,0edh,0eah,0e4h,0eeh,0eeh,0eeh,0f2h,0feh	; 8c72  ................
	defb 00dh,0eeh,0ech,0e4h,0f8h,0f9h,0fah,0edh,0feh,02eh,0eeh,0e8h,0e4h,0e4h,0e4h,0e3h	; 8c82  ................
	defb 0ffh	; 8c92

; ----------------------------------------------------------------------
; DATOS tira_8C93: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[14] (21 bytes)
;   0x8c93..0x8ca8  (21 bytes)
DATA_tira_8C93:
	defb 04dh,0eeh,0e9h,0f4h,0eeh,0eeh,0efh,0f1h,0feh,06ch,0eeh,0e7h,0e4h,0eeh,0eeh,0eeh	; 8c93  M........l......
	defb 0eeh,0eeh,0efh,0f1h,0ffh	; 8ca3

; ----------------------------------------------------------------------
; DATOS tira_8CA8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x870E[15] (9 bytes)
;   0x8ca8..0x8cb1  (9 bytes)
DATA_tira_8CA8:
	defb 06dh,0eeh,0e9h,0f4h,0eeh,0eeh,0efh,0f1h,0ffh	; 8ca8  m........

; ----------------------------------------------------------------------
; DATOS tira_8CB1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[0], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[0] (5 bytes)
;   0x8cb1..0x8cb6  (5 bytes)
DATA_tira_8CB1:
	defb 0eeh,0ech,0d4h,0dah,0ffh	; 8cb1

; ----------------------------------------------------------------------
; DATOS tira_8CB6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[1], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[1] (4 bytes)
;   0x8cb6..0x8cba  (4 bytes)
DATA_tira_8CB6:
	defb 0eeh,0ech,0d8h,0ffh	; 8cb6

; ----------------------------------------------------------------------
; DATOS tira_8CBA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[2], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[2] (4 bytes)
;   0x8cba..0x8cbe  (4 bytes)
DATA_tira_8CBA:
	defb 0eeh,0ech,0d9h,0ffh	; 8cba

; ----------------------------------------------------------------------
; DATOS tira_8CBE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[3], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[3] (4 bytes)
;   0x8cbe..0x8cc2  (4 bytes)
DATA_tira_8CBE:
	defb 0eeh,0ech,0d3h,0ffh	; 8cbe

; ----------------------------------------------------------------------
; DATOS tira_8CC2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[4], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[4] (5 bytes)
;   0x8cc2..0x8cc7  (5 bytes)
DATA_tira_8CC2:
	defb 00dh,0edh,0cfh,0d0h,0ffh	; 8cc2

; ----------------------------------------------------------------------
; DATOS tira_8CC7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[5], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[5] (5 bytes)
;   0x8cc7..0x8ccc  (5 bytes)
DATA_tira_8CC7:
	defb 02ch,0edh,0cfh,0d0h,0ffh	; 8cc7

; ----------------------------------------------------------------------
; DATOS tira_8CCC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[6], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[6] (10 bytes)
;   0x8ccc..0x8cd6  (10 bytes)
DATA_tira_8CCC:
	defb 02bh,0edh,0cbh,0c8h,0feh,04bh,0edh,0cdh,0d2h,0ffh	; 8ccc  +....K....

; ----------------------------------------------------------------------
; DATOS tira_8CD6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[7], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[7] (10 bytes)
;   0x8cd6..0x8ce0  (10 bytes)
DATA_tira_8CD6:
	defb 04ah,0edh,0cbh,0c8h,0feh,06ah,0edh,0cdh,0d2h,0ffh	; 8cd6  J....j....

; ----------------------------------------------------------------------
; DATOS tira_8CE0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[8], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[8] (19 bytes)
;   0x8ce0..0x8cf3  (19 bytes)
DATA_tira_8CE0:
	defb 049h,0edh,0c9h,0cah,0feh,068h,0edh,0ceh,0cch,0c7h,0d1h,0feh,088h,0edh,0e6h,0e4h	; 8ce0  I....h..........
	defb 0f6h,0fch,0ffh	; 8cf0

; ----------------------------------------------------------------------
; DATOS tira_8CF3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[9], p00:4760, p01:6910 y p01:6985
;   por 0x8A0E[9] (19 bytes)
;   0x8cf3..0x8d06  (19 bytes)
DATA_tira_8CF3:
	defb 068h,0edh,0c9h,0cah,0feh,087h,0edh,0e5h,0f5h,0eeh,0f3h,0feh,0a7h,0edh,0e6h,0e4h	; 8cf3  h...............
	defb 0f6h,0fch,0ffh	; 8d03

; ----------------------------------------------------------------------
; DATOS tira_8D06: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[10], p00:4760, p01:6910 y
;   p01:6985 por 0x8A0E[10] (21 bytes)
;   0x8d06..0x8d1b  (21 bytes)
DATA_tira_8D06:
	defb 086h,0edh,0e7h,0f4h,0efh,0f0h,0feh,0a6h,0edh,0e4h,0f7h,0eeh,0fdh,0feh,0c6h,0edh	; 8d06  ................
	defb 0e8h,0e4h,0e4h,0fbh,0ffh	; 8d16

; ----------------------------------------------------------------------
; DATOS tira_8D1B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[11], p00:4760, p01:6910 y
;   p01:6985 por 0x8A0E[11] (21 bytes)
;   0x8d1b..0x8d30  (21 bytes)
DATA_tira_8D1B:
	defb 0a5h,0edh,0e7h,0f4h,0efh,0f0h,0feh,0c5h,0edh,0e4h,0f7h,0eeh,0fdh,0feh,0e5h,0edh	; 8d1b  ................
	defb 0e8h,0e4h,0e4h,0fbh,0ffh	; 8d2b

; ----------------------------------------------------------------------
; DATOS tira_8D30: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[12], p00:4760, p01:6910 y
;   p01:6985 por 0x8A0E[12] (33 bytes)
;   0x8d30..0x8d51  (33 bytes)
DATA_tira_8D30:
	defb 0a4h,0edh,0e9h,0f4h,0efh,0f1h,0feh,0c3h,0edh,0eah,0e4h,0eeh,0eeh,0eeh,0f2h,0feh	; 8d30  ................
	defb 0e3h,0edh,0ech,0e4h,0f8h,0f9h,0fah,0edh,0feh,004h,0eeh,0e8h,0e4h,0e4h,0e4h,0e3h	; 8d40  ................
	defb 0ffh	; 8d50

; ----------------------------------------------------------------------
; DATOS tira_8D51: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[13], p00:4760, p01:6910 y
;   p01:6985 por 0x8A0E[13] (33 bytes)
;   0x8d51..0x8d72  (33 bytes)
DATA_tira_8D51:
	defb 0c3h,0edh,0e9h,0f4h,0efh,0f1h,0feh,0e2h,0edh,0eah,0e4h,0eeh,0eeh,0eeh,0f2h,0feh	; 8d51  ................
	defb 002h,0eeh,0ech,0e4h,0f8h,0f9h,0fah,0edh,0feh,023h,0eeh,0e8h,0e4h,0e4h,0e4h,0e3h	; 8d61  .........#......
	defb 0ffh	; 8d71

; ----------------------------------------------------------------------
; DATOS tira_8D72: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[14] (16 bytes)
;   0x8d72..0x8d82  (16 bytes)
DATA_tira_8D72:
	defb 040h,0eeh,0eeh,0eeh,0efh,0f1h,0feh,060h,0eeh,0eeh,0eeh,0eeh,0eeh,0efh,0f1h,0ffh	; 8d72  @......`........

; ----------------------------------------------------------------------
; DATOS tira_8D82: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x872E[15] (7 bytes)
;   0x8d82..0x8d89  (7 bytes)
DATA_tira_8D82:
	defb 060h,0eeh,0eeh,0eeh,0efh,0f1h,0ffh	; 8d82

; ----------------------------------------------------------------------
; DATOS tira_8D89: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[0], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[0] (5 bytes)
;   0x8d89..0x8d8e  (5 bytes)
DATA_tira_8D89:
	defb 0f0h,0ech,0d4h,0dah,0ffh	; 8d89

; ----------------------------------------------------------------------
; DATOS tira_8D8E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[1], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[1] (4 bytes)
;   0x8d8e..0x8d92  (4 bytes)
DATA_tira_8D8E:
	defb 0f1h,0ech,0deh,0ffh	; 8d8e

; ----------------------------------------------------------------------
; DATOS tira_8D92: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[2], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[2] (4 bytes)
;   0x8d92..0x8d96  (4 bytes)
DATA_tira_8D92:
	defb 0f1h,0ech,0dfh,0ffh	; 8d92

; ----------------------------------------------------------------------
; DATOS tira_8D96: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[3], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[3] (4 bytes)
;   0x8d96..0x8d9a  (4 bytes)
DATA_tira_8D96:
	defb 0f1h,0ech,0d3h,0ffh	; 8d96

; ----------------------------------------------------------------------
; DATOS tira_8D9A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[4], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[4] (5 bytes)
;   0x8d9a..0x8d9f  (5 bytes)
DATA_tira_8D9A:
	defb 011h,0edh,0cfh,0d0h,0ffh	; 8d9a

; ----------------------------------------------------------------------
; DATOS tira_8D9F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[5], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[5] (5 bytes)
;   0x8d9f..0x8da4  (5 bytes)
DATA_tira_8D9F:
	defb 032h,0edh,0cfh,0d0h,0ffh	; 8d9f

; ----------------------------------------------------------------------
; DATOS tira_8DA4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[6], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[6] (10 bytes)
;   0x8da4..0x8dae  (10 bytes)
DATA_tira_8DA4:
	defb 033h,0edh,0cbh,0c8h,0feh,053h,0edh,0cdh,0d2h,0ffh	; 8da4  3....S....

; ----------------------------------------------------------------------
; DATOS tira_8DAE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[7], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[7] (10 bytes)
;   0x8dae..0x8db8  (10 bytes)
DATA_tira_8DAE:
	defb 054h,0edh,0cbh,0c8h,0feh,074h,0edh,0cdh,0d2h,0ffh	; 8dae  T....t....

; ----------------------------------------------------------------------
; DATOS tira_8DB8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[8], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[8] (19 bytes)
;   0x8db8..0x8dcb  (19 bytes)
DATA_tira_8DB8:
	defb 055h,0edh,0c9h,0cah,0feh,074h,0edh,0ceh,0cch,0c7h,0d1h,0feh,094h,0edh,0e6h,0e4h	; 8db8  U....t..........
	defb 0f6h,0fch,0ffh	; 8dc8

; ----------------------------------------------------------------------
; DATOS tira_8DCB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[9], p00:4760, p01:6910 y p01:6985
;   por 0x8A2E[9] (19 bytes)
;   0x8dcb..0x8dde  (19 bytes)
DATA_tira_8DCB:
	defb 076h,0edh,0c9h,0cah,0feh,095h,0edh,0e5h,0f5h,0eeh,0f3h,0feh,0b5h,0edh,0e6h,0e4h	; 8dcb  v...............
	defb 0f6h,0fch,0ffh	; 8ddb

; ----------------------------------------------------------------------
; DATOS tira_8DDE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[10], p00:4760, p01:6910 y
;   p01:6985 por 0x8A2E[10] (21 bytes)
;   0x8dde..0x8df3  (21 bytes)
DATA_tira_8DDE:
	defb 096h,0edh,0e7h,0f4h,0efh,0f0h,0feh,0b6h,0edh,0e4h,0f7h,0eeh,0fdh,0feh,0d6h,0edh	; 8dde  ................
	defb 0e8h,0e4h,0e4h,0fbh,0ffh	; 8dee

; ----------------------------------------------------------------------
; DATOS tira_8DF3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[11], p00:4760, p01:6910 y
;   p01:6985 por 0x8A2E[11] (21 bytes)
;   0x8df3..0x8e08  (21 bytes)
DATA_tira_8DF3:
	defb 0b7h,0edh,0e7h,0f4h,0efh,0f0h,0feh,0d7h,0edh,0e4h,0f7h,0eeh,0fdh,0feh,0f7h,0edh	; 8df3  ................
	defb 0e8h,0e4h,0e4h,0fbh,0ffh	; 8e03

; ----------------------------------------------------------------------
; DATOS tira_8E08: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[12], p00:4760, p01:6910 y
;   p01:6985 por 0x8A2E[12] (33 bytes)
;   0x8e08..0x8e29  (33 bytes)
DATA_tira_8E08:
	defb 0b8h,0edh,0e9h,0f4h,0efh,0f1h,0feh,0d7h,0edh,0eah,0e4h,0eeh,0eeh,0eeh,0f2h,0feh	; 8e08  ................
	defb 0f7h,0edh,0ech,0e4h,0f8h,0f9h,0fah,0edh,0feh,018h,0eeh,0e8h,0e4h,0e4h,0e4h,0e3h	; 8e18  ................
	defb 0ffh	; 8e28

; ----------------------------------------------------------------------
; DATOS tira_8E29: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[13], p00:4760, p01:6910 y
;   p01:6985 por 0x8A2E[13] (33 bytes)
;   0x8e29..0x8e4a  (33 bytes)
DATA_tira_8E29:
	defb 0d9h,0edh,0e9h,0f4h,0efh,0f1h,0feh,0f8h,0edh,0eah,0e4h,0eeh,0eeh,0eeh,0f2h,0feh	; 8e29  ................
	defb 018h,0eeh,0ech,0e4h,0f8h,0f9h,0fah,0edh,0feh,039h,0eeh,0e8h,0e4h,0e4h,0e4h,0e3h	; 8e39  .........9......
	defb 0ffh	; 8e49

; ----------------------------------------------------------------------
; DATOS tira_8E4A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[14] (17 bytes)
;   0x8e4a..0x8e5b  (17 bytes)
DATA_tira_8E4A:
	defb 05bh,0eeh,0e9h,0f4h,0eeh,0eeh,0efh,0feh,07ah,0eeh,0e7h,0e4h,0eeh,0eeh,0eeh,0eeh	; 8e4a  [.......z.......
	defb 0ffh	; 8e5a

; ----------------------------------------------------------------------
; DATOS tira_8E5B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x874E[15] (7 bytes)
;   0x8e5b..0x8e62  (7 bytes)
DATA_tira_8E5B:
	defb 07ch,0eeh,0e9h,0f4h,0eeh,0eeh,0ffh	; 8e5b

; ----------------------------------------------------------------------
; DATOS tira_8E62: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[0], p00:4760, p01:6910 y p01:6985
;   por 0x87AE[0], p00:4760, p01:6910 y p01:6985 por 0x8A4E[0] (3 bytes)
;   0x8e62..0x8e65  (3 bytes)
DATA_tira_8E62:
	defb 0f0h,0ech,0ffh	; 8e62

; ----------------------------------------------------------------------
; DATOS tira_8E65: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[1], p00:4760, p01:6910 y p01:6985
;   por 0x87AE[1], p00:4760, p01:6910 y p01:6985 por 0x8A4E[1] (3 bytes)
;   0x8e65..0x8e68  (3 bytes)
DATA_tira_8E65:
	defb 0f0h,0ech,0ffh	; 8e65

; ----------------------------------------------------------------------
; DATOS tira_8E68: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[2], p00:4760, p01:6910 y p01:6985
;   por 0x87AE[2], p00:4760, p01:6910 y p01:6985 por 0x8A4E[2] (5 bytes)
;   0x8e68..0x8e6d  (5 bytes)
DATA_tira_8E68:
	defb 00eh,0edh,09ah,0a7h,0ffh	; 8e68

; ----------------------------------------------------------------------
; DATOS tira_8E6D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[3], p00:4760, p01:6910 y p01:6985
;   por 0x87AE[3], p00:4760, p01:6910 y p01:6985 por 0x8A4E[3] (5 bytes)
;   0x8e6d..0x8e72  (5 bytes)
DATA_tira_8E6D:
	defb 00eh,0edh,099h,098h,0ffh	; 8e6d

; ----------------------------------------------------------------------
; DATOS tira_8E72: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[4] (5 bytes)
;   0x8e72..0x8e77  (5 bytes)
DATA_tira_8E72:
	defb 02dh,0edh,097h,08fh,0ffh	; 8e72

; ----------------------------------------------------------------------
; DATOS tira_8E77: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[5] (10 bytes)
;   0x8e77..0x8e81  (10 bytes)
DATA_tira_8E77:
	defb 02dh,0edh,090h,091h,0feh,04dh,0edh,08dh,092h,0ffh	; 8e77  -....M....

; ----------------------------------------------------------------------
; DATOS tira_8E81: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[6] (6 bytes)
;   0x8e81..0x8e87  (6 bytes)
DATA_tira_8E81:
	defb 04ch,0edh,093h,094h,095h,0ffh	; 8e81

; ----------------------------------------------------------------------
; DATOS tira_8E87: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[7] (5 bytes)
;   0x8e87..0x8e8c  (5 bytes)
DATA_tira_8E87:
	defb 06ch,0edh,096h,0a3h,0ffh	; 8e87

; ----------------------------------------------------------------------
; DATOS tira_8E8C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[8] (6 bytes)
;   0x8e8c..0x8e92  (6 bytes)
DATA_tira_8E8C:
	defb 08bh,0edh,072h,05ah,06bh,0ffh	; 8e8c

; ----------------------------------------------------------------------
; DATOS tira_8E92: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[9] (7 bytes)
;   0x8e92..0x8e99  (7 bytes)
DATA_tira_8E92:
	defb 0aah,0edh,068h,05ah,05ah,06fh,0ffh	; 8e92

; ----------------------------------------------------------------------
; DATOS tira_8E99: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[10] (12 bytes)
;   0x8e99..0x8ea5  (12 bytes)
DATA_tira_8E99:
	defb 0aah,0edh,05ch,073h,073h,0feh,0cah,0edh,069h,069h,070h,0ffh	; 8e99  ..\ss...iip.

; ----------------------------------------------------------------------
; DATOS tira_8EA5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[11] (13 bytes)
;   0x8ea5..0x8eb2  (13 bytes)
DATA_tira_8EA5:
	defb 0c9h,0edh,05ch,074h,06dh,0feh,0e9h,0edh,069h,069h,070h,06bh,0ffh	; 8ea5  ..\tm...iipk.

; ----------------------------------------------------------------------
; DATOS tira_8EB2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[12] (14 bytes)
;   0x8eb2..0x8ec0  (14 bytes)
DATA_tira_8EB2:
	defb 0e8h,0edh,05ch,074h,06dh,073h,0feh,008h,0eeh,072h,069h,070h,070h,0ffh	; 8eb2  ..\tms...ripp.

; ----------------------------------------------------------------------
; DATOS tira_8EC0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[13] (17 bytes)
;   0x8ec0..0x8ed1  (17 bytes)
DATA_tira_8EC0:
	defb 026h,0eeh,05ch,073h,074h,06dh,073h,0feh,046h,0eeh,072h,069h,069h,070h,070h,06bh	; 8ec0  &.\stms.F.riippk
	defb 0ffh	; 8ed0

; ----------------------------------------------------------------------
; DATOS tira_8ED1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[14] (3 bytes)
;   0x8ed1..0x8ed4  (3 bytes)
DATA_tira_8ED1:
	defb 055h,0eeh,0ffh	; 8ed1

; ----------------------------------------------------------------------
; DATOS tira_8ED4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x876E[15] (3 bytes)
;   0x8ed4..0x8ed7  (3 bytes)
DATA_tira_8ED4:
	defb 076h,0eeh,0ffh	; 8ed4

; ----------------------------------------------------------------------
; DATOS tira_8ED7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[0], p00:4760, p01:6910 y p01:6985
;   por 0x87CE[0], p00:4760, p01:6910 y p01:6985 por 0x8A6E[0] (3 bytes)
;   0x8ed7..0x8eda  (3 bytes)
DATA_tira_8ED7:
	defb 0f0h,0ech,0ffh	; 8ed7

; ----------------------------------------------------------------------
; DATOS tira_8EDA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[1], p00:4760, p01:6910 y p01:6985
;   por 0x87CE[1], p00:4760, p01:6910 y p01:6985 por 0x8A6E[1] (3 bytes)
;   0x8eda..0x8edd  (3 bytes)
DATA_tira_8EDA:
	defb 0f0h,0ech,0ffh	; 8eda

; ----------------------------------------------------------------------
; DATOS tira_8EDD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[2], p00:4760, p01:6910 y p01:6985
;   por 0x87CE[2], p00:4760, p01:6910 y p01:6985 por 0x8A6E[2] (5 bytes)
;   0x8edd..0x8ee2  (5 bytes)
DATA_tira_8EDD:
	defb 010h,0edh,09ah,0a7h,0ffh	; 8edd

; ----------------------------------------------------------------------
; DATOS tira_8EE2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[3], p00:4760, p01:6910 y p01:6985
;   por 0x87CE[3], p00:4760, p01:6910 y p01:6985 por 0x8A6E[3] (5 bytes)
;   0x8ee2..0x8ee7  (5 bytes)
DATA_tira_8EE2:
	defb 010h,0edh,0a5h,0a6h,0ffh	; 8ee2

; ----------------------------------------------------------------------
; DATOS tira_8EE7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[4] (5 bytes)
;   0x8ee7..0x8eec  (5 bytes)
DATA_tira_8EE7:
	defb 031h,0edh,09ch,0a4h,0ffh	; 8ee7

; ----------------------------------------------------------------------
; DATOS tira_8EEC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[5] (10 bytes)
;   0x8eec..0x8ef6  (10 bytes)
DATA_tira_8EEC:
	defb 031h,0edh,09eh,09dh,0feh,051h,0edh,09fh,08dh,0ffh	; 8eec  1....Q....

; ----------------------------------------------------------------------
; DATOS tira_8EF6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[6] (6 bytes)
;   0x8ef6..0x8efc  (6 bytes)
DATA_tira_8EF6:
	defb 051h,0edh,0a2h,0a1h,0a0h,0ffh	; 8ef6

; ----------------------------------------------------------------------
; DATOS tira_8EFC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[7] (5 bytes)
;   0x8efc..0x8f01  (5 bytes)
DATA_tira_8EFC:
	defb 072h,0edh,096h,0a3h,0ffh	; 8efc

; ----------------------------------------------------------------------
; DATOS tira_8F01: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[8] (6 bytes)
;   0x8f01..0x8f07  (6 bytes)
DATA_tira_8F01:
	defb 092h,0edh,072h,05ah,06bh,0ffh	; 8f01

; ----------------------------------------------------------------------
; DATOS tira_8F07: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[9] (7 bytes)
;   0x8f07..0x8f0e  (7 bytes)
DATA_tira_8F07:
	defb 0b2h,0edh,068h,05ah,05ah,06fh,0ffh	; 8f07

; ----------------------------------------------------------------------
; DATOS tira_8F0E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[10] (12 bytes)
;   0x8f0e..0x8f1a  (12 bytes)
DATA_tira_8F0E:
	defb 0b3h,0edh,05ch,073h,073h,0feh,0d3h,0edh,069h,069h,070h,0ffh	; 8f0e  ..\ss...iip.

; ----------------------------------------------------------------------
; DATOS tira_8F1A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[11] (13 bytes)
;   0x8f1a..0x8f27  (13 bytes)
DATA_tira_8F1A:
	defb 0d4h,0edh,06ch,073h,073h,0feh,0f3h,0edh,068h,069h,070h,070h,0ffh	; 8f1a  ..lss...hipp.

; ----------------------------------------------------------------------
; DATOS tira_8F27: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[12] (15 bytes)
;   0x8f27..0x8f36  (15 bytes)
DATA_tira_8F27:
	defb 0f4h,0edh,05ch,074h,06dh,073h,0feh,014h,0eeh,072h,069h,070h,070h,05bh,0ffh	; 8f27  ..\tms...ripp[.

; ----------------------------------------------------------------------
; DATOS tira_8F36: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[13] (17 bytes)
;   0x8f36..0x8f47  (17 bytes)
DATA_tira_8F36:
	defb 034h,0eeh,05ch,073h,074h,06dh,073h,0feh,054h,0eeh,072h,069h,069h,070h,070h,06bh	; 8f36  4.\stms.T.riippk
	defb 0ffh	; 8f46

; ----------------------------------------------------------------------
; DATOS tira_8F47: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[14] (3 bytes)
;   0x8f47..0x8f4a  (3 bytes)
DATA_tira_8F47:
	defb 055h,0eeh,0ffh	; 8f47

; ----------------------------------------------------------------------
; DATOS tira_8F4A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x878E[15] (3 bytes)
;   0x8f4a..0x8f4d  (3 bytes)
DATA_tira_8F4A:
	defb 076h,0eeh,0ffh	; 8f4a

; ----------------------------------------------------------------------
; DATOS tira_8F4D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[4], p00:4760, p01:6910 y p01:6985
;   por 0x8A4E[4] (5 bytes)
;   0x8f4d..0x8f52  (5 bytes)
DATA_tira_8F4D:
	defb 02dh,0edh,097h,08fh,0ffh	; 8f4d

; ----------------------------------------------------------------------
; DATOS tira_8F52: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[5], p00:4760, p01:6910 y p01:6985
;   por 0x8A4E[5] (10 bytes)
;   0x8f52..0x8f5c  (10 bytes)
DATA_tira_8F52:
	defb 02dh,0edh,090h,091h,0feh,04dh,0edh,08dh,092h,0ffh	; 8f52  -....M....

; ----------------------------------------------------------------------
; DATOS tira_8F5C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[6], p00:4760, p01:6910 y p01:6985
;   por 0x8A4E[6] (6 bytes)
;   0x8f5c..0x8f62  (6 bytes)
DATA_tira_8F5C:
	defb 04ch,0edh,093h,094h,095h,0ffh	; 8f5c

; ----------------------------------------------------------------------
; DATOS tira_8F62: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[7], p00:4760, p01:6910 y p01:6985
;   por 0x8A4E[7] (5 bytes)
;   0x8f62..0x8f67  (5 bytes)
DATA_tira_8F62:
	defb 06ch,0edh,096h,0a3h,0ffh	; 8f62

; ----------------------------------------------------------------------
; DATOS tira_8F67: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[8], p00:4760, p01:6910 y p01:6985
;   por 0x8A4E[8] (12 bytes)
;   0x8f67..0x8f73  (12 bytes)
DATA_tira_8F67:
	defb 06bh,0edh,09bh,08eh,0a8h,0feh,08bh,0edh,072h,05ah,06bh,0ffh	; 8f67  k.......rZk.

; ----------------------------------------------------------------------
; DATOS tira_8F73: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[9], p00:4760, p01:6910 y p01:6985
;   por 0x8A4E[9] (12 bytes)
;   0x8f73..0x8f7f  (12 bytes)
DATA_tira_8F73:
	defb 08bh,0edh,06eh,075h,0feh,0aah,0edh,068h,063h,063h,06fh,0ffh	; 8f73  ..nu...hcco.

; ----------------------------------------------------------------------
; DATOS tira_8F7F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[10], p00:4760, p01:6910 y
;   p01:6985 por 0x8A4E[10] (19 bytes)
;   0x8f7f..0x8f92  (19 bytes)
DATA_tira_8F7F:
	defb 08ah,0edh,05fh,05dh,05eh,0feh,0a9h,0edh,061h,062h,057h,058h,0feh,0cah,0edh,069h	; 8f7f  .._]^...abWX...i
	defb 06ah,070h,0ffh	; 8f8f

; ----------------------------------------------------------------------
; DATOS tira_8F92: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[11], p00:4760, p01:6910 y
;   p01:6985 por 0x8A4E[11] (20 bytes)
;   0x8f92..0x8fa6  (20 bytes)
DATA_tira_8F92:
	defb 0a9h,0edh,065h,064h,075h,0feh,0c8h,0edh,061h,062h,057h,057h,0feh,0e9h,0edh,069h	; 8f92  ..edu...abWW...i
	defb 06ah,071h,06bh,0ffh	; 8fa2

; ----------------------------------------------------------------------
; DATOS tira_8FA6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[12], p00:4760, p01:6910 y
;   p01:6985 por 0x8A4E[12] (30 bytes)
;   0x8fa6..0x8fc4  (30 bytes)
DATA_tira_8FA6:
	defb 0a8h,0edh,05fh,05dh,05dh,05eh,0feh,0c8h,0edh,059h,057h,057h,058h,0feh,0e7h,0edh	; 8fa6  .._]]^...YWWX...
	defb 061h,062h,057h,057h,058h,0feh,008h,0eeh,069h,06ah,071h,070h,05bh,0ffh	; 8fb6  abWWX...ijqp[.

; ----------------------------------------------------------------------
; DATOS tira_8FC4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[13], p00:4760, p01:6910 y
;   p01:6985 por 0x8A4E[13] (38 bytes)
;   0x8fc4..0x8fea  (38 bytes)
DATA_tira_8FC4:
	defb 0c7h,0edh,06eh,064h,064h,075h,0feh,0e7h,0edh,057h,057h,057h,057h,0feh,007h,0eeh	; 8fc4  ..nddu...WWWW...
	defb 057h,057h,057h,057h,0feh,026h,0eeh,060h,057h,057h,057h,057h,0feh,046h,0eeh,072h	; 8fd4  WWWW.&.`WWWW.F.r
	defb 06ah,06ah,071h,071h,06bh,0ffh	; 8fe4

; ----------------------------------------------------------------------
; DATOS tira_8FEA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[14] (18 bytes)
;   0x8fea..0x8ffc  (18 bytes)
DATA_tira_8FEA:
	defb 044h,0eeh,06eh,064h,064h,064h,064h,066h,0feh,064h,0eeh,057h,057h,057h,057h,057h	; 8fea  D.nddddf.d.WWWWW
	defb 058h,0ffh	; 8ffa

; ----------------------------------------------------------------------
; DATOS tira_8FFC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87AE[15] (10 bytes)
;   0x8ffc..0x9006  (10 bytes)
DATA_tira_8FFC:
	defb 061h,0eeh,065h,064h,064h,064h,064h,064h,075h,0ffh	; 8ffc  a.edddddu.

; ----------------------------------------------------------------------
; DATOS tira_9006: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[4], p00:4760, p01:6910 y p01:6985
;   por 0x8A6E[4] (5 bytes)
;   0x9006..0x900b  (5 bytes)
DATA_tira_9006:
	defb 031h,0edh,09ch,0a4h,0ffh	; 9006

; ----------------------------------------------------------------------
; DATOS tira_900B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[5], p00:4760, p01:6910 y p01:6985
;   por 0x8A6E[5] (10 bytes)
;   0x900b..0x9015  (10 bytes)
DATA_tira_900B:
	defb 031h,0edh,09eh,09dh,0feh,051h,0edh,09fh,08dh,0ffh	; 900b  1....Q....

; ----------------------------------------------------------------------
; DATOS tira_9015: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[6], p00:4760, p01:6910 y p01:6985
;   por 0x8A6E[6] (6 bytes)
;   0x9015..0x901b  (6 bytes)
DATA_tira_9015:
	defb 051h,0edh,0a2h,0a1h,0a0h,0ffh	; 9015

; ----------------------------------------------------------------------
; DATOS tira_901B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[7], p00:4760, p01:6910 y p01:6985
;   por 0x8A6E[7] (5 bytes)
;   0x901b..0x9020  (5 bytes)
DATA_tira_901B:
	defb 072h,0edh,096h,0a3h,0ffh	; 901b

; ----------------------------------------------------------------------
; DATOS tira_9020: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[8], p00:4760, p01:6910 y p01:6985
;   por 0x8A6E[8] (12 bytes)
;   0x9020..0x902c  (12 bytes)
DATA_tira_9020:
	defb 072h,0edh,09bh,08eh,0a8h,0feh,092h,0edh,072h,05ah,06bh,0ffh	; 9020  r.......rZk.

; ----------------------------------------------------------------------
; DATOS tira_902C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[9], p00:4760, p01:6910 y p01:6985
;   por 0x8A6E[9] (12 bytes)
;   0x902c..0x9038  (12 bytes)
DATA_tira_902C:
	defb 093h,0edh,06eh,075h,0feh,0b2h,0edh,068h,063h,063h,06fh,0ffh	; 902c  ..nu...hcco.

; ----------------------------------------------------------------------
; DATOS tira_9038: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[10], p00:4760, p01:6910 y
;   p01:6985 por 0x8A6E[10] (19 bytes)
;   0x9038..0x904b  (19 bytes)
DATA_tira_9038:
	defb 093h,0edh,05fh,05dh,05eh,0feh,0b2h,0edh,061h,062h,057h,058h,0feh,0d3h,0edh,069h	; 9038  .._]^...abWX...i
	defb 06ah,070h,0ffh	; 9048

; ----------------------------------------------------------------------
; DATOS tira_904B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[11], p00:4760, p01:6910 y
;   p01:6985 por 0x8A6E[11] (20 bytes)
;   0x904b..0x905f  (20 bytes)
DATA_tira_904B:
	defb 0b4h,0edh,06eh,064h,066h,0feh,0d3h,0edh,060h,057h,057h,058h,0feh,0f3h,0edh,068h	; 904b  ..ndf...`WWX...h
	defb 06ah,071h,070h,0ffh	; 905b

; ----------------------------------------------------------------------
; DATOS tira_905F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[12], p00:4760, p01:6910 y
;   p01:6985 por 0x8A6E[12] (30 bytes)
;   0x905f..0x907d  (30 bytes)
DATA_tira_905F:
	defb 0b4h,0edh,05fh,05dh,05dh,05eh,0feh,0d4h,0edh,059h,057h,057h,058h,0feh,0f3h,0edh	; 905f  .._]]^...YWWX...
	defb 061h,062h,057h,057h,058h,0feh,014h,0eeh,072h,071h,071h,070h,05bh,0ffh	; 906f  abWWX...rqqp[.

; ----------------------------------------------------------------------
; DATOS tira_907D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[13], p00:4760, p01:6910 y
;   p01:6985 por 0x8A6E[13] (38 bytes)
;   0x907d..0x90a3  (38 bytes)
DATA_tira_907D:
	defb 0d5h,0edh,06eh,064h,064h,075h,0feh,0f5h,0edh,057h,057h,057h,057h,0feh,015h,0eeh	; 907d  ..nddu...WWWW...
	defb 057h,057h,057h,057h,0feh,034h,0eeh,060h,057h,057h,057h,057h,0feh,054h,0eeh,072h	; 908d  WWWW.4.`WWWW.T.r
	defb 06ah,06ah,071h,071h,06bh,0ffh	; 909d

; ----------------------------------------------------------------------
; DATOS tira_90A3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[14] (18 bytes)
;   0x90a3..0x90b5  (18 bytes)
DATA_tira_90A3:
	defb 056h,0eeh,065h,064h,064h,064h,064h,075h,0feh,076h,0eeh,059h,057h,057h,057h,057h	; 90a3  V.eddddu.v.YWWWW
	defb 057h,0ffh	; 90b3

; ----------------------------------------------------------------------
; DATOS tira_90B5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87CE[15] (10 bytes)
;   0x90b5..0x90bf  (10 bytes)
DATA_tira_90B5:
	defb 078h,0eeh,06eh,064h,064h,064h,064h,064h,066h,0ffh	; 90b5  x.ndddddf.

; ----------------------------------------------------------------------
; DATOS tira_90BF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[0] (3 bytes)
;   0x90bf..0x90c2  (3 bytes)
DATA_tira_90BF:
	defb 0efh,0ech,0ffh	; 90bf

; ----------------------------------------------------------------------
; DATOS tira_90C2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[1] (3 bytes)
;   0x90c2..0x90c5  (3 bytes)
DATA_tira_90C2:
	defb 0eeh,0ech,0ffh	; 90c2

; ----------------------------------------------------------------------
; DATOS tira_90C5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[2] (3 bytes)
;   0x90c5..0x90c8  (3 bytes)
DATA_tira_90C5:
	defb 0eeh,0ech,0ffh	; 90c5

; ----------------------------------------------------------------------
; DATOS tira_90C8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[3] (5 bytes)
;   0x90c8..0x90cd  (5 bytes)
DATA_tira_90C8:
	defb 0eeh,0ech,0bah,0b9h,0ffh	; 90c8

; ----------------------------------------------------------------------
; DATOS tira_90CD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[4] (6 bytes)
;   0x90cd..0x90d3  (6 bytes)
DATA_tira_90CD:
	defb 00dh,0edh,0beh,0adh,0b5h,0ffh	; 90cd

; ----------------------------------------------------------------------
; DATOS tira_90D3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[5] (7 bytes)
;   0x90d3..0x90da  (7 bytes)
DATA_tira_90D3:
	defb 02ch,0edh,0b2h,0afh,0afh,0bdh,0ffh	; 90d3

; ----------------------------------------------------------------------
; DATOS tira_90DA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[6] (8 bytes)
;   0x90da..0x90e2  (8 bytes)
DATA_tira_90DA:
	defb 04bh,0edh,0b2h,0afh,0afh,0bbh,0bch,0ffh	; 90da  K.......

; ----------------------------------------------------------------------
; DATOS tira_90E2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[7] (8 bytes)
;   0x90e2..0x90ea  (8 bytes)
DATA_tira_90E2:
	defb 06ah,0edh,0b2h,0b0h,0b0h,0b0h,0c1h,0ffh	; 90e2  j.......

; ----------------------------------------------------------------------
; DATOS tira_90EA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[8] (9 bytes)
;   0x90ea..0x90f3  (9 bytes)
DATA_tira_90EA:
	defb 089h,0edh,07dh,078h,078h,078h,078h,08bh,0ffh	; 90ea  ..}xxxx..

; ----------------------------------------------------------------------
; DATOS tira_90F3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[9] (20 bytes)
;   0x90f3..0x9107  (20 bytes)
DATA_tira_90F3:
	defb 0a7h,0edh,07eh,079h,079h,079h,079h,079h,091h,0feh,0c7h,0edh,088h,076h,076h,076h	; 90f3  ..~yyyyy.....vvv
	defb 076h,076h,09bh,0ffh	; 9103

; ----------------------------------------------------------------------
; DATOS tira_9107: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[10] (22 bytes)
;   0x9107..0x911d  (22 bytes)
DATA_tira_9107:
	defb 0c6h,0edh,07eh,079h,077h,07ah,077h,07ah,079h,07fh,0feh,0e6h,0edh,088h,076h,07bh	; 9107  ..~ywzwzy.....v{
	defb 08eh,07bh,08eh,076h,080h,0ffh	; 9117

; ----------------------------------------------------------------------
; DATOS tira_911D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[11] (22 bytes)
;   0x911d..0x9133  (22 bytes)
DATA_tira_911D:
	defb 0e5h,0edh,07eh,079h,077h,07ah,077h,07ah,079h,091h,0feh,005h,0eeh,089h,076h,07bh	; 911d  ..~ywzwzy.....v{
	defb 08eh,07bh,08eh,076h,09bh,0ffh	; 912d

; ----------------------------------------------------------------------
; DATOS tira_9133: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[12] (24 bytes)
;   0x9133..0x914b  (24 bytes)
DATA_tira_9133:
	defb 003h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,091h,0feh,023h,0eeh,088h,076h	; 9133  ..~ywzwzwz..#..v
	defb 07bh,08eh,07bh,08eh,07bh,08eh,09ch,0ffh	; 9143  {.{.{...

; ----------------------------------------------------------------------
; DATOS tira_914B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[13] (26 bytes)
;   0x914b..0x9165  (26 bytes)
DATA_tira_914B:
	defb 022h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,079h,091h,0feh,042h,0eeh,088h	; 914b  ".~ywzwzwzy..B..
	defb 076h,07bh,08eh,07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 915b  v{.{.{.v..

; ----------------------------------------------------------------------
; DATOS tira_9165: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[14] (30 bytes)
;   0x9165..0x9183  (30 bytes)
DATA_tira_9165:
	defb 040h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,081h,082h,0feh,060h	; 9165  @.~ywzwzwzwz...`
	defb 0eeh,088h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08ah,083h,0ffh	; 9175  ..{.{.{.{.{...

; ----------------------------------------------------------------------
; DATOS tira_9183: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x87EE[15] (14 bytes)
;   0x9183..0x9191  (14 bytes)
DATA_tira_9183:
	defb 060h,0eeh,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,081h,082h,0ffh	; 9183  `.wzwzwzwzw...

; ----------------------------------------------------------------------
; DATOS tira_9191: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[0] (3 bytes)
;   0x9191..0x9194  (3 bytes)
DATA_tira_9191:
	defb 0efh,0ech,0ffh	; 9191

; ----------------------------------------------------------------------
; DATOS tira_9194: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[1] (3 bytes)
;   0x9194..0x9197  (3 bytes)
DATA_tira_9194:
	defb 0eeh,0ech,0ffh	; 9194

; ----------------------------------------------------------------------
; DATOS tira_9197: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[2] (3 bytes)
;   0x9197..0x919a  (3 bytes)
DATA_tira_9197:
	defb 0eeh,0ech,0ffh	; 9197

; ----------------------------------------------------------------------
; DATOS tira_919A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[3] (5 bytes)
;   0x919a..0x919f  (5 bytes)
DATA_tira_919A:
	defb 0f0h,0ech,0c4h,0c5h,0ffh	; 919a

; ----------------------------------------------------------------------
; DATOS tira_919F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[4] (6 bytes)
;   0x919f..0x91a5  (6 bytes)
DATA_tira_919F:
	defb 010h,0edh,0c0h,0adh,0b3h,0ffh	; 919f

; ----------------------------------------------------------------------
; DATOS tira_91A5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[5] (7 bytes)
;   0x91a5..0x91ac  (7 bytes)
DATA_tira_91A5:
	defb 030h,0edh,0b2h,0afh,0afh,0bdh,0ffh	; 91a5

; ----------------------------------------------------------------------
; DATOS tira_91AC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[6] (8 bytes)
;   0x91ac..0x91b4  (8 bytes)
DATA_tira_91AC:
	defb 050h,0edh,0b1h,0c6h,0afh,0afh,0bdh,0ffh	; 91ac  P.......

; ----------------------------------------------------------------------
; DATOS tira_91B4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[7] (8 bytes)
;   0x91b4..0x91bc  (8 bytes)
DATA_tira_91B4:
	defb 071h,0edh,0b6h,0b0h,0b0h,0b0h,0bdh,0ffh	; 91b4  q.......

; ----------------------------------------------------------------------
; DATOS tira_91BC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[8] (9 bytes)
;   0x91bc..0x91c5  (9 bytes)
DATA_tira_91BC:
	defb 091h,0edh,09eh,078h,078h,078h,078h,090h,0ffh	; 91bc  ...xxxx..

; ----------------------------------------------------------------------
; DATOS tira_91C5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[9] (20 bytes)
;   0x91c5..0x91d9  (20 bytes)
DATA_tira_91C5:
	defb 0b2h,0edh,07eh,079h,079h,079h,079h,079h,091h,0feh,0d2h,0edh,088h,076h,076h,076h	; 91c5  ..~yyyyy.....vvv
	defb 076h,076h,09bh,0ffh	; 91d5

; ----------------------------------------------------------------------
; DATOS tira_91D9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[10] (22 bytes)
;   0x91d9..0x91ef  (22 bytes)
DATA_tira_91D9:
	defb 0d2h,0edh,07eh,079h,077h,07ah,077h,07ah,079h,091h,0feh,0f2h,0edh,088h,076h,07bh	; 91d9  ..~ywzwzy.....v{
	defb 08eh,07bh,08eh,076h,09bh,0ffh	; 91e9

; ----------------------------------------------------------------------
; DATOS tira_91EF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[11] (22 bytes)
;   0x91ef..0x9205  (22 bytes)
DATA_tira_91EF:
	defb 0f3h,0edh,07eh,079h,077h,07ah,077h,07ah,079h,091h,0feh,013h,0eeh,089h,076h,07bh	; 91ef  ..~ywzwzy.....v{
	defb 08eh,07bh,08eh,076h,09ch,0ffh	; 91ff

; ----------------------------------------------------------------------
; DATOS tira_9205: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[12] (24 bytes)
;   0x9205..0x921d  (24 bytes)
DATA_tira_9205:
	defb 014h,0eeh,07eh,077h,07ah,077h,07ah,077h,07ah,079h,091h,0feh,034h,0eeh,089h,07bh	; 9205  ..~wzwzwzy..4..{
	defb 08eh,07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 9215  .{.{.v..

; ----------------------------------------------------------------------
; DATOS tira_921D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[13] (26 bytes)
;   0x921d..0x9237  (26 bytes)
DATA_tira_921D:
	defb 034h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,079h,091h,0feh,054h,0eeh,088h	; 921d  4.~ywzwzwzy..T..
	defb 076h,08eh,07bh,08eh,07bh,08eh,07bh,076h,09bh,0ffh	; 922d  v.{.{.{v..

; ----------------------------------------------------------------------
; DATOS tira_9237: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[14] (30 bytes)
;   0x9237..0x9255  (30 bytes)
DATA_tira_9237:
	defb 054h,0eeh,095h,094h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,079h,091h,0feh,074h	; 9237  T...wzwzwzwzy..t
	defb 0eeh,096h,09dh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,09bh,0ffh	; 9247  ....{.{.{.{...

; ----------------------------------------------------------------------
; DATOS tira_9255: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x880E[15] (14 bytes)
;   0x9255..0x9263  (14 bytes)
DATA_tira_9255:
	defb 075h,0eeh,095h,094h,077h,07ah,07ah,077h,07ah,077h,07ah,077h,07ah,0ffh	; 9255  u...wzzwzwzwz.

; ----------------------------------------------------------------------
; DATOS tira_9263: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[0] (4 bytes)
;   0x9263..0x9267  (4 bytes)
DATA_tira_9263:
	defb 0efh,0ech,0abh,0ffh	; 9263

; ----------------------------------------------------------------------
; DATOS tira_9267: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[1] (4 bytes)
;   0x9267..0x926b  (4 bytes)
DATA_tira_9267:
	defb 0efh,0ech,0ach,0ffh	; 9267

; ----------------------------------------------------------------------
; DATOS tira_926B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[2] (6 bytes)
;   0x926b..0x9271  (6 bytes)
DATA_tira_926B:
	defb 0eeh,0ech,0beh,0adh,0b4h,0ffh	; 926b

; ----------------------------------------------------------------------
; DATOS tira_9271: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[3] (6 bytes)
;   0x9271..0x9277  (6 bytes)
DATA_tira_9271:
	defb 0eeh,0ech,0c4h,0aeh,0c5h,0ffh	; 9271

; ----------------------------------------------------------------------
; DATOS tira_9277: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[4] (7 bytes)
;   0x9277..0x927e  (7 bytes)
DATA_tira_9277:
	defb 00dh,0edh,0beh,0adh,0adh,0b3h,0ffh	; 9277

; ----------------------------------------------------------------------
; DATOS tira_927E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[5] (8 bytes)
;   0x927e..0x9286  (8 bytes)
DATA_tira_927E:
	defb 02ch,0edh,0b2h,0afh,0afh,0afh,0c2h,0ffh	; 927e  ,.......

; ----------------------------------------------------------------------
; DATOS tira_9286: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[6] (9 bytes)
;   0x9286..0x928f  (9 bytes)
DATA_tira_9286:
	defb 04bh,0edh,0b2h,0afh,0afh,0afh,0afh,0b8h,0ffh	; 9286  K........

; ----------------------------------------------------------------------
; DATOS tira_928F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[7] (11 bytes)
;   0x928f..0x929a  (11 bytes)
DATA_tira_928F:
	defb 06ah,0edh,0b2h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bdh,0ffh	; 928f  j..........

; ----------------------------------------------------------------------
; DATOS tira_929A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[8] (12 bytes)
;   0x929a..0x92a6  (12 bytes)
DATA_tira_929A:
	defb 089h,0edh,07dh,078h,078h,078h,078h,078h,078h,078h,090h,0ffh	; 929a  ..}xxxxxxx..

; ----------------------------------------------------------------------
; DATOS tira_92A6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[9] (26 bytes)
;   0x92a6..0x92c0  (26 bytes)
DATA_tira_92A6:
	defb 0a8h,0edh,07eh,079h,079h,079h,079h,079h,079h,079h,079h,091h,0feh,0c8h,0edh,088h	; 92a6  ..~yyyyyyyy.....
	defb 076h,076h,076h,076h,076h,076h,076h,076h,09bh,0ffh	; 92b6  vvvvvvvv..

; ----------------------------------------------------------------------
; DATOS tira_92C0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[10] (30 bytes)
;   0x92c0..0x92de  (30 bytes)
DATA_tira_92C0:
	defb 0c7h,0edh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,079h,091h,0feh,0e7h	; 92c0  ..~ywzwzwzwzy...
	defb 0edh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 92d0  ..v{.{.{.{.v..

; ----------------------------------------------------------------------
; DATOS tira_92DE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[11] (33 bytes)
;   0x92de..0x92ff  (33 bytes)
DATA_tira_92DE:
	defb 0e6h,0edh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,084h,085h	; 92de  ..~ywzwzwzwzwz..
	defb 0feh,006h,0eeh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,086h	; 92ee  ....v{.{.{.{.{..
	defb 0ffh	; 92fe

; ----------------------------------------------------------------------
; DATOS tira_92FF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[12] (36 bytes)
;   0x92ff..0x9323  (36 bytes)
DATA_tira_92FF:
	defb 005h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,079h,08dh	; 92ff  ..~ywzwzwzwzwzy.
	defb 087h,0feh,025h,0eeh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh	; 930f  ..%..v{.{.{.{.{.
	defb 076h,09fh,07ch,0ffh	; 931f

; ----------------------------------------------------------------------
; DATOS tira_9323: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[13] (39 bytes)
;   0x9323..0x934a  (39 bytes)
DATA_tira_9323:
	defb 024h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah	; 9323  $.~ywzwzwzwzwzwz
	defb 079h,084h,085h,0feh,044h,0eeh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh	; 9333  y...D..v{.{.{.{.
	defb 07bh,08eh,07bh,08eh,076h,086h,0ffh	; 9343

; ----------------------------------------------------------------------
; DATOS tira_934A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[14] (42 bytes)
;   0x934a..0x9374  (42 bytes)
DATA_tira_934A:
	defb 043h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah	; 934a  C.~ywzwzwzwzwzwz
	defb 077h,07ah,079h,091h,0feh,063h,0eeh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh	; 935a  wzy..c..v{.{.{.{
	defb 08eh,07bh,08eh,07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 936a  .{.{.{.v..

; ----------------------------------------------------------------------
; DATOS tira_9374: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x882E[15] (23 bytes)
;   0x9374..0x938b  (23 bytes)
DATA_tira_9374:
	defb 062h,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah	; 9374  b.~ywzwzwzwzwzwz
	defb 077h,07ah,077h,07ah,079h,091h,0ffh	; 9384

; ----------------------------------------------------------------------
; DATOS tira_938B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[0] (4 bytes)
;   0x938b..0x938f  (4 bytes)
DATA_tira_938B:
	defb 0f0h,0ech,0abh,0ffh	; 938b

; ----------------------------------------------------------------------
; DATOS tira_938F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[1] (4 bytes)
;   0x938f..0x9393  (4 bytes)
DATA_tira_938F:
	defb 0f0h,0ech,0ach,0ffh	; 938f

; ----------------------------------------------------------------------
; DATOS tira_9393: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[2] (6 bytes)
;   0x9393..0x9399  (6 bytes)
DATA_tira_9393:
	defb 0efh,0ech,0beh,0adh,0b3h,0ffh	; 9393

; ----------------------------------------------------------------------
; DATOS tira_9399: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[3] (6 bytes)
;   0x9399..0x939f  (6 bytes)
DATA_tira_9399:
	defb 0efh,0ech,0bah,0aeh,0b9h,0ffh	; 9399

; ----------------------------------------------------------------------
; DATOS tira_939F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[4] (7 bytes)
;   0x939f..0x93a6  (7 bytes)
DATA_tira_939F:
	defb 00fh,0edh,0beh,0adh,0adh,0b3h,0ffh	; 939f

; ----------------------------------------------------------------------
; DATOS tira_93A6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[5] (8 bytes)
;   0x93a6..0x93ae  (8 bytes)
DATA_tira_93A6:
	defb 02fh,0edh,0b7h,0afh,0afh,0afh,0bdh,0ffh	; 93a6  /.......

; ----------------------------------------------------------------------
; DATOS tira_93AE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[6] (9 bytes)
;   0x93ae..0x93b7  (9 bytes)
DATA_tira_93AE:
	defb 04fh,0edh,0b2h,0afh,0afh,0afh,0afh,0bdh,0ffh	; 93ae  O........

; ----------------------------------------------------------------------
; DATOS tira_93B7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[7] (11 bytes)
;   0x93b7..0x93c2  (11 bytes)
DATA_tira_93B7:
	defb 06eh,0edh,0b2h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bdh,0ffh	; 93b7  n..........

; ----------------------------------------------------------------------
; DATOS tira_93C2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[8] (12 bytes)
;   0x93c2..0x93ce  (12 bytes)
DATA_tira_93C2:
	defb 08eh,0edh,07dh,078h,078h,078h,078h,078h,078h,078h,090h,0ffh	; 93c2  ..}xxxxxxx..

; ----------------------------------------------------------------------
; DATOS tira_93CE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[9] (26 bytes)
;   0x93ce..0x93e8  (26 bytes)
DATA_tira_93CE:
	defb 0aeh,0edh,07eh,079h,079h,079h,079h,079h,079h,079h,079h,091h,0feh,0ceh,0edh,088h	; 93ce  ..~yyyyyyyy.....
	defb 076h,076h,076h,076h,076h,076h,076h,076h,09bh,0ffh	; 93de  vvvvvvvv..

; ----------------------------------------------------------------------
; DATOS tira_93E8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[10] (30 bytes)
;   0x93e8..0x9406  (30 bytes)
DATA_tira_93E8:
	defb 0cdh,0edh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,079h,091h,0feh,0edh	; 93e8  ..~ywzwzwzwzy...
	defb 0edh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 93f8  ..v{.{.{.{.v..

; ----------------------------------------------------------------------
; DATOS tira_9406: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[11] (33 bytes)
;   0x9406..0x9427  (33 bytes)
DATA_tira_9406:
	defb 0ech,0edh,098h,097h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,079h,091h	; 9406  ....wzwzwzwzwzy.
	defb 0feh,00dh,0eeh,099h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,076h,09bh	; 9416  ....{.{.{.{.{.v.
	defb 0ffh	; 9426

; ----------------------------------------------------------------------
; DATOS tira_9427: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[12] (36 bytes)
;   0x9427..0x944b  (36 bytes)
DATA_tira_9427:
	defb 00dh,0eeh,07eh,0a0h,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,079h	; 9427  ..~.ywzwzwzwzwzy
	defb 091h,0feh,02dh,0eeh,08fh,08ch,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh,07bh	; 9437  ..-...v{.{.{.{.{
	defb 08eh,076h,09bh,0ffh	; 9447

; ----------------------------------------------------------------------
; DATOS tira_944B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[13] (39 bytes)
;   0x944b..0x9472  (39 bytes)
DATA_tira_944B:
	defb 02bh,0eeh,098h,097h,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h	; 944b  +...ywzwzwzwzwzw
	defb 07ah,079h,091h,0feh,04ch,0eeh,099h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh,08eh	; 945b  zy..L..v{.{.{.{.
	defb 07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 946b

; ----------------------------------------------------------------------
; DATOS tira_9472: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[14] (42 bytes)
;   0x9472..0x949c  (42 bytes)
DATA_tira_9472:
	defb 04bh,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah	; 9472  K.~ywzwzwzwzwzwz
	defb 077h,07ah,079h,091h,0feh,06bh,0eeh,088h,076h,07bh,08eh,07bh,08eh,07bh,08eh,07bh	; 9482  wzy..k..v{.{.{.{
	defb 08eh,07bh,08eh,07bh,08eh,07bh,08eh,076h,09bh,0ffh	; 9492  .{.{.{.v..

; ----------------------------------------------------------------------
; DATOS tira_949C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x884E[15] (23 bytes)
;   0x949c..0x94b3  (23 bytes)
DATA_tira_949C:
	defb 06ah,0eeh,07eh,079h,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah,077h,07ah	; 949c  j.~ywzwzwzwzwzwz
	defb 077h,07ah,077h,07ah,079h,091h,0ffh	; 94ac

; ----------------------------------------------------------------------
; DATOS tira_94B3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[0] (5 bytes)
;   0x94b3..0x94b8  (5 bytes)
DATA_tira_94B3:
	defb 0efh,0ech,095h,097h,0ffh	; 94b3

; ----------------------------------------------------------------------
; DATOS tira_94B8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[1] (5 bytes)
;   0x94b8..0x94bd  (5 bytes)
DATA_tira_94B8:
	defb 0efh,0ech,09ah,09ch,0ffh	; 94b8

; ----------------------------------------------------------------------
; DATOS tira_94BD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[2] (5 bytes)
;   0x94bd..0x94c2  (5 bytes)
DATA_tira_94BD:
	defb 00fh,0edh,0a7h,0a8h,0ffh	; 94bd

; ----------------------------------------------------------------------
; DATOS tira_94C2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[3] (5 bytes)
;   0x94c2..0x94c7  (5 bytes)
DATA_tira_94C2:
	defb 00fh,0edh,0a9h,0aah,0ffh	; 94c2

; ----------------------------------------------------------------------
; DATOS tira_94C7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[4] (5 bytes)
;   0x94c7..0x94cc  (5 bytes)
DATA_tira_94C7:
	defb 02fh,0edh,0a5h,0a4h,0ffh	; 94c7

; ----------------------------------------------------------------------
; DATOS tira_94CC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[5] (14 bytes)
;   0x94cc..0x94da  (14 bytes)
DATA_tira_94CC:
	defb 02eh,0edh,08dh,0a2h,094h,09eh,0feh,04eh,0edh,08eh,08fh,08fh,092h,0ffh	; 94cc  .......N......

; ----------------------------------------------------------------------
; DATOS tira_94DA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[6] (7 bytes)
;   0x94da..0x94e1  (7 bytes)
DATA_tira_94DA:
	defb 04eh,0edh,0a3h,0a6h,0a4h,091h,0ffh	; 94da

; ----------------------------------------------------------------------
; DATOS tira_94E1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[7] (14 bytes)
;   0x94e1..0x94ef  (14 bytes)
DATA_tira_94E1:
	defb 04eh,0edh,08dh,0a2h,094h,09eh,0feh,06eh,0edh,090h,08fh,08fh,092h,0ffh	; 94e1  N......n......

; ----------------------------------------------------------------------
; DATOS tira_94EF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[8] (14 bytes)
;   0x94ef..0x94fd  (14 bytes)
DATA_tira_94EF:
	defb 06eh,0edh,09ah,0a2h,094h,09eh,0feh,08eh,0edh,05fh,060h,060h,066h,0ffh	; 94ef  n........_``f.

; ----------------------------------------------------------------------
; DATOS tira_94FD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[9] (25 bytes)
;   0x94fd..0x9516  (25 bytes)
DATA_tira_94FD:
	defb 08eh,0edh,05dh,061h,061h,05eh,0feh,0adh,0edh,057h,070h,071h,071h,06fh,068h,0feh	; 94fd  ..]aa^...Wpqqoh.
	defb 0cdh,0edh,058h,059h,05ah,05ah,062h,064h,0ffh	; 950d  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9516: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[10] (25 bytes)
;   0x9516..0x952f  (25 bytes)
DATA_tira_9516:
	defb 0aeh,0edh,05dh,067h,067h,05eh,0feh,0cdh,0edh,057h,06ah,072h,073h,06eh,068h,0feh	; 9516  ..]gg^...Wjrsnh.
	defb 0edh,0edh,058h,059h,05ah,05ah,062h,064h,0ffh	; 9526  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_952F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[11] (25 bytes)
;   0x952f..0x9548  (25 bytes)
DATA_tira_952F:
	defb 0ceh,0edh,05dh,067h,067h,05eh,0feh,0edh,0edh,057h,06ah,072h,073h,06eh,068h,0feh	; 952f  ..]gg^...Wjrsnh.
	defb 00dh,0eeh,058h,059h,05ah,05ah,062h,064h,0ffh	; 953f  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9548: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[12] (31 bytes)
;   0x9548..0x9567  (31 bytes)
DATA_tira_9548:
	defb 0edh,0edh,069h,063h,05bh,05bh,065h,05ch,0feh,00ch,0eeh,057h,06ah,06bh,06ch,06ch	; 9548  ..ic[[e\...Wjkll
	defb 06dh,06eh,068h,0feh,02ch,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 9558  mnh.,.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9567: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[13] (31 bytes)
;   0x9567..0x9586  (31 bytes)
DATA_tira_9567:
	defb 00dh,0eeh,069h,063h,05bh,05bh,065h,05ch,0feh,02ch,0eeh,057h,06ah,06bh,06ch,06ch	; 9567  ..ic[[e\.,.Wjkll
	defb 06dh,06eh,068h,0feh,04ch,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 9577  mnh.L.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9586: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[14] (31 bytes)
;   0x9586..0x95a5  (31 bytes)
DATA_tira_9586:
	defb 02dh,0eeh,069h,063h,05bh,05bh,065h,05ch,0feh,04ch,0eeh,057h,06ah,06bh,06ch,06ch	; 9586  -.ic[[e\.L.Wjkll
	defb 06dh,06eh,068h,0feh,06ch,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 9596  mnh.l.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_95A5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x886E[15] (24 bytes)
;   0x95a5..0x95bd  (24 bytes)
DATA_tira_95A5:
	defb 04ch,0eeh,069h,063h,05bh,05bh,05bh,05bh,065h,05ch,0feh,06bh,0eeh,057h,06ah,06bh	; 95a5  L.ic[[[[e\.k.Wjk
	defb 06ch,06ch,06ch,06ch,06dh,06eh,068h,0ffh	; 95b5  llllmnh.

; ----------------------------------------------------------------------
; DATOS tira_95BD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[0] (4 bytes)
;   0x95bd..0x95c1  (4 bytes)
DATA_tira_95BD:
	defb 0efh,0ech,099h,0ffh	; 95bd

; ----------------------------------------------------------------------
; DATOS tira_95C1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[1] (5 bytes)
;   0x95c1..0x95c6  (5 bytes)
DATA_tira_95C1:
	defb 0eeh,0ech,09ah,09ch,0ffh	; 95c1

; ----------------------------------------------------------------------
; DATOS tira_95C6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[2] (4 bytes)
;   0x95c6..0x95ca  (4 bytes)
DATA_tira_95C6:
	defb 00eh,0edh,09fh,0ffh	; 95c6

; ----------------------------------------------------------------------
; DATOS tira_95CA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[3] (5 bytes)
;   0x95ca..0x95cf  (5 bytes)
DATA_tira_95CA:
	defb 00dh,0edh,09ah,096h,0ffh	; 95ca

; ----------------------------------------------------------------------
; DATOS tira_95CF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[4] (5 bytes)
;   0x95cf..0x95d4  (5 bytes)
DATA_tira_95CF:
	defb 02dh,0edh,0a5h,0a4h,0ffh	; 95cf

; ----------------------------------------------------------------------
; DATOS tira_95D4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[5] (12 bytes)
;   0x95d4..0x95e0  (12 bytes)
DATA_tira_95D4:
	defb 02ch,0edh,08dh,0a2h,0a0h,0feh,04ch,0edh,08eh,08fh,093h,0ffh	; 95d4  ,.....L.....

; ----------------------------------------------------------------------
; DATOS tira_95E0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[6] (6 bytes)
;   0x95e0..0x95e6  (6 bytes)
DATA_tira_95E0:
	defb 04ch,0edh,0a5h,0a6h,091h,0ffh	; 95e0

; ----------------------------------------------------------------------
; DATOS tira_95E6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[7] (14 bytes)
;   0x95e6..0x95f4  (14 bytes)
DATA_tira_95E6:
	defb 04bh,0edh,09ah,0a2h,094h,09eh,0feh,06bh,0edh,090h,08fh,08fh,092h,0ffh	; 95e6  K......k......

; ----------------------------------------------------------------------
; DATOS tira_95F4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[8] (14 bytes)
;   0x95f4..0x9602  (14 bytes)
DATA_tira_95F4:
	defb 06ah,0edh,09ah,0a2h,094h,09eh,0feh,08ah,0edh,05fh,060h,060h,066h,0ffh	; 95f4  j........_``f.

; ----------------------------------------------------------------------
; DATOS tira_9602: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[9] (22 bytes)
;   0x9602..0x9618  (22 bytes)
DATA_tira_9602:
	defb 08ah,0edh,05dh,061h,05eh,0feh,0a9h,0edh,057h,070h,071h,06fh,068h,0feh,0c9h,0edh	; 9602  ..]a^...Wpqoh...
	defb 058h,059h,05ah,062h,064h,0ffh	; 9612

; ----------------------------------------------------------------------
; DATOS tira_9618: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[10] (25 bytes)
;   0x9618..0x9631  (25 bytes)
DATA_tira_9618:
	defb 0a9h,0edh,05dh,067h,067h,05eh,0feh,0c8h,0edh,057h,06ah,072h,073h,06eh,068h,0feh	; 9618  ..]gg^...Wjrsnh.
	defb 0e8h,0edh,058h,059h,05ah,05ah,062h,064h,0ffh	; 9628  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9631: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[11] (25 bytes)
;   0x9631..0x964a  (25 bytes)
DATA_tira_9631:
	defb 0c8h,0edh,05dh,067h,067h,05eh,0feh,0e7h,0edh,057h,06ah,072h,073h,06eh,068h,0feh	; 9631  ..]gg^...Wjrsnh.
	defb 007h,0eeh,058h,059h,05ah,05ah,062h,064h,0ffh	; 9641  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_964A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[12] (31 bytes)
;   0x964a..0x9669  (31 bytes)
DATA_tira_964A:
	defb 0e7h,0edh,069h,063h,05bh,05bh,065h,05ch,0feh,006h,0eeh,057h,06ah,06bh,06ch,06ch	; 964a  ..ic[[e\...Wjkll
	defb 06dh,06eh,068h,0feh,026h,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 965a  mnh.&.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9669: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[13] (31 bytes)
;   0x9669..0x9688  (31 bytes)
DATA_tira_9669:
	defb 006h,0eeh,069h,063h,05bh,05bh,065h,05ch,0feh,025h,0eeh,057h,06ah,06bh,06ch,06ch	; 9669  ..ic[[e\.%.Wjkll
	defb 06dh,06eh,068h,0feh,045h,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 9679  mnh.E.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9688: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[14] (31 bytes)
;   0x9688..0x96a7  (31 bytes)
DATA_tira_9688:
	defb 025h,0eeh,069h,063h,05bh,05bh,065h,05ch,0feh,044h,0eeh,057h,06ah,06bh,06ch,06ch	; 9688  %.ic[[e\.D.Wjkll
	defb 06dh,06eh,068h,0feh,064h,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 9698  mnh.d.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_96A7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x888E[15] (24 bytes)
;   0x96a7..0x96bf  (24 bytes)
DATA_tira_96A7:
	defb 044h,0eeh,069h,063h,05bh,05bh,05bh,05bh,065h,05ch,0feh,063h,0eeh,057h,06ah,06bh	; 96a7  D.ic[[[[e\.c.Wjk
	defb 06ch,06ch,06ch,06ch,06dh,06eh,068h,0ffh	; 96b7  llllmnh.

; ----------------------------------------------------------------------
; DATOS tira_96BF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[0] (4 bytes)
;   0x96bf..0x96c3  (4 bytes)
DATA_tira_96BF:
	defb 0f0h,0ech,099h,0ffh	; 96bf

; ----------------------------------------------------------------------
; DATOS tira_96C3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[1] (5 bytes)
;   0x96c3..0x96c8  (5 bytes)
DATA_tira_96C3:
	defb 0f0h,0ech,09ah,09ch,0ffh	; 96c3

; ----------------------------------------------------------------------
; DATOS tira_96C8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[2] (4 bytes)
;   0x96c8..0x96cc  (4 bytes)
DATA_tira_96C8:
	defb 011h,0edh,09fh,0ffh	; 96c8

; ----------------------------------------------------------------------
; DATOS tira_96CC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[3] (5 bytes)
;   0x96cc..0x96d1  (5 bytes)
DATA_tira_96CC:
	defb 011h,0edh,098h,09ch,0ffh	; 96cc

; ----------------------------------------------------------------------
; DATOS tira_96D1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[4] (5 bytes)
;   0x96d1..0x96d6  (5 bytes)
DATA_tira_96D1:
	defb 031h,0edh,0a5h,0a4h,0ffh	; 96d1

; ----------------------------------------------------------------------
; DATOS tira_96D6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[5] (12 bytes)
;   0x96d6..0x96e2  (12 bytes)
DATA_tira_96D6:
	defb 031h,0edh,08dh,0a2h,0a0h,0feh,051h,0edh,08eh,08fh,093h,0ffh	; 96d6  1.....Q.....

; ----------------------------------------------------------------------
; DATOS tira_96E2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[6] (6 bytes)
;   0x96e2..0x96e8  (6 bytes)
DATA_tira_96E2:
	defb 051h,0edh,0a3h,0a6h,0a1h,0ffh	; 96e2

; ----------------------------------------------------------------------
; DATOS tira_96E8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[7] (14 bytes)
;   0x96e8..0x96f6  (14 bytes)
DATA_tira_96E8:
	defb 051h,0edh,09ah,0a2h,094h,09eh,0feh,071h,0edh,090h,08fh,08fh,092h,0ffh	; 96e8  Q......q......

; ----------------------------------------------------------------------
; DATOS tira_96F6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[8] (14 bytes)
;   0x96f6..0x9704  (14 bytes)
DATA_tira_96F6:
	defb 072h,0edh,09ah,0a2h,094h,09eh,0feh,092h,0edh,05fh,060h,060h,066h,0ffh	; 96f6  r........_``f.

; ----------------------------------------------------------------------
; DATOS tira_9704: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[9] (22 bytes)
;   0x9704..0x971a  (22 bytes)
DATA_tira_9704:
	defb 093h,0edh,05dh,061h,05eh,0feh,0b2h,0edh,057h,070h,071h,06fh,068h,0feh,0d2h,0edh	; 9704  ..]a^...Wpqoh...
	defb 058h,059h,05ah,062h,064h,0ffh	; 9714

; ----------------------------------------------------------------------
; DATOS tira_971A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[10] (25 bytes)
;   0x971a..0x9733  (25 bytes)
DATA_tira_971A:
	defb 0b3h,0edh,05dh,067h,067h,05eh,0feh,0d2h,0edh,057h,06ah,072h,073h,06eh,068h,0feh	; 971a  ..]gg^...Wjrsnh.
	defb 0f2h,0edh,058h,059h,05ah,05ah,062h,064h,0ffh	; 972a  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_9733: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[11] (25 bytes)
;   0x9733..0x974c  (25 bytes)
DATA_tira_9733:
	defb 0d4h,0edh,05dh,067h,067h,05eh,0feh,0f3h,0edh,057h,06ah,072h,073h,06eh,068h,0feh	; 9733  ..]gg^...Wjrsnh.
	defb 013h,0eeh,058h,059h,05ah,05ah,062h,064h,0ffh	; 9743  ..XYZZbd.

; ----------------------------------------------------------------------
; DATOS tira_974C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[12] (31 bytes)
;   0x974c..0x976b  (31 bytes)
DATA_tira_974C:
	defb 0f4h,0edh,069h,063h,05bh,05bh,065h,05ch,0feh,013h,0eeh,057h,06ah,06bh,06ch,06ch	; 974c  ..ic[[e\...Wjkll
	defb 06dh,06eh,068h,0feh,033h,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 975c  mnh.3.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_976B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[13] (31 bytes)
;   0x976b..0x978a  (31 bytes)
DATA_tira_976B:
	defb 015h,0eeh,069h,063h,05bh,05bh,065h,05ch,0feh,034h,0eeh,057h,06ah,06bh,06ch,06ch	; 976b  ..ic[[e\.4.Wjkll
	defb 06dh,06eh,068h,0feh,054h,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 977b  mnh.T.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_978A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[14] (31 bytes)
;   0x978a..0x97a9  (31 bytes)
DATA_tira_978A:
	defb 035h,0eeh,069h,063h,05bh,05bh,065h,05ch,0feh,054h,0eeh,057h,06ah,06bh,06ch,06ch	; 978a  5.ic[[e\.T.Wjkll
	defb 06dh,06eh,068h,0feh,074h,0eeh,058h,059h,05ah,05ah,05ah,05ah,062h,064h,0ffh	; 979a  mnh.t.XYZZZZbd.

; ----------------------------------------------------------------------
; DATOS tira_97A9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88AE[15] (24 bytes)
;   0x97a9..0x97c1  (24 bytes)
DATA_tira_97A9:
	defb 055h,0eeh,069h,063h,05bh,05bh,05bh,05bh,065h,05ch,0feh,074h,0eeh,057h,06ah,06bh	; 97a9  U.ic[[[[e\.t.Wjk
	defb 06ch,06ch,06ch,06ch,06dh,06eh,068h,0ffh	; 97b9  llllmnh.

; ----------------------------------------------------------------------
; DATOS tira_97C1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[0], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[0] (4 bytes)
;   0x97c1..0x97c5  (4 bytes)
DATA_tira_97C1:
	defb 0efh,0ech,0b3h,0ffh	; 97c1

; ----------------------------------------------------------------------
; DATOS tira_97C5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[1], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[1] (6 bytes)
;   0x97c5..0x97cb  (6 bytes)
DATA_tira_97C5:
	defb 0eeh,0ech,0b5h,0ach,0bch,0ffh	; 97c5

; ----------------------------------------------------------------------
; DATOS tira_97CB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[2], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[2] (7 bytes)
;   0x97cb..0x97d2  (7 bytes)
DATA_tira_97CB:
	defb 00dh,0edh,0b4h,0abh,0abh,0b8h,0ffh	; 97cb

; ----------------------------------------------------------------------
; DATOS tira_97D2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[3], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[3] (8 bytes)
;   0x97d2..0x97da  (8 bytes)
DATA_tira_97D2:
	defb 00dh,0edh,0b7h,0ach,0ach,0ach,0bfh,0ffh	; 97d2  ........

; ----------------------------------------------------------------------
; DATOS tira_97DA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[4], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[4] (9 bytes)
;   0x97da..0x97e3  (9 bytes)
DATA_tira_97DA:
	defb 02ch,0edh,0b4h,0adh,0adh,0adh,0adh,0b9h,0ffh	; 97da  ,........

; ----------------------------------------------------------------------
; DATOS tira_97E3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[5], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[5] (10 bytes)
;   0x97e3..0x97ed  (10 bytes)
DATA_tira_97E3:
	defb 02bh,0edh,0b6h,0aeh,0b0h,0b0h,0b0h,0b0h,0bah,0ffh	; 97e3  +.........

; ----------------------------------------------------------------------
; DATOS tira_97ED: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[6], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[6] (11 bytes)
;   0x97ed..0x97f8  (11 bytes)
DATA_tira_97ED:
	defb 04bh,0edh,0bbh,0afh,0afh,0afh,0afh,0afh,0afh,0beh,0ffh	; 97ed  K..........

; ----------------------------------------------------------------------
; DATOS tira_97F8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[7], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[7] (12 bytes)
;   0x97f8..0x9804  (12 bytes)
DATA_tira_97F8:
	defb 04ah,0edh,0b6h,0b2h,0b2h,0b2h,0b2h,0b2h,0b2h,0b2h,0c0h,0ffh	; 97f8  J...........

; ----------------------------------------------------------------------
; DATOS tira_9804: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[8], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[8] (12 bytes)
;   0x9804..0x9810  (12 bytes)
DATA_tira_9804:
	defb 06ah,0edh,0b1h,0afh,0afh,0afh,0afh,0afh,0afh,0afh,0c5h,0ffh	; 9804  j...........

; ----------------------------------------------------------------------
; DATOS tira_9810: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[9], p00:4760, p01:6910 y p01:6985
;   por 0x8A8E[9] (15 bytes)
;   0x9810..0x981f  (15 bytes)
DATA_tira_9810:
	defb 088h,0edh,087h,08bh,07eh,07eh,07eh,07eh,07eh,07eh,083h,084h,091h,08dh,0ffh	; 9810  ....~~~~~~.....

; ----------------------------------------------------------------------
; DATOS tira_981F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[10], p00:4760, p01:6910 y
;   p01:6985 por 0x8A8E[10] (37 bytes)
;   0x981f..0x9844  (37 bytes)
DATA_tira_981F:
	defb 090h,0edh,078h,080h,0feh,0a7h,0edh,088h,089h,081h,07ch,081h,07ch,081h,07ch,081h	; 981f  ..x.......|.|.|.
	defb 07ch,081h,07ch,08fh,08eh,0feh,0c8h,0edh,076h,077h,076h,077h,076h,077h,076h,077h	; 982f  |.|.....vwvwvwvw
	defb 077h,076h,077h,076h,0ffh	; 983f

; ----------------------------------------------------------------------
; DATOS tira_9844: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[11], p00:4760, p01:6910 y
;   p01:6985 por 0x8A8E[11] (45 bytes)
;   0x9844..0x9871  (45 bytes)
DATA_tira_9844:
	defb 0b0h,0edh,078h,080h,0feh,0c5h,0edh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 9844  ..x......y{y{y{y
	defb 07bh,079h,079h,07ah,07bh,079h,090h,08eh,0feh,0e5h,0edh,086h,07dh,085h,07fh,085h	; 9854  {yyz{y......}...
	defb 07fh,085h,07fh,085h,07fh,085h,085h,07fh,085h,07fh,082h,08ch,0ffh	; 9864  .............

; ----------------------------------------------------------------------
; DATOS tira_9871: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[12], p00:4760, p01:6910 y
;   p01:6985 por 0x8A8E[12] (47 bytes)
;   0x9871..0x98a0  (47 bytes)
DATA_tira_9871:
	defb 0d0h,0edh,078h,080h,0feh,0e4h,0edh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 9871  ..x......y{y{y{y
	defb 07bh,079h,07bh,079h,07ah,07bh,079h,090h,08eh,0feh,004h,0eeh,086h,07dh,085h,07fh	; 9881  {y{yz{y......}..
	defb 085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,082h,08ch,0ffh	; 9891  ...............

; ----------------------------------------------------------------------
; DATOS tira_98A0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[13], p00:4760, p01:6910 y
;   p01:6985 por 0x8A8E[13] (51 bytes)
;   0x98a0..0x98d3  (51 bytes)
DATA_tira_98A0:
	defb 0f0h,0edh,078h,080h,0feh,003h,0eeh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 98a0  ..x......y{y{y{y
	defb 07bh,079h,07bh,079h,079h,07ah,07bh,079h,07bh,090h,08eh,0feh,023h,0eeh,086h,07dh	; 98b0  {y{yyz{y{...#..}
	defb 085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,085h,07fh,085h,07fh,085h	; 98c0  ................
	defb 082h,08ch,0ffh	; 98d0

; ----------------------------------------------------------------------
; DATOS tira_98D3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[14] (53 bytes)
;   0x98d3..0x9908  (53 bytes)
DATA_tira_98D3:
	defb 011h,0eeh,078h,080h,0feh,022h,0eeh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 98d3  ..x.."...y{y{y{y
	defb 07bh,079h,07bh,079h,07bh,07bh,079h,07ah,07bh,079h,090h,08eh,0feh,042h,0eeh,086h	; 98e3  {y{y{{yz{y...B..
	defb 07dh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h	; 98f3  }...............
	defb 07fh,085h,082h,08ch,0ffh	; 9903

; ----------------------------------------------------------------------
; DATOS tira_9908: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88CE[15] (57 bytes)
;   0x9908..0x9941  (57 bytes)
DATA_tira_9908:
	defb 031h,0eeh,078h,080h,0feh,041h,0eeh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 9908  1.x..A...y{y{y{y
	defb 07bh,079h,07bh,079h,07bh,079h,07bh,079h,07ah,07bh,079h,07bh,090h,08eh,0feh,061h	; 9918  {y{y{y{yz{y{...a
	defb 0eeh,086h,07dh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h	; 9928  ..}.............
	defb 085h,07fh,085h,07fh,085h,07fh,082h,08ch,0ffh	; 9938  .........

; ----------------------------------------------------------------------
; DATOS tira_9941: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[0], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[0] (4 bytes)
;   0x9941..0x9945  (4 bytes)
DATA_tira_9941:
	defb 0f0h,0ech,0bdh,0ffh	; 9941

; ----------------------------------------------------------------------
; DATOS tira_9945: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[1], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[1] (6 bytes)
;   0x9945..0x994b  (6 bytes)
DATA_tira_9945:
	defb 0efh,0ech,0c6h,0ach,0bfh,0ffh	; 9945

; ----------------------------------------------------------------------
; DATOS tira_994B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[2], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[2] (7 bytes)
;   0x994b..0x9952  (7 bytes)
DATA_tira_994B:
	defb 00fh,0edh,0c2h,0abh,0abh,0beh,0ffh	; 994b

; ----------------------------------------------------------------------
; DATOS tira_9952: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[3], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[3] (8 bytes)
;   0x9952..0x995a  (8 bytes)
DATA_tira_9952:
	defb 00eh,0edh,0b5h,0ach,0ach,0ach,0c1h,0ffh	; 9952  ........

; ----------------------------------------------------------------------
; DATOS tira_995A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[4], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[4] (9 bytes)
;   0x995a..0x9963  (9 bytes)
DATA_tira_995A:
	defb 02eh,0edh,0c3h,0adh,0adh,0adh,0adh,0beh,0ffh	; 995a  .........

; ----------------------------------------------------------------------
; DATOS tira_9963: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[5], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[5] (10 bytes)
;   0x9963..0x996d  (10 bytes)
DATA_tira_9963:
	defb 02eh,0edh,0c4h,0b0h,0b0h,0b0h,0b0h,0b0h,0c0h,0ffh	; 9963  ..........

; ----------------------------------------------------------------------
; DATOS tira_996D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[6], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[6] (11 bytes)
;   0x996d..0x9978  (11 bytes)
DATA_tira_996D:
	defb 04dh,0edh,0b4h,0afh,0afh,0afh,0afh,0afh,0afh,0c5h,0ffh	; 996d  M..........

; ----------------------------------------------------------------------
; DATOS tira_9978: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[7], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[7] (12 bytes)
;   0x9978..0x9984  (12 bytes)
DATA_tira_9978:
	defb 04dh,0edh,0b6h,0b2h,0b2h,0b2h,0b2h,0b2h,0b2h,0b2h,0c0h,0ffh	; 9978  M...........

; ----------------------------------------------------------------------
; DATOS tira_9984: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[8], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[8] (12 bytes)
;   0x9984..0x9990  (12 bytes)
DATA_tira_9984:
	defb 06dh,0edh,0b1h,0afh,0afh,0afh,0afh,0afh,0afh,0afh,0c5h,0ffh	; 9984  m...........

; ----------------------------------------------------------------------
; DATOS tira_9990: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[9], p00:4760, p01:6910 y p01:6985
;   por 0x8AAE[9] (15 bytes)
;   0x9990..0x999f  (15 bytes)
DATA_tira_9990:
	defb 08ch,0edh,087h,08bh,07eh,07eh,07eh,07eh,07eh,07eh,083h,084h,091h,08dh,0ffh	; 9990  ....~~~~~~.....

; ----------------------------------------------------------------------
; DATOS tira_999F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[10], p00:4760, p01:6910 y
;   p01:6985 por 0x8AAE[10] (37 bytes)
;   0x999f..0x99c4  (37 bytes)
DATA_tira_999F:
	defb 094h,0edh,078h,080h,0feh,0abh,0edh,088h,089h,081h,07ch,081h,07ch,081h,07ch,081h	; 999f  ..x.......|.|.|.
	defb 07ch,081h,07ch,08fh,08eh,0feh,0cch,0edh,076h,077h,076h,077h,076h,077h,076h,077h	; 99af  |.|.....vwvwvwvw
	defb 077h,076h,077h,076h,0ffh	; 99bf

; ----------------------------------------------------------------------
; DATOS tira_99C4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[11], p00:4760, p01:6910 y
;   p01:6985 por 0x8AAE[11] (45 bytes)
;   0x99c4..0x99f1  (45 bytes)
DATA_tira_99C4:
	defb 0b5h,0edh,078h,080h,0feh,0cah,0edh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 99c4  ..x......y{y{y{y
	defb 07bh,079h,079h,07ah,07bh,079h,090h,08eh,0feh,0eah,0edh,086h,07dh,085h,07fh,085h	; 99d4  {yyz{y......}...
	defb 07fh,085h,07fh,085h,07fh,085h,085h,07fh,085h,07fh,082h,08ch,0ffh	; 99e4  .............

; ----------------------------------------------------------------------
; DATOS tira_99F1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[12], p00:4760, p01:6910 y
;   p01:6985 por 0x8AAE[12] (47 bytes)
;   0x99f1..0x9a20  (47 bytes)
DATA_tira_99F1:
	defb 0d6h,0edh,078h,080h,0feh,0eah,0edh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 99f1  ..x......y{y{y{y
	defb 07bh,079h,07bh,079h,07ah,07bh,079h,090h,08eh,0feh,00ah,0eeh,086h,07dh,085h,07fh	; 9a01  {y{yz{y......}..
	defb 085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,082h,08ch,0ffh	; 9a11  ...............

; ----------------------------------------------------------------------
; DATOS tira_9A20: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[13], p00:4760, p01:6910 y
;   p01:6985 por 0x8AAE[13] (51 bytes)
;   0x9a20..0x9a53  (51 bytes)
DATA_tira_9A20:
	defb 0f6h,0edh,078h,080h,0feh,009h,0eeh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 9a20  ..x......y{y{y{y
	defb 07bh,079h,07bh,079h,079h,07ah,07bh,079h,07bh,090h,08eh,0feh,029h,0eeh,086h,07dh	; 9a30  {y{yyz{y{...)..}
	defb 085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,085h,07fh,085h,07fh,085h	; 9a40  ................
	defb 082h,08ch,0ffh	; 9a50

; ----------------------------------------------------------------------
; DATOS tira_9A53: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[14] (53 bytes)
;   0x9a53..0x9a88  (53 bytes)
DATA_tira_9A53:
	defb 018h,0eeh,078h,080h,0feh,029h,0eeh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 9a53  ..x..)...y{y{y{y
	defb 07bh,079h,07bh,079h,07bh,07bh,079h,07ah,07bh,079h,090h,08eh,0feh,049h,0eeh,086h	; 9a63  {y{y{{yz{y...I..
	defb 07dh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h	; 9a73  }...............
	defb 07fh,085h,082h,08ch,0ffh	; 9a83

; ----------------------------------------------------------------------
; DATOS tira_9A88: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x88EE[15] (57 bytes)
;   0x9a88..0x9ac1  (57 bytes)
DATA_tira_9A88:
	defb 038h,0eeh,078h,080h,0feh,048h,0eeh,088h,08ah,079h,07bh,079h,07bh,079h,07bh,079h	; 9a88  8.x..H...y{y{y{y
	defb 07bh,079h,07bh,079h,07bh,079h,07bh,079h,07ah,07bh,079h,07bh,090h,08eh,0feh,068h	; 9a98  {y{y{y{yz{y{...h
	defb 0eeh,086h,07dh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h,07fh,085h	; 9aa8  ..}.............
	defb 085h,07fh,085h,07fh,085h,07fh,082h,08ch,0ffh	; 9ab8  .........

; ----------------------------------------------------------------------
; DATOS tira_9AC1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[0] (3 bytes)
;   0x9ac1..0x9ac4  (3 bytes)
DATA_tira_9AC1:
	defb 0efh,0ech,0ffh	; 9ac1

; ----------------------------------------------------------------------
; DATOS tira_9AC4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[1] (3 bytes)
;   0x9ac4..0x9ac7  (3 bytes)
DATA_tira_9AC4:
	defb 0eeh,0ech,0ffh	; 9ac4

; ----------------------------------------------------------------------
; DATOS tira_9AC7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[2] (3 bytes)
;   0x9ac7..0x9aca  (3 bytes)
DATA_tira_9AC7:
	defb 0eeh,0ech,0ffh	; 9ac7

; ----------------------------------------------------------------------
; DATOS tira_9ACA: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[3] (4 bytes)
;   0x9aca..0x9ace  (4 bytes)
DATA_tira_9ACA:
	defb 0efh,0ech,0b6h,0ffh	; 9aca

; ----------------------------------------------------------------------
; DATOS tira_9ACE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[4] (4 bytes)
;   0x9ace..0x9ad2  (4 bytes)
DATA_tira_9ACE:
	defb 00eh,0edh,0b8h,0ffh	; 9ace

; ----------------------------------------------------------------------
; DATOS tira_9AD2: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[5] (4 bytes)
;   0x9ad2..0x9ad6  (4 bytes)
DATA_tira_9AD2:
	defb 00eh,0edh,0bah,0ffh	; 9ad2

; ----------------------------------------------------------------------
; DATOS tira_9AD6: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[6] (8 bytes)
;   0x9ad6..0x9ade  (8 bytes)
DATA_tira_9AD6:
	defb 00eh,0edh,0ach,0feh,02eh,0edh,0aeh,0ffh	; 9ad6  ........

; ----------------------------------------------------------------------
; DATOS tira_9ADE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[7] (5 bytes)
;   0x9ade..0x9ae3  (5 bytes)
DATA_tira_9ADE:
	defb 02dh,0edh,0b4h,0b5h,0ffh	; 9ade

; ----------------------------------------------------------------------
; DATOS tira_9AE3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[8] (9 bytes)
;   0x9ae3..0x9aec  (9 bytes)
DATA_tira_9AE3:
	defb 02dh,0edh,0b0h,0b1h,0feh,04dh,0edh,0b9h,0ffh	; 9ae3  -....M...

; ----------------------------------------------------------------------
; DATOS tira_9AEC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[9] (8 bytes)
;   0x9aec..0x9af4  (8 bytes)
DATA_tira_9AEC:
	defb 04dh,0edh,0abh,0feh,06dh,0edh,0adh,0ffh	; 9aec  M...m...

; ----------------------------------------------------------------------
; DATOS tira_9AF4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[10] (15 bytes)
;   0x9af4..0x9b03  (15 bytes)
DATA_tira_9AF4:
	defb 04ch,0edh,0afh,0b1h,0feh,06ch,0edh,0b2h,0b3h,0feh,08ch,0edh,07dh,07eh,0ffh	; 9af4  L....l......}~.

; ----------------------------------------------------------------------
; DATOS tira_9B03: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[11] (22 bytes)
;   0x9b03..0x9b19  (22 bytes)
DATA_tira_9B03:
	defb 06bh,0edh,0b7h,0c3h,0feh,08bh,0edh,07bh,089h,0feh,0aah,0edh,083h,07fh,08dh,091h	; 9b03  k......{........
	defb 0feh,0cbh,0edh,080h,08eh,0ffh	; 9b13

; ----------------------------------------------------------------------
; DATOS tira_9B19: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[12] (24 bytes)
;   0x9b19..0x9b31  (24 bytes)
DATA_tira_9B19:
	defb 08ah,0edh,079h,087h,0feh,0a9h,0edh,076h,07ah,088h,084h,0feh,0cah,0edh,07ch,08ah	; 9b19  ..y....vz.....|.
	defb 0feh,0e9h,0edh,082h,081h,08fh,090h,0ffh	; 9b29  ........

; ----------------------------------------------------------------------
; DATOS tira_9B31: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[13] (29 bytes)
;   0x9b31..0x9b4e  (29 bytes)
DATA_tira_9B31:
	defb 0a9h,0edh,077h,085h,0feh,0c9h,0edh,079h,087h,0feh,0e8h,0edh,076h,07ah,088h,084h	; 9b31  ..w....y....vz..
	defb 0feh,009h,0eeh,07ch,08ah,0feh,028h,0eeh,082h,081h,08fh,090h,0ffh	; 9b41  ...|..(......

; ----------------------------------------------------------------------
; DATOS tira_9B4E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[14] (31 bytes)
;   0x9b4e..0x9b6d  (31 bytes)
DATA_tira_9B4E:
	defb 0e7h,0edh,085h,077h,0feh,006h,0eeh,078h,087h,079h,086h,0feh,026h,0eeh,076h,07ah	; 9b4e  ...w...x.y..&.vz
	defb 088h,084h,0feh,047h,0eeh,07ch,08ah,0feh,066h,0eeh,082h,081h,08fh,090h,0ffh	; 9b5e  ...G.|..f......

; ----------------------------------------------------------------------
; DATOS tira_9B6D: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x890E[15] (12 bytes)
;   0x9b6d..0x9b79  (12 bytes)
DATA_tira_9B6D:
	defb 045h,0eeh,077h,085h,0feh,064h,0eeh,078h,079h,087h,086h,0ffh	; 9b6d  E.w..d.xy...

; ----------------------------------------------------------------------
; DATOS tira_9B79: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[0] (3 bytes)
;   0x9b79..0x9b7c  (3 bytes)
DATA_tira_9B79:
	defb 0efh,0ech,0ffh	; 9b79

; ----------------------------------------------------------------------
; DATOS tira_9B7C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[1] (3 bytes)
;   0x9b7c..0x9b7f  (3 bytes)
DATA_tira_9B7C:
	defb 0eeh,0ech,0ffh	; 9b7c

; ----------------------------------------------------------------------
; DATOS tira_9B7F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[2] (3 bytes)
;   0x9b7f..0x9b82  (3 bytes)
DATA_tira_9B7F:
	defb 0eeh,0ech,0ffh	; 9b7f

; ----------------------------------------------------------------------
; DATOS tira_9B82: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[3] (4 bytes)
;   0x9b82..0x9b86  (4 bytes)
DATA_tira_9B82:
	defb 0f0h,0ech,0c2h,0ffh	; 9b82

; ----------------------------------------------------------------------
; DATOS tira_9B86: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[4] (4 bytes)
;   0x9b86..0x9b8a  (4 bytes)
DATA_tira_9B86:
	defb 011h,0edh,0c4h,0ffh	; 9b86

; ----------------------------------------------------------------------
; DATOS tira_9B8A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[5] (4 bytes)
;   0x9b8a..0x9b8e  (4 bytes)
DATA_tira_9B8A:
	defb 011h,0edh,0c6h,0ffh	; 9b8a

; ----------------------------------------------------------------------
; DATOS tira_9B8E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[6] (8 bytes)
;   0x9b8e..0x9b96  (8 bytes)
DATA_tira_9B8E:
	defb 011h,0edh,0ach,0feh,031h,0edh,0aeh,0ffh	; 9b8e  ....1...

; ----------------------------------------------------------------------
; DATOS tira_9B96: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[7] (5 bytes)
;   0x9b96..0x9b9b  (5 bytes)
DATA_tira_9B96:
	defb 031h,0edh,0c1h,0c0h,0ffh	; 9b96

; ----------------------------------------------------------------------
; DATOS tira_9B9B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[8] (9 bytes)
;   0x9b9b..0x9ba4  (9 bytes)
DATA_tira_9B9B:
	defb 031h,0edh,0bdh,0bch,0feh,052h,0edh,0c5h,0ffh	; 9b9b  1....R...

; ----------------------------------------------------------------------
; DATOS tira_9BA4: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[9] (8 bytes)
;   0x9ba4..0x9bac  (8 bytes)
DATA_tira_9BA4:
	defb 052h,0edh,0abh,0feh,072h,0edh,0adh,0ffh	; 9ba4  R...r...

; ----------------------------------------------------------------------
; DATOS tira_9BAC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[10] (15 bytes)
;   0x9bac..0x9bbb  (15 bytes)
DATA_tira_9BAC:
	defb 052h,0edh,0bdh,0bbh,0feh,072h,0edh,0bfh,0beh,0feh,092h,0edh,08ch,08bh,0ffh	; 9bac  R....r.........

; ----------------------------------------------------------------------
; DATOS tira_9BBB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[11] (22 bytes)
;   0x9bbb..0x9bd1  (22 bytes)
DATA_tira_9BBB:
	defb 073h,0edh,0b7h,0c3h,0feh,093h,0edh,07bh,089h,0feh,0b2h,0edh,083h,07fh,08dh,091h	; 9bbb  s......{........
	defb 0feh,0d3h,0edh,080h,08eh,0ffh	; 9bcb

; ----------------------------------------------------------------------
; DATOS tira_9BD1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[12] (24 bytes)
;   0x9bd1..0x9be9  (24 bytes)
DATA_tira_9BD1:
	defb 094h,0edh,079h,087h,0feh,0b3h,0edh,076h,07ah,088h,084h,0feh,0d4h,0edh,07ch,08ah	; 9bd1  ..y....vz.....|.
	defb 0feh,0f3h,0edh,082h,081h,08fh,090h,0ffh	; 9be1  ........

; ----------------------------------------------------------------------
; DATOS tira_9BE9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[13] (29 bytes)
;   0x9be9..0x9c06  (29 bytes)
DATA_tira_9BE9:
	defb 0b5h,0edh,077h,085h,0feh,0d5h,0edh,079h,087h,0feh,0f4h,0edh,076h,07ah,088h,084h	; 9be9  ..w....y....vz..
	defb 0feh,015h,0eeh,07ch,08ah,0feh,034h,0eeh,082h,081h,08fh,090h,0ffh	; 9bf9  ...|..4......

; ----------------------------------------------------------------------
; DATOS tira_9C06: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[14] (31 bytes)
;   0x9c06..0x9c25  (31 bytes)
DATA_tira_9C06:
	defb 0f7h,0edh,085h,077h,0feh,016h,0eeh,078h,087h,079h,086h,0feh,036h,0eeh,076h,07ah	; 9c06  ...w...x.y..6.vz
	defb 088h,084h,0feh,057h,0eeh,07ch,08ah,0feh,076h,0eeh,082h,081h,08fh,090h,0ffh	; 9c16  ...W.|..v......

; ----------------------------------------------------------------------
; DATOS tira_9C25: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x892E[15] (12 bytes)
;   0x9c25..0x9c31  (12 bytes)
DATA_tira_9C25:
	defb 059h,0eeh,077h,085h,0feh,078h,0eeh,078h,079h,087h,086h,0ffh	; 9c25  Y.w..x.xy...

; ----------------------------------------------------------------------
; DATOS tira_9C31: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[0] (8 bytes)
;   0x9c31..0x9c39  (8 bytes)
DATA_tira_9C31:
	defb 06eh,0ech,040h,0feh,08eh,0ech,00dh,0ffh	; 9c31  n.@.....

; ----------------------------------------------------------------------
; DATOS tira_9C39: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[1] (8 bytes)
;   0x9c39..0x9c41  (8 bytes)
DATA_tira_9C39:
	defb 06eh,0ech,041h,0feh,08eh,0ech,00bh,0ffh	; 9c39  n.A.....

; ----------------------------------------------------------------------
; DATOS tira_9C41: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[2] (10 bytes)
;   0x9c41..0x9c4b  (10 bytes)
DATA_tira_9C41:
	defb 06dh,0ech,042h,043h,0feh,08dh,0ech,003h,015h,0ffh	; 9c41  m.BC......

; ----------------------------------------------------------------------
; DATOS tira_9C4B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[3] (10 bytes)
;   0x9c4b..0x9c55  (10 bytes)
DATA_tira_9C4B:
	defb 06dh,0ech,044h,045h,0feh,08dh,0ech,010h,014h,0ffh	; 9c4b  m.DE......

; ----------------------------------------------------------------------
; DATOS tira_9C55: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[4] (10 bytes)
;   0x9c55..0x9c5f  (10 bytes)
DATA_tira_9C55:
	defb 06dh,0ech,046h,047h,0feh,08dh,0ech,004h,004h,0ffh	; 9c55  m.FG......

; ----------------------------------------------------------------------
; DATOS tira_9C5F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[5] (16 bytes)
;   0x9c5f..0x9c6f  (16 bytes)
DATA_tira_9C5F:
	defb 04dh,0ech,0ach,0aeh,0feh,06ch,0ech,04ah,04bh,04ch,0feh,08dh,0ech,00eh,00eh,0ffh	; 9c5f  M....l.JKL......

; ----------------------------------------------------------------------
; DATOS tira_9C6F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[6] (18 bytes)
;   0x9c6f..0x9c81  (18 bytes)
DATA_tira_9C6F:
	defb 04ch,0ech,042h,04eh,04fh,0feh,06ch,0ech,050h,04bh,04ch,0feh,08ch,0ech,00ah,012h	; 9c6f  L.BNO.l.PKL.....
	defb 013h,0ffh	; 9c7f

; ----------------------------------------------------------------------
; DATOS tira_9C81: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[7] (19 bytes)
;   0x9c81..0x9c94  (19 bytes)
DATA_tira_9C81:
	defb 04ch,0ech,052h,053h,054h,0feh,06ch,0ech,055h,04bh,04ch,057h,0feh,08ch,0ech,006h	; 9c81  L.RST.l.UKLW....
	defb 012h,013h,0ffh	; 9c91

; ----------------------------------------------------------------------
; DATOS tira_9C94: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[8] (19 bytes)
;   0x9c94..0x9ca7  (19 bytes)
DATA_tira_9C94:
	defb 04ch,0ech,058h,059h,05ah,0feh,06ch,0ech,05bh,04bh,05ch,091h,0feh,08ch,0ech,006h	; 9c94  L.XYZ.l.[K\.....
	defb 012h,013h,0ffh	; 9ca4

; ----------------------------------------------------------------------
; DATOS tira_9CA7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[9] (26 bytes)
;   0x9ca7..0x9cc1  (26 bytes)
DATA_tira_9CA7:
	defb 02ch,0ech,0adh,0afh,0feh,04bh,0ech,05fh,04bh,008h,05ah,0feh,06bh,0ech,062h,063h	; 9ca7  ,....K._K.Z.k.bc
	defb 064h,008h,091h,0feh,08ch,0ech,007h,012h,013h,0ffh	; 9cb7  d.........

; ----------------------------------------------------------------------
; DATOS tira_9CC1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[10] (29 bytes)
;   0x9cc1..0x9cde  (29 bytes)
DATA_tira_9CC1:
	defb 02bh,0ech,042h,067h,068h,0feh,04bh,0ech,069h,04bh,008h,06ah,049h,0feh,06bh,0ech	; 9cc1  +.Bgh.K.iK.jI.k.
	defb 06bh,063h,064h,008h,091h,0feh,08bh,0ech,003h,011h,012h,013h,0ffh	; 9cd1  kcd..........

; ----------------------------------------------------------------------
; DATOS tira_9CDE: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[11] (30 bytes)
;   0x9cde..0x9cfc  (30 bytes)
DATA_tira_9CDE:
	defb 02bh,0ech,06eh,06fh,060h,0a5h,0feh,04bh,0ech,061h,04bh,072h,051h,049h,0feh,06bh	; 9cde  +.no`..K.aKrQI.k
	defb 0ech,061h,063h,064h,008h,091h,0feh,08bh,0ech,005h,011h,012h,013h,0ffh	; 9cee  .acd..........

; ----------------------------------------------------------------------
; DATOS tira_9CFC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[12] (30 bytes)
;   0x9cfc..0x9d1a  (30 bytes)
DATA_tira_9CFC:
	defb 02bh,0ech,071h,070h,060h,06dh,0feh,04bh,0ech,04dh,04bh,072h,051h,049h,0feh,06bh	; 9cfc  +.qp`m.K.MKrQI.k
	defb 0ech,04dh,063h,064h,008h,091h,0feh,08bh,0ech,005h,011h,012h,013h,0ffh	; 9d0c  .Mcd..........

; ----------------------------------------------------------------------
; DATOS tira_9D1A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[13] (37 bytes)
;   0x9d1a..0x9d3f  (37 bytes)
DATA_tira_9D1A:
	defb 00bh,0ech,042h,066h,0feh,02bh,0ech,065h,072h,06ah,056h,0feh,04ah,0ech,06ch,001h	; 9d1a  ..Bf.+.erjV.J.l.
	defb 04bh,072h,072h,049h,0feh,06ah,0ech,06ch,001h,063h,064h,008h,091h,0feh,08bh,0ech	; 9d2a  KrrI.j.l.cd.....
	defb 005h,011h,012h,013h,0ffh	; 9d3a

; ----------------------------------------------------------------------
; DATOS tira_9D3F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[14] (16 bytes)
;   0x9d3f..0x9d4f  (16 bytes)
DATA_tira_9D3F:
	defb 0e7h,0ebh,0a6h,001h,0a7h,059h,072h,0a8h,0feh,008h,0ech,0a9h,0aah,0abh,05eh,0ffh	; 9d3f  .....Yr.......^.

; ----------------------------------------------------------------------
; DATOS tira_9D4F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x894E[15] (8 bytes)
;   0x9d4f..0x9d57  (8 bytes)
DATA_tira_9D4F:
	defb 0e2h,0ebh,05dh,048h,0abh,081h,05eh,0ffh	; 9d4f  ..]H..^.

; ----------------------------------------------------------------------
; DATOS tira_9D57: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[0] (5 bytes)
;   0x9d57..0x9d5c  (5 bytes)
DATA_tira_9D57:
	defb 074h,0ech,073h,074h,0ffh	; 9d57

; ----------------------------------------------------------------------
; DATOS tira_9D5C: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[1] (5 bytes)
;   0x9d5c..0x9d61  (5 bytes)
DATA_tira_9D5C:
	defb 074h,0ech,075h,076h,0ffh	; 9d5c

; ----------------------------------------------------------------------
; DATOS tira_9D61: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[2] (5 bytes)
;   0x9d61..0x9d66  (5 bytes)
DATA_tira_9D61:
	defb 074h,0ech,077h,078h,0ffh	; 9d61

; ----------------------------------------------------------------------
; DATOS tira_9D66: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[3] (5 bytes)
;   0x9d66..0x9d6b  (5 bytes)
DATA_tira_9D66:
	defb 074h,0ech,079h,07ah,0ffh	; 9d66

; ----------------------------------------------------------------------
; DATOS tira_9D6B: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[4] (11 bytes)
;   0x9d6b..0x9d76  (11 bytes)
DATA_tira_9D6B:
	defb 054h,0ech,07bh,07ch,0feh,074h,0ech,07dh,07eh,07fh,0ffh	; 9d6b  T.{|.t.}~..

; ----------------------------------------------------------------------
; DATOS tira_9D76: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[5] (12 bytes)
;   0x9d76..0x9d82  (12 bytes)
DATA_tira_9D76:
	defb 054h,0ech,080h,04eh,082h,0feh,074h,0ech,088h,089h,08ah,0ffh	; 9d76  T..N..t.....

; ----------------------------------------------------------------------
; DATOS tira_9D82: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[6] (18 bytes)
;   0x9d82..0x9d94  (18 bytes)
DATA_tira_9D82:
	defb 054h,0ech,083h,084h,085h,0feh,074h,0ech,087h,04bh,086h,0feh,094h,0ech,0f6h,0fbh	; 9d82  T.....t..K......
	defb 0fbh,0ffh	; 9d92

; ----------------------------------------------------------------------
; DATOS tira_9D94: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[7] (19 bytes)
;   0x9d94..0x9da7  (19 bytes)
DATA_tira_9D94:
	defb 054h,0ech,08bh,059h,05ah,0feh,074h,0ech,08eh,08fh,064h,091h,0feh,094h,0ech,0f6h	; 9d94  T..YZ.t...d.....
	defb 0fbh,0fbh,0ffh	; 9da4

; ----------------------------------------------------------------------
; DATOS tira_9DA7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[8] (25 bytes)
;   0x9da7..0x9dc0  (25 bytes)
DATA_tira_9DA7:
	defb 035h,0ech,040h,0feh,054h,0ech,093h,04bh,094h,082h,0feh,074h,0ech,096h,063h,064h	; 9da7  5.@.T..K...t..cd
	defb 098h,0feh,094h,0ech,0f8h,009h,009h,0fch,0ffh	; 9db7  .........

; ----------------------------------------------------------------------
; DATOS tira_9DC0: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[9] (27 bytes)
;   0x9dc0..0x9ddb  (27 bytes)
DATA_tira_9DC0:
	defb 034h,0ech,07bh,09ah,04fh,0feh,054h,0ech,09ch,04bh,04ch,085h,0feh,074h,0ech,09dh	; 9dc0  4.{.O.T..KL..t..
	defb 063h,064h,090h,0feh,094h,0ech,00ch,009h,00eh,0fbh,0ffh	; 9dd0  cd.........

; ----------------------------------------------------------------------
; DATOS tira_9DDB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[10] (28 bytes)
;   0x9ddb..0x9df7  (28 bytes)
DATA_tira_9DDB:
	defb 034h,0ech,07bh,092h,054h,0feh,054h,0ech,095h,04bh,072h,097h,0feh,074h,0ech,099h	; 9ddb  4.{.T.T..Kr..t..
	defb 063h,064h,008h,057h,0feh,094h,0ech,00fh,011h,012h,013h,0ffh	; 9deb  cd.W........

; ----------------------------------------------------------------------
; DATOS tira_9DF7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[11] (30 bytes)
;   0x9df7..0x9e15  (30 bytes)
DATA_tira_9DF7:
	defb 034h,0ech,09bh,09fh,09eh,085h,0feh,054h,0ech,0a0h,04bh,008h,072h,0a1h,0feh,074h	; 9df7  4......T..K.r..t
	defb 0ech,0a0h,063h,064h,008h,098h,0feh,094h,0ech,0f7h,011h,012h,013h,0ffh	; 9e07  ..cd..........

; ----------------------------------------------------------------------
; DATOS tira_9E15: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[12] (30 bytes)
;   0x9e15..0x9e33  (30 bytes)
DATA_tira_9E15:
	defb 034h,0ech,042h,0a2h,0a3h,0a4h,0a5h,0feh,054h,0ech,08ch,04bh,008h,072h,08dh,0feh	; 9e15  4.B.....T..K.r..
	defb 074h,0ech,08ch,063h,064h,008h,086h,0feh,095h,0ech,007h,012h,013h,0ffh	; 9e25  t..cd.........

; ----------------------------------------------------------------------
; DATOS tira_9E33: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[13] (37 bytes)
;   0x9e33..0x9e58  (37 bytes)
DATA_tira_9E33:
	defb 015h,0ech,042h,066h,0feh,035h,0ech,065h,072h,06ah,056h,0feh,054h,0ech,06ch,001h	; 9e33  ..Bf.5.erjV.T.l.
	defb 04bh,072h,072h,049h,0feh,074h,0ech,06ch,001h,063h,064h,008h,091h,0feh,095h,0ech	; 9e43  KrrI.t.l.cd.....
	defb 005h,011h,012h,013h,0ffh	; 9e53

; ----------------------------------------------------------------------
; DATOS tira_9E58: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[14] (16 bytes)
;   0x9e58..0x9e68  (16 bytes)
DATA_tira_9E58:
	defb 0f6h,0ebh,0a6h,001h,0a7h,059h,072h,0a8h,0feh,017h,0ech,0a9h,0aah,0abh,05eh,0ffh	; 9e58  .....Yr.......^.

; ----------------------------------------------------------------------
; DATOS tira_9E68: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x896E[15] (8 bytes)
;   0x9e68..0x9e70  (8 bytes)
DATA_tira_9E68:
	defb 0f9h,0ebh,05dh,048h,0abh,081h,05eh,0ffh	; 9e68  ..]H..^.

; ----------------------------------------------------------------------
; DATOS tira_9E70: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[0] (10 bytes)
;   0x9e70..0x9e7a  (10 bytes)
DATA_tira_9E70:
	defb 0c7h,0ech,058h,0f9h,0feh,0e7h,0ech,09eh,09dh,0ffh	; 9e70  ..X.......

; ----------------------------------------------------------------------
; DATOS tira_9E7A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[1] (10 bytes)
;   0x9e7a..0x9e84  (10 bytes)
DATA_tira_9E7A:
	defb 0c7h,0ech,0f5h,0f9h,0feh,0e7h,0ech,0bbh,0bah,0ffh	; 9e7a  ..........

; ----------------------------------------------------------------------
; DATOS tira_9E84: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[2] (10 bytes)
;   0x9e84..0x9e8e  (10 bytes)
DATA_tira_9E84:
	defb 0c7h,0ech,0f4h,0f9h,0feh,0e7h,0ech,0b7h,0b9h,0ffh	; 9e84  ..........

; ----------------------------------------------------------------------
; DATOS tira_9E8E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[3] (11 bytes)
;   0x9e8e..0x9e99  (11 bytes)
DATA_tira_9E8E:
	defb 0c7h,0ech,033h,0b0h,0feh,0e6h,0ech,0b2h,0b1h,0b3h,0ffh	; 9e8e  ..3........

; ----------------------------------------------------------------------
; DATOS tira_9E99: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[4] (12 bytes)
;   0x9e99..0x9ea5  (12 bytes)
DATA_tira_9E99:
	defb 0c6h,0ech,0f5h,045h,0b0h,0feh,0e6h,0ech,0b5h,0b4h,0b6h,0ffh	; 9e99  ...E........

; ----------------------------------------------------------------------
; DATOS tira_9EA5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[5] (12 bytes)
;   0x9ea5..0x9eb1  (12 bytes)
DATA_tira_9EA5:
	defb 0c6h,0ech,0b8h,09ch,0b0h,0feh,0e6h,0ech,0aeh,0bch,0bdh,0ffh	; 9ea5  ............

; ----------------------------------------------------------------------
; DATOS tira_9EB1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[6] (18 bytes)
;   0x9eb1..0x9ec3  (18 bytes)
DATA_tira_9EB1:
	defb 0c6h,0ech,0ach,0abh,0b0h,0feh,0e6h,0ech,0adh,01bh,0aah,0feh,006h,0edh,0afh,0afh	; 9eb1  ................
	defb 049h,0ffh	; 9ec1

; ----------------------------------------------------------------------
; DATOS tira_9EC3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[7] (21 bytes)
;   0x9ec3..0x9ed8  (21 bytes)
DATA_tira_9EC3:
	defb 0c5h,0ech,0c1h,0c0h,0c2h,0b0h,0feh,0e5h,0ech,0c1h,01bh,024h,07ch,0feh,005h,0edh	; 9ec3  ...........$|...
	defb 0f7h,011h,012h,0c6h,0ffh	; 9ed3

; ----------------------------------------------------------------------
; DATOS tira_9ED8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[8] (21 bytes)
;   0x9ed8..0x9eed  (21 bytes)
DATA_tira_9ED8:
	defb 0c5h,0ech,0cah,0c9h,0c2h,0b0h,0feh,0e5h,0ech,0cch,01bh,024h,07ch,0feh,005h,0edh	; 9ed8  ...........$|...
	defb 00ah,0cbh,0cdh,0beh,0ffh	; 9ee8

; ----------------------------------------------------------------------
; DATOS tira_9EED: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[9] (21 bytes)
;   0x9eed..0x9f02  (21 bytes)
DATA_tira_9EED:
	defb 0c5h,0ech,07ah,037h,018h,084h,0feh,0e5h,0ech,07bh,01bh,002h,07ch,0feh,005h,0edh	; 9eed  ..z7.....{..|...
	defb 0a9h,07dh,07eh,07fh,0ffh	; 9efd

; ----------------------------------------------------------------------
; DATOS tira_9F02: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[10] (21 bytes)
;   0x9f02..0x9f17  (21 bytes)
DATA_tira_9F02:
	defb 0c5h,0ech,0c3h,0c4h,018h,0b0h,0feh,0e5h,0ech,0c5h,01bh,002h,01ch,0feh,005h,0edh	; 9f02  ................
	defb 01dh,0c7h,01fh,0c8h,0ffh	; 9f12

; ----------------------------------------------------------------------
; DATOS tira_9F17: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[11] (29 bytes)
;   0x9f17..0x9f34  (29 bytes)
DATA_tira_9F17:
	defb 0a5h,0ech,0f5h,0f9h,0feh,0c4h,0ech,055h,036h,037h,018h,0fah,0feh,0e4h,0ech,0bfh	; 9f17  .......U67......
	defb 01bh,002h,002h,09fh,0feh,004h,0edh,0bfh,0a2h,047h,0a0h,0a1h,0ffh	; 9f27  .........G...

; ----------------------------------------------------------------------
; DATOS tira_9F34: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[12] (37 bytes)
;   0x9f34..0x9f59  (37 bytes)
DATA_tira_9F34:
	defb 0a5h,0ech,067h,0fah,0feh,0c4h,0ech,0a4h,036h,037h,018h,0fah,0feh,0e4h,0ech,0a5h	; 9f34  ..g.....67......
	defb 01bh,002h,002h,0a3h,0feh,004h,0edh,0a6h,0a7h,047h,0a0h,0a1h,0feh,025h,0edh,0a8h	; 9f44  .........G...%..
	defb 0feh,027h,0edh,0a8h,0ffh	; 9f54

; ----------------------------------------------------------------------
; DATOS tira_9F59: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[13] (37 bytes)
;   0x9f59..0x9f7e  (37 bytes)
DATA_tira_9F59:
	defb 0a5h,0ech,033h,0feh,0c3h,0ech,0f5h,0e7h,036h,0dah,0eeh,0feh,0e3h,0ech,0e6h,001h	; 9f59  ..3.....6.......
	defb 01bh,0efh,0edh,070h,0feh,003h,0edh,0e6h,001h,0d8h,024h,0ebh,0ech,0feh,024h,0edh	; 9f69  ...p......$...$.
	defb 005h,0e8h,0e9h,0eah,0ffh	; 9f79

; ----------------------------------------------------------------------
; DATOS tira_9F7E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[14] (39 bytes)
;   0x9f7e..0x9fa5  (39 bytes)
DATA_tira_9F7E:
	defb 0c1h,0ech,0f5h,0e5h,0fah,0feh,0e0h,0ech,0d5h,0d9h,036h,0dah,0dbh,0feh,000h,0edh	; 9f7e  ..........6.....
	defb 0ceh,001h,01bh,002h,0deh,0cfh,0feh,020h,0edh,0ceh,001h,0d8h,024h,0ebh,0ddh,0feh	; 9f8e  ....... ....$...
	defb 041h,0edh,0d6h,0d0h,0dfh,0dch,0ffh	; 9f9e

; ----------------------------------------------------------------------
; DATOS tira_9FA5: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x898E[15] (20 bytes)
;   0x9fa5..0x9fb9  (20 bytes)
DATA_tira_9FA5:
	defb 0e0h,0ech,054h,0d1h,0feh,000h,0edh,0e0h,0e1h,0feh,020h,0edh,024h,0e4h,0feh,040h	; 9fa5  ..T....... .$..@
	defb 0edh,0d7h,0dch,0ffh	; 9fb5

; ----------------------------------------------------------------------
; DATOS tira_9FB9: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[0] (10 bytes)
;   0x9fb9..0x9fc3  (10 bytes)
DATA_tira_9FB9:
	defb 0efh,0ech,080h,081h,0feh,00fh,0edh,0f7h,0fch,0ffh	; 9fb9  ..........

; ----------------------------------------------------------------------
; DATOS tira_9FC3: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[1] (10 bytes)
;   0x9fc3..0x9fcd  (10 bytes)
DATA_tira_9FC3:
	defb 0efh,0ech,083h,084h,0feh,00fh,0edh,085h,086h,0ffh	; 9fc3  ..........

; ----------------------------------------------------------------------
; DATOS tira_9FCD: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[2] (10 bytes)
;   0x9fcd..0x9fd7  (10 bytes)
DATA_tira_9FCD:
	defb 0efh,0ech,0f4h,0f9h,0feh,00fh,0edh,08fh,090h,0ffh	; 9fcd  ..........

; ----------------------------------------------------------------------
; DATOS tira_9FD7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[3] (10 bytes)
;   0x9fd7..0x9fe1  (10 bytes)
DATA_tira_9FD7:
	defb 0efh,0ech,067h,0f9h,0feh,00fh,0edh,06ah,06bh,0ffh	; 9fd7  ..g....jk.

; ----------------------------------------------------------------------
; DATOS tira_9FE1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[4] (10 bytes)
;   0x9fe1..0x9feb  (10 bytes)
DATA_tira_9FE1:
	defb 0efh,0ech,067h,0f9h,0feh,00fh,0edh,068h,069h,0ffh	; 9fe1  ..g....hi.

; ----------------------------------------------------------------------
; DATOS tira_9FEB: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[5] (17 bytes)
;   0x9feb..0x9ffc  (17 bytes)
DATA_tira_9FEB:
	defb 0efh,0ech,067h,0fah,0feh,00eh,0edh,071h,01bh,054h,073h,0feh,02fh,0edh,072h,072h	; 9feb  ..g....q.Ts./.rr
	defb 0ffh	; 9ffb

; ----------------------------------------------------------------------
; DATOS tira_9FFC: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) (de
;   las ranuras de 0xE440) que lee rellena_de_unos y copia_bloques; lo cargan
;   p00:4760, p01:6910 y p01:6985 por 0x89AE[6]; sigue en el banco 11, en la
;   ranura de al lado (4 bytes)
;   0x9ffc..0xa000  (4 bytes)
DATA_tira_9FFC:
	defb 0eeh,0ech,06ch,06dh	; 9ffc
