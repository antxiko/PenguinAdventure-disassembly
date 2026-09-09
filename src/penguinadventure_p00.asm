; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS sin identificar  0x4000..0x4023  (35 bytes)
DATA_4000:
	defb 041h,042h,06ah,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  ABj@............
	defb 043h,044h,007h,043h,060h,000h,0e0h,004h,092h,0e0h,00dh,090h,0e0h,083h,0e0h,086h	; 4010  CD.C`...........
	defb 0e0h,0f7h,040h	; 4020

; ======================================================================
; CODIGO 0x4023..0x40f7  (212 bytes)
; ======================================================================


L_4023:
	call 0013eh		;4023   ; BIOS RDVDP - Reads VDP status register
	di			;4026
	ld a,00eh		;4027
	ld (08000h),a		;4029
	inc a			;402c
	ld (0a000h),a		;402d
	call 08082h		;4030
	di			;4033
	ld a,(0f0f2h)		;4034
	ld (08000h),a		;4037
	ld a,(0f0f3h)		;403a
	ld (0a000h),a		;403d
	ld hl,0e005h		;4040
	bit 0,(hl)		;4043
	jr nz,L_4053		;4045
	inc (hl)			;4047
	ei			;4048
	call L_44BB		;4049
	call 08000h		;404c
	xor a			;404f
	ld (0e005h),a		;4050
L_4053:
	ei			;4053
	ret			;4054
L_4055:
	add a,a			;4055
L_4056:
	add a,l			;4056
	ld l,a			;4057
	ret nc			;4058
	inc h			;4059
	ret			;405a
L_405B:
	add a,e			;405b
	ld e,a			;405c
	ret nc			;405d
	inc d			;405e
	ret			;405f
L_4060:
	pop hl			;4060
	add a,a			;4061
	call L_4056		;4062
	ld e,(hl)			;4065
	inc hl			;4066
	ld d,(hl)			;4067
	ex de,hl			;4068
	jp (hl)			;4069
L_406A:
	di			;406a
	im 1		;406b
	di			;406d
	push hl			;406e
	ld hl,0f0f1h		;406f
	ld a,001h		;4072
	ld (06000h),a		;4074
	ld (hl),a			;4077
	inc a			;4078
	ld (08000h),a		;4079
	inc hl			;407c
	ld (hl),a			;407d
	inc a			;407e
	ld (0a000h),a		;407f
	inc hl			;4082
	ld (hl),a			;4083
	pop hl			;4084
	ei			;4085
	call 00138h		;4086   ; BIOS RSLREG - Reads the primary slot register
	rrca			;4089
	rrca			;408a
	and 003h		;408b
	ld c,a			;408d
	ld hl,0fcc1h		;408e
	add a,l			;4091
	ld l,a			;4092
	ld a,(hl)			;4093
	and 080h		;4094
	or c			;4096
	ld c,a			;4097
	inc l			;4098
	inc l			;4099
	inc l			;409a
	inc l			;409b
	ld a,(hl)			;409c
	and 00ch		;409d
	or c			;409f
	ld h,080h		;40a0
	call 00024h		;40a2   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,0c3h		;40a5
	ld (0fd9ah),a		;40a7
	ld hl,L_4023		;40aa
	ld (0fd9bh),hl		;40ad
	ld hl,0e000h		;40b0
	ld de,0e001h		;40b3
	ld bc,010efh		;40b6
	xor a			;40b9
	ld (hl),a			;40ba
	ldir		;40bb
	ld (0f0f7h),a		;40bd
	ex de,hl			;40c0
	ld sp,hl			;40c1
	ld hl,0f0f1h		;40c2
	ld de,0f0f2h		;40c5
	ld bc,0000fh		;40c8
	ld (hl),a			;40cb
	ldir		;40cc
	inc a			;40ce
	ld (0e005h),a		;40cf
	call L_4485		;40d2
	xor a			;40d5
	ld (0e005h),a		;40d6
	call 0013eh		;40d9   ; BIOS RDVDP - Reads VDP status register
	di			;40dc
	push hl			;40dd
	ld hl,0f0f1h		;40de
	ld a,001h		;40e1
	ld (06000h),a		;40e3
	ld (hl),a			;40e6
	inc a			;40e7
	ld (08000h),a		;40e8
	inc hl			;40eb
	ld (hl),a			;40ec
	inc a			;40ed
	ld (0a000h),a		;40ee
	inc hl			;40f1
	ld (hl),a			;40f2
	pop hl			;40f3
	ei			;40f4
L_40F5:
	jr L_40F5		;40f5

; ----------------------------------------------------------------------
; DATOS sin identificar  0x40f7..0x413a  (67 bytes)
DATA_40F7:
	defb 03ah,01ah,0d3h,0a7h,020h,004h,03ch,032h,092h,0e0h,03ah,092h,0e0h,03dh,021h,020h	; 40f7  :... .<2..:..=!
	defb 041h,0cdh,056h,040h,07eh,032h,091h,0e0h,03ah,092h,0e0h,03dh,021h,02dh,041h,0cdh	; 4107  A.V@~2..:..=!-A.
	defb 056h,040h,07eh,032h,093h,0e0h,0c3h,0e3h,046h,001h,002h,003h,004h,005h,006h,007h	; 4117  V@~2....F.......
	defb 008h,009h,010h,011h,012h,013h,001h,002h,003h,001h,002h,003h,001h,002h,003h,001h	; 4127  ................
	defb 002h,003h,001h	; 4137

; ======================================================================
; CODIGO 0x413a..0x422f  (245 bytes)
; ======================================================================


L_413A:
	di			;413a
	push hl			;413b
	ld hl,0e002h		;413c
	bit 6,(hl)		;413f
	jr z,L_4189		;4141
	jr L_4147		;4143
L_4145:
	di			;4145
	push hl			;4146
L_4147:
	push de			;4147
	push bc			;4148
	push ix		;4149
	push iy		;414b
	push af			;414d
	ld a,(0f0f2h)		;414e
	ld (0f0f4h),a		;4151
	ld a,(0f0f3h)		;4154
	ld (0f0f5h),a		;4157
	ld a,00eh		;415a
	ld (08000h),a		;415c
	ld (0f0f2h),a		;415f
	ld a,00fh		;4162
	ld (0a000h),a		;4164
	ld (0f0f3h),a		;4167
	pop af			;416a
	push af			;416b
	call 086bah		;416c
	di			;416f
	ld a,(0f0f4h)		;4170
	ld (08000h),a		;4173
	ld (0f0f2h),a		;4176
	ld a,(0f0f5h)		;4179
	ld (0a000h),a		;417c
	ld (0f0f3h),a		;417f
	pop af			;4182
	pop iy		;4183
	pop ix		;4185
	pop bc			;4187
	pop de			;4188
L_4189:
	pop hl			;4189
	ei			;418a
	ret			;418b
L_418C:
	ld e,(hl)			;418c
	inc hl			;418d
	ld d,(hl)			;418e
	inc hl			;418f
L_4190:
	ld a,(hl)			;4190
	and a			;4191
	ret z			;4192
	inc hl			;4193
	ld b,a			;4194
	and 07fh		;4195
	cp b			;4197
	jr z,L_41A4		;4198
	and a			;419a
	jr z,L_418C		;419b
	ld b,000h		;419d
	ld c,a			;419f
	ldir		;41a0
	jr L_4190		;41a2
L_41A4:
	ld a,(hl)			;41a4
	inc hl			;41a5
L_41A6:
	ld (de),a			;41a6
	inc de			;41a7
	djnz L_41A6		;41a8
	jr L_4190		;41aa
L_41AC:
	inc hl			;41ac
L_41AD:
	ld e,(hl)			;41ad
	inc hl			;41ae
	ld d,(hl)			;41af
	inc hl			;41b0
L_41B1:
	ld a,(hl)			;41b1
	inc a			;41b2
	ret z			;41b3
	inc a			;41b4
	jr z,L_41AC		;41b5
	ld a,001h		;41b7
	ld (de),a			;41b9
	inc de			;41ba
	inc hl			;41bb
	jr L_41B1		;41bc
L_41BE:
	inc hl			;41be
L_41BF:
	ld e,(hl)			;41bf
	inc hl			;41c0
	ld d,(hl)			;41c1
	inc hl			;41c2
L_41C3:
	ld a,(hl)			;41c3
	inc a			;41c4
	ret z			;41c5
	inc a			;41c6
	jr z,L_41BE		;41c7
	ldi		;41c9
	jr L_41C3		;41cb
L_41CD:
	di			;41cd
	push hl			;41ce
	ld hl,0f0f1h		;41cf
	ld a,004h		;41d2
	ld (06000h),a		;41d4
	ld (hl),a			;41d7
	inc a			;41d8
	ld (08000h),a		;41d9
	inc hl			;41dc
	ld (hl),a			;41dd
	inc a			;41de
	ld (0a000h),a		;41df
	inc hl			;41e2
	ld (hl),a			;41e3
	pop hl			;41e4
	ei			;41e5
	ld a,c			;41e6
	add a,a			;41e7
	add a,a			;41e8
	add a,a			;41e9
	push af			;41ea
	ld de,0bd89h		;41eb
	call L_405B		;41ee
	ld hl,03718h		;41f1
	ld bc,00008h		;41f4
	call L_428F		;41f7
	pop af			;41fa
	ld de,0bda9h		;41fb
	call L_405B		;41fe
	ld hl,01718h		;4201
	ld bc,00008h		;4204
	call L_428F		;4207
	di			;420a
	push hl			;420b
	ld hl,0f0f1h		;420c
	ld a,001h		;420f
	ld (06000h),a		;4211
	ld (hl),a			;4214
	inc a			;4215
	ld (08000h),a		;4216
	inc hl			;4219
	ld (hl),a			;421a
	inc a			;421b
	ld (0a000h),a		;421c
	inc hl			;421f
	ld (hl),a			;4220
	pop hl			;4221
	ei			;4222
	ret			;4223
L_4224:
	call L_42ED		;4224
	ld hl,03800h		;4227
	ld bc,00300h		;422a
	jr $+11		;422d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x422f..0x4232  (3 bytes)
DATA_422F:
	defb 0cdh,0edh,042h	; 422f

; ======================================================================
; CODIGO 0x4232..0x44ae  (636 bytes)
; ======================================================================


L_4232:
	ld hl,03860h		;4232
	ld bc,002a0h		;4235
L_4238:
	xor a			;4238
	jp 00056h		;4239   ; BIOS FILVRM - Fills VRAM with value
L_423C:
	call 00053h		;423c   ; BIOS SETWRT - Enables VDP to write
	ld a,(00007h)		;423f
	ld c,a			;4242
	ret			;4243
L_4244:
	ex de,hl			;4244
	ld e,(hl)			;4245
	inc hl			;4246
	ld d,(hl)			;4247
	ex de,hl			;4248
	inc de			;4249
	ret			;424a
L_424B:
	ld hl,03820h		;424b
	call L_423C		;424e
	ld hl,0eba0h		;4251
	ld a,002h		;4254
	jr L_4270		;4256
L_4258:
	ld hl,03900h		;4258
	call L_423C		;425b
	ld hl,0ec80h		;425e
	ld a,010h		;4261
	jr L_4270		;4263
L_4265:
	ld hl,03860h		;4265
	call L_423C		;4268
	ld hl,0ebe0h		;426b
	ld a,015h		;426e
L_4270:
	ld d,040h		;4270
L_4272:
	ld b,d			;4272
L_4273:
	outi		;4273
	djnz L_4273		;4275
	dec a			;4277
	jr nz,L_4272		;4278
	ret			;427a
L_427B:
	ld hl,03860h		;427b
	call L_423C		;427e
	xor a			;4281
	ld d,015h		;4282
L_4284:
	ld b,020h		;4284
L_4286:
	out (c),a		;4286
	nop			;4288
	djnz L_4286		;4289
	dec d			;428b
	jr nz,L_4284		;428c
	ret			;428e
L_428F:
	ex de,hl			;428f
	jp 0005ch		;4290   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_4293:
	ld d,003h		;4293
L_4295:
	push bc			;4295
	push de			;4296
	call 00056h		;4297   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;429a
	add hl,de			;429d
	pop de			;429e
	pop bc			;429f
	dec d			;42a0
	jr nz,L_4295		;42a1
	ret			;42a3
L_42A4:
	ld c,001h		;42a4
	jr L_42AA		;42a6
L_42A8:
	ld c,000h		;42a8
L_42AA:
	ld b,003h		;42aa
L_42AC:
	push bc			;42ac
	push de			;42ad
	push hl			;42ae
	call L_4386		;42af
	pop hl			;42b2
	ld a,008h		;42b3
	add a,h			;42b5
	ld h,a			;42b6
	pop de			;42b7
	pop bc			;42b8
	djnz L_42AC		;42b9
	ret			;42bb
L_42BC:
	ld c,0ffh		;42bc
L_42BE:
	call L_4244		;42be
L_42C1:
	ld a,(de)			;42c1
	inc de			;42c2
	ld b,a			;42c3
	inc b			;42c4
	ret z			;42c5
	inc b			;42c6
	jr z,L_42BE		;42c7
	and c			;42c9
	call 0004dh		;42ca   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;42cd
	jr L_42C1		;42ce
L_42D0:
	ld a,0e0h		;42d0
	ld hl,0ee90h		;42d2
	ld b,01ch		;42d5
L_42D7:
	ld (hl),a			;42d7
	inc l			;42d8
	inc l			;42d9
	inc l			;42da
	inc l			;42db
	djnz L_42D7		;42dc
	ret			;42de
L_42DF:
	call L_42D0		;42df
	call 07dd5h		;42e2
	jp L_4332		;42e5
L_42E8:
	call L_42D0		;42e8
	jr L_42FB		;42eb
L_42ED:
	ld hl,0ee80h		;42ed
	ld b,020h		;42f0
	ld a,0e0h		;42f2
L_42F4:
	ld (hl),a			;42f4
	inc l			;42f5
	inc l			;42f6
	inc l			;42f7
	inc l			;42f8
	djnz L_42F4		;42f9
L_42FB:
	ld a,(0e203h)		;42fb
	cp 004h		;42fe
	jr z,L_430E		;4300
	ld hl,03b00h		;4302
	ld de,0ee80h		;4305
	ld bc,00080h		;4308
	jp L_428F		;430b
L_430E:
	ld hl,03b00h		;430e
	ld de,0ee90h		;4311
	ld bc,00008h		;4314
	call L_428F		;4317
	ld hl,03b08h		;431a
	ld de,0ee80h		;431d
	ld bc,00010h		;4320
	call L_428F		;4323
	ld hl,03b18h		;4326
	ld de,0ee98h		;4329
	ld bc,00068h		;432c
	jp L_428F		;432f
L_4332:
	ld a,(0e203h)		;4332
	cp 010h		;4335
	jr z,L_4351		;4337
	ld hl,03b00h		;4339
	ld de,0eee0h		;433c
	ld bc,00020h		;433f
	call L_428F		;4342
	ld hl,03b20h		;4345
	ld de,0ee80h		;4348
	ld bc,00060h		;434b
	jp L_428F		;434e
L_4351:
	ld hl,03b00h		;4351
	ld de,0eee0h		;4354
	ld bc,00020h		;4357
	call L_428F		;435a
	ld hl,03b20h		;435d
	ld de,0ee98h		;4360
	ld bc,00004h		;4363
	call L_428F		;4366
	ld hl,03b24h		;4369
	ld de,0ee80h		;436c
	ld bc,00018h		;436f
	call L_428F		;4372
	ld hl,03b3ch		;4375
	ld de,0ee9ch		;4378
	ld bc,00044h		;437b
	jp L_428F		;437e
L_4381:
	ld c,000h		;4381
	call L_4244		;4383
L_4386:
	call 00053h		;4386   ; BIOS SETWRT - Enables VDP to write
	exx			;4389
	ld a,(00007h)		;438a
	ld c,a			;438d
	exx			;438e
L_438F:
	ld a,(de)			;438f
	and a			;4390
	ret z			;4391
	inc de			;4392
	ld b,a			;4393
	and 07fh		;4394
	cp b			;4396
	jr z,L_43A8		;4397
	and a			;4399
	jr z,L_4381		;439a
	ld b,a			;439c
L_439D:
	call L_43F9		;439d
	exx			;43a0
	out (c),a		;43a1
	exx			;43a3
	djnz L_439D		;43a4
	jr L_438F		;43a6
L_43A8:
	call L_43F9		;43a8
L_43AB:
	exx			;43ab
	out (c),a		;43ac
	exx			;43ae
	djnz L_43AB		;43af
	jr L_438F		;43b1
L_43B3:
	call L_4244		;43b3
	call 00053h		;43b6   ; BIOS SETWRT - Enables VDP to write
	ld h,c			;43b9
	ld l,b			;43ba
	ld a,(00007h)		;43bb
	ld c,a			;43be
L_43BF:
	push de			;43bf
	xor a			;43c0
	call L_43E6		;43c1
	bit 0,h		;43c4
	jr z,L_43D3		;43c6
	push de			;43c8
	xor a			;43c9
	call L_43E6		;43ca
	pop de			;43cd
	ld a,001h		;43ce
	call L_43E6		;43d0
L_43D3:
	pop de			;43d3
	ld a,001h		;43d4
	call L_43E6		;43d6
	bit 0,h		;43d9
	jr z,L_43E2		;43db
	ld a,010h		;43dd
	call L_405B		;43df
L_43E2:
	dec l			;43e2
	jr nz,L_43BF		;43e3
	ret			;43e5
L_43E6:
	push hl			;43e6
	ld b,010h		;43e7
	ld h,a			;43e9
L_43EA:
	push hl			;43ea
	ld a,(de)			;43eb
	bit 0,h		;43ec
	call nz,L_4402		;43ee
	inc de			;43f1
	out (c),a		;43f2
	pop hl			;43f4
	djnz L_43EA		;43f5
	pop hl			;43f7
	ret			;43f8
L_43F9:
	ld a,(de)			;43f9
	inc de			;43fa
	bit 7,c		;43fb
	jr nz,L_440D		;43fd
	bit 0,c		;43ff
	ret z			;4401
L_4402:
	ld h,b			;4402
	ld l,a			;4403
	ld b,008h		;4404
L_4406:
	rr l		;4406
	rla			;4408
	djnz L_4406		;4409
	ld b,h			;440b
	ret			;440c
L_440D:
	ld ix,0e4e0h		;440d
	ld iy,0e4ech		;4411
	ld h,a			;4415
	and 00fh		;4416
	cp (iy+000h)		;4418
	ld l,(iy+001h)		;441b
	jr z,L_4448		;441e
	cp (iy+002h)		;4420
	ld l,(iy+003h)		;4423
	jr z,L_4448		;4426
	cp (iy+004h)		;4428
	ld l,(iy+005h)		;442b
	jr z,L_4448		;442e
	cp (iy+006h)		;4430
	ld l,(iy+007h)		;4433
	jr z,L_4448		;4436
	cp (iy+008h)		;4438
	ld l,(iy+009h)		;443b
	jr z,L_4448		;443e
	cp (iy+00ah)		;4440
	ld l,(iy+00bh)		;4443
	jr nz,L_444D		;4446
L_4448:
	ld a,h			;4448
	and 0f0h		;4449
	or l			;444b
	ld h,a			;444c
L_444D:
	ld a,h			;444d
	and 0f0h		;444e
	cp (ix+000h)		;4450
	ld l,(ix+001h)		;4453
	jr z,L_4480		;4456
	cp (ix+002h)		;4458
	ld l,(ix+003h)		;445b
	jr z,L_4480		;445e
	cp (ix+004h)		;4460
	ld l,(ix+005h)		;4463
	jr z,L_4480		;4466
	cp (ix+006h)		;4468
	ld l,(ix+007h)		;446b
	jr z,L_4480		;446e
	cp (ix+008h)		;4470
	ld l,(ix+009h)		;4473
	jr z,L_4480		;4476
	cp (ix+00ah)		;4478
	ld l,(ix+00bh)		;447b
	ld a,h			;447e
	ret nz			;447f
L_4480:
	ld a,h			;4480
	and 00fh		;4481
	or l			;4483
	ret			;4484
L_4485:
	ld a,0bfh		;4485
	ld (0e079h),a		;4487
	ld e,a			;448a
	ld a,007h		;448b
	call 00093h		;448d   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,0cbh		;4490
	call L_4145		;4492
	xor a			;4495
	ld l,a			;4496
	ld h,a			;4497
	ld c,a			;4498
	ld b,040h		;4499
	call 00056h		;449b   ; BIOS FILVRM - Fills VRAM with value
L_449E:
	ld hl,044aeh		;449e
	ld c,008h		;44a1
L_44A3:
	ld a,c			;44a3
	and a			;44a4
	ret z			;44a5
	dec c			;44a6
	ld b,(hl)			;44a7
	call 00047h		;44a8   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;44ab
	jr L_44A3		;44ac

; ----------------------------------------------------------------------
; DATOS sin identificar  0x44ae..0x44b6  (8 bytes)
DATA_44AE:
	defb 0e4h,003h,076h,007h,07fh,00eh,0e2h,002h	; 44ae  ..v.....

; ======================================================================
; CODIGO 0x44b6..0x4a89  (1491 bytes)
; ======================================================================


L_44B6:
	ld c,007h		;44b6
	jp 00047h		;44b8   ; BIOS WRTVDP - Writes data in the VDP-register
L_44BB:
	call L_44C8		;44bb
L_44BE:
	ld hl,0e007h		;44be
	ld c,(hl)			;44c1
	ld (hl),a			;44c2
	xor c			;44c3
	and (hl)			;44c4
	dec hl			;44c5
	ld (hl),a			;44c6
	ret			;44c7
L_44C8:
	ld e,08fh		;44c8
	ld a,00fh		;44ca
	call 00093h		;44cc   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;44cf
	di			;44d1
	call 00096h		;44d2   ; BIOS RDPSG - Reads value from PSG-register
	ei			;44d5
	cpl			;44d6
	and 03fh		;44d7
	push af			;44d9
	ld a,008h		;44da
	call 00141h		;44dc   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;44df
	rrca			;44e0
	rrca			;44e1
	ld b,a			;44e2
	and 004h		;44e3
	ld e,a			;44e5
	ld a,b			;44e6
	rrca			;44e7
	rrca			;44e8
	ld b,a			;44e9
	and 018h		;44ea
	or e			;44ec
	ld e,a			;44ed
	ld a,b			;44ee
	rrca			;44ef
	and 003h		;44f0
	or e			;44f2
	ld e,a			;44f3
	ld a,006h		;44f4
	call 00141h		;44f6   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;44f9
	rlca			;44fa
	rlca			;44fb
	and 080h		;44fc
	or e			;44fe
	ld e,a			;44ff
	ld a,004h		;4500
	call 00141h		;4502   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4505
	rlca			;4506
	rlca			;4507
	rlca			;4508
	and 020h		;4509
	or e			;450b
	ld e,a			;450c
	ld a,007h		;450d
	call 00141h		;450f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4512
	rrca			;4513
	rrca			;4514
	rrca			;4515
	and 040h		;4516
	or e			;4518
	pop bc			;4519
	or b			;451a
	ret			;451b
L_451C:
	call L_42FB		;451c
	ld a,(0e0dch)		;451f
	and a			;4522
	jr nz,L_452A		;4523
	call L_4265		;4525
	jr L_4557		;4528
L_452A:
	dec a			;452a
	ld (0e0dch),a		;452b
	ld a,(0e1f1h)		;452e
	and a			;4531
	jr nz,L_4544		;4532
	ld a,004h		;4534
	ld hl,03b07h		;4536
	call 0004dh		;4539   ; BIOS WRTVRM - Writes data in VRAM
	ld a,004h		;453c
	ld hl,03b0bh		;453e
	call 0004dh		;4541   ; BIOS WRTVRM - Writes data in VRAM
L_4544:
	ld a,005h		;4544
	ld hl,03b4bh		;4546
	call 0004dh		;4549   ; BIOS WRTVRM - Writes data in VRAM
	ld a,005h		;454c
	ld hl,03b4fh		;454e
	call 0004dh		;4551   ; BIOS WRTVRM - Writes data in VRAM
	call L_427B		;4554
L_4557:
	call 066dah		;4557
	call 091adh		;455a
	call L_5F77		;455d
	call 064f0h		;4560
	call 07e47h		;4563
	ld a,(0e0a2h)		;4566
	and a			;4569
	jr nz,L_4578		;456a
	ld a,(0e002h)		;456c
	and 040h		;456f
	jr z,L_457B		;4571
	call 09471h		;4573
	jr L_457B		;4576
L_4578:
	call 09440h		;4578
L_457B:
	call 06799h		;457b
	call 068cah		;457e
	call 06aa8h		;4581
	ld a,(0e096h)		;4584
	rra			;4587
	ret c			;4588
	call 0921bh		;4589
	ld a,(0e002h)		;458c
	and 040h		;458f
	jr z,L_4596		;4591
	call 09469h		;4593
L_4596:
	call 0be41h		;4596
	call 096f9h		;4599
	call 0929fh		;459c
	call 0a985h		;459f
	ld a,(0e0a2h)		;45a2
	dec a			;45a5
	jr z,L_45B1		;45a6
	call 0bd8ah		;45a8
	call 0bdcah		;45ab
	call 07b44h		;45ae
L_45B1:
	call 0baceh		;45b1
	call 0b4ebh		;45b4
	call 0b52eh		;45b7
	call 0bb2bh		;45ba
	call 0bb75h		;45bd
	call 0b8abh		;45c0
	call 0bf32h		;45c3
	call 0bf72h		;45c6
	di			;45c9
	push hl			;45ca
	ld hl,0f0f1h		;45cb
	ld a,007h		;45ce
	ld (06000h),a		;45d0
	ld (hl),a			;45d3
	inc a			;45d4
	ld (08000h),a		;45d5
	inc hl			;45d8
	ld (hl),a			;45d9
	inc a			;45da
	ld (0a000h),a		;45db
	inc hl			;45de
	ld (hl),a			;45df
	pop hl			;45e0
	ei			;45e1
	ld a,(0e0a5h)		;45e2
	and a			;45e5
	jr nz,L_45F1		;45e6
	call 0a83fh		;45e8
	call 0b616h		;45eb
	call 0bba1h		;45ee
L_45F1:
	call 0a92bh		;45f1
	call 0aa18h		;45f4
	call 0a9e9h		;45f7
	call 0abc3h		;45fa
	call 0ac52h		;45fd
	di			;4600
	push hl			;4601
	ld hl,0f0f1h		;4602
	ld a,001h		;4605
	ld (06000h),a		;4607
	ld (hl),a			;460a
	inc a			;460b
	ld (08000h),a		;460c
	inc hl			;460f
	ld (hl),a			;4610
	inc a			;4611
	ld (0a000h),a		;4612
	inc hl			;4615
	ld (hl),a			;4616
	pop hl			;4617
	ei			;4618
	call 0bc1bh		;4619
	call 0bca0h		;461c
	call 0bd53h		;461f
	ld a,(0e097h)		;4622
	and a			;4625
	ret z			;4626
	call 0b2d9h		;4627
	call 0b3a0h		;462a
	call 07059h		;462d
	call 0b3e4h		;4630
	call 07531h		;4633
	call 07625h		;4636
	call 0b36bh		;4639
	jp 07730h		;463c
L_463F:
	xor a			;463f
	ld (0e201h),a		;4640
	ld (0e202h),a		;4643
	ld (0e10eh),a		;4646
	ld a,0e0h		;4649
	ld (0e3a3h),a		;464b
	ld (0e3a7h),a		;464e
	ld (0e3b3h),a		;4651
	ld (0e3b7h),a		;4654
	ld (0e3c3h),a		;4657
	ld (0e3c7h),a		;465a
	jp 062a4h		;465d
L_4660:
	xor a			;4660
	ld hl,0e1f0h		;4661
	ld de,0e1f1h		;4664
	ld bc,009afh		;4667
	ld (hl),a			;466a
	ldir		;466b
	ld hl,0ebe0h		;466d
	ld de,0ebe1h		;4670
	ld bc,00320h		;4673
	ld (hl),a			;4676
	ldir		;4677
	ld (0e0a5h),a		;4679
	ld (0e0b6h),a		;467c
	ld (0e0d4h),a		;467f
	ld (0e166h),a		;4682
	ld (0e16ch),a		;4685
	ld (0e0bdh),a		;4688
	ld (0e0bbh),a		;468b
	ld (0e0bch),a		;468e
	ld (0e0beh),a		;4691
	ld (0e0bfh),a		;4694
	ld (0e0c0h),a		;4697
	ld (0e0c1h),a		;469a
	ld (0e0c2h),a		;469d
	ld (0e0c3h),a		;46a0
	ld (0e0c4h),a		;46a3
	ld (0e0d7h),a		;46a6
	ld (0e0d8h),a		;46a9
	ld (0e0d9h),a		;46ac
	ld (0e0dah),a		;46af
	ld (0e0dbh),a		;46b2
	ld (0e0a9h),a		;46b5
	ld (0e0dch),a		;46b8
	ld c,006h		;46bb
	call 0baa3h		;46bd
	ld c,00ch		;46c0
	call 0baa3h		;46c2
	ld a,(0e16ah)		;46c5
	and a			;46c8
	jr z,L_46D4		;46c9
	dec a			;46cb
	ld (0e16ah),a		;46cc
	ld c,00ah		;46cf
	call 0baa3h		;46d1
L_46D4:
	ld a,(0e16bh)		;46d4
	and a			;46d7
	jr z,L_46E3		;46d8
	dec a			;46da
	ld (0e16bh),a		;46db
	ld c,00bh		;46de
	call 0baa3h		;46e0
L_46E3:
	call 061ffh		;46e3
	call 0624ch		;46e6
	call 062bch		;46e9
	call 06737h		;46ec
	call 062cbh		;46ef
	call 06323h		;46f2
	xor a			;46f5
	call 066edh		;46f6
	call 063fdh		;46f9
	call 063bch		;46fc
	call 06370h		;46ff
	call 0643fh		;4702
	jp 0be00h		;4705
L_4708:
	ld hl,(0e301h)		;4708
	ld a,(0e300h)		;470b
	push hl			;470e
	push af			;470f
	ld hl,0e1f0h		;4710
	ld de,0e1f1h		;4713
	ld bc,0020fh		;4716
	xor a			;4719
	ld (hl),a			;471a
	ldir		;471b
	ld (0e0dch),a		;471d
	ld hl,0e500h		;4720
	ld de,0e501h		;4723
	ld bc,0000fh		;4726
	ld (hl),a			;4729
	ldir		;472a
	pop af			;472c
	pop hl			;472d
	ld (0e301h),hl		;472e
	ld (0e300h),a		;4731
	di			;4734
	ld a,00ah		;4735
	ld (08000h),a		;4737
	ld (0f0f2h),a		;473a
	ei			;473d
	di			;473e
	ld a,00bh		;473f
	ld (0a000h),a		;4741
	ld (0f0f3h),a		;4744
	ei			;4747
	ld de,0e440h		;4748
	ld c,005h		;474b
L_474D:
	ld a,(de)			;474d
	and a			;474e
	ld a,010h		;474f
	jr z,L_4784		;4751
	inc e			;4753
	inc e			;4754
	ld a,(de)			;4755
	cp 008h		;4756
	ld a,00eh		;4758
	jr c,L_4784		;475a
	dec e			;475c
	push de			;475d
	ld a,(de)			;475e
	dec a			;475f
	ld hl,08682h		;4760
	call L_4055		;4763
	ld a,(hl)			;4766
	inc hl			;4767
	ld h,(hl)			;4768
	ld l,a			;4769
	inc e			;476a
	ld a,(de)			;476b
	dec a			;476c
	call L_4055		;476d
	ld a,(hl)			;4770
	inc hl			;4771
	ld h,(hl)			;4772
	ld l,a			;4773
	call L_41AD		;4774
	pop de			;4777
	ex de,hl			;4778
	dec l			;4779
	ld b,010h		;477a
L_477C:
	ld (hl),000h		;477c
	inc l			;477e
	djnz L_477C		;477f
	ex de,hl			;4781
	jr L_4786		;4782
L_4784:
	add a,e			;4784
	ld e,a			;4785
L_4786:
	dec c			;4786
	jr nz,L_474D		;4787
	di			;4789
	ld a,002h		;478a
	ld (08000h),a		;478c
	ld (0f0f2h),a		;478f
	ei			;4792
	di			;4793
	ld a,003h		;4794
	ld (0a000h),a		;4796
	ld (0f0f3h),a		;4799
	ei			;479c
	di			;479d
	ld a,00ch		;479e
	ld (08000h),a		;47a0
	ld (0f0f2h),a		;47a3
	ei			;47a6
	di			;47a7
	ld a,00dh		;47a8
	ld (0a000h),a		;47aa
	ld (0f0f3h),a		;47ad
	ei			;47b0
	ld a,(0e092h)		;47b1
	dec a			;47b4
	ld l,a			;47b5
	ld h,000h		;47b6
	add hl,hl			;47b8
	add hl,hl			;47b9
	ld de,0acbah		;47ba
	add hl,de			;47bd
	ld e,(hl)			;47be
	inc hl			;47bf
	ld a,(hl)			;47c0
	and 00fh		;47c1
	ld d,a			;47c3
	ld (0e08bh),de		;47c4
	di			;47c8
	ld a,002h		;47c9
	ld (08000h),a		;47cb
	ld (0f0f2h),a		;47ce
	ei			;47d1
	di			;47d2
	ld a,003h		;47d3
	ld (0a000h),a		;47d5
	ld (0f0f3h),a		;47d8
	ei			;47db
	call 0624ch		;47dc
	jp 06323h		;47df
L_47E2:
	di			;47e2
	push hl			;47e3
	ld hl,0f0f1h		;47e4
	ld a,004h		;47e7
	ld (06000h),a		;47e9
	ld (hl),a			;47ec
	inc a			;47ed
	ld (08000h),a		;47ee
	inc hl			;47f1
	ld (hl),a			;47f2
	inc a			;47f3
	ld (0a000h),a		;47f4
	inc hl			;47f7
	ld (hl),a			;47f8
	pop hl			;47f9
	ei			;47fa
	ld de,0b5b9h		;47fb
	call L_4381		;47fe
	di			;4801
	push hl			;4802
	ld hl,0f0f1h		;4803
	ld a,001h		;4806
	ld (06000h),a		;4808
	ld (hl),a			;480b
	inc a			;480c
	ld (08000h),a		;480d
	inc hl			;4810
	ld (hl),a			;4811
	inc a			;4812
	ld (0a000h),a		;4813
	inc hl			;4816
	ld (hl),a			;4817
	pop hl			;4818
	ei			;4819
	ret			;481a
L_481B:
	di			;481b
	push hl			;481c
	ld hl,0f0f1h		;481d
	ld a,004h		;4820
	ld (06000h),a		;4822
	ld (hl),a			;4825
	inc a			;4826
	ld (08000h),a		;4827
	inc hl			;482a
	ld (hl),a			;482b
	inc a			;482c
	ld (0a000h),a		;482d
	inc hl			;4830
	ld (hl),a			;4831
	pop hl			;4832
	ei			;4833
	ld de,0a77ah		;4834
	call L_4381		;4837
	ld de,0aabbh		;483a
	ld hl,02e70h		;483d
	ld c,001h		;4840
	call L_4386		;4842
	ld de,0aba5h		;4845
	call L_4381		;4848
	ld de,0af15h		;484b
	ld hl,03680h		;484e
	ld c,001h		;4851
	call L_4386		;4853
	ld de,0aadbh		;4856
	call L_4381		;4859
	ld de,0ab93h		;485c
	ld hl,00e70h		;485f
	ld c,000h		;4862
	call L_4386		;4864
	ld de,0af34h		;4867
	call L_4381		;486a
	ld de,0b003h		;486d
	ld hl,01680h		;4870
	ld c,000h		;4873
	call L_4386		;4875
	ld de,0b006h		;4878
	ld bc,00601h		;487b
	call L_43B3		;487e
	di			;4881
	push hl			;4882
	ld hl,0f0f1h		;4883
	ld a,001h		;4886
	ld (06000h),a		;4888
	ld (hl),a			;488b
	inc a			;488c
	ld (08000h),a		;488d
	inc hl			;4890
	ld (hl),a			;4891
	inc a			;4892
	ld (0a000h),a		;4893
	inc hl			;4896
	ld (hl),a			;4897
	pop hl			;4898
	ei			;4899
	ld a,(0e0a0h)		;489a
	and a			;489d
	ret z			;489e
	di			;489f
	push hl			;48a0
	ld hl,0f0f1h		;48a1
	ld a,004h		;48a4
	ld (06000h),a		;48a6
	ld (hl),a			;48a9
	inc a			;48aa
	ld (08000h),a		;48ab
	inc hl			;48ae
	ld (hl),a			;48af
	inc a			;48b0
	ld (0a000h),a		;48b1
	inc hl			;48b4
	ld (hl),a			;48b5
	pop hl			;48b6
	ei			;48b7
	ld de,0ba5ah		;48b8
	ld bc,01301h		;48bb
	call L_43B3		;48be
	jr L_48E2		;48c1
L_48C3:
	di			;48c3
	push hl			;48c4
	ld hl,0f0f1h		;48c5
	ld a,004h		;48c8
	ld (06000h),a		;48ca
	ld (hl),a			;48cd
	inc a			;48ce
	ld (08000h),a		;48cf
	inc hl			;48d2
	ld (hl),a			;48d3
	inc a			;48d4
	ld (0a000h),a		;48d5
	inc hl			;48d8
	ld (hl),a			;48d9
	pop hl			;48da
	ei			;48db
	ld de,08afbh		;48dc
	call L_4381		;48df
L_48E2:
	di			;48e2
	push hl			;48e3
	ld hl,0f0f1h		;48e4
	ld a,001h		;48e7
	ld (06000h),a		;48e9
	ld (hl),a			;48ec
	inc a			;48ed
	ld (08000h),a		;48ee
	inc hl			;48f1
	ld (hl),a			;48f2
	inc a			;48f3
	ld (0a000h),a		;48f4
	inc hl			;48f7
	ld (hl),a			;48f8
	pop hl			;48f9
	ei			;48fa
	ret			;48fb
L_48FC:
	di			;48fc
	push hl			;48fd
	ld hl,0f0f1h		;48fe
	ld a,004h		;4901
	ld (06000h),a		;4903
	ld (hl),a			;4906
	inc a			;4907
	ld (08000h),a		;4908
	inc hl			;490b
	ld (hl),a			;490c
	inc a			;490d
	ld (0a000h),a		;490e
	inc hl			;4911
	ld (hl),a			;4912
	pop hl			;4913
	ei			;4914
	ld de,09bb6h		;4915
	call L_4381		;4918
	ld de,09d25h		;491b
	ld hl,02478h		;491e
	ld c,001h		;4921
	call L_4386		;4923
	ld de,09dfah		;4926
	call L_4381		;4929
	ld de,0a1e1h		;492c
	ld hl,02e40h		;492f
	ld c,001h		;4932
	call L_4386		;4934
	ld de,0a52ch		;4937
	call L_4381		;493a
	ld de,0a575h		;493d
	ld hl,031d0h		;4940
	ld c,001h		;4943
	call L_4386		;4945
	ld de,09de5h		;4948
	call L_4381		;494b
	ld de,09df1h		;494e
	ld hl,00478h		;4951
	ld c,000h		;4954
	call L_4386		;4956
	ld de,0a387h		;4959
	call L_4381		;495c
	ld de,0a4f6h		;495f
	ld hl,00e40h		;4962
	ld c,000h		;4965
	call L_4386		;4967
	ld de,0a6b7h		;496a
	call L_4381		;496d
	ld de,0a6edh		;4970
	ld hl,011d0h		;4973
	ld c,000h		;4976
	call L_4386		;4978
	di			;497b
	push hl			;497c
	ld hl,0f0f1h		;497d
	ld a,001h		;4980
	ld (06000h),a		;4982
	ld (hl),a			;4985
	inc a			;4986
	ld (08000h),a		;4987
	inc hl			;498a
	ld (hl),a			;498b
	inc a			;498c
	ld (0a000h),a		;498d
	inc hl			;4990
	ld (hl),a			;4991
	pop hl			;4992
	ei			;4993
	ret			;4994
L_4995:
	di			;4995
	push hl			;4996
	ld hl,0f0f1h		;4997
	ld a,004h		;499a
	ld (06000h),a		;499c
	ld (hl),a			;499f
	inc a			;49a0
	ld (08000h),a		;49a1
	inc hl			;49a4
	ld (hl),a			;49a5
	inc a			;49a6
	ld (0a000h),a		;49a7
	inc hl			;49aa
	ld (hl),a			;49ab
	pop hl			;49ac
	ei			;49ad
	ld a,(0e0a1h)		;49ae
	ld hl,04a89h		;49b1
	call L_4056		;49b4
	ld a,(hl)			;49b7
	ld hl,00008h		;49b8
	ld bc,00008h		;49bb
	call 00056h		;49be   ; BIOS FILVRM - Fills VRAM with value
	ld hl,02200h		;49c1
	ld (0e4e0h),hl		;49c4
	ld hl,00200h		;49c7
	ld (0e4e2h),hl		;49ca
	ld hl,04a93h		;49cd
	jr L_4A24		;49d0
L_49D2:
	di			;49d2
	push hl			;49d3
	ld hl,0f0f1h		;49d4
	ld a,004h		;49d7
	ld (06000h),a		;49d9
	ld (hl),a			;49dc
	inc a			;49dd
	ld (08000h),a		;49de
	inc hl			;49e1
	ld (hl),a			;49e2
	inc a			;49e3
	ld (0a000h),a		;49e4
	inc hl			;49e7
	ld (hl),a			;49e8
	pop hl			;49e9
	ei			;49ea
	ld hl,03008h		;49eb
	ld (0e4e0h),hl		;49ee
	ld hl,01008h		;49f1
	ld (0e4e2h),hl		;49f4
	ld hl,04b5bh		;49f7
	jr L_4A24		;49fa
L_49FC:
	di			;49fc
	push hl			;49fd
	ld hl,0f0f1h		;49fe
	ld a,004h		;4a01
	ld (06000h),a		;4a03
	ld (hl),a			;4a06
	inc a			;4a07
	ld (08000h),a		;4a08
	inc hl			;4a0b
	ld (hl),a			;4a0c
	inc a			;4a0d
	ld (0a000h),a		;4a0e
	inc hl			;4a11
	ld (hl),a			;4a12
	pop hl			;4a13
	ei			;4a14
	ld hl,02808h		;4a15
	ld (0e4e0h),hl		;4a18
	ld hl,00808h		;4a1b
	ld (0e4e2h),hl		;4a1e
	ld hl,04af7h		;4a21
L_4A24:
	ld a,(0e0a1h)		;4a24
	add a,a			;4a27
	ld c,a			;4a28
	add a,a			;4a29
	add a,a			;4a2a
	add a,c			;4a2b
	call L_4056		;4a2c
	ld e,(hl)			;4a2f
	inc hl			;4a30
	ld d,(hl)			;4a31
	inc hl			;4a32
	push hl			;4a33
	ld hl,(0e4e0h)		;4a34
	ld c,000h		;4a37
	call L_4386		;4a39
	pop hl			;4a3c
	ld e,(hl)			;4a3d
	inc hl			;4a3e
	ld d,(hl)			;4a3f
	inc hl			;4a40
	ld a,(hl)			;4a41
	inc hl			;4a42
	push hl			;4a43
	ld h,(hl)			;4a44
	ld l,a			;4a45
	ld (0e4e0h),hl		;4a46
	ld c,001h		;4a49
	call L_4386		;4a4b
	pop hl			;4a4e
	inc hl			;4a4f
	ld e,(hl)			;4a50
	inc hl			;4a51
	ld d,(hl)			;4a52
	inc hl			;4a53
	push hl			;4a54
	ld hl,(0e4e2h)		;4a55
	ld c,000h		;4a58
	call L_4386		;4a5a
	pop hl			;4a5d
	ld e,(hl)			;4a5e
	inc hl			;4a5f
	ld d,(hl)			;4a60
	ld hl,(0e4e0h)		;4a61
	ld bc,02000h		;4a64
	and a			;4a67
	sbc hl,bc		;4a68
	ld c,000h		;4a6a
	call L_4386		;4a6c
	di			;4a6f
	push hl			;4a70
	ld hl,0f0f1h		;4a71
	ld a,001h		;4a74
	ld (06000h),a		;4a76
	ld (hl),a			;4a79
	inc a			;4a7a
	ld (08000h),a		;4a7b
	inc hl			;4a7e
	ld (hl),a			;4a7f
	inc a			;4a80
	ld (0a000h),a		;4a81
	inc hl			;4a84
	ld (hl),a			;4a85
	pop hl			;4a86
	ei			;4a87
	ret			;4a88

; ----------------------------------------------------------------------
; DATOS sin identificar  0x4a89..0x4bbf  (310 bytes)
DATA_4A89:
	defb 007h,007h,007h,007h,007h,007h,001h,004h,001h,001h,000h,060h,000h,060h,000h,022h	; 4a89  ...........`.`."
	defb 001h,060h,001h,060h,051h,062h,05eh,062h,028h,023h,06eh,063h,070h,063h,024h,066h	; 4a99  .`.`Qb^b(#ncpc$f
	defb 024h,066h,000h,022h,025h,066h,025h,066h,051h,062h,05eh,062h,028h,023h,08fh,069h	; 4aa9  $f."%f%fQb^b(#.i
	defb 091h,069h,02eh,06ah,02eh,06ah,000h,022h,02fh,06ah,02fh,06ah,023h,06eh,084h,06eh	; 4ab9  .i.j.j."/j/j#n.n
	defb 0c0h,023h,07eh,06fh,08ch,06fh,060h,073h,096h,073h,0c0h,023h,0f0h,074h,00dh,075h	; 4ac9  .#~o.o`s.s.#.t.u
	defb 01ch,079h,00bh,07ch,000h,022h,00ch,07ch,01ah,07ch,025h,07fh,025h,07fh,000h,022h	; 4ad9  .y.|.".|.|%.%.."
	defb 026h,07fh,026h,07fh,060h,073h,096h,073h,0c0h,023h,08ch,087h,0a9h,087h,002h,060h	; 4ae9  &.&.`s.s.#.....`
	defb 059h,060h,040h,02ah,0a7h,061h,0d2h,061h,07fh,063h,098h,063h,058h,02ah,07dh,065h	; 4af9  Y`@*.a.a.c.cX*}e
	defb 085h,065h,026h,066h,053h,066h,060h,02ah,01fh,068h,035h,068h,07fh,063h,098h,063h	; 4b09  .e&fSf`*.h5h.c.c
	defb 058h,02ah,0a0h,069h,0ach,069h,030h,06ah,08fh,06ah,0e8h,02ah,0b4h,06ch,0e3h,06ch	; 4b19  X*.i.i0j.j.*.l.l
	defb 0a1h,06fh,0d0h,06fh,0d8h,02ah,0f5h,071h,009h,072h,08ah,075h,0a3h,075h,090h,02ah	; 4b29  .o.o.*.q.r.u.u.*
	defb 0cch,077h,0d0h,077h,01bh,07ch,035h,07ch,048h,02ah,009h,07eh,011h,07eh,027h,07fh	; 4b39  .w.w.|5|H*.~.~'.
	defb 029h,07fh,008h,028h,02ah,07fh,02ch,07fh,08ah,075h,0a3h,075h,090h,02ah,026h,088h	; 4b49  )..(*.,..u.u.*&.
	defb 02ah,088h,04bh,062h,04dh,062h,008h,030h,04eh,062h,050h,062h,0ceh,065h,0d0h,065h	; 4b59  *.KbMb.0NbPb.e.e
	defb 070h,030h,01fh,066h,021h,066h,013h,069h,015h,069h,078h,030h,06eh,069h,070h,069h	; 4b69  p0.f!f.i.ix0nipi
	defb 0ceh,065h,0d0h,065h,070h,030h,029h,06ah,02bh,06ah,012h,06eh,014h,06eh,018h,030h	; 4b79  .e.ep0)j+j.n.n.0
	defb 01eh,06eh,020h,06eh,0feh,072h,000h,073h,050h,030h,03ch,073h,03eh,073h,042h,078h	; 4b89  .n n.r.sP0<s>sBx
	defb 048h,078h,0d8h,030h,0eeh,078h,0f0h,078h,091h,07eh,093h,07eh,0a8h,030h,01eh,07fh	; 4b99  Hx.0.x.x.~.~.0..
	defb 020h,07fh,02dh,07fh,0cch,085h,0b0h,037h,0feh,085h,07fh,087h,042h,078h,048h,078h	; 4ba9   .-....7....BxHx
	defb 0d8h,030h,09ch,088h,09eh,088h	; 4bb9

