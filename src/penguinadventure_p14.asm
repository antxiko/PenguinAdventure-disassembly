; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 14 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x834e  (846 bytes)
; ======================================================================


L_8000:
	ld bc,00015h		;8000
	ldir		;8003
	ld c,a			;8005
	xor a			;8006
	ld (0e07ah),a		;8007
	ret			;800a
L_800B:
	inc hl			;800b
	ld a,(hl)			;800c
	or a			;800d
	jr z,L_8039		;800e
	ld a,(ix+00bh)		;8010
	inc a			;8013
	cp (hl)			;8014
	jr z,L_802A		;8015
	jp m,L_801B		;8017
	dec a			;801a
L_801B:
	ld (ix+00bh),a		;801b
	inc hl			;801e
	ld a,(hl)			;801f
	ld (ix+003h),a		;8020
	inc hl			;8023
	ld a,(hl)			;8024
	ld (ix+004h),a		;8025
	jr L_8033		;8028
L_802A:
	inc hl			;802a
	inc hl			;802b
	xor a			;802c
	ld (ix+00bh),a		;802d
L_8030:
	call L_8322		;8030
L_8033:
	inc (ix+000h)		;8033
	jp L_80D2		;8036
L_8039:
	ld a,(ix+00eh)		;8039
	or a			;803c
	jr z,L_8044		;803d
	dec (ix+00eh)		;803f
	jr L_8047		;8042
L_8044:
	inc (ix+00eh)		;8044
L_8047:
	jr L_8030		;8047
L_8049:
	ld a,(0e079h)		;8049
	ld e,a			;804c
	ld a,(ix+005h)		;804d
	and 003h		;8050
	ld d,a			;8052
	ld a,c			;8053
	cp 001h		;8054
	jr z,L_8059		;8056
	dec a			;8058
L_8059:
	ld b,a			;8059
	bit 1,d		;805a
	call z,L_807F		;805c
	bit 1,d		;805f
	call nz,L_807B		;8061
	ld a,b			;8064
	rlca			;8065
	rlca			;8066
	rlca			;8067
	bit 0,d		;8068
	call z,L_807F		;806a
	bit 0,d		;806d
	call nz,L_807B		;806f
L_8072:
	ld (0e079h),a		;8072
	ld e,a			;8075
	ld a,007h		;8076
	jp 00093h		;8078   ; BIOS WRTPSG - Writes data to PSG-register
L_807B:
	cpl			;807b
	and e			;807c
	ld e,a			;807d
	ret			;807e
L_807F:
	or e			;807f
	ld e,a			;8080
	ret			;8081
L_8082:
	ld a,(0e079h)		;8082
	call L_8072		;8085
	ld c,001h		;8088
	ld ix,0e010h		;808a
	exx			;808e
	ld b,004h		;808f
	ld de,00015h		;8091
L_8094:
	exx			;8094
	ld a,c			;8095
	cp 001h		;8096
	jr nz,L_80C5		;8098
	ld a,(0e07ah)		;809a
	or a			;809d
	jr z,L_80AA		;809e
	ld a,c			;80a0
	ld hl,0e064h		;80a1
	ld de,0e010h		;80a4
	call L_8000		;80a7
L_80AA:
	ld a,(ix+002h)		;80aa
	or a			;80ad
	jr nz,L_80BA		;80ae
	ld a,c			;80b0
	cp 007h		;80b1
	jr z,L_80B8		;80b3
	call L_817D		;80b5
L_80B8:
	jr L_80BD		;80b8
L_80BA:
	call L_80D2		;80ba
L_80BD:
	inc c			;80bd
	inc c			;80be
	exx			;80bf
	add ix,de		;80c0
	djnz L_8094		;80c2
	ret			;80c4
L_80C5:
	ld a,(0e0a0h)		;80c5
	or a			;80c8
	jr z,L_80AA		;80c9
	ld h,000h		;80cb
	call L_81BA		;80cd
	jr L_80BD		;80d0
L_80D2:
	ld a,(ix+00eh)		;80d2
	or a			;80d5
	jp nz,L_81EB		;80d6
	ld (ix+010h),000h		;80d9
	dec (ix+000h)		;80dd
	ret nz			;80e0
L_80E1:
	ld l,(ix+003h)		;80e1
	ld h,(ix+004h)		;80e4
	ld a,(hl)			;80e7
	cp 0feh		;80e8
	jp z,L_800B		;80ea
	jp nc,L_817D		;80ed
	ld a,(ix+00eh)		;80f0
	or a			;80f3
	ld a,(hl)			;80f4
	jp nz,L_820C		;80f5
L_80F8:
	and 0f0h		;80f8
	cp 020h		;80fa
	jr nz,L_8138		;80fc
	ld a,(hl)			;80fe
	ld (ix+005h),a		;80ff
	inc hl			;8102
	ld a,(ix+010h)		;8103
	or a			;8106
	ld a,(hl)			;8107
	jr nz,L_810D		;8108
	ld (ix+001h),a		;810a
L_810D:
	ld (ix+014h),a		;810d
	inc hl			;8110
	ld a,(ix+005h)		;8111
	cp 020h		;8114
	jr nz,L_8124		;8116
	dec hl			;8118
	xor a			;8119
	ld b,a			;811a
	ld a,(ix+010h)		;811b
	or a			;811e
	jp nz,L_833C		;811f
	jr L_8159		;8122
L_8124:
	bit 3,a		;8124
	jr z,L_8138		;8126
	ld a,(hl)			;8128
	ld e,a			;8129
	ld a,00ch		;812a
	call 00093h		;812c   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;812f
	ld a,(hl)			;8130
	ld e,a			;8131
	ld a,00bh		;8132
	call 00093h		;8134   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;8137
L_8138:
	ld a,(hl)			;8138
	and 0f0h		;8139
	cp 010h		;813b
	jr nz,L_814A		;813d
	ld a,(hl)			;813f
	and 00fh		;8140
	add a,a			;8142
	ld e,a			;8143
	ld a,006h		;8144
	call 00093h		;8146   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;8149
L_814A:
	ld a,(hl)			;814a
	and 0f0h		;814b
	ld b,a			;814d
	xor (hl)			;814e
	ld d,a			;814f
	inc hl			;8150
	ld e,(hl)			;8151
	ld a,(ix+010h)		;8152
	or a			;8155
	jp nz,L_833C		;8156
L_8159:
	call L_8322		;8159
L_815C:
	ex de,hl			;815c
	call L_82E4		;815d
	ld a,b			;8160
	rrca			;8161
	rrca			;8162
	rrca			;8163
	rrca			;8164
	ld h,a			;8165
	ld a,(ix+010h)		;8166
	or a			;8169
	jp z,L_8175		;816a
	ld a,(ix+014h)		;816d
	ld (ix+013h),a		;8170
	jr L_81BA		;8173
L_8175:
	ld a,(ix+001h)		;8175
	ld (ix+000h),a		;8178
	jr L_81BA		;817b
L_817D:
	xor a			;817d
	ld (ix+002h),a		;817e
	ld h,a			;8181
	ld (ix+005h),a		;8182
	ld (ix+00bh),a		;8185
	ld (ix+00eh),a		;8188
	ld (ix+00fh),a		;818b
	ld (ix+010h),a		;818e
	ld a,c			;8191
	cp 007h		;8192
	jr c,L_81BA		;8194
	ld l,000h		;8196
	dec c			;8198
	dec c			;8199
	call L_82FF		;819a
	call L_81CF		;819d
	ld a,(0e07ch)		;81a0
	ld b,a			;81a3
	or a			;81a4
	ret z			;81a5
	xor a			;81a6
	ld (0e07ch),a		;81a7
	ld a,b			;81aa
	jp L_86BA		;81ab
L_81AE:
	dec (ix+00ah)		;81ae
L_81B1:
	ld a,(ix+008h)		;81b1
	dec a			;81b4
	ret m			;81b5
	ld (ix+008h),a		;81b6
	ld h,a			;81b9
L_81BA:
	ld a,(0e051h)		;81ba
	ld e,a			;81bd
	ld a,c			;81be
	cp 005h		;81bf
	jr c,L_81CF		;81c1
	jr nz,L_81CA		;81c3
	ld a,e			;81c5
	or a			;81c6
	ret nz			;81c7
	jr L_81CF		;81c8
L_81CA:
	ld a,e			;81ca
	or a			;81cb
	ret z			;81cc
	dec c			;81cd
	dec c			;81ce
L_81CF:
	call L_8049		;81cf
	ld a,c			;81d2
	rrca			;81d3
	add a,088h		;81d4
	ld d,a			;81d6
	bit 3,(ix+005h)		;81d7
	jr z,L_81E6		;81db
	ld e,h			;81dd
	ld a,00dh		;81de
	call 00093h		;81e0   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,010h		;81e3
	ld h,a			;81e5
L_81E6:
	ld a,d			;81e6
	ld e,h			;81e7
	jp 00093h		;81e8   ; BIOS WRTPSG - Writes data to PSG-register
L_81EB:
	dec (ix+000h)		;81eb
	jp z,L_80E1		;81ee
	ld a,(ix+010h)		;81f1
	or a			;81f4
	jp nz,L_832A		;81f5
	dec (ix+00ah)		;81f8
	ld a,(ix+00ah)		;81fb
	cp (ix+000h)		;81fe
	jr nz,L_81AE		;8201
	ld e,a			;8203
	ld a,(ix+00dh)		;8204
	cp e			;8207
	ld a,e			;8208
	jr nc,L_81B1		;8209
	ret			;820b
L_820C:
	ld a,(hl)			;820c
	and 0f0h		;820d
	cp 0d0h		;820f
	ld a,(hl)			;8211
	jr nz,L_821B		;8212
	and 00fh		;8214
	ld (ix+006h),a		;8216
	inc hl			;8219
	ld a,(hl)			;821a
L_821B:
	cp 0f0h		;821b
	jr c,L_8239		;821d
	and 00fh		;821f
	inc a			;8221
	inc a			;8222
	ld (ix+007h),a		;8223
	inc hl			;8226
	ld a,(hl)			;8227
	and 0f0h		;8228
	rrca			;822a
	rrca			;822b
	rrca			;822c
	rrca			;822d
	ld (ix+00ch),a		;822e
	ld a,(hl)			;8231
	and 00fh		;8232
	ld (ix+00dh),a		;8234
	inc hl			;8237
	ld a,(hl)			;8238
L_8239:
	cp 0e0h		;8239
	jr c,L_8265		;823b
	and 00fh		;823d
	cp 008h		;823f
	jr c,L_8260		;8241
	jr nz,L_824B		;8243
	ld (ix+00fh),a		;8245
	inc hl			;8248
	jr L_820C		;8249
L_824B:
	cp 00fh		;824b
	jr z,L_8256		;824d
	sub 008h		;824f
	ld (ix+010h),a		;8251
	jr L_8263		;8254
L_8256:
	xor a			;8256
	ld (ix+00fh),a		;8257
	ld (ix+010h),a		;825a
	inc hl			;825d
	jr L_820C		;825e
L_8260:
	ld (ix+009h),a		;8260
L_8263:
	inc hl			;8263
	ld a,(hl)			;8264
L_8265:
	and 00fh		;8265
	ld b,a			;8267
	ld a,(ix+006h)		;8268
	jr z,L_8272		;826b
L_826D:
	add a,(ix+006h)		;826d
	djnz L_826D		;8270
L_8272:
	ld (ix+001h),a		;8272
	ld a,(hl)			;8275
	call L_8322		;8276
	and 0f0h		;8279
	rrca			;827b
	rrca			;827c
	rrca			;827d
	rrca			;827e
	ld b,a			;827f
	ld a,(ix+010h)		;8280
	or a			;8283
	jr z,L_82AF		;8284
	add a,a			;8286
	ld de,08358h		;8287
	add a,e			;828a
	ld e,a			;828b
	jr nc,L_828F		;828c
	inc d			;828e
L_828F:
	ld a,(de)			;828f
	ld l,a			;8290
	inc de			;8291
	ld a,(de)			;8292
	ld h,a			;8293
	ld a,(ix+001h)		;8294
	ld (ix+000h),a		;8297
	ld a,b			;829a
	add a,a			;829b
	add a,l			;829c
	ld l,a			;829d
	jr nc,L_82A1		;829e
	inc h			;82a0
L_82A1:
	ld e,(hl)			;82a1
	ld (ix+011h),e		;82a2
	inc hl			;82a5
	ld d,(hl)			;82a6
	ld (ix+012h),d		;82a7
	ex de,hl			;82aa
	ld a,(hl)			;82ab
	jp L_80F8		;82ac
L_82AF:
	ld a,b			;82af
	sub 00ch		;82b0
	jr z,L_82B7		;82b2
	ld a,(ix+007h)		;82b4
L_82B7:
	ld (ix+008h),a		;82b7
	ld d,a			;82ba
	ld e,(ix+001h)		;82bb
	ld (ix+000h),e		;82be
	ld a,(ix+00ch)		;82c1
	add a,e			;82c4
	ld (ix+00ah),a		;82c5
	ld a,b			;82c8
	ld hl,0834eh		;82c9
	add a,l			;82cc
	ld l,a			;82cd
	jr nc,L_82D1		;82ce
	inc h			;82d0
