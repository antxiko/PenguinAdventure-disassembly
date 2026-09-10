; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS sin identificar  0xa000..0xa019  (25 bytes)
DATA_A000:
	defb 004h,0cdh,0f5h,0a8h,03ah,0a2h,0e0h,0feh,003h,0d8h,03eh,004h,032h,083h,0eeh,032h	; a000  ....:.....>.2..2
	defb 087h,0eeh,032h,08bh,0eeh,032h,08fh,0eeh,0c9h	; a010  ..2..2...

; ======================================================================
; CODIGO 0xa019..0xa093  (122 bytes)
; ======================================================================


L_A019:
	call L_A083		;a019
	ld a,(0e003h)		;a01c   ; el contador de cuadros
	rra			;a01f
	ret c			;a020
	ld a,(0e204h)		;a021   ; la X en la pantalla de lo que se maneja
	add a,001h		;a024
	ld (0e204h),a		;a026   ; la X en la pantalla de lo que se maneja
	cp 0c0h		;a029
	jr c,L_A033		;a02b
	ld a,011h		;a02d
	ld (0e203h),a		;a02f   ; por donde va la rotacion de los sprites
	ret			;a032
L_A033:
	call L_A8DB		;a033
	ld a,004h		;a036
	jp L_A8F5		;a038
L_A03B:
	ld a,(0e003h)		;a03b   ; el contador de cuadros
	rra			;a03e
	ret c			;a03f
	ld a,(0e204h)		;a040   ; la X en la pantalla de lo que se maneja
	sub 001h		;a043
	ld (0e204h),a		;a045   ; la X en la pantalla de lo que se maneja
	cp 098h		;a048
	jr nc,L_A07B		;a04a
	ld a,004h		;a04c
	ld (0e203h),a		;a04e   ; por donde va la rotacion de los sprites
	ld a,020h		;a051
	ld (0e20eh),a		;a053
	ld a,0b4h		;a056
	ld l,a			;a058
	ld a,(0e205h)		;a059   ; la Y en la pantalla de lo que se maneja
	ld h,a			;a05c
	ld (0ee90h),hl		;a05d
	add a,010h		;a060
	ld h,a			;a062
	ld (0ee94h),hl		;a063
	ld l,04ch		;a066
	ld a,(0e0a1h)		;a068   ; el DECORADO, de 0 a 9
	cp 002h		;a06b
	ld c,00fh		;a06d
	jr c,L_A073		;a06f
	ld c,009h		;a071
L_A073:
	ld h,c			;a073
	ld (0ee92h),hl		;a074
	ld (0ee96h),hl		;a077
	ret			;a07a
L_A07B:
	call L_A8DB		;a07b
	ld a,004h		;a07e
	jp L_A8F5		;a080
L_A083:
	xor a			;a083
	ld (0e4c0h),a		;a084
	jp 05f77h		;a087
L_A08A:
	call L_A083		;a08a
	ld a,(0e21dh)		;a08d
	call 04060h		;a090   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa093..0xa099  (6 bytes)
DATA_A093:
	defb 099h,0a0h,0c2h,0a0h,06ah,0a1h	; a093

; ======================================================================
; CODIGO 0xa099..0xa183  (234 bytes)
; ======================================================================


L_A099:
	call L_A8DB		;a099
	ld a,00bh		;a09c
	call L_A8F5		;a09e
	ld a,(0e0a2h)		;a0a1   ; el modo en el que esta el juego
	dec a			;a0a4
	jr nz,L_A0B5		;a0a5
	ld a,004h		;a0a7
	ld (0ee83h),a		;a0a9
	ld (0ee87h),a		;a0ac
	ld (0ee8bh),a		;a0af
	ld (0ee8fh),a		;a0b2
L_A0B5:
	ld hl,0e21bh		;a0b5
	inc (hl)			;a0b8
	ld a,(hl)			;a0b9
	cp 020h		;a0ba
	ret nz			;a0bc
	ld hl,0e21dh		;a0bd
	inc (hl)			;a0c0
	ret			;a0c1
L_A0C2:
	ld hl,0e204h		;a0c2
	ld a,(0e0a2h)		;a0c5   ; el modo en el que esta el juego
	dec a			;a0c8
	jr nz,L_A0D3		;a0c9
	ld a,(hl)			;a0cb
	cp 0c0h		;a0cc
	jp nc,L_A15D		;a0ce
	jr L_A0D8		;a0d1
L_A0D3:
	ld a,(hl)			;a0d3
	cp 090h		;a0d4
	jr nc,L_A147		;a0d6
L_A0D8:
	inc (hl)			;a0d8
	inc (hl)			;a0d9
L_A0DA:
	ld hl,(0e204h)		;a0da   ; la X en la pantalla de lo que se maneja
	ld a,l			;a0dd
	add a,008h		;a0de
	ld l,a			;a0e0
	ld d,h			;a0e1
	ld a,003h		;a0e2
	add a,h			;a0e4
	ld h,a			;a0e5
	ld (0ee80h),hl		;a0e6   ; la tabla de atributos de los 32 sprites
	ld a,00ah		;a0e9
	add a,h			;a0eb
	ld h,a			;a0ec
	ld (0ee84h),hl		;a0ed
	ld a,003h		;a0f0
	add a,l			;a0f2
	ld l,a			;a0f3
	ld a,h			;a0f4
	sub 005h		;a0f5
	ld h,a			;a0f7
	ld (0ee88h),hl		;a0f8
	ld a,005h		;a0fb
	add a,l			;a0fd
	ld l,a			;a0fe
	ld (0ee8ch),hl		;a0ff
	ld a,008h		;a102
	add a,l			;a104
	ld l,a			;a105
	ld h,d			;a106
	ld (0ee90h),hl		;a107
	ld a,010h		;a10a
	add a,h			;a10c
	ld h,a			;a10d
	ld (0ee94h),hl		;a10e
	ld hl,0a183h		;a111
	ld de,0ee82h		;a114
	ldi		;a117
	ldi		;a119
	inc e			;a11b
	inc e			;a11c
	ldi		;a11d
	ldi		;a11f
	inc e			;a121
	inc e			;a122
	ldi		;a123
	ldi		;a125
	inc e			;a127
	inc e			;a128
	ldi		;a129
	ldi		;a12b
	inc e			;a12d
	inc e			;a12e
	ldi		;a12f
	ldi		;a131
	inc e			;a133
	inc e			;a134
	ldi		;a135
	ldi		;a137
	ld a,(0e0a2h)		;a139   ; el modo en el que esta el juego
	dec a			;a13c
	ret nz			;a13d
	ld a,004h		;a13e
	ld (0ee93h),a		;a140
	ld (0ee97h),a		;a143
	ret			;a146
L_A147:
	ld a,090h		;a147
	ld (0e204h),a		;a149   ; la X en la pantalla de lo que se maneja
	call L_A0DA		;a14c
	ld hl,0e21dh		;a14f
	inc (hl)			;a152
	ld hl,0e21bh		;a153
	ld (hl),080h		;a156
	ld a,08fh		;a158
	jp 0413ah		;a15a   ; banco 0: pide_sonido_si_esta_activo
L_A15D:
	ld a,0c0h		;a15d
	ld (0e204h),a		;a15f   ; la X en la pantalla de lo que se maneja
	call L_A0DA		;a162
	xor a			;a165
	ld (0e096h),a		;a166   ; los avisos que deja el cuadro
	ret			;a169
L_A16A:
	ld hl,0e21bh		;a16a
	dec (hl)			;a16d
	jr z,L_A17E		;a16e
	ld a,(hl)			;a170
	cp 040h		;a171
	ret nz			;a173
	ld a,(0e0e0h)		;a174
	and a			;a177
	ret z			;a178
	ld a,083h		;a179
	jp 0413ah		;a17b   ; banco 0: pide_sonido_si_esta_activo
L_A17E:
	xor a			;a17e
	ld (0e096h),a		;a17f   ; los avisos que deja el cuadro
	ret			;a182

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa183..0xa18f  (12 bytes)
DATA_A183:
	defb 0d0h,00ah,0d4h,00ah,0b8h,00ah,0bch,00eh,0d8h,001h,0dch,001h	; a183  ............

; ======================================================================
; CODIGO 0xa18f..0xa198  (9 bytes)
; ======================================================================


L_A18F:
	call L_A083		;a18f
	ld a,(0e21dh)		;a192
	call 04060h		;a195   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa198..0xa19e  (6 bytes)
DATA_A198:
	defb 09eh,0a1h,0bfh,0a1h,0eeh,0a1h	; a198

; ======================================================================
; CODIGO 0xa19e..0xa21b  (125 bytes)
; ======================================================================


L_A19E:
	call L_A8DB		;a19e
	ld a,00bh		;a1a1
	call L_A8F5		;a1a3
	ld hl,0e21bh		;a1a6
	inc (hl)			;a1a9
	ld a,(hl)			;a1aa
	cp 020h		;a1ab
	ret nz			;a1ad
	ld a,(0e0d3h)		;a1ae
	and a			;a1b1
	jr nz,L_A1B9		;a1b2
	ld hl,0e21dh		;a1b4
	inc (hl)			;a1b7
	ret			;a1b8
L_A1B9:
	ld hl,0e21dh		;a1b9
	inc (hl)			;a1bc
	inc (hl)			;a1bd
	ret			;a1be
L_A1BF:
	ld hl,0e204h		;a1bf
	ld a,(hl)			;a1c2
	cp 090h		;a1c3
	jr nc,L_A1D1		;a1c5
	inc (hl)			;a1c7
	inc (hl)			;a1c8
L_A1C9:
	call L_A8DB		;a1c9
	ld a,00bh		;a1cc
	jp L_A8F5		;a1ce
L_A1D1:
	cp 092h		;a1d1
	jr nc,L_A1DA		;a1d3
	ld a,090h		;a1d5
	ld (0e204h),a		;a1d7   ; la X en la pantalla de lo que se maneja
L_A1DA:
	call L_A1C9		;a1da
	call 07dd5h		;a1dd   ; banco 1
	ld hl,0e21dh		;a1e0
	inc (hl)			;a1e3
	ld hl,0e21bh		;a1e4
	ld (hl),080h		;a1e7
	ld a,02fh		;a1e9
	jp 0413ah		;a1eb   ; banco 0: pide_sonido_si_esta_activo
L_A1EE:
	ld hl,0e204h		;a1ee
	ld a,(hl)			;a1f1
	cp 0c0h		;a1f2
	jr nc,L_A1FF		;a1f4
	inc (hl)			;a1f6
L_A1F7:
	call L_A8DB		;a1f7
	ld a,00bh		;a1fa
	jp L_A8F5		;a1fc
L_A1FF:
	ld a,0c0h		;a1ff
	ld (0e204h),a		;a201   ; la X en la pantalla de lo que se maneja
	call L_A1F7		;a204
	ld hl,0e21bh		;a207
	dec (hl)			;a20a
	ret nz			;a20b
	xor a			;a20c
	ld (0e096h),a		;a20d   ; los avisos que deja el cuadro
	ret			;a210
L_A211:
	call L_A083		;a211
	ld a,(0e21eh)		;a214
	dec a			;a217
	call 04060h		;a218   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa21b..0xa227  (12 bytes)
DATA_A21B:
	defb 027h,0a2h,05ah,0a2h,07ah,0a2h,099h,0a2h,0cfh,0a2h,083h,0a3h	; a21b  '.Z.z.......

; ======================================================================
; CODIGO 0xa227..0xa39a  (371 bytes)
; ======================================================================


L_A227:
	ld hl,0e205h		;a227
	ld a,(hl)			;a22a
	cp 070h		;a22b
	jr z,L_A24B		;a22d
	jr nc,L_A234		;a22f
	inc (hl)			;a231
	jr L_A235		;a232
L_A234:
	dec (hl)			;a234
L_A235:
	call L_A8DB		;a235
	ld a,(0e003h)		;a238   ; el contador de cuadros
	rra			;a23b
	rra			;a23c
	rra			;a23d
	ld c,000h		;a23e
	jr nc,L_A247		;a240
	inc c			;a242
	rra			;a243
	jr c,L_A247		;a244
	inc c			;a246
L_A247:
	ld a,c			;a247
	jp L_A8F5		;a248
L_A24B:
	ld a,004h		;a24b
	ld (0e21eh),a		;a24d
	ld a,018h		;a250
	ld (0e21ch),a		;a252
	ld a,0b0h		;a255
	jp 0413ah		;a257   ; banco 0: pide_sonido_si_esta_activo
L_A25A:
	ld hl,0e205h		;a25a
	ld a,(hl)			;a25d
	cp 070h		;a25e
	jr z,L_A26B		;a260
	jr nc,L_A267		;a262
	inc (hl)			;a264
	jr L_A268		;a265
L_A267:
	dec (hl)			;a267
L_A268:
	jp 09a1dh		;a268   ; banco 2
L_A26B:
	ld a,004h		;a26b
	ld (0e21eh),a		;a26d
	ld a,018h		;a270
	ld (0e21ch),a		;a272
	ld a,0b0h		;a275
	jp 0413ah		;a277   ; banco 0: pide_sonido_si_esta_activo
L_A27A:
	ld hl,0e205h		;a27a
	ld a,(hl)			;a27d
	cp 070h		;a27e
	jr z,L_A28B		;a280
	jr nc,L_A287		;a282
	inc (hl)			;a284
	jr L_A288		;a285
L_A287:
	dec (hl)			;a287
L_A288:
	jp 09c3ah		;a288   ; banco 2
L_A28B:
	ld hl,0e21eh		;a28b
	inc (hl)			;a28e
	ld a,018h		;a28f
	ld (0e21ch),a		;a291
	ld a,0b0h		;a294
	jp 0413ah		;a296   ; banco 0: pide_sonido_si_esta_activo
L_A299:
	ld a,(0e21ch)		;a299
	rra			;a29c
	ld c,008h		;a29d
	jr nc,L_A2A3		;a29f
	ld c,010h		;a2a1
L_A2A3:
	ld hl,0e222h		;a2a3
	inc (hl)			;a2a6
	ld a,(hl)			;a2a7
	cp c			;a2a8
	ret nz			;a2a9
	ld (hl),000h		;a2aa
	ld hl,0e21ch		;a2ac
	dec (hl)			;a2af
	jr z,L_A2C5		;a2b0
	bit 0,(hl)		;a2b2
	ld hl,0a3c6h		;a2b4
	jr z,L_A2BC		;a2b7
	ld hl,0a3eah		;a2b9
L_A2BC:
	ld de,0ee80h		;a2bc
	ld bc,00024h		;a2bf
	ldir		;a2c2
	ret			;a2c4
L_A2C5:
	ld hl,0e21eh		;a2c5
	inc (hl)			;a2c8
	ld a,010h		;a2c9
	ld (0e21ch),a		;a2cb
	ret			;a2ce
L_A2CF:
	ld a,(0e003h)		;a2cf   ; el contador de cuadros
	and 00fh		;a2d2
	ret nz			;a2d4
	ld hl,0e21ch		;a2d5
	dec (hl)			;a2d8
	ld a,(hl)			;a2d9
	cp 00eh		;a2da
	ld hl,0a47ah		;a2dc
	jr z,L_A343		;a2df
	cp 00dh		;a2e1
	ld hl,0a492h		;a2e3
	jr z,L_A343		;a2e6
	cp 00ch		;a2e8
	ld hl,0a4aah		;a2ea
	jr z,L_A343		;a2ed
	cp 00bh		;a2ef
	ld hl,0a4c2h		;a2f1
	jr z,L_A343		;a2f4
	cp 00ah		;a2f6
	ld hl,0a4dah		;a2f8
	jr z,L_A343		;a2fb
	cp 009h		;a2fd
	ld hl,0a4f2h		;a2ff
	jr z,L_A343		;a302
	cp 008h		;a304
	ld hl,0a50ah		;a306
	jr z,L_A343		;a309
	cp 007h		;a30b
	ld hl,0a522h		;a30d
	jr z,L_A343		;a310
	cp 006h		;a312
	ld hl,0a53ah		;a314
	jr z,L_A32A		;a317
	and a			;a319
	ret nz			;a31a
	ld a,030h		;a31b
	call 0413ah		;a31d   ; banco 0: pide_sonido_si_esta_activo
	ld hl,0e21eh		;a320
	inc (hl)			;a323
	ld a,002h		;a324
	ld (0e21ch),a		;a326
	ret			;a329
L_A32A:
	ld a,(0e08bh)		;a32a   ; el largo de la fase
	and 00fh		;a32d
	cp 007h		;a32f
	ld c,0aah		;a331
	jr z,L_A33F		;a333
	cp 005h		;a335
	jr z,L_A33F		;a337
	cp 003h		;a339
	jr z,L_A33F		;a33b
	ld c,0a1h		;a33d
L_A33F:
	ld a,c			;a33f
	call 0413ah		;a340   ; banco 0: pide_sonido_si_esta_activo
L_A343:
	ld de,0eea4h		;a343
	ld bc,00018h		;a346
	ldir		;a349
	ld a,(0e08bh)		;a34b   ; el largo de la fase
	and 00fh		;a34e
	cp 007h		;a350
	jr z,L_A35C		;a352
	cp 005h		;a354
	jr z,L_A35C		;a356
	cp 003h		;a358
	jr nz,L_A36E		;a35a
L_A35C:
	ld a,(0e0e2h)		;a35c
	ld hl,0a39ah		;a35f
	call 04055h		;a362   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;a365
	ld (0eea7h),a		;a366
	inc hl			;a369
	ld a,(hl)			;a36a
	ld (0eeabh),a		;a36b
L_A36E:
	ld a,(0e0a1h)		;a36e   ; el DECORADO, de 0 a 9
	cp 002h		;a371
	ret nc			;a373
	ld a,00eh		;a374
	ld (0eeafh),a		;a376
	ld (0eeb3h),a		;a379
	ld (0eeb7h),a		;a37c
	ld (0eebbh),a		;a37f
	ret			;a382
L_A383:
	ld hl,0e21ch		;a383
	dec (hl)			;a386
	jr z,L_A395		;a387
	ld hl,0a3a2h		;a389
	ld de,0ee80h		;a38c
	ld bc,00024h		;a38f
	ldir		;a392
	ret			;a394