; ======================================================================
; CODIGO 0x4bbf..0x565f  (2720 bytes)
; ======================================================================


L_4BBF:
	di			;4bbf
	push hl			;4bc0
	ld hl,0f0f1h		;4bc1
	ld a,004h		;4bc4
	ld (06000h),a		;4bc6
	ld (hl),a			;4bc9
	inc a			;4bca
	ld (08000h),a		;4bcb
	inc hl			;4bce
	ld (hl),a			;4bcf
	inc a			;4bd0
	ld (0a000h),a		;4bd1
	inc hl			;4bd4
	ld (hl),a			;4bd5
	pop hl			;4bd6
	ei			;4bd7
	ld de,088cah		;4bd8
	ld hl,02200h		;4bdb
	call L_42A8		;4bde
	ld de,0898ah		;4be1
	ld hl,02368h		;4be4
	call L_42A4		;4be7
	ld de,089fdh		;4bea
	ld hl,00200h		;4bed
	call L_42A8		;4bf0
	ld de,08a6ch		;4bf3
	ld hl,00368h		;4bf6
	call L_42A8		;4bf9
	ld a,(0e0a2h)		;4bfc
	cp 004h		;4bff
	jr nz,L_4C1E		;4c01
	ld de,08abbh		;4c03
	ld hl,00248h		;4c06
	call L_42A8		;4c09
	ld de,08af0h		;4c0c
	ld hl,00318h		;4c0f
	call L_42A8		;4c12
	ld de,08af0h		;4c15
	ld hl,00390h		;4c18
	call L_42A8		;4c1b