L_82D1:
	ld l,(hl)			;82d1
	ld h,000h		;82d2
	ld a,(ix+009h)		;82d4
	or a			;82d7
	jr z,L_82DE		;82d8
	ld b,a			;82da
L_82DB:
	add hl,hl			;82db
	djnz L_82DB		;82dc
L_82DE:
	call L_82E4		;82de
	jp L_81BA		;82e1
L_82E4:
	ld a,(0e051h)		;82e4
	ld e,a			;82e7
	ld a,c			;82e8
	cp 005h		;82e9
	jr c,L_82FF		;82eb
	jr nz,L_82F4		;82ed
	ld a,e			;82ef
	or a			;82f0
	ret nz			;82f1
	jr L_82FF		;82f2
L_82F4:
	ld a,e			;82f4
	or a			;82f5
	ret z			;82f6
	dec c			;82f7
	dec c			;82f8
	call L_82FF		;82f9
	inc c			;82fc
	inc c			;82fd
	ret			;82fe
L_82FF:
	ld a,(ix+00fh)		;82ff
	or a			;8302
	jr z,L_8306		;8303
	inc hl			;8305
L_8306:
	ld a,c			;8306
	ld e,h			;8307
	call 00093h		;8308   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,c			;830b
	dec a			;830c
	ld e,l			;830d
	call 00093h		;830e   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(ix+010h)		;8311
	or a			;8314
	ret nz			;8315
	ld a,(ix+00eh)		;8316
	or a			;8319
	ret z			;831a
	ld h,d			;831b
	ld a,002h		;831c
	ld (ix+005h),a		;831e
	ret			;8321
L_8322:
	inc hl			;8322
	ld (ix+003h),l		;8323
	ld (ix+004h),h		;8326
	ret			;8329
L_832A:
	dec (ix+013h)		;832a
	ret nz			;832d
	ld l,(ix+011h)		;832e
	ld h,(ix+012h)		;8331
	ld a,(hl)			;8334
	cp 0ffh		;8335
	jr z,L_8346		;8337
	jp L_80F8		;8339
L_833C:
	inc hl			;833c
	ld (ix+011h),l		;833d
	ld (ix+012h),h		;8340
	jp L_815C		;8343
L_8346:
	xor a			;8346
	ld h,a			;8347
	ld (ix+005h),a		;8348
	jp L_81BA		;834b

; ----------------------------------------------------------------------
; DATOS sin identificar  0x834e..0x86ba  (876 bytes)
DATA_834E:
	defb 06bh,065h,05fh,05ah,055h,050h,04ch,047h,043h,040h,03ch,039h,060h,083h,0ddh,084h	; 834e  ke_ZUPLGC@<9`...
	defb 0d6h,085h,07ah,083h,080h,083h,08eh,083h,0a1h,083h,0afh,083h,0bdh,083h,0e6h,083h	; 835e  ..z.............
	defb 00fh,084h,038h,084h,067h,084h,096h,084h,0c1h,084h,0cfh,084h,021h,001h,010h,0a0h	; 836e  ..8.g.......!...
	defb 000h,0ffh,023h,001h,013h,091h,080h,022h,001h,082h,000h,072h,070h,063h,030h,0ffh	; 837e  ..#...."...rpc0.
	defb 023h,001h,010h,0cah,000h,021h,004h,010h,0a0h,000h,090h,000h,080h,000h,070h,000h	; 838e  #....!........p.
	defb 060h,000h,0ffh,023h,001h,013h,0c1h,030h,022h,001h,0c1h,0a0h,092h,020h,072h,0f0h	; 839e  `..#...0".... r.
	defb 0ffh,023h,001h,013h,0c1h,080h,022h,001h,0c2h,000h,092h,070h,073h,030h,0ffh,022h	; 83ae  .#...."....ps0."
	defb 001h,0b1h,050h,0a1h,05ah,0a1h,065h,091h,070h,091h,07ah,091h,085h,081h,090h,081h	; 83be  ..P.Z.e.p.z.....
	defb 09ah,081h,0a5h,081h,0b0h,071h,0bah,071h,0c5h,071h,0d0h,071h,0dah,071h,0e5h,071h	; 83ce  .....q.q.q.q.q.q
	defb 0f0h,061h,0fah,062h,025h,052h,030h,0ffh,022h,001h,0b1h,0a0h,0a1h,0aah,0a1h,0b5h	; 83de  .a.b%R0.".......
	defb 091h,0c0h,091h,0cah,091h,0d5h,081h,0e0h,081h,0eah,081h,0f5h,082h,000h,072h,00ah	; 83ee  ..............r.
	defb 072h,015h,072h,020h,072h,02ah,072h,035h,072h,040h,062h,04ah,062h,055h,052h,060h	; 83fe  r.r r*r5r@bJbUR`
	defb 0ffh,022h,001h,0b1h,000h,0a1h,00ah,0a1h,015h,091h,020h,091h,02ah,091h,035h,081h	; 840e  ."........ .*.5.
	defb 040h,081h,04ah,081h,055h,081h,060h,071h,06ah,071h,075h,071h,080h,071h,08ah,071h	; 841e  @.J.U.`qjquq.q.q
	defb 095h,071h,0a0h,061h,0aah,061h,0b5h,051h,0c0h,0ffh,022h,001h,0c2h,000h,0b2h,00ah	; 842e  .q.a.a.Q..".....
	defb 0b2h,015h,0a2h,020h,0a2h,02ah,0a2h,035h,092h,040h,092h,04ah,092h,055h,092h,060h	; 843e  ... .*.5.@.J.U.`
	defb 082h,06ah,082h,075h,082h,080h,082h,08ah,082h,095h,072h,0a0h,072h,0aah,072h,0b5h	; 844e  .j.u......r.r.r.
	defb 072h,0c0h,062h,0cah,062h,0d5h,052h,0e0h,0ffh,022h,001h,0d3h,000h,0c3h,00ah,0c3h	; 845e  r.b.b.R.."......
	defb 015h,0b3h,020h,0b3h,02ah,0b3h,035h,0a3h,040h,0a3h,04ah,0a3h,055h,0a3h,060h,093h	; 846e  .. .*.5.@.J.U.`.
	defb 06ah,093h,075h,093h,080h,093h,08ah,093h,095h,083h,0a0h,083h,0aah,083h,0b5h,073h	; 847e  j.u............s
	defb 0c0h,073h,0cah,063h,0d5h,053h,0e0h,0ffh,022h,001h,0e4h,000h,0d4h,015h,0c4h,030h	; 848e  .s.c.S.."......0
	defb 0c4h,045h,0b4h,060h,0b4h,075h,0b4h,090h,0a4h,0b0h,0a4h,0d0h,0a4h,0f0h,0a5h,010h	; 849e  .E.`.u..........
	defb 095h,030h,095h,050h,094h,070h,094h,090h,094h,0b0h,084h,0d0h,084h,0f0h,075h,010h	; 84ae  .0.P.p........u.
	defb 065h,030h,0ffh,023h,001h,013h,081h,080h,022h,001h,072h,000h,062h,070h,053h,030h	; 84be  e0.#....".r.bpS0
	defb 0ffh,023h,001h,013h,061h,080h,022h,001h,052h,000h,042h,070h,033h,030h,0ffh,0f7h	; 84ce  .#..a.".R.Bp30..
	defb 084h,008h,085h,019h,085h,02ah,085h,03dh,085h,04eh,085h,05fh,085h,070h,085h,081h	; 84de  .....*.=.N._.p..
	defb 085h,092h,085h,0a3h,085h,0b4h,085h,0c5h,085h,022h,004h,090h,036h,080h,036h,070h	; 84ee  ........."..6.6p
	defb 036h,060h,036h,050h,036h,040h,036h,030h,036h,0ffh,022h,004h,090h,040h,080h,040h	; 84fe  6`6P6@606."..@.@
	defb 070h,040h,060h,040h,050h,040h,040h,040h,030h,040h,0ffh,022h,004h,090h,02fh,080h	; 850e  p@`@P@@@0@."../.
	defb 02fh,070h,02fh,060h,02fh,050h,02fh,040h,02fh,030h,02fh,0ffh,022h,004h,090h,02dh	; 851e  /p/`/P/@/0/."..-
	defb 080h,02dh,070h,02dh,060h,02dh,050h,02dh,040h,02dh,030h,02dh,020h,02dh,0ffh,022h	; 852e  .-p-`-P-@-0- -."
	defb 004h,090h,02ah,080h,02ah,070h,02ah,060h,02ah,050h,02ah,040h,02ah,030h,02ah,0ffh	; 853e  ..*.*p*`*P*@*0*.
	defb 022h,004h,090h,028h,080h,028h,070h,028h,060h,028h,050h,028h,040h,028h,030h,028h	; 854e  "..(.(p(`(P(@(0(
	defb 0ffh,022h,004h,090h,026h,080h,026h,070h,026h,060h,026h,050h,026h,040h,026h,030h	; 855e  ."..&.&p&`&P&@&0
	defb 026h,0ffh,022h,004h,090h,024h,080h,024h,070h,024h,060h,024h,050h,024h,040h,024h	; 856e  &."..$.$p$`$P$@$
	defb 030h,024h,0ffh,022h,004h,090h,022h,080h,022h,070h,022h,060h,022h,050h,022h,040h	; 857e  0$.".."."p"`"P"@
	defb 022h,030h,022h,0ffh,022h,004h,090h,020h,080h,020h,070h,020h,060h,020h,050h,020h	; 858e  "0".".. . p ` P
	defb 040h,020h,030h,020h,0ffh,022h,004h,090h,01eh,080h,01eh,070h,01eh,060h,01eh,050h	; 859e  @ 0 .".....p.`.P
	defb 01eh,040h,01eh,030h,01eh,0ffh,022h,004h,090h,01ch,080h,01ch,070h,01ch,060h,01ch	; 85ae  .@.0..".....p.`.
	defb 050h,01ch,040h,01ch,030h,01ch,0ffh,022h,004h,090h,039h,080h,039h,070h,039h,060h	; 85be  P.@.0.."..9.9p9`
	defb 039h,050h,039h,040h,039h,030h,039h,0ffh,0eeh,085h,0ffh,085h,010h,086h,021h,086h	; 85ce  9P9@909.......!.
	defb 032h,086h,043h,086h,054h,086h,065h,086h,076h,086h,087h,086h,098h,086h,0a9h,086h	; 85de  2.C.T.e.v.......
	defb 022h,004h,090h,050h,080h,050h,070h,050h,060h,050h,050h,050h,040h,050h,030h,050h	; 85ee  "..P.PpP`PPP@P0P
	defb 0ffh,022h,002h,090h,032h,080h,032h,070h,032h,060h,032h,050h,032h,040h,032h,030h	; 85fe  ."..2.2p2`2P2@20
	defb 032h,0ffh,022h,004h,090h,018h,080h,018h,070h,018h,060h,018h,050h,018h,040h,018h	; 860e  2.".....p.`.P.@.
	defb 030h,018h,0ffh,022h,002h,090h,02fh,080h,02fh,070h,02fh,060h,02fh,050h,02fh,040h	; 861e  0..".././p/`/P/@
	defb 02fh,030h,02fh,0ffh,022h,004h,090h,055h,080h,055h,070h,055h,060h,055h,050h,055h	; 862e  /0/."..U.UpU`UPU
	defb 040h,055h,030h,055h,0ffh,022h,002h,090h,02ah,080h,02ah,070h,02ah,060h,02ah,050h	; 863e  @U0U."..*.*p*`*P
	defb 02ah,040h,02ah,030h,02ah,0ffh,022h,002h,090h,026h,080h,026h,070h,026h,060h,026h	; 864e  *@*0*."..&.&p&`&
	defb 050h,026h,040h,026h,030h,026h,0ffh,022h,004h,090h,047h,080h,047h,070h,047h,060h	; 865e  P&@&0&."..G.GpG`
	defb 047h,050h,047h,040h,047h,030h,047h,0ffh,022h,004h,090h,043h,080h,043h,070h,043h	; 866e  GPG@G0G."..C.CpC
	defb 060h,043h,050h,043h,040h,043h,030h,043h,0ffh,022h,004h,090h,03ch,080h,03ch,070h	; 867e  `CPC@C0C."..<.<p
	defb 03ch,060h,03ch,050h,03ch,040h,03ch,030h,03ch,0ffh,022h,004h,090h,048h,080h,048h	; 868e  <`<P<@<0<."..H.H
	defb 070h,048h,060h,048h,050h,048h,040h,048h,030h,048h,0ffh,022h,004h,090h,01bh,080h	; 869e  pH`HPH@H0H."....
	defb 01bh,070h,01bh,060h,01bh,050h,01bh,040h,01bh,030h,01bh,0ffh	; 86ae  .p.`.P.@.0..

; ======================================================================
; CODIGO 0x86ba..0x873a  (128 bytes)
; ======================================================================