L_A395:
	xor a			;a395
	ld (0e096h),a		;a396   ; los avisos que deja el cuadro
	ret			;a399

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa39a..0xa5be  (548 bytes)
DATA_A39A:
	defb 005h,004h,006h,00ah,002h,00ch,009h,006h,087h,07fh,040h,00ah,0a0h,073h,050h,00ah	; a39a  ..........@..sP.
	defb 0a2h,085h,054h,00ah,085h,07dh,03ch,00fh,095h,079h,048h,00fh,081h,078h,034h,001h	; a3aa  ..T..}<..yH..x4.
	defb 081h,088h,038h,001h,091h,076h,044h,001h,091h,086h,04ch,001h,08dh,070h,060h,00ah	; a3ba  ..8..vD...L..p`.
	defb 0a3h,075h,070h,00ah,0e0h,000h,000h,000h,089h,06fh,058h,00fh,09bh,076h,068h,00fh	; a3ca  .up......oX..vh.
	defb 08dh,06ah,05ch,001h,08eh,07ah,064h,001h,09eh,07ah,06ch,001h,0e0h,000h,000h,000h	; a3da  .j\..zd..zl.....
	defb 08fh,070h,07ch,00ah,0a3h,075h,070h,00ah,0e0h,000h,000h,000h,08ah,06fh,074h,00fh	; a3ea  .p|..up......ot.
	defb 09bh,076h,080h,00fh,08fh,06ah,078h,001h,090h,07ah,084h,001h,0a0h,07ah,088h,001h	; a3fa  .v...jx..z...z..
	defb 0e0h,000h,000h,000h,0a1h,074h,098h,00ah,0bdh,077h,0b0h,00ah,0bch,08bh,0b4h,00ah	; a40a  .....t...w......
	defb 09ch,075h,094h,00fh,0ach,06ch,0a4h,00fh,0a4h,070h,09ch,004h,0a4h,080h,0a0h,004h	; a41a  .u...l...p......
	defb 0b4h,073h,0a8h,004h,0b4h,083h,0ach,004h,0a4h,078h,03ch,00ah,0bbh,074h,04ch,00ah	; a42a  .s.......x<..tL.
	defb 0bbh,07ch,050h,00ah,09eh,078h,038h,00fh,0b1h,078h,048h,00fh,09dh,078h,034h,001h	; a43a  .|P..x8..xH..x4.
	defb 0adh,070h,040h,001h,0adh,080h,044h,001h,0e0h,000h,000h,000h,081h,07fh,0a0h,00ah	; a44a  .p@...D.........
	defb 09ah,073h,0b0h,00ah,09ch,085h,0b4h,00ah,07fh,07dh,09ch,00fh,08fh,079h,0a8h,00fh	; a45a  .s.......}...y..
	defb 07bh,078h,094h,001h,07bh,088h,098h,001h,08bh,076h,0a4h,001h,08bh,086h,0ach,001h	; a46a  {x..{....v......
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,077h,088h,08ch,00fh,0e0h,000h,000h,00fh	; a47a  ........w.......
	defb 0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,008h,0e0h,000h,000h,008h	; a48a  ................
	defb 077h,088h,090h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a49a  w...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,076h,089h,094h,00fh,0e0h,000h,000h,00fh	; a4aa  ........v.......
	defb 0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,008h,0e0h,000h,000h,008h	; a4ba  ................
	defb 075h,08ah,098h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a4ca  u...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,070h,08fh,09ch,00fh,080h,08bh,0a0h,00fh	; a4da  ........p.......
	defb 0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,008h,0e0h,000h,000h,008h	; a4ea  ................
	defb 06bh,08eh,0a4h,00fh,06fh,09ch,0a8h,00fh,07bh,08ch,0ach,00fh,0e0h,000h,000h,00fh	; a4fa  k...o...{.......
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,067h,08fh,0b0h,00fh,06ah,09dh,0b4h,00fh	; a50a  ........g...j...
	defb 077h,08dh,0b8h,00fh,07ah,09dh,0bch,00fh,0e0h,000h,000h,008h,0e0h,000h,000h,008h	; a51a  w...z...........
	defb 062h,093h,0c0h,00fh,062h,0a3h,0c4h,00fh,072h,08eh,0c8h,00fh,072h,09eh,0cch,00fh	; a52a  b...b...r...r...
	defb 066h,098h,0d0h,008h,066h,098h,0d4h,00ah,062h,093h,0c0h,00fh,062h,0a3h,0c4h,00fh	; a53a  f...f...b...b...
	defb 072h,08eh,0c8h,00fh,072h,09eh,0cch,00fh,0a4h,078h,03ch,00ah,0bbh,074h,04ch,00ah	; a54a  r...r....x<..tL.
	defb 0bbh,07ch,050h,00ah,09eh,078h,038h,00fh,0b1h,078h,048h,00fh,09dh,078h,034h,004h	; a55a  .|P..x8..xH..x4.
	defb 0adh,070h,040h,004h,0adh,080h,044h,004h,0e0h,000h,000h,000h,0a0h,07dh,054h,00ah	; a56a  .p@...D......}T.
	defb 0bfh,07ah,06ch,00ah,0b3h,08ah,070h,00ah,0a2h,07ch,05ch,00fh,0b2h,07ah,068h,00fh	; a57a  .zl...p..|\..zh.
	defb 0a2h,076h,058h,004h,0a2h,086h,060h,004h,0b2h,076h,064h,004h,0e0h,000h,000h,000h	; a58a  .vX...`..vd.....
	defb 0a0h,073h,074h,00ah,0bfh,076h,08ch,00ah,0b3h,066h,090h,00ah,0a2h,074h,07ch,00fh	; a59a  .st..v...f...t|.
	defb 0b2h,076h,088h,00fh,0a2h,07ah,078h,004h,0a2h,06ah,080h,004h,0b2h,07ah,084h,004h	; a5aa  .v...zx..j...z..
	defb 0e0h,000h,000h,000h	; a5ba

; ======================================================================
; CODIGO 0xa5be..0xa5c8  (10 bytes)
; ======================================================================


L_A5BE:
	call L_A083		;a5be
	ld a,(0e21eh)		;a5c1
	dec a			;a5c4
	call 04060h		;a5c5   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa5c8..0xa5d0  (8 bytes)
DATA_A5C8:
	defb 0d0h,0a5h,033h,0a6h,069h,0a6h,0cbh,0a6h	; a5c8  ..3.i...

; ======================================================================
; CODIGO 0xa5d0..0xa623  (83 bytes)
; ======================================================================


L_A5D0:
	ld a,0e0h		;a5d0
	ld (0ee80h),a		;a5d2   ; la tabla de atributos de los 32 sprites
	ld (0ee84h),a		;a5d5
	ld (0ee88h),a		;a5d8
	ld (0ee8ch),a		;a5db
	ld hl,0e21ch		;a5de
	dec (hl)			;a5e1
	jr z,L_A60E		;a5e2
	ld a,(hl)			;a5e4
	and 00fh		;a5e5
	ret nz			;a5e7
	ld hl,0e0ddh		;a5e8
	inc (hl)			;a5eb
	ld a,(hl)			;a5ec
	push af			;a5ed
	dec a			;a5ee
	ld hl,0a623h		;a5ef
	call 04055h		;a5f2   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a5f5
	inc hl			;a5f6
	ld d,(hl)			;a5f7
	ld hl,0ae85h		;a5f8
	call 07d9ch		;a5fb   ; banco 1
	ld de,01000h		;a5fe
	call 09367h		;a601   ; banco 2
	pop af			;a604
	dec a			;a605
	and 003h		;a606
	ld c,033h		;a608
	add a,c			;a60a
	jp 0413ah		;a60b   ; banco 0: pide_sonido_si_esta_activo
L_A60E:
	ld hl,0e21eh		;a60e
	inc (hl)			;a611
	ld a,050h		;a612
	ld (0e21ch),a		;a614
	ld a,r		;a617
	rra			;a619
	ld a,0b6h		;a61a
	jr c,L_A620		;a61c
	ld a,0b3h		;a61e
L_A620:
	jp 0413ah		;a620   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa623..0xa633  (16 bytes)
DATA_A623:
	defb 0edh,0edh,0f0h,0edh,0eah,0edh,0f3h,0edh,0e7h,0edh,0f6h,0edh,0e4h,0edh,0f9h,0edh	; a623  ................

; ======================================================================
; CODIGO 0xa633..0xa7d2  (415 bytes)
; ======================================================================


L_A633:
	ld de,0ee80h		;a633
	ld hl,0a552h		;a636
	ld bc,00024h		;a639
	ldir		;a63c
	ld a,(0e0ddh)		;a63e
	and a			;a641
	jr z,L_A65A		;a642
	ld b,a			;a644
L_A645:
	push bc			;a645
	ld hl,0a623h		;a646
	ld a,b			;a649
	dec a			;a64a
	call 04055h		;a64b   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a64e
	inc hl			;a64f
	ld d,(hl)			;a650
	ld hl,0ae94h		;a651
	call 07d9ch		;a654   ; banco 1
	pop bc			;a657
	djnz L_A645		;a658
L_A65A:
	ld hl,0e21ch		;a65a
	dec (hl)			;a65d
	ret nz			;a65e
	ld hl,0e21eh		;a65f
	inc (hl)			;a662
	ld a,024h		;a663
	ld (0e21ch),a		;a665
	ret			;a668
L_A669:
	ld a,(0e003h)		;a669   ; el contador de cuadros
	and 00fh		;a66c
	jr nz,L_A6C1		;a66e
	ld hl,0e21ch		;a670
	dec (hl)			;a673
	ld a,(hl)			;a674
	cp 010h		;a675
	jr nz,L_A683		;a677
	ld hl,0e21eh		;a679
	inc (hl)			;a67c
	ld a,040h		;a67d
	ld (0e21ch),a		;a67f
	ret			;a682
L_A683:
	bit 0,(hl)		;a683
	push hl			;a685
	ld hl,0a576h		;a686
	jr z,L_A68E		;a689
	ld hl,0a59ah		;a68b
L_A68E:
	ld de,0ee80h		;a68e
	ld bc,00024h		;a691
	ldir		;a694
	pop hl			;a696
	bit 0,(hl)		;a697
	ld hl,0aea3h		;a699
	jr z,L_A6A1		;a69c
	ld hl,0aeb2h		;a69e
L_A6A1:
	ld a,(0e0ddh)		;a6a1
	and a			;a6a4
	jr z,L_A6C1		;a6a5
	ld b,a			;a6a7
L_A6A8:
	push bc			;a6a8
	push hl			;a6a9
	ld de,0a623h		;a6aa
	ld a,b			;a6ad
	dec a			;a6ae
	add a,a			;a6af
	call 0405bh		;a6b0   ; banco 0: a_mas_de
	ld a,(de)			;a6b3
	ld c,a			;a6b4
	inc de			;a6b5
	ld a,(de)			;a6b6
	ld b,a			;a6b7
	ld e,c			;a6b8
	ld d,b			;a6b9
	call 07d9ch		;a6ba   ; banco 1
	pop hl			;a6bd
	pop bc			;a6be
	djnz L_A6A8		;a6bf
L_A6C1:
	ld a,(0e003h)		;a6c1   ; el contador de cuadros
	and 006h		;a6c4
	rra			;a6c6
	ld c,a			;a6c7
	jp 041cdh		;a6c8   ; banco 0: trae_un_caracter_del_banco_6
L_A6CB:
	ld hl,0e21ch		;a6cb
	dec (hl)			;a6ce
	jr z,L_A6F8		;a6cf
	ld hl,0a40eh		;a6d1
	ld de,0ee80h		;a6d4
	ld bc,00024h		;a6d7
	ldir		;a6da
	ld a,(0e0ddh)		;a6dc
	and a			;a6df
	ret z			;a6e0
	ld b,a			;a6e1
L_A6E2:
	push bc			;a6e2
	ld hl,0a623h		;a6e3
	ld a,b			;a6e6
	dec a			;a6e7
	call 04055h		;a6e8   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a6eb
	inc hl			;a6ec
	ld d,(hl)			;a6ed
	ld hl,0aec1h		;a6ee
	call 07d9ch		;a6f1   ; banco 1
	pop bc			;a6f4
	djnz L_A6E2		;a6f5
	ret			;a6f7
L_A6F8:
	xor a			;a6f8
	ld (0e096h),a		;a6f9   ; los avisos que deja el cuadro
	ret			;a6fc
L_A6FD:
	ld a,(0e006h)		;a6fd   ; las teclas recien pulsadas
	and 010h		;a700
	jr z,L_A708		;a702
	xor a			;a704
	ld (0e212h),a		;a705
L_A708:
	ld a,(0e003h)		;a708   ; el contador de cuadros
	and 003h		;a70b
	jr nz,L_A739		;a70d
	ld hl,0e212h		;a70f
	ld a,(hl)			;a712
	cp 00ch		;a713
	jr nc,L_A723		;a715
	ld a,(hl)			;a717
	inc (hl)			;a718
	ld hl,09c74h		;a719
	call 04056h		;a71c   ; banco 0: a_mas_hl
	ld a,(hl)			;a71f
	ld (0e214h),a		;a720
L_A723:
	ld a,(0e214h)		;a723
	ld hl,0e204h		;a726
	add a,(hl)			;a729
	ld (hl),a			;a72a
	cp 020h		;a72b
	jr nc,L_A733		;a72d
	ld (hl),020h		;a72f
	jr L_A739		;a731
L_A733:
	cp 081h		;a733
	jr c,L_A739		;a735
	ld (hl),080h		;a737
L_A739:
	call L_A84B		;a739
	ld a,(0e209h)		;a73c
	call L_A87A		;a73f
L_A742:
	ld hl,(0e204h)		;a742   ; la X en la pantalla de lo que se maneja
	ld d,h			;a745
	ld (0ee98h),hl		;a746
	ld a,010h		;a749
	add a,h			;a74b
	ld h,a			;a74c
	ld (0ee9ch),hl		;a74d
	ld a,h			;a750
	sub 008h		;a751
	ld h,a			;a753
	ld a,00dh		;a754
	add a,l			;a756
	ld l,a			;a757
	ld (0eea0h),hl		;a758
	ld a,003h		;a75b
	add a,l			;a75d
	ld l,a			;a75e
	ld (0ee94h),hl		;a75f
	ld hl,0e213h		;a762
	ld a,(0e003h)		;a765   ; el contador de cuadros
	and 007h		;a768
	jr nz,L_A76D		;a76a
	inc (hl)			;a76c
L_A76D:
	ld a,(hl)			;a76d
	rra			;a76e
	ld c,007h		;a76f
	jr nc,L_A778		;a771
	inc c			;a773
	rra			;a774
	jr nc,L_A778		;a775
	inc c			;a777
L_A778:
	ld a,c			;a778
	add a,a			;a779
	add a,a			;a77a
	ld hl,0a91dh		;a77b
	call 04055h		;a77e   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a781
	inc hl			;a782
	ld d,(hl)			;a783
	ld (0ee96h),de		;a784
	inc hl			;a788
	ld e,(hl)			;a789
	inc hl			;a78a
	ld d,(hl)			;a78b
	ld (0ee9ah),de		;a78c
	inc hl			;a790
	ld e,(hl)			;a791
	inc hl			;a792
	ld d,(hl)			;a793
	ld (0ee9eh),de		;a794
	inc hl			;a798
	ld e,(hl)			;a799
	inc hl			;a79a
	ld d,(hl)			;a79b
	ld (0eea2h),de		;a79c
	ld a,004h		;a7a0
	ld (0ee9bh),a		;a7a2
	ld (0ee9fh),a		;a7a5
	ld a,00fh		;a7a8
	ld (0eea3h),a		;a7aa
	ld a,00ah		;a7ad
	ld (0ee97h),a		;a7af
	ret			;a7b2
L_A7B3:
	call L_A083		;a7b3
	ld a,(0e204h)		;a7b6   ; la X en la pantalla de lo que se maneja
	add a,001h		;a7b9
	ld (0e204h),a		;a7bb   ; la X en la pantalla de lo que se maneja
	cp 0c0h		;a7be
	jp c,L_A742		;a7c0
	xor a			;a7c3
	ld (0e096h),a		;a7c4   ; los avisos que deja el cuadro
	ret			;a7c7
L_A7C8:
	call L_A083		;a7c8
	ld a,(0e21eh)		;a7cb
	dec a			;a7ce
	call 04060h		;a7cf   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa7d2..0xa7d8  (6 bytes)
DATA_A7D2:
	defb 0d8h,0a7h,00ah,0a8h,019h,0a8h	; a7d2

; ======================================================================
; CODIGO 0xa7d8..0xa91d  (325 bytes)
; ======================================================================


L_A7D8:
	xor a			;a7d8
	call L_A8F5		;a7d9
	ld hl,0e21fh		;a7dc
	inc (hl)			;a7df
	ld a,(hl)			;a7e0
	cp 090h		;a7e1
	jr z,L_A800		;a7e3
	ld c,a			;a7e5
	and 00fh		;a7e6
	jr nz,L_A7FB		;a7e8
	ld a,(0e220h)		;a7ea
	ld b,a			;a7ed
	ld hl,0ee94h		;a7ee
	add a,a			;a7f1
	call 04055h		;a7f2   ; banco 0: dos_por_a_mas_hl
	ld (hl),c			;a7f5
	inc b			;a7f6
	ld a,b			;a7f7
	ld (0e220h),a		;a7f8
L_A7FB:
	ld a,c			;a7fb
	ld (0ee90h),a		;a7fc
	ret			;a7ff
L_A800:
	ld hl,0e21eh		;a800
	inc (hl)			;a803
	ld a,010h		;a804
	ld (0e21ch),a		;a806
	ret			;a809
L_A80A:
	ld a,00ch		;a80a
	call L_A8F5		;a80c
	ld hl,0e21ch		;a80f
	dec (hl)			;a812
	ret nz			;a813
	ld hl,0e21eh		;a814
	inc (hl)			;a817
	ret			;a818
L_A819:
	ld hl,0e21fh		;a819
	dec (hl)			;a81c
	ld a,(hl)			;a81d
	ld c,a			;a81e
	and 00fh		;a81f
	jr nz,L_A835		;a821
	ld a,(0e220h)		;a823
	ld b,a			;a826
	ld hl,0ee94h		;a827
	add a,a			;a82a
	call 04055h		;a82b   ; banco 0: dos_por_a_mas_hl
	ld (hl),0e0h		;a82e
	dec b			;a830
	ld a,b			;a831
	ld (0e220h),a		;a832
L_A835:
	ld a,c			;a835
	ld (0ee90h),a		;a836
	ld hl,0e204h		;a839
	dec (hl)			;a83c
	call L_A8DB		;a83d
	ld a,(0e204h)		;a840   ; la X en la pantalla de lo que se maneja
	cp 0f8h		;a843
	ret nz			;a845
	xor a			;a846
	ld (0e203h),a		;a847   ; por donde va la rotacion de los sprites
	ret			;a84a
L_A84B:
	ld a,(0e007h)		;a84b   ; el estado de los mandos del cuadro anterior
	and 00ch		;a84e
	ld b,a			;a850
	ld c,000h		;a851
	jr z,L_A875		;a853
	ld a,(0e006h)		;a855   ; las teclas recien pulsadas
	and 00ch		;a858
	cp 00ch		;a85a
	ret z			;a85c
	bit 2,a		;a85d
	ld c,004h		;a85f
	jr nz,L_A875		;a861
	bit 3,a		;a863
	ld c,008h		;a865
	jr nz,L_A875		;a867
	ld a,b			;a869
	cp 00ch		;a86a
	ret z			;a86c
	bit 2,a		;a86d
	ld c,004h		;a86f
	jr nz,L_A875		;a871
	ld c,008h		;a873
L_A875:
	ld a,c			;a875
	ld (0e209h),a		;a876
	ret			;a879
L_A87A:
	ld hl,0e205h		;a87a
	and 00ch		;a87d
	jr z,L_A8B1		;a87f
	cp 00ch		;a881
	jr z,L_A8B1		;a883
	cp 008h		;a885
	jr z,L_A89E		;a887
	ld a,(0e16dh)		;a889
	and a			;a88c
	ld c,001h		;a88d
	jr z,L_A892		;a88f
	inc c			;a891
L_A892:
	ld a,(hl)			;a892
	sub c			;a893
	ld (hl),a			;a894
	ld a,(hl)			;a895
	cp 014h		;a896
	jr nc,L_A8B1		;a898
	ld (hl),014h		;a89a
	jr L_A8B1		;a89c
L_A89E:
	ld a,(0e16dh)		;a89e
	and a			;a8a1
	ld c,001h		;a8a2
	jr z,L_A8A7		;a8a4
	inc c			;a8a6
L_A8A7:
	ld a,(hl)			;a8a7
	add a,c			;a8a8
	ld (hl),a			;a8a9
	ld a,(hl)			;a8aa
	cp 0cdh		;a8ab
	jr c,L_A8B1		;a8ad
	ld (hl),0cch		;a8af
L_A8B1:
	ld a,(0e20bh)		;a8b1
	and a			;a8b4
	ret nz			;a8b5
	ld a,(0e003h)		;a8b6   ; el contador de cuadros
	rra			;a8b9
	ret nc			;a8ba
	ld a,(0e16eh)		;a8bb
	and a			;a8be
	ret nz			;a8bf
	ld a,(0e0a6h)		;a8c0
	and a			;a8c3
	ret z			;a8c4
	rra			;a8c5
	ld a,001h		;a8c6
	jr c,L_A8CC		;a8c8
	ld a,0ffh		;a8ca
L_A8CC:
	add a,(hl)			;a8cc
	ld (hl),a			;a8cd
	cp 0cdh		;a8ce
	jr c,L_A8D5		;a8d0
	ld (hl),0cch		;a8d2
	ret			;a8d4
L_A8D5:
	cp 014h		;a8d5
	ret nc			;a8d7
	ld (hl),014h		;a8d8
	ret			;a8da
L_A8DB:
	ld hl,(0e204h)		;a8db   ; la X en la pantalla de lo que se maneja
	ld d,h			;a8de
	ld (0ee80h),hl		;a8df   ; la tabla de atributos de los 32 sprites
	ld a,010h		;a8e2
	add a,h			;a8e4
	ld h,a			;a8e5
	ld (0ee84h),hl		;a8e6
	ld a,010h		;a8e9
	add a,l			;a8eb
	ld l,a			;a8ec
	ld (0ee8ch),hl		;a8ed
	ld h,d			;a8f0
	ld (0ee88h),hl		;a8f1
	ret			;a8f4