L_4C1E:
	di			;4c1e
	push hl			;4c1f
	ld hl,0f0f1h		;4c20
	ld a,001h		;4c23
	ld (06000h),a		;4c25
	ld (hl),a			;4c28
	inc a			;4c29
	ld (08000h),a		;4c2a
	inc hl			;4c2d
	ld (hl),a			;4c2e
	inc a			;4c2f
	ld (0a000h),a		;4c30
	inc hl			;4c33
	ld (hl),a			;4c34
	pop hl			;4c35
	ei			;4c36
	ret			;4c37
L_4C38:
	di			;4c38
	push hl			;4c39
	ld hl,0f0f1h		;4c3a
	ld a,004h		;4c3d
	ld (06000h),a		;4c3f
	ld (hl),a			;4c42
	inc a			;4c43
	ld (08000h),a		;4c44
	inc hl			;4c47
	ld (hl),a			;4c48
	inc a			;4c49
	ld (0a000h),a		;4c4a
	inc hl			;4c4d
	ld (hl),a			;4c4e
	pop hl			;4c4f
	ei			;4c50
	ld de,0b0c8h		;4c51
	call L_4381		;4c54
	ld de,0b0feh		;4c57
	ld hl,02440h		;4c5a
	ld c,001h		;4c5d
	call L_4386		;4c5f
	ld de,0b13ch		;4c62
	call L_4381		;4c65
	ld de,0b1dch		;4c68
	ld hl,02cd8h		;4c6b
	ld c,001h		;4c6e
	call L_4386		;4c70
	ld de,0b260h		;4c73
	call L_4381		;4c76
	ld de,0b36eh		;4c79
	ld hl,03558h		;4c7c
	ld c,001h		;4c7f
	call L_4386		;4c81
	ld de,0b110h		;4c84
	call L_4381		;4c87
	ld de,0b129h		;4c8a
	ld hl,00440h		;4c8d
	ld c,000h		;4c90
	call L_4386		;4c92
	ld de,0b200h		;4c95
	call L_4381		;4c98
	ld de,0b24dh		;4c9b
	ld hl,00cd8h		;4c9e
	ld c,000h		;4ca1
	call L_4386		;4ca3
	ld de,0b38fh		;4ca6
	call L_4381		;4ca9
	ld de,0b407h		;4cac
	ld hl,01558h		;4caf
	ld c,000h		;4cb2
	call L_4386		;4cb4
	di			;4cb7
	push hl			;4cb8
	ld hl,0f0f1h		;4cb9
	ld a,001h		;4cbc
	ld (06000h),a		;4cbe
	ld (hl),a			;4cc1
	inc a			;4cc2
	ld (08000h),a		;4cc3
	inc hl			;4cc6
	ld (hl),a			;4cc7
	inc a			;4cc8
	ld (0a000h),a		;4cc9
	inc hl			;4ccc
	ld (hl),a			;4ccd
	pop hl			;4cce
	ei			;4ccf
	ret			;4cd0