L_86BA:
	cp 03ah		;86ba
	jr nz,L_86C8		;86bc
	ld hl,0e010h		;86be
	ld de,0e064h		;86c1
	call L_8000		;86c4
	ld a,c			;86c7
L_86C8:
	ld c,a			;86c8
	ld hl,0e012h		;86c9
	ld b,001h		;86cc
	ld a,c			;86ce
	cp 03bh		;86cf
	jr c,L_86E5		;86d1
	cp 0cbh		;86d3
	jr nz,L_86D8		;86d5
	inc b			;86d7
L_86D8:
	inc b			;86d8
	inc b			;86d9
	cp 08ch		;86da
	jr nz,L_8706		;86dc
	xor a			;86de
	ld (0e051h),a		;86df
	ld a,c			;86e2
	jr L_8706		;86e3
L_86E5:
	ld a,c			;86e5
	cp 039h		;86e6
	jr z,L_8706		;86e8
	cp 03ah		;86ea
	jr z,L_8706		;86ec
	ld l,051h		;86ee
	ld a,(0e03ch)		;86f0
	cp 07ah		;86f3
	ret nc			;86f5
	ld a,(hl)			;86f6
	ld e,a			;86f7
	ld a,c			;86f8
	cp 005h		;86f9
	jr nz,L_86FE		;86fb
	inc a			;86fd
L_86FE:
	cp 024h		;86fe
	jr nz,L_8703		;8700
	inc a			;8702
L_8703:
	cp e			;8703
	ret c			;8704
	ld a,c			;8705
L_8706:
	ld de,08738h		;8706
	add a,a			;8709
	jr nc,L_870D		;870a
	inc d			;870c
L_870D:
	add a,e			;870d
	ld e,a			;870e
	jr nc,L_8712		;870f
	inc d			;8711
L_8712:
	dec l			;8712
	dec l			;8713
L_8714:
	ld (hl),001h		;8714
	inc l			;8716
	inc l			;8717
	ld (hl),c			;8718
	inc l			;8719
	ld a,(de)			;871a
	ld (hl),a			;871b
	inc l			;871c
	inc de			;871d
	ld a,(de)			;871e
	ld (hl),a			;871f
	ld a,007h		;8720
	add a,l			;8722
	ld l,a			;8723
	xor a			;8724
	ld (hl),a			;8725
	ld a,003h		;8726
	add a,l			;8728
	ld l,a			;8729
	ld a,001h		;872a
	ld (hl),a			;872c
	inc l			;872d
	dec a			;872e
	ld (hl),a			;872f
	inc l			;8730
	ld (hl),a			;8731
	ld a,005h		;8732
	add a,l			;8734
	ld l,a			;8735
	inc de			;8736
	djnz L_8714		;8737
	ret			;8739