L_A8F5:
	add a,a			;a8f5
	add a,a			;a8f6
	ld hl,0a91dh		;a8f7
	call 04055h		;a8fa   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a8fd
	inc hl			;a8fe
	ld d,(hl)			;a8ff
	ld (0ee82h),de		;a900
	inc hl			;a904
	ld e,(hl)			;a905
	inc hl			;a906
	ld d,(hl)			;a907
	ld (0ee86h),de		;a908
	inc hl			;a90c
	ld e,(hl)			;a90d
	inc hl			;a90e
	ld d,(hl)			;a90f
	ld (0ee8ah),de		;a910
	inc hl			;a914
	ld e,(hl)			;a915
	inc hl			;a916
	ld d,(hl)			;a917
	ld (0ee8eh),de		;a918
	ret			;a91c

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa91d..0xa985  (104 bytes)
DATA_A91D:
	defb 018h,001h,01ch,001h,010h,001h,014h,001h,020h,001h,024h,001h,000h,001h,008h,001h	; a91d  ........ .$.....
	defb 028h,001h,02ch,001h,00ch,001h,004h,001h,018h,001h,01ch,001h,058h,001h,05ch,001h	; a92d  (.,.........X.\.
	defb 068h,001h,06ch,001h,060h,001h,064h,001h,020h,001h,024h,001h,000h,001h,050h,001h	; a93d  h.l.`.d. .$...P.
	defb 028h,001h,02ch,001h,054h,001h,004h,001h,004h,00ah,010h,001h,014h,001h,000h,00fh	; a94d  (.,.T...........
	defb 008h,00ah,018h,001h,01ch,001h,000h,00fh,00ch,00ah,020h,001h,024h,001h,000h,00fh	; a95d  .......... .$...
	defb 000h,00fh,000h,00fh,018h,001h,01ch,001h,0c0h,001h,0c4h,001h,0c8h,001h,0cch,001h	; a96d  ................
	defb 038h,001h,03ch,001h,040h,001h,044h,001h	; a97d  8.<.@.D.

; ======================================================================
; CODIGO 0xa985..0xa98b  (6 bytes)
; ======================================================================


L_A985:
	ld a,(0e203h)		;a985   ; por donde va la rotacion de los sprites
	call 04060h		;a988   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa98b..0xa9c3  (56 bytes)
DATA_A98B:
	defb 0c3h,0a9h,0d7h,0a9h,00bh,0aah,0c3h,0a9h,06ch,0aah,06ch,0aah,061h,0aah,075h,0aah	; a98b  ........l.l.a.u.
	defb 06ch,0aah,0c3h,0a9h,0c3h,0a9h,03fh,0aah,049h,0aah,051h,0aah,051h,0aah,0c3h,0a9h	; a99b  l.....?.I.Q.Q...
	defb 0c3h,0a9h,0c3h,0a9h,06ch,0aah,06ch,0aah,0c3h,0a9h,06ch,0aah,06ch,0aah,06ch,0aah	; a9ab  ....l.l...l.l.l.
	defb 06ch,0aah,06ch,0aah,06ch,0aah,0c3h,0a9h	; a9bb  l.l.l...

; ======================================================================
; CODIGO 0xa9c3..0xa9f7  (52 bytes)
; ======================================================================


L_A9C3:
	ld hl,(0e204h)		;a9c3   ; la X en la pantalla de lo que se maneja
	ld l,0aeh		;a9c6
L_A9C8:
	ld a,004h		;a9c8
	add a,h			;a9ca
	ld h,a			;a9cb
	ld (0eec8h),hl		;a9cc
	ld a,008h		;a9cf
	add a,h			;a9d1
	ld h,a			;a9d2
	ld (0eecch),hl		;a9d3
	ret			;a9d6
L_A9D7:
	ld a,(0e208h)		;a9d7
	cp 0ffh		;a9da
	jr z,L_A9C3		;a9dc
	ld hl,0a9f7h		;a9de
L_A9E1:
	call 04055h		;a9e1   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a9e4
	inc hl			;a9e5
	ld d,(hl)			;a9e6
	ld a,(0e205h)		;a9e7   ; la Y en la pantalla de lo que se maneja
	ld l,0aeh		;a9ea
	add a,e			;a9ec
	ld h,a			;a9ed
	ld (0eec8h),hl		;a9ee
	add a,d			;a9f1
	ld h,a			;a9f2
	ld (0eecch),hl		;a9f3
	ret			;a9f6

; ----------------------------------------------------------------------
; DATOS sin identificar  0xa9f7..0xaa0b  (20 bytes)
DATA_A9F7:
	defb 005h,006h,006h,004h,007h,002h,008h,000h,008h,000h,008h,000h,008h,000h,007h,002h	; a9f7  ................
	defb 006h,004h,005h,006h	; aa07

; ======================================================================
; CODIGO 0xaa0b..0xaa17  (12 bytes)
; ======================================================================


L_AA0B:
	ld a,(0e208h)		;aa0b
	cp 0ffh		;aa0e
	jr z,$-77		;aa10
	ld hl,0aa17h		;aa12
	jr $-52		;aa15

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaa17..0xaa3f  (40 bytes)
DATA_AA17:
	defb 005h,006h,006h,004h,007h,002h,008h,000h,008h,000h,008h,000h,008h,000h,008h,000h	; aa17  ................
	defb 008h,000h,008h,000h,008h,000h,008h,000h,008h,000h,008h,000h,008h,000h,008h,000h	; aa27  ................
	defb 008h,000h,007h,002h,006h,004h,005h,006h	; aa37  ........

; ======================================================================
; CODIGO 0xaa3f..0xaa8a  (75 bytes)
; ======================================================================


L_AA3F:
	ld hl,(0e204h)		;aa3f   ; la X en la pantalla de lo que se maneja
	ld a,l			;aa42
	add a,01eh		;aa43
	ld l,a			;aa45
	jp L_A9C8		;aa46
L_AA49:
	ld hl,(0e204h)		;aa49   ; la X en la pantalla de lo que se maneja
	ld l,0b0h		;aa4c
	jp L_A9C8		;aa4e
L_AA51:
	ld hl,(0e204h)		;aa51   ; la X en la pantalla de lo que se maneja
	ld l,0b0h		;aa54
	ld a,008h		;aa56
	add a,h			;aa58
	ld h,a			;aa59
	ld (0eec8h),hl		;aa5a
	ld (0eecch),hl		;aa5d
	ret			;aa60
L_AA61:
	ld a,005h		;aa61
	ld (0eecbh),a		;aa63
	ld (0eecfh),a		;aa66
	jp L_A9D7		;aa69
L_AA6C:
	ld a,0e0h		;aa6c
	ld (0eec8h),a		;aa6e
	ld (0eecch),a		;aa71
	ret			;aa74
L_AA75:
	ld a,005h		;aa75
	ld (0eecbh),a		;aa77
	ld (0eecfh),a		;aa7a
	jp L_AA0B		;aa7d
L_AA80:
	ld a,(0e0b7h)		;aa80
	ld b,a			;aa83
	ld a,(0e0b9h)		;aa84
	call 04060h		;aa87   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaa8a..0xaa90  (6 bytes)
DATA_AA8A:
	defb 05bh,0abh,041h,0ach,090h,0aah	; aa8a

; ======================================================================
; CODIGO 0xaa90..0xad88  (760 bytes)
; ======================================================================


L_AA90:
	djnz L_AAA0		;aa90
	call L_ACD6		;aa92
	ret nz			;aa95
	ld de,0b2ech		;aa96
	ld (0e4e0h),de		;aa99   ; la tabla de cambio de color, nibble alto
	jp L_AAE6		;aa9d
L_AAA0:
	djnz L_AAB1		;aaa0
	call 05667h		;aaa2
	call 056d9h		;aaa5
	call 048c3h		;aaa8
	call 05789h		;aaab
	jp L_AB51		;aaae
L_AAB1:
	djnz L_AADC		;aab1
	ld a,(0e0b8h)		;aab3
	cp 01bh		;aab6
	call c,L_AD4C		;aab8
	ld de,(0e4e0h)		;aabb   ; la tabla de cambio de color, nibble alto
	call 07b85h		;aabf   ; banco 1
	ld (0e4e0h),de		;aac2   ; la tabla de cambio de color, nibble alto
	ret nz			;aac6
	ld a,071h		;aac7
	call 04145h		;aac9   ; banco 0: pide_sonido
	xor a			;aacc
	ld (0e0b8h),a		;aacd
	ld a,0bfh		;aad0
	ld (0e204h),a		;aad2   ; la X en la pantalla de lo que se maneja
	ld a,06dh		;aad5
	ld (0e205h),a		;aad7   ; la Y en la pantalla de lo que se maneja
	jr L_AAE6		;aada
L_AADC:
	djnz L_AAE8		;aadc
	ld a,(0e204h)		;aade   ; la X en la pantalla de lo que se maneja
	cp 082h		;aae1
	jp nz,L_ACE6		;aae3
L_AAE6:
	jr L_AB28		;aae6
L_AAE8:
	djnz L_AAFB		;aae8
L_AAEA:
	ld a,(0e003h)		;aaea   ; el contador de cuadros
	and 00fh		;aaed
	ret nz			;aaef
	ld hl,0a432h		;aaf0
	call L_AD0B		;aaf3
	call L_AD14		;aaf6
	jr L_AB51		;aaf9
L_AAFB:
	djnz L_AB13		;aafb
	ld a,(0e012h)		;aafd
	and a			;ab00
	ret nz			;ab01
	xor a			;ab02
	ld (0e0b8h),a		;ab03
	ld hl,0a456h		;ab06
	call L_AD0B		;ab09
	ld a,0a4h		;ab0c
	call 04145h		;ab0e   ; banco 0: pide_sonido
	jr L_AB28		;ab11
L_AB13:
	djnz L_AB2A		;ab13
	ld a,(0e003h)		;ab15   ; el contador de cuadros
	and 003h		;ab18
	ret nz			;ab1a
	ld a,(0e0b8h)		;ab1b
	cp 011h		;ab1e
	jp c,L_AD58		;ab20
	ld hl,0e0b8h		;ab23
	inc (hl)			;ab26
	ret z			;ab27
L_AB28:
	jr L_AB56		;ab28
L_AB2A:
	djnz L_AB38		;ab2a
	ld a,(0e012h)		;ab2c
	and a			;ab2f
	ret nz			;ab30
	ld a,0b9h		;ab31
	call 04145h		;ab33   ; banco 0: pide_sonido
	jr L_AB56		;ab36
L_AB38:
	djnz L_AB42		;ab38
	ld hl,0b58ch		;ab3a
	call 07be7h		;ab3d   ; banco 1
	jr L_AB56		;ab40
L_AB42:
	djnz L_AB4E		;ab42
L_AB44:
	ld a,(0e012h)		;ab44
	and a			;ab47
	ret nz			;ab48
	xor a			;ab49
	ld (0e096h),a		;ab4a   ; los avisos que deja el cuadro
	ret			;ab4d
L_AB4E:
	call 042edh		;ab4e   ; banco 0: esconde_los_sprites
L_AB51:
	ld a,020h		;ab51
	ld (0e0b8h),a		;ab53
L_AB56:
	ld hl,0e0b7h		;ab56
	inc (hl)			;ab59
	ret			;ab5a
L_AB5B:
	djnz L_AB63		;ab5b
L_AB5D:
	call L_ACD6		;ab5d
	ret nz			;ab60
	jr L_AB56		;ab61
L_AB63:
	djnz L_AB77		;ab63
	xor a			;ab65
	ld (0e0a1h),a		;ab66   ; el DECORADO, de 0 a 9
	call 057fbh		;ab69
	call 048fch		;ab6c
L_AB6F:
	ld hl,0b5f1h		;ab6f
	ld (0e4e0h),hl		;ab72   ; la tabla de cambio de color, nibble alto
L_AB75:
	jr L_AB51		;ab75
L_AB77:
	djnz L_AB91		;ab77
	ld de,(0e4e0h)		;ab79   ; la tabla de cambio de color, nibble alto
	call 07b85h		;ab7d   ; banco 1
	ld (0e4e0h),de		;ab80   ; la tabla de cambio de color, nibble alto
	ret nz			;ab84
	ld a,070h		;ab85
	ld (0e205h),a		;ab87   ; la Y en la pantalla de lo que se maneja
	ld a,077h		;ab8a
	call 04145h		;ab8c   ; banco 0: pide_sonido
	jr L_AB75		;ab8f
L_AB91:
	djnz L_ABA5		;ab91
	ld hl,0e0b8h		;ab93
	dec (hl)			;ab96
	ret nz			;ab97
	ld hl,0b90dh		;ab98
	call 07be7h		;ab9b   ; banco 1
	ld a,0bfh		;ab9e
	ld (0e204h),a		;aba0   ; la X en la pantalla de lo que se maneja
	jr L_AB75		;aba3
L_ABA5:
	djnz L_ABBC		;aba5
L_ABA7:
	ld a,(0e204h)		;aba7   ; la X en la pantalla de lo que se maneja
	cp 07bh		;abaa
	jp nc,L_ACE6		;abac
	ld hl,0e0b8h		;abaf
	dec (hl)			;abb2
	ret nz			;abb3
	ld a,004h		;abb4
	call 04145h		;abb6   ; banco 0: pide_sonido
L_ABB9:
	jp L_AB56		;abb9
L_ABBC:
	djnz L_ABE7		;abbc
	call L_AD2F		;abbe
	ld a,(0e003h)		;abc1   ; el contador de cuadros
	and 003h		;abc4
	jr nz,L_ABCC		;abc6
	ld hl,0e0b8h		;abc8
	inc (hl)			;abcb
L_ABCC:
	ld a,(0e0b8h)		;abcc
	cp 00fh		;abcf
	jp nz,L_ABDF		;abd1
	ld hl,0b930h		;abd4
	call 07be7h		;abd7   ; banco 1
	ld a,07dh		;abda
	call 04145h		;abdc   ; banco 0: pide_sonido
L_ABDF:
	ld a,(0e0b8h)		;abdf
	cp 01ch		;abe2
	ret nz			;abe4
	jr L_AB75		;abe5
L_ABE7:
	djnz L_AC0C		;abe7
	ld a,07bh		;abe9
	ld (0e204h),a		;abeb   ; la X en la pantalla de lo que se maneja
	call L_A8DB		;abee
	xor a			;abf1
	ld hl,0e0b8h		;abf2
	dec (hl)			;abf5
	jp nz,L_A8F5		;abf6
	ld hl,0b93ch		;abf9
	call 07be7h		;abfc   ; banco 1
	ld a,080h		;abff
	call 04145h		;ac01   ; banco 0: pide_sonido
	call 05667h		;ac04
	call 056d9h		;ac07
	jr L_ABB9		;ac0a
L_AC0C:
	djnz L_AC15		;ac0c
	ld a,(0e012h)		;ac0e
	and a			;ac11
	ret nz			;ac12
	jr L_ABB9		;ac13
L_AC15:
	djnz L_AC1A		;ac15
	jp L_AAEA		;ac17
L_AC1A:
	djnz L_AC2F		;ac1a
	ld hl,0e0b8h		;ac1c
	dec (hl)			;ac1f
	ret nz			;ac20
	ld a,0bch		;ac21
	call 04145h		;ac23   ; banco 0: pide_sonido
	ld hl,0a456h		;ac26
	call L_AD0B		;ac29
	jp L_AB56		;ac2c
L_AC2F:
	djnz L_AC39		;ac2f
	ld hl,0b891h		;ac31
	call 07be7h		;ac34   ; banco 1
L_AC37:
	jr L_ABB9		;ac37
L_AC39:
	djnz L_AC3E		;ac39
	jp L_AB44		;ac3b
L_AC3E:
	jp L_AB4E		;ac3e
L_AC41:
	djnz L_AC46		;ac41
	jp L_AB5D		;ac43
L_AC46:
	djnz L_AC57		;ac46
	call 048fch		;ac48
	call 05717h		;ac4b
	ld hl,0b963h		;ac4e
	ld (0e4e2h),hl		;ac51
	jp L_AB6F		;ac54
L_AC57:
	djnz L_AC67		;ac57
	ld hl,0ae07h		;ac59
	ld bc,00008h		;ac5c
	ld de,0ee98h		;ac5f
	ldir		;ac62
	jp L_AB51		;ac64
L_AC67:
	djnz L_AC9A		;ac67
	ld de,(0e4e0h)		;ac69   ; la tabla de cambio de color, nibble alto
	call 07b85h		;ac6d   ; banco 1
	ld (0e4e0h),de		;ac70   ; la tabla de cambio de color, nibble alto
	ld a,(0e0b8h)		;ac74
	cp 016h		;ac77
	ld de,(0e4e2h)		;ac79
	call nc,07bc4h		;ac7d
	ld (0e4e2h),de		;ac80
	ld a,(0e0b8h)		;ac84
	and a			;ac87
	ret nz			;ac88
	ld a,0bfh		;ac89
	call 04145h		;ac8b   ; banco 0: pide_sonido
	ld a,070h		;ac8e
	ld (0e205h),a		;ac90   ; la Y en la pantalla de lo que se maneja
	ld a,0bfh		;ac93
	ld (0e204h),a		;ac95   ; la X en la pantalla de lo que se maneja
	jr L_AC37		;ac98
L_AC9A:
	djnz L_AC9F		;ac9a
	jp L_ABA7		;ac9c
L_AC9F:
	djnz L_ACAC		;ac9f
	call L_ACB5		;aca1
	and 010h		;aca4
	call z,L_ACAF		;aca6
	jp L_AB44		;aca9
L_ACAC:
	jp L_AB4E		;acac
L_ACAF:
	ld hl,0b995h		;acaf
	jp 07be7h		;acb2   ; banco 1
L_ACB5:
	ld a,(0e003h)		;acb5   ; el contador de cuadros
	and 007h		;acb8
	ret nz			;acba
	ld a,(0e0b8h)		;acbb
	and 001h		;acbe
	ld hl,0add7h		;acc0
	jr z,L_ACC8		;acc3
	ld hl,0adefh		;acc5
L_ACC8:
	ld bc,00018h		;acc8
	ld de,0ee80h		;accb
	ldir		;acce
	ld hl,0e0b8h		;acd0
	ld a,(hl)			;acd3
	inc (hl)			;acd4
	ret			;acd5
L_ACD6:
	call 07baeh		;acd6   ; banco 1
	xor a			;acd9
	ld de,00020h		;acda
L_ACDD:
	ld (hl),a			;acdd
	add hl,de			;acde
	djnz L_ACDD		;acdf
	ld a,(0e0b8h)		;ace1
	and a			;ace4
	ret			;ace5
L_ACE6:
	ld a,(0e003h)		;ace6   ; el contador de cuadros
	and 003h		;ace9
	ret nz			;aceb
	ld a,(0e204h)		;acec   ; la X en la pantalla de lo que se maneja
	dec a			;acef
	ld (0e204h),a		;acf0   ; la X en la pantalla de lo que se maneja
	call L_A8DB		;acf3
	ld a,(0e204h)		;acf6   ; la X en la pantalla de lo que se maneja
	and 001h		;acf9
	jr z,L_AD08		;acfb
	ld a,(0e204h)		;acfd   ; la X en la pantalla de lo que se maneja
	and 002h		;ad00
	ld a,001h		;ad02
	jr z,L_AD08		;ad04
	ld a,002h		;ad06
L_AD08:
	jp L_A8F5		;ad08
L_AD0B:
	ld de,0ee80h		;ad0b
	ld bc,00024h		;ad0e
	ldir		;ad11
	ret			;ad13
L_AD14:
	ld a,(0e0b9h)		;ad14
	and 001h		;ad17
	ld c,0d4h		;ad19
	jr nz,L_AD1F		;ad1b
	ld c,0dfh		;ad1d
L_AD1F:
	ld hl,0ee80h		;ad1f
	ld b,009h		;ad22
L_AD24:
	ld a,(hl)			;ad24
	add a,c			;ad25
	ld (hl),a			;ad26
	ld a,004h		;ad27
	call 04056h		;ad29   ; banco 0: a_mas_hl
	djnz L_AD24		;ad2c
	ret			;ad2e
L_AD2F:
	ld hl,0adbah		;ad2f
	ld a,(0e0b8h)		;ad32
	call 04056h		;ad35   ; banco 0: a_mas_hl
	ld a,(hl)			;ad38
	ld (0e204h),a		;ad39   ; la X en la pantalla de lo que se maneja
	call L_A8DB		;ad3c
	ld a,(0e0b8h)		;ad3f
	and 001h		;ad42
	ld a,003h		;ad44
	jr z,L_AD49		;ad46
	inc a			;ad48
L_AD49:
	jp L_A8F5		;ad49
L_AD4C:
	ld hl,0adaah		;ad4c
	ld de,0eef0h		;ad4f
	ld bc,00010h		;ad52
	ldir		;ad55
	ret			;ad57
L_AD58:
	call L_AD4C		;ad58
	ld a,(0e0b8h)		;ad5b
	sla a		;ad5e
	ld hl,0ad88h		;ad60
	call 04056h		;ad63   ; banco 0: a_mas_hl
	ld a,(hl)			;ad66
	ld (0eef0h),a		;ad67
	sub 005h		;ad6a
	ld (0eef4h),a		;ad6c
	ld (0eef8h),a		;ad6f
	ld (0eefch),a		;ad72
	inc hl			;ad75
	ld a,(hl)			;ad76
	ld (0eef1h),a		;ad77
	ld (0eef5h),a		;ad7a
	ld (0eef9h),a		;ad7d
	ld (0eefdh),a		;ad80
	ld hl,0e0b8h		;ad83
	inc (hl)			;ad86
	ret			;ad87

; ----------------------------------------------------------------------
; DATOS sin identificar  0xad88..0xae0f  (135 bytes)
DATA_AD88:
	defb 038h,080h,03ch,080h,041h,080h,047h,080h,04eh,080h,056h,080h,05eh,080h,067h,080h	; ad88  8.<.A.G.N.V.^.g.
	defb 070h,080h,067h,07fh,05eh,07eh,056h,07ch,050h,07ah,056h,078h,05eh,076h,067h,075h	; ad98  p.g.^~V|PzVx^vgu
	defb 070h,074h,038h,080h,0f0h,00ah,033h,080h,0f4h,001h,033h,080h,0f8h,008h,026h,077h	; ada8  pt8...3...3...&w
	defb 0fch,002h,079h,071h,06dh,068h,064h,060h,05dh,05ah,058h,056h,054h,053h,052h,051h	; adb8  ..yqmhd`]ZXVTSRQ
	defb 050h,051h,052h,053h,054h,056h,058h,05ah,05dh,060h,064h,068h,06dh,071h,079h,07bh	; adc8  PQRSTVXZ]`dhmqy{
	defb 070h,0b8h,001h,07bh,080h,0bch,001h,08bh,070h,0c0h,001h,08bh,080h,0c4h,001h,0d1h	; add8  p..{....p.......
	defb 000h,000h,000h,0d1h,000h,000h,000h,07bh,070h,0c8h,001h,07bh,080h,0cch,001h,08bh	; ade8  .......{p..{....
	defb 070h,0d0h,001h,08bh,080h,0d4h,001h,07bh,070h,0d8h,00fh,07bh,080h,0dch,00fh,047h	; adf8  p......{p..{...G
	defb 078h,0e0h,001h,047h,088h,0e4h,001h	; ae08

; ======================================================================
; CODIGO 0xae0f..0xae1b  (12 bytes)
; ======================================================================


L_AE0F:
	ld hl,0ae1bh		;ae0f
	ld de,0e530h		;ae12
	ld bc,00008h		;ae15
	ldir		;ae18
	ret			;ae1a

; ----------------------------------------------------------------------
; DATOS sin identificar  0xae1b..0xae23  (8 bytes)
DATA_AE1B:
	defb 001h,000h,000h,030h,000h,080h,080h,002h	; ae1b  ...0....

; ======================================================================
; CODIGO 0xae23..0xae3a  (23 bytes)
; ======================================================================


L_AE23:
	ld hl,0ae3ah		;ae23
	ld de,0e550h		;ae26
	ld bc,00020h		;ae29
	ldir		;ae2c
	ld hl,0ae5ah		;ae2e
	ld de,0eea8h		;ae31
	ld bc,00010h		;ae34
	ldir		;ae37
	ret			;ae39

; ----------------------------------------------------------------------
; DATOS sin identificar  0xae3a..0xae6a  (48 bytes)
DATA_AE3A:
	defb 001h,0ffh,028h,041h,000h,000h,000h,000h,001h,0ffh,060h,001h,000h,000h,000h,000h	; ae3a  ..(A......`.....
	defb 001h,0ffh,098h,021h,000h,000h,000h,000h,001h,0ffh,0d0h,061h,000h,000h,000h,000h	; ae4a  ...!.......a....
	defb 0e0h,000h,0a0h,004h,0e0h,000h,0a0h,004h,0e0h,000h,0a0h,004h,0e0h,000h,0a0h,004h	; ae5a  ................