L_4CD1:
	ld a,(0e0a1h)		;4cd1
	cp 008h		;4cd4
	ret z			;4cd6
	di			;4cd7
	push hl			;4cd8
	ld hl,0f0f1h		;4cd9
	ld a,007h		;4cdc
	ld (06000h),a		;4cde
	ld (hl),a			;4ce1
	inc a			;4ce2
	ld (08000h),a		;4ce3
	inc hl			;4ce6
	ld (hl),a			;4ce7
	inc a			;4ce8
	ld (0a000h),a		;4ce9
	inc hl			;4cec
	ld (hl),a			;4ced
	pop hl			;4cee
	ei			;4cef
	ld de,06000h		;4cf0
	call L_4381		;4cf3
	ld de,06089h		;4cf6
	ld hl,02fd8h		;4cf9
	ld c,001h		;4cfc
	call L_4386		;4cfe
	ld de,060e8h		;4d01
	call L_4381		;4d04
	ld de,06230h		;4d07
	ld hl,036f0h		;4d0a
	ld c,001h		;4d0d
	call L_4386		;4d0f
	ld a,(0e0a1h)		;4d12
	cp 002h		;4d15
	ld hl,0970eh		;4d17
	jr c,L_4D31		;4d1a
	cp 004h		;4d1c
	ld hl,0973eh		;4d1e
	jr z,L_4D31		;4d21
	cp 005h		;4d23
	jr z,L_4D31		;4d25
	cp 007h		;4d27
	ld hl,09726h		;4d29
	jr z,L_4D31		;4d2c
	ld hl,096f6h		;4d2e
L_4D31:
	ld de,0e4e0h		;4d31
	ld bc,00018h		;4d34
	ldir		;4d37
	ld de,06095h		;4d39
	ld hl,00f00h		;4d3c
	ld c,080h		;4d3f
	call L_4386		;4d41
	ld de,060e3h		;4d44
	ld hl,00fd8h		;4d47
	ld c,080h		;4d4a
	call L_4386		;4d4c
	ld de,06237h		;4d4f
	ld hl,01570h		;4d52
	ld c,080h		;4d55
	call L_4386		;4d57
	ld de,062feh		;4d5a
	ld hl,016f0h		;4d5d
	ld c,080h		;4d60
	call L_4386		;4d62
	di			;4d65
	push hl			;4d66
	ld hl,0f0f1h		;4d67
	ld a,001h		;4d6a
	ld (06000h),a		;4d6c
	ld (hl),a			;4d6f
	inc a			;4d70
	ld (08000h),a		;4d71
	inc hl			;4d74
	ld (hl),a			;4d75
	inc a			;4d76
	ld (0a000h),a		;4d77
	inc hl			;4d7a
	ld (hl),a			;4d7b
	pop hl			;4d7c
	ei			;4d7d
	ret			;4d7e
L_4D7F:
	ld a,(0e0a1h)		;4d7f
	cp 008h		;4d82
	ret z			;4d84
	di			;4d85
	push hl			;4d86
	ld hl,0f0f1h		;4d87
	ld a,007h		;4d8a
	ld (06000h),a		;4d8c
	ld (hl),a			;4d8f
	inc a			;4d90
	ld (08000h),a		;4d91
	inc hl			;4d94
	ld (hl),a			;4d95
	inc a			;4d96
	ld (0a000h),a		;4d97
	inc hl			;4d9a
	ld (hl),a			;4d9b
	pop hl			;4d9c
	ei			;4d9d
	ld de,06304h		;4d9e
	call L_4381		;4da1
	ld de,06360h		;4da4
	ld hl,02ed0h		;4da7
	ld c,001h		;4daa
	call L_4386		;4dac
	ld de,063b9h		;4daf
	call L_4381		;4db2
	ld a,(0e0a1h)		;4db5
	cp 002h		;4db8
	ld hl,09756h		;4dba
	jr c,L_4DD7		;4dbd
	cp 004h		;4dbf
	ld hl,0976eh		;4dc1
	jr z,L_4DD7		;4dc4
	cp 005h		;4dc6
	ld hl,0979eh		;4dc8
	jr z,L_4DD7		;4dcb
	cp 007h		;4dcd
	ld hl,09786h		;4dcf
	jr z,L_4DD7		;4dd2
	ld hl,096f6h		;4dd4
L_4DD7:
	ld de,0e4e0h		;4dd7
	ld bc,00018h		;4dda
	ldir		;4ddd
	ld de,06386h		;4ddf
	ld hl,00e38h		;4de2
	ld c,080h		;4de5
	call L_4386		;4de7
	ld de,063a0h		;4dea
	ld hl,00ed0h		;4ded
	ld c,080h		;4df0
	call L_4386		;4df2
	ld de,06473h		;4df5
	ld hl,01718h		;4df8
	ld c,080h		;4dfb
	call L_4386		;4dfd
	di			;4e00
	push hl			;4e01
	ld hl,0f0f1h		;4e02
	ld a,001h		;4e05
	ld (06000h),a		;4e07
	ld (hl),a			;4e0a
	inc a			;4e0b
	ld (08000h),a		;4e0c
	inc hl			;4e0f
	ld (hl),a			;4e10
	inc a			;4e11
	ld (0a000h),a		;4e12
	inc hl			;4e15
	ld (hl),a			;4e16
	pop hl			;4e17
	ei			;4e18
	ret			;4e19
L_4E1A:
	ld a,(0e0a1h)		;4e1a
	cp 004h		;4e1d
	ret nc			;4e1f
	di			;4e20
	push hl			;4e21
	ld hl,0f0f1h		;4e22
	ld a,007h		;4e25
	ld (06000h),a		;4e27
	ld (hl),a			;4e2a
	inc a			;4e2b
	ld (08000h),a		;4e2c
	inc hl			;4e2f
	ld (hl),a			;4e30
	inc a			;4e31
	ld (0a000h),a		;4e32
	inc hl			;4e35
	ld (hl),a			;4e36
	pop hl			;4e37
	ei			;4e38
	ld de,06496h		;4e39
	call L_4381		;4e3c
	ld de,0649ch		;4e3f
	ld hl,02ce0h		;4e42
	ld c,001h		;4e45
	call L_4386		;4e47
	ld de,064e4h		;4e4a
	call L_4381		;4e4d
	ld de,06538h		;4e50
	ld hl,03378h		;4e53
	ld c,001h		;4e56
	call L_4386		;4e58
	ld a,(0e0a1h)		;4e5b
	cp 002h		;4e5e
	ld hl,097b6h		;4e60
	jr c,L_4E68		;4e63
	ld hl,096f6h		;4e65
L_4E68:
	ld de,0e4e0h		;4e68
	ld bc,00018h		;4e6b
	ldir		;4e6e
	ld de,064d9h		;4e70
	ld hl,00c68h		;4e73
	ld c,080h		;4e76
	call L_4386		;4e78
	ld de,064deh		;4e7b
	ld hl,00ce0h		;4e7e
	ld c,080h		;4e81
	call L_4386		;4e83
	ld de,06562h		;4e86
	ld hl,012b8h		;4e89
	ld c,080h		;4e8c
	call L_4386		;4e8e
	ld de,06586h		;4e91
	ld hl,01378h		;4e94
	ld c,080h		;4e97
	call L_4386		;4e99
	di			;4e9c
	push hl			;4e9d
	ld hl,0f0f1h		;4e9e
	ld a,001h		;4ea1
	ld (06000h),a		;4ea3
	ld (hl),a			;4ea6
	inc a			;4ea7
	ld (08000h),a		;4ea8
	inc hl			;4eab
	ld (hl),a			;4eac
	inc a			;4ead
	ld (0a000h),a		;4eae
	inc hl			;4eb1
	ld (hl),a			;4eb2
	pop hl			;4eb3
	ei			;4eb4
	ret			;4eb5
L_4EB6:
	ld a,(0e0a1h)		;4eb6
	cp 004h		;4eb9
	ret z			;4ebb
	cp 005h		;4ebc
	ret z			;4ebe
	cp 007h		;4ebf
	ret z			;4ec1
	cp 008h		;4ec2
	ret z			;4ec4
	di			;4ec5
	push hl			;4ec6
	ld hl,0f0f1h		;4ec7
	ld a,007h		;4eca
	ld (06000h),a		;4ecc
	ld (hl),a			;4ecf
	inc a			;4ed0
	ld (08000h),a		;4ed1
	inc hl			;4ed4
	ld (hl),a			;4ed5
	inc a			;4ed6
	ld (0a000h),a		;4ed7
	inc hl			;4eda
	ld (hl),a			;4edb
	pop hl			;4edc
	ei			;4edd
	ld de,06591h		;4ede
	call L_4381		;4ee1
	ld de,065b1h		;4ee4
	ld hl,02de0h		;4ee7
	ld c,001h		;4eea
	call L_4386		;4eec
	ld de,06630h		;4eef
	call L_4381		;4ef2
	ld de,0665ah		;4ef5
	ld hl,03470h		;4ef8
	ld c,001h		;4efb
	call L_4386		;4efd
	ld a,(0e0a1h)		;4f00
	cp 002h		;4f03
	ld hl,097ceh		;4f05
	jr c,L_4F0D		;4f08
	ld hl,096f6h		;4f0a
L_4F0D:
	ld de,0e4e0h		;4f0d
	ld bc,00018h		;4f10
	ldir		;4f13
	ld de,065f2h		;4f15
	ld hl,00d58h		;4f18
	ld c,080h		;4f1b
	call L_4386		;4f1d
	ld de,06606h		;4f20
	ld hl,00de0h		;4f23
	ld c,080h		;4f26
	call L_4386		;4f28
	ld de,066dah		;4f2b
	ld hl,013b0h		;4f2e
	ld c,080h		;4f31
	call L_4386		;4f33
	ld de,066f5h		;4f36
	ld hl,01470h		;4f39
	ld c,080h		;4f3c
	call L_4386		;4f3e
	di			;4f41
	push hl			;4f42
	ld hl,0f0f1h		;4f43
	ld a,001h		;4f46
	ld (06000h),a		;4f48
	ld (hl),a			;4f4b
	inc a			;4f4c
	ld (08000h),a		;4f4d
	inc hl			;4f50
	ld (hl),a			;4f51
	inc a			;4f52
	ld (0a000h),a		;4f53
	inc hl			;4f56
	ld (hl),a			;4f57
	pop hl			;4f58
	ei			;4f59
	ret			;4f5a
L_4F5B:
	ld a,(0e0a1h)		;4f5b
	cp 007h		;4f5e
	ret nz			;4f60
	di			;4f61
	push hl			;4f62
	ld hl,0f0f1h		;4f63
	ld a,007h		;4f66
	ld (06000h),a		;4f68
	ld (hl),a			;4f6b
	inc a			;4f6c
	ld (08000h),a		;4f6d
	inc hl			;4f70
	ld (hl),a			;4f71
	inc a			;4f72
	ld (0a000h),a		;4f73
	inc hl			;4f76
	ld (hl),a			;4f77
	pop hl			;4f78
	ei			;4f79
	ld de,06714h		;4f7a
	call L_4381		;4f7d
	ld de,0682fh		;4f80
	call L_4381		;4f83
	ld de,067cbh		;4f86
	call L_4381		;4f89
	ld de,068eah		;4f8c
	call L_4381		;4f8f
	di			;4f92
	push hl			;4f93
	ld hl,0f0f1h		;4f94
	ld a,001h		;4f97
	ld (06000h),a		;4f99
	ld (hl),a			;4f9c
	inc a			;4f9d
	ld (08000h),a		;4f9e
	inc hl			;4fa1
	ld (hl),a			;4fa2
	inc a			;4fa3
	ld (0a000h),a		;4fa4
	inc hl			;4fa7
	ld (hl),a			;4fa8
	pop hl			;4fa9
	ei			;4faa
	ret			;4fab
L_4FAC:
	ld a,(0e0a1h)		;4fac
	cp 004h		;4faf
	jr z,L_4FB6		;4fb1
	cp 005h		;4fb3
	ret nz			;4fb5
L_4FB6:
	di			;4fb6
	push hl			;4fb7
	ld hl,0f0f1h		;4fb8
	ld a,007h		;4fbb
	ld (06000h),a		;4fbd
	ld (hl),a			;4fc0
	inc a			;4fc1
	ld (08000h),a		;4fc2
	inc hl			;4fc5
	ld (hl),a			;4fc6
	inc a			;4fc7
	ld (0a000h),a		;4fc8
	inc hl			;4fcb
	ld (hl),a			;4fcc
	pop hl			;4fcd
	ei			;4fce
	ld de,06932h		;4fcf
	call L_4381		;4fd2
	ld de,06965h		;4fd5
	ld hl,02de8h		;4fd8
	ld c,001h		;4fdb
	call L_4386		;4fdd
	ld de,069f5h		;4fe0
	call L_4381		;4fe3
	ld de,06aafh		;4fe6
	ld hl,03460h		;4fe9
	ld c,001h		;4fec
	call L_4386		;4fee
	ld de,069a0h		;4ff1
	call L_4381		;4ff4
	ld de,069cfh		;4ff7
	ld hl,00de8h		;4ffa
	ld c,000h		;4ffd
	call L_4386		;4fff
	ld de,06ad6h		;5002
	call L_4381		;5005
	ld de,06b48h		;5008
	ld hl,01460h		;500b
	ld c,000h		;500e
	call L_4386		;5010
	di			;5013
	push hl			;5014
	ld hl,0f0f1h		;5015
	ld a,001h		;5018
	ld (06000h),a		;501a
	ld (hl),a			;501d
	inc a			;501e
	ld (08000h),a		;501f
	inc hl			;5022
	ld (hl),a			;5023
	inc a			;5024
	ld (0a000h),a		;5025
	inc hl			;5028
	ld (hl),a			;5029
	pop hl			;502a
	ei			;502b
	ret			;502c