; ----------------------------------------------------------------------
; DATOS sin identificar  0x873a..0xa000  (6342 bytes)
DATA_873A:
	defb 01ah,08bh,060h,08bh,028h,092h,0bah,094h,045h,092h,0edh,094h,0afh,092h,0cah,092h	; 873a  ..`.(...E.......
	defb 0d5h,092h,0e0h,092h,016h,093h,09ah,092h,040h,08fh,09bh,08eh,0d7h,091h,0e8h,091h	; 874a  ........@.......
	defb 04ah,08eh,0ffh,08ch,03eh,08dh,07fh,08dh,031h,093h,077h,091h,05ch,08dh,025h,091h	; 875a  J...>...1.w.\.%.
	defb 0a0h,094h,02eh,091h,089h,094h,08eh,093h,06ah,093h,0a7h,08dh,0b1h,08ch,0f0h,08ch	; 876a  ........j.......
	defb 086h,08ch,042h,095h,0c7h,093h,054h,094h,04bh,094h,01dh,08fh,0e8h,08eh,0d4h,093h	; 877a  ..B...T.K.......
	defb 04fh,08fh,089h,08fh,0a4h,08fh,054h,090h,031h,08bh,050h,08bh,05fh,090h,002h,091h	; 878a  O.....T.1.P._...
	defb 0b6h,091h,0feh,0bfh,0adh,08bh,0bch,08bh,0cbh,08bh,0dah,08bh,023h,08eh,0e9h,08bh	; 879a  ............#...
	defb 0afh,094h,0b3h,095h,0c1h,095h,05dh,096h,02dh,097h,023h,098h,076h,099h,083h,09ah	; 87aa  ......].-.#.v...
	defb 069h,09bh,002h,09ch,0b3h,09ch,0fdh,09ch,040h,09eh,011h,09fh,042h,0a0h,0d1h,0a0h	; 87ba  i.......@...B...
	defb 04dh,0a1h,08dh,0a1h,03bh,0a2h,01ah,0a3h,0a5h,0a3h,01bh,0a4h,084h,0a4h,0edh,0a4h	; 87ca  M...;...........
	defb 06ch,0a5h,00eh,0a6h,073h,0a6h,0fbh,0a6h,000h,0a8h,0d6h,0b5h,0fah,08ah,006h,08bh	; 87da  l...s...........
	defb 0f2h,08fh,023h,090h,0feh,0bfh,0dah,0a8h,03eh,0a9h,0fbh,0a9h,043h,0aah,09ah,0aah	; 87ea  ..#.....>...C...
	defb 02dh,0abh,057h,0abh,09ah,0abh,0e8h,0abh,061h,0abh,0afh,0abh,0eah,0abh,04eh,0ach	; 87fa  -.W.....a.....N.
	defb 0dfh,0ach,068h,0adh,02ah,0aeh,099h,0aeh,0e3h,0aeh,056h,0afh,084h,0afh,0b4h,0afh	; 880a  ..h.*.....V.....
	defb 0c4h,0b0h,0e8h,0b0h,017h,0b1h,06eh,0b0h,08ah,0b0h,0aah,0b0h,033h,0b9h,02fh,0b9h	; 881a  ......n.....3./.
	defb 031h,0b9h,030h,0b1h,0edh,0b1h,06dh,0b2h,094h,08ah,0a3h,08ah,0c4h,08ah,0cbh,08ah	; 882a  1.0...m.........
	defb 0d1h,08ah,0feh,0bfh,0cch,08dh,0feh,0bfh,0feh,0bfh,070h,08ch,0feh,0bfh,0feh,0bfh	; 883a  ..........p.....
	defb 0a6h,0b2h,0c7h,0b2h,0feh,0bfh,006h,0b3h,027h,0b3h,0feh,0bfh,040h,0b3h,04dh,0b3h	; 884a  ........'...@.M.
	defb 05ah,0b3h,052h,0b5h,069h,0b5h,0feh,0bfh,080h,0b5h,0abh,0b5h,0feh,0bfh,0d6h,0b5h	; 885a  Z.R.i...........
	defb 0feh,0bfh,0feh,0bfh,081h,0b3h,0a4h,0b3h,0c1h,0b3h,0deh,0b3h,001h,0b4h,01eh,0b4h	; 886a  ................
	defb 03bh,0b4h,07ah,0b4h,0b7h,0b4h,0e0h,0b4h,021h,0b5h,0feh,0bfh,07dh,08bh,093h,08bh	; 887a  ;.z.....!...}...
	defb 07bh,08bh,03bh,0b4h,07ah,0b4h,0feh,0bfh,004h,0b6h,05bh,0b6h,07bh,0b6h,09eh,0b6h	; 888a  {.;.z.....[.{...
	defb 0efh,0b6h,00ah,0b7h,05bh,0b7h,0a0h,0b7h,0ddh,0b7h,011h,0b8h,060h,0b8h,085h,0b8h	; 889a  ....[.......`...
	defb 0bch,0b8h,001h,0b9h,011h,0b9h,0d6h,088h,049h,089h,0feh,089h,049h,0b9h,068h,0bah	; 88aa  ........I...I.h.
	defb 0efh,0bah,00eh,0bch,042h,0bdh,015h,0beh,044h,0bfh,051h,0bfh,05ch,0bfh,068h,0bfh	; 88ba  ....B...D.Q.\.h.
	defb 098h,0bfh,0cbh,0bfh,0feh,0bfh,0feh,0bfh,0feh,0bfh,0feh,0bfh,0efh,0dah,0f9h,012h	; 88ca  ................
	defb 0e2h,0c0h,070h,0e1h,000h,030h,0fah,012h,072h,070h,050h,030h,052h,0a2h,032h,030h	; 88da  ..p..0..rpP0R.20
	defb 030h,030h,052h,022h,0f8h,012h,0e1h,030h,020h,000h,0e2h,0a0h,070h,0a0h,0feh,004h	; 88ea  00R"...0 ...p...
	defb 0eeh,088h,0f9h,012h,0e1h,030h,020h,000h,0e2h,0a0h,070h,0a0h,0feh,004h,0fch,088h	; 88fa  .....0 ...p.....
	defb 0e1h,072h,071h,0a0h,052h,020h,050h,0a0h,0e0h,032h,030h,020h,000h,022h,0e1h,0a2h	; 890a  .rq.R P..20 ."..
	defb 0fah,012h,0e0h,002h,000h,0e1h,0a0h,080h,0a2h,070h,0a0h,0e0h,030h,050h,0e1h,0aah	; 891a  .........p..0P..
	defb 0f9h,021h,0e0h,072h,070h,050h,030h,052h,0a2h,0dbh,032h,030h,030h,030h,052h,022h	; 892a  .!.rpP0R..2000R"
	defb 004h,002h,003h,007h,0d4h,0eah,041h,071h,0ebh,0b0h,0b8h,0efh,0dbh,0c6h,0ffh,0efh	; 893a  ......Aq........
	defb 0dah,0f9h,012h,0e2h,0c0h,030h,070h,0e1h,000h,0e2h,002h,000h,000h,000h,0e3h,0a2h	; 894a  .....0p.........
	defb 0a2h,082h,080h,080h,080h,0a2h,072h,0e0h,001h,0e1h,070h,0e0h,033h,020h,000h,0e1h	; 895a  ......r...p.3 ..
	defb 0a0h,070h,0a0h,070h,050h,030h,020h,0e2h,0a0h,0e1h,020h,0e0h,000h,0e1h,0a0h,080h	; 896a  .p.pP0 ... .....
	defb 070h,050h,030h,0f8h,000h,0e1h,071h,080h,0d5h,0f8h,000h,070h,080h,0feh,00ah,085h	; 897a  pP0...q....p....
	defb 089h,0f9h,000h,070h,080h,0feh,009h,08dh,089h,070h,050h,030h,020h,0dah,0ebh,072h	; 898a  ...p.....pP0 ..r
	defb 071h,090h,003h,000h,090h,0eah,032h,030h,020h,000h,022h,0ebh,092h,0efh,0d5h,0f7h	; 899a  q.....20 .".....
	defb 000h,0e1h,000h,0e2h,030h,080h,0e1h,000h,030h,000h,0feh,002h,0ach,089h,0f8h,010h	; 89aa  ....0...0.......
	defb 0e2h,0a0h,030h,070h,0a0h,0e1h,030h,0e2h,0a0h,0d6h,030h,070h,0d7h,0a0h,0e1h,030h	; 89ba  ..0p..0...0p...0
	defb 0d8h,0e2h,0a0h,0d6h,0e2h,050h,0dah,0a0h,0e1h,030h,050h,030h,0e2h,0a0h,050h,0a0h	; 89ca  .....P...0P0..P.
	defb 0e1h,020h,050h,020h,0e2h,0a0h,0f9h,012h,0e2h,002h,000h,000h,000h,0e3h,0a2h,0a2h	; 89da  . P ............
	defb 0dbh,082h,080h,080h,080h,0a2h,072h,054h,042h,023h,048h,0d2h,0c0h,0d4h,0eah,040h	; 89ea  ......rTB#H....@
	defb 070h,0ebh,0b8h,0ffh,0efh,0dah,0fah,023h,0e3h,0c0h,000h,000h,000h,0fbh,023h,032h	; 89fa  p......#......#2
	defb 030h,030h,030h,052h,022h,032h,030h,030h,030h,052h,022h,001h,000h,001h,000h,021h	; 8a0a  000R"2000R"....!
	defb 020h,021h,020h,031h,030h,031h,030h,051h,050h,051h,050h,001h,000h,000h,000h,000h	; 8a1a   ! 1010QPQP.....
	defb 021h,020h,020h,020h,020h,030h,030h,030h,030h,030h,030h,051h,050h,050h,050h,050h	; 8a2a  !    000000QPPPP
	defb 0fah,012h,0e3h,071h,0c0h,071h,0c0h,0a1h,0c0h,051h,0c0h,031h,0c0h,031h,0c0h,051h	; 8a3a  ...q.q...Q.1.1.Q
	defb 0c0h,0a1h,0c0h,0fah,012h,0e3h,080h,0e2h,000h,0f9h,011h,030h,0feh,002h,04dh,08ah	; 8a4a  ...........0..M.
	defb 0fah,012h,0e3h,070h,0a0h,0f9h,011h,0e2h,030h,0feh,002h,05ah,08ah,0fah,012h,0e3h	; 8a5a  ...p....0..Z....
	defb 050h,0a0h,0f9h,011h,0e2h,030h,0feh,002h,067h,08ah,0fah,012h,0e3h,050h,0a0h,0f9h	; 8a6a  P....0..g....P..
	defb 011h,0e2h,020h,0feh,002h,074h,08ah,0fbh,023h,0e3h,032h,030h,030h,030h,052h,022h	; 8a7a  .. ..t..#.2000R"
	defb 0dbh,032h,030h,030h,030h,052h,022h,00bh,009h,0ffh,0feh,000h,020h,005h,022h,001h	; 8a8a  .2000R"..... .".
	defb 070h,040h,020h,005h,022h,001h,080h,030h,0ffh,0feh,000h,022h,001h,060h,030h,060h	; 8a9a  p@ ."..0...".`0`
	defb 02fh,060h,02eh,060h,02dh,060h,02ch,060h,02bh,060h,02ah,060h,029h,060h,028h,040h	; 8aaa  /`.`-`,`+`*`)`(@
	defb 02ch,040h,02bh,040h,02ah,040h,029h,040h,028h,0ffh,0efh,0d1h,0c0h,0feh,002h,040h	; 8aba  ,@+@*@)@(......@
	defb 08fh,0d8h,0c0h,0feh,002h,0b7h,0b4h,0feh,000h,020h,01dh,022h,002h,070h,018h,070h	; 8aca  ......... .".p.p
	defb 019h,070h,01ah,070h,01bh,070h,01ch,070h,01dh,070h,01eh,070h,02ch,070h,02bh,022h	; 8ada  .p.p.p.p.p.p,p+"
	defb 003h,070h,02ah,070h,029h,070h,028h,022h,001h,070h,027h,070h,026h,070h,025h,0ffh	; 8aea  .p*p)p(".p'p&p%.
	defb 0feh,000h,022h,015h,090h,022h,020h,02ah,0feh,0feh,0fch,08ah,0feh,000h,022h,007h	; 8afa  ..".." *......".
	defb 090h,0a0h,000h,000h,070h,0a0h,000h,000h,050h,0a0h,020h,013h,0feh,0feh,008h,08bh	; 8b0a  ....p...P. .....
	defb 0feh,000h,021h,001h,012h,080h,000h,0a0h,000h,070h,000h,090h,000h,016h,070h,000h	; 8b1a  ..!......p....p.
	defb 090h,000h,060h,000h,080h,000h,0ffh,0feh,000h,022h,001h,0b0h,020h,0c0h,021h,0a0h	; 8b2a  ..`......".. .!.
	defb 020h,0b0h,021h,0c0h,060h,0b0h,030h,0a0h,062h,080h,031h,090h,060h,070h,030h,080h	; 8b3a   .!.`.0.b.1.`p0.
	defb 062h,060h,031h,070h,02fh,0ffh,0feh,000h,022h,001h,0a0h,060h,0a0h,03ah,0a0h,02ch	; 8b4a  b`1p/..."..`.:.,
	defb 0a0h,065h,0feh,002h,03bh,08bh,0feh,000h,021h,001h,010h,0b0h,000h,015h,0a0h,000h	; 8b5a  .e..;...!.......
	defb 019h,080h,000h,020h,001h,021h,001h,013h,0a0h,000h,019h,080h,000h,01fh,060h,000h	; 8b6a  ... .!........`.
	defb 0ffh,0dah,0c0h,0d8h,0eah,043h,073h,095h,073h,043h,021h,005h,013h,003h,021h,095h	; 8b7a  .....Cs.sC!...!.
	defb 073h,041h,073h,010h,000h,040h,091h,095h,0ffh,0d8h,0c7h,0ebh,001h,001h,0eah,001h	; 8b8a  sAs..@..........
	defb 0c3h,0ebh,0a3h,045h,005h,003h,0a1h,0efh,0d2h,0c0h,0d8h,0eah,005h,0c3h,0ebh,0a1h	; 8b9a  ...E............
	defb 0eah,0c3h,0ffh,0feh,000h,022h,001h,0a0h,030h,0b0h,034h,0b0h,038h,0b0h,03bh,0a0h	; 8baa  ....."..0.4.8.;.
	defb 040h,0ffh,0feh,000h,022h,001h,0a0h,04ah,0b0h,047h,0b0h,045h,0b0h,040h,0a0h,03eh	; 8bba  @..."..J.G.E.@.>
	defb 0ffh,0feh,000h,022h,001h,0a0h,05ah,0b0h,055h,0b0h,050h,0b0h,04ah,0a0h,045h,0ffh	; 8bca  ..."..Z.U.P.J.E.
	defb 0feh,000h,022h,001h,0a0h,020h,0b0h,022h,0b0h,025h,0b0h,028h,0a0h,02ch,0ffh,0feh	; 8bda  ..".. .".%.(.,..
	defb 000h,022h,001h,0e0h,056h,0d0h,055h,0c0h,056h,0b0h,056h,0a0h,056h,0e0h,06eh,0d0h	; 8bea  ."..V.U.V.V.V.n.
	defb 06dh,0c0h,06eh,0d0h,06fh,0a0h,070h,0e0h,049h,0d0h,048h,0c0h,049h,0b0h,049h,080h	; 8bfa  m.n.o.p.I.H.I.I.
	defb 049h,060h,049h,040h,049h,020h,004h,022h,001h,0b0h,058h,0a0h,057h,090h,058h,090h	; 8c0a  I`I@I ."..X.W.X.
	defb 057h,080h,058h,0b0h,070h,0a0h,06fh,0b0h,070h,0b0h,071h,0b0h,072h,0a0h,04bh,090h	; 8c1a  W.X.p.o.p.q.r.K.
	defb 04bh,080h,04bh,070h,04bh,050h,04bh,020h,006h,022h,001h,090h,059h,090h,05ah,090h	; 8c2a  K.KpKPK ."..Y.Z.
	defb 059h,090h,05ah,090h,05bh,090h,072h,090h,073h,090h,074h,090h,073h,070h,04eh,060h	; 8c3a  Y.Z.[.r.s.t.spN`
	defb 04eh,050h,04eh,040h,04eh,030h,04eh,020h,007h,022h,001h,070h,05dh,070h,05eh,070h	; 8c4a  NPN@N0N .".p]p^p
	defb 05dh,070h,05eh,070h,05dh,070h,05eh,060h,077h,060h,076h,060h,077h,070h,053h,060h	; 8c5a  ]p^p]p^`w`v`wpS`
	defb 054h,050h,033h,050h,054h,0ffh,0feh,000h,022h,001h,0a0h,02ch,0a0h,040h,020h,005h	; 8c6a  TP3PT..."..,.@ .
	defb 022h,001h,090h,040h,080h,050h,020h,006h,0feh,0feh,072h,08ch,0feh,000h,021h,002h	; 8c7a  "..@.P ...r...!.
	defb 01ah,0c0h,000h,020h,003h,023h,003h,017h,0c0h,022h,0a0h,021h,0c0h,022h,020h,003h	; 8c8a  ... .#...".!." .
	defb 023h,002h,0a0h,022h,020h,004h,023h,002h,080h,022h,020h,005h,023h,002h,060h,022h	; 8c9a  #.." .#.." .#.`"
	defb 020h,006h,023h,002h,050h,022h,0ffh,0feh,000h,022h,001h,0c0h,040h,0c0h,041h,0c0h	; 8caa   .#.P"..."..@.A.
	defb 042h,0c0h,043h,0c0h,044h,0c0h,045h,0c0h,046h,0c0h,047h,0c0h,048h,0c0h,049h,0c0h	; 8cba  B.C.D.E.F.G.H.I.
	defb 04ah,0c0h,04bh,0c0h,04ch,0c0h,04dh,0c0h,04eh,0c0h,04fh,0c0h,050h,0c0h,051h,0c0h	; 8cca  J.K.L.M.N.O.P.Q.
	defb 052h,0c0h,053h,0b0h,054h,0b0h,055h,0a0h,056h,090h,057h,080h,058h,070h,059h,060h	; 8cda  R.S.T.U.V.W.XpY`
	defb 05ah,050h,05bh,040h,05ch,0ffh,0feh,000h,023h,001h,010h,0d3h,000h,020h,003h,023h	; 8cea  ZP[@\...#.... .#
	defb 001h,014h,0e2h,000h,0ffh,0feh,000h,022h,001h,0d0h,0a0h,080h,0f0h,0b0h,0a0h,080h	; 8cfa  ......."........
	defb 0f4h,0b0h,0a0h,080h,0f8h,0b0h,0a0h,0c0h,080h,0c0h,087h,0c0h,080h,0c0h,087h,0c0h	; 8d0a  ................
	defb 084h,0c0h,08bh,0c0h,085h,0c0h,08bh,0c0h,088h,0c0h,090h,0c0h,088h,0c0h,090h,0c0h	; 8d1a  ................
	defb 08bh,0c0h,093h,0c0h,08bh,0c0h,093h,0c0h,08fh,0c0h,097h,0c0h,08fh,0c0h,097h,0c0h	; 8d2a  ................
	defb 093h,0c0h,09ch,0ffh,0feh,000h,023h,001h,014h,0f9h,000h,0ech,000h,0d8h,000h,0dah	; 8d3a  ......#.........
	defb 000h,0cbh,000h,0cdh,000h,0d7h,000h,0d4h,000h,0d1h,000h,0e2h,000h,0f1h,000h,0f1h	; 8d4a  ................
	defb 0a0h,0ffh,0feh,000h,022h,001h,0d0h,04ah,0d0h,03ah,020h,001h,022h,001h,0d0h,04ah	; 8d5a  ...."..J.: ."..J
	defb 0d0h,03dh,0d0h,030h,020h,002h,022h,001h,0d0h,040h,0d0h,046h,0d0h,04ch,0d0h,054h	; 8d6a  .=.0 ."..@.F.L.T
	defb 0d0h,060h,0d0h,06ah,0ffh,0feh,000h,023h,002h,018h,0a3h,008h,01dh,0b1h,0fah,01eh	; 8d7a  .`.j...#........
	defb 0b2h,0dah,01ch,0e1h,070h,01fh,0d2h,0d7h,0d1h,0a0h,0e1h,090h,0f2h,040h,0c1h,067h	; 8d8a  ....p........@.g
	defb 0b2h,010h,0a2h,03ah,023h,005h,091h,0c0h,082h,04ah,073h,03ah,0ffh,0feh,000h,022h	; 8d9a  ...:#....Js:..."
	defb 002h,0f6h,000h,0e5h,000h,0e4h,000h,0d3h,000h,0d2h,000h,0c1h,000h,0c1h,010h,020h	; 8daa  ...............
	defb 001h,022h,002h,0b6h,000h,0a5h,000h,0a4h,000h,093h,000h,092h,000h,081h,000h,091h	; 8dba  ."..............
	defb 010h,0ffh,0feh,000h,022h,001h,0c0h,06ah,0d0h,0d4h,0c0h,06bh,0d0h,0d6h,0feh,003h	; 8dca  ...."..j...k....
	defb 0d0h,08dh,0d0h,0f0h,0d1h,0e0h,0d1h,000h,0d2h,000h,0d1h,010h,0d2h,020h,0d1h,020h	; 8dda  ............. .
	defb 0d2h,040h,0d1h,030h,0d2h,060h,0d1h,040h,0d2h,080h,0d1h,050h,0d2h,0a0h,0d1h,060h	; 8dea  .@.0.`.@...P...`
	defb 0d2h,0c0h,0d1h,070h,0d2h,0e0h,0d3h,080h,0d7h,000h,0d3h,04eh,0d6h,09ch,0d3h,04eh	; 8dfa  ...p.......N...N
	defb 0d6h,09ch,0d3h,080h,0d7h,000h,0feh,003h,008h,08eh,0d3h,030h,0d6h,060h,0d3h,013h	; 8e0a  ...........0.`..
	defb 0d3h,010h,0d6h,020h,0d3h,079h,0d6h,000h,0ffh,0feh,000h,022h,001h,0e0h,056h,0d0h	; 8e1a  ... .y....."..V.
	defb 055h,0c0h,056h,0b0h,056h,0a0h,056h,0e0h,06eh,0d0h,06dh,0c0h,06eh,0d0h,06dh,0a0h	; 8e2a  U.V.V.V.n.m.n.m.
	defb 06eh,0e0h,049h,0d0h,048h,0c0h,049h,0b0h,049h,080h,049h,060h,049h,040h,049h,0ffh	; 8e3a  n.I.H.I.I.I`I@I.
	defb 0feh,000h,023h,002h,010h,0b0h,000h,01fh,0e0h,000h,015h,0a0h,000h,01ah,080h,000h	; 8e4a  ..#.............
	defb 021h,001h,010h,0e0h,000h,013h,0d0h,000h,022h,001h,0e0h,085h,0c0h,07ah,023h,001h	; 8e5a  !......."....z#.
	defb 010h,0a0h,075h,011h,080h,070h,021h,003h,010h,090h,000h,021h,001h,011h,090h,000h	; 8e6a  ..u..p!....!....
	defb 012h,090h,000h,013h,090h,000h,014h,080h,000h,015h,080h,000h,016h,070h,000h,017h	; 8e7a  .............p..
	defb 070h,000h,019h,060h,000h,01bh,060h,000h,01dh,050h,000h,021h,007h,01fh,050h,000h	; 8e8a  p..`..`..P.!..P.
	defb 0ffh,0feh,000h,022h,001h,0c0h,0e2h,0d0h,0beh,0c0h,0aah,0b0h,099h,0c0h,088h,0b0h	; 8e9a  ..."............
	defb 077h,0a0h,066h,090h,055h,020h,005h,022h,001h,0a0h,0e5h,0b0h,0c1h,0a0h,0adh,090h	; 8eaa  w.f.U ."........
	defb 09ch,0a0h,08bh,090h,07ah,080h,069h,070h,058h,020h,005h,022h,001h,080h,0e9h,090h	; 8eba  ....z.ipX ."....
	defb 0c5h,080h,0b1h,070h,0a0h,080h,08fh,070h,07eh,060h,06dh,050h,05ch,020h,005h,022h	; 8eca  ...p...p~`mP\ ."
	defb 001h,060h,0eeh,070h,0cah,060h,0b6h,050h,0a5h,060h,094h,050h,083h,0ffh,0feh,000h	; 8eda  .`.p.`.P.`.P....
	defb 022h,001h,0c0h,080h,0c0h,071h,0c0h,05fh,0c0h,040h,0feh,003h,0ech,08eh,020h,003h	; 8eea  "....q._.@.... .
	defb 022h,001h,090h,080h,090h,071h,090h,05fh,090h,040h,020h,004h,022h,001h,060h,080h	; 8efa  "....q._.@ .".`.
	defb 060h,071h,060h,05fh,060h,040h,020h,005h,022h,001h,040h,080h,040h,071h,040h,05fh	; 8f0a  `q`_`@ .".@.@q@_
	defb 040h,040h,0ffh,0feh,000h,022h,002h,0d0h,0c0h,0b0h,030h,0d0h,080h,0d0h,040h,0b0h	; 8f1a  @@..."....0...@.
	defb 030h,0d0h,020h,022h,002h,0d0h,060h,0c0h,030h,0b0h,060h,0a0h,030h,090h,060h,080h	; 8f2a  0. "..`.0.`.0.`.
	defb 030h,070h,060h,060h,030h,0ffh,0feh,000h,02ah,006h,000h,070h,090h,040h,02ah,006h	; 8f3a  0p``0...*..p.@*.
	defb 000h,0a0h,090h,030h,0ffh,0feh,000h,023h,001h,015h,0e1h,053h,0e0h,0fdh,0e2h,0a7h	; 8f4a  ...0...#...S....
	defb 0e1h,0fch,000h,000h,000h,000h,0f0h,020h,0e0h,020h,0d0h,020h,0c0h,020h,0b0h,020h	; 8f5a  ....... . . . .
	defb 0a0h,020h,090h,020h,080h,020h,022h,001h,0a0h,040h,0a0h,036h,0a0h,040h,0a0h,030h	; 8f6a  . . . "..@.6.@.0
	defb 0a0h,040h,0a0h,028h,0a0h,040h,0a0h,023h,0a0h,040h,0feh,0feh,070h,08fh,0ffh,0feh	; 8f7a  .@.(.@.#.@..p...
	defb 000h,023h,001h,015h,0f0h,0fdh,0d0h,0beh,0e1h,0ach,0c3h,000h,0d0h,040h,0c0h,020h	; 8f8a  .#...........@.
	defb 0b0h,040h,0a0h,020h,090h,040h,0feh,002h,070h,08fh,0feh,000h,023h,001h,015h,0f0h	; 8f9a  .@. .@..p...#...
	defb 0fdh,0d0h,0beh,0e1h,0ach,0c3h,000h,0d0h,040h,0c0h,020h,0b0h,040h,0a0h,020h,090h	; 8faa  ........@. .@. .
	defb 040h,000h,000h,000h,000h,080h,020h,070h,040h,000h,000h,000h,000h,060h,020h,050h	; 8fba  @..... p@....` P
	defb 040h,020h,019h,023h,001h,01ah,0f3h,050h,0c0h,020h,01fh,0b0h,040h,0a0h,020h,090h	; 8fca  @ .#...P. ..@. .
	defb 021h,080h,023h,020h,00ah,023h,001h,01ah,0f3h,050h,0c0h,080h,01fh,0b0h,020h,0a0h	; 8fda  !.# .#...P.... .
	defb 040h,090h,020h,080h,021h,070h,023h,0ffh,0feh,000h,022h,001h,0d0h,0a0h,0d0h,098h	; 8fea  @. .!p#...".....
	defb 0d0h,090h,0d0h,088h,0d0h,080h,0d0h,078h,0d0h,070h,022h,003h,0e0h,040h,0d0h,080h	; 8ffa  .......x.p"..@..
	defb 0d0h,040h,0a0h,080h,0c0h,040h,090h,080h,0b0h,040h,080h,080h,0a0h,040h,070h,080h	; 900a  .@...@...@...@p.
	defb 090h,040h,060h,080h,080h,040h,050h,080h,0ffh,0feh,000h,022h,001h,0d0h,050h,0d0h	; 901a  .@`..@P...."..P.
	defb 04ch,0d0h,048h,0d0h,044h,0d0h,040h,0d0h,03ch,0d0h,038h,022h,003h,0e0h,020h,0b0h	; 902a  L.H.D.@.<.8".. .
	defb 040h,0d0h,020h,0a0h,040h,0c0h,020h,090h,040h,0b0h,020h,080h,040h,0a0h,020h,070h	; 903a  @. .@. .@. .@. p
	defb 040h,090h,020h,060h,040h,080h,020h,050h,040h,0ffh,0feh,000h,022h,001h,0c0h,078h	; 904a  @. `@. P@..."..x
	defb 0b0h,058h,0a0h,048h,0ffh,0feh,000h,022h,001h,0b5h,000h,0b4h,080h,0b4h,000h,0b3h	; 905a  .X.H..."........
	defb 080h,0b3h,000h,0b2h,080h,0b2h,000h,0b1h,0a0h,0b8h,000h,0b7h,000h,0b6h,000h,0b5h	; 906a  ................
	defb 080h,0b5h,000h,0b4h,080h,0b4h,000h,0b3h,080h,0b3h,000h,0bch,000h,0bbh,000h,0bah	; 907a  ................
	defb 000h,0b9h,000h,0b8h,000h,0b7h,000h,0b6h,000h,0b5h,080h,0b5h,000h,0b4h,080h,0b4h	; 908a  ................
	defb 000h,0b3h,080h,0b3h,000h,0b6h,000h,0b5h,080h,0b5h,000h,0b4h,080h,0b4h,000h,0b3h	; 909a  ................
	defb 080h,0b3h,000h,0b2h,080h,0b9h,000h,0b8h,000h,0b7h,000h,0b6h,000h,0b5h,080h,0b5h	; 90aa  ................
	defb 000h,0a4h,080h,0a4h,000h,0a3h,080h,0a3h,000h,0a2h,080h,0a2h,000h,0ach,000h,0aah	; 90ba  ................
	defb 000h,0aah,000h,0a9h,000h,098h,000h,097h,000h,096h,000h,095h,080h,095h,000h,094h	; 90ca  ................
	defb 080h,094h,000h,093h,080h,093h,000h,098h,000h,087h,000h,086h,000h,085h,080h,085h	; 90da  ................
	defb 000h,084h,080h,084h,000h,083h,080h,083h,000h,082h,080h,082h,000h,071h,0a0h,077h	; 90ea  .............q.w
	defb 000h,077h,000h,076h,000h,075h,070h,0ffh,0feh,000h,022h,001h,090h,02eh,0a0h,02ah	; 90fa  .w.v.up..."....*
	defb 0b0h,026h,0c0h,023h,0d0h,024h,0d0h,025h,0d0h,026h,0d0h,02ah,0d0h,02ch,0d0h,02eh	; 910a  .&.#.$.%.&.*.,..
	defb 0d0h,030h,0c0h,032h,0b0h,034h,0a0h,036h,090h,038h,0ffh,0feh,000h,02ah,008h,004h	; 911a  .0.2.4.6.8...*..
	defb 000h,090h,01eh,0ffh,0feh,000h,022h,001h,0f1h,0c0h,0f2h,000h,0f2h,080h,0f6h,000h	; 912a  ......".........
	defb 0f2h,0e0h,0f3h,050h,0f4h,000h,0f2h,000h,0f3h,050h,000h,000h,0f6h,000h,000h,000h	; 913a  ...P.....P......
	defb 000h,000h,0fbh,000h,000h,000h,0fch,000h,000h,000h,000h,000h,0f9h,000h,000h,000h	; 914a  ................
	defb 000h,000h,0fdh,0fdh,000h,000h,0fah,0b0h,000h,000h,000h,000h,0fch,000h,000h,000h	; 915a  ................
	defb 0fah,000h,000h,000h,0fdh,0d6h,000h,000h,000h,000h,0fbh,000h,0ffh,0feh,000h,022h	; 916a  ..............."
	defb 004h,070h,035h,080h,02ch,080h,02fh,090h,02ah,090h,01ch,090h,021h,0a0h,032h,0a0h	; 917a  .p5.,./.*...!.2.
	defb 023h,0a0h,01eh,0feh,002h,079h,091h,0a0h,02fh,022h,003h,0b0h,035h,0c0h,02ch,0c0h	; 918a  #....y../"..5.,.
	defb 025h,0feh,002h,091h,091h,0c0h,02ah,0c0h,01ch,0c0h,021h,0c0h,032h,0c0h,023h,0c0h	; 919a  %.....*...!.2.#.
	defb 01eh,0c0h,02fh,0c0h,02ah,0b0h,01ch,0a0h,028h,090h,02ah,0ffh,0feh,000h,022h,003h	; 91aa  ../.*...(.*...".
	defb 0f0h,03fh,0e0h,056h,0b0h,03fh,0a0h,056h,022h,002h,070h,01ch,080h,03fh,070h,056h	; 91ba  .?.V.?.V".p..?pV
	defb 060h,01ch,060h,03fh,050h,056h,050h,01ch,0feh,003h,0b8h,091h,0ffh,0feh,000h,022h	; 91ca  `.`?PVP........"
	defb 001h,0d0h,040h,0d0h,060h,0d0h,05ah,0d0h,055h,0d0h,050h,0d0h,04ah,0ffh,0feh,000h	; 91da  ..@.`.Z.U.P.J...
	defb 021h,001h,010h,0c0h,000h,01fh,0e0h,000h,01eh,0d0h,000h,01dh,0c0h,000h,01ch,0b0h	; 91ea  !...............
	defb 000h,01bh,0b0h,000h,01ah,0b0h,000h,019h,0b0h,000h,018h,0b0h,000h,017h,0b0h,000h	; 91fa  ................
	defb 016h,0b0h,000h,015h,0b0h,000h,014h,0b0h,000h,013h,0b0h,000h,012h,0b0h,000h,011h	; 920a  ................
	defb 0b0h,000h,010h,0b0h,000h,0a0h,000h,090h,000h,080h,000h,070h,000h,0ffh,0feh,000h	; 921a  ...........p....
	defb 022h,002h,0d0h,07fh,0b0h,070h,0b0h,077h,0a0h,062h,090h,050h,080h,043h,020h,003h	; 922a  "....p.w.b.P.C .
	defb 022h,001h,070h,043h,020h,004h,022h,001h,060h,043h,0ffh,0feh,000h,021h,001h,01fh	; 923a  ".pC .".`C...!..
	defb 0d0h,000h,010h,0b0h,000h,013h,0a0h,000h,016h,090h,000h,01ah,080h,000h,021h,002h	; 924a  ..............!.
	defb 010h,0e0h,000h,013h,0c0h,000h,016h,0b0h,000h,01ch,0a0h,000h,01fh,090h,000h,020h	; 925a  ...............
	defb 001h,021h,002h,010h,0a0h,000h,013h,0b0h,000h,017h,0a0h,000h,01fh,090h,000h,020h	; 926a  .!.............
	defb 002h,021h,002h,010h,080h,000h,013h,090h,000h,01bh,080h,000h,01fh,070h,000h,020h	; 927a  .!...........p.
	defb 003h,021h,002h,010h,060h,000h,013h,070h,000h,01bh,060h,000h,01fh,050h,000h,0ffh	; 928a  .!..`..p..`..P..
	defb 0feh,000h,022h,001h,0c0h,0e2h,0d0h,0beh,0c0h,0aah,0b0h,099h,0c0h,088h,0b0h,077h	; 929a  .."............w
	defb 0a0h,066h,090h,055h,0ffh,0feh,000h,022h,002h,0d1h,0eeh,0d1h,0cch,0c1h,0eeh,0b1h	; 92aa  .f.U..."........
	defb 0ffh,0a1h,099h,091h,088h,081h,077h,071h,066h,061h,077h,051h,088h,041h,099h,0ffh	; 92ba  ......wqfawQ.A..
	defb 0feh,000h,022h,001h,0d1h,003h,0c1h,00dh,0c1h,006h,0ffh,0feh,000h,022h,001h,0d1h	; 92ca  ..".........."..
	defb 043h,0c1h,04dh,0c1h,046h,0ffh,0feh,000h,023h,001h,016h,0d0h,045h,022h,001h,0b0h	; 92da  C.M.F...#...E"..
	defb 040h,020h,003h,023h,001h,010h,0b0h,080h,012h,0b0h,088h,014h,0a0h,090h,016h,0a0h	; 92ea  @ .#............
	defb 098h,018h,0a0h,0a0h,01ah,090h,0a8h,01ch,090h,0b0h,01fh,090h,0b1h,080h,0b2h,080h	; 92fa  ................
	defb 0b3h,080h,0b5h,070h,0b9h,070h,0bdh,070h,0c1h,070h,0c8h,0ffh,0feh,000h,022h,001h	; 930a  ...p.p.p.p....".
	defb 0e0h,0a5h,0d0h,0adh,0c0h,0b5h,0a0h,0c5h,090h,0d5h,080h,0e5h,022h,002h,070h,0e5h	; 931a  ............".p.
	defb 061h,005h,051h,025h,051h,045h,0ffh,0feh,000h,022h,002h,0e3h,000h,0f5h,000h,020h	; 932a  a.Q%QE...".....
	defb 001h,023h,001h,010h,0e0h,030h,0e0h,031h,0d0h,02fh,0d0h,02eh,013h,0c0h,02dh,023h	; 933a  .#...0.1./....-#
	defb 002h,0c0h,02eh,016h,0b0h,02fh,0b0h,030h,0a0h,031h,0a0h,032h,023h,003h,01ah,090h	; 934a  ...../.0.1.2#...
	defb 033h,080h,034h,070h,035h,060h,036h,060h,037h,060h,038h,060h,039h,050h,03ah,0ffh	; 935a  3.4p5`6`7`8`9P:.
	defb 0feh,000h,023h,001h,01fh,0f0h,080h,0d0h,040h,0b0h,080h,090h,020h,022h,001h,0e2h	; 936a  ..#.....@... "..
	defb 000h,0d4h,000h,0d5h,000h,0d6h,000h,0d7h,000h,0d8h,000h,0d9h,000h,0dah,000h,0cbh	; 937a  ................
	defb 000h,0cch,000h,0ffh,0feh,000h,022h,001h,0f3h,000h,0e5h,000h,0e7h,000h,0e8h,000h	; 938a  ......".........
	defb 0fah,000h,0ech,000h,0e7h,000h,0d8h,000h,000h,000h,0f8h,000h,0ech,000h,000h,000h	; 939a  ................
	defb 0f4h,000h,0e7h,000h,0dch,000h,020h,001h,022h,001h,0f6h,000h,0e8h,000h,0eah,000h	; 93aa  ...... .".......
	defb 0dch,000h,000h,000h,0fah,000h,0ech,000h,0edh,000h,0deh,000h,0ffh,0feh,000h,020h	; 93ba  ...............
	defb 001h,022h,001h,0e0h,050h,0b0h,050h,070h,050h,0ffh,0efh,0d1h,0fbh,000h,0e2h,000h	; 93ca  ."..P.PpP.......
	defb 0b0h,0e3h,090h,0e2h,080h,0e3h,060h,0e2h,050h,0e3h,030h,0e2h,020h,0e3h,000h,0e2h	; 93da  ......`.P.0. ...
	defb 000h,0e3h,010h,0e2h,010h,0e3h,020h,0e2h,020h,0e3h,030h,0e2h,030h,0e3h,040h,0e2h	; 93ea  ...... . .0.0.@.
	defb 040h,0e3h,050h,0e2h,050h,0e3h,060h,0e2h,060h,0e3h,070h,0e2h,070h,0e3h,080h,0e2h	; 93fa  @.P.P.`.`.p.p...
	defb 080h,0e3h,090h,0e2h,090h,0e3h,0a0h,0e2h,0a0h,0e3h,0b0h,0e2h,0b0h,000h,0e1h,000h	; 940a  ................
	defb 0e2h,010h,0e1h,010h,0e2h,020h,0e1h,020h,0e2h,030h,0e1h,030h,0e2h,040h,0e1h,040h	; 941a  ..... . .0.0.@.@
	defb 0e2h,050h,0e1h,050h,0e2h,060h,0e1h,060h,0f9h,000h,0e2h,060h,0e1h,060h,0f7h,000h	; 942a  .P.P.`.`...`.`..
	defb 0e2h,060h,0e1h,060h,0f5h,000h,0e2h,060h,0e1h,060h,0f3h,000h,0e2h,060h,0e1h,060h	; 943a  .`.`...`.`...`.`
	defb 0ffh,0feh,000h,02ah,01bh,000h,013h,0a0h,070h,0ffh,0feh,000h,022h,001h,0c0h,080h	; 944a  ...*....p..."...
	defb 0c0h,071h,0c0h,05fh,0c0h,040h,0c0h,07bh,0c0h,06ch,0c0h,05bh,0c0h,03ch,0c0h,077h	; 945a  .q._.@.{.l.[.<.w
	defb 0c0h,067h,0c0h,056h,0c0h,038h,020h,002h,022h,003h,0c0h,030h,0b0h,02fh,0a0h,030h	; 946a  .g.V.8 ."..0./.0
	defb 090h,02fh,080h,030h,070h,02fh,060h,030h,050h,02fh,040h,030h,030h,02fh,0ffh,0feh	; 947a  ./.0p/`0P/@00/..
	defb 000h,022h,002h,0d0h,035h,0c0h,055h,0c0h,054h,0c0h,053h,0c0h,052h,0b0h,051h,0b0h	; 948a  ."..5.U.T.S.R.Q.
	defb 050h,0a0h,04fh,0a0h,04eh,0ffh,0feh,000h,022h,001h,0b0h,080h,090h,040h,020h,003h	; 949a  P.O.N..."....@ .
	defb 0feh,005h,0a2h,094h,0ffh,0feh,000h,022h,001h,0c0h,040h,0b0h,020h,020h,002h,0ffh	; 94aa  ......."..@.  ..
	defb 0feh,000h,022h,001h,0c0h,043h,0d0h,058h,0e0h,046h,0d0h,04ah,0d0h,04fh,0c0h,055h	; 94ba  .."..C.X.F.J.O.U
	defb 0c0h,05ch,020h,005h,022h,001h,090h,044h,0b0h,047h,0a0h,04bh,0a0h,050h,090h,056h	; 94ca  .\ ."..D.G.K.P.V
	defb 090h,05dh,020h,003h,022h,001h,060h,045h,080h,048h,070h,04ch,070h,051h,060h,057h	; 94da  .] .".`E.HpLpQ`W
	defb 060h,05eh,0ffh,0feh,000h,023h,001h,010h,0f2h,060h,021h,001h,012h,0b0h,000h,014h	; 94ea  `^...#...`!.....
	defb 090h,000h,016h,0a0h,000h,01ah,080h,000h,023h,002h,010h,0f3h,000h,021h,002h,013h	; 94fa  ........#....!..
	defb 090h,000h,016h,0c0h,000h,01ch,0b0h,000h,01fh,0a0h,000h,090h,000h,020h,001h,021h	; 950a  ............. .!
	defb 002h,010h,0b0h,000h,013h,080h,000h,016h,0a0h,000h,01ch,090h,000h,01fh,080h,000h	; 951a  ................
	defb 070h,000h,020h,002h,021h,002h,010h,090h,000h,013h,060h,000h,016h,080h,000h,01ch	; 952a  p. .!.....`.....
	defb 070h,000h,01fh,060h,000h,050h,000h,0ffh,0feh,000h,022h,003h,0d0h,055h,022h,001h	; 953a  p..`.P...."..U".
	defb 0d0h,053h,0d0h,051h,0d0h,04eh,0d0h,04bh,0d0h,048h,0d0h,044h,0d0h,040h,0d0h,03ch	; 954a  .S.Q.N.K.H.D.@.<
	defb 0d0h,039h,0d0h,035h,0a0h,055h,0a0h,053h,0a0h,051h,0a0h,04eh,0a0h,04bh,0a0h,048h	; 955a  .9.5.U.S.Q.N.K.H
	defb 0a0h,044h,0a0h,040h,0a0h,03ch,0a0h,039h,0a0h,035h,070h,055h,070h,053h,070h,051h	; 956a  .D.@.<.9.5pUpSpQ
	defb 070h,04eh,070h,04bh,070h,048h,070h,044h,070h,040h,070h,03ch,070h,039h,070h,035h	; 957a  pNpKpHpDp@p<p9p5
	defb 040h,055h,040h,053h,040h,051h,040h,04eh,040h,04bh,040h,048h,040h,044h,040h,040h	; 958a  @U@S@Q@N@K@H@D@@
	defb 040h,03ch,040h,039h,040h,035h,030h,055h,030h,053h,030h,051h,030h,04eh,030h,04bh	; 959a  @<@9@50U0S0Q0N0K
	defb 030h,048h,030h,044h,030h,040h,030h,039h,0ffh,0efh,0d1h,0fch,088h,0e1h,004h,074h	; 95aa  0H0D0@09.......t
	defb 044h,074h,0fch,023h,0e0h,009h,0ffh,0efh,0d7h,0f9h,014h,0e2h,0a0h,080h,0a0h,0e1h	; 95ba  Dt.#............
	defb 011h,0e2h,0a0h,080h,0a0h,0e1h,013h,003h,0feh,002h,0c3h,095h,0e2h,0a0h,080h,0a0h	; 95ca  ................
	defb 0e1h,012h,0e2h,0a0h,080h,0a0h,0e1h,032h,0e2h,0a0h,080h,0a0h,080h,0feh,002h,0d6h	; 95da  .......2........
	defb 095h,0e2h,0c0h,060h,080h,0a0h,0c0h,060h,085h,080h,0a0h,0e1h,010h,030h,0c0h,060h	; 95ea  ...`...`.....0.`
	defb 080h,0a0h,0c0h,060h,085h,080h,060h,050h,010h,0e2h,0a0h,080h,0a0h,0e1h,012h,0e2h	; 95fa  ...`..`P........
	defb 0a0h,080h,0a0h,0e1h,032h,0e2h,0a0h,080h,0a0h,080h,0feh,002h,003h,096h,0e2h,0c0h	; 960a  ....2...........
	defb 060h,080h,0a0h,0c0h,060h,085h,080h,0a0h,0e1h,010h,030h,0c0h,060h,080h,0a0h,0c0h	; 961a  `...`.....0.`...
	defb 060h,085h,080h,060h,050h,010h,0e2h,093h,042h,090h,0e1h,043h,042h,060h,04bh,022h	; 962a  `..`P...B..CB`K"
	defb 010h,022h,010h,0f9h,000h,0e2h,09ah,0d1h,0a0h,0b0h,0e1h,000h,010h,020h,030h,040h	; 963a  ."........... 0@
	defb 050h,060h,070h,080h,092h,0d7h,0f9h,013h,098h,071h,050h,030h,010h,0e2h,0a0h,0feh	; 964a  P`p......qP0....
	defb 0feh,0c3h,095h,0efh,0d7h,0fah,013h,0e3h,031h,0e2h,030h,030h,0e3h,031h,0e2h,030h	; 965a  ........1.00.1.0
	defb 030h,0e3h,061h,0e2h,060h,060h,0e3h,081h,0e2h,080h,080h,0feh,002h,061h,096h,0e3h	; 966a  0.a.``.......a..
	defb 031h,0e2h,030h,030h,0e3h,031h,0e2h,030h,030h,0e3h,061h,0e2h,060h,060h,0e3h,051h	; 967a  1.00.1.00.a.``.Q
	defb 0e2h,050h,050h,0feh,002h,079h,096h,0e3h,011h,0e2h,010h,010h,0e3h,011h,0e2h,010h	; 968a  .PP..y..........
	defb 010h,0e3h,061h,0e2h,060h,060h,0e3h,051h,0e2h,050h,050h,0feh,002h,091h,096h,0e3h	; 969a  ..a.``.Q.PP.....
	defb 031h,0e2h,030h,030h,0e3h,031h,0e2h,030h,030h,0e3h,061h,0e2h,060h,060h,0e3h,051h	; 96aa  1.00.1.00.a.``.Q
	defb 0e2h,050h,050h,0feh,002h,0a9h,096h,0e3h,011h,0e2h,010h,010h,0e3h,011h,0e2h,010h	; 96ba  .PP.............
	defb 010h,0e3h,061h,0e2h,060h,060h,0e3h,051h,0e2h,050h,050h,0feh,002h,0c1h,096h,0e3h	; 96ca  ..a.``.Q.PP.....
	defb 091h,0e2h,040h,040h,0e3h,091h,0e2h,010h,010h,0e3h,091h,0e2h,090h,090h,0e3h,091h	; 96da  ..@@............
	defb 0e2h,040h,040h,0e3h,071h,0e2h,070h,070h,0e3h,071h,0e2h,020h,020h,0e3h,071h,0e2h	; 96ea  .@@.q.pp.q.  .q.
	defb 070h,070h,0e3h,071h,0e2h,020h,020h,0e3h,061h,0e2h,060h,060h,0e3h,061h,0e2h,020h	; 96fa  pp.q.  .a.``.a.
	defb 020h,0e3h,061h,0e2h,060h,060h,0e3h,061h,0e2h,020h,020h,0e3h,051h,0e2h,050h,050h	; 970a   .a.``.a.  .Q.PP
	defb 0e3h,051h,0e2h,000h,000h,0e3h,071h,0e2h,070h,070h,0e3h,081h,0e2h,080h,080h,0feh	; 971a  .Q....q.pp......
	defb 0feh,061h,096h,0efh,0d7h,0f9h,014h,0e4h,031h,0e9h,000h,000h,040h,000h,0efh,0f9h	; 972a  .a......1...@...
	defb 014h,0e4h,030h,030h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,080h,080h	; 973a  ..00a...@.......
	defb 0feh,002h,031h,097h,0e4h,031h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,030h	; 974a  ..1..1...@.....0
	defb 030h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,050h,050h,0feh,002h,04eh	; 975a  0a...@.....PP..N
	defb 097h,0e4h,011h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,010h,010h,061h,0e9h	; 976a  ......@.......a.
	defb 000h,000h,040h,000h,0efh,0f9h,014h,0e4h,050h,050h,0feh,002h,06bh,097h,0e4h,031h	; 977a  ..@.....PP..k..1
	defb 0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,030h,030h,061h,0e9h,000h,000h,040h	; 978a  ...@.....00a...@
	defb 000h,0efh,0f9h,014h,0e4h,050h,050h,0feh,002h,088h,097h,0e4h,011h,0e9h,000h,000h	; 979a  .....PP.........
	defb 040h,000h,0efh,0f9h,014h,0e4h,010h,010h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h	; 97aa  @.......a...@...
	defb 014h,0e4h,050h,050h,0feh,002h,0a5h,097h,0e4h,091h,0e9h,000h,000h,040h,000h,0efh	; 97ba  ..PP.........@..
	defb 0f9h,014h,0e4h,090h,090h,091h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,090h	; 97ca  .........@......
	defb 090h,071h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,070h,070h,071h,0e9h,000h	; 97da  .q...@.....ppq..
	defb 000h,040h,000h,0efh,0f9h,014h,070h,070h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h	; 97ea  .@....ppa...@...
	defb 014h,0e4h,060h,060h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,060h,060h,051h	; 97fa  ..``a...@....``Q
	defb 0e9h,000h,000h,040h,000h,0efh,0f9h,014h,050h,050h,071h,0e9h,000h,000h,040h,000h	; 980a  ...@....PPq...@.
	defb 0efh,0f9h,014h,080h,080h,0feh,0feh,031h,097h,0efh,0d8h,0fah,022h,0e2h,050h,0e1h	; 981a  .......1....".P.
	defb 000h,0e2h,0a0h,0e1h,030h,0e2h,050h,0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,030h,0e1h	; 982a  ....0.P.....0.0.
	defb 000h,0e2h,0a0h,0e1h,030h,0e2h,030h,0e1h,000h,0e2h,0a0h,0e1h,030h,010h,0e2h,080h	; 983a  ....0.0.....0...
	defb 0e1h,010h,050h,030h,0e2h,0a0h,0e1h,030h,070h,057h,0e2h,051h,0e1h,001h,0e2h,0a1h	; 984a  ..P0...0pW.Q....
	defb 0e1h,031h,010h,000h,0e2h,0a1h,081h,0e1h,001h,0e2h,0a0h,080h,071h,051h,081h,070h	; 985a  .1..........qQ.p
	defb 050h,070h,080h,0a0h,080h,070h,000h,0feh,002h,054h,098h,0e2h,081h,0e1h,031h,031h	; 986a  Pp...p...T....11
	defb 010h,000h,0e2h,0a1h,0e1h,011h,003h,0e2h,051h,0e1h,001h,001h,0e2h,0a0h,0e1h,000h	; 987a  ........Q.......
	defb 010h,000h,0e2h,0a0h,080h,071h,0e1h,001h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h	; 988a  .....q...Q.....1
	defb 010h,000h,0e2h,0a1h,0e1h,001h,0e2h,081h,0e1h,051h,0e2h,081h,0e1h,031h,071h,057h	; 989a  .........Q...1qW
	defb 0e2h,050h,0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,050h,0e1h,000h,0e2h,0a0h,0e1h,030h	; 98aa  .P.....0.P.....0
	defb 0e2h,030h,0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,030h,0e1h,000h,0e2h,0a0h,0e1h,030h	; 98ba  .0.....0.0.....0
	defb 010h,0e2h,080h,0e1h,010h,050h,030h,0e2h,0a0h,0e1h,030h,070h,057h,0e2h,051h,0e1h	; 98ca  .....P0...0pW.Q.
	defb 001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h,0a1h,081h,0e1h,001h,0e2h,0a0h,080h,071h	; 98da  ....1..........q
	defb 051h,081h,070h,050h,070h,080h,0a0h,080h,070h,000h,0feh,002h,0d7h,098h,0e2h,081h	; 98ea  Q.pPp...p.......
	defb 0e1h,031h,031h,010h,000h,0e2h,0a1h,0e1h,011h,003h,0e2h,051h,0e1h,001h,001h,0e2h	; 98fa  .11........Q....
	defb 0a0h,0e1h,000h,010h,000h,0e2h,0a0h,080h,071h,0e1h,001h,0e2h,051h,0e1h,001h,0e2h	; 990a  ........q...Q...
	defb 0a1h,0e1h,031h,010h,000h,0e2h,0a1h,0e1h,001h,0e2h,081h,0e1h,051h,0e2h,081h,0e1h	; 991a  ..1.........Q...
	defb 031h,071h,057h,0f9h,013h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h	; 992a  1qW...Q.....1...
	defb 0a1h,081h,0e1h,001h,0e2h,080h,000h,0a0h,030h,0e1h,000h,0e2h,050h,0e1h,030h,0e2h	; 993a  ........0...P.0.
	defb 080h,0e1h,010h,000h,0e2h,030h,0e1h,010h,000h,0e2h,0a0h,040h,0e1h,000h,0fah,022h	; 994a  .....0.....@..."
	defb 0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h,0a1h,0e1h,001h,0e2h,081h	; 995a  .Q.....1........
	defb 0e1h,051h,0e2h,081h,0e1h,031h,071h,057h,0feh,0feh,027h,098h,0efh,0d8h,0fbh,021h	; 996a  .Q...1qW..'....!
	defb 0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h,011h,0e4h,0a1h,0e3h,011h	; 997a  .Q..q...........
	defb 001h,031h,050h,000h,0e4h,0a0h,0e3h,010h,000h,0e4h,0a0h,080h,070h,0fbh,016h,0e4h	; 998a  .1P.........p...
	defb 051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h,031h,011h,0e4h,0a1h,0e3h,001h	; 999a  Q..q......1.....
	defb 0e4h,081h,071h,051h,071h,001h,0feh,002h,097h,099h,0e4h,081h,0e3h,001h,011h,0e4h	; 99aa  ..qQq...........
	defb 0a1h,071h,0a1h,0e3h,001h,0e4h,081h,051h,081h,0a1h,071h,051h,081h,0a1h,071h,0e4h	; 99ba  .q.....Q..qQ..q.
	defb 051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h,031h,011h,0e4h,081h,0e3h,031h	; 99ca  Q..q......1....1
	defb 0e4h,0a1h,0e3h,051h,001h,0e4h,081h,001h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h	; 99da  ...Q.....Q..q...
	defb 0e4h,0a1h,0e3h,011h,0e4h,0a1h,0e3h,011h,001h,031h,050h,000h,0e4h,0a0h,0e3h,010h	; 99ea  .........1P.....
	defb 000h,0e4h,0a0h,080h,070h,0fbh,016h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h	; 99fa  ....p...Q..q....
	defb 0a1h,0e3h,031h,011h,0e4h,0a1h,0e3h,001h,0e4h,081h,071h,051h,071h,001h,0feh,002h	; 9a0a  ..1.......qQq...
	defb 0ffh,099h,0e4h,081h,0e3h,001h,011h,0e4h,0a1h,071h,0a1h,0e3h,001h,0e4h,081h,051h	; 9a1a  .........q.....Q
	defb 081h,0a1h,071h,051h,081h,0a1h,071h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h	; 9a2a  ..qQ..q.Q..q....
	defb 0a1h,0e3h,031h,011h,0e4h,081h,0e3h,031h,0e4h,0a1h,0e3h,051h,001h,0e4h,081h,001h	; 9a3a  ..1....1...Q....
	defb 0f9h,012h,0e2h,081h,0e1h,031h,031h,010h,000h,0e2h,0a1h,0e1h,011h,001h,0e2h,031h	; 9a4a  .....11........1
	defb 051h,071h,081h,0e1h,001h,0e3h,071h,051h,041h,001h,0fbh,016h,0e4h,051h,081h,0a1h	; 9a5a  Qq....qQA....Q..
	defb 071h,081h,0e3h,001h,0e4h,0a1h,0e3h,031h,011h,0e4h,081h,0e3h,031h,0e4h,0a1h,0e3h	; 9a6a  q......1....1...
	defb 051h,001h,0e4h,081h,001h,0feh,0feh,07ah,099h,0efh,0d8h,0f9h,035h,0e0h,050h,001h	; 9a7a  Q......z....5.P.
	defb 000h,000h,001h,000h,030h,001h,000h,000h,001h,000h,0e0h,050h,010h,050h,080h,070h	; 9a8a  ....0......P.P.p
	defb 030h,070h,0a0h,0e9h,070h,071h,070h,080h,080h,080h,080h,000h,000h,000h,000h,040h	; 9a9a  0p..pqp........@
	defb 000h,000h,000h,000h,000h,000h,000h,040h,000h,081h,0feh,006h,0a5h,09ah,000h,000h	; 9aaa  .......@........
	defb 000h,000h,040h,000h,000h,000h,000h,000h,000h,000h,030h,000h,081h,000h,000h,000h	; 9aba  ..@.......0.....
	defb 000h,040h,000h,000h,000h,070h,070h,070h,070h,080h,080h,080h,080h,000h,000h,000h	; 9aca  .@...pppp.......
	defb 000h,040h,000h,000h,000h,000h,000h,000h,000h,030h,000h,081h,000h,000h,000h,000h	; 9ada  .@.......0......
	defb 040h,000h,000h,000h,070h,071h,070h,080h,080h,080h,080h,000h,000h,000h,000h,040h	; 9aea  @...pqp........@
	defb 000h,000h,000h,000h,000h,000h,000h,040h,000h,081h,0feh,006h,0f5h,09ah,000h,000h	; 9afa  .......@........
	defb 000h,000h,040h,000h,000h,000h,000h,000h,000h,000h,030h,000h,081h,000h,000h,000h	; 9b0a  ..@.......0.....
	defb 000h,040h,000h,000h,000h,070h,070h,070h,070h,080h,080h,080h,080h,0efh,0d8h,0f9h	; 9b1a  .@...pppp.......
	defb 012h,0e3h,051h,0e2h,001h,001h,0e3h,0a0h,080h,071h,0a1h,081h,001h,011h,031h,051h	; 9b2a  ..Q......q....1Q
	defb 081h,0e9h,070h,071h,070h,080h,080h,080h,080h,000h,000h,000h,000h,040h,000h,000h	; 9b3a  ..pqp........@..
	defb 000h,000h,000h,000h,000h,030h,000h,081h,000h,000h,000h,000h,040h,000h,000h,000h	; 9b4a  .....0......@...
	defb 070h,071h,070h,080h,080h,080h,080h,0feh,002h,043h,09bh,0feh,0feh,0a5h,09ah,0efh	; 9b5a  pqp......C......
	defb 0d7h,0fah,023h,0e2h,041h,040h,040h,020h,000h,0feh,003h,06bh,09bh,070h,053h,050h	; 9b6a  ..#.A@@ ...k.pSP
	defb 042h,040h,020h,000h,0e1h,002h,000h,0e2h,070h,0e1h,000h,002h,030h,020h,000h,041h	; 9b7a  B@ .....p...0 .A
	defb 000h,0e2h,070h,0e1h,000h,040h,070h,001h,002h,001h,040h,051h,040h,070h,001h,002h	; 9b8a  ..p..@p...@Q@p..
	defb 001h,040h,051h,040h,040h,020h,000h,071h,000h,040h,020h,000h,070h,000h,000h,080h	; 9b9a  .@Q@@ .q.@ .p...
	defb 070h,050h,030h,020h,000h,041h,000h,0e2h,070h,0e1h,000h,040h,031h,070h,081h,070h	; 9baa  pP0 .A..p..@1p.p
	defb 0a2h,0a0h,080h,070h,081h,070h,034h,030h,030h,0e2h,0a0h,0e1h,030h,032h,030h,0e2h	; 9bba  ...p.p400...020.
	defb 0a0h,0e1h,030h,031h,030h,030h,0e2h,0a0h,0e1h,030h,032h,060h,050h,030h,081h,060h	; 9bca  ..0100...02`P0.`
	defb 051h,070h,041h,040h,040h,020h,000h,0feh,003h,0dch,09bh,070h,053h,050h,042h,040h	; 9bda  QpA@@ .....pSPB@
	defb 020h,000h,082h,080h,030h,080h,0a2h,0e0h,020h,000h,0e1h,0a0h,0e0h,001h,0e1h,070h	; 9bea   ...0... ......p
	defb 040h,000h,0e2h,070h,0feh,0feh,06bh,09bh,0efh,0d7h,0fbh,015h,0e3h,001h,000h,000h	; 9bfa  @..p..k.........
	defb 000h,000h,0e4h,0a1h,0a0h,0a0h,0a0h,0a0h,091h,090h,090h,090h,090h,0a1h,0a0h,0a0h	; 9c0a  ................
	defb 0a0h,0a0h,0e3h,001h,000h,000h,000h,000h,0e4h,0a1h,0a0h,0a0h,0a0h,0a0h,081h,080h	; 9c1a  ................
	defb 0a1h,0a0h,0e3h,001h,000h,000h,000h,000h,001h,000h,000h,000h,000h,0e4h,0a1h,0a0h	; 9c2a  ................
	defb 0a0h,0a0h,0a0h,091h,090h,090h,090h,090h,081h,080h,080h,080h,080h,0e3h,001h,000h	; 9c3a  ................
	defb 000h,000h,000h,0e4h,0a1h,0a0h,0a0h,0a0h,0a0h,081h,080h,0a1h,0a0h,0e3h,001h,000h	; 9c4a  ................
	defb 000h,000h,000h,0e3h,031h,030h,030h,030h,030h,0feh,002h,05dh,09ch,011h,010h,010h	; 9c5a  ....10000..]....
	defb 010h,010h,0feh,002h,067h,09ch,001h,000h,000h,000h,000h,0feh,002h,070h,09ch,0e4h	; 9c6a  ....g........p..
	defb 0b1h,0b0h,0b0h,0b0h,0b0h,0b1h,0b0h,0e3h,010h,011h,001h,000h,000h,000h,000h,0e4h	; 9c7a  ................
	defb 0a1h,0a0h,0a0h,0a0h,0a0h,091h,090h,090h,090h,090h,081h,080h,0a1h,0a0h,0e3h,001h	; 9c8a  ................
	defb 000h,000h,000h,000h,0e4h,081h,080h,080h,080h,080h,0a1h,0a0h,0a0h,0a0h,0a0h,0e3h	; 9c9a  ................
	defb 001h,000h,000h,000h,000h,0feh,0feh,004h,09ch,0d7h,0e9h,001h,000h,041h,000h,0feh	; 9caa  .............A..
	defb 007h,0b5h,09ch,001h,000h,040h,081h,001h,000h,041h,000h,0feh,004h,0c1h,09ch,001h	; 9cba  .....@...A......
	defb 000h,040h,020h,000h,0feh,002h,0c9h,09ch,070h,070h,070h,070h,070h,070h,080h,080h	; 9cca  .@ .....pppppp..
	defb 080h,080h,080h,080h,001h,000h,041h,000h,0feh,007h,0deh,09ch,001h,000h,040h,040h	; 9cda  ......A.......@@
	defb 040h,001h,000h,041h,000h,0feh,007h,0ebh,09ch,070h,070h,070h,080h,080h,080h,0feh	; 9cea  @..A.....ppp....
	defb 0feh,0b5h,09ch,0efh,0d7h,0fah,023h,0e2h,000h,070h,0e1h,000h,0e2h,070h,0e1h,020h	; 9cfa  ......#..p...p.
	defb 040h,000h,0e2h,001h,050h,0a0h,050h,0e1h,000h,020h,0e2h,0a1h,0e3h,080h,0e2h,030h	; 9d0a  @...P.P.. .....0
	defb 080h,030h,0a0h,0e1h,000h,0e2h,080h,0e3h,0a1h,0e2h,050h,0a0h,050h,0a0h,090h,0a0h	; 9d1a  .0........P.P...
	defb 0b0h,0f9h,013h,0e2h,000h,070h,0e1h,000h,0e2h,070h,0e1h,020h,040h,000h,0e2h,001h	; 9d2a  .....p...p. @...
	defb 050h,0a0h,050h,0e1h,000h,020h,0e2h,0a1h,0e3h,080h,0e2h,030h,080h,030h,0a0h,0e1h	; 9d3a  P.P.. .....0.0..
	defb 000h,0e2h,080h,0e3h,0a1h,0e2h,050h,0a0h,050h,0a0h,090h,0a0h,0b0h,0d7h,0fah,023h	; 9d4a  ......P.P......#
	defb 0e2h,051h,071h,050h,040h,000h,0e1h,00ah,0e2h,0a0h,0a2h,070h,0a0h,081h,071h,080h	; 9d5a  .QqP@......p..q.
	defb 070h,050h,040h,0e2h,051h,041h,050h,040h,050h,070h,0e1h,00dh,0e2h,0a0h,077h,050h	; 9d6a  pP@.QAP@Pp....wP
	defb 0e2h,051h,041h,050h,040h,000h,0e1h,00ah,0e2h,0a0h,0a1h,000h,070h,0a0h,081h,071h	; 9d7a  .QAP@.......p..q
	defb 080h,070h,050h,040h,0e2h,051h,041h,050h,0e1h,000h,070h,0e0h,00eh,0e1h,0a0h,078h	; 9d8a  .pP@.QAP..p....x
	defb 0feh,002h,02bh,09dh,0f9h,013h,0e2h,000h,070h,0e1h,000h,0e2h,070h,0e1h,020h,040h	; 9d9a  ..+.....p...p. @
	defb 000h,0e2h,001h,050h,0a0h,050h,0e1h,000h,020h,0e2h,0a1h,0e3h,080h,0e2h,030h,080h	; 9daa  ...P.P.. .....0.
	defb 030h,0a0h,0e1h,000h,0e2h,080h,0e3h,0a1h,0e2h,050h,0a0h,050h,0a0h,090h,0a0h,0b0h	; 9dba  0........P.P....
	defb 0feh,002h,0a0h,09dh,0e2h,020h,090h,0e1h,020h,0e2h,090h,0e1h,040h,060h,020h,0e2h	; 9dca  ..... .. ...@` .
	defb 001h,070h,0e1h,000h,0e2h,070h,0e1h,020h,040h,001h,0e3h,0a0h,0e2h,050h,0a0h,050h	; 9dda  .p...p. @....P.P
	defb 0e1h,000h,020h,0e2h,0a0h,001h,070h,0e1h,000h,0e2h,070h,0e1h,000h,0e2h,0b0h,0e1h	; 9dea  .. ...p...p.....
	defb 000h,010h,0e2h,020h,090h,0e1h,020h,0e2h,090h,0e1h,040h,060h,020h,0e2h,001h,070h	; 9dfa  ... .. ...@` ..p
	defb 0e1h,000h,0e2h,070h,0e1h,020h,040h,001h,0e3h,0a0h,0e2h,050h,0a0h,050h,0e1h,000h	; 9e0a  ...p. @....P.P..
	defb 020h,0e2h,0a0h,001h,070h,0e1h,000h,0e2h,070h,0d5h,0e1h,040h,050h,060h,0e0h,000h	; 9e1a   ...p...p..@P`..
	defb 070h,0c1h,0f7h,013h,070h,0c1h,0f6h,013h,070h,0c1h,0f5h,013h,070h,0c1h,0f3h,013h	; 9e2a  p...p...p...p...
	defb 070h,0c0h,0feh,0feh,057h,09dh,0efh,0d7h,0fbh,024h,0e3h,001h,001h,001h,0e4h,000h	; 9e3a  p...W....$......
	defb 000h,0a2h,0a0h,030h,030h,080h,030h,0e4h,081h,081h,081h,0e5h,080h,080h,0e4h,0a2h	; 9e4a  ...00.0.........
	defb 0a0h,0fbh,015h,050h,040h,050h,0b0h,0fbh,025h,0e3h,001h,001h,001h,0e4h,000h,000h	; 9e5a  ...P@P..%.......
	defb 0a2h,0a0h,0fah,026h,030h,030h,080h,030h,0fbh,025h,0e4h,081h,081h,081h,0e5h,080h	; 9e6a  ...&00.0.%......
	defb 080h,0e4h,0a2h,0a0h,0fah,016h,050h,040h,050h,0b0h,0d7h,0fbh,025h,0e3h,001h,001h	; 9e7a  ......P@P...%...
	defb 001h,0e4h,000h,000h,0a2h,0a0h,0fah,026h,030h,030h,080h,030h,0fbh,025h,0e4h,081h	; 9e8a  .......&00.0.%..
	defb 081h,081h,0e5h,080h,080h,0e4h,0a2h,0a0h,0fah,026h,050h,040h,050h,0b0h,0feh,00bh	; 9e9a  .........&P@P...
	defb 084h,09eh,0fbh,025h,0e3h,021h,021h,021h,0e4h,020h,020h,0e3h,002h,000h,0fah,026h	; 9eaa  ...%.!!!.  ....&
	defb 0e4h,050h,050h,0a0h,050h,0fbh,025h,0e4h,0a1h,0a1h,0a1h,0e5h,0a0h,0a0h,0e3h,002h	; 9eba  .PP.P.%.........
	defb 000h,0fah,026h,0e4h,070h,060h,070h,0e3h,000h,0fbh,025h,0e3h,021h,021h,021h,0e4h	; 9eca  ..&.p`p...%.!!!.
	defb 020h,020h,0e3h,002h,000h,0fah,026h,0e4h,050h,050h,0a0h,050h,0fbh,025h,0e4h,0a1h	; 9eda    ....&.PP.P.%..
	defb 0a1h,0a1h,0e5h,0a0h,0a0h,0e3h,002h,000h,0d5h,0fbh,026h,0e4h,070h,090h,0a0h,0e3h	; 9eea  ..........&.p...
	defb 000h,050h,0c1h,0f9h,025h,050h,0c1h,0f7h,025h,050h,0c1h,0f5h,025h,050h,0c1h,0f3h	; 9efa  .P..%P..%P..%P..
	defb 025h,050h,0c0h,0feh,0feh,084h,09eh,0feh,000h,022h,002h,090h,024h,080h,024h,070h	; 9f0a  %P......."..$.$p
	defb 024h,020h,001h,0feh,000h,0d7h,0ebh,060h,0feh,000h,022h,002h,090h,028h,080h,028h	; 9f1a  $ .....`.."..(.(
	defb 070h,028h,020h,001h,0feh,000h,0d7h,0ebh,050h,0feh,000h,022h,002h,090h,02dh,080h	; 9f2a  p( .....P.."..-.
	defb 02dh,070h,02dh,020h,001h,0feh,000h,0d7h,0ebh,030h,010h,0feh,000h,022h,002h,090h	; 9f3a  -p- .....0..."..
	defb 036h,080h,036h,070h,036h,020h,001h,022h,002h,090h,039h,080h,039h,070h,039h,020h	; 9f4a  6.6p6 ."..9.9p9
	defb 001h,022h,002h,090h,03ch,080h,03ch,070h,03ch,020h,001h,022h,002h,090h,040h,080h	; 9f5a  ."..<.<p< ."..@.
	defb 040h,070h,040h,020h,001h,022h,002h,090h,043h,080h,043h,070h,043h,020h,001h,022h	; 9f6a  @p@ ."..C.CpC ."
	defb 002h,090h,047h,080h,047h,070h,047h,020h,001h,022h,002h,090h,04ch,080h,04ch,070h	; 9f7a  ..G.GpG ."..L.Lp
	defb 04ch,020h,001h,022h,002h,090h,050h,080h,050h,070h,050h,020h,001h,022h,002h,090h	; 9f8a  L ."..P.PpP ."..
	defb 055h,080h,055h,070h,055h,020h,001h,0feh,000h,0d3h,0e9h,070h,070h,070h,073h,0d7h	; 9f9a  U.UpU .....ppps.
	defb 060h,060h,060h,060h,060h,080h,080h,080h,080h,090h,090h,090h,090h,000h,000h,000h	; 9faa  `````...........
	defb 000h,040h,000h,080h,081h,000h,000h,000h,040h,000h,000h,000h,0feh,002h,0b7h,09fh	; 9fba  .@......@.......
	defb 0d7h,0e9h,071h,051h,061h,050h,051h,000h,000h,000h,040h,000h,000h,000h,000h,000h	; 9fca  ..qQaPQ...@.....
	defb 000h,000h,040h,000h,080h,081h,000h,000h,000h,040h,000h,000h,000h,0feh,009h,0d8h	; 9fda  ..@......@......
	defb 09fh,071h,051h,061h,050h,051h,000h,000h,000h,040h,000h,000h,000h,000h,000h,000h	; 9fea  .qQaPQ...@......
	defb 000h,040h,000h,080h,081h,000h	; 9ffa