; ======================================================================
; CODIGO 0xae6a..0xaf4b  (225 bytes)
; ======================================================================


L_AE6A:
	ld a,(0e530h)		;ae6a
	dec a			;ae6d
	ret nz			;ae6e
	ld a,(0e540h)		;ae6f
	dec a			;ae72
	ret z			;ae73
	dec a			;ae74
	ret z			;ae75
	ld hl,0e534h		;ae76
	ld a,(hl)			;ae79
	dec l			;ae7a
	and a			;ae7b
	jr z,L_AED2		;ae7c
	dec a			;ae7e
	jr z,L_AEAA		;ae7f
	dec (hl)			;ae81
	jp z,L_AF28		;ae82
	ld a,(hl)			;ae85
	cp 040h		;ae86
	jr z,L_AE8F		;ae88
	cp 020h		;ae8a
	jr z,L_AE94		;ae8c
	ret			;ae8e
L_AE8F:
	dec l			;ae8f
	dec l			;ae90
	ld (hl),002h		;ae91
	ret			;ae93
L_AE94:
	ld a,(0e537h)		;ae94
	inc a			;ae97
	ld (0e537h),a		;ae98
	dec l			;ae9b
	dec l			;ae9c
	ld (hl),001h		;ae9d
	ld hl,0af4bh		;ae9f
	call 04056h		;aea2   ; banco 0: a_mas_hl
	ld a,(hl)			;aea5
	ld (0e536h),a		;aea6
	ret			;aea9
L_AEAA:
	dec (hl)			;aeaa
	jr z,L_AF28		;aeab
	ld a,(hl)			;aead
	cp 040h		;aeae
	jr z,L_AEB7		;aeb0
	cp 020h		;aeb2
	jr z,L_AEBC		;aeb4
	ret			;aeb6
L_AEB7:
	dec l			;aeb7
	dec l			;aeb8
	ld (hl),001h		;aeb9
	ret			;aebb
L_AEBC:
	ld a,(0e537h)		;aebc
	dec a			;aebf
	ld (0e537h),a		;aec0
	dec l			;aec3
	dec l			;aec4
	ld (hl),002h		;aec5
	ld hl,0af4bh		;aec7
	call 04056h		;aeca   ; banco 0: a_mas_hl
	ld a,(hl)			;aecd
	ld (0e536h),a		;aece
	ret			;aed1
L_AED2:
	dec (hl)			;aed2
	ret z			;aed3
	inc l			;aed4
	inc l			;aed5
	inc l			;aed6
	ld a,(0e205h)		;aed7   ; la Y en la pantalla de lo que se maneja
	add a,010h		;aeda
	cp (hl)			;aedc
	jr nc,L_AF03		;aedd
	dec l			;aedf
	dec l			;aee0
	dec l			;aee1
	ld a,(0e537h)		;aee2
	and a			;aee5
	jr z,L_AF28		;aee6
	ld c,a			;aee8
	ld a,(0e092h)		;aee9   ; la FASE, de 1 a 13
	ld de,0af50h		;aeec
	call 0405bh		;aeef   ; banco 0: a_mas_de
	ld a,(de)			;aef2
	ld (hl),a			;aef3
	inc l			;aef4
	ld (hl),001h		;aef5
	ld a,c			;aef7
	ld hl,0af4bh		;aef8
	call 04056h		;aefb   ; banco 0: a_mas_hl
	ld a,(hl)			;aefe
	ld (0e536h),a		;aeff
	ret			;af02
L_AF03:
	dec l			;af03
	dec l			;af04
	dec l			;af05
	ld a,(0e537h)		;af06
	cp 004h		;af09
	jr z,L_AF28		;af0b
	ld c,a			;af0d
	ld a,(0e092h)		;af0e   ; la FASE, de 1 a 13
	ld de,0af50h		;af11
	call 0405bh		;af14   ; banco 0: a_mas_de
	ld a,(de)			;af17
	ld (hl),a			;af18
	inc l			;af19
	ld (hl),002h		;af1a
	ld a,c			;af1c
	ld hl,0af4bh		;af1d
	call 04056h		;af20   ; banco 0: a_mas_hl
	ld a,(hl)			;af23
	ld (0e536h),a		;af24
	ret			;af27
L_AF28:
	ld a,(0e092h)		;af28   ; la FASE, de 1 a 13
	ld de,0af69h		;af2b
	call 0405bh		;af2e   ; banco 0: a_mas_de
	ld a,(de)			;af31
	ld (hl),a			;af32
	inc l			;af33
	ld (hl),000h		;af34
	dec l			;af36
	dec l			;af37
	dec l			;af38
	ld (hl),000h		;af39
	ld a,(0e537h)		;af3b
	ld hl,0af4bh		;af3e
	call 04056h		;af41   ; banco 0: a_mas_hl
	ld a,(hl)			;af44
	ld (0e536h),a		;af45
	jp L_B165		;af48

; ----------------------------------------------------------------------
; DATOS sin identificar  0xaf4b..0xaf82  (55 bytes)
DATA_AF4B:
	defb 070h,078h,080h,088h,090h,000h,060h,060h,060h,05ch,05ch,05ch,058h,058h,058h,054h	; af4b  px....```\\\XXXT
	defb 054h,054h,050h,050h,050h,04ch,04ch,04ch,048h,048h,048h,044h,044h,044h,000h,030h	; af5b  TTPPPLLLHHHDDD.0
	defb 030h,030h,02ch,02ch,02ch,028h,028h,028h,024h,024h,024h,020h,020h,020h,01ch,01ch	; af6b  00,,,((($$$   ..
	defb 01ch,018h,018h,018h,014h,014h,014h	; af7b

; ======================================================================
; CODIGO 0xaf82..0xafb7  (53 bytes)
; ======================================================================


L_AF82:
	ld a,(0e530h)		;af82
	dec a			;af85
	ret nz			;af86
	ld a,(0e540h)		;af87
	dec a			;af8a
	ret z			;af8b
	dec a			;af8c
	ret z			;af8d
	ld hl,0e536h		;af8e
	ld a,(0e205h)		;af91   ; la Y en la pantalla de lo que se maneja
	add a,010h		;af94
	sub (hl)			;af96
	jr nc,L_AFA4		;af97
	neg		;af99
	cp 020h		;af9b
	ld a,001h		;af9d
	jr nc,L_AFAB		;af9f
	xor a			;afa1
	jr L_AFAB		;afa2
L_AFA4:
	cp 020h		;afa4
	ld a,002h		;afa6
	jr nc,L_AFAB		;afa8
	xor a			;afaa
L_AFAB:
	ld (0e532h),a		;afab
	ret			;afae
L_AFAF:
	ld a,(0e530h)		;afaf
	sub 002h		;afb2
	call 04060h		;afb4   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xafb7..0xafbd  (6 bytes)
DATA_AFB7:
	defb 0bdh,0afh,0d4h,0afh,0afh,0b0h	; afb7

; ======================================================================
; CODIGO 0xafbd..0xb0cb  (270 bytes)
; ======================================================================


L_AFBD:
	ld hl,0e533h		;afbd
	inc (hl)			;afc0
	ld a,(hl)			;afc1
	cp 070h		;afc2
	jr z,L_AFCB		;afc4
	rra			;afc6
	ret nc			;afc7
	jp 07d74h		;afc8   ; banco 1
L_AFCB:
	xor a			;afcb
	ld (0e533h),a		;afcc
L_AFCF:
	ld hl,0e530h		;afcf
	inc (hl)			;afd2
	ret			;afd3
L_AFD4:
	ld hl,0e533h		;afd4
	inc (hl)			;afd7
	ld a,(hl)			;afd8
	cp 090h		;afd9
	jr z,L_AFCF		;afdb
	bit 4,(hl)		;afdd
	jr z,L_B048		;afdf
	ld a,(0e0a1h)		;afe1   ; el DECORADO, de 0 a 9
	cp 002h		;afe4
	jr c,L_B018		;afe6
	ld de,0b0cbh		;afe8
	ld hl,02d98h		;afeb
	ld bc,00008h		;afee
	call 0428fh		;aff1   ; banco 0: copia_a_vram
	ld de,0b0d3h		;aff4
	ld hl,02e80h		;aff7
	ld bc,00008h		;affa
	call 0428fh		;affd   ; banco 0: copia_a_vram
	ld de,0b0ebh		;b000
	ld hl,00d98h		;b003
	ld bc,00008h		;b006
	call 0428fh		;b009   ; banco 0: copia_a_vram
	ld de,0b0f3h		;b00c
	ld hl,00e80h		;b00f
	ld bc,00008h		;b012
	jp 0428fh		;b015   ; banco 0: copia_a_vram
L_B018:
	ld de,0b0cbh		;b018
	ld hl,02d98h		;b01b
	ld bc,00008h		;b01e
	call 0428fh		;b021   ; banco 0: copia_a_vram
	ld de,0b0d3h		;b024
	ld hl,02e80h		;b027
	ld bc,00008h		;b02a
	call 0428fh		;b02d   ; banco 0: copia_a_vram
	ld de,0b10bh		;b030
	ld hl,00d98h		;b033
	ld bc,00008h		;b036
	call 0428fh		;b039   ; banco 0: copia_a_vram
	ld de,0b113h		;b03c
	ld hl,00e80h		;b03f
	ld bc,00008h		;b042
	jp 0428fh		;b045   ; banco 0: copia_a_vram
L_B048:
	ld a,(0e0a1h)		;b048   ; el DECORADO, de 0 a 9
	cp 002h		;b04b
	jr c,L_B07F		;b04d
	ld de,0b0dbh		;b04f
	ld hl,02d98h		;b052
	ld bc,00008h		;b055
	call 0428fh		;b058   ; banco 0: copia_a_vram
	ld de,0b0e3h		;b05b
	ld hl,02e80h		;b05e
	ld bc,00008h		;b061
	call 0428fh		;b064   ; banco 0: copia_a_vram
	ld de,0b0fbh		;b067
	ld hl,00d98h		;b06a
	ld bc,00008h		;b06d
	call 0428fh		;b070   ; banco 0: copia_a_vram
	ld de,0b103h		;b073
	ld hl,00e80h		;b076
	ld bc,00008h		;b079
	jp 0428fh		;b07c   ; banco 0: copia_a_vram
L_B07F:
	ld de,0b0dbh		;b07f
	ld hl,02d98h		;b082
	ld bc,00008h		;b085
	call 0428fh		;b088   ; banco 0: copia_a_vram
	ld de,0b0e3h		;b08b
	ld hl,02e80h		;b08e
	ld bc,00008h		;b091
	call 0428fh		;b094   ; banco 0: copia_a_vram
	ld de,0b11bh		;b097
	ld hl,00d98h		;b09a
	ld bc,00008h		;b09d
	call 0428fh		;b0a0   ; banco 0: copia_a_vram
	ld de,0b123h		;b0a3
	ld hl,00e80h		;b0a6
	ld bc,00008h		;b0a9
	jp 0428fh		;b0ac   ; banco 0: copia_a_vram
L_B0AF:
	ld a,(0e003h)		;b0af   ; el contador de cuadros
	and 007h		;b0b2
	ret nz			;b0b4
	ld hl,(0e538h)		;b0b5
	ld de,00020h		;b0b8
	add hl,de			;b0bb
	ld (0e538h),hl		;b0bc
	ld hl,0e531h		;b0bf
	inc (hl)			;b0c2
	ld a,(hl)			;b0c3
	sub 00ah		;b0c4
	ret nz			;b0c6
	ld (0e530h),a		;b0c7
	ret			;b0ca

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb0cb..0xb12b  (96 bytes)
DATA_B0CB:
	defb 03ch,07eh,0fbh,0f5h,0fbh,07eh,03ch,0efh,000h,000h,038h,06ch,05ch,038h,0d7h,0f7h	; b0cb  <~...~<...8l\8..
	defb 000h,000h,01ch,036h,03ah,01ch,0ebh,0efh,03ch,07eh,0dfh,0afh,0dfh,07eh,03ch,0f7h	; b0db  ...6:...<~...~<.
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,060h,066h,066h,0f6h,0f6h,0f6h,0f6h,060h,060h	; b0eb  .......`ff....``
	defb 066h,066h,0f6h,0f6h,0f6h,0f6h,060h,060h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,060h	; b0fb  ff....``.......`
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,040h,044h,044h,0f4h,0f4h,0f4h,0f4h,040h,040h	; b10b  .......@DD....@@
	defb 044h,044h,0f4h,0f4h,0f4h,0f4h,040h,040h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,040h	; b11b  DD....@@.......@

; ======================================================================
; CODIGO 0xb12b..0xb174  (73 bytes)
; ======================================================================


L_B12B:
	ld b,004h		;b12b
	ld hl,0e550h		;b12d
	ld de,0eea8h		;b130
L_B133:
	ld a,(hl)			;b133
	inc l			;b134
	dec a			;b135
	jr nz,L_B158		;b136
	inc l			;b138
	inc l			;b139
	ld a,(hl)			;b13a
	and a			;b13b
	jr nz,L_B155		;b13c
	dec l			;b13e
	dec l			;b13f
	ld a,(hl)			;b140
	add a,003h		;b141
	ld (hl),a			;b143
	cp 0a0h		;b144
	jr c,L_B158		;b146
	dec l			;b148
	inc (hl)			;b149
	inc l			;b14a
	ld a,0e0h		;b14b
	ld (de),a			;b14d
	ld a,01dh		;b14e
	call 0413ah		;b150   ; banco 0: pide_sonido_si_esta_activo
	jr L_B158		;b153
L_B155:
	dec (hl)			;b155
	dec l			;b156
	dec l			;b157
L_B158:
	ld a,007h		;b158
	call 04056h		;b15a   ; banco 0: a_mas_hl
	ld a,004h		;b15d
	call 0405bh		;b15f   ; banco 0: a_mas_de
	djnz L_B133		;b162
	ret			;b164
L_B165:
	ld hl,0b174h		;b165
	ld de,0e540h		;b168
	ld a,(de)			;b16b
	and a			;b16c
	ret nz			;b16d
	ld bc,00010h		;b16e
	ldir		;b171
	ret			;b173

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb174..0xb184  (16 bytes)
DATA_B174:
	defb 001h,000h,000h,000h,000h,000h,000h,0e0h,000h,000h,09ch,00ah,020h,000h,000h,000h	; b174  ............ ...

; ======================================================================
; CODIGO 0xb184..0xb18a  (6 bytes)
; ======================================================================


L_B184:
	ld a,(0e540h)		;b184
	call 04060h		;b187   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb18a..0xb194  (10 bytes)
DATA_B18A:
	defb 094h,0b1h,095h,0b1h,036h,0b2h,060h,0b2h,08ah,0b2h	; b18a  ....6.`...

; ======================================================================
; CODIGO 0xb194..0xb212  (126 bytes)
; ======================================================================


L_B194:
	ret			;b194
L_B195:
	ld a,(0e536h)		;b195
	ld c,a			;b198
	ld a,(0e532h)		;b199
	and a			;b19c
	ld b,0fah		;b19d
	jr z,L_B1A8		;b19f
	dec a			;b1a1
	ld b,0e4h		;b1a2
	jr z,L_B1A8		;b1a4
	ld b,010h		;b1a6
L_B1A8:
	ld a,c			;b1a8
	add a,b			;b1a9
	ld h,a			;b1aa
	ld l,000h		;b1ab
	ld (0e548h),hl		;b1ad
	ld hl,07c00h		;b1b0
	ld (0e546h),hl		;b1b3
	ld hl,0e54ch		;b1b6
	dec (hl)			;b1b9
	jr z,L_B1C8		;b1ba
	bit 3,(hl)		;b1bc
	ld a,0a4h		;b1be
	jr nz,L_B1C4		;b1c0
	ld a,0a8h		;b1c2
L_B1C4:
	ld (0e54ah),a		;b1c4
	ret			;b1c7
L_B1C8:
	ld hl,0e540h		;b1c8
	inc (hl)			;b1cb
	ld a,(0e532h)		;b1cc
	and a			;b1cf
	ld de,0b212h		;b1d0
	jr z,L_B1DE		;b1d3
	dec a			;b1d5
	ld de,0b21eh		;b1d6
	jr z,L_B1DE		;b1d9
	ld de,0b22ah		;b1db
L_B1DE:
	ld b,000h		;b1de
	ld hl,0e549h		;b1e0
	ld a,(0e205h)		;b1e3   ; la Y en la pantalla de lo que se maneja
	add a,010h		;b1e6
	sub (hl)			;b1e8
	jr nc,L_B1EE		;b1e9
	inc b			;b1eb
	neg		;b1ec
L_B1EE:
	cp 010h		;b1ee
	ld c,004h		;b1f0
	jr c,L_B1FB		;b1f2
	dec b			;b1f4
	ld c,000h		;b1f5
	jr z,L_B1FB		;b1f7
	ld c,008h		;b1f9
L_B1FB:
	ld a,c			;b1fb
	call 0405bh		;b1fc   ; banco 0: a_mas_de
	ex de,hl			;b1ff
	ld de,0e542h		;b200
	ld bc,00004h		;b203
	ldir		;b206
	ld a,0ach		;b208
	ld (0e54ah),a		;b20a
	ld a,01eh		;b20d
	jp 0413ah		;b20f   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb212..0xb236  (36 bytes)
DATA_B212:
	defb 06ah,000h,01eh,0ffh,06ah,000h,000h,000h,06ah,000h,0e2h,000h,06ah,000h,0d9h,0feh	; b212  j...j...j...j...
	defb 06ah,000h,01eh,0ffh,06ah,000h,000h,000h,06ah,000h,000h,000h,06ah,000h,0e2h,000h	; b222  j...j...j...j...
	defb 06ah,000h,027h,001h	; b232

; ======================================================================
; CODIGO 0xb236..0xb30b  (213 bytes)
; ======================================================================