L_502D:
	ld a,(0e0a1h)		;502d
	cp 007h		;5030
	ret nz			;5032
	di			;5033
	push hl			;5034
	ld hl,0f0f1h		;5035
	ld a,007h		;5038
	ld (06000h),a		;503a
	ld (hl),a			;503d
	inc a			;503e
	ld (08000h),a		;503f
	inc hl			;5042
	ld (hl),a			;5043
	inc a			;5044
	ld (0a000h),a		;5045
	inc hl			;5048
	ld (hl),a			;5049
	pop hl			;504a
	ei			;504b
	ld de,06b64h		;504c
	call L_4381		;504f
	ld de,06b82h		;5052
	ld hl,02dd8h		;5055
	ld c,001h		;5058
	call L_4386		;505a
	ld de,06c11h		;505d
	call L_4381		;5060
	ld de,06c13h		;5063
	ld hl,03420h		;5066
	ld c,001h		;5069
	call L_4386		;506b
	ld de,06bdbh		;506e
	call L_4381		;5071
	ld de,06be9h		;5074
	ld hl,00dd8h		;5077
	ld c,000h		;507a
	call L_4386		;507c
	ld de,06c7ah		;507f
	call L_4381		;5082
	ld de,06c7ch		;5085
	ld hl,01420h		;5088
	ld c,000h		;508b
	call L_4386		;508d
	di			;5090
	push hl			;5091
	ld hl,0f0f1h		;5092
	ld a,001h		;5095
	ld (06000h),a		;5097
	ld (hl),a			;509a
	inc a			;509b
	ld (08000h),a		;509c
	inc hl			;509f
	ld (hl),a			;50a0
	inc a			;50a1
	ld (0a000h),a		;50a2
	inc hl			;50a5
	ld (hl),a			;50a6
	pop hl			;50a7
	ei			;50a8
	ret			;50a9
L_50AA:
	ld a,(0e0a1h)		;50aa
	cp 008h		;50ad
	ret nz			;50af
	di			;50b0
	push hl			;50b1
	ld hl,0f0f1h		;50b2
	ld a,007h		;50b5
	ld (06000h),a		;50b7
	ld (hl),a			;50ba
	inc a			;50bb
	ld (08000h),a		;50bc
	inc hl			;50bf
	ld (hl),a			;50c0
	inc a			;50c1
	ld (0a000h),a		;50c2
	inc hl			;50c5
	ld (hl),a			;50c6
	pop hl			;50c7
	ei			;50c8
	ld de,06c9ch		;50c9
	call L_4381		;50cc
	ld de,06fb9h		;50cf
	ld hl,02570h		;50d2
	ld c,001h		;50d5
	call L_4386		;50d7
	ld de,06fdbh		;50da
	call L_4381		;50dd
	ld de,07640h		;50e0
	ld hl,02fc8h		;50e3
	ld c,001h		;50e6
	call L_4386		;50e8
	ld de,06fc3h		;50eb
	call L_4381		;50ee
	ld de,06fd8h		;50f1
	ld hl,00570h		;50f4
	ld c,000h		;50f7
	call L_4386		;50f9
	ld de,07655h		;50fc
	call L_4381		;50ff
	ld de,07683h		;5102
	ld hl,00fc8h		;5105
	ld c,000h		;5108
	call L_4386		;510a
	di			;510d
	push hl			;510e
	ld hl,0f0f1h		;510f
	ld a,001h		;5112
	ld (06000h),a		;5114
	ld (hl),a			;5117
	inc a			;5118
	ld (08000h),a		;5119
	inc hl			;511c
	ld (hl),a			;511d
	inc a			;511e
	ld (0a000h),a		;511f
	inc hl			;5122
	ld (hl),a			;5123
	pop hl			;5124
	ei			;5125
	ret			;5126
L_5127:
	ld a,(0e0a1h)		;5127
	cp 008h		;512a
	ret nz			;512c
	di			;512d
	push hl			;512e
	ld hl,0f0f1h		;512f
	ld a,007h		;5132
	ld (06000h),a		;5134
	ld (hl),a			;5137
	inc a			;5138
	ld (08000h),a		;5139
	inc hl			;513c
	ld (hl),a			;513d
	inc a			;513e
	ld (0a000h),a		;513f
	inc hl			;5142
	ld (hl),a			;5143
	pop hl			;5144
	ei			;5145
	ld de,07686h		;5146
	call L_4381		;5149
	di			;514c
	push hl			;514d
	ld hl,0f0f1h		;514e
	ld a,001h		;5151
	ld (06000h),a		;5153
	ld (hl),a			;5156
	inc a			;5157
	ld (08000h),a		;5158
	inc hl			;515b
	ld (hl),a			;515c
	inc a			;515d
	ld (0a000h),a		;515e
	inc hl			;5161
	ld (hl),a			;5162
	pop hl			;5163
	ei			;5164
	ret			;5165
L_5166:
	ld a,(0e0a1h)		;5166
	cp 005h		;5169
	ret z			;516b
	cp 006h		;516c
	ret z			;516e
	cp 007h		;516f
	ret z			;5171
	cp 008h		;5172
	ret z			;5174
	cp 009h		;5175
	ret z			;5177
	di			;5178
	push hl			;5179
	ld hl,0f0f1h		;517a
	ld a,007h		;517d
	ld (06000h),a		;517f
	ld (hl),a			;5182
	inc a			;5183
	ld (08000h),a		;5184
	inc hl			;5187
	ld (hl),a			;5188
	inc a			;5189
	ld (0a000h),a		;518a
	inc hl			;518d
	ld (hl),a			;518e
	pop hl			;518f
	ei			;5190
	ld de,07806h		;5191
	call L_4381		;5194
	ld de,07857h		;5197
	ld hl,024f0h		;519a
	ld c,001h		;519d
	call L_4386		;519f
	ld de,07891h		;51a2
	call L_4381		;51a5
	ld de,078c8h		;51a8
	ld hl,004f0h		;51ab
	ld c,000h		;51ae
	call L_4386		;51b0
	di			;51b3
	push hl			;51b4
	ld hl,0f0f1h		;51b5
	ld a,001h		;51b8
	ld (06000h),a		;51ba
	ld (hl),a			;51bd
	inc a			;51be
	ld (08000h),a		;51bf
	inc hl			;51c2
	ld (hl),a			;51c3
	inc a			;51c4
	ld (0a000h),a		;51c5
	inc hl			;51c8
	ld (hl),a			;51c9
	pop hl			;51ca
	ei			;51cb
	ret			;51cc
L_51CD:
	di			;51cd
	push hl			;51ce
	ld hl,0f0f1h		;51cf
	ld a,004h		;51d2
	ld (06000h),a		;51d4
	ld (hl),a			;51d7
	inc a			;51d8
	ld (08000h),a		;51d9
	inc hl			;51dc
	ld (hl),a			;51dd
	inc a			;51de
	ld (0a000h),a		;51df
	inc hl			;51e2
	ld (hl),a			;51e3
	pop hl			;51e4
	ei			;51e5
	ld de,0b71bh		;51e6
	ld hl,02590h		;51e9
	call L_42A8		;51ec
	ld de,0b96ah		;51ef
	ld hl,00590h		;51f2
	call L_42A8		;51f5
	di			;51f8
	push hl			;51f9
	ld hl,0f0f1h		;51fa
	ld a,001h		;51fd
	ld (06000h),a		;51ff
	ld (hl),a			;5202
	inc a			;5203
	ld (08000h),a		;5204
	inc hl			;5207
	ld (hl),a			;5208
	inc a			;5209
	ld (0a000h),a		;520a
	inc hl			;520d
	ld (hl),a			;520e
	pop hl			;520f
	ei			;5210
	ret			;5211
L_5212:
	di			;5212
	push hl			;5213
	ld hl,0f0f1h		;5214
	ld a,007h		;5217
	ld (06000h),a		;5219
	ld (hl),a			;521c
	inc a			;521d
	ld (08000h),a		;521e
	inc hl			;5221
	ld (hl),a			;5222
	inc a			;5223
	ld (0a000h),a		;5224
	inc hl			;5227
	ld (hl),a			;5228
	pop hl			;5229
	ei			;522a
	ld de,09229h		;522b
	call L_4381		;522e
	ld de,09234h		;5231
	ld hl,02ea0h		;5234
	ld c,001h		;5237
	call L_4386		;5239
	di			;523c
	push hl			;523d
	ld hl,0f0f1h		;523e
	ld a,001h		;5241
	ld (06000h),a		;5243
	ld (hl),a			;5246
	inc a			;5247
	ld (08000h),a		;5248
	inc hl			;524b
	ld (hl),a			;524c
	inc a			;524d
	ld (0a000h),a		;524e
	inc hl			;5251
	ld (hl),a			;5252
	pop hl			;5253
	ei			;5254
	ret			;5255
L_5256:
	di			;5256
	push hl			;5257
	ld hl,0f0f1h		;5258
	ld a,007h		;525b
	ld (06000h),a		;525d
	ld (hl),a			;5260
	inc a			;5261
	ld (08000h),a		;5262
	inc hl			;5265
	ld (hl),a			;5266
	inc a			;5267
	ld (0a000h),a		;5268
	inc hl			;526b
	ld (hl),a			;526c
	pop hl			;526d
	ei			;526e
	ld de,09457h		;526f
	call L_4381		;5272
	ld de,09473h		;5275
	ld hl,03488h		;5278
	ld c,001h		;527b
	call L_4386		;527d
	di			;5280
	push hl			;5281
	ld hl,0f0f1h		;5282
	ld a,001h		;5285
	ld (06000h),a		;5287
	ld (hl),a			;528a
	inc a			;528b
	ld (08000h),a		;528c
	inc hl			;528f
	ld (hl),a			;5290
	inc a			;5291
	ld (0a000h),a		;5292
	inc hl			;5295
	ld (hl),a			;5296
	pop hl			;5297
	ei			;5298
	ret			;5299
L_529A:
	di			;529a
	push hl			;529b
	ld hl,0f0f1h		;529c
	ld a,007h		;529f
	ld (06000h),a		;52a1
	ld (hl),a			;52a4
	inc a			;52a5
	ld (08000h),a		;52a6
	inc hl			;52a9
	ld (hl),a			;52aa
	inc a			;52ab
	ld (0a000h),a		;52ac
	inc hl			;52af
	ld (hl),a			;52b0
	pop hl			;52b1
	ei			;52b2
	ld a,(0e0a1h)		;52b3
	cp 002h		;52b6
	ld hl,09816h		;52b8
	jr c,L_52D2		;52bb
	cp 004h		;52bd
	ld hl,097e6h		;52bf
	jr z,L_52D2		;52c2
	cp 005h		;52c4
	jr z,L_52D2		;52c6
	cp 007h		;52c8
	ld hl,097feh		;52ca
	jr z,L_52D2		;52cd
	ld hl,096f6h		;52cf
L_52D2:
	ld de,0e4e0h		;52d2
	ld bc,00018h		;52d5
	ldir		;52d8
	ld de,09373h		;52da
	ld hl,00d50h		;52dd
	ld c,080h		;52e0
	call L_4386		;52e2
	ld de,0937ah		;52e5
	ld hl,00ea0h		;52e8
	ld c,080h		;52eb
	call L_4386		;52ed
	di			;52f0
	push hl			;52f1
	ld hl,0f0f1h		;52f2
	ld a,001h		;52f5
	ld (06000h),a		;52f7
	ld (hl),a			;52fa
	inc a			;52fb
	ld (08000h),a		;52fc
	inc hl			;52ff
	ld (hl),a			;5300
	inc a			;5301
	ld (0a000h),a		;5302
	inc hl			;5305
	ld (hl),a			;5306
	pop hl			;5307
	ei			;5308
	ret			;5309
L_530A:
	di			;530a
	push hl			;530b
	ld hl,0f0f1h		;530c
	ld a,007h		;530f
	ld (06000h),a		;5311
	ld (hl),a			;5314
	inc a			;5315
	ld (08000h),a		;5316
	inc hl			;5319
	ld (hl),a			;531a
	inc a			;531b
	ld (0a000h),a		;531c
	inc hl			;531f
	ld (hl),a			;5320
	pop hl			;5321
	ei			;5322
	ld a,(0e0a1h)		;5323
	cp 002h		;5326
	ld hl,09816h		;5328
	jr c,L_5342		;532b
	cp 004h		;532d
	ld hl,097e6h		;532f
	jr z,L_5342		;5332
	cp 005h		;5334
	jr z,L_5342		;5336
	cp 007h		;5338
	ld hl,097feh		;533a
	jr z,L_5342		;533d
	ld hl,096f6h		;533f
L_5342:
	ld de,0e4e0h		;5342
	ld bc,00018h		;5345
	ldir		;5348
	ld de,095fbh		;534a
	ld hl,012b8h		;534d
	ld c,080h		;5350
	call L_4386		;5352
	ld de,0960dh		;5355
	ld hl,01488h		;5358
	ld c,080h		;535b
	call L_4386		;535d
	di			;5360
	push hl			;5361
	ld hl,0f0f1h		;5362
	ld a,001h		;5365
	ld (06000h),a		;5367
	ld (hl),a			;536a
	inc a			;536b
	ld (08000h),a		;536c
	inc hl			;536f
	ld (hl),a			;5370
	inc a			;5371
	ld (0a000h),a		;5372
	inc hl			;5375
	ld (hl),a			;5376
	pop hl			;5377
	ei			;5378
	ret			;5379
L_537A:
	di			;537a
	push hl			;537b
	ld hl,0f0f1h		;537c
	ld a,007h		;537f
	ld (06000h),a		;5381
	ld (hl),a			;5384
	inc a			;5385
	ld (08000h),a		;5386
	inc hl			;5389
	ld (hl),a			;538a
	inc a			;538b
	ld (0a000h),a		;538c
	inc hl			;538f
	ld (hl),a			;5390
	pop hl			;5391
	ei			;5392
	ld de,08b7dh		;5393
	call L_4381		;5396
	ld de,08c2ch		;5399
	ld hl,02e00h		;539c
	ld c,001h		;539f
	call L_4386		;53a1
	ld de,08d0eh		;53a4
	call L_4381		;53a7
	ld de,08d31h		;53aa
	ld hl,02f80h		;53ad
	ld c,001h		;53b0
	call L_4386		;53b2
	di			;53b5
	push hl			;53b6
	ld hl,0f0f1h		;53b7
	ld a,001h		;53ba
	ld (06000h),a		;53bc
	ld (hl),a			;53bf
	inc a			;53c0
	ld (08000h),a		;53c1
	inc hl			;53c4
	ld (hl),a			;53c5
	inc a			;53c6
	ld (0a000h),a		;53c7
	inc hl			;53ca
	ld (hl),a			;53cb
	pop hl			;53cc
	ei			;53cd
	ret			;53ce
L_53CF:
	di			;53cf
	push hl			;53d0
	ld hl,0f0f1h		;53d1
	ld a,007h		;53d4
	ld (06000h),a		;53d6
	ld (hl),a			;53d9
	inc a			;53da
	ld (08000h),a		;53db
	inc hl			;53de
	ld (hl),a			;53df
	inc a			;53e0
	ld (0a000h),a		;53e1
	inc hl			;53e4
	ld (hl),a			;53e5
	pop hl			;53e6
	ei			;53e7
	ld de,08e52h		;53e8
	call L_4381		;53eb
	ld de,08ef1h		;53ee
	ld hl,033e0h		;53f1
	ld c,001h		;53f4
	call L_4386		;53f6
	ld de,08f56h		;53f9
	call L_4381		;53fc
	ld de,08ffch		;53ff
	ld hl,03600h		;5402
	ld c,001h		;5405
	call L_4386		;5407
	di			;540a
	push hl			;540b
	ld hl,0f0f1h		;540c
	ld a,001h		;540f
	ld (06000h),a		;5411
	ld (hl),a			;5414
	inc a			;5415
	ld (08000h),a		;5416
	inc hl			;5419
	ld (hl),a			;541a
	inc a			;541b
	ld (0a000h),a		;541c
	inc hl			;541f
	ld (hl),a			;5420
	pop hl			;5421
	ei			;5422
	ret			;5423
L_5424:
	di			;5424
	push hl			;5425
	ld hl,0f0f1h		;5426
	ld a,007h		;5429
	ld (06000h),a		;542b
	ld (hl),a			;542e
	inc a			;542f
	ld (08000h),a		;5430
	inc hl			;5433
	ld (hl),a			;5434
	inc a			;5435
	ld (0a000h),a		;5436
	inc hl			;5439
	ld (hl),a			;543a
	pop hl			;543b
	ei			;543c
	ld a,(0e0a1h)		;543d
	cp 002h		;5440
	ld hl,0982eh		;5442
	jr c,L_544A		;5445
	ld hl,096f6h		;5447
L_544A:
	ld de,0e4e0h		;544a
	ld bc,00018h		;544d
	ldir		;5450
	ld de,08da3h		;5452
	ld hl,00c68h		;5455
	ld c,080h		;5458
	call L_4386		;545a
	ld de,08db5h		;545d
	ld hl,00e00h		;5460
	ld c,080h		;5463
	call L_4386		;5465
	ld de,08e13h		;5468
	ld hl,00ee8h		;546b
	ld c,080h		;546e
	call L_4386		;5470
	ld de,08e19h		;5473
	ld hl,00f80h		;5476
	ld c,080h		;5479
	call L_4386		;547b
	di			;547e
	push hl			;547f
	ld hl,0f0f1h		;5480
	ld a,001h		;5483
	ld (06000h),a		;5485
	ld (hl),a			;5488
	inc a			;5489
	ld (08000h),a		;548a
	inc hl			;548d
	ld (hl),a			;548e
	inc a			;548f
	ld (0a000h),a		;5490
	inc hl			;5493
	ld (hl),a			;5494
	pop hl			;5495
	ei			;5496
	ret			;5497
L_5498:
	di			;5498
	push hl			;5499
	ld hl,0f0f1h		;549a
	ld a,007h		;549d
	ld (06000h),a		;549f
	ld (hl),a			;54a2
	inc a			;54a3
	ld (08000h),a		;54a4
	inc hl			;54a7
	ld (hl),a			;54a8
	inc a			;54a9
	ld (0a000h),a		;54aa
	inc hl			;54ad
	ld (hl),a			;54ae
	pop hl			;54af
	ei			;54b0
	ld a,(0e0a1h)		;54b1
	cp 002h		;54b4
	ld hl,0982eh		;54b6
	jr c,L_54BE		;54b9
	ld hl,096f6h		;54bb
L_54BE:
	ld de,0e4e0h		;54be
	ld bc,00018h		;54c1
	ldir		;54c4
	ld de,090e7h		;54c6
	ld hl,012b8h		;54c9
	ld c,080h		;54cc
	call L_4386		;54ce
	ld de,09105h		;54d1
	ld hl,013e0h		;54d4
	ld c,080h		;54d7
	call L_4386		;54d9
	ld de,09138h		;54dc
	ld hl,01450h		;54df
	ld c,080h		;54e2
	call L_4386		;54e4
	ld de,09150h		;54e7
	ld hl,01600h		;54ea
	ld c,080h		;54ed
	call L_4386		;54ef
	di			;54f2
	push hl			;54f3
	ld hl,0f0f1h		;54f4
	ld a,001h		;54f7
	ld (06000h),a		;54f9
	ld (hl),a			;54fc
	inc a			;54fd
	ld (08000h),a		;54fe
	inc hl			;5501
	ld (hl),a			;5502
	inc a			;5503
	ld (0a000h),a		;5504
	inc hl			;5507
	ld (hl),a			;5508
	pop hl			;5509
	ei			;550a
	ret			;550b
L_550C:
	di			;550c
	push hl			;550d
	ld hl,0f0f1h		;550e
	ld a,004h		;5511
	ld (06000h),a		;5513
	ld (hl),a			;5516
	inc a			;5517
	ld (08000h),a		;5518
	inc hl			;551b
	ld (hl),a			;551c
	inc a			;551d
	ld (0a000h),a		;551e
	inc hl			;5521
	ld (hl),a			;5522
	pop hl			;5523
	ei			;5524
	ld de,0bcbch		;5525
	call L_4381		;5528
	ld de,0bcfdh		;552b
	ld hl,037a8h		;552e
	ld c,001h		;5531
	call L_4386		;5533
	ld de,0bd42h		;5536
	call L_4381		;5539
	ld de,0bd70h		;553c
	ld hl,017a8h		;553f
	ld c,000h		;5542
	call L_4386		;5544
	di			;5547
	push hl			;5548
	ld hl,0f0f1h		;5549
	ld a,001h		;554c
	ld (06000h),a		;554e
	ld (hl),a			;5551
	inc a			;5552
	ld (08000h),a		;5553
	inc hl			;5556
	ld (hl),a			;5557
	inc a			;5558
	ld (0a000h),a		;5559
	inc hl			;555c
	ld (hl),a			;555d
	pop hl			;555e
	ei			;555f
	ret			;5560
L_5561:
	di			;5561
	push hl			;5562
	ld hl,0f0f1h		;5563
	ld a,007h		;5566
	ld (06000h),a		;5568
	ld (hl),a			;556b
	inc a			;556c
	ld (08000h),a		;556d
	inc hl			;5570
	ld (hl),a			;5571
	inc a			;5572
	ld (0a000h),a		;5573
	inc hl			;5576
	ld (hl),a			;5577
	pop hl			;5578
	ei			;5579
	ld de,091a3h		;557a
	call L_4381		;557d
	ld de,091bah		;5580
	ld hl,02cc0h		;5583
	ld c,001h		;5586
	call L_4386		;5588
	ld de,09209h		;558b
	call L_4381		;558e
	ld de,0920bh		;5591
	ld hl,032d8h		;5594
	ld c,001h		;5597
	call L_4386		;5599
	ld a,(0e0a1h)		;559c
	cp 002h		;559f
	ld hl,0982eh		;55a1
	jr c,L_55A9		;55a4
	ld hl,096f6h		;55a6
L_55A9:
	ld de,0e4e0h		;55a9
	ld bc,00018h		;55ac
	ldir		;55af
	ld de,091eeh		;55b1
	ld hl,00c68h		;55b4
	ld c,080h		;55b7
	call L_4386		;55b9
	ld de,091fch		;55bc
	ld hl,00cc0h		;55bf
	ld c,080h		;55c2
	call L_4386		;55c4
	ld de,09226h		;55c7
	ld hl,012b8h		;55ca
	ld c,080h		;55cd
	call L_4386		;55cf
	ld de,09226h		;55d2
	ld hl,012d8h		;55d5
	ld c,080h		;55d8
	call L_4386		;55da
	di			;55dd
	push hl			;55de
	ld hl,0f0f1h		;55df
	ld a,001h		;55e2
	ld (06000h),a		;55e4
	ld (hl),a			;55e7
	inc a			;55e8
	ld (08000h),a		;55e9
	inc hl			;55ec
	ld (hl),a			;55ed
	inc a			;55ee
	ld (0a000h),a		;55ef
	inc hl			;55f2
	ld (hl),a			;55f3
	pop hl			;55f4
	ei			;55f5
	ret			;55f6
L_55F7:
	di			;55f7
	push hl			;55f8
	ld hl,0f0f1h		;55f9
	ld a,007h		;55fc
	ld (06000h),a		;55fe
	ld (hl),a			;5601
	inc a			;5602
	ld (08000h),a		;5603
	inc hl			;5606
	ld (hl),a			;5607
	inc a			;5608
	ld (0a000h),a		;5609
	inc hl			;560c
	ld (hl),a			;560d
	pop hl			;560e
	ei			;560f
	ld de,07e3ah		;5610
	call L_4381		;5613
	ld de,082ddh		;5616
	call L_4381		;5619
	ld a,(0e08bh)		;561c
	and 00fh		;561f
	cp 007h		;5621
	jr z,L_5630		;5623
	cp 005h		;5625
	jr z,L_5630		;5627
	cp 003h		;5629
	ld de,08416h		;562b
	jr nz,L_5642		;562e
L_5630:
	ld a,r		;5630
	rra			;5632
	rra			;5633
	and 003h		;5634
	ld (0e0e2h),a		;5636
	ld hl,0565fh		;5639
	call L_4055		;563c
	ld e,(hl)			;563f
	inc hl			;5640
	ld d,(hl)			;5641
L_5642:
	call L_4381		;5642
	di			;5645
	push hl			;5646
	ld hl,0f0f1h		;5647
	ld a,001h		;564a
	ld (06000h),a		;564c
	ld (hl),a			;564f
	inc a			;5650
	ld (08000h),a		;5651
	inc hl			;5654
	ld (hl),a			;5655
	inc a			;5656
	ld (0a000h),a		;5657
	inc hl			;565a
	ld (hl),a			;565b
	pop hl			;565c
	ei			;565d
	ret			;565e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x565f..0x5667  (8 bytes)
DATA_565F:
	defb 052h,084h,092h,084h,0d6h,084h,009h,085h	; 565f  R.......

; ======================================================================
; CODIGO 0x5667..0x5e3a  (2003 bytes)
; ======================================================================


L_5667:
	di			;5667
	push hl			;5668
	ld hl,0f0f1h		;5669
	ld a,007h		;566c
	ld (06000h),a		;566e
	ld (hl),a			;5671
	inc a			;5672
	ld (08000h),a		;5673
	inc hl			;5676
	ld (hl),a			;5677
	inc a			;5678
	ld (0a000h),a		;5679
	inc hl			;567c
	ld (hl),a			;567d
	pop hl			;567e
	ei			;567f
	ld de,07fbch		;5680
	call L_4381		;5683
	di			;5686
	push hl			;5687
	ld hl,0f0f1h		;5688
	ld a,001h		;568b
	ld (06000h),a		;568d
	ld (hl),a			;5690
	inc a			;5691
	ld (08000h),a		;5692
	inc hl			;5695
	ld (hl),a			;5696
	inc a			;5697
	ld (0a000h),a		;5698
	inc hl			;569b
	ld (hl),a			;569c
	pop hl			;569d
	ei			;569e
	ret			;569f
L_56A0:
	di			;56a0
	push hl			;56a1
	ld hl,0f0f1h		;56a2
	ld a,007h		;56a5
	ld (06000h),a		;56a7
	ld (hl),a			;56aa
	inc a			;56ab
	ld (08000h),a		;56ac
	inc hl			;56af
	ld (hl),a			;56b0
	inc a			;56b1
	ld (0a000h),a		;56b2
	inc hl			;56b5
	ld (hl),a			;56b6
	pop hl			;56b7
	ei			;56b8
	ld de,081cfh		;56b9
	call L_4381		;56bc
	di			;56bf
	push hl			;56c0
	ld hl,0f0f1h		;56c1
	ld a,001h		;56c4
	ld (06000h),a		;56c6
	ld (hl),a			;56c9
	inc a			;56ca
	ld (08000h),a		;56cb
	inc hl			;56ce
	ld (hl),a			;56cf
	inc a			;56d0
	ld (0a000h),a		;56d1
	inc hl			;56d4
	ld (hl),a			;56d5
	pop hl			;56d6
	ei			;56d7
	ret			;56d8
L_56D9:
	di			;56d9
	push hl			;56da
	ld hl,0f0f1h		;56db
	ld a,007h		;56de
	ld (06000h),a		;56e0
	ld (hl),a			;56e3
	inc a			;56e4
	ld (08000h),a		;56e5
	inc hl			;56e8
	ld (hl),a			;56e9
	inc a			;56ea
	ld (0a000h),a		;56eb
	inc hl			;56ee
	ld (hl),a			;56ef
	pop hl			;56f0
	ei			;56f1
	ld de,07e3ch		;56f2
	ld hl,01ca0h		;56f5
	ld c,000h		;56f8
	call L_4386		;56fa
	di			;56fd
	push hl			;56fe
	ld hl,0f0f1h		;56ff
	ld a,001h		;5702
	ld (06000h),a		;5704
	ld (hl),a			;5707
	inc a			;5708
	ld (08000h),a		;5709
	inc hl			;570c
	ld (hl),a			;570d
	inc a			;570e
	ld (0a000h),a		;570f
	inc hl			;5712
	ld (hl),a			;5713
	pop hl			;5714
	ei			;5715
	ret			;5716
L_5717:
	di			;5717
	push hl			;5718
	ld hl,0f0f1h		;5719
	ld a,007h		;571c
	ld (06000h),a		;571e
	ld (hl),a			;5721
	inc a			;5722
	ld (08000h),a		;5723
	inc hl			;5726
	ld (hl),a			;5727
	inc a			;5728
	ld (0a000h),a		;5729
	inc hl			;572c
	ld (hl),a			;572d
	pop hl			;572e
	ei			;572f
	ld de,0852ch		;5730
	call L_4381		;5733
	di			;5736
	push hl			;5737
	ld hl,0f0f1h		;5738
	ld a,001h		;573b
	ld (06000h),a		;573d
	ld (hl),a			;5740
	inc a			;5741
	ld (08000h),a		;5742
	inc hl			;5745
	ld (hl),a			;5746
	inc a			;5747
	ld (0a000h),a		;5748
	inc hl			;574b
	ld (hl),a			;574c
	pop hl			;574d
	ei			;574e
	ret			;574f
L_5750:
	di			;5750
	push hl			;5751
	ld hl,0f0f1h		;5752
	ld a,007h		;5755
	ld (06000h),a		;5757
	ld (hl),a			;575a
	inc a			;575b
	ld (08000h),a		;575c
	inc hl			;575f
	ld (hl),a			;5760
	inc a			;5761
	ld (0a000h),a		;5762
	inc hl			;5765
	ld (hl),a			;5766
	pop hl			;5767
	ei			;5768
	ld de,07d6fh		;5769
	call L_4381		;576c
	di			;576f
	push hl			;5770
	ld hl,0f0f1h		;5771
	ld a,001h		;5774
	ld (06000h),a		;5776
	ld (hl),a			;5779
	inc a			;577a
	ld (08000h),a		;577b
	inc hl			;577e
	ld (hl),a			;577f
	inc a			;5780
	ld (0a000h),a		;5781
	inc hl			;5784
	ld (hl),a			;5785
	pop hl			;5786
	ei			;5787
	ret			;5788
L_5789:
	di			;5789
	push hl			;578a
	ld hl,0f0f1h		;578b
	ld a,007h		;578e
	ld (06000h),a		;5790
	ld (hl),a			;5793
	inc a			;5794
	ld (08000h),a		;5795
	inc hl			;5798
	ld (hl),a			;5799
	inc a			;579a
	ld (0a000h),a		;579b
	inc hl			;579e
	ld (hl),a			;579f
	pop hl			;57a0
	ei			;57a1
	ld de,082adh		;57a2
	call L_4381		;57a5
	di			;57a8
	push hl			;57a9
	ld hl,0f0f1h		;57aa
	ld a,001h		;57ad
	ld (06000h),a		;57af
	ld (hl),a			;57b2
	inc a			;57b3
	ld (08000h),a		;57b4
	inc hl			;57b7
	ld (hl),a			;57b8
	inc a			;57b9
	ld (0a000h),a		;57ba
	inc hl			;57bd
	ld (hl),a			;57be
	pop hl			;57bf
	ei			;57c0
	ret			;57c1
L_57C2:
	di			;57c2
	push hl			;57c3
	ld hl,0f0f1h		;57c4
	ld a,007h		;57c7
	ld (06000h),a		;57c9
	ld (hl),a			;57cc
	inc a			;57cd
	ld (08000h),a		;57ce
	inc hl			;57d1
	ld (hl),a			;57d2
	inc a			;57d3
	ld (0a000h),a		;57d4
	inc hl			;57d7
	ld (hl),a			;57d8
	pop hl			;57d9
	ei			;57da
	ld de,0823ah		;57db
	call L_4381		;57de
	di			;57e1
	push hl			;57e2
	ld hl,0f0f1h		;57e3
	ld a,001h		;57e6
	ld (06000h),a		;57e8
	ld (hl),a			;57eb
	inc a			;57ec
	ld (08000h),a		;57ed
	inc hl			;57f0
	ld (hl),a			;57f1
	inc a			;57f2
	ld (0a000h),a		;57f3
	inc hl			;57f6
	ld (hl),a			;57f7
	pop hl			;57f8
	ei			;57f9
	ret			;57fa
L_57FB:
	di			;57fb
	push hl			;57fc
	ld hl,0f0f1h		;57fd
	ld a,007h		;5800
	ld (06000h),a		;5802
	ld (hl),a			;5805
	inc a			;5806
	ld (08000h),a		;5807
	inc hl			;580a
	ld (hl),a			;580b
	inc a			;580c
	ld (0a000h),a		;580d
	inc hl			;5810
	ld (hl),a			;5811
	pop hl			;5812
	ei			;5813
	ld a,(0e0a1h)		;5814
	cp 007h		;5817
	jr z,L_585B		;5819
	cp 008h		;581b
	jr z,L_585B		;581d
	cp 002h		;581f
	jr z,L_5839		;5821
	cp 003h		;5823
	jr z,L_5839		;5825
	cp 006h		;5827
	jr z,L_5839		;5829
	ld de,078f1h		;582b
	ld bc,00301h		;582e
	call L_43B3		;5831
	call L_4381		;5834
	jr L_5845		;5837
L_5839:
	ld de,08600h		;5839
	ld bc,00301h		;583c
	call L_43B3		;583f
	call L_4381		;5842
L_5845:
	ld a,(0e0a1h)		;5845
	cp 004h		;5848
	jr z,L_5850		;584a
	cp 005h		;584c
	jr nz,L_586D		;584e
L_5850:
	ld de,07af2h		;5850
	ld bc,00201h		;5853
	call L_43B3		;5856
	jr L_586D		;5859
L_585B:
	ld de,079c7h		;585b
	ld bc,00200h		;585e
	call L_43B3		;5861
	ld bc,00101h		;5864
	call L_43B3		;5867
	call L_4381		;586a
L_586D:
	ld de,07b34h		;586d
	ld bc,00800h		;5870
	call L_43B3		;5873
	ld bc,00301h		;5876
	call L_43B3		;5879
	call L_4381		;587c
	ld a,(0e0a1h)		;587f
	cp 002h		;5882
	jr z,L_588E		;5884
	cp 003h		;5886
	jr z,L_588E		;5888
	cp 006h		;588a
	jr nz,L_5897		;588c