L_B236:
	ld hl,0e542h		;b236
	ld e,(hl)			;b239
	inc l			;b23a
	ld d,(hl)			;b23b
	inc l			;b23c
	ld c,(hl)			;b23d
	inc l			;b23e
	ld b,(hl)			;b23f
	inc l			;b240
	ld a,e			;b241
	add a,(hl)			;b242
	ld (hl),a			;b243
	inc hl			;b244
	ld a,d			;b245
	adc a,(hl)			;b246
	ld (hl),a			;b247
	inc l			;b248
	ld a,c			;b249
	add a,(hl)			;b24a
	ld (hl),a			;b24b
	inc hl			;b24c
	ld a,b			;b24d
	adc a,(hl)			;b24e
	ld (hl),a			;b24f
	dec l			;b250
	dec l			;b251
	ld a,(hl)			;b252
	cp 088h		;b253
	ret c			;b255
	ld hl,0e540h		;b256
	inc (hl)			;b259
	ld a,0b0h		;b25a
	ld (0e54ah),a		;b25c
	ret			;b25f
L_B260:
	ld hl,0e542h		;b260
	ld e,(hl)			;b263
	inc l			;b264
	ld d,(hl)			;b265
	inc l			;b266
	ld c,(hl)			;b267
	inc l			;b268
	ld b,(hl)			;b269
	inc l			;b26a
	ld a,e			;b26b
	add a,(hl)			;b26c
	ld (hl),a			;b26d
	inc hl			;b26e
	ld a,d			;b26f
	adc a,(hl)			;b270
	ld (hl),a			;b271
	inc l			;b272
	ld a,c			;b273
	add a,(hl)			;b274
	ld (hl),a			;b275
	inc hl			;b276
	ld a,b			;b277
	adc a,(hl)			;b278
	ld (hl),a			;b279
	dec l			;b27a
	dec l			;b27b
	ld a,(hl)			;b27c
	cp 090h		;b27d
	ret c			;b27f
	ld hl,0e540h		;b280
	inc (hl)			;b283
	ld a,0b4h		;b284
	ld (0e54ah),a		;b286
	ret			;b289
L_B28A:
	ld hl,0e542h		;b28a
	ld e,(hl)			;b28d
	inc l			;b28e
	ld d,(hl)			;b28f
	inc l			;b290
	ld c,(hl)			;b291
	inc l			;b292
	ld b,(hl)			;b293
	inc l			;b294
	ld a,e			;b295
	add a,(hl)			;b296
	ld (hl),a			;b297
	inc hl			;b298
	ld a,d			;b299
	adc a,(hl)			;b29a
	ld (hl),a			;b29b
	inc l			;b29c
	ld a,c			;b29d
	add a,(hl)			;b29e
	ld (hl),a			;b29f
	inc hl			;b2a0
	ld a,b			;b2a1
	adc a,(hl)			;b2a2
	ld (hl),a			;b2a3
	cp 010h		;b2a4
	jr c,L_B2B2		;b2a6
	cp 0e0h		;b2a8
	jr nc,L_B2B2		;b2aa
	dec l			;b2ac
	dec l			;b2ad
	ld a,(hl)			;b2ae
	cp 0a8h		;b2af
	ret c			;b2b1
L_B2B2:
	ld hl,0e540h		;b2b2
	ld b,010h		;b2b5
	xor a			;b2b7
L_B2B8:
	ld (hl),a			;b2b8
	inc l			;b2b9
	djnz L_B2B8		;b2ba
	ld a,0e0h		;b2bc
	ld (0e547h),a		;b2be
	ret			;b2c1
L_B2C2:
	ld a,(0e547h)		;b2c2
	ld l,a			;b2c5
	ld a,(0e549h)		;b2c6
	ld h,a			;b2c9
	ld (0eef4h),hl		;b2ca
	ld a,(0e54ah)		;b2cd
	ld l,a			;b2d0
	ld a,(0e54bh)		;b2d1
	ld h,a			;b2d4
	ld (0eef6h),hl		;b2d5
	ret			;b2d8

; ----------------------------------------------------------------------
; CHOCAR CON LO QUE HAY EN 0xE0C0. El rectangulo es de 0x24 de ancho por 0x20 de alto, con margen de 0x1C y 0x18. Y hay TRES pasos de transicion en los que no se choca -el 3, el 8 y el 10-, que son en los que el juego esta cambiando de escena.
; ----------------------------------------------------------------------
choca_con_lo_de_0xE0C0:
	ld a,(0e0c0h)		;b2d9   ; ¿hay algo de eso puesto?
	and a			;b2dc
	ret z			;b2dd   ; si no, no hay con que chocar
	ld a,(0e203h)		;b2de   ; el paso de la transicion
	cp 003h		;b2e1   ; en el 3...
	ret z			;b2e3
	cp 008h		;b2e4   ; ...en el 8...
	ret z			;b2e6
	cp 00ah		;b2e7   ; ...y en el 10 no se choca
	ret z			;b2e9
	ld hl,(0e204h)		;b2ea   ; la posicion de lo que se maneja
	ld de,(0e0c3h)		;b2ed   ; y la del objeto
	ld a,l			;b2f1
	add a,01ch		;b2f2   ; el margen en X
	sub e			;b2f4   ; menos la del objeto
	cp 024h		;b2f5   ; ¿cabe en los 0x24 de ancho?
	ret nc			;b2f7   ; si no, no se han tocado
	ld a,h			;b2f8
	add a,018h		;b2f9   ; y ahora el margen en Y
	sub d			;b2fb
	cp 020h		;b2fc   ; ¿cabe en los 0x20 de alto?
	ret nc			;b2fe
	ld a,(0e0c0h)		;b2ff   ; que era lo que habia
	push af			;b302
	call quita_lo_de_0xE0C0		;b303   ; se quita de en medio
	pop af			;b306
	dec a			;b307   ; y se despacha por lo que era
	call 04060h		;b308   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS que_pasa_al_cogerlo: Las cuatro cosas que puede haber en 0xE0C0, con
;   lo que hace cada una: 0xB313 da puntos, 0xB31E ALARGA la fase, 0xB331 y
;   0xB35E arrancan sendos movimientos.
;   0xb30b..0xb313  (8 bytes)
DATA_que_pasa_al_cogerlo:
	defw 0b313h	; b30b  -> coger_da_puntos
	defw 0b31eh	; b30d  -> coger_alarga_la_fase
	defw 0b331h	; b30f  -> coger_arranca_el_movimiento
	defw 0b35eh	; b311  -> coger_arranca_el_otro

; ======================================================================
; CODIGO 0xb313..0xb534  (545 bytes)
; ======================================================================


coger_da_puntos:
	ld a,026h		;b313   ; el efecto 0x26
	call 0413ah		;b315   ; banco 0: pide_sonido_si_esta_activo
	ld de,01000h		;b318   ; 0x1000 puntos
	jp 09367h		;b31b   ; y a sumarlos, en el banco 2

; ----------------------------------------------------------------------
; COGER ESTO ALARGA LA FASE. Le suma 0x50 EN BCD al largo, o sea que la meta se va mas lejos. Es la unica cosa de todo el cartucho que toca 0xE08B despues de montada la fase.
; ----------------------------------------------------------------------
coger_alarga_la_fase:
	ld hl,(0e08bh)		;b31e   ; el largo de la fase
	ld a,050h		;b321   ; 0x50 mas
	add a,l			;b323
	daa			;b324   ; en BCD
	ld l,a			;b325
	jr nc,L_B329		;b326   ; con su acarreo al byte alto
	inc h			;b328
L_B329:
	ld (0e08bh),hl		;b329   ; y guardado
	ld a,027h		;b32c   ; el efecto 0x27
	jp 0413ah		;b32e   ; banco 0: pide_sonido_si_esta_activo
coger_arranca_el_movimiento:
	call 058b1h		;b331
	ld a,070h		;b334   ; se coloca en la columna 0x70
	ld (0e204h),a		;b336   ; la X en la pantalla de lo que se maneja
	ld a,00fh		;b339   ; el paso de la transicion, a 15
	ld (0e203h),a		;b33b   ; por donde va la rotacion de los sprites
	ld a,001h		;b33e
	ld (0e1f0h),a		;b340
	ld hl,00400h		;b343   ; una velocidad
	ld (0e1f4h),hl		;b346
	ld hl,00e70h		;b349   ; y los dos sprites, colocados
	ld (0ee92h),hl		;b34c
	ld l,074h		;b34f
	ld (0ee96h),hl		;b351
coger_suena_doble:
	ld a,028h		;b354   ; el efecto 0x28
	call 0413ah		;b356   ; banco 0: pide_sonido_si_esta_activo
	ld a,05ch		;b359   ; y detras el 0x5C
	jp 0413ah		;b35b   ; banco 0: pide_sonido_si_esta_activo
coger_arranca_el_otro:
	ld a,001h		;b35e
	ld (0e1f1h),a		;b360
	ld hl,00400h		;b363   ; su velocidad
	ld (0e1f2h),hl		;b366
	jr coger_suena_doble		;b369

; ----------------------------------------------------------------------
; CHOCAR CON LO QUE HAY EN 0xE0D7. La misma cuenta pero con otro objeto y un rectangulo un poco mas ancho -0x28 en vez de 0x24-, y con los mismos tres pasos de transicion exentos.
; ----------------------------------------------------------------------
choca_con_lo_de_0xE0D7:
	ld a,(0e0d7h)		;b36b   ; ¿hay algo?
	and a			;b36e
	ret z			;b36f
	ld a,(0e203h)		;b370   ; el paso de la transicion
	cp 003h		;b373   ; el 3...
	ret z			;b375
	cp 008h		;b376   ; ...el 8...
	ret z			;b378
	cp 00ah		;b379   ; ...y el 10 no chocan
	ret z			;b37b
	ld hl,(0e204h)		;b37c   ; la posicion de lo que se maneja
	ld de,(0e0dah)		;b37f   ; y la del objeto
	ld a,l			;b383
	add a,01ch		;b384   ; el margen en X
	sub e			;b386
	cp 028h		;b387   ; 0x28 de ancho
	ret nc			;b389
	ld a,h			;b38a
	add a,018h		;b38b   ; el margen en Y
	sub d			;b38d
	cp 020h		;b38e   ; y 0x20 de alto
	ret nc			;b390
	ld a,(0e0d7h)		;b391   ; lo que era
	ld c,a			;b394
	call L_BA2F		;b395
	ld a,024h		;b398   ; el efecto 0x24
	call 0413ah		;b39a   ; banco 0: pide_sonido_si_esta_activo
	jp L_BFAB		;b39d

; ----------------------------------------------------------------------
; CHOCAR CON EL QUE VUELA. El rectangulo mas grande de los tres -0x30 de ancho por 0x20 de alto- y el unico que acaba mal: pone el modo a 1, que es el de perder, y deja un aviso de 2 para que la maquina de estados se salte dos estados.
; ----------------------------------------------------------------------
choca_con_el_que_vuela:
	ld a,(0e0bdh)		;b3a0   ; ¿esta en pantalla?
	and a			;b3a3
	ret z			;b3a4
	ld a,(0e203h)		;b3a5   ; el paso de la transicion
	cp 003h		;b3a8
	ret z			;b3aa
	cp 008h		;b3ab
	ret z			;b3ad
	cp 00ah		;b3ae
	ret z			;b3b0
	ld hl,(0e204h)		;b3b1   ; la posicion de lo que se maneja
	ld de,(0e0bbh)		;b3b4   ; y la del que vuela
	ld a,l			;b3b8
	add a,020h		;b3b9   ; el margen en X
	sub e			;b3bb
	cp 030h		;b3bc   ; 0x30 de ancho: el mas ancho de los tres
	ret nc			;b3be
	ld a,h			;b3bf
	add a,020h		;b3c0   ; el margen en Y
	sub d			;b3c2
	cp 020h		;b3c3   ; y 0x20 de alto
	ret nc			;b3c5
	call el_que_vuela_se_va		;b3c6   ; el que vuela se va
	xor a			;b3c9
	ld (0e1f1h),a		;b3ca
	ld (0e1f2h),a		;b3cd
	inc a			;b3d0
	ld (0e0a2h),a		;b3d1   ; modo 1: se ha perdido
	inc a			;b3d4
	ld (0e096h),a		;b3d5   ; y un aviso de 2
	ld a,(0e0adh)		;b3d8
	ld (0e0a3h),a		;b3db   ; por que vuelta va
	ld a,010h		;b3de
	ld (0e203h),a		;b3e0   ; el paso de la transicion, a 16
	ret			;b3e3

; ----------------------------------------------------------------------
; RECOGER. Los tres huecos de 0xE3A0, de dieciseis bytes cada uno, y una cuenta distinta de las de arriba: aqui no hay rectangulo fijo, el alto que se admite DEPENDE de lo lejos que este -0xB41C dobla la diferencia en X y se la suma al margen-, que es lo que hace que valga tocarlo tanto de cerca como de lejos. Recoger da un punto de los de uno en uno y 0x10 de los de golpe, y suena el efecto 0x0C.
; ----------------------------------------------------------------------
recoger:
	ld a,(0e203h)		;b3e4   ; el paso de la transicion
	cp 003h		;b3e7   ; el 3, el 4, el 8 y el 10 no cuentan
	ret z			;b3e9
	cp 004h		;b3ea
	ret z			;b3ec
	cp 008h		;b3ed
	ret z			;b3ef
	cp 00ah		;b3f0
	ret z			;b3f2
	ld ix,0e3a0h		;b3f3   ; los tres huecos
	ld b,003h		;b3f7   ; tres
recoger_mira_un_hueco:
	ld a,(ix+000h)		;b3f9   ; ¿hay algo?
	and a			;b3fc
	jp z,recoger_hueco_siguiente		;b3fd
	ld a,(ix+002h)		;b400   ; y el segundo byte
	cp 010h		;b403   ; por debajo de 0x10 todavia no se puede coger
	jr c,recoger_hueco_siguiente		;b405
	ld e,(ix+003h)		;b407   ; su posicion
	ld d,(ix+004h)		;b40a
	ld hl,(0e204h)		;b40d   ; y la de lo que se maneja
	ld a,e			;b410
	sub l			;b411   ; la diferencia en X
	ld e,a			;b412
	sub 00ah		;b413   ; si esta a mas de diez, no
	jr nc,recoger_hueco_siguiente		;b415
	ld a,013h		;b417   ; y de ahi sale el margen en Y...
	add a,e			;b419
	ld l,a			;b41a
	ld a,e			;b41b
	add a,a			;b41c   ; ...doblando la diferencia en X: cuanto mas lejos, mas se perdona
	add a,017h		;b41d
	ld e,a			;b41f
	ld a,d			;b420
	sub h			;b421   ; la diferencia en Y
	sub l			;b422
	add a,e			;b423
	jr nc,recoger_hueco_siguiente		;b424   ; y si se pasa, no se ha cogido
	ld a,(0e089h)		;b426   ; el marcador
	add a,001h		;b429   ; un punto mas, EN BCD
	daa			;b42b
	ld (0e089h),a		;b42c   ; el marcador, cifras bajas (BCD)
	jr nc,recoger_descuenta		;b42f
	ld a,(0e08ah)		;b431   ; y la cifra alta con su acarreo
	add a,001h		;b434
	daa			;b436
	ld (0e08ah),a		;b437   ; el marcador, cifra alta (BCD)
	cp 010h		;b43a   ; al llegar a 0x10...
	jr nz,recoger_descuenta		;b43c
	ld hl,00999h		;b43e   ; ...el marcador se queda en su tope
	ld (0e089h),hl		;b441   ; el marcador, cifras bajas (BCD)
recoger_descuenta:
	ld a,(0e203h)		;b444   ; el paso de la transicion
	cp 001h		;b447   ; en cuatro de ellos -1, 2, 6 y 7-...
	jr z,L_B457		;b449
	cp 002h		;b44b
	jr z,L_B457		;b44d
	cp 006h		;b44f
	jr z,L_B457		;b451
	cp 007h		;b453
	jr nz,recoger_suena_y_borra		;b455
L_B457:
	ld hl,0e111h		;b457   ; ...se descuenta uno de 0xE111
	dec (hl)			;b45a
recoger_suena_y_borra:
	push bc			;b45b
	ld a,(0e002h)		;b45c   ; las banderas de la partida
	and 040h		;b45f   ; el bit 6, el del sonido
	call nz,0947bh		;b461
	ld de,00010h		;b464   ; 0x10 puntos mas
	call 09367h		;b467   ; sumados en el banco 2
	pop bc			;b46a
	ld a,00ch		;b46b   ; el efecto 0x0C
	call 04145h		;b46d   ; banco 0: pide_sonido
	push ix		;b470   ; el hueco
	pop hl			;b472
	ld c,010h		;b473   ; sus dieciseis bytes
	xor a			;b475
recoger_borra_el_hueco:
	ld (hl),a			;b476
	inc l			;b477
	dec c			;b478
	jr nz,recoger_borra_el_hueco		;b479
	ld (ix+003h),0e0h		;b47b   ; y los dos sprites, fuera de la pantalla
	ld (ix+007h),0e0h		;b47f
recoger_hueco_siguiente:
	ld de,00010h		;b483   ; dieciseis bytes al siguiente
	add ix,de		;b486
	dec b			;b488
	jp nz,recoger_mira_un_hueco		;b489
	ret			;b48c

; ----------------------------------------------------------------------
; LAS CUATRO RANURAS DE 0xE550. Ocho bytes cada una, y lo que cuenta es que las CUATRO lleguen a 5: mientras alguna no lo este, la rutina se vuelve. Cuando lo estan todas, se arranca lo que sea que se abre.
; ----------------------------------------------------------------------
mira_las_cuatro_ranuras:
	ld a,(0e205h)		;b48d   ; la Y de lo que se maneja
	ld c,a			;b490
	ld b,004h		;b491   ; cuatro ranuras
	ld hl,0e550h		;b493   ; y ahi estan
mira_una_ranura:
	ld a,(hl)			;b496   ; lo que tiene
	cp 005h		;b497   ; con un 5 ya esta llena
	ld a,008h		;b499   ; y el salto a la siguiente es de ocho
	jr z,ranura_siguiente		;b49b
	inc l			;b49d
	inc l			;b49e
	ld a,(hl)			;b49f   ; su altura
	sub c			;b4a0   ; menos la de lo que se maneja
	jr c,ranura_siguiente_seis		;b4a1
	cp 018h		;b4a3   ; si no cae dentro de 0x18, no
	jr nc,ranura_siguiente_seis		;b4a5
	dec l			;b4a7
	dec l			;b4a8
	inc (hl)			;b4a9   ; y si cae, la ranura sube uno
	ld a,01ch		;b4aa   ; el efecto 0x1C
	call 0413ah		;b4ac   ; banco 0: pide_sonido_si_esta_activo
	jr ranura_siguiente		;b4af
ranura_siguiente_seis:
	ld a,006h		;b4b1   ; aqui el salto es de seis
ranura_siguiente:
	call 04056h		;b4b3   ; banco 0: a_mas_hl
	djnz mira_una_ranura		;b4b6
	ld hl,0e550h		;b4b8
	ld b,004h		;b4bb
mira_si_estan_las_cuatro:
	ld a,(hl)			;b4bd   ; la ranura
	cp 005h		;b4be   ; con menos de 5 no estan todas
	ret nz			;b4c0
	ld a,008h		;b4c1   ; ocho bytes a la siguiente
	call 04056h		;b4c3   ; banco 0: a_mas_hl
	djnz mira_si_estan_las_cuatro		;b4c6
	call 07c9fh		;b4c8   ; y con las cuatro llenas, esto
	ld hl,0ae0ah		;b4cb
	ld (0e53ah),hl		;b4ce
	ld a,002h		;b4d1
	ld (0e530h),a		;b4d3   ; lo que abre queda en marcha
	xor a			;b4d6
	ld (0e531h),a		;b4d7
	ld (0e532h),a		;b4da
	ld (0e533h),a		;b4dd
	call L_A8F5		;b4e0
	ld c,001h		;b4e3
	ld de,00000h		;b4e5
	jp 09369h		;b4e8   ; banco 2

; ----------------------------------------------------------------------
; ¿SALE EL BICHO QUE VUELA? Tres condiciones y todas tienen que darse: que la partida tenga puesto el bit 6 de sus banderas, que el juego este en el modo de jugar, y que se haya llegado a la distancia apuntada en 0xE0AB -que empieza a 0xFFFF, o sea "nunca"-. Y ademas solo en cuatro de los diez decorados.
; ----------------------------------------------------------------------
mira_si_sale_el_que_vuela:
	ld a,(0e002h)		;b4eb   ; las banderas de la partida
	and 040h		;b4ee   ; el bit 6
	ret z			;b4f0   ; sin el, no sale
	ld a,(0e0a2h)		;b4f1   ; el modo en el que esta el juego
	and a			;b4f4   ; y fuera del modo de jugar, tampoco
	ret nz			;b4f5
	ld hl,(0e0abh)		;b4f6   ; la distancia a la que le toca salir
	ld a,h			;b4f9
	inc a			;b4fa   ; 0xFFFF quiere decir que no sale nunca
	ret z			;b4fb
	ld de,(0e08dh)		;b4fc   ; la distancia a la que sale el objeto siguiente
	rst 20h			;b500   ; DCOMPR: ¿hemos llegado?
	ret nz			;b501
	ld hl,0ffffh		;b502   ; y una vez que sale, no vuelve a salir
	ld (0e0abh),hl		;b505
	ld a,(0e203h)		;b508   ; por donde va la rotacion de los sprites
	cp 001h		;b50b   ; solo en cuatro decorados: el 1, el 2, el 6 y el 7
	jr z,L_B51A		;b50d
	cp 002h		;b50f
	jr z,L_B51A		;b511
	cp 006h		;b513
	jr z,L_B51A		;b515
	cp 007h		;b517
	ret nz			;b519