L_588E:
	ld de,086d3h		;588e
	ld bc,00101h		;5891
	call L_43B3		;5894
L_5897:
	di			;5897
	push hl			;5898
	ld hl,0f0f1h		;5899
	ld a,001h		;589c
	ld (06000h),a		;589e
	ld (hl),a			;58a1
	inc a			;58a2
	ld (08000h),a		;58a3
	inc hl			;58a6
	ld (hl),a			;58a7
	inc a			;58a8
	ld (0a000h),a		;58a9
	inc hl			;58ac
	ld (hl),a			;58ad
	pop hl			;58ae
	ei			;58af
	ret			;58b0
L_58B1:
	di			;58b1
	push hl			;58b2
	ld hl,0f0f1h		;58b3
	ld a,007h		;58b6
	ld (06000h),a		;58b8
	ld (hl),a			;58bb
	inc a			;58bc
	ld (08000h),a		;58bd
	inc hl			;58c0
	ld (hl),a			;58c1
	inc a			;58c2
	ld (0a000h),a		;58c3
	inc hl			;58c6
	ld (hl),a			;58c7
	pop hl			;58c8
	ei			;58c9
	ld de,078f1h		;58ca
	ld bc,00301h		;58cd
	call L_43B3		;58d0
	call L_4381		;58d3
	di			;58d6
	push hl			;58d7
	ld hl,0f0f1h		;58d8
	ld a,001h		;58db
	ld (06000h),a		;58dd
	ld (hl),a			;58e0
	inc a			;58e1
	ld (08000h),a		;58e2
	inc hl			;58e5
	ld (hl),a			;58e6
	inc a			;58e7
	ld (0a000h),a		;58e8
	inc hl			;58eb
	ld (hl),a			;58ec
	pop hl			;58ed
	ei			;58ee
	ret			;58ef
L_58F0:
	di			;58f0
	push hl			;58f1
	ld hl,0f0f1h		;58f2
	ld a,007h		;58f5
	ld (06000h),a		;58f7
	ld (hl),a			;58fa
	inc a			;58fb
	ld (08000h),a		;58fc
	inc hl			;58ff
	ld (hl),a			;5900
	inc a			;5901
	ld (0a000h),a		;5902
	inc hl			;5905
	ld (hl),a			;5906
	pop hl			;5907
	ei			;5908
	ld de,07af2h		;5909
	ld bc,00201h		;590c
	call L_43B3		;590f
	di			;5912
	push hl			;5913
	ld hl,0f0f1h		;5914
	ld a,001h		;5917
	ld (06000h),a		;5919
	ld (hl),a			;591c
	inc a			;591d
	ld (08000h),a		;591e
	inc hl			;5921
	ld (hl),a			;5922
	inc a			;5923
	ld (0a000h),a		;5924
	inc hl			;5927
	ld (hl),a			;5928
	pop hl			;5929
	ei			;592a
	ret			;592b
L_592C:
	di			;592c
	push hl			;592d
	ld hl,0f0f1h		;592e
	ld a,007h		;5931
	ld (06000h),a		;5933
	ld (hl),a			;5936
	inc a			;5937
	ld (08000h),a		;5938
	inc hl			;593b
	ld (hl),a			;593c
	inc a			;593d
	ld (0a000h),a		;593e
	inc hl			;5941
	ld (hl),a			;5942
	pop hl			;5943
	ei			;5944
	ld de,08600h		;5945
	ld bc,00301h		;5948
	call L_43B3		;594b
	call L_4381		;594e
	ld de,086d3h		;5951
	ld bc,00101h		;5954
	call L_43B3		;5957
	di			;595a
	push hl			;595b
	ld hl,0f0f1h		;595c
	ld a,001h		;595f
	ld (06000h),a		;5961
	ld (hl),a			;5964
	inc a			;5965
	ld (08000h),a		;5966
	inc hl			;5969
	ld (hl),a			;596a
	inc a			;596b
	ld (0a000h),a		;596c
	inc hl			;596f
	ld (hl),a			;5970
	pop hl			;5971
	ei			;5972
	ret			;5973
L_5974:
	di			;5974
	push hl			;5975
	ld hl,0f0f1h		;5976
	ld a,007h		;5979
	ld (06000h),a		;597b
	ld (hl),a			;597e
	inc a			;597f
	ld (08000h),a		;5980
	inc hl			;5983
	ld (hl),a			;5984
	inc a			;5985
	ld (0a000h),a		;5986
	inc hl			;5989
	ld (hl),a			;598a
	pop hl			;598b
	ei			;598c
	jp L_586D		;598d
L_5990:
	di			;5990
	push hl			;5991
	ld hl,0f0f1h		;5992
	ld a,007h		;5995
	ld (06000h),a		;5997
	ld (hl),a			;599a
	inc a			;599b
	ld (08000h),a		;599c
	inc hl			;599f
	ld (hl),a			;59a0
	inc a			;59a1
	ld (0a000h),a		;59a2
	inc hl			;59a5
	ld (hl),a			;59a6
	pop hl			;59a7
	ei			;59a8
	ld de,086f5h		;59a9
	call L_4381		;59ac
	di			;59af
	push hl			;59b0
	ld hl,0f0f1h		;59b1
	ld a,001h		;59b4
	ld (06000h),a		;59b6
	ld (hl),a			;59b9
	inc a			;59ba
	ld (08000h),a		;59bb
	inc hl			;59be
	ld (hl),a			;59bf
	inc a			;59c0
	ld (0a000h),a		;59c1
	inc hl			;59c4
	ld (hl),a			;59c5
	pop hl			;59c6
	ei			;59c7
	ret			;59c8
L_59C9:
	di			;59c9
	push hl			;59ca
	ld hl,0f0f1h		;59cb
	ld a,007h		;59ce
	ld (06000h),a		;59d0
	ld (hl),a			;59d3
	inc a			;59d4
	ld (08000h),a		;59d5
	inc hl			;59d8
	ld (hl),a			;59d9
	inc a			;59da
	ld (0a000h),a		;59db
	inc hl			;59de
	ld (hl),a			;59df
	pop hl			;59e0
	ei			;59e1
	ld de,08757h		;59e2
	call L_4381		;59e5
	di			;59e8
	push hl			;59e9
	ld hl,0f0f1h		;59ea
	ld a,001h		;59ed
	ld (06000h),a		;59ef
	ld (hl),a			;59f2
	inc a			;59f3
	ld (08000h),a		;59f4
	inc hl			;59f7
	ld (hl),a			;59f8
	inc a			;59f9
	ld (0a000h),a		;59fa
	inc hl			;59fd
	ld (hl),a			;59fe
	pop hl			;59ff
	ei			;5a00
	ret			;5a01
L_5A02:
	di			;5a02
	push hl			;5a03
	ld hl,0f0f1h		;5a04
	ld a,007h		;5a07
	ld (06000h),a		;5a09
	ld (hl),a			;5a0c
	inc a			;5a0d
	ld (08000h),a		;5a0e
	inc hl			;5a11
	ld (hl),a			;5a12
	inc a			;5a13
	ld (0a000h),a		;5a14
	inc hl			;5a17
	ld (hl),a			;5a18
	pop hl			;5a19
	ei			;5a1a
	ld de,087b8h		;5a1b
	call L_4381		;5a1e
	di			;5a21
	push hl			;5a22
	ld hl,0f0f1h		;5a23
	ld a,001h		;5a26
	ld (06000h),a		;5a28
	ld (hl),a			;5a2b
	inc a			;5a2c
	ld (08000h),a		;5a2d
	inc hl			;5a30
	ld (hl),a			;5a31
	inc a			;5a32
	ld (0a000h),a		;5a33
	inc hl			;5a36
	ld (hl),a			;5a37
	pop hl			;5a38
	ei			;5a39
	ret			;5a3a
L_5A3B:
	di			;5a3b
	push hl			;5a3c
	ld hl,0f0f1h		;5a3d
	ld a,007h		;5a40
	ld (06000h),a		;5a42
	ld (hl),a			;5a45
	inc a			;5a46
	ld (08000h),a		;5a47
	inc hl			;5a4a
	ld (hl),a			;5a4b
	inc a			;5a4c
	ld (0a000h),a		;5a4d
	inc hl			;5a50
	ld (hl),a			;5a51
	pop hl			;5a52
	ei			;5a53
	ld de,0882eh		;5a54
	call L_4381		;5a57
	di			;5a5a
	push hl			;5a5b
	ld hl,0f0f1h		;5a5c
	ld a,001h		;5a5f
	ld (06000h),a		;5a61
	ld (hl),a			;5a64
	inc a			;5a65
	ld (08000h),a		;5a66
	inc hl			;5a69
	ld (hl),a			;5a6a
	inc a			;5a6b
	ld (0a000h),a		;5a6c
	inc hl			;5a6f
	ld (hl),a			;5a70
	pop hl			;5a71
	ei			;5a72
	ret			;5a73
L_5A74:
	di			;5a74
	push hl			;5a75
	ld hl,0f0f1h		;5a76
	ld a,007h		;5a79
	ld (06000h),a		;5a7b
	ld (hl),a			;5a7e
	inc a			;5a7f
	ld (08000h),a		;5a80
	inc hl			;5a83
	ld (hl),a			;5a84
	inc a			;5a85
	ld (0a000h),a		;5a86
	inc hl			;5a89
	ld (hl),a			;5a8a
	pop hl			;5a8b
	ei			;5a8c
	ld de,0888dh		;5a8d
	call L_4381		;5a90
	di			;5a93
	push hl			;5a94
	ld hl,0f0f1h		;5a95
	ld a,001h		;5a98
	ld (06000h),a		;5a9a
	ld (hl),a			;5a9d
	inc a			;5a9e
	ld (08000h),a		;5a9f
	inc hl			;5aa2
	ld (hl),a			;5aa3
	inc a			;5aa4
	ld (0a000h),a		;5aa5
	inc hl			;5aa8
	ld (hl),a			;5aa9
	pop hl			;5aaa
	ei			;5aab
	ret			;5aac
L_5AAD:
	di			;5aad
	push hl			;5aae
	ld hl,0f0f1h		;5aaf
	ld a,007h		;5ab2
	ld (06000h),a		;5ab4
	ld (hl),a			;5ab7
	inc a			;5ab8
	ld (08000h),a		;5ab9
	inc hl			;5abc
	ld (hl),a			;5abd
	inc a			;5abe
	ld (0a000h),a		;5abf
	inc hl			;5ac2
	ld (hl),a			;5ac3
	pop hl			;5ac4
	ei			;5ac5
	ld de,088e8h		;5ac6
	call L_4381		;5ac9
	di			;5acc
	push hl			;5acd
	ld hl,0f0f1h		;5ace
	ld a,001h		;5ad1
	ld (06000h),a		;5ad3
	ld (hl),a			;5ad6
	inc a			;5ad7
	ld (08000h),a		;5ad8
	inc hl			;5adb
	ld (hl),a			;5adc
	inc a			;5add
	ld (0a000h),a		;5ade
	inc hl			;5ae1
	ld (hl),a			;5ae2
	pop hl			;5ae3
	ei			;5ae4
	ret			;5ae5
L_5AE6:
	di			;5ae6
	push hl			;5ae7
	ld hl,0f0f1h		;5ae8
	ld a,007h		;5aeb
	ld (06000h),a		;5aed
	ld (hl),a			;5af0
	inc a			;5af1
	ld (08000h),a		;5af2
	inc hl			;5af5
	ld (hl),a			;5af6
	inc a			;5af7
	ld (0a000h),a		;5af8
	inc hl			;5afb
	ld (hl),a			;5afc
	pop hl			;5afd
	ei			;5afe
	ld de,089b8h		;5aff
	call L_4381		;5b02
	di			;5b05
	push hl			;5b06
	ld hl,0f0f1h		;5b07
	ld a,001h		;5b0a
	ld (06000h),a		;5b0c
	ld (hl),a			;5b0f
	inc a			;5b10
	ld (08000h),a		;5b11
	inc hl			;5b14
	ld (hl),a			;5b15
	inc a			;5b16
	ld (0a000h),a		;5b17
	inc hl			;5b1a
	ld (hl),a			;5b1b
	pop hl			;5b1c
	ei			;5b1d
	ret			;5b1e
L_5B1F:
	di			;5b1f
	push hl			;5b20
	ld hl,0f0f1h		;5b21
	ld a,007h		;5b24
	ld (06000h),a		;5b26
	ld (hl),a			;5b29
	inc a			;5b2a
	ld (08000h),a		;5b2b
	inc hl			;5b2e
	ld (hl),a			;5b2f
	inc a			;5b30
	ld (0a000h),a		;5b31
	inc hl			;5b34
	ld (hl),a			;5b35
	pop hl			;5b36
	ei			;5b37
	ld de,08a7eh		;5b38
	call L_4381		;5b3b
	di			;5b3e
	push hl			;5b3f
	ld hl,0f0f1h		;5b40
	ld a,001h		;5b43
	ld (06000h),a		;5b45
	ld (hl),a			;5b48
	inc a			;5b49
	ld (08000h),a		;5b4a
	inc hl			;5b4d
	ld (hl),a			;5b4e
	inc a			;5b4f
	ld (0a000h),a		;5b50
	inc hl			;5b53
	ld (hl),a			;5b54
	pop hl			;5b55
	ei			;5b56
	ret			;5b57
L_5B58:
	di			;5b58
	push hl			;5b59
	ld hl,0f0f1h		;5b5a
	ld a,007h		;5b5d
	ld (06000h),a		;5b5f
	ld (hl),a			;5b62
	inc a			;5b63
	ld (08000h),a		;5b64
	inc hl			;5b67
	ld (hl),a			;5b68
	inc a			;5b69
	ld (0a000h),a		;5b6a
	inc hl			;5b6d
	ld (hl),a			;5b6e
	pop hl			;5b6f
	ei			;5b70
	ld de,08b3ah		;5b71
	call L_4381		;5b74
	di			;5b77
	push hl			;5b78
	ld hl,0f0f1h		;5b79
	ld a,001h		;5b7c
	ld (06000h),a		;5b7e
	ld (hl),a			;5b81
	inc a			;5b82
	ld (08000h),a		;5b83
	inc hl			;5b86
	ld (hl),a			;5b87
	inc a			;5b88
	ld (0a000h),a		;5b89
	inc hl			;5b8c
	ld (hl),a			;5b8d
	pop hl			;5b8e
	ei			;5b8f
	ret			;5b90
L_5B91:
	call 09325h		;5b91
	di			;5b94
	push hl			;5b95
	ld hl,0f0f1h		;5b96
	ld a,004h		;5b99
	ld (06000h),a		;5b9b
	ld (hl),a			;5b9e
	inc a			;5b9f
	ld (08000h),a		;5ba0
	inc hl			;5ba3
	ld (hl),a			;5ba4
	inc a			;5ba5
	ld (0a000h),a		;5ba6
	inc hl			;5ba9
	ld (hl),a			;5baa
	pop hl			;5bab
	ei			;5bac
	ld de,0b423h		;5bad
	ld hl,02058h		;5bb0
	call L_5BF3		;5bb3
L_5BB6:
	di			;5bb6
	push hl			;5bb7
	ld hl,0f0f1h		;5bb8
	ld a,004h		;5bbb
	ld (06000h),a		;5bbd
	ld (hl),a			;5bc0
	inc a			;5bc1
	ld (08000h),a		;5bc2
	inc hl			;5bc5
	ld (hl),a			;5bc6
	inc a			;5bc7
	ld (0a000h),a		;5bc8
	inc hl			;5bcb
	ld (hl),a			;5bcc
	pop hl			;5bcd
	ei			;5bce
	ld de,0b597h		;5bcf
	jr L_5BF0		;5bd2
L_5BD4:
	di			;5bd4
	push hl			;5bd5
	ld hl,0f0f1h		;5bd6
	ld a,004h		;5bd9
	ld (06000h),a		;5bdb
	ld (hl),a			;5bde
	inc a			;5bdf
	ld (08000h),a		;5be0
	inc hl			;5be3
	ld (hl),a			;5be4
	inc a			;5be5
	ld (0a000h),a		;5be6
	inc hl			;5be9
	ld (hl),a			;5bea
	pop hl			;5beb
	ei			;5bec
	ld de,0b5a8h		;5bed
L_5BF0:
	ld hl,00058h		;5bf0
L_5BF3:
	call L_42A8		;5bf3
	di			;5bf6
	push hl			;5bf7
	ld hl,0f0f1h		;5bf8
	ld a,001h		;5bfb
	ld (06000h),a		;5bfd
	ld (hl),a			;5c00
	inc a			;5c01
	ld (08000h),a		;5c02
	inc hl			;5c05
	ld (hl),a			;5c06
	inc a			;5c07
	ld (0a000h),a		;5c08
	inc hl			;5c0b
	ld (hl),a			;5c0c
	pop hl			;5c0d
	ei			;5c0e
	ret			;5c0f
L_5C10:
	ld b,0e0h		;5c10
	call L_44B6		;5c12
	call L_4224		;5c15
	call L_5B91		;5c18
	call L_5BD4		;5c1b
	xor a			;5c1e
	ld (0e14eh),a		;5c1f
	ld (0e150h),a		;5c22
	di			;5c25
	push hl			;5c26
	ld hl,0f0f1h		;5c27
	ld a,007h		;5c2a
	ld (06000h),a		;5c2c
	ld (hl),a			;5c2f
	inc a			;5c30
	ld (08000h),a		;5c31
	inc hl			;5c34
	ld (hl),a			;5c35
	inc a			;5c36
	ld (0a000h),a		;5c37
	inc hl			;5c3a
	ld (hl),a			;5c3b
	pop hl			;5c3c
	ei			;5c3d
	ld de,09846h		;5c3e
	call L_4381		;5c41
	ld a,(0002bh)		;5c44
	and 00fh		;5c47
	jr z,L_5C51		;5c49
	ld de,0a463h		;5c4b
	call L_4381		;5c4e
L_5C51:
	di			;5c51
	push hl			;5c52
	ld hl,0f0f1h		;5c53
	ld a,001h		;5c56
	ld (06000h),a		;5c58
	ld (hl),a			;5c5b
	inc a			;5c5c
	ld (08000h),a		;5c5d
	inc hl			;5c60
	ld (hl),a			;5c61
	inc a			;5c62
	ld (0a000h),a		;5c63
	inc hl			;5c66
	ld (hl),a			;5c67
	pop hl			;5c68
	ei			;5c69
	ret			;5c6a
L_5C6B:
	di			;5c6b
	ld a,00ch		;5c6c
	ld (08000h),a		;5c6e
	ld (0f0f2h),a		;5c71
	ei			;5c74
	di			;5c75
	ld a,00dh		;5c76
	ld (0a000h),a		;5c78
	ld (0f0f3h),a		;5c7b
	ei			;5c7e
	ld de,0bab2h		;5c7f
	call L_4381		;5c82
	ld de,0ee80h		;5c85
	ld hl,0ba9eh		;5c88
	ld bc,00014h		;5c8b
	ldir		;5c8e
	call L_42FB		;5c90
	jr L_5C51		;5c93
L_5C95:
	call L_5C10		;5c95
	call L_5C6B		;5c98
	ld a,0a7h		;5c9b
	call L_4145		;5c9d
	ld hl,05000h		;5ca0
	ld (0e00ch),hl		;5ca3
	ld h,001h		;5ca6
	ld (0e00eh),hl		;5ca8
	ld a,017h		;5cab
	ld (0e155h),a		;5cad
	ld hl,048e0h		;5cb0
	ld (0ee9ch),hl		;5cb3
	ld h,058h		;5cb6
	ld (0eea0h),hl		;5cb8
	ld hl,00a2ch		;5cbb
	ld (0ee9eh),hl		;5cbe
	ld l,028h		;5cc1
	ld (0eea2h),hl		;5cc3
	ld hl,00607h		;5cc6
	ld (0e14ah),hl		;5cc9
	ld a,004h		;5ccc
	ld (0e14fh),a		;5cce
	ld a,020h		;5cd1
	ld (0e14ch),a		;5cd3
L_5CD6:
	call L_5DCF		;5cd6
	ld a,(0e00ch)		;5cd9
	dec a			;5cdc
	jp nz,L_5D50		;5cdd
	ld a,(0e00dh)		;5ce0
	dec a			;5ce3
	jr nz,L_5D03		;5ce4
	ld a,(0e003h)		;5ce6
	and 007h		;5ce9
	ret nz			;5ceb
	ld hl,03f73h		;5cec
	ld (0ee9ch),hl		;5cef
	call L_5E1E		;5cf2
	ld (0ee9eh),hl		;5cf5
	call L_5E2B		;5cf8
	ret nz			;5cfb
	ld a,008h		;5cfc
	ld (0e15ah),a		;5cfe
	jr L_5D46		;5d01
L_5D03:
	dec a			;5d03
	jr nz,L_5D0C		;5d04
	call L_5E35		;5d06
	ret nz			;5d09
	jr L_5D46		;5d0a
L_5D0C:
	dec a			;5d0c
	jr nz,L_5D27		;5d0d
	ld a,(0e003h)		;5d0f
	and 007h		;5d12
	ret nz			;5d14
	ld hl,03b73h		;5d15
	ld (0eea0h),hl		;5d18
	call L_5E1E		;5d1b
	ld (0eea2h),hl		;5d1e
	call L_5E2B		;5d21
	ret nz			;5d24
	jr L_5D46		;5d25
L_5D27:
	dec a			;5d27
	jr nz,L_5D39		;5d28
	ld a,0e0h		;5d2a
	ld (0eea0h),a		;5d2c
	ld hl,0e004h		;5d2f
	dec (hl)			;5d32
	ret nz			;5d33
	ld hl,0e00fh		;5d34
	dec (hl)			;5d37
	ret			;5d38
L_5D39:
	call L_5E35		;5d39
	ret nz			;5d3c
	xor a			;5d3d
	ld (0e14ah),a		;5d3e
	ld a,003h		;5d41
	ld (0e15ah),a		;5d43
L_5D46:
	ld a,020h		;5d46
	ld (0e14ch),a		;5d48
	ld hl,0e00dh		;5d4b
	inc (hl)			;5d4e
	ret			;5d4f
L_5D50:
	ld a,(0e00eh)		;5d50
	and a			;5d53
	jr nz,L_5D63		;5d54
	call L_5E35		;5d56
	ret nz			;5d59
	xor a			;5d5a
	ld (0ee9ch),a		;5d5b
	ld (0eea0h),a		;5d5e
	jr L_5DA5		;5d61
L_5D63:
	dec a			;5d63
	jr nz,L_5DAA		;5d64
	ld a,(0e003h)		;5d66
	and 001h		;5d69
	ret nz			;5d6b
	ld de,(0ee9ch)		;5d6c
	ld a,d			;5d70
	add a,005h		;5d71
	ld d,a			;5d73
	ld a,e			;5d74
	add a,002h		;5d75
	ld e,a			;5d77
	ld (0ee9ch),de		;5d78
	ld de,(0eea0h)		;5d7c
	ld a,d			;5d80
	add a,005h		;5d81
	ld d,a			;5d83
	ld a,e			;5d84
	add a,002h		;5d85
	ld e,a			;5d87
	ld (0eea0h),de		;5d88
	ld hl,0e155h		;5d8c
	dec (hl)			;5d8f
	ret nz			;5d90
	ld a,0e0h		;5d91
	ld hl,0ee9ch		;5d93
	ld (hl),a			;5d96
	inc l			;5d97
	inc l			;5d98
	inc l			;5d99
	inc l			;5d9a
	ld (hl),a			;5d9b
	xor a			;5d9c
	ld (0e155h),a		;5d9d
	ld a,020h		;5da0
	ld (0e14ch),a		;5da2
L_5DA5:
	ld hl,0e00eh		;5da5
	inc (hl)			;5da8
	ret			;5da9
L_5DAA:
	ld a,(0e003h)		;5daa
	and 007h		;5dad
	ret nz			;5daf
	ld a,(0e155h)		;5db0
	ld hl,05e3ch		;5db3
	call L_4055		;5db6
	ld e,(hl)			;5db9
	inc hl			;5dba
	ld d,(hl)			;5dbb
	call 07df7h		;5dbc
	ld hl,0e155h		;5dbf
	inc (hl)			;5dc2
	ld a,(hl)			;5dc3
	sub 00ah		;5dc4
	ret nz			;5dc6
	ld (0e00dh),a		;5dc7
	ld hl,0e00ch		;5dca
	inc (hl)			;5dcd
	ret			;5dce
L_5DCF:
	ld a,(0e003h)		;5dcf
	and 003h		;5dd2
	ret nz			;5dd4
	ld a,(0e14eh)		;5dd5
	and a			;5dd8
	jr nz,L_5E03		;5dd9
	ld a,r		;5ddb
	rrca			;5ddd
	rrca			;5dde
	rrca			;5ddf
	rrca			;5de0
	ld hl,0e003h		;5de1
	xor (hl)			;5de4
	and 003h		;5de5
	ld (0e14fh),a		;5de7
	ld hl,05e50h		;5dea
	add a,a			;5ded
	call L_4055		;5dee
	ld de,0e151h		;5df1
	ld bc,00004h		;5df4
	ldir		;5df7
	ld a,0ffh		;5df9
	ld (0e150h),a		;5dfb
	ld hl,0e14eh		;5dfe
	inc (hl)			;5e01
	ret			;5e02
L_5E03:
	ld hl,0e150h		;5e03
	inc (hl)			;5e06
	ld a,(hl)			;5e07
	cp 003h		;5e08
	jr z,L_5E19		;5e0a
	ld hl,(0e151h)		;5e0c
	call L_4056		;5e0f
	ld a,(hl)			;5e12
	ld hl,(0e153h)		;5e13
	jp 0004dh		;5e16   ; BIOS WRTVRM - Writes data in VRAM
L_5E19:
	xor a			;5e19
	ld (0e14eh),a		;5e1a
	ret			;5e1d
L_5E1E:
	ld a,(0e14ah)		;5e1e
	ld hl,05e66h		;5e21
	call L_4056		;5e24
	ld l,(hl)			;5e27
	ld h,007h		;5e28
	ret			;5e2a
L_5E2B:
	ld hl,0e14ah		;5e2b
	inc (hl)			;5e2e
	ld a,(hl)			;5e2f
	ld hl,0e15ah		;5e30
	cp (hl)			;5e33
	ret			;5e34
L_5E35:
	ld hl,0e14ch		;5e35
	dec (hl)			;5e38
	ret			;5e39

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5e3a..0x5e6e  (52 bytes)
DATA_5E3A:
	defb 004h,00bh,0b7h,0b3h,0c1h,0b3h,0cbh,0b3h,0d6h,0b3h,0eah,0b3h,0d6h,0b3h,0cbh,0b3h	; 5e3a  ................
	defb 0c1h,0b3h,0b7h,0b3h,0feh,0b3h,060h,05eh,0a3h,038h,063h,05eh,047h,038h,060h,05eh	; 5e4a  ......`^.8c^G8`^
	defb 03ah,038h,063h,05eh,033h,038h,09eh,09fh,051h,0a1h,050h,0a0h,010h,014h,018h,01ch	; 5e5a  :8c^38..Q.P.....
	defb 020h,024h,020h,01ch	; 5e6a

; ======================================================================
; CODIGO 0x5e6e..0x5f35  (199 bytes)
; ======================================================================


L_5E6E:
	ld a,001h		;5e6e
	ld (0e096h),a		;5e70
	ld a,(0e003h)		;5e73
	and 01fh		;5e76
	ret nz			;5e78
	ld a,(0e13dh)		;5e79
	ld b,a			;5e7c
	djnz L_5EC4		;5e7d
L_5E7F:
	ld bc,00300h		;5e7f
	ld hl,0eba0h		;5e82
	ld de,0eb80h		;5e85
	ldir		;5e88
	ld hl,0bcf8h		;5e8a
	call 07e2dh		;5e8d
	ld hl,0e13eh		;5e90
	dec (hl)			;5e93
	ret nz			;5e94
	ld hl,0e140h		;5e95
	dec (hl)			;5e98
	jp z,L_5F2F		;5e99
	ld a,(hl)			;5e9c
	dec a			;5e9d
	ld hl,(0e147h)		;5e9e
	call L_4055		;5ea1
	ld e,(hl)			;5ea4
	inc hl			;5ea5
	ld d,(hl)			;5ea6
	di			;5ea7
	ld a,00ah		;5ea8
	ld (08000h),a		;5eaa
	ld (0f0f2h),a		;5ead
	ei			;5eb0
	di			;5eb1
	ld a,00bh		;5eb2
	ld (0a000h),a		;5eb4
	ld (0f0f3h),a		;5eb7
	ei			;5eba
	ld a,(de)			;5ebb
	ld (0e13eh),a		;5ebc
	inc de			;5ebf
	ex de,hl			;5ec0
	jp 07e2dh		;5ec1
L_5EC4:
	djnz L_5EDD		;5ec4
	ld hl,0e13fh		;5ec6
	dec (hl)			;5ec9
	ret nz			;5eca
	ld a,018h		;5ecb
	ld (0e140h),a		;5ecd
	ld a,001h		;5ed0
	ld (0e13eh),a		;5ed2
	ld hl,(0e149h)		;5ed5
	ld (0e147h),hl		;5ed8
	jr L_5F2F		;5edb
L_5EDD:
	djnz L_5EE1		;5edd
	jr L_5E7F		;5edf
L_5EE1:
	djnz L_5F01		;5ee1
	ld a,(0e012h)		;5ee3
	and a			;5ee6
	ret nz			;5ee7
	xor a			;5ee8
	ld (0e096h),a		;5ee9
L_5EEC:
	di			;5eec
	ld a,002h		;5eed
	ld (08000h),a		;5eef
	ld (0f0f2h),a		;5ef2
	ei			;5ef5
	di			;5ef6
	ld a,003h		;5ef7
	ld (0a000h),a		;5ef9
	ld (0f0f3h),a		;5efc
	ei			;5eff
	ret			;5f00
L_5F01:
	ld a,006h		;5f01
	ld (0e140h),a		;5f03
	ld a,004h		;5f06
	ld (0e13fh),a		;5f08
	ld a,004h		;5f0b
	ld (0e13eh),a		;5f0d
	ld hl,0bcf8h		;5f10
	call 07e2dh		;5f13
	call L_5B91		;5f16
	ld a,(0e0b9h)		;5f19
	ld hl,05f35h		;5f1c
	ld de,05f63h		;5f1f
	and a			;5f22
	jr z,L_5F28		;5f23
	ld de,05f6dh		;5f25
L_5F28:
	ld (0e147h),de		;5f28
	ld (0e149h),hl		;5f2c
L_5F2F:
	ld hl,0e13dh		;5f2f
	inc (hl)			;5f32
	jr L_5EEC		;5f33

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5f35..0x5f77  (66 bytes)
DATA_5F35:
	defb 0e0h,0bch,0d2h,0bch,0b8h,0bch,09dh,0bch,091h,0bch,01ah,0bch,082h,0bch,072h,0bch	; 5f35  ..............r.
	defb 065h,0bch,051h,0bch,042h,0bch,033h,0bch,028h,0bch,01ah,0bch,003h,0bch,0f5h,0bbh	; 5f45  e.Q.B.3.(.......
	defb 0e2h,0bbh,0d7h,0bbh,0cbh,0bbh,0b6h,0bbh,0aah,0bbh,094h,0bbh,086h,0bbh,027h,0bbh	; 5f55  ..............'.
	defb 007h,0bbh,0e9h,0bah,0cfh,0bah,0c0h,0bah,082h,0bbh,06ch,0bbh,053h,0bbh,03ch,0bbh	; 5f65  ..........l.S.<.
	defb 0c0h,0bah	; 5f75

; ======================================================================
; CODIGO 0x5f77..0x5f99  (34 bytes)
; ======================================================================


L_5F77:
	ld de,05f99h		;5f77
	ld a,(0e4c0h)		;5f7a
	and a			;5f7d
	jr z,L_5F96		;5f7e
	ld de,05fa0h		;5f80
	cp 004h		;5f83
	jr nc,L_5F8A		;5f85
	xor a			;5f87
	jr L_5F93		;5f88
L_5F8A:
	sub 004h		;5f8a
	ld hl,05fd8h		;5f8c
	call L_4056		;5f8f
	ld a,(hl)			;5f92
L_5F93:
	call L_405B		;5f93
L_5F96:
	jp L_42BC		;5f96

; ----------------------------------------------------------------------
; DATOS sin identificar  0x5f99..0x6000  (103 bytes)
DATA_5F99:
	defb 01ah,038h,000h,000h,000h,000h,0ffh,01ah,038h,03fh,03fh,03fh,00eh,0ffh,01ah,038h	; 5f99  .8......8???...8
	defb 03fh,03fh,03fh,00dh,0ffh,01ah,038h,03fh,03fh,03fh,000h,0ffh,01ah,038h,03fh,03fh	; 5fa9  ???...8???...8??
	defb 03eh,000h,0ffh,01ah,038h,03fh,03fh,000h,000h,0ffh,01ah,038h,03fh,03eh,000h,000h	; 5fb9  >...8??....8?>..
	defb 0ffh,01ah,038h,03fh,000h,000h,000h,0ffh,01ah,038h,03eh,000h,000h,000h,0ffh,000h	; 5fc9  ..8?.....8>.....
	defb 007h,00eh,015h,015h,01ch,01ch,01ch,023h,023h,023h,023h,02ah,02ah,02ah,02ah,02ah	; 5fd9  .......####*****
	defb 031h,031h,031h,031h,031h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5fe9  11111...........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5ff9