L_B51A:
	ld a,(0e0c0h)		;b51a   ; si hay otra cosa ocupando, no
	and a			;b51d
	ret nz			;b51e
	ld a,(0e0d7h)		;b51f   ; ni si hay otra
	and a			;b522
	ret nz			;b523
	ld a,(0e0bdh)		;b524   ; ni si ya esta el mismo
	and a			;b527
	ret nz			;b528
	inc a			;b529   ; y si no, se enciende
	ld (0e0bdh),a		;b52a
	ret			;b52d

; ----------------------------------------------------------------------
; EL BICHO QUE VUELA, EN TRES TIEMPOS. Se despacha por 0xE0BD con el despachador de la casa: 0 no hace nada, 1 lo coloca y 2 lo mueve.
; ----------------------------------------------------------------------
el_que_vuela:
	ld a,(0e0bdh)		;b52e   ; en que tiempo va
	call 04060h		;b531   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS tiempos_del_que_vuela: Los tres destinos: 0xB558 -que es un `ret`-,
;   0xB53A y 0xB559.
;   0xb534..0xb53a  (6 bytes)
DATA_tiempos_del_que_vuela:
	defw 0b558h	; b534  -> el_que_vuela_quieto
	defw 0b53ah	; b536  -> el_que_vuela_aparece
	defw 0b559h	; b538  -> el_que_vuela_se_mueve

; ======================================================================
; CODIGO 0xb53a..0xb5c1  (135 bytes)
; ======================================================================


el_que_vuela_aparece:
	ld hl,0e0bdh		;b53a   ; el tiempo
	inc (hl)			;b53d   ; al siguiente
	ld l,068h		;b53e   ; la columna por la que entra
	ld a,(0e205h)		;b540   ; la Y en la pantalla de lo que se maneja
	cp 078h		;b543   ; y segun este arriba o abajo...
	ld h,0e8h		;b545   ; ...entra por abajo del todo...
	ld a,000h		;b547
	jr c,L_B54E		;b549
	ld h,008h		;b54b   ; ...o por arriba
	inc a			;b54d
L_B54E:
	ld (0e0bbh),hl		;b54e   ; su posicion
	ld (0e0bfh),a		;b551   ; y hacia donde va
	xor a			;b554
	ld (0e0beh),a		;b555   ; el paso del vaiven, a cero
el_que_vuela_quieto:
	ret			;b558

; ----------------------------------------------------------------------
; EL VAIVEN. La columna avanza siempre en la misma direccion, pero la fila sale de una tabla de 32 valores que se recorre en circulo: eso es lo que le da el vuelo ondulado. Y suena uno de cada ocho cuadros.
; ----------------------------------------------------------------------
el_que_vuela_se_mueve:
	ld a,(0e003h)		;b559   ; el contador de cuadros
	and 007h		;b55c   ; uno de cada ocho
	jr nz,L_B565		;b55e
	ld a,002h		;b560   ; el efecto 2
	call 0413ah		;b562   ; banco 0: pide_sonido_si_esta_activo
L_B565:
	ld a,(0e003h)		;b565   ; el contador de cuadros
	rra			;b568   ; y ahora uno de cada dos
	ret nc			;b569
	ld hl,0e0beh		;b56a   ; el paso del vaiven
	inc (hl)			;b56d   ; uno mas
	ld a,(hl)			;b56e
	and 01fh		;b56f   ; treinta y dos pasos, y vuelta a empezar
	ld hl,0b5c1h		;b571   ; la tabla del vaiven
	call 04056h		;b574   ; banco 0: a_mas_hl
	ld a,(hl)			;b577   ; el desplazamiento que toca
	ld hl,(0e0bbh)		;b578   ; su posicion
	add a,l			;b57b   ; sumado a la columna
	ld l,a			;b57c
	ld a,(0e0bfh)		;b57d   ; hacia donde va
	and 00fh		;b580
	ld c,0ffh		;b582   ; a la izquierda...
	jr z,L_B588		;b584
	ld c,001h		;b586   ; ...o a la derecha
L_B588:
	ld a,h			;b588
	add a,c			;b589   ; la fila, un paso
	ld h,a			;b58a
	cp 008h		;b58b   ; por arriba se sale
	jr c,el_que_vuela_se_va		;b58d
	cp 0e9h		;b58f   ; y por abajo tambien
	jr nc,el_que_vuela_se_va		;b591
	ld (0e0bbh),hl		;b593   ; la posicion nueva
	ld hl,(0e0bbh)		;b596
	ld (0ee98h),hl		;b599   ; y a su hueco de sprite, el 6
	ld a,(0e003h)		;b59c   ; el contador de cuadros
	and 008h		;b59f
	ld c,07ch		;b5a1   ; y el dibujo cambia cada ocho cuadros: eso son las alas
	jr z,L_B5A7		;b5a3
	ld c,080h		;b5a5
L_B5A7:
	ld a,c			;b5a7
	ld (0ee9ah),a		;b5a8   ; al color de su hueco de sprite
	ret			;b5ab
el_que_vuela_se_va:
	ld a,0e0h		;b5ac   ; 0xE0 en la Y: fuera de la pantalla
	ld (0ee98h),a		;b5ae
	ld l,a			;b5b1
	xor a			;b5b2
	ld h,a			;b5b3
	ld (0e0bbh),hl		;b5b4   ; y todo lo suyo, a cero
	ld (0e0bdh),a		;b5b7
	ld (0e0beh),a		;b5ba
	ld (0e0bfh),a		;b5bd
	ret			;b5c0

; ----------------------------------------------------------------------
; DATOS vaiven_del_que_vuela: Los treinta y dos pasos del vuelo: 0, 0, 1, 1,
;   2, 2, 2, 3, 3, 2, 2, 2, 1, 1, 0, 0 y los mismos en negativo. Sube y baja,
;   y por eso vuela ondulando en vez de en linea recta.
;   0xb5c1..0xb5e1  (32 bytes)
DATA_vaiven_del_que_vuela:
	defb 000h,000h,001h,001h,002h,002h,002h,003h,003h,002h,002h,002h,001h,001h,000h,000h	; b5c1  ................
	defb 000h,000h,0ffh,0ffh,0feh,0feh,0feh,0fdh,0fdh,0feh,0feh,0feh,0ffh,0ffh,000h,000h	; b5d1  ................

; ======================================================================
; CODIGO 0xb5e1..0xb635  (84 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; MONTAR LA FASE DE BONUS. Se reconoce por el decorado que pone: el 8, que es la Tierra vista desde el espacio. Borra 2.335 bytes de variables y los 672 de la zona de juego, se guarda el largo de la fase de verdad en 0xE0CC y lo cambia por uno de los diez de la tabla de 0xB635, que van de 0x85 a 0x40: cuanto mas veces se ha llegado aqui, mas corta es.
; ----------------------------------------------------------------------
monta_el_bonus:
	xor a			;b5e1
	ld hl,0e280h		;b5e2   ; las variables de 0xE280
	ld de,0e281h		;b5e5
	ld bc,0091fh		;b5e8   ; 2.335 bytes
	ld (hl),a			;b5eb
	ldir		;b5ec
	ld hl,0ebe0h		;b5ee   ; y la zona de juego
	ld de,0ebe1h		;b5f1
	ld bc,0029fh		;b5f4   ; 672 bytes: veintiuna filas
	ld (hl),a			;b5f7
	ldir		;b5f8
	ld (0e0d0h),a		;b5fa   ; lo que queda de bonus por pasar al marcador
	ld (0e0a6h),a		;b5fd
	ld a,008h		;b600   ; el decorado 8: la Tierra desde el espacio
	ld (0e0a1h),a		;b602   ; el DECORADO, de 0 a 9
	ld hl,(0e08bh)		;b605   ; el largo de la fase de verdad
	ld (0e0cch),hl		;b608   ; se guarda aparte, que luego hay que devolverlo
	ld a,(0e0a3h)		;b60b   ; cuantas veces se ha llegado al bonus
	ld hl,0b635h		;b60e   ; la tabla de largos
	call 04056h		;b611   ; banco 0: a_mas_hl
	ld e,(hl)			;b614
	inc hl			;b615
	ld d,000h		;b616
	ld (0e08bh),de		;b618   ; y ese es el largo del bonus
	ld hl,09000h		;b61c   ; 0x9000: una distancia a la que no se llega
	ld (0e08dh),hl		;b61f   ; asi no sale ningun enemigo
	call 0624ch		;b622   ; banco 1
	call 062b8h		;b625   ; banco 1
	xor a			;b628
	ld (0e403h),a		;b629
	call 06323h		;b62c   ; banco 1
	call 062efh		;b62f   ; banco 1
	jp 062e0h		;b632   ; banco 1

; ----------------------------------------------------------------------
; DATOS largos_del_bonus: Los diez largos de la fase de bonus, indexados por
;   0xE0A3: 0x85, 0x80, 0x75, 0x70, 0x65, 0x60, 0x55, 0x50, 0x45 y 0x40. Cada
;   vez que se vuelve, dura menos.
;   0xb635..0xb63f  (10 bytes)
DATA_largos_del_bonus:
	defb 085h,080h,075h,070h,065h,060h,055h,050h,045h,040h	; b635  ..upe`UPE@

; ======================================================================
; CODIGO 0xb63f..0xb645  (6 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LA CUENTA DEL BONUS, EN CINCO TIEMPOS. Escribe BONUS en la pantalla, va pasando el bonus al marcador de uno en uno con un pitido por cada punto, y cuando se acaba se vuelve. Los numeros van en BCD -de ahi los `daa`- y el marcador tiene tope: al llegar a 10 en la cifra alta se queda clavado en 0x0999.
; ----------------------------------------------------------------------
la_cuenta_del_bonus:
	ld a,(0e0ceh)		;b63f   ; en que tiempo va
	call 04060h		;b642   ; el despachador, con la tabla detras

; ----------------------------------------------------------------------
; DATOS tiempos_del_bonus: Los cinco: 0xB64F, 0xB65F, 0xB684, 0xB68E y 0xB6DF.
;   0xb645..0xb64f  (10 bytes)
DATA_tiempos_del_bonus:
	defw 0b64fh	; b645  -> bonus_escribe_el_rotulo
	defw 0b65fh	; b647  -> bonus_escribe_la_cifra
	defw 0b684h	; b649  -> bonus_espera
	defw 0b68eh	; b64b  -> bonus_lo_pasa_al_marcador
	defw 0b6dfh	; b64d  -> bonus_se_acabo

; ======================================================================
; CODIGO 0xb64f..0xb6e9  (154 bytes)
; ======================================================================


bonus_escribe_el_rotulo:
	ld de,0b6e9h		;b64f   ; el guion del rotulo
	call 042bch		;b652   ; banco 0: pinta_guion_con_mascara
	ld hl,0e0ceh		;b655   ; al tiempo siguiente
	inc (hl)			;b658
	ld a,030h		;b659   ; y 0x30 cuadros de espera
	ld (0e0cfh),a		;b65b
	ret			;b65e
bonus_escribe_la_cifra:
	ld hl,0e0cfh		;b65f   ; la espera
	dec (hl)			;b662
	ret nz			;b663   ; mientras dure, nada
	ld de,0b6f1h		;b664   ; el segundo guion
	call 042bch		;b667   ; banco 0: pinta_guion_con_mascara
	ld de,0e0d0h		;b66a   ; el bonus que hay
	ld hl,03911h		;b66d   ; donde va en la pantalla
	ld b,001h		;b670
	call 09417h		;b672   ; el pintor de cifras BCD del banco 2
	ld a,059h		;b675   ; el efecto 0x59
	call 0413ah		;b677   ; banco 0: pide_sonido_si_esta_activo
	ld hl,0e0ceh		;b67a
	inc (hl)			;b67d
	ld a,040h		;b67e   ; y 0x40 cuadros
	ld (0e0cfh),a		;b680
	ret			;b683
bonus_espera:
	ld hl,0e0cfh		;b684
	dec (hl)			;b687   ; la espera
	ret nz			;b688
	ld hl,0e0ceh		;b689
	inc (hl)			;b68c
	ret			;b68d
bonus_lo_pasa_al_marcador:
	ld a,(0e003h)		;b68e   ; el contador de cuadros
	and 003h		;b691   ; uno de cada cuatro
	ret nz			;b693
	ld a,(0e0d0h)		;b694   ; lo que queda de bonus
	and a			;b697   ; cuando se acaba, al tiempo siguiente
	jr z,bonus_acabado		;b698
	sub 001h		;b69a   ; uno menos, EN BCD
	daa			;b69c
	ld (0e0d0h),a		;b69d   ; lo que queda de bonus por pasar al marcador
	ld a,(0e089h)		;b6a0   ; el marcador
	add a,001h		;b6a3   ; uno mas, tambien en BCD
	daa			;b6a5
	ld (0e089h),a		;b6a6   ; el marcador, cifras bajas (BCD)
	jr nc,L_B6BC		;b6a9   ; y si se ha desbordado, la cifra alta
	ld a,(0e08ah)		;b6ab   ; el marcador, cifra alta (BCD)
	inc a			;b6ae   ; una mas
	ld (0e08ah),a		;b6af   ; el marcador, cifra alta (BCD)
	cp 00ah		;b6b2   ; al llegar a diez...
	jr c,L_B6BC		;b6b4
	ld hl,00999h		;b6b6   ; ...el marcador se queda clavado en su tope
	ld (0e089h),hl		;b6b9   ; el marcador, cifras bajas (BCD)
L_B6BC:
	ld de,00010h		;b6bc   ; donde va el marcador
	call 09367h		;b6bf   ; banco 2
	ld de,0e0d0h		;b6c2   ; y donde va el bonus
	ld hl,03911h		;b6c5
	ld b,001h		;b6c8
	call 09417h		;b6ca   ; repintados los dos
	call 0947bh		;b6cd   ; banco 2
	ld a,00ch		;b6d0   ; y un pitido por cada punto
	jp 0413ah		;b6d2   ; banco 0: pide_sonido_si_esta_activo
bonus_acabado:
	ld hl,0e0ceh		;b6d5
	inc (hl)			;b6d8   ; al ultimo tiempo
	ld a,040h		;b6d9   ; con 0x40 cuadros
	ld (0e0cfh),a		;b6db
	ret			;b6de
bonus_se_acabo:
	ld hl,0e0cfh		;b6df
	dec (hl)			;b6e2   ; la espera
	ret nz			;b6e3
	xor a			;b6e4   ; y se borran los avisos: se sigue jugando
	ld (0e096h),a		;b6e5   ; los avisos que deja el cuadro
	ret			;b6e8

; ----------------------------------------------------------------------
; DATOS rotulos_del_bonus: Dos guiones para el pintor con mascara, cada uno
;   con su destino de VRAM delante. El primero pone BONUS en 0x388D y el
;   segundo cuatro caracteres en 0x390C. Las letras van con el alfabeto del
;   cartucho, que empieza en 0x21 = A: 0x22 0x2F 0x2E 0x35 0x33 se leen B, O,
;   N, U y S.
;   0xb6e9..0xb6f8  (15 bytes)
DATA_rotulos_del_bonus:
	defw 0388dh	; b6e9
	defw 02f22h	; b6eb
	defw 0352eh	; b6ed
	defw 0ff33h	; b6ef
	defw 0390ch	; b6f1
	defw 01c1bh	; b6f3
	defw 01e00h	; b6f5
	defb 0ffh	; b6f7

; ======================================================================
; CODIGO 0xb6f8..0xb79b  (163 bytes)
; ======================================================================


L_B6F8:
	xor a			;b6f8
	ld hl,0e280h		;b6f9
	ld de,0e281h		;b6fc
	ld bc,0091fh		;b6ff
	ld (hl),a			;b702
	ldir		;b703
	ld hl,0ebe0h		;b705
	ld de,0ebe1h		;b708
	ld bc,0029fh		;b70b
	ld (hl),a			;b70e
	ldir		;b70f
	ld a,011h		;b711
	ld (0e203h),a		;b713   ; por donde va la rotacion de los sprites
	inc hl			;b716
	ld a,0f8h		;b717
	ld (0e204h),a		;b719   ; la X en la pantalla de lo que se maneja
	ld hl,(0e0cch)		;b71c
	ld (0e08bh),hl		;b71f   ; el largo de la fase
	ld a,(0e0a3h)		;b722
	ld l,a			;b725
	ld h,000h		;b726
	push hl			;b728
	add hl,hl			;b729
	add hl,hl			;b72a
	add hl,hl			;b72b
	add hl,hl			;b72c
	pop de			;b72d
	add hl,de			;b72e
	ld de,0b79bh		;b72f
	add hl,de			;b732
	ld e,(hl)			;b733
	inc hl			;b734
	ld d,(hl)			;b735
	ld (0e08dh),de		;b736   ; la distancia a la que sale el objeto siguiente
	inc hl			;b73a
	ld a,(hl)			;b73b
	ld (0e093h),a		;b73c   ; el valor 1-2-3 de la fase
	inc hl			;b73f
	ld a,(hl)			;b740
	ld (0e0a1h),a		;b741   ; el DECORADO, de 0 a 9
	inc hl			;b744
	ld a,(hl)			;b745
	ld (0e0b6h),a		;b746
	inc hl			;b749
	ld a,(hl)			;b74a
	ld (0e0a9h),a		;b74b
	inc hl			;b74e
	ld c,(hl)			;b74f
	xor a			;b750
	ld (0e0a6h),a		;b751
	inc hl			;b754
	ld e,(hl)			;b755
	inc hl			;b756
	ld d,(hl)			;b757
	ld (0e0a7h),de		;b758
	inc hl			;b75c
	ld a,(hl)			;b75d
	ld (0e404h),a		;b75e
	inc hl			;b761
	inc hl			;b762
	inc hl			;b763
	ld e,(hl)			;b764
	inc hl			;b765
	ld d,(hl)			;b766
	ld (0e301h),de		;b767   ; lo andado en la fase
	inc hl			;b76b
	ld a,(hl)			;b76c
	ld (0e300h),a		;b76d   ; por que pareja del guion de la fase va
	inc hl			;b770
	inc hl			;b771
	ld a,(hl)			;b772
	ld (0e0d4h),a		;b773
	xor a			;b776
	ld (0e0a2h),a		;b777   ; el modo en el que esta el juego
	ld (0e0a3h),a		;b77a
	ld (0e0a4h),a		;b77d
	ld (0e0b3h),a		;b780
	call 062adh		;b783   ; banco 1
	call 06737h		;b786   ; banco 1
	call 062cbh		;b789   ; banco 1
	call 06323h		;b78c   ; banco 1
	call 06370h		;b78f   ; banco 1
	call 063fdh		;b792   ; banco 1
	call 063bch		;b795   ; banco 1
	jp 07db3h		;b798   ; banco 1

; ----------------------------------------------------------------------
; DATOS sin identificar  0xb79b..0xb8ab  (272 bytes)
DATA_B79B:
	defb 070h,002h,001h,003h,002h,000h,000h,0ffh,0ffh,003h,000h,000h,0ffh,0ffh,000h,000h	; b79b  p...............
	defb 002h,060h,002h,003h,000h,003h,002h,000h,036h,002h,005h,000h,000h,050h,002h,012h	; b7ab  .`......6....P..
	defb 000h,002h,095h,002h,001h,000h,001h,004h,000h,010h,002h,005h,000h,000h,090h,002h	; b7bb  ................
	defb 013h,000h,001h,095h,000h,003h,001h,003h,004h,000h,0ffh,0ffh,006h,000h,000h,090h	; b7cb  ................
	defb 000h,01eh,000h,003h,090h,000h,002h,005h,000h,008h,000h,0ffh,0ffh,006h,000h,000h	; b7db  ................
	defb 0ffh,0ffh,01eh,000h,003h,090h,003h,003h,000h,003h,004h,000h,080h,003h,005h,000h	; b7eb  ................
	defb 000h,085h,003h,018h,000h,002h,070h,004h,002h,006h,000h,000h,000h,064h,004h,001h	; b7fb  ......p......d..
	defb 000h,000h,060h,004h,009h,000h,000h,080h,007h,001h,006h,000h,000h,000h,028h,007h	; b80b  ..`...........(.
	defb 003h,000h,000h,030h,007h,016h,000h,001h,050h,003h,002h,005h,000h,004h,000h,036h	; b81b  ...0....P......6
	defb 003h,003h,000h,000h,040h,003h,00dh,000h,002h,010h,004h,003h,002h,002h,00ah,000h	; b82b  ....@...........
	defb 032h,003h,009h,000h,000h,090h,003h,037h,000h,004h,080h,002h,003h,002h,002h,002h	; b83b  2......7........
	defb 005h,064h,002h,003h,0c6h,0e0h,070h,002h,012h,000h,002h,060h,005h,003h,001h,000h	; b84b  .d....p....`....
	defb 000h,003h,032h,005h,001h,0c7h,0e0h,050h,005h,002h,000h,001h,080h,008h,003h,000h	; b85b  ..2....P........
	defb 000h,000h,003h,000h,007h,000h,0c8h,0e0h,060h,007h,000h,000h,000h,025h,005h,003h	; b86b  ........`....%..
	defb 002h,000h,002h,002h,028h,003h,002h,0c9h,0e0h,000h,005h,014h,000h,002h,005h,008h	; b87b  ....(...........
	defb 003h,003h,001h,002h,003h,048h,007h,002h,0cah,0e0h,095h,007h,00ah,000h,001h,049h	; b88b  .....H.........I
	defb 010h,003h,002h,000h,004h,003h,042h,008h,003h,0cbh,0e0h,040h,010h,00dh,000h,001h	; b89b  ......B....@....

; ======================================================================
; CODIGO 0xb8ab..0xbaad  (514 bytes)
; ======================================================================


L_B8AB:
	ld hl,(0e0afh)		;b8ab
	ld a,h			;b8ae
	and l			;b8af
	cp 0ffh		;b8b0
	ret z			;b8b2
	ld de,(0e08dh)		;b8b3   ; la distancia a la que sale el objeto siguiente
	rst 20h			;b8b7
	ret nz			;b8b8
	ld hl,0e0b6h		;b8b9
	inc (hl)			;b8bc
	ld a,(0e0b2h)		;b8bd
	ld (0e0b3h),a		;b8c0
	ld c,a			;b8c3
	ld a,(0e166h)		;b8c4
	and a			;b8c7
	jr z,L_B8D4		;b8c8
	ld a,c			;b8ca
	cp 002h		;b8cb
	jr nz,L_B8D4		;b8cd
	ld a,031h		;b8cf
	call 0413ah		;b8d1   ; banco 0: pide_sonido_si_esta_activo
L_B8D4:
	ld a,(0e0b1h)		;b8d4
	ld (0e0bah),a		;b8d7
	jp 06370h		;b8da   ; banco 1
L_B8DD:
	xor a			;b8dd
	ld hl,0e1f0h		;b8de
	ld de,0e1f1h		;b8e1
	ld bc,00010h		;b8e4
	ld (hl),a			;b8e7
	ldir		;b8e8
	ld hl,0e280h		;b8ea
	ld de,0e281h		;b8ed
	ld bc,0091fh		;b8f0
	ld (hl),a			;b8f3
	ldir		;b8f4
	ld hl,0ebe0h		;b8f6
	ld de,0ebe1h		;b8f9
	ld bc,0029fh		;b8fc
	ld (hl),a			;b8ff
	ldir		;b900
	ld (0e0bdh),a		;b902
	ld (0e0bbh),a		;b905
	ld (0e0bch),a		;b908
	ld (0e0beh),a		;b90b
	ld (0e0bfh),a		;b90e
	ld (0e0c0h),a		;b911
	ld (0e0c1h),a		;b914
	ld (0e0c2h),a		;b917
	ld (0e0c3h),a		;b91a
	ld (0e0c4h),a		;b91d
	ld (0e0d7h),a		;b920
	ld (0e0d8h),a		;b923
	ld (0e0d9h),a		;b926
	ld (0e0dah),a		;b929
	ld (0e0dbh),a		;b92c
	ld (0e0a6h),a		;b92f
	ld a,009h		;b932
	ld (0e0a1h),a		;b934   ; el DECORADO, de 0 a 9
	ld hl,070f8h		;b937
	ld (0e204h),hl		;b93a   ; la X en la pantalla de lo que se maneja
	ld de,00150h		;b93d
	ld (0e08dh),de		;b940   ; la distancia a la que sale el objeto siguiente
	call 062b8h		;b944   ; banco 1
	jp 06323h		;b947   ; banco 1
L_B94A:
	xor a			;b94a
	ld hl,0e280h		;b94b
	ld de,0e281h		;b94e
	ld bc,0091fh		;b951
	ld (hl),a			;b954
	ldir		;b955
	ld hl,0ebe0h		;b957
	ld de,0ebe1h		;b95a
	ld bc,0029fh		;b95d
	ld (hl),a			;b960
	ldir		;b961
	ld a,(0e0a3h)		;b963
	ld l,a			;b966
	ld h,000h		;b967
	push hl			;b969
	add hl,hl			;b96a
	add hl,hl			;b96b
	add hl,hl			;b96c
	add hl,hl			;b96d
	pop de			;b96e
	add hl,de			;b96f
	ld de,0b79bh		;b970
	add hl,de			;b973
	ld e,(hl)			;b974
	inc hl			;b975
	ld d,(hl)			;b976
	ld (0e08dh),de		;b977   ; la distancia a la que sale el objeto siguiente
	inc hl			;b97b
	ld a,003h		;b97c
	ld (0e093h),a		;b97e   ; el valor 1-2-3 de la fase
	inc hl			;b981
	ld a,(hl)			;b982
	ld (0e0a1h),a		;b983   ; el DECORADO, de 0 a 9
	inc hl			;b986
	ld a,(hl)			;b987
	ld (0e0b6h),a		;b988
	inc hl			;b98b
	ld a,(hl)			;b98c
	ld (0e0a9h),a		;b98d
	inc hl			;b990
	ld c,(hl)			;b991
	ld a,(0e091h)		;b992   ; el numero de fase tal como se pinta
	add a,c			;b995
	daa			;b996
	ld (0e091h),a		;b997   ; el numero de fase tal como se pinta
	ld a,(0e092h)		;b99a   ; la FASE, de 1 a 13
	add a,c			;b99d
	ld (0e092h),a		;b99e   ; la FASE, de 1 a 13
	xor a			;b9a1
	ld (0e0a6h),a		;b9a2
	inc hl			;b9a5
	ld e,(hl)			;b9a6
	inc hl			;b9a7
	ld d,(hl)			;b9a8
	ld (0e0a7h),de		;b9a9
	inc hl			;b9ad
	ld a,(hl)			;b9ae
	ld (0e404h),a		;b9af
	inc hl			;b9b2
	ld e,(hl)			;b9b3
	inc hl			;b9b4
	ld d,(hl)			;b9b5
	ld a,001h		;b9b6
	ld (de),a			;b9b8
	inc hl			;b9b9
	ld e,(hl)			;b9ba
	inc hl			;b9bb
	ld d,(hl)			;b9bc
	ld (0e301h),de		;b9bd   ; lo andado en la fase
	inc hl			;b9c1
	ld a,(hl)			;b9c2
	ld (0e300h),a		;b9c3   ; por que pareja del guion de la fase va
	inc hl			;b9c6
	ld de,(0e08bh)		;b9c7   ; el largo de la fase
	ld a,(hl)			;b9cb
	and 0f0h		;b9cc
	add a,e			;b9ce
	daa			;b9cf
	ld e,a			;b9d0
	push af			;b9d1
	ld a,(hl)			;b9d2
	and 00fh		;b9d3
	add a,d			;b9d5
	daa			;b9d6
	ld d,a			;b9d7
	pop af			;b9d8
	jr nc,L_B9E0		;b9d9
	ld a,001h		;b9db
	add a,d			;b9dd
	daa			;b9de
	ld d,a			;b9df
L_B9E0:
	ld (0e08bh),de		;b9e0   ; el largo de la fase
	inc hl			;b9e4
	ld a,(hl)			;b9e5
	ld (0e0d4h),a		;b9e6
	xor a			;b9e9
	ld (0e0a2h),a		;b9ea   ; el modo en el que esta el juego
	ld (0e0a3h),a		;b9ed
	ld (0e0a4h),a		;b9f0
	ld (0e0b3h),a		;b9f3
	ld (0e0bah),a		;b9f6
	ld (0e166h),a		;b9f9
	ld (0e16ah),a		;b9fc
	ld (0e16bh),a		;b9ff
	ld c,006h		;ba02
	call L_BAA3		;ba04
	ld c,00ah		;ba07
	call L_BAA3		;ba09
	ld c,00bh		;ba0c
	call L_BAA3		;ba0e
	call 0624ch		;ba11   ; banco 1
	call 062adh		;ba14   ; banco 1
	call 06737h		;ba17   ; banco 1
	call 062cbh		;ba1a   ; banco 1
	call 06323h		;ba1d   ; banco 1
	call 06370h		;ba20   ; banco 1
	call 063fdh		;ba23   ; banco 1
	call 063bch		;ba26   ; banco 1
	call L_BE00		;ba29
	jp 07db3h		;ba2c   ; banco 1
L_BA2F:
	ld a,024h		;ba2f
	call 0413ah		;ba31   ; banco 0: pide_sonido_si_esta_activo
	ld a,c			;ba34
	ld hl,0babbh		;ba35
	call 04056h		;ba38   ; banco 0: a_mas_hl
	ld b,(hl)			;ba3b
	ld a,c			;ba3c
	ld hl,0e160h		;ba3d
	call 04056h		;ba40   ; banco 0: a_mas_hl
	ld (hl),b			;ba43
	ex de,hl			;ba44
L_BA45:
	ld a,c			;ba45
	sub 003h		;ba46
	jr c,L_BA78		;ba48
	cp 00ah		;ba4a
	jr nc,L_BA78		;ba4c
	cp 004h		;ba4e
	jr c,L_BA58		;ba50
	cp 007h		;ba52
	jr c,L_BA78		;ba54
	sub 003h		;ba56
L_BA58:
	ld hl,0baadh		;ba58
	call 04055h		;ba5b   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;ba5e
	inc hl			;ba5f
	ld h,(hl)			;ba60
	ld l,a			;ba61
	ld a,(de)			;ba62
	and a			;ba63
	jp z,06da2h		;ba64
L_BA67:
	ld a,c			;ba67
	cp 0ffh		;ba68
	jp z,06da2h		;ba6a
	ld a,0b2h		;ba6d
	sla c		;ba6f
	sla c		;ba71
	add a,c			;ba73
	ld c,a			;ba74
	jp 06d7ch		;ba75   ; banco 1
L_BA78:
	ld hl,03830h		;ba78
	push hl			;ba7b
	push bc			;ba7c
	ld c,002h		;ba7d
	ld hl,0383bh		;ba7f
	ld de,0383dh		;ba82
L_BA85:
	ld b,00ch		;ba85
L_BA87:
	call 0004ah		;ba87   ; BIOS RDVRM - Reads the content of VRAM
	ex de,hl			;ba8a
	call 06fb8h		;ba8b   ; banco 1
	call 0004dh		;ba8e   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;ba91
	dec de			;ba92
	dec hl			;ba93
	djnz L_BA87		;ba94
	ld hl,0385bh		;ba96
	ld de,0385dh		;ba99
	dec c			;ba9c
	jr nz,L_BA85		;ba9d
	pop bc			;ba9f
	pop hl			;baa0
	jr L_BA67		;baa1
L_BAA3:
	ld a,c			;baa3
	ld de,0e160h		;baa4
	call 0405bh		;baa7   ; banco 0: a_mas_de
	jp L_BA45		;baaa

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbaad..0xbace  (33 bytes)
DATA_BAAD:
	defb 022h,038h,024h,038h,026h,038h,028h,038h,02ah,038h,02ch,038h,02eh,038h,001h,001h	; baad  "8$8&8(8*8,8.8..
	defb 001h,003h,003h,003h,001h,001h,001h,001h,002h,002h,001h,001h,001h,001h,001h,001h	; babd  ................
	defb 001h	; bacd

; ======================================================================
; CODIGO 0xbace..0xbbd2  (260 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LO QUE SOLO SALE EN EL DECORADO 7. La primera instruccion lo dice todo: si (0xE0A1) no es 7, esta rutina se va sin hacer nada. Se dispara cuando lo que se maneja pasa de la columna 0x48, y a partir de ahi va bajando por su cuenta durante 0x40 cuadros, cambiando de dibujo cada cuatro.
; ----------------------------------------------------------------------
lo_del_decorado_7:
	ld a,(0e0a1h)		;bace   ; el decorado
	cp 007h		;bad1   ; solo el 7
	jr nz,lo_del_decorado_7_se_va		;bad3
	ld a,(0e216h)		;bad5   ; ¿ya esta en marcha?
	and a			;bad8
	jr z,lo_del_decorado_7_arranca		;bad9
	ld hl,0e218h		;badb   ; el contador
	inc (hl)			;bade
	ld a,(hl)			;badf
	cp 040h		;bae0   ; a los 0x40 cuadros se acaba
	jr z,lo_del_decorado_7_se_va		;bae2
	bit 2,a		;bae4   ; el bit 2: cambia de dibujo cada cuatro cuadros
	ld a,028h		;bae6
	jr nz,L_BAEC		;bae8
	ld a,02ch		;baea
L_BAEC:
	ld (0eec6h),a		;baec   ; el patron del sprite 17
	ld hl,0e219h		;baef   ; la fila
	dec (hl)			;baf2   ; que va bajando
	ld a,(hl)			;baf3
	ld (0eec4h),a		;baf4
	ret			;baf7
lo_del_decorado_7_arranca:
	ld a,(0e204h)		;baf8   ; la X de lo que se maneja
	cp 048h		;bafb   ; hasta la columna 0x48 no sale
	ret c			;bafd
	ld hl,0e217h		;bafe   ; cuantas veces ha salido
	inc (hl)			;bb01
	ld c,(hl)			;bb02
	ld a,001h		;bb03
	ld (0e216h),a		;bb05   ; y queda en marcha
	ld hl,(0e204h)		;bb08   ; su posicion sale de la del jugador
	ld a,l			;bb0b
	sub 010h		;bb0c   ; dieciseis a la izquierda
	ld l,a			;bb0e
	rr c		;bb0f   ; y una vez si y otra no...
	jr nc,lo_del_decorado_7_colocado		;bb11
	ld a,010h		;bb13   ; ...dieciseis mas abajo
	add a,h			;bb15
	ld h,a			;bb16
lo_del_decorado_7_colocado:
	ld (0e219h),hl		;bb17
	ld (0eec4h),hl		;bb1a   ; y al sprite
	ret			;bb1d
lo_del_decorado_7_se_va:
	ld a,0e0h		;bb1e   ; 0xE0: fuera de la pantalla
	ld (0eec4h),a		;bb20
	xor a			;bb23
	ld (0e216h),a		;bb24   ; y las dos banderas, a cero
	ld (0e218h),a		;bb27
	ret			;bb2a

; ----------------------------------------------------------------------
; SACAR LO DE 0xE0C0. Otra cosa que sale a una distancia apuntada, como los enemigos del banco 9, pero esta la lleva el banco 3 y solo sale si NO hay ya ninguna de las otras tres en pantalla -0xE0C0, 0xE0D7 y 0xE0BD-. Entra por arriba o por abajo segun donde este el jugador, igual que el que vuela.
; ----------------------------------------------------------------------
saca_lo_de_0xE0C0:
	ld hl,(0e0d5h)		;bb2b   ; la distancia a la que le toca
	ld a,h			;bb2e
	and l			;bb2f   ; 0xFFFF quiere decir nunca
	cp 0ffh		;bb30
	ret z			;bb32
	ld de,(0e08dh)		;bb33   ; lo andado
	rst 20h			;bb37   ; DCOMPR: ¿hemos llegado?
	ret nz			;bb38
	ld hl,0e0d4h		;bb39   ; cuantas veces ha salido
	inc (hl)			;bb3c
	ld a,(0e0c0h)		;bb3d   ; si ya hay una de estas...
	and a			;bb40
	jr nz,L_BB72		;bb41
	ld a,(0e0d7h)		;bb43   ; ...o una de las otras...
	and a			;bb46
	jr nz,L_BB72		;bb47
	ld a,(0e0bdh)		;bb49   ; ...o el que vuela, no sale
	and a			;bb4c
	jr nz,L_BB72		;bb4d
	ld l,06ch		;bb4f   ; la columna por la que entra
	ld a,(0e205h)		;bb51   ; la Y de lo que se maneja
	cp 070h		;bb54   ; y segun este arriba o abajo...
	ld h,0e8h		;bb56   ; ...entra por abajo...
	ld a,000h		;bb58
	jr c,L_BB5F		;bb5a
	ld h,008h		;bb5c   ; ...o por arriba
	inc a			;bb5e
L_BB5F:
	ld (0e0c3h),hl		;bb5f   ; su posicion
	ld (0e0c2h),a		;bb62
	xor a			;bb65
	ld (0e0c1h),a		;bb66
	inc a			;bb69
	ld (0e0c0h),a		;bb6a   ; y queda en marcha
	ld a,00dh		;bb6d   ; el dibujo, en el sprite 8
	ld (0eea3h),a		;bb6f
L_BB72:
	jp 063bch		;bb72   ; banco 1

; ----------------------------------------------------------------------
; MOVERLO. Usa LA MISMA tabla de vaiven que el que vuela -la de 0xB5C1-, o sea que los dos ondulan igual aunque sean cosas distintas. Lo unico propio es el dibujo, que sale de la tabla de cuatro de 0xBBD2.
; ----------------------------------------------------------------------
mueve_lo_de_0xE0C0:
	ld a,(0e0c0h)		;bb75   ; ¿esta en pantalla?
	and a			;bb78
	ret z			;bb79
	ld a,(0e003h)		;bb7a   ; el contador de cuadros
	rra			;bb7d   ; uno de cada dos
	ret nc			;bb7e
	ld hl,0e0c1h		;bb7f   ; el paso del vaiven
	inc (hl)			;bb82
	ld a,(hl)			;bb83
	and 01fh		;bb84   ; treinta y dos pasos
	ld hl,0b5c1h		;bb86   ; la MISMA tabla que el que vuela
	call 04056h		;bb89   ; banco 0: a_mas_hl
	ld a,(hl)			;bb8c
	ld hl,(0e0c3h)		;bb8d   ; su posicion
	add a,l			;bb90   ; mas el desplazamiento
	ld l,a			;bb91
	ld a,(0e0c2h)		;bb92   ; hacia donde va
	and 07fh		;bb95
	ld c,0ffh		;bb97   ; a la izquierda...
	jr z,L_BB9D		;bb99
	ld c,001h		;bb9b   ; ...o a la derecha
L_BB9D:
	ld a,h			;bb9d
	add a,c			;bb9e   ; la fila, un paso
	ld h,a			;bb9f
	cp 008h		;bba0   ; por arriba se sale
	jr c,quita_lo_de_0xE0C0		;bba2
	cp 0e9h		;bba4   ; y por abajo tambien
	jr nc,quita_lo_de_0xE0C0		;bba6
	ld (0e0c3h),hl		;bba8   ; la posicion nueva
	ld (0eea0h),hl		;bbab   ; y al sprite 8
	ld a,(0e0c0h)		;bbae   ; cual de las cuatro es
	dec a			;bbb1
	ld hl,0bbd2h		;bbb2   ; la tabla de dibujos
	call 04056h		;bbb5   ; banco 0: a_mas_hl
	ld a,(hl)			;bbb8
	ld (0eea3h),a		;bbb9   ; y al color del sprite
	ret			;bbbc
quita_lo_de_0xE0C0:
	ld a,0e0h		;bbbd   ; 0xE0: fuera de la pantalla
	ld (0eea0h),a		;bbbf
	ld l,a			;bbc2
	xor a			;bbc3
	ld h,a			;bbc4
	ld (0e0c3h),hl		;bbc5
	ld (0e0c0h),a		;bbc8   ; y todo lo suyo, a cero
	ld (0e0c1h),a		;bbcb
	ld (0e0c2h),a		;bbce
	ret			;bbd1

; ----------------------------------------------------------------------
; DATOS dibujos_de_lo_de_0xE0C0: Los cuatro dibujos: 0x0D, 0x03, 0x07 y 0x0A.
;   0xBBB2 elige con (0xE0C0), que es a la vez la bandera de "esta en
;   pantalla" y cual de los cuatro es.
;   0xbbd2..0xbbd6  (4 bytes)
DATA_dibujos_de_lo_de_0xE0C0:
	defb 00dh,003h,007h,00ah	; bbd2

; ======================================================================
; CODIGO 0xbbd6..0xbd08  (306 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; CAMBIARLO POR EL SIGUIENTE. Sube (0xE0C0) de uno en uno y al llegar a 5 vuelve al 1, o sea que los cuatro dan vueltas. Segun cual salga hace una cosa u otra, y el 2 depende ademas del decorado.
; ----------------------------------------------------------------------
cambia_lo_de_0xE0C0:
	ld a,(0e0c0h)		;bbd6   ; ¿hay alguno?
	and a			;bbd9
	ret z			;bbda
cambia_al_siguiente:
	inc a			;bbdb   ; el siguiente
	cp 005h		;bbdc   ; al llegar a 5...
	jr nz,cambia_despacha		;bbde
	ld a,001h		;bbe0   ; ...vuelve al 1
cambia_despacha:
	ld c,a			;bbe2   ; C se lo queda
	dec a			;bbe3   ; el 2...
	dec a			;bbe4
	jr z,cambia_a_uno_normal		;bbe5
	dec a			;bbe7   ; ...el 3...
	jr z,cambia_al_dos		;bbe8
	dec a			;bbea   ; ...y el 4 van por su lado
	jr z,L_BC0C		;bbeb
cambia_a_uno_normal:
	ld a,c			;bbed
	ld (0e0c0h),a		;bbee   ; el nuevo
	ld a,00dh		;bbf1   ; el efecto 0x0D
	jp 0413ah		;bbf3   ; banco 0: pide_sonido_si_esta_activo
cambia_al_dos:
	ld a,(0e0a1h)		;bbf6   ; el decorado
	cp 007h		;bbf9   ; en el 7, otra cosa
	jr z,L_BC09		;bbfb
	ld a,(0e1f1h)		;bbfd
	and a			;bc00
	jr nz,L_BC09		;bc01
	ld a,(0e1f0h)		;bc03
	and a			;bc06
	jr z,cambia_a_uno_normal		;bc07
L_BC09:
	ld a,c			;bc09
	jr cambia_al_siguiente		;bc0a
L_BC0C:
	ld a,(0e1f0h)		;bc0c
	and a			;bc0f
	jr nz,L_BC18		;bc10
	ld a,(0e1f1h)		;bc12
	and a			;bc15
	jr z,cambia_a_uno_normal		;bc16
L_BC18:
	ld a,c			;bc18
	jr cambia_al_siguiente		;bc19
L_BC1B:
	ld hl,0e440h		;bc1b
	ld b,005h		;bc1e
L_BC20:
	ld c,010h		;bc20
	ld a,(hl)			;bc22
	and a			;bc23
	jr z,L_BC43		;bc24
	dec c			;bc26
	inc l			;bc27
	ld a,(hl)			;bc28
	cp 003h		;bc29
	jr nc,L_BC43		;bc2b
	dec c			;bc2d
	inc l			;bc2e
	ld a,(hl)			;bc2f
	cp 007h		;bc30
	jr nz,L_BC43		;bc32
	dec c			;bc34
	inc l			;bc35
	ld a,(hl)			;bc36
	and a			;bc37
	jr z,L_BC43		;bc38
	ld (hl),000h		;bc3a
	push hl			;bc3c
	push bc			;bc3d
	call L_BC49		;bc3e
	pop bc			;bc41
	pop hl			;bc42
L_BC43:
	ld a,c			;bc43
	add a,l			;bc44
	ld l,a			;bc45
	djnz L_BC20		;bc46
	ret			;bc48
L_BC49:
	dec l			;bc49
	dec l			;bc4a
	dec l			;bc4b
	push hl			;bc4c
	pop ix		;bc4d
	ld hl,0e3a0h		;bc4f
	ld b,003h		;bc52
L_BC54:
	ld a,(hl)			;bc54
	and a			;bc55
	jr z,L_BC5F		;bc56
	ld a,010h		;bc58
	add a,l			;bc5a
	ld l,a			;bc5b
	djnz L_BC54		;bc5c
	ret			;bc5e
L_BC5F:
	ld (hl),001h		;bc5f
	inc l			;bc61
	ld a,(ix+001h)		;bc62
	dec a			;bc65
	ld de,06660h		;bc66
	ld a,(0e205h)		;bc69   ; la Y en la pantalla de lo que se maneja
	ld c,001h		;bc6c
	jr nz,L_BC77		;bc6e
	cp 046h		;bc70
	jr c,L_BC7E		;bc72
	inc c			;bc74
	jr L_BC7E		;bc75
L_BC77:
	cp 0aah		;bc77
	ld d,08ah		;bc79
	jr c,L_BC7E		;bc7b
	inc c			;bc7d
L_BC7E:
	ld (hl),c			;bc7e
	inc l			;bc7f
	ld (hl),000h		;bc80
	inc l			;bc82
	ld (hl),e			;bc83
	inc l			;bc84
	ld (hl),d			;bc85
	inc l			;bc86
	ld (hl),088h		;bc87
	inc l			;bc89
	ld a,(0e0a1h)		;bc8a   ; el DECORADO, de 0 a 9
	cp 002h		;bc8d
	ld (hl),006h		;bc8f
	jr c,L_BC95		;bc91
	ld (hl),00eh		;bc93
L_BC95:
	ld a,e			;bc95
	add a,010h		;bc96
	inc l			;bc98
	ld (hl),a			;bc99
	inc l			;bc9a
	ld (hl),d			;bc9b
	inc l			;bc9c
	ld (hl),040h		;bc9d
	ret			;bc9f
L_BCA0:
	ld a,(0e003h)		;bca0   ; el contador de cuadros
	rra			;bca3
	ret c			;bca4
	ld hl,0e3a0h		;bca5
	ld b,003h		;bca8
L_BCAA:
	ld a,(hl)			;bcaa
	dec a			;bcab
	ld a,010h		;bcac
	jr nz,L_BD03		;bcae
	inc l			;bcb0
	ld a,(hl)			;bcb1
	ld c,0feh		;bcb2
	dec a			;bcb4
	jr z,L_BCB9		;bcb5
	ld c,002h		;bcb7
L_BCB9:
	inc l			;bcb9
	inc (hl)			;bcba
	ld a,(hl)			;bcbb
	ld de,0bd08h		;bcbc
	call 0405bh		;bcbf   ; banco 0: a_mas_de
	ld a,(de)			;bcc2
	ld d,(hl)			;bcc3
	inc l			;bcc4
	add a,(hl)			;bcc5
	ld (hl),a			;bcc6
	ld e,a			;bcc7
	inc l			;bcc8
	ld a,(hl)			;bcc9
	add a,c			;bcca
	ld (hl),a			;bccb
	ld c,a			;bccc
	cp 008h		;bccd
	jr c,$+105		;bccf
	cp 0e9h		;bcd1
	jr nc,$+101		;bcd3
	ld a,e			;bcd5
	cp 0c1h		;bcd6
	jr nc,$+96		;bcd8
	inc l			;bcda
	ld a,d			;bcdb
	cp 00ch		;bcdc
	ld de,08840h		;bcde
	jr c,L_BCF4		;bce1
	cp 014h		;bce3
	ld de,08c44h		;bce5
	jr c,L_BCF4		;bce8
	cp 01ch		;bcea
	ld de,09048h		;bcec
	jr c,L_BCF4		;bcef
	ld de,09430h		;bcf1
L_BCF4:
	ld (hl),d			;bcf4
	inc l			;bcf5
	inc l			;bcf6
	inc (hl)			;bcf7
	inc (hl)			;bcf8
	inc l			;bcf9
	ld (hl),c			;bcfa
	inc l			;bcfb
	ld (hl),e			;bcfc
	ld a,l			;bcfd
	sub 005h		;bcfe
	ld l,a			;bd00
L_BD01:
	ld a,00ch		;bd01
L_BD03:
	add a,l			;bd03
	ld l,a			;bd04
	djnz L_BCAA		;bd05
	ret			;bd07

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbd08..0xbd38  (48 bytes)
DATA_BD08:
	defb 0fdh,0fdh,0fdh,0feh,0feh,0feh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd08  ................
	defb 000h,000h,000h,000h,003h,003h,003h,003h,005h,005h,005h,005h,007h,007h,007h,007h	; bd18  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; bd28  ................

; ======================================================================
; CODIGO 0xbd38..0xbe4d  (277 bytes)
; ======================================================================


L_BD38:
	push hl			;bd38
	ld a,l			;bd39
	sub 004h		;bd3a
	ld l,a			;bd3c
	ld c,010h		;bd3d
	xor a			;bd3f
	push hl			;bd40
	pop ix		;bd41
L_BD43:
	ld (hl),a			;bd43
	inc l			;bd44
	dec c			;bd45
	jr nz,L_BD43		;bd46
	ld (ix+003h),0e0h		;bd48
	ld (ix+007h),0e0h		;bd4c
	pop hl			;bd50
	jr $-80		;bd51
L_BD53:
	ld a,(0e0a1h)		;bd53   ; el DECORADO, de 0 a 9
	cp 008h		;bd56
	ret z			;bd58
	cp 009h		;bd59
	ret z			;bd5b
	ld de,0eeb8h		;bd5c
	ld hl,0e3a3h		;bd5f
	ld b,003h		;bd62
	ld c,0ffh		;bd64
L_BD66:
	ldi		;bd66
	ldi		;bd68
	ldi		;bd6a
	ldi		;bd6c
	ld a,00ch		;bd6e
	add a,l			;bd70
	ld l,a			;bd71
	djnz L_BD66		;bd72
	ld de,0eed0h		;bd74
	ld hl,0e3a7h		;bd77
	ld b,003h		;bd7a
L_BD7C:
	ldi		;bd7c
	ldi		;bd7e
	ldi		;bd80
	ld a,00dh		;bd82
	add a,l			;bd84
	ld l,a			;bd85
	inc e			;bd86
	djnz L_BD7C		;bd87
	ret			;bd89
L_BD8A:
	ld a,(0e162h)		;bd8a
	and a			;bd8d
	ret z			;bd8e
	ld a,(0e203h)		;bd8f   ; por donde va la rotacion de los sprites
	cp 003h		;bd92
	ret z			;bd94
	cp 004h		;bd95
	ret z			;bd97
	cp 008h		;bd98
	ret z			;bd9a
	cp 00ah		;bd9b
	ret z			;bd9d
	ld a,(0e006h)		;bd9e   ; las teclas recien pulsadas
	and 020h		;bda1
	ret z			;bda3
	ld hl,0e500h		;bda4
	ld a,(hl)			;bda7
	and a			;bda8
	ret nz			;bda9
	ld (hl),001h		;bdaa
	inc l			;bdac
	ld (hl),000h		;bdad
	inc l			;bdaf
	ld de,(0e204h)		;bdb0   ; la X en la pantalla de lo que se maneja
	ld a,e			;bdb4
	sub 00ah		;bdb5
	ld e,a			;bdb7
	ld a,008h		;bdb8
	add a,d			;bdba
	ld d,a			;bdbb
	ld (hl),e			;bdbc
	inc l			;bdbd
	ld (hl),d			;bdbe
	inc l			;bdbf
	ld (hl),034h		;bdc0
	inc l			;bdc2
	ld (hl),008h		;bdc3
	ld a,00ah		;bdc5
	jp 04145h		;bdc7   ; banco 0: pide_sonido
L_BDCA:
	ld hl,0e500h		;bdca
	ld a,(hl)			;bdcd
	and a			;bdce
	ret z			;bdcf
	inc l			;bdd0
	inc (hl)			;bdd1
	ld a,(hl)			;bdd2
	ld c,a			;bdd3
	cp 018h		;bdd4
	jr z,L_BDF0		;bdd6
	ld a,0ffh		;bdd8
	inc l			;bdda
	add a,(hl)			;bddb
	ld (hl),a			;bddc
	ld a,c			;bddd
	cp 008h		;bdde
	ld c,034h		;bde0
	jr c,L_BDEC		;bde2
	cp 010h		;bde4
	ld c,038h		;bde6
	jr c,L_BDEC		;bde8
	ld c,03ch		;bdea
L_BDEC:
	inc l			;bdec
	inc l			;bded
	ld (hl),c			;bdee
	ret			;bdef
L_BDF0:
	dec l			;bdf0
	ld b,010h		;bdf1
	xor a			;bdf3
	push hl			;bdf4
	pop ix		;bdf5
L_BDF7:
	ld (hl),a			;bdf7
	inc l			;bdf8
	djnz L_BDF7		;bdf9
	ld (ix+002h),0e0h		;bdfb
	ret			;bdff
L_BE00:
	xor a			;be00
	ld hl,0e110h		;be01
	ld de,0e111h		;be04
	ld bc,00005h		;be07
	ld (hl),a			;be0a
	ldir		;be0b
	ld (0e0c5h),a		;be0d
	ld (0e221h),a		;be10
	ld a,(0e092h)		;be13   ; la FASE, de 1 a 13
	ld hl,0e112h		;be16
	ld bc,00708h		;be19
	cp 003h		;be1c
	jr z,L_BE32		;be1e
	ld hl,0e111h		;be20
	ld bc,00005h		;be23
	cp 006h		;be26
	jr z,L_BE32		;be28
	ld hl,0e112h		;be2a
	ld c,0b4h		;be2d
	cp 00dh		;be2f
	ret nz			;be31
L_BE32:
	ld (hl),c			;be32
	inc hl			;be33
	ld (hl),b			;be34
	ld (0e116h),bc		;be35
	ret			;be39
L_BE3A:
	ld hl,(0e116h)		;be3a
	ld (0e112h),hl		;be3d
	ret			;be40
L_BE41:
	ld a,(0e115h)		;be41
	or a			;be44
	ret nz			;be45
	ld a,(0e092h)		;be46   ; la FASE, de 1 a 13
	dec a			;be49
	call 04060h		;be4a   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbe4d..0xbe7d  (48 bytes)
DATA_BE4D:
	defb 02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh,07dh,0beh,02bh,0bfh,02bh,0bfh	; be4d  +.+.+.+.+.}.+.+.
	defb 0a6h,0beh,02bh,0bfh,02bh,0bfh,02bh,0bfh,0c0h,0beh,0ech,0beh,02bh,0bfh,018h,0bfh	; be5d  ..+.+.+.....+...
	defb 02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh,02bh,0bfh	; be6d  +.+.+.+.+.+.+.+.

; ======================================================================
; CODIGO 0xbe7d..0xbf2c  (175 bytes)
; ======================================================================


L_BE7D:
	ld a,(0e167h)		;be7d
	and a			;be80
	jr nz,L_BE8A		;be81
	ld hl,(0e116h)		;be83
	ld (0e111h),hl		;be86
	ret			;be89
L_BE8A:
	ld de,0e111h		;be8a
	ld c,00dh		;be8d
	ld a,(de)			;be8f
	or a			;be90
	ret nz			;be91
L_BE92:
	ld hl,0e160h		;be92
	ld a,c			;be95
	call 04056h		;be96   ; banco 0: a_mas_hl
	ld a,(hl)			;be99
	and a			;be9a
	ret nz			;be9b
	ld hl,0e110h		;be9c
	ld (hl),c			;be9f
	ld hl,0e115h		;bea0
	ld (hl),001h		;bea3
	ret			;bea5
L_BEA6:
	ld c,011h		;bea6
	ld a,(0e203h)		;bea8   ; por donde va la rotacion de los sprites
	cp 010h		;beab
	jp nz,L_BF27		;bead
	ld a,(0e114h)		;beb0
	cp 00ah		;beb3
	jp z,L_BE92		;beb5
	ld a,(0e006h)		;beb8   ; las teclas recien pulsadas
	and 010h		;bebb
	ret z			;bebd
	jr L_BF13		;bebe
L_BEC0:
	ld a,(0e167h)		;bec0
	and a			;bec3
	ret z			;bec4
	ld hl,0e112h		;bec5
	ld c,00eh		;bec8
	ld a,(0e0a6h)		;beca
	cp 001h		;becd
	ld d,01ch		;becf
	jr z,L_BEE2		;bed1
	cp 002h		;bed3
	jp nz,L_BE3A		;bed5
	ld d,0c4h		;bed8
	ld a,(0e205h)		;beda   ; la Y en la pantalla de lo que se maneja
	cp d			;bedd
	ret c			;bede
	jp L_BEE7		;bedf
L_BEE2:
	ld a,(0e205h)		;bee2   ; la Y en la pantalla de lo que se maneja
	cp d			;bee5
	ret nc			;bee6
L_BEE7:
	dec (hl)			;bee7
	jp z,L_BE92		;bee8
	ret			;beeb
L_BEEC:
	ld a,(0e167h)		;beec
	and a			;beef
	ret z			;bef0
	ld a,(0e203h)		;bef1   ; por donde va la rotacion de los sprites
	cp 004h		;bef4
	jp nz,L_BF27		;bef6
	ld hl,0bf2ch		;bef9
	ld b,002h		;befc
	ld c,010h		;befe
L_BF00:
	ld a,(0e114h)		;bf00
	cp b			;bf03
	jp z,L_BE92		;bf04
	call 04056h		;bf07   ; banco 0: a_mas_hl
	ld d,(hl)			;bf0a
	ld a,(0e006h)		;bf0b   ; las teclas recien pulsadas
	and a			;bf0e
	ret z			;bf0f
	and d			;bf10
	jr z,L_BF27		;bf11
L_BF13:
	ld hl,0e114h		;bf13
	inc (hl)			;bf16
	ret			;bf17
L_BF18:
	ld a,(0e0a0h)		;bf18   ; la bandera de PAUSA
	and a			;bf1b
	jr z,L_BF27		;bf1c
	ld hl,0bf2eh		;bf1e
	ld b,004h		;bf21
	ld c,012h		;bf23
	jr L_BF00		;bf25
L_BF27:
	xor a			;bf27
	ld (0e114h),a		;bf28
L_BF2B:
	ret			;bf2b

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbf2c..0xbf32  (6 bytes)
DATA_BF2C:
	defb 004h,008h,001h,008h,002h,004h	; bf2c

; ======================================================================
; CODIGO 0xbf32..0xbfc0  (142 bytes)
; ======================================================================


L_BF32:
	ld a,(0e002h)		;bf32
	and 040h		;bf35
	ret z			;bf37
	ld a,(0e0a2h)		;bf38   ; el modo en el que esta el juego
	and a			;bf3b
	ret nz			;bf3c
	ld a,(0e110h)		;bf3d
	and a			;bf40
	ret z			;bf41
	ld a,(0e0c0h)		;bf42
	ld hl,0e0bdh		;bf45
	or (hl)			;bf48
	ret nz			;bf49
	ld l,06ch		;bf4a
	ld a,(0e205h)		;bf4c   ; la Y en la pantalla de lo que se maneja
	cp 070h		;bf4f
	ld h,0e8h		;bf51
	ld a,000h		;bf53
	jr c,L_BF5A		;bf55
	ld h,008h		;bf57
	inc a			;bf59
L_BF5A:
	ld (0e0dah),hl		;bf5a
	ld (0e0d9h),a		;bf5d
	ld a,(0e110h)		;bf60
	ld (0e0d7h),a		;bf63
	xor a			;bf66
	ld (0e0d8h),a		;bf67
	ld (0e110h),a		;bf6a
	ld a,022h		;bf6d
	jp 0413ah		;bf6f   ; banco 0: pide_sonido_si_esta_activo
L_BF72:
	ld a,(0e0d7h)		;bf72
	and a			;bf75
	ret z			;bf76
	ld a,(0e003h)		;bf77   ; el contador de cuadros
	rra			;bf7a
	ret nc			;bf7b
	ld hl,0e0d8h		;bf7c
	inc (hl)			;bf7f
	ld a,(hl)			;bf80
	and 01fh		;bf81
	ld hl,0b5c1h		;bf83
	call 04056h		;bf86   ; banco 0: a_mas_hl
	ld a,(hl)			;bf89
	ld hl,(0e0dah)		;bf8a
	add a,l			;bf8d
	ld l,a			;bf8e
	ld a,(0e0d9h)		;bf8f
	and a			;bf92
	ld c,0ffh		;bf93
	jr z,L_BF99		;bf95
	ld c,001h		;bf97
L_BF99:
	ld a,h			;bf99
	add a,c			;bf9a
	ld h,a			;bf9b
	cp 008h		;bf9c
	jr c,L_BFAB		;bf9e
	cp 0e9h		;bfa0
	jr nc,L_BFAB		;bfa2
	ld (0e0dah),hl		;bfa4
	ld (0eea4h),hl		;bfa7
	ret			;bfaa
L_BFAB:
	ld a,0e0h		;bfab
	ld (0eea4h),a		;bfad
	ld l,a			;bfb0
	xor a			;bfb1
	ld h,a			;bfb2
	ld (0e0dah),hl		;bfb3
	ld (0e0d7h),a		;bfb6
	ld (0e0d8h),a		;bfb9
	ld (0e0d9h),a		;bfbc
	ret			;bfbf

; ----------------------------------------------------------------------
; DATOS sin identificar  0xbfc0..0xc000  (64 bytes)
DATA_BFC0:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bah,0b1h,090h	; bfe0  ................
	defb 0ach,0b7h,09ch,0b7h,093h,080h,000h,087h,0a7h,081h,08fh,0a1h,0a4h,010h,043h,0aah	; bff0  ..............C.
