; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x62ec  (748 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL DECORADO MANDA. Una escalera de `dec a` con los diez decorados: cada uno tiene su rutina de montaje y el 9 comparte la del 6. Esta es la puerta por la que el juego entra a armar la pantalla, y de aqui salen los cambios de banco que llevan a los decorados de los bancos 12 y 13.
; ----------------------------------------------------------------------
monta_el_decorado:
	ld a,(0e0a1h)		;6000   ; que decorado toca
	and a			;6003
	jr z,L_602A		;6004   ; el 0
	dec a			;6006
	jr z,L_605C		;6007   ; el 1
	dec a			;6009
	jp z,L_608B		;600a   ; el 2
	dec a			;600d
	jp z,L_60BD		;600e   ; el 3
	dec a			;6011
	jp z,L_60EC		;6012   ; el 4
	dec a			;6015
	jp z,L_611E		;6016   ; el 5
	dec a			;6019
	jp z,L_614D		;601a   ; el 6
	dec a			;601d
	jp z,L_617C		;601e   ; el 7
	dec a			;6021
	jp z,L_61AB		;6022   ; el 8
	dec a			;6025
	jp z,L_614D		;6026   ; y el 9, que comparte rutina con el 6
	ret			;6029   ; y de un decadecimo no hay nada
L_602A:
	di			;602a   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;602b
	ld (08000h),a		;602d   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6030   ; y en su copia de RAM
	ei			;6033   ; el mapa ya esta entero
	di			;6034   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6035
	ld (0a000h),a		;6037   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;603a   ; y en su copia de RAM
	ei			;603d   ; el mapa ya esta entero
	ld hl,08014h		;603e
	call 0418ch		;6041   ; banco 0: descomprime
	call L_61DD		;6044
	di			;6047   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6048
	ld (08000h),a		;604a   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;604d   ; y en su copia de RAM
	ei			;6050   ; el mapa ya esta entero
	di			;6051   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6052
	ld (0a000h),a		;6054   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6057   ; y en su copia de RAM
	ei			;605a   ; el mapa ya esta entero
	ret			;605b
L_605C:
	di			;605c   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;605d
	ld (08000h),a		;605f   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6062   ; y en su copia de RAM
	ei			;6065   ; el mapa ya esta entero
	di			;6066   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6067
	ld (0a000h),a		;6069   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;606c   ; y en su copia de RAM
	ei			;606f   ; el mapa ya esta entero
	ld hl,081ech		;6070
	call 0418ch		;6073   ; banco 0: descomprime
	di			;6076   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6077
	ld (08000h),a		;6079   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;607c   ; y en su copia de RAM
	ei			;607f   ; el mapa ya esta entero
	di			;6080   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6081
	ld (0a000h),a		;6083   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6086   ; y en su copia de RAM
	ei			;6089   ; el mapa ya esta entero
	ret			;608a
L_608B:
	di			;608b   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;608c
	ld (08000h),a		;608e   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6091   ; y en su copia de RAM
	ei			;6094   ; el mapa ya esta entero
	di			;6095   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6096
	ld (0a000h),a		;6098   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;609b   ; y en su copia de RAM
	ei			;609e   ; el mapa ya esta entero
	ld hl,08725h		;609f
	call 0418ch		;60a2   ; banco 0: descomprime
	call L_61DD		;60a5
	di			;60a8   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;60a9
	ld (08000h),a		;60ab   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;60ae   ; y en su copia de RAM
	ei			;60b1   ; el mapa ya esta entero
	di			;60b2   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;60b3
	ld (0a000h),a		;60b5   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;60b8   ; y en su copia de RAM
	ei			;60bb   ; el mapa ya esta entero
	ret			;60bc
L_60BD:
	di			;60bd   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;60be
	ld (08000h),a		;60c0   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;60c3   ; y en su copia de RAM
	ei			;60c6   ; el mapa ya esta entero
	di			;60c7   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;60c8
	ld (0a000h),a		;60ca   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;60cd   ; y en su copia de RAM
	ei			;60d0   ; el mapa ya esta entero
	ld hl,089b0h		;60d1
	call 0418ch		;60d4   ; banco 0: descomprime
	di			;60d7   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;60d8
	ld (08000h),a		;60da   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;60dd   ; y en su copia de RAM
	ei			;60e0   ; el mapa ya esta entero
	di			;60e1   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;60e2
	ld (0a000h),a		;60e4   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;60e7   ; y en su copia de RAM
	ei			;60ea   ; el mapa ya esta entero
	ret			;60eb
L_60EC:
	di			;60ec   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;60ed
	ld (08000h),a		;60ef   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;60f2   ; y en su copia de RAM
	ei			;60f5   ; el mapa ya esta entero
	di			;60f6   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;60f7
	ld (0a000h),a		;60f9   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;60fc   ; y en su copia de RAM
	ei			;60ff   ; el mapa ya esta entero
	ld hl,08ee9h		;6100
	call 0418ch		;6103   ; banco 0: descomprime
	call L_61DD		;6106
	di			;6109   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;610a
	ld (08000h),a		;610c   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;610f   ; y en su copia de RAM
	ei			;6112   ; el mapa ya esta entero
	di			;6113   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6114
	ld (0a000h),a		;6116   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6119   ; y en su copia de RAM
	ei			;611c   ; el mapa ya esta entero
	ret			;611d
L_611E:
	di			;611e   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;611f
	ld (08000h),a		;6121   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6124   ; y en su copia de RAM
	ei			;6127   ; el mapa ya esta entero
	di			;6128   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6129
	ld (0a000h),a		;612b   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;612e   ; y en su copia de RAM
	ei			;6131   ; el mapa ya esta entero
	ld hl,090efh		;6132
	call 0418ch		;6135   ; banco 0: descomprime
	di			;6138   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6139
	ld (08000h),a		;613b   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;613e   ; y en su copia de RAM
	ei			;6141   ; el mapa ya esta entero
	di			;6142   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6143
	ld (0a000h),a		;6145   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6148   ; y en su copia de RAM
	ei			;614b   ; el mapa ya esta entero
	ret			;614c
L_614D:
	di			;614d   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;614e
	ld (08000h),a		;6150   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6153   ; y en su copia de RAM
	ei			;6156   ; el mapa ya esta entero
	di			;6157   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6158
	ld (0a000h),a		;615a   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;615d   ; y en su copia de RAM
	ei			;6160   ; el mapa ya esta entero
	ld hl,09735h		;6161
	call 0418ch		;6164   ; banco 0: descomprime
	di			;6167   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6168
	ld (08000h),a		;616a   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;616d   ; y en su copia de RAM
	ei			;6170   ; el mapa ya esta entero
	di			;6171   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6172
	ld (0a000h),a		;6174   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6177   ; y en su copia de RAM
	ei			;617a   ; el mapa ya esta entero
	ret			;617b
L_617C:
	di			;617c   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;617d
	ld (08000h),a		;617f   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6182   ; y en su copia de RAM
	ei			;6185   ; el mapa ya esta entero
	di			;6186   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6187
	ld (0a000h),a		;6189   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;618c   ; y en su copia de RAM
	ei			;618f   ; el mapa ya esta entero
	ld hl,09d72h		;6190
	call 0418ch		;6193   ; banco 0: descomprime
	di			;6196   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6197
	ld (08000h),a		;6199   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;619c   ; y en su copia de RAM
	ei			;619f   ; el mapa ya esta entero
	di			;61a0   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;61a1
	ld (0a000h),a		;61a3   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;61a6   ; y en su copia de RAM
	ei			;61a9   ; el mapa ya esta entero
	ret			;61aa
L_61AB:
	di			;61ab   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;61ac
	ld (08000h),a		;61ae   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;61b1   ; y en su copia de RAM
	ei			;61b4   ; el mapa ya esta entero
	di			;61b5   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;61b6
	ld (0a000h),a		;61b8   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;61bb   ; y en su copia de RAM
	ei			;61be   ; el mapa ya esta entero
	ld hl,0a314h		;61bf
	call 0418ch		;61c2   ; banco 0: descomprime
	call L_7E47		;61c5
	di			;61c8   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;61c9
	ld (08000h),a		;61cb   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;61ce   ; y en su copia de RAM
	ei			;61d1   ; el mapa ya esta entero
	di			;61d2   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;61d3
	ld (0a000h),a		;61d5   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;61d8   ; y en su copia de RAM
	ei			;61db   ; el mapa ya esta entero
	ret			;61dc
L_61DD:
	ld a,(0e0a1h)		;61dd   ; el DECORADO, de 0 a 9
	add a,a			;61e0
	ld hl,0ac16h		;61e1
	call 04056h		;61e4   ; banco 0: a_mas_hl
	ld a,(hl)			;61e7
	inc hl			;61e8
	ld h,(hl)			;61e9
	ld l,a			;61ea
	ld de,0e510h		;61eb
	ld bc,00020h		;61ee
	ldir		;61f1
L_61F3:
	ld hl,0e510h		;61f3
	ld de,0eca0h		;61f6
	ld bc,00020h		;61f9
	ldir		;61fc
	ret			;61fe
L_61FF:
	di			;61ff   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;6200
	ld (08000h),a		;6202   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6205   ; y en su copia de RAM
	ei			;6208   ; el mapa ya esta entero
	di			;6209   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;620a
	ld (0a000h),a		;620c   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;620f   ; y en su copia de RAM
	ei			;6212   ; el mapa ya esta entero
	call L_64E7		;6213
	add hl,hl			;6216
	ld de,0acbah		;6217
	add hl,de			;621a
	ld e,(hl)			;621b
	inc hl			;621c
	ld a,(hl)			;621d
	and 00fh		;621e
	ld d,a			;6220
	ld (0e08bh),de		;6221   ; el TIEMPO que queda
	ld a,(hl)			;6225
	and 0f0h		;6226
	rra			;6228
	rra			;6229
	rra			;622a
	rra			;622b
	ld (0e0a1h),a		;622c   ; el DECORADO. Aqui solo salen del 0 al 7: los decorados 8 y 9 no los usa ninguna de las veinticuatro fases, los ponen a mano p03:B602 y p03:B932 para dos escenas de por medio
	inc hl			;622f
	ld e,(hl)			;6230
	inc hl			;6231
	ld d,(hl)			;6232
	ld (0e08dh),de		;6233   ; lo que queda de fase
	di			;6237   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6238
	ld (08000h),a		;623a   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;623d   ; y en su copia de RAM
	ei			;6240   ; el mapa ya esta entero
	di			;6241   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6242
	ld (0a000h),a		;6244   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6247   ; y en su copia de RAM
	ei			;624a   ; el mapa ya esta entero
	ret			;624b
L_624C:
	di			;624c   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;624d
	ld (08000h),a		;624f   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6252   ; y en su copia de RAM
	ei			;6255   ; el mapa ya esta entero
	di			;6256   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6257
	ld (0a000h),a		;6259   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;625c   ; y en su copia de RAM
	ei			;625f   ; el mapa ya esta entero
	xor a			;6260
	ld (0e201h),a		;6261
	ld (0e202h),a		;6264
	ld a,(0e093h)		;6267   ; el valor 1-2-3 de la fase
	cp 003h		;626a
	jr nz,L_6277		;626c
	ld a,(0e0a5h)		;626e   ; por que vuelta de la fase va
	cp 002h		;6271
	ld a,009h		;6273
	jr nc,L_627A		;6275
L_6277:
	ld a,(0e0a1h)		;6277   ; el DECORADO, de 0 a 9
L_627A:
	ld hl,0ad1ah		;627a
	ld b,a			;627d
	add a,a			;627e
	add a,b			;627f
	call 04056h		;6280   ; banco 0: a_mas_hl
	ld e,(hl)			;6283
	inc hl			;6284
	ld d,(hl)			;6285
	ld (0e204h),de		;6286   ; la Y en la pantalla de lo que se maneja
	inc hl			;628a
	ld a,(hl)			;628b
	ld (0e203h),a		;628c   ; el ESTADO de lo que se maneja
	di			;628f   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6290
	ld (08000h),a		;6292   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6295   ; y en su copia de RAM
	ei			;6298   ; el mapa ya esta entero
	di			;6299   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;629a
	ld (0a000h),a		;629c   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;629f   ; y en su copia de RAM
	ei			;62a2   ; el mapa ya esta entero
	ret			;62a3
L_62A4:
	ld a,017h		;62a4
	ld (0e4c0h),a		;62a6   ; el nivel de la barra de nueve
	ld (0e4c1h),a		;62a9
	ret			;62ac
L_62AD:
	ld a,008h		;62ad
	ld (0e401h),a		;62af
	ld a,006h		;62b2
	ld (0e400h),a		;62b4
	ret			;62b7
L_62B8:
	ld a,008h		;62b8
	jr los_cuatro_contadores_de_partida		;62ba
L_62BC:
	ld a,020h		;62bc
los_cuatro_contadores_de_partida:
	ld (0e401h),a		;62be   ; el primero, el que venga
	ld a,006h		;62c1   ; el segundo, a 6
	ld (0e400h),a		;62c3
	xor a			;62c6   ; y el tercero, a cero
	ld (0e404h),a		;62c7
	ret			;62ca
los_cuatro_pasos_de_color_de_partida:
	ld a,008h		;62cb   ; la primera tabla empieza en el 8...
	ld (0e409h),a		;62cd
	ld a,004h		;62d0   ; ...la segunda en el 4...
	ld (0e408h),a		;62d2
	ld a,002h		;62d5   ; ...la tercera en el 2...
	ld (0e407h),a		;62d7
	ld a,006h		;62da   ; ...y la cuarta en el 6
	ld (0e406h),a		;62dc
	ret			;62df
L_62E0:
	ld hl,062ech		;62e0
	ld de,0e40ah		;62e3
	ld bc,00003h		;62e6
	ldir		;62e9
	ret			;62eb

; ----------------------------------------------------------------------
; DATOS tres_bytes_a_E40A: tres bytes que p01:62E0 copia con ldir a 0xE40A
;   0x62ec..0x62ef  (3 bytes)
DATA_tres_bytes_a_E40A:
	defb 004h,00ch,008h	; 62ec

; ======================================================================
; CODIGO 0x62ef..0x64c6  (471 bytes)
; ======================================================================


L_62EF:
	di			;62ef   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;62f0
	ld (08000h),a		;62f2   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;62f5   ; y en su copia de RAM
	ei			;62f8   ; el mapa ya esta entero
	di			;62f9   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;62fa
	ld (0a000h),a		;62fc   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;62ff   ; y en su copia de RAM
	ei			;6302   ; el mapa ya esta entero
	ld hl,0ad38h		;6303
	ld de,0e570h		;6306
	ld bc,00030h		;6309
	ldir		;630c
	di			;630e   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;630f
	ld (08000h),a		;6311   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6314   ; y en su copia de RAM
	ei			;6317   ; el mapa ya esta entero
	di			;6318   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6319
	ld (0a000h),a		;631b   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;631e   ; y en su copia de RAM
	ei			;6321   ; el mapa ya esta entero
	ret			;6322
L_6323:
	di			;6323   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;6324
	ld (08000h),a		;6326   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6329   ; y en su copia de RAM
	ei			;632c   ; el mapa ya esta entero
	di			;632d   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;632e
	ld (0a000h),a		;6330   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;6333   ; y en su copia de RAM
	ei			;6336   ; el mapa ya esta entero
	ld hl,0ad68h		;6337
	ld de,0ee80h		;633a
	ld bc,00080h		;633d
	ldir		;6340
	ld a,(0e0a1h)		;6342   ; el DECORADO, de 0 a 9
	cp 002h		;6345
	jr z,L_6353		;6347
	cp 003h		;6349
	jr z,L_6353		;634b
	cp 006h		;634d
	jr z,L_6353		;634f
	jr L_635B		;6351
L_6353:
	ld a,006h		;6353
	ld (0eecbh),a		;6355
	ld (0eecfh),a		;6358
L_635B:
	di			;635b   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;635c
	ld (08000h),a		;635e   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6361   ; y en su copia de RAM
	ei			;6364   ; el mapa ya esta entero
	di			;6365   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6366
	ld (0a000h),a		;6368   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;636b   ; y en su copia de RAM
	ei			;636e   ; el mapa ya esta entero
	ret			;636f
L_6370:
	di			;6370   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;6371
	ld (08000h),a		;6373   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6376   ; y en su copia de RAM
	ei			;6379   ; el mapa ya esta entero
	di			;637a   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;637b
	ld (0a000h),a		;637d   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;6380   ; y en su copia de RAM
	ei			;6383   ; el mapa ya esta entero
	call L_64E7		;6384
	ld de,0b046h		;6387
	add hl,de			;638a
	ld e,(hl)			;638b
	inc hl			;638c
	ld d,(hl)			;638d
	ex de,hl			;638e
	ld a,(0e0b6h)		;638f
	add a,a			;6392
	call 04055h		;6393   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;6396
	inc hl			;6397
	ld d,(hl)			;6398
	ld (0e0afh),de		;6399
	inc hl			;639d
	ld a,(hl)			;639e
	ld (0e0b1h),a		;639f
	inc hl			;63a2
	ld a,(hl)			;63a3
	ld (0e0b2h),a		;63a4
	di			;63a7   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;63a8
	ld (08000h),a		;63aa   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;63ad   ; y en su copia de RAM
	ei			;63b0   ; el mapa ya esta entero
	di			;63b1   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;63b2
	ld (0a000h),a		;63b4   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;63b7   ; y en su copia de RAM
	ei			;63ba   ; el mapa ya esta entero
	ret			;63bb
L_63BC:
	di			;63bc   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;63bd
	ld (08000h),a		;63bf   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;63c2   ; y en su copia de RAM
	ei			;63c5   ; el mapa ya esta entero
	di			;63c6   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;63c7
	ld (0a000h),a		;63c9   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;63cc   ; y en su copia de RAM
	ei			;63cf   ; el mapa ya esta entero
	call L_64E7		;63d0
	ld de,0b192h		;63d3
	add hl,de			;63d6
	ld e,(hl)			;63d7
	inc hl			;63d8
	ld d,(hl)			;63d9
	ex de,hl			;63da
	ld a,(0e0d4h)		;63db
	call 04055h		;63de   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;63e1
	inc hl			;63e2
	ld d,(hl)			;63e3
	ld (0e0d5h),de		;63e4
	di			;63e8   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;63e9
	ld (08000h),a		;63eb   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;63ee   ; y en su copia de RAM
	ei			;63f1   ; el mapa ya esta entero
	di			;63f2   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;63f3
	ld (0a000h),a		;63f5   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;63f8   ; y en su copia de RAM
	ei			;63fb   ; el mapa ya esta entero
	ret			;63fc
L_63FD:
	di			;63fd   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;63fe
	ld (08000h),a		;6400   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6403   ; y en su copia de RAM
	ei			;6406   ; el mapa ya esta entero
	di			;6407   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6408
	ld (0a000h),a		;640a   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;640d   ; y en su copia de RAM
	ei			;6410   ; el mapa ya esta entero
	call L_64E7		;6411
	ld de,0b28ch		;6414
	add hl,hl			;6417
	add hl,de			;6418
	ld e,(hl)			;6419
	inc hl			;641a
	ld d,(hl)			;641b
	ld (0e0abh),de		;641c
	inc hl			;6420
	ld a,(hl)			;6421
	ld (0e0adh),a		;6422
	inc hl			;6425
	ld a,(hl)			;6426
	ld (0e0aeh),a		;6427
	di			;642a   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;642b
	ld (08000h),a		;642d   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6430   ; y en su copia de RAM
	ei			;6433   ; el mapa ya esta entero
	di			;6434   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6435
	ld (0a000h),a		;6437   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;643a   ; y en su copia de RAM
	ei			;643d   ; el mapa ya esta entero
	ret			;643e
L_643F:
	di			;643f   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;6440
	ld (08000h),a		;6442   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6445   ; y en su copia de RAM
	ei			;6448   ; el mapa ya esta entero
	di			;6449   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;644a
	ld (0a000h),a		;644c   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;644f   ; y en su copia de RAM
	ei			;6452   ; el mapa ya esta entero
	call L_64E7		;6453
	ld de,0ac8ah		;6456
	add hl,de			;6459
	ld e,(hl)			;645a
	inc hl			;645b
	ld d,(hl)			;645c
	ld (0e301h),de		;645d   ; la distancia a la que toca el objeto siguiente
	di			;6461   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6462
	ld (08000h),a		;6464   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6467   ; y en su copia de RAM
	ei			;646a   ; el mapa ya esta entero
	di			;646b   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;646c
	ld (0a000h),a		;646e   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6471   ; y en su copia de RAM
	ei			;6474   ; el mapa ya esta entero
	ret			;6475
escoge_el_registro_de_once:
	and a			;6476   ; el 0...
	ld hl,064c6h		;6477
	jr z,lee_el_registro_de_once		;647a
	dec a			;647c   ; ...el 1...
	ld hl,064d1h		;647d
	jr z,lee_el_registro_de_once		;6480
	ld hl,064dch		;6482   ; ...o los demas
lee_el_registro_de_once:
	ld e,(hl)			;6485   ; la primera palabra
	inc hl			;6486
	ld d,(hl)			;6487
	ld (0e08dh),de		;6488   ; lo que queda de fase
	inc hl			;648c
	ld a,(hl)			;648d
	ld (0e0b6h),a		;648e
	inc hl			;6491
	ld a,(hl)			;6492
	ld (0e0a9h),a		;6493
	xor a			;6496
	ld (0e0a6h),a		;6497   ; el arrastre de lado que se lleva solo
	inc hl			;649a
	ld e,(hl)			;649b
	inc hl			;649c
	ld d,(hl)			;649d
	ld (0e0a7h),de		;649e
	inc hl			;64a2
	ld a,(hl)			;64a3
	ld (0e404h),a		;64a4
	inc hl			;64a7
	ld e,(hl)			;64a8
	inc hl			;64a9
	ld d,(hl)			;64aa
	ld (0e301h),de		;64ab   ; la distancia a la que toca el objeto siguiente
	inc hl			;64af
	ld a,(hl)			;64b0
	ld (0e300h),a		;64b1   ; por que pareja del guion de la fase va
	inc hl			;64b4
	ld a,(hl)			;64b5
	ld (0e0d4h),a		;64b6
	xor a			;64b9
	ld (0e0b3h),a		;64ba
	call el_guion_del_terreno		;64bd
	call L_6370		;64c0
	jp L_63FD		;64c3

; ----------------------------------------------------------------------
; DATOS tres_registros_de_11: tres registros de 11 bytes: p01:6477 escoge
;   0x64C6, 0x64D1 o 0x64DC segun A (0, 1 u otro) y p01:6485 empieza por
;   llevar la primera palabra a 0xE08D, lo que queda de fase
;   0x64c6..0x64e7  (33 bytes)
DATA_tres_registros_de_11:
	defb 015h,005h,001h,004h,080h,003h,003h,080h,004h,011h,002h	; 64c6  ...........
	defb 090h,004h,001h,008h,094h,003h,006h,050h,004h,01ch,003h	; 64d1  .......P...
	defb 055h,007h,001h,006h,004h,004h,006h,050h,007h,02ah,003h	; 64dc  U......P.*.

; ======================================================================
; CODIGO 0x64e7..0x6cc0  (2009 bytes)
; ======================================================================


L_64E7:
	ld a,(0e092h)		;64e7   ; la FASE, de 1 a 24
	dec a			;64ea
	ld l,a			;64eb
	ld h,000h		;64ec
	add hl,hl			;64ee
	ret			;64ef

; ----------------------------------------------------------------------
; CADA CUANTO SE ANDA. Aqui esta el paso del juego: 0xE4C1 baja un cuadro cada vez y, cuando llega a cero, se recarga con (0xE4C0) y SE CAE dentro de la rutina de abajo, la que descuenta lo que queda de fase. O sea que el terreno avanza un paso cada (0xE4C0) cuadros, que es el mismo numero que pinta la barra de nueve. En los estados 3, 4, 8 y 10 no se anda.
; ----------------------------------------------------------------------
cada_cuanto_se_anda:
	ld a,(0e203h)		;64f0   ; el ESTADO de lo que se maneja
	cp 003h		;64f3   ; en el 3...
	ret z			;64f5
	cp 004h		;64f6   ; ...en el 4...
	ret z			;64f8
	cp 008h		;64f9   ; ...en el 8...
	ret z			;64fb
	cp 00ah		;64fc   ; ...y en el 10 no se anda
	ret z			;64fe
	ld hl,0e4c0h		;64ff   ; el nivel de la barra, que es el periodo
	ld c,(hl)			;6502   ; guardado
	inc hl			;6503
	dec (hl)			;6504   ; un cuadro menos
	ret nz			;6505   ; y hasta cero, nada
	ld (hl),c			;6506   ; recargado, y se cae en la rutina de abajo

; ----------------------------------------------------------------------
; LO QUE QUEDA DE FASE, CUADRO A CUADRO. Descuenta uno EN BCD de los dos bytes de 0xE08D, y cuando el byte bajo llega a cero pide el trozo siguiente del terreno. De ahi salen las dos cuentas atras que llevan la fase: a 0x50 de la meta empieza el final, y de 0x30 para abajo van cayendo los pasos uno a uno. Ojo: esto NO es el tiempo, que corre aparte en 0xE08B y no mira lo que se ande.
; ----------------------------------------------------------------------
lo_que_queda_de_fase:
	ld hl,0e08dh		;6507   ; lo que queda
	ld a,(hl)			;650a
	sub 001h		;650b   ; uno menos, EN BCD
	daa			;650d
	ld (hl),a			;650e
	ld e,a			;650f
	inc l			;6510   ; y el byte alto, con su acarreo
	ld a,(hl)			;6511
	sbc a,000h		;6512
	daa			;6514
	ld (hl),a			;6515
	ld d,a			;6516
	ld a,e			;6517
	and a			;6518   ; ¿el byte bajo ha llegado a cero?
	push de			;6519
	call z,el_guion_del_terreno		;651a   ; entonces toca trozo nuevo de terreno
	call L_6B92		;651d
	pop de			;6520
	ld hl,0e401h		;6521   ; y un paso menos de 0xE401
	dec (hl)			;6524
	ld a,(0e0a2h)		;6525   ; fuera del modo de jugar, por otro lado
	and a			;6528
	jp nz,L_66C6		;6529
	ld hl,00050h		;652c   ; ¿quedan 0x50 justos?
	rst 20h			;652f
	jp z,a_0x50_de_la_meta		;6530   ; pues ahi empieza el final
	jp nc,cuenta_atras_del_final		;6533   ; y por debajo de 0x50, la cuenta atras
sigue_la_fase:
	call 092ech		;6536   ; banco 2: lo de cada cuadro
anima_el_fondo:
	di			;6539   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;653a
	ld (08000h),a		;653c   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;653f   ; y en su copia de RAM
	ei			;6542   ; el mapa ya esta entero
	di			;6543   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6544
	ld (0a000h),a		;6546   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;6549   ; y en su copia de RAM
	ei			;654c   ; el mapa ya esta entero
	ld hl,0e4c2h		;654d   ; el paso de la animacion
	inc (hl)			;6550
	ld a,(hl)			;6551
	and 003h		;6552   ; de cuatro en cuatro, en circulo
	ld c,a			;6554
	ld a,(0e0a1h)		;6555   ; y el decorado
	ld b,a			;6558
	push bc			;6559
	ld hl,08000h		;655a   ; la tabla de dos niveles de 0x8000
	call 04055h		;655d   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;6560
	inc hl			;6561
	ld d,(hl)			;6562
	ex de,hl			;6563
	ld a,c			;6564   ; el paso de dentro
	call 04055h		;6565   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;6568
	inc hl			;6569
	ld d,(hl)			;656a
	ex de,hl			;656b
	call 041bfh		;656c   ; banco 0: y a soltar sus bloques
	pop bc			;656f
	ld a,(0e0a6h)		;6570   ; ¿hay arrastre?
	and a			;6573
	jr z,L_6592		;6574
	ld hl,0a613h		;6576   ; con el 1, la tabla de 0xA613...
	dec a			;6579
	jr z,L_657F		;657a
	ld hl,0a627h		;657c   ; ...y con los demas, la de 0xA627
L_657F:
	ld a,b			;657f
	call 04055h		;6580   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;6583
	inc hl			;6584
	ld d,(hl)			;6585
	ex de,hl			;6586
	ld a,c			;6587
	call 04055h		;6588   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;658b
	inc hl			;658c
	ld d,(hl)			;658d
	ex de,hl			;658e
	call 041bfh		;658f   ; banco 0: y los bloques de esa
L_6592:
	di			;6592   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6593
	ld (08000h),a		;6595   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6598   ; y en su copia de RAM
	ei			;659b   ; el mapa ya esta entero
	di			;659c   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;659d
	ld (0a000h),a		;659f   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;65a2   ; y en su copia de RAM
	ei			;65a5   ; el mapa ya esta entero
	ret			;65a6

; ----------------------------------------------------------------------
; A 0x50 DE LA META. Aqui se mira si la fase es la 12, la 18 o la 24 -las tres que cierran vuelta- y, si ademas 0xE16C esta a cero, se llama a 0x6476 con 0, 1 o 2: una cosa distinta para cada una de las tres. En las otras veintiuna fases lo unico que pasa es que 0xE0A5 se pone a 1.
; ----------------------------------------------------------------------
a_0x50_de_la_meta:
	ld a,(0e092h)		;65a7   ; la fase
	cp 00ch		;65aa   ; ¿la 12?
	ld c,000h		;65ac
	jr z,el_final_de_las_tres_fases		;65ae
	inc c			;65b0
	cp 012h		;65b1   ; ¿la 18?
	jr z,el_final_de_las_tres_fases		;65b3
	inc c			;65b5
	cp 018h		;65b6   ; ¿o la 24?
	jr z,el_final_de_las_tres_fases		;65b8
el_final_de_siempre:
	ld a,001h		;65ba   ; la vuelta, a 1
	ld (0e0a5h),a		;65bc   ; por que vuelta de la fase va
	jp sigue_la_fase		;65bf
el_final_de_las_tres_fases:
	ld a,(0e16ch)		;65c2   ; y 0xE16C lo puede impedir
	and a			;65c5
	jr nz,el_final_de_siempre		;65c6
	ld a,c			;65c8   ; 0, 1 o 2 segun cual de las tres sea
	call escoge_el_registro_de_once		;65c9
	jp sigue_la_fase		;65cc

; ----------------------------------------------------------------------
; LA CUENTA ATRAS DEL FINAL. Nueve cortes: a 0x30, 0x25, 0x20, 0x15, 0x10, 8, 5, 2 y 0 de la meta, cada uno con su rutina. Es una escalera de `rst 20h`, que en el MSX es DCOMPR: compara HL con DE y pone Z si son iguales. Entre corte y corte no pasa nada, se sigue la fase por 0x6536.
; ----------------------------------------------------------------------
cuenta_atras_del_final:
	ld hl,00030h		;65cf   ; ¿quedan 0x30?
	rst 20h			;65d2   ; DCOMPR: compara HL con DE
	jr z,L_661A		;65d3
	ld hl,00025h		;65d5   ; ¿0x25?
	rst 20h			;65d8
	jp z,L_663E		;65d9
	ld hl,00020h		;65dc   ; ¿0x20?
	rst 20h			;65df
	jp z,L_6651		;65e0
	ld hl,00015h		;65e3   ; ¿0x15?
	rst 20h			;65e6
	jp z,L_6659		;65e7
	ld hl,00010h		;65ea   ; ¿0x10?
	rst 20h			;65ed
	jp z,L_666C		;65ee
	ld hl,00008h		;65f1   ; ¿8?
	rst 20h			;65f4
	jp z,L_6674		;65f5
	ld hl,00005h		;65f8   ; ¿5?
	rst 20h			;65fb
	jp z,L_6687		;65fc
	ld hl,00002h		;65ff   ; ¿2?
	rst 20h			;6602
	jp z,L_668F		;6603
	ld hl,00000h		;6606   ; ¿y cero?
	rst 20h			;6609
	jp nz,sigue_la_fase		;660a   ; si no es ninguno, la fase sigue
	ld c,008h		;660d   ; y en cero, el paso 8
	call L_6697		;660f
	ld a,001h		;6612
	ld (0e096h),a		;6614   ; los avisos que deja el cuadro
	jp sigue_la_fase		;6617
L_661A:
	ld a,002h		;661a
	ld (0e0a5h),a		;661c   ; por que vuelta de la fase va
	ld a,(0e1f0h)		;661f
	and a			;6622
	jr z,L_662B		;6623
	ld hl,00001h		;6625
	ld (0e1f4h),hl		;6628
L_662B:
	ld a,(0e093h)		;662b   ; el valor 1-2-3 de la fase
	cp 003h		;662e
	jr z,L_6638		;6630
	call 05212h		;6632
	jp sigue_la_fase		;6635
L_6638:
	call 0537ah		;6638
	jp sigue_la_fase		;663b
L_663E:
	ld a,(0e093h)		;663e   ; el valor 1-2-3 de la fase
	cp 003h		;6641
	jr z,L_664B		;6643
	call 0529ah		;6645
	jp sigue_la_fase		;6648
L_664B:
	call 05424h		;664b
	jp sigue_la_fase		;664e
L_6651:
	ld c,000h		;6651
	call L_6697		;6653
	jp sigue_la_fase		;6656
L_6659:
	ld a,(0e093h)		;6659   ; el valor 1-2-3 de la fase
	cp 003h		;665c
	jr z,L_6666		;665e
	call 05256h		;6660
	jp sigue_la_fase		;6663
L_6666:
	call 053cfh		;6666
	jp sigue_la_fase		;6669
L_666C:
	ld c,002h		;666c
	call L_6697		;666e
	jp sigue_la_fase		;6671
L_6674:
	ld a,(0e093h)		;6674   ; el valor 1-2-3 de la fase
	cp 003h		;6677
	jr z,L_6681		;6679
	call 0530ah		;667b
	jp sigue_la_fase		;667e
L_6681:
	call 05498h		;6681
	jp sigue_la_fase		;6684
L_6687:
	ld c,004h		;6687
	call L_6697		;6689
	jp sigue_la_fase		;668c
L_668F:
	ld c,006h		;668f
	call L_6697		;6691
	jp sigue_la_fase		;6694
L_6697:
	di			;6697   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;6698
	ld (08000h),a		;669a   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;669d   ; y en su copia de RAM
	ei			;66a0   ; el mapa ya esta entero
	di			;66a1   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;66a2
	ld (0a000h),a		;66a4   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;66a7   ; y en su copia de RAM
	ei			;66aa   ; el mapa ya esta entero
	ld a,(0e093h)		;66ab   ; el valor 1-2-3 de la fase
	cp 003h		;66ae
	ld hl,0a605h		;66b0
	jr nz,L_66B8		;66b3
	ld hl,0a76bh		;66b5
L_66B8:
	ld a,c			;66b8
	call 04056h		;66b9   ; banco 0: a_mas_hl
	ld e,(hl)			;66bc
	inc hl			;66bd
	ld d,(hl)			;66be
	ex de,hl			;66bf
	call 041bfh		;66c0   ; banco 0: copia_bloques
	jp L_6592		;66c3
L_66C6:
	cp 002h		;66c6
	jp nz,sigue_la_fase		;66c8
	ld hl,00000h		;66cb
	rst 20h			;66ce
	jp nz,sigue_la_fase		;66cf
	ld a,010h		;66d2
	ld (0e096h),a		;66d4   ; los avisos que deja el cuadro
	jp sigue_la_fase		;66d7

; ----------------------------------------------------------------------
; EL SEGUNDO GUION: LO QUE PASA A CADA DISTANCIA. Igual que el de los enemigos pero en el banco 13, y con entradas de tres bytes en vez de dos. Se dispara comparando la distancia andada con la apuntada, y al dispararse deja la siguiente ya preparada.
; ----------------------------------------------------------------------
el_segundo_guion:
	ld a,(0e0a2h)		;66da   ; el modo del juego; el modo en el que esta el juego
	and a			;66dd
	ret nz			;66de   ; fuera del de jugar, nada
	ld hl,(0e08dh)		;66df   ; lo que queda de fase
	ld de,(0e0a7h)		;66e2   ; y la distancia a la que toca
	rst 20h			;66e6   ; DCOMPR: ¿hemos llegado?
	ret nz			;66e7
	ld hl,0e0a9h		;66e8   ; por que entrada del guion va
	inc (hl)			;66eb   ; la siguiente
	ld a,(hl)			;66ec
lee_la_entrada_del_segundo_guion:
	ld c,a			;66ed   ; C se queda con el numero de entrada
	di			;66ee   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;66ef   ; el banco 12
	ld (08000h),a		;66f1   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;66f4   ; y en su copia de RAM
	ei			;66f7   ; el mapa ya esta entero
	di			;66f8   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;66f9   ; y el 13, que es donde esta el guion
	ld (0a000h),a		;66fb   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;66fe   ; y en su copia de RAM
	ei			;6701   ; el mapa ya esta entero
	ld hl,0ade8h		;6702   ; la tabla, un puntero por fase
	ld a,(0e092h)		;6705   ; la FASE, de 1 a 24
	dec a			;6708
	call 04055h		;6709   ; dos bytes por entrada; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;670c   ; y ahi esta el guion de esta fase
	inc hl			;670d
	ld d,(hl)			;670e
	ld a,c			;670f
	add a,a			;6710   ; tres bytes por entrada: por tres
	add a,c			;6711
	ex de,hl			;6712
	call 04056h		;6713   ; HL = guion + 3*entrada; banco 0: a_mas_hl
	ld e,(hl)			;6716   ; la distancia de la entrada
	inc hl			;6717
	ld d,(hl)			;6718
	ld (0e0a7h),de		;6719   ; apuntada para la proxima
	inc hl			;671d
	ld a,(hl)			;671e   ; y el byte que dice que pasa
	ld (0e0a6h),a		;671f   ; el arrastre de lado que se lleva solo
	di			;6722   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6723   ; el 2 y el 3, de vuelta
	ld (08000h),a		;6725   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6728   ; y en su copia de RAM
	ei			;672b   ; el mapa ya esta entero
	di			;672c   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;672d
	ld (0a000h),a		;672f   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6732   ; y en su copia de RAM
	ei			;6735   ; el mapa ya esta entero
	ret			;6736

; ----------------------------------------------------------------------
; EL TERCER GUION: EL TERRENO. Se lee de un tiron distinto: aqui no hay distancias, hay una TIRA de bytes que se va gastando de uno en uno segun se avanza (0xE404 es por donde va y 0xE402 el byte de ahora). Y hay TRES tiras por fase, en el banco 10: 0x8000, 0x80F9 y 0x8490, y cual se coge depende del modo y de 0xE08F -que es lo que se eligio en el menu-.
; ----------------------------------------------------------------------
el_guion_del_terreno:
	ld a,(0e0a2h)		;6737   ; el modo del juego; el modo en el que esta el juego
	dec a			;673a
	ret z			;673b   ; en el modo 1 no hay terreno que leer
	di			;673c   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;673d   ; el banco 10
	ld (08000h),a		;673f   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;6742   ; y en su copia de RAM
	ei			;6745   ; el mapa ya esta entero
	di			;6746   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;6747   ; y el 11
	ld (0a000h),a		;6749   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;674c   ; y en su copia de RAM
	ei			;674f   ; el mapa ya esta entero
	ld a,(0e0a2h)		;6750   ; el modo otra vez; el modo en el que esta el juego
	and a			;6753
	jr z,L_675B		;6754
	ld de,08490h		;6756   ; con modo distinto de cero, la tercera tira
	jr coge_el_byte_de_terreno		;6759
L_675B:
	ld a,(0e08fh)		;675b   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
	and a			;675e
	ld de,08000h		;675f   ; la primera tira...
	jr z,el_terreno_de_esta_fase		;6762
	ld de,080f9h		;6764   ; ...o la segunda
el_terreno_de_esta_fase:
	ld a,(0e092h)		;6767   ; la FASE, de 1 a 24
	dec a			;676a
	ld l,a			;676b
	ld h,000h		;676c
	add hl,hl			;676e   ; dos bytes por entrada
	add hl,de			;676f
	ld e,(hl)			;6770   ; y ese es el puntero a la tira de esta fase
	inc hl			;6771
	ld d,(hl)			;6772
coge_el_byte_de_terreno:
	ld hl,0e404h		;6773   ; por donde va la tira
	ld a,(hl)			;6776
	inc (hl)			;6777   ; y se avanza uno
	ex de,hl			;6778
	call 04056h		;6779   ; HL = tira + lo andado; banco 0: a_mas_hl
	ld a,(hl)			;677c   ; el byte que toca
	ld (0e402h),a		;677d   ; que queda de byte de terreno de ahora
	xor a			;6780
	ld (0e403h),a		;6781   ; y la marca de que ya se ha usado, a cero
	di			;6784   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6785   ; el 2 y el 3, de vuelta
	ld (08000h),a		;6787   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;678a   ; y en su copia de RAM
	ei			;678d   ; el mapa ya esta entero
	di			;678e   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;678f
	ld (0a000h),a		;6791   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6794   ; y en su copia de RAM
	ei			;6797   ; el mapa ya esta entero
	ret			;6798

; ----------------------------------------------------------------------
; LO QUE SALE DEL TERRENO. La rutina que convierte el byte de terreno en cosas puestas en las cinco ranuras de 0xE440. Tiene dos fuentes segun el modo: en el modo 1 lee una lista de 0x81F2 -banco 10-, y en el de jugar coge el byte de terreno de ahora (0xE402), lo multiplica por OCHO y con eso indexa la tabla de 0x84EA: ocho cosas por cada tramo de terreno, y 0xE403 dice por cual va.
; ----------------------------------------------------------------------
lo_que_sale_del_terreno:
	ld a,(0e0a5h)		;6799   ; por que vuelta de la fase va
	and a			;679c
	ret nz			;679d
	ld a,(0e0a4h)		;679e   ; y otra bandera
	and a			;67a1
	ret nz			;67a2
	ld hl,0e401h		;67a3   ; la marca de que ya se ha usado el byte
	ld a,(hl)			;67a6
	and a			;67a7
	ret nz			;67a8   ; si sigue puesta, no toca
	dec hl			;67a9   ; el byte de terreno
	ld a,(hl)			;67aa
	inc hl			;67ab
	ld (hl),a			;67ac   ; que pasa a ser el de ahora
	di			;67ad   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;67ae   ; el banco 10
	ld (08000h),a		;67b0   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;67b3   ; y en su copia de RAM
	ei			;67b6   ; el mapa ya esta entero
	di			;67b7   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;67b8   ; y el 11
	ld (0a000h),a		;67ba   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;67bd   ; y en su copia de RAM
	ei			;67c0   ; el mapa ya esta entero
lee_lo_que_toca_del_terreno:
	ld a,(0e0a2h)		;67c1   ; el modo en el que esta el juego
	dec a			;67c4
	ld hl,081f2h		;67c5   ; en el modo 1, otra tabla
	jr nz,lo_que_sale_en_el_juego		;67c8
	ld a,(0e0a3h)		;67ca   ; cual de ellas
	call 04055h		;67cd   ; banco 0: dos_por_a_mas_hl; dos bytes por entrada
	ld e,(hl)			;67d0
	inc hl			;67d1
	ld d,(hl)			;67d2
	ld hl,0e403h		;67d3   ; por donde va la lista
	inc (hl)			;67d6   ; uno mas
	ld a,(hl)			;67d7
	call 0405bh		;67d8   ; banco 0: a_mas_de; DE = lista + indice
	ld a,(de)			;67db   ; lo que hay
	cp 0ffh		;67dc   ; 0xFF cierra la lista
	jr nz,lo_del_terreno_encontrado		;67de
	ld a,0ffh		;67e0   ; y se vuelve a empezar
	ld (0e403h),a		;67e2
	jr lee_lo_que_toca_del_terreno		;67e5
lo_del_terreno_encontrado:
	ld c,a			;67e7   ; C se queda con lo que sale
	jr mete_la_cosa_en_una_ranura		;67e8
lo_que_sale_en_el_juego:
	ld a,(0e402h)		;67ea   ; el byte de terreno de ahora
	ld de,084eah		;67ed   ; la tabla de tramos
	ld l,a			;67f0
	ld h,000h		;67f1
	add hl,hl			;67f3   ; por ocho: ocho cosas por tramo
	add hl,hl			;67f4
	add hl,hl			;67f5
	add hl,de			;67f6   ; y ahi esta el tramo
	ex de,hl			;67f7
	ld hl,0e403h		;67f8   ; por cual de las ocho va
	ld c,(hl)			;67fb
	inc (hl)			;67fc   ; la siguiente
	ld a,(hl)			;67fd
	cp 008h		;67fe   ; a las ocho...
	jr nz,coge_la_cosa_del_tramo		;6800
	xor a			;6802   ; ...vuelta a empezar
	ld (hl),a			;6803
coge_la_cosa_del_tramo:
	ld a,c			;6804
	ex de,hl			;6805
	call 04056h		;6806   ; banco 0: a_mas_hl; HL = tramo + la que toca
	ld a,(hl)			;6809   ; y lo que sale
	and a			;680a   ; un cero es "aqui no sale nada"
	jr z,devuelve_el_2_y_el_3		;680b
	ld c,a			;680d
	ld a,(0e0b3h)		;680e   ; una bandera que cambia lo que sale
	and a			;6811
	jr z,mete_la_cosa_en_una_ranura		;6812
	cp 002h		;6814   ; con un 2 sale otra cosa
	ld c,02fh		;6816
	jr z,mete_la_cosa_en_una_ranura		;6818
	and 0f0h		;681a   ; y segun el nibble alto, dos mas
	ld c,00ah		;681c
	jr z,mete_la_cosa_en_una_ranura		;681e
	ld c,00bh		;6820
mete_la_cosa_en_una_ranura:
	ld a,c			;6822   ; lo que sale
	cp 030h		;6823   ; de 0x30 para arriba, por otro camino
	jp nc,L_68BB		;6825
	cp 027h		;6828   ; de 0x27 a 0x2F, por otro
	jr nc,L_6888		;682a
	ld d,000h		;682c
busca_ranura_libre:
	ld hl,0e440h		;682e   ; las cinco ranuras
	ld b,005h		;6831   ; cinco
busca_ranura_libre_vuelta:
	ld a,(hl)			;6833   ; ¿esta ocupada?
	and a			;6834
	jr z,llena_la_ranura		;6835
	ld a,010h		;6837   ; 0x10 bytes a la siguiente
	add a,l			;6839
	ld l,a			;683a
	djnz busca_ranura_libre_vuelta		;683b
devuelve_el_2_y_el_3:
	di			;683d   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;683e   ; el banco 2
	ld (08000h),a		;6840   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6843   ; y en su copia de RAM
	ei			;6846   ; el mapa ya esta entero
	di			;6847   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6848   ; y el 3
	ld (0a000h),a		;684a   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;684d   ; y en su copia de RAM
	ei			;6850   ; el mapa ya esta entero
	ret			;6851
llena_la_ranura:
	ld (hl),001h		;6852   ; la ranura queda ocupada
	inc l			;6854
	ld (hl),c			;6855   ; con lo que sale
	inc l			;6856
	ld (hl),000h		;6857   ; y el tercer byte a cero
	inc hl			;6859
	ld a,c			;685a
	cp 003h		;685b   ; por debajo de 3...
	ld a,001h		;685d   ; ...un uno...
	jr c,L_6862		;685f
	dec a			;6861   ; ...y si no, un cero
L_6862:
	ld (hl),a			;6862
	inc hl			;6863
	ld a,c			;6864   ; lo que sale
	cp 00ah		;6865   ; de 0x0A a 0x0D...
	jr c,otra_cosa_del_mismo_tramo		;6867
	cp 00eh		;6869
	jr nc,otra_cosa_del_mismo_tramo		;686b
	ld a,(0e0b3h)		;686d   ; ...se le guardan dos cosas mas de la RAM
	and 00fh		;6870
	ld (hl),a			;6872
	inc hl			;6873
	ld a,(0e0bah)		;6874
	ld (hl),a			;6877
	xor a			;6878
	ld (0e0b3h),a		;6879   ; que quedan gastadas
	ld (0e0bah),a		;687c
otra_cosa_del_mismo_tramo:
	ld a,d			;687f   ; ¿habia una segunda?
	and a			;6880
	ld c,d			;6881   ; pues se mete tambien
	ld d,000h		;6882
	jr nz,busca_ranura_libre		;6884
	jr devuelve_el_2_y_el_3		;6886
L_6888:
	sub 027h		;6888
	ld hl,084a0h		;688a
	call 04055h		;688d   ; banco 0: dos_por_a_mas_hl
	ld c,(hl)			;6890
	inc hl			;6891
	ld e,(hl)			;6892
	ld a,c			;6893
	cp 004h		;6894
	jr z,L_68A9		;6896
	cp 00fh		;6898
	jr z,L_68A9		;689a
	ld a,(0e205h)		;689c   ; la X en la pantalla de lo que se maneja
	cp 070h		;689f
	jr c,L_68A4		;68a1
	ld c,e			;68a3
L_68A4:
	ld d,000h		;68a4
	jp busca_ranura_libre		;68a6
L_68A9:
	ld a,(0e205h)		;68a9   ; la X en la pantalla de lo que se maneja
	cp 050h		;68ac
	jr c,L_68B6		;68ae
	dec c			;68b0
	cp 0a0h		;68b1
	jr c,L_68B6		;68b3
	ld c,e			;68b5
L_68B6:
	ld d,000h		;68b6
	jp busca_ranura_libre		;68b8
L_68BB:
	sub 030h		;68bb
	ld hl,084b2h		;68bd
	call 04055h		;68c0   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;68c3
	inc hl			;68c4
	ld d,(hl)			;68c5
	ld c,e			;68c6
	jp busca_ranura_libre		;68c7
L_68CA:
	ld a,(0e203h)		;68ca   ; el ESTADO de lo que se maneja
	cp 003h		;68cd
	ret z			;68cf
	cp 004h		;68d0
	ret z			;68d2
	cp 008h		;68d3
	ret z			;68d5
	cp 00ah		;68d6
	ret z			;68d8
	ld a,(0e4c0h)		;68d9   ; el nivel de la barra de nueve
	ld c,a			;68dc
	ld a,(0e4c1h)		;68dd
	cp c			;68e0
	ret nz			;68e1
L_68E2:
	di			;68e2   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;68e3
	ld (08000h),a		;68e5   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;68e8   ; y en su copia de RAM
	ei			;68eb   ; el mapa ya esta entero
	di			;68ec   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;68ed
	ld (0a000h),a		;68ef   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;68f2   ; y en su copia de RAM
	ei			;68f5   ; el mapa ya esta entero
	ld de,0e440h		;68f6
	ld b,005h		;68f9
	xor a			;68fb
	ld (0e0e3h),a		;68fc   ; que hueco de sprite toca
lee_el_guion_del_decorado:
	push bc			;68ff   ; el byte del guion
	ld a,(de)			;6900
	inc e			;6901
	and a			;6902   ; el cero lo cierra
	jr z,L_6938		;6903
	ld a,(de)			;6905
	cp 01ah		;6906   ; por debajo de 0x1A va por un lado...
	jr c,L_690F		;6908
	cp 020h		;690a   ; ...y del 0x1A al 0x1F, por otro
	jp c,L_69D0		;690c
L_690F:
	dec a			;690f
	ld hl,08682h		;6910   ; la tabla de dos niveles de 0x8682
	call 04055h		;6913   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6916
	inc hl			;6917
	ld h,(hl)			;6918
	ld l,a			;6919
	inc e			;691a
	ld a,(de)			;691b
	ld c,a			;691c
	inc a			;691d
	ld (de),a			;691e
	ld a,c			;691f
	and a			;6920
	jr z,L_6937		;6921
	push af			;6923
	dec a			;6924
	call 04055h		;6925   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6928
	inc hl			;6929
	ld h,(hl)			;692a
	ld l,a			;692b
	push de			;692c
	call 041adh		;692d   ; banco 0: rellena_de_unos
	pop de			;6930
	pop af			;6931
	cp 010h		;6932
	jp z,L_69BF		;6934
L_6937:
	dec e			;6937
L_6938:
	ld a,00fh		;6938
L_693A:
	add a,e			;693a
	ld e,a			;693b
	pop bc			;693c
	ld hl,0e0e3h		;693d
	inc (hl)			;6940
	djnz lee_el_guion_del_decorado		;6941
	di			;6943   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6944
	ld (08000h),a		;6946   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6949   ; y en su copia de RAM
	ei			;694c   ; el mapa ya esta entero
	di			;694d   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;694e
	ld (0a000h),a		;6950   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6953   ; y en su copia de RAM
	ei			;6956   ; el mapa ya esta entero
	di			;6957   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;6958
	ld (08000h),a		;695a   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;695d   ; y en su copia de RAM
	ei			;6960   ; el mapa ya esta entero
	di			;6961   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;6962
	ld (0a000h),a		;6964   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;6967   ; y en su copia de RAM
	ei			;696a   ; el mapa ya esta entero
	ld de,0e440h		;696b
	ld b,005h		;696e
	xor a			;6970
	ld (0e0e3h),a		;6971   ; que hueco de sprite toca
lee_el_otro_guion_del_decorado:
	push bc			;6974   ; el byte del guion
	ld a,(de)			;6975
	inc e			;6976
	and a			;6977   ; el cero lo cierra
	jr z,L_699F		;6978
	ld a,(de)			;697a
	cp 01ah		;697b   ; por debajo de 0x1A va por un lado...
	jr c,L_6984		;697d
	cp 020h		;697f   ; ...y del 0x1A al 0x1F, por otro
	jp c,L_6A3F		;6981
L_6984:
	dec a			;6984
	ld hl,08682h		;6985   ; la tabla de dos niveles de 0x8682
	call 04055h		;6988   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;698b
	inc hl			;698c
	ld h,(hl)			;698d
	ld l,a			;698e
	inc e			;698f
	ld a,(de)			;6990
	dec a			;6991
	call 04055h		;6992   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6995
	inc hl			;6996
	ld h,(hl)			;6997
	ld l,a			;6998
	push de			;6999
	call 041bfh		;699a   ; banco 0: copia_bloques
	pop de			;699d
	dec e			;699e
L_699F:
	ld a,00fh		;699f
L_69A1:
	add a,e			;69a1
	ld e,a			;69a2
	pop bc			;69a3
	ld hl,0e0e3h		;69a4
	inc (hl)			;69a7
	djnz lee_el_otro_guion_del_decorado		;69a8
	di			;69aa   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;69ab
	ld (08000h),a		;69ad   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;69b0   ; y en su copia de RAM
	ei			;69b3   ; el mapa ya esta entero
	di			;69b4   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;69b5
	ld (0a000h),a		;69b7   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;69ba   ; y en su copia de RAM
	ei			;69bd   ; el mapa ya esta entero
	ret			;69be
L_69BF:
	dec e			;69bf
	dec e			;69c0
	push de			;69c1
	ex de,hl			;69c2
	ld b,010h		;69c3
borra_y_sigue_el_guion:
	ld (hl),000h		;69c5   ; a cero
	inc hl			;69c7
	djnz borra_y_sigue_el_guion		;69c8
	pop de			;69ca
	ld a,010h		;69cb   ; y el byte 0x10 del guion
	jp L_693A		;69cd
L_69D0:
	sub 01ah		;69d0
	ld (0e4e0h),a		;69d2   ; la tabla de cambio de color, nibble alto
	ld hl,0a539h		;69d5
	call 04055h		;69d8   ; banco 0: dos_por_a_mas_hl
	ld c,(hl)			;69db
	inc hl			;69dc
	ld b,(hl)			;69dd
	inc e			;69de
	ld a,(de)			;69df
	inc a			;69e0
	ld (de),a			;69e1
	cp 011h		;69e2
	jr z,borra_el_hueco_y_su_sprite		;69e4
	dec a			;69e6
	ld l,a			;69e7
	ld h,000h		;69e8
	push bc			;69ea
	add hl,hl			;69eb
	ld c,l			;69ec
	ld b,h			;69ed
	add hl,bc			;69ee
	pop bc			;69ef
	add hl,bc			;69f0
	inc e			;69f1
	inc e			;69f2
	inc e			;69f3
	inc e			;69f4
	ldi		;69f5
	ldi		;69f7
	ldi		;69f9
	ldi		;69fb
	ld a,(0e4e0h)		;69fd   ; la tabla de cambio de color, nibble alto
	cp 003h		;6a00
	jr c,L_6A11		;6a02
	ld a,(0e003h)		;6a04   ; el contador de cuadros
	rra			;6a07
	ld a,006h		;6a08
	jr c,L_6A0E		;6a0a
	ld a,00ah		;6a0c
L_6A0E:
	dec e			;6a0e
	ld (de),a			;6a0f
	inc e			;6a10
L_6A11:
	ld a,006h		;6a11
	jp L_693A		;6a13
borra_el_hueco_y_su_sprite:
	dec e			;6a16   ; atras, al principio del hueco
	dec e			;6a17
	push de			;6a18
	ex de,hl			;6a19
	ld b,010h		;6a1a   ; sus dieciseis bytes
	xor a			;6a1c
borra_el_hueco_vuelta_de_0xE440:
	ld (hl),a			;6a1d
	inc hl			;6a1e
	djnz borra_el_hueco_vuelta_de_0xE440		;6a1f
	ld a,(0e0e3h)		;6a21   ; que hueco de sprite tenia
	add a,a			;6a24   ; por cuatro
	ld hl,0ee80h		;6a25
	call 04055h		;6a28   ; banco 0: dos_por_a_mas_hl
	ld (hl),0e0h		;6a2b
	ld a,(0e0e3h)		;6a2d   ; que hueco de sprite toca
	add a,a			;6a30
	ld hl,0eea4h		;6a31
	call 04055h		;6a34   ; banco 0: dos_por_a_mas_hl
	ld (hl),0e0h		;6a37
	pop de			;6a39
	ld a,010h		;6a3a
	jp L_693A		;6a3c
L_6A3F:
	sub 01ah		;6a3f
	ld (0e4e0h),a		;6a41   ; la tabla de cambio de color, nibble alto
	inc e			;6a44
	ld a,(de)			;6a45
	cp 00fh		;6a46
	jr nc,L_6A73		;6a48
	ld a,(0e0e3h)		;6a4a   ; que hueco de sprite toca
	add a,a			;6a4d
	ld hl,0eea4h		;6a4e
	call 04055h		;6a51   ; banco 0: dos_por_a_mas_hl
	inc e			;6a54
	inc e			;6a55
	inc e			;6a56
	inc e			;6a57
	ex de,hl			;6a58
	ldi		;6a59
	ldi		;6a5b
	ldi		;6a5d
	ldi		;6a5f
	ld a,(0e4e0h)		;6a61   ; la tabla de cambio de color, nibble alto
	cp 003h		;6a64
	jr c,L_6A6D		;6a66
	ld a,00ah		;6a68
	dec e			;6a6a
	ld (de),a			;6a6b
	inc e			;6a6c
L_6A6D:
	ex de,hl			;6a6d
	ld a,006h		;6a6e
	jp L_69A1		;6a70
L_6A73:
	ld a,(0e0e3h)		;6a73   ; que hueco de sprite toca
	add a,a			;6a76
	ld hl,0ee80h		;6a77
	call 04055h		;6a7a   ; banco 0: dos_por_a_mas_hl
	inc e			;6a7d
	inc e			;6a7e
	inc e			;6a7f
	inc e			;6a80
	ex de,hl			;6a81
	ldi		;6a82
	ldi		;6a84
	ldi		;6a86
	ldi		;6a88
	ld a,(0e4e0h)		;6a8a   ; la tabla de cambio de color, nibble alto
	cp 003h		;6a8d
	jr c,L_6A96		;6a8f
	ld a,00ah		;6a91
	dec e			;6a93
	ld (de),a			;6a94
	inc e			;6a95
L_6A96:
	ex de,hl			;6a96
	ld hl,0eea4h		;6a97
	ld a,(0e0e3h)		;6a9a   ; que hueco de sprite toca
	add a,a			;6a9d
	call 04055h		;6a9e   ; banco 0: dos_por_a_mas_hl
	ld (hl),0e0h		;6aa1
	ld a,006h		;6aa3
	jp L_69A1		;6aa5

; ----------------------------------------------------------------------
; LO QUE PASA POR LOS LADOS DE LA CARRETERA (no son colores: se decia "los colores que dan vueltas" y no toca ni un color). Solo en cinco de los diez decorados: cuatro tiras en los decorados 0, 2 y 4 y dos en el 1 y el 3, de la tabla de 0xA420 del banco 11, cada una de diez pasos. En cada cuadro con la barra clavada -0xE4C0 igual a 0xE4C1- y solo uno de cada dos (0xE405): borra el paso anterior con unos (p00:41AD) y pinta el siguiente (p00:41BF). Va por cuadros, no por distancia.
; ----------------------------------------------------------------------
los_colores_que_dan_vueltas:
	ld a,(0e203h)		;6aa8   ; el ESTADO de lo que se maneja
	cp 003h		;6aab
	ret z			;6aad
	cp 004h		;6aae
	ret z			;6ab0
	cp 008h		;6ab1
	ret z			;6ab3
	cp 00ah		;6ab4
	ret z			;6ab6
	ld a,(0e0a1h)		;6ab7   ; el decorado
	and a			;6aba
	ld b,004h		;6abb   ; el 0, el 2 y el 4 giran cuatro tablas...
	jr z,L_6AD0		;6abd
	cp 002h		;6abf
	jr z,L_6AD0		;6ac1
	cp 004h		;6ac3
	jr z,L_6AD0		;6ac5
	ld b,002h		;6ac7   ; ...y el 1 y el 3, dos
	cp 001h		;6ac9
	jr z,L_6AD0		;6acb
	cp 003h		;6acd
	ret nz			;6acf   ; en los demas no gira nada
L_6AD0:
	ld a,b			;6ad0
	ld (0e4e0h),a		;6ad1   ; cuantas tablas
	ld a,(0e4c0h)		;6ad4   ; el nivel de la barra
	ld c,a			;6ad7
	ld a,(0e4c1h)		;6ad8   ; contra su contador
	cp c			;6adb
	ret nz			;6adc   ; si no esta clavada, no se gira nada
	ld hl,0e405h		;6add
	inc (hl)			;6ae0   ; un cuadro mas
	ld a,(hl)			;6ae1
	rra			;6ae2   ; y solo uno de cada dos
	ret nc			;6ae3
	di			;6ae4   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;6ae5
	ld (08000h),a		;6ae7   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;6aea   ; y en su copia de RAM
	ei			;6aed   ; el mapa ya esta entero
	di			;6aee   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;6aef
	ld (0a000h),a		;6af1   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;6af4   ; y en su copia de RAM
	ei			;6af7   ; el mapa ya esta entero
	ld de,0e409h		;6af8   ; los pasos de cada tabla
	ld a,(0e4e0h)		;6afb   ; cuantas tablas
	ld b,a			;6afe
gira_una_tabla_de_color:
	push bc			;6aff
	dec b			;6b00
	ld a,b			;6b01
	ld hl,0a420h		;6b02   ; las tablas de color del banco 10
	call 04055h		;6b05   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6b08   ; la que toca
	inc hl			;6b09
	ld h,(hl)			;6b0a
	ld l,a			;6b0b
	ld a,(de)			;6b0c   ; su paso de ahora
	ld c,a			;6b0d
	inc a			;6b0e   ; uno mas
	cp 00ah		;6b0f   ; y al llegar a diez...
	jr nz,L_6B14		;6b11
	xor a			;6b13   ; ...vuelta a empezar
L_6B14:
	ld (de),a			;6b14   ; apuntado
	ld a,c			;6b15
	and a			;6b16   ; con el paso a cero no se pinta nada
	jr z,L_6B28		;6b17
	push af			;6b19
	dec a			;6b1a
	call 04055h		;6b1b   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6b1e
	inc hl			;6b1f
	ld h,(hl)			;6b20
	ld l,a			;6b21
	push de			;6b22
	call 041adh		;6b23   ; banco 0: rellena_de_unos
	pop de			;6b26
	pop af			;6b27
L_6B28:
	dec e			;6b28
	pop bc			;6b29
	djnz gira_una_tabla_de_color		;6b2a
	di			;6b2c   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6b2d
	ld (08000h),a		;6b2f   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6b32   ; y en su copia de RAM
	ei			;6b35   ; el mapa ya esta entero
	di			;6b36   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6b37
	ld (0a000h),a		;6b39   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6b3c   ; y en su copia de RAM
	ei			;6b3f   ; el mapa ya esta entero
	di			;6b40   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;6b41
	ld (08000h),a		;6b43   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;6b46   ; y en su copia de RAM
	ei			;6b49   ; el mapa ya esta entero
	di			;6b4a   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;6b4b
	ld (0a000h),a		;6b4d   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;6b50   ; y en su copia de RAM
	ei			;6b53   ; el mapa ya esta entero
	ld de,0e409h		;6b54
	ld a,(0e4e0h)		;6b57   ; la tabla de cambio de color, nibble alto
	ld b,a			;6b5a
L_6B5B:
	push bc			;6b5b
	dec b			;6b5c
	ld a,b			;6b5d
	ld hl,0a420h		;6b5e
	call 04055h		;6b61   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6b64
	inc hl			;6b65
	ld h,(hl)			;6b66
	ld l,a			;6b67
	ld a,(de)			;6b68
	and a			;6b69
	jr z,L_6B79		;6b6a
	dec a			;6b6c
	call 04055h		;6b6d   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6b70
	inc hl			;6b71
	ld h,(hl)			;6b72
	ld l,a			;6b73
	push de			;6b74
	call 041bfh		;6b75   ; banco 0: copia_bloques
	pop de			;6b78
L_6B79:
	dec e			;6b79
	pop bc			;6b7a
	djnz L_6B5B		;6b7b
	di			;6b7d   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6b7e
	ld (08000h),a		;6b80   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6b83   ; y en su copia de RAM
	ei			;6b86   ; el mapa ya esta entero
	di			;6b87   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6b88
	ld (0a000h),a		;6b8a   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6b8d   ; y en su copia de RAM
	ei			;6b90   ; el mapa ya esta entero
	ret			;6b91
L_6B92:
	ld a,(0e0a2h)		;6b92   ; el modo en el que esta el juego
	dec a			;6b95
	ret nz			;6b96
	di			;6b97   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;6b98
	ld (08000h),a		;6b9a   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;6b9d   ; y en su copia de RAM
	ei			;6ba0   ; el mapa ya esta entero
	di			;6ba1   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;6ba2
	ld (0a000h),a		;6ba4   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;6ba7   ; y en su copia de RAM
	ei			;6baa   ; el mapa ya esta entero
	ld hl,0e40ah		;6bab
	ld de,0eeb8h		;6bae
	ld bc,0aed0h		;6bb1
	call gira_los_cuatro_bytes_de_la_tabla		;6bb4
	ld bc,0af10h		;6bb7
	call gira_los_cuatro_bytes_de_la_tabla		;6bba
	ld bc,0af50h		;6bbd
	call gira_los_cuatro_bytes_de_la_tabla		;6bc0
	di			;6bc3   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6bc4
	ld (08000h),a		;6bc6   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6bc9   ; y en su copia de RAM
	ei			;6bcc   ; el mapa ya esta entero
	di			;6bcd   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6bce
	ld (0a000h),a		;6bd0   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6bd3   ; y en su copia de RAM
	ei			;6bd6   ; el mapa ya esta entero
	ret			;6bd7
gira_los_cuatro_bytes_de_la_tabla:
	push hl			;6bd8
	inc (hl)			;6bd9   ; un paso mas
	ld a,(hl)			;6bda
	cp 010h		;6bdb   ; al llegar a 16...
	jr nz,L_6BE1		;6bdd
	xor a			;6bdf   ; ...vuelta a cero
	ld (hl),a			;6be0
L_6BE1:
	add a,a			;6be1   ; dos bytes por entrada
	ld l,c			;6be2
	ld h,b			;6be3
	call 04055h		;6be4   ; banco 0: dos_por_a_mas_hl
	ld bc,00004h		;6be7   ; y cuatro bytes copiados
	ldir		;6bea
	pop hl			;6bec
	inc hl			;6bed
	ret			;6bee
L_6BEF:
	ld hl,0e1f0h		;6bef
	ld de,0e1f1h		;6bf2
	ld bc,00010h		;6bf5
	ld (hl),000h		;6bf8
	ldir		;6bfa
	ld a,(0e205h)		;6bfc   ; la X en la pantalla de lo que se maneja
	ld (0e0aah),a		;6bff
	ld a,003h		;6c02
	ld (0e134h),a		;6c04
	ld hl,06cc0h		;6c07
	ld a,(hl)			;6c0a
	ld (0e203h),a		;6c0b   ; el ESTADO de lo que se maneja
	inc hl			;6c0e
	ld a,(hl)			;6c0f
	ld (0e204h),a		;6c10   ; la Y en la pantalla de lo que se maneja
	inc hl			;6c13
	ld a,(hl)			;6c14
	ld (0e205h),a		;6c15   ; la X en la pantalla de lo que se maneja
	ld a,004h		;6c18
	ld (0ee83h),a		;6c1a
	ld (0ee87h),a		;6c1d
	ld (0ee8bh),a		;6c20
	ld (0ee8fh),a		;6c23
	call L_7DB3		;6c26
	ld a,005h		;6c29
	ld (0eecbh),a		;6c2b
	ld (0eecfh),a		;6c2e
	call 05b91h		;6c31
	call 04bbfh		;6c34
	call 051cdh		;6c37
L_6C3A:
	di			;6c3a   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;6c3b
	ld (08000h),a		;6c3d   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;6c40   ; y en su copia de RAM
	ei			;6c43   ; el mapa ya esta entero
	di			;6c44   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;6c45
	ld (0a000h),a		;6c47   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;6c4a   ; y en su copia de RAM
	ei			;6c4d   ; el mapa ya esta entero
	ld de,0a563h		;6c4e
	ld a,(0e0a2h)		;6c51   ; el modo en el que esta el juego
	sub 003h		;6c54
	jr z,L_6C61		;6c56
	ld de,0a59dh		;6c58
	dec a			;6c5b
	jr z,L_6C61		;6c5c
	ld de,0a5d7h		;6c5e
L_6C61:
	call 042bch		;6c61   ; banco 0: pinta_guion_con_mascara
	call pon_los_bancos_2_y_3		;6c64
	call L_6CC3		;6c67
repinta_la_tienda_entera:
	call L_6D1B		;6c6a
	call el_marcador_por_uno_de_los_dos_puentes		;6c6d   ; el marcador
	call repasa_las_seis_casillas		;6c70   ; las seis casillas
	call L_6C84		;6c73
	ld (0e10ch),a		;6c76   ; donde queda el cursor
	ld de,039c3h		;6c79   ; y su sitio en la pantalla
	jp pinta_el_cursor		;6c7c
L_6C7F:
	call 04bbfh		;6c7f
	jr L_6C3A		;6c82
L_6C84:
	xor a			;6c84
mueve_el_cursor_por_las_casillas:
	ld c,a			;6c85   ; a que casilla se quiere ir
	ld hl,0e100h		;6c86   ; las seis casillas
	ld a,(0e128h)		;6c89   ; y hacia que lado se va
	ld b,a			;6c8c
	and a			;6c8d
	ld a,c			;6c8e
	jr z,L_6C97		;6c8f   ; sin lado, se mira el tope de arriba
	cp 0ffh		;6c91   ; y con el, el de abajo
	jr z,el_cursor_a_la_casilla_7		;6c93
	jr L_6C9B		;6c95
L_6C97:
	cp 008h		;6c97
	jr z,L_6C84		;6c99
L_6C9B:
	cp 006h		;6c9b
	jr z,L_6CB8		;6c9d
	cp 007h		;6c9f
	ret z			;6ca1
	call 04055h		;6ca2   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6ca5
	and a			;6ca6
	ld a,c			;6ca7
	ret nz			;6ca8
el_cursor_arriba_o_abajo:
	ld a,b			;6ca9   ; hacia que lado
	and a			;6caa
	ld a,c			;6cab
	jr z,L_6CB1		;6cac
	dec a			;6cae   ; hacia atras...
	jr mueve_el_cursor_por_las_casillas		;6caf
L_6CB1:
	inc a			;6cb1   ; ...o hacia delante
	jr mueve_el_cursor_por_las_casillas		;6cb2
el_cursor_a_la_casilla_7:
	ld a,007h		;6cb4   ; la 7 es la de cerrar
	jr mueve_el_cursor_por_las_casillas		;6cb6
L_6CB8:
	ld a,(0e134h)		;6cb8
	and a			;6cbb
	ld a,c			;6cbc
	jr z,el_cursor_arriba_o_abajo		;6cbd
	ret			;6cbf

; ----------------------------------------------------------------------
; DATOS salida_de_lo_que_se_maneja: tres bytes que p01:6C07 reparte: el estado
;   de lo que se maneja (0xE203), la Y (0xE204) y la X (0xE205) de lo que se
;   maneja
;   0x6cc0..0x6cc3  (3 bytes)
DATA_salida_de_lo_que_se_maneja:
	defb 011h,0f8h,070h	; 6cc0

; ======================================================================
; CODIGO 0x6cc3..0x6dc5  (258 bytes)
; ======================================================================


L_6CC3:
	call borra_las_seis_casillas		;6cc3
	call pon_los_bancos_10_y_11		;6cc6
	ld ix,06fd5h		;6cc9
	ld a,(0e0a2h)		;6ccd   ; el modo en el que esta el juego
	sub 003h		;6cd0
	jr z,L_6CDF		;6cd2
	ld ix,06fe5h		;6cd4
	dec a			;6cd8
	jr z,L_6CDF		;6cd9
	ld ix,06ff5h		;6cdb
L_6CDF:
	ld a,(0e092h)		;6cdf   ; la FASE, de 1 a 24
	dec a			;6ce2
	ld c,a			;6ce3
	add a,a			;6ce4
	ld b,a			;6ce5
	add a,a			;6ce6
	add a,b			;6ce7
	add a,c			;6ce8
	ld de,0af90h		;6ce9
	ld bc,0e100h		;6cec
	call 0405bh		;6cef   ; banco 0: a_mas_de
L_6CF2:
	ld hl,0e160h		;6cf2
	ld a,(de)			;6cf5
	and a			;6cf6
	jr z,L_6D11		;6cf7
	dec a			;6cf9
	call 04056h		;6cfa   ; banco 0: a_mas_hl
	ld a,(hl)			;6cfd
	and a			;6cfe
	jr nz,L_6D0E		;6cff
	ld a,(de)			;6d01
	ld (bc),a			;6d02
	inc bc			;6d03
	push ix		;6d04
	pop hl			;6d06
	dec a			;6d07
	call 04056h		;6d08   ; banco 0: a_mas_hl
	ld a,(hl)			;6d0b
	ld (bc),a			;6d0c
	inc bc			;6d0d
L_6D0E:
	inc de			;6d0e
	jr L_6CF2		;6d0f
L_6D11:
	xor a			;6d11
	ld (0e11dh),a		;6d12
	ld (0e158h),a		;6d15
	jp pon_los_bancos_2_y_3		;6d18
L_6D1B:
	ld b,000h		;6d1b
pinta_las_seis_casillas:
	ld de,0e100h		;6d1d   ; las seis casillas
	call pinta_una_casilla		;6d20
	inc b			;6d23
	ld a,b			;6d24
	cp 006h		;6d25   ; hasta la sexta
	jr nz,pinta_las_seis_casillas		;6d27
	ret			;6d29

; ----------------------------------------------------------------------
; PINTAR UNA CASILLA DE LO QUE SE LLEVA. Cada casilla son cuatro caracteres en cuadro -dos seguidos y otros dos justo debajo, que es lo que significa el salto de 0x1F mas el `inc`-, y el primero de los cuatro sale de 0xB2 mas el valor por cuatro. Con 0xFF en el valor se pintan cuatro ceros: la casilla vacia. Se escribe con WRTVRM de la BIOS, uno a uno.
; ----------------------------------------------------------------------
pinta_una_casilla:
	ld a,b			;6d2a   ; que casilla
	ld hl,06dc5h		;6d2b   ; las seis direcciones de la tabla de nombres
	call 04055h		;6d2e   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6d31   ; la suya
	inc hl			;6d32
	ld h,(hl)			;6d33
	ld l,a			;6d34
	ld a,b			;6d35
	add a,a			;6d36
	call 0405bh		;6d37   ; y su valor, de dos en dos
	ld a,(de)			;6d3a
	dec a			;6d3b   ; los valores van desde 1
	ld c,a			;6d3c
	ld a,c			;6d3d
	cp 0ffh		;6d3e   ; el 0xFF es la casilla vacia
	jp z,borra_una_casilla		;6d40
	ld a,0b2h		;6d43   ; los dibujos empiezan en el 0xB2...
	sla c		;6d45   ; ...y van de cuatro en cuatro
	sla c		;6d47
	add a,c			;6d49
	ld c,a			;6d4a
pinta_los_cuatro_caracteres:
	ld a,c			;6d4b
	call 0004dh		;6d4c   ; BIOS WRTVRM - Writes data in VRAM | el de arriba a la izquierda
	inc hl			;6d4f
	inc c			;6d50
	ld a,c			;6d51
	call 0004dh		;6d52   ; BIOS WRTVRM - Writes data in VRAM | el de arriba a la derecha
	ld a,01fh		;6d55   ; 0x1F mas el `inc hl`: una fila entera
	call 04056h		;6d57   ; banco 0: a_mas_hl
	inc c			;6d5a
	ld a,c			;6d5b
	call 0004dh		;6d5c   ; BIOS WRTVRM - Writes data in VRAM | el de abajo a la izquierda
	inc hl			;6d5f
	inc c			;6d60
	ld a,c			;6d61
	jp 0004dh		;6d62   ; BIOS WRTVRM - Writes data in VRAM | y el de abajo a la derecha
borra_una_casilla:
	xor a			;6d65
	call 0004dh		;6d66   ; BIOS WRTVRM - Writes data in VRAM | cuatro ceros en cuadro: casilla vacia
	inc hl			;6d69
	xor a			;6d6a
	call 0004dh		;6d6b   ; BIOS WRTVRM - Writes data in VRAM
	ld a,01fh		;6d6e   ; la fila de abajo
	call 04056h		;6d70   ; banco 0: a_mas_hl
	xor a			;6d73
	call 0004dh		;6d74   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6d77
	xor a			;6d78
	jp 0004dh		;6d79   ; BIOS WRTVRM - Writes data in VRAM
pinta_una_casilla_traducida:
	ld a,c			;6d7c
	call apunta_el_caracter_en_0xB380		;6d7d   ; la misma cuenta, pero cada caracter pasa antes por 0x6FB8
	call 0004dh		;6d80   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6d83
	inc c			;6d84
	ld a,c			;6d85
	call apunta_el_caracter_en_0xB380		;6d86
	call 0004dh		;6d89   ; BIOS WRTVRM - Writes data in VRAM
	ld a,01fh		;6d8c
	call 04056h		;6d8e   ; banco 0: a_mas_hl
	inc c			;6d91
	ld a,c			;6d92
	call apunta_el_caracter_en_0xB380		;6d93
	call 0004dh		;6d96   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6d99
	inc c			;6d9a
	ld a,c			;6d9b
	call apunta_el_caracter_en_0xB380		;6d9c
	jp 0004dh		;6d9f   ; BIOS WRTVRM - Writes data in VRAM
borra_una_casilla_traducida:
	xor a			;6da2
	call apunta_el_caracter_en_0xB380		;6da3
	call 0004dh		;6da6   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6da9
	xor a			;6daa
	call apunta_el_caracter_en_0xB380		;6dab
	call 0004dh		;6dae   ; BIOS WRTVRM - Writes data in VRAM
	ld a,01fh		;6db1
	call 04056h		;6db3   ; banco 0: a_mas_hl
	xor a			;6db6
	call apunta_el_caracter_en_0xB380		;6db7
	call 0004dh		;6dba   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6dbd
	xor a			;6dbe
	call apunta_el_caracter_en_0xB380		;6dbf
	jp 0004dh		;6dc2   ; BIOS WRTVRM - Writes data in VRAM

; ----------------------------------------------------------------------
; DATOS seis_direcciones_de_nombres: seis palabras, direcciones de la tabla de
;   nombres (0x3987, 0x398A...): p01:6D2B coge la de B y p01:6DD6 las recorre
;   las seis
;   0x6dc5..0x6dd1  (12 bytes)
DATA_seis_direcciones_de_nombres:
	defb 087h,039h	; 6dc5
	defb 08ah,039h	; 6dc7
	defb 08dh,039h	; 6dc9
	defb 091h,039h	; 6dcb
	defb 094h,039h	; 6dcd
	defb 097h,039h	; 6dcf

; ======================================================================
; CODIGO 0x6dd1..0x6fd5  (516 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; REPASAR LAS SEIS CASILLAS. Los seis valores estan en 0xE101 y siguientes, de dos en dos, y las seis direcciones de pantalla en 0x6DC5. Lo que se pinta cae dos filas por debajo de la direccion de la tabla, que es lo que suma el 0x40 de 0x6DE9.
; ----------------------------------------------------------------------
repasa_las_seis_casillas:
	ld de,0e101h		;6dd1   ; los seis valores
	ld b,006h		;6dd4   ; seis
	ld hl,06dc5h		;6dd6   ; y las seis direcciones
repasa_una_casilla_vuelta:
	push bc			;6dd9
	call pinta_una_de_las_seis		;6dda
	inc hl			;6ddd
	inc de			;6dde   ; los valores van de dos en dos
	inc de			;6ddf
	pop bc			;6de0
	djnz repasa_una_casilla_vuelta		;6de1
	ret			;6de3
pinta_una_de_las_seis:
	ld a,(hl)			;6de4   ; su direccion de pantalla
	inc hl			;6de5
	push hl			;6de6
	ld h,(hl)			;6de7
	ld l,a			;6de8
	ld a,040h		;6de9   ; dos filas mas abajo
	call 04056h		;6deb   ; banco 0: a_mas_hl
	ld a,(de)			;6dee   ; su valor
	or a			;6def   ; a cero, casilla vacia
	jr z,deja_la_casilla_vacia		;6df0
	ld b,001h		;6df2
	push de			;6df4
	call 09417h		;6df5   ; banco 2: y si no, a pintarlo
	pop de			;6df8
	pop hl			;6df9
	ret			;6dfa
deja_la_casilla_vacia:
	xor a			;6dfb
	call 0004dh		;6dfc   ; BIOS WRTVRM - Writes data in VRAM | dos ceros arriba...
	inc hl			;6dff
	xor a			;6e00
	call 0004dh		;6e01   ; BIOS WRTVRM - Writes data in VRAM | ...y el segundo
	pop hl			;6e04
	ret			;6e05
el_marcador_por_uno_de_los_dos_puentes:
	ld de,0b124h		;6e06
	ld a,(0e134h)		;6e09   ; segun 0xE134, por un puente o por el otro
	and a			;6e0c
	jp z,L_7E11		;6e0d
	jp L_7DF7		;6e10
si_el_marcador_esta_a_cero:
	ld hl,(0e089h)		;6e13   ; el marcador
	ld a,l			;6e16
	or h			;6e17
	ret nz			;6e18   ; si no esta a cero, nada
	xor a			;6e19
	ld (0e134h),a		;6e1a   ; y si lo esta, 0xE134 tambien
	ret			;6e1d

; ----------------------------------------------------------------------
; LA TIENDA. Tres juegos de guiones distintos segun el modo del juego (0xE0A2 = 3, 4 u otro), y cada uno con su efecto de fondo. Monta la pantalla con los bancos 10 y 11 puestos, pinta el guion de 0xB12E y devuelve los bancos 2 y 3. A partir de ahi, izquierda y derecha mueven el cursor y el disparo compra.
; ----------------------------------------------------------------------
la_tienda:
	ld a,(0e11dh)		;6e1e   ; ¿ya se esta cerrando?
	and a			;6e21
	jp nz,la_tienda_espera_a_cerrarse		;6e22
	ld a,(0e158h)		;6e25   ; ¿o ya se ha comprado?
	and a			;6e28
	jp nz,la_tienda_se_cierra		;6e29
	ld a,(0e0a2h)		;6e2c   ; el modo del juego
	ld de,0b038h		;6e2f   ; los dos guiones y el efecto del modo 3...
	ld hl,0b094h		;6e32
	ld b,09bh		;6e35
	sub 003h		;6e37
	jr z,L_6E4E		;6e39
	ld de,0b065h		;6e3b   ; ...los del 4...
	ld hl,0b0beh		;6e3e
	ld b,09eh		;6e41
	dec a			;6e43
	jr z,L_6E4E		;6e44
	ld de,0b0ddh		;6e46   ; ...y los de los demas
	ld hl,0b105h		;6e49
	ld b,09bh		;6e4c
L_6E4E:
	ld (0e119h),de		;6e4e   ; guardados los dos guiones...
	ld (0e11bh),hl		;6e52
	ld a,b			;6e55
	ld (0e10dh),a		;6e56   ; ...y el efecto
	call L_7DF7		;6e59
	call pon_los_bancos_10_y_11		;6e5c
	ld de,0b12eh		;6e5f   ; el guion de la tienda
	call 04381h		;6e62   ; banco 0: y a pintarlo
	call pon_los_bancos_2_y_3		;6e65   ; devueltos los bancos 2 y 3
	ld a,(0e006h)		;6e68   ; las teclas
	ld c,a			;6e6b
	and 010h		;6e6c   ; el disparo compra
	jr nz,comprar		;6e6e

; ----------------------------------------------------------------------
; MOVER EL CURSOR. El bit 3 del mando lo lleva a la derecha y el bit 2 a la izquierda; si de verdad ha cambiado de casilla suena el efecto 0x23. Borra los dos caracteres de donde estaba y pinta el 0x44 y el 0x45 donde esta ahora.
; ----------------------------------------------------------------------
mueve_el_cursor_de_la_tienda:
	ld a,(0e10ch)		;6e70   ; en que casilla esta
	ld hl,07005h		;6e73   ; las seis posiciones del cursor
	call 04055h		;6e76   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;6e79
	inc hl			;6e7a
	ld d,(hl)			;6e7b
	ld a,(0e10ch)		;6e7c   ; la casilla otra vez
	ld hl,0e128h		;6e7f
	bit 3,c		;6e82   ; el bit 3: a la derecha
	ld (hl),000h		;6e84
	jr nz,L_6E90		;6e86
	bit 2,c		;6e88   ; el bit 2: a la izquierda
	ret z			;6e8a   ; y sin ninguno de los dos, no se mueve
	ld (hl),001h		;6e8b
	dec a			;6e8d
	jr L_6E91		;6e8e
L_6E90:
	inc a			;6e90
L_6E91:
	call mueve_el_cursor_por_las_casillas		;6e91
	ld hl,0e10ch		;6e94
	cp (hl)			;6e97   ; ¿ha cambiado de casilla?
	ld (hl),a			;6e98
	jr z,pinta_el_cursor		;6e99
	ld a,023h		;6e9b   ; si ha cambiado, el efecto 0x23
	call 0413ah		;6e9d   ; banco 0: pide_sonido_si_esta_activo
pinta_el_cursor:
	ld a,(0e10ch)		;6ea0   ; la casilla de ahora
	ld hl,07005h		;6ea3   ; y su posicion
	call 04055h		;6ea6   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;6ea9
	inc hl			;6eaa
	ld h,(hl)			;6eab
	ld l,a			;6eac
borra_y_pinta_el_cursor:
	ex de,hl			;6ead
	xor a			;6eae
	call 0004dh		;6eaf   ; BIOS WRTVRM - Writes data in VRAM | dos ceros donde estaba
	xor a			;6eb2
	inc hl			;6eb3
	call 0004dh		;6eb4   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;6eb7
	ld c,044h		;6eb8   ; y el 0x44 y el 0x45 donde esta
	ld a,c			;6eba
	call 0004dh		;6ebb   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6ebe
	ld a,c			;6ebf
	inc a			;6ec0
	jp 0004dh		;6ec1   ; BIOS WRTVRM - Writes data in VRAM

; ----------------------------------------------------------------------
; COMPRAR. La casilla 6 deja el aviso 2 y la 7 cierra la tienda; las demas cuestan lo que diga su segundo byte, restado EN BCD del marcador. Si no llega el dinero suena el efecto 0x25 y no pasa nada mas. Si llega, la casilla se borra -sus dos bytes a cero-, se repinta vacia y el banco 3 se queda con el objeto.
; ----------------------------------------------------------------------
comprar:
	ld a,(0e10ch)		;6ec4   ; en que casilla esta
	cp 006h		;6ec7   ; la 6 solo deja el aviso 2...
	jp z,deja_el_aviso_2		;6ec9
	cp 007h		;6ecc   ; ...y la 7 cierra la tienda
	jp z,la_tienda_se_cierra		;6ece
	ld hl,0e101h		;6ed1   ; las seis casillas, de dos en dos
	call 04055h		;6ed4   ; banco 0: dos_por_a_mas_hl
	ld c,(hl)			;6ed7   ; lo que cuesta
	ld d,001h		;6ed8   ; y el 1 que se lleva al byte alto si hay que pedir prestado
	ld ix,0e089h		;6eda   ; el dinero es el marcador
	call resta_en_bcd_de_dos_bytes		;6ede   ; a ver si llega
	jr c,no_llega_el_dinero		;6ee1   ; si no llega, nada
	dec hl			;6ee3   ; atras, a que es
	ld a,(0e10ch)		;6ee4
	ld b,a			;6ee7
	ld a,(hl)			;6ee8   ; lo que se lleva
	ld c,a			;6ee9
	dec c			;6eea
	push bc			;6eeb
	push hl			;6eec
	call 0ba2fh		;6eed   ; banco 3: y ahi se apunta
	pop hl			;6ef0
	ld (hl),000h		;6ef1   ; la casilla, vacia
	inc hl			;6ef3
	ld (hl),000h		;6ef4
	ld de,0e100h		;6ef6
	pop bc			;6ef9
	call pinta_una_casilla		;6efa   ; y repintada
	call repasa_las_seis_casillas		;6efd
	call 0947bh		;6f00   ; banco 2
	call si_el_marcador_esta_a_cero		;6f03
	call el_marcador_por_uno_de_los_dos_puentes		;6f06
	ld a,(0e0a2h)		;6f09   ; el modo en el que esta el juego
	cp 005h		;6f0c
	jr z,la_tienda_se_cierra_del_todo		;6f0e
	ld c,008h		;6f10
	jp mueve_el_cursor_de_la_tienda		;6f12
la_tienda_se_cierra_del_todo:
	xor a			;6f15
	ld (0e134h),a		;6f16   ; sin marcador que pintar
	call borra_las_seis_casillas		;6f19   ; las seis casillas, vacias
	ld c,008h		;6f1c   ; el cursor, a la casilla 8
	call mueve_el_cursor_de_la_tienda		;6f1e
	call repinta_la_tienda_entera		;6f21
	ld a,001h		;6f24   ; y marcada como comprada
	ld (0e158h),a		;6f26
la_tienda_se_cierra:
	ld a,(0e051h)		;6f29   ; se espera a que se calle el efecto
	and a			;6f2c
	ret nz			;6f2d
	ld de,(0e119h)		;6f2e   ; el primero de los dos guiones
	call L_7E11		;6f32
	ld de,(0e11bh)		;6f35   ; y el segundo
	call L_7DF7		;6f39
	ld a,(0e10dh)		;6f3c   ; con el efecto del modo
	call 0413ah		;6f3f   ; banco 0: pide_sonido_si_esta_activo
	ld a,001h		;6f42
	ld (0e11dh),a		;6f44   ; ya se esta cerrando
	ld a,080h		;6f47   ; y 0x80 cuadros de espera
	ld (0e159h),a		;6f49
la_tienda_espera_a_cerrarse:
	ld hl,0e159h		;6f4c
	dec (hl)			;6f4f   ; se descuenta la espera
	ret nz			;6f50
	ld a,001h		;6f51
	ld (0e096h),a		;6f53   ; y al acabarse, el aviso 1
	ret			;6f56
no_llega_el_dinero:
	ld a,025h		;6f57   ; el efecto 0x25 y ya
	jp 0413ah		;6f59   ; banco 0: pide_sonido_si_esta_activo
pon_los_bancos_2_y_3:
	di			;6f5c   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;6f5d
	ld (08000h),a		;6f5f   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;6f62   ; y en su copia de RAM
	ei			;6f65   ; el mapa ya esta entero
	di			;6f66   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;6f67
	ld (0a000h),a		;6f69   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;6f6c   ; y en su copia de RAM
	ei			;6f6f   ; el mapa ya esta entero
	ret			;6f70
pon_los_bancos_10_y_11:
	di			;6f71   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;6f72
	ld (08000h),a		;6f74   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;6f77   ; y en su copia de RAM
	ei			;6f7a   ; el mapa ya esta entero
	di			;6f7b   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;6f7c
	ld (0a000h),a		;6f7e   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;6f81   ; y en su copia de RAM
	ei			;6f84   ; el mapa ya esta entero
	ret			;6f85

; ----------------------------------------------------------------------
; RESTAR EN BCD DE DOS BYTES. IX apunta al numero y C es lo que se le quita. OJO CON LA D: no es el byte alto del importe, es lo que se le resta al byte alto CUANDO HAY QUE PEDIR PRESTADO, y vale 1 en todas las llamadas -o sea que es el acarreo a mano, que es lo que hace falta porque `daa` no se lleva bien con `sbc`-. Si el resultado sale negativo vuelve con el acarreo puesto y SIN tocar nada, que es como se sabe que no llega el dinero.
; ----------------------------------------------------------------------
resta_en_bcd_de_dos_bytes:
	ld a,(ix+000h)		;6f86   ; el numero
	sub c			;6f89
	daa			;6f8a   ; EN BCD: por eso el `daa`
	ld c,a			;6f8b
	jr nc,guarda_el_byte_bajo		;6f8c   ; ¿hizo falta pedir prestado?
	ld a,(ix+001h)		;6f8e   ; entonces se le quita la D al byte alto
	sub d			;6f91
	daa			;6f92
	ret c			;6f93   ; y si tampoco llega, se vuelve sin tocar nada
	ld (ix+001h),a		;6f94
guarda_el_byte_bajo:
	ld a,c			;6f97
	ld (ix+000h),a		;6f98
	ret			;6f9b

; ----------------------------------------------------------------------
; SUMAR EN BCD DE DOS BYTES. La pareja de la anterior, con la misma D de acarreo a mano: si se desborda, vuelve con el acarreo puesto y sin guardar.
; ----------------------------------------------------------------------
suma_en_bcd_de_dos_bytes:
	ld a,(ix+000h)		;6f9c   ; el numero
	add a,c			;6f9f
	daa			;6fa0   ; EN BCD
	ld c,a			;6fa1
	jr nc,guarda_el_byte_bajo		;6fa2   ; ¿se ha llevado una?
	ld a,(ix+001h)		;6fa4   ; entonces se le suma la D al byte alto
	add a,d			;6fa7
	daa			;6fa8
	ret c			;6fa9   ; y si se desborda, no se guarda
	ld (ix+001h),a		;6faa
	ld a,c			;6fad
	ld (ix+000h),a		;6fae
	ret			;6fb1
deja_el_aviso_2:
	ld a,002h		;6fb2
	ld (0e096h),a		;6fb4   ; los avisos que deja el cuadro
	ret			;6fb7
apunta_el_caracter_en_0xB380:
	push hl			;6fb8
	push de			;6fb9
	ld de,0b380h		;6fba   ; la tabla de 0xB380
	and a			;6fbd
	adc hl,de		;6fbe   ; el caracter que sea...
	ld (hl),a			;6fc0   ; ...apuntado en su casilla
	pop de			;6fc1
	pop hl			;6fc2
	ret			;6fc3
borra_las_seis_casillas:
	call si_el_marcador_esta_a_cero		;6fc4
	ld hl,0e100h		;6fc7   ; los doce bytes de las seis casillas
	ld de,0e101h		;6fca
	ld (hl),000h		;6fcd
	ld bc,0000bh		;6fcf   ; a cero
	ldir		;6fd2
	ret			;6fd4

; ----------------------------------------------------------------------
; DATOS tablas_de_IX_por_modo: tres tablas de 16 bytes, una por modo (0xE0A2 =
;   3, 4 u otro): p01:6CC9, 6CD4 y 6CDB ponen IX en 0x6FD5, 0x6FE5 o 0x6FF5, y
;   p01:6D04 lee de IX con los indices de las listas del banco 11 (0xAF90)
;   0x6fd5..0x7005  (48 bytes)
DATA_tablas_de_IX_por_modo:
	defb 019h,015h,010h,008h,012h,013h,017h,020h,018h,022h,011h,014h,021h,000h,000h,023h	; 6fd5  ....... ."..!..#
	defb 038h,030h,020h,016h,024h,026h,032h,040h,036h,044h,022h,028h,042h,000h,000h,046h	; 6fe5  80 .$&2@6D"(B..F
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6ff5  ................

; ----------------------------------------------------------------------
; DATOS ocho_punteros_E10C: ocho palabras que p01:6E73 y p01:6EA3 indexan con
;   (0xE10C)
;   0x7005..0x7015  (16 bytes)
DATA_ocho_punteros_E10C:
	defb 0e7h,039h	; 7005
	defb 0eah,039h	; 7007
	defb 0edh,039h	; 7009
	defb 0f1h,039h	; 700b
	defb 0f4h,039h	; 700d
	defb 0f7h,039h	; 700f
	defb 085h,03ah	; 7011
	defb 098h,03ah	; 7013

; ======================================================================
; CODIGO 0x7015..0x7085  (112 bytes)
; ======================================================================


L_7015:
	ld hl,(0e301h)		;7015   ; la distancia a la que toca el objeto siguiente
	ld a,(0e300h)		;7018   ; por que pareja del guion de la fase va
	push hl			;701b
	ld hl,0e280h		;701c
	ld de,0e281h		;701f
	ld bc,0017eh		;7022
	ld (hl),000h		;7025
	ldir		;7027
	pop hl			;7029
	ld (0e301h),hl		;702a   ; la distancia a la que toca el objeto siguiente
	ld (0e300h),a		;702d   ; por que pareja del guion de la fase va
	call L_6323		;7030
	ld a,013h		;7033
	ld (0e203h),a		;7035   ; el ESTADO de lo que se maneja
	ld a,0c0h		;7038
	ld (0e204h),a		;703a   ; la Y en la pantalla de lo que se maneja
	call L_7DD5		;703d
	ld a,(0e0aah)		;7040
	ld (0e205h),a		;7043   ; la X en la pantalla de lo que se maneja
	xor a			;7046
	ld (0e0aah),a		;7047
	ld (0e201h),a		;704a
	ld (0e202h),a		;704d
	ld (0e0a2h),a		;7050   ; el modo en el que esta el juego
	ld (0e0a3h),a		;7053
	jp L_62A4		;7056
L_7059:
	ld a,(0e203h)		;7059   ; el ESTADO de lo que se maneja
	cp 010h		;705c
	ret z			;705e
	ld hl,0e440h		;705f
	ld b,005h		;7062
	xor a			;7064
	ld (0e0e3h),a		;7065   ; que hueco de sprite toca
repasa_las_cinco_ranuras_de_0xE440:
	ld a,(hl)			;7068   ; ¿lleva algo esta ranura?
	and a			;7069
	push hl			;706a
	push bc			;706b
	call nz,L_707C		;706c   ; si lleva, se atiende
	pop bc			;706f
	ld hl,0e0e3h		;7070
	inc (hl)			;7073
	pop hl			;7074
	ld a,010h		;7075
	add a,l			;7077
	ld l,a			;7078
	djnz repasa_las_cinco_ranuras_de_0xE440		;7079
	ret			;707b
L_707C:
	push hl			;707c
	pop ix		;707d
	inc l			;707f
	ld a,(hl)			;7080
	dec a			;7081
	call 04060h		;7082   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_7082: 38 punteros pegados detras del `call despacha` de
;   p01:7082: la rutina de cada clase de objeto, indexada con (ix+1) - 1.
;   Varias clases comparten rutina
;   0x7085..0x70d1  (76 bytes)
DATA_despacho_de_7082:
	defb 0d1h,070h	; 7085
	defb 0d1h,070h	; 7087
	defb 027h,071h	; 7089
	defb 027h,071h	; 708b
	defb 027h,071h	; 708d
	defb 005h,072h	; 708f
	defb 005h,072h	; 7091
	defb 042h,072h	; 7093
	defb 042h,072h	; 7095
	defb 0c4h,072h	; 7097
	defb 0c4h,072h	; 7099
	defb 017h,073h	; 709b
	defb 017h,073h	; 709d
	defb 0a3h,073h	; 709f
	defb 0a3h,073h	; 70a1
	defb 0a3h,073h	; 70a3
	defb 0a4h,073h	; 70a5
	defb 0a4h,073h	; 70a7
	defb 0fbh,073h	; 70a9
	defb 0fbh,073h	; 70ab
	defb 04ah,074h	; 70ad
	defb 04ah,074h	; 70af
	defb 04ah,074h	; 70b1
	defb 04ah,074h	; 70b3
	defb 04ah,074h	; 70b5
	defb 0a5h,074h	; 70b7
	defb 0a5h,074h	; 70b9
	defb 0a5h,074h	; 70bb
	defb 0a5h,074h	; 70bd
	defb 0a5h,074h	; 70bf
	defb 0a5h,074h	; 70c1
	defb 030h,075h	; 70c3
	defb 030h,075h	; 70c5
	defb 030h,075h	; 70c7
	defb 030h,075h	; 70c9
	defb 030h,075h	; 70cb
	defb 030h,075h	; 70cd
	defb 030h,075h	; 70cf

; ======================================================================
; CODIGO 0x70d1..0x711f  (78 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; CAERSE POR UN HUECO (LAS VARIANTES 3, 4 Y 5). Es la mas larga de la familia porque tiene tres salidas distintas: si no se lleva nada, se pierde la vida -estado 0x15, o 0x16 en los decorados 4 y 5, y el efecto 0x8C-; si 0xE1F1 esta puesto, se salva, la variante del hueco sube 0x1D y caen 768 puntos; y si lo que esta puesto es 0xE171, se entra al hueco de verdad, que es lo que lleva al estado 3, 8 o 10 segun el decorado. En los decorados 4, 5 y 7 esta rutina no cuenta.
; ----------------------------------------------------------------------
caerse_por_un_hueco:
	ld a,(ix+002h)		;70d1   ; la clase del objeto
	cp 00eh		;70d4   ; la 14 son los huecos
	ret nz			;70d6
	ld a,(0e0a1h)		;70d7   ; el DECORADO, de 0 a 9
	cp 004h		;70da   ; en el decorado 4...
	ret z			;70dc
	cp 005h		;70dd   ; ...en el 5...
	ret z			;70df
	cp 007h		;70e0   ; ...y en el 7 no hay nada de esto
	ret z			;70e2
	ld a,(0e203h)		;70e3   ; el ESTADO de lo que se maneja
	cp 003h		;70e6   ; y en el estado 3 tampoco
	ret z			;70e8
	ld a,(ix+001h)		;70e9   ; la variante del hueco
	dec a			;70ec
	ld hl,0711fh		;70ed   ; la primera ventana...
	jr z,L_70F5		;70f0
	ld hl,07123h		;70f2   ; ...o la segunda
L_70F5:
	ld a,(0e205h)		;70f5   ; la X en la pantalla de lo que se maneja
	cp (hl)			;70f8   ; por debajo de la ventana, fuera
	ret c			;70f9
	inc hl			;70fa
	cp (hl)			;70fb   ; y por encima, tambien
	ret nc			;70fc
	inc hl			;70fd
	ld a,(0e204h)		;70fe   ; la tercera medida es el punto medio
	cp (hl)			;7101
	ret c			;7102
	inc hl			;7103
	ld a,(0e205h)		;7104   ; y de que lado cae decide el bit 7
	cp (hl)			;7107
	ld a,000h		;7108
	jr c,L_710E		;710a
	ld a,080h		;710c
L_710E:
	ld (0e20bh),a		;710e   ; por que lado se ha entrado
	call esconde_los_sprites_4_y_5		;7111
	ld a,(0e203h)		;7114   ; el ESTADO de lo que se maneja
	cp 011h		;7117   ; en el estado 0x11...
	call z,09ecfh		;7119   ; ...hay que avisar al banco 2
	jp y_al_estado_3		;711c

; ----------------------------------------------------------------------
; DATOS ventanas_711F: dos entradas de 4 bytes que p01:70ED escoge con (ix+1):
;   la X de lo que se maneja (0xE205) tiene que caer entre las dos primeras
;   (`cp (hl) / ret c / inc hl / cp (hl) / ret nc`) y el resto se sigue
;   comparando
;   0x711f..0x7127  (8 bytes)
DATA_ventanas_711F:
	defb 020h,050h,088h,001h	; 711f
	defb 090h,0c0h,088h,0ffh	; 7123

; ======================================================================
; CODIGO 0x7127..0x71e1  (186 bytes)
; ======================================================================


caerse_por_un_hueco_variantes_del_medio:
	ld a,(ix+002h)		;7127   ; la clase del objeto
	cp 00eh		;712a   ; la 14 son los huecos
	ret nz			;712c
	ld a,(0e203h)		;712d   ; el ESTADO de lo que se maneja
	cp 003h		;7130   ; en el 3 ya se esta dentro
	ret z			;7132
	cp 008h		;7133   ; en el 8...
	ret z			;7135
	cp 00ah		;7136   ; ...y en el 10, tampoco
	ret z			;7138
	ld a,(ix+001h)		;7139   ; la variante
	sub 003h		;713c
	ld hl,071e1h		;713e   ; la ventana de la primera...
	jr z,mira_la_ventana_de_doce		;7141
	dec a			;7143
	ld hl,071edh		;7144   ; ...la de la segunda...
	jr z,mira_la_ventana_de_doce		;7147
	ld hl,071f9h		;7149   ; ...o la de la tercera
mira_la_ventana_de_doce:
	ld a,(0e205h)		;714c   ; la columna del jugador
	cp (hl)			;714f   ; por debajo de la ventana, fuera
	ret c			;7150
	inc hl			;7151
	cp (hl)			;7152   ; y por encima, tambien
	ret nc			;7153
	inc hl			;7154
	ld d,(hl)			;7155   ; el punto medio, guardado para luego
	inc hl			;7156
	cp (hl)			;7157   ; y ahora cuatro cortes seguidos, que van dando la fila que hace falta...
	inc hl			;7158
	jr c,L_716B		;7159   ; ...y el primero que se pase manda
	inc hl			;715b
	cp (hl)			;715c
	inc hl			;715d
	jr c,L_716B		;715e
	inc hl			;7160
	cp (hl)			;7161
	inc hl			;7162
	jr nc,L_716B		;7163
	inc hl			;7165
	cp (hl)			;7166
	inc hl			;7167
	jr nc,L_716B		;7168
	inc hl			;716a
L_716B:
	ld a,(0e204h)		;716b   ; la fila del jugador
	cp (hl)			;716e   ; si no llega, no ha caido
	ret c			;716f
	ld a,(0e1f1h)		;7170   ; ¿lleva lo de 0xE1F1?
	and a			;7173
	jr nz,con_lo_de_0xE1F1_se_salva		;7174
	ld a,(0e171h)		;7176   ; ¿y lo de 0xE171?
	and a			;7179
	jr nz,con_lo_de_0xE171_se_entra		;717a
	xor a			;717c   ; sin nada de eso, se acabo la fase
	ld (0e21dh),a		;717d   ; por que paso va la secuencia
	ld (0e097h),a		;7180   ; la bandera de que la fase se ha acabado
	ld a,(0e0a1h)		;7183   ; el decorado
	ld c,016h		;7186   ; en el 4 y en el 5 se pierde con el estado 0x16...
	cp 004h		;7188
	jr z,L_7192		;718a
	cp 005h		;718c
	jr z,L_7192		;718e
	ld c,015h		;7190   ; ...y en el resto con el 0x15
L_7192:
	ld a,c			;7192
	ld (0e203h),a		;7193   ; el ESTADO de lo que se maneja
	ld a,08ch		;7196   ; y el efecto 0x8C, el de perder
	jp 0413ah		;7198   ; banco 0: pide_sonido_si_esta_activo
con_lo_de_0xE1F1_se_salva:
	ld a,(ix+001h)		;719b   ; la variante del hueco
	add a,01dh		;719e   ; sube 0x1D: el hueco pasa a ser otra cosa
	ld (ix+001h),a		;71a0
	ld a,01ah		;71a3   ; el efecto 0x1A
	call 0413ah		;71a5   ; banco 0: pide_sonido_si_esta_activo
	ld de,00300h		;71a8   ; y 768 puntos
	jp 09367h		;71ab   ; banco 2
con_lo_de_0xE171_se_entra:
	ld a,(0e205h)		;71ae   ; la columna del jugador
	cp d			;71b1   ; contra el punto medio de antes
	ld a,000h		;71b2   ; por la izquierda...
	jr c,L_71B8		;71b4
	ld a,080h		;71b6   ; ...o por la derecha
L_71B8:
	ld (0e20bh),a		;71b8   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	ld a,(0e0a1h)		;71bb   ; el decorado
	cp 007h		;71be
	ld c,00ah		;71c0   ; en el 7 se va al estado 10...
	jr z,L_71D5		;71c2
	cp 004h		;71c4
	ld c,008h		;71c6   ; ...en el 4 y en el 5 al 8...
	jr z,L_71D0		;71c8
	cp 005h		;71ca
	jr z,L_71D0		;71cc
	ld c,003h		;71ce   ; ...y en el resto al 3
L_71D0:
	push bc			;71d0
	call 09ecfh		;71d1   ; banco 2: aviso
	pop bc			;71d4
L_71D5:
	push bc			;71d5
	call 09485h		;71d6   ; banco 2: y el otro aviso
	pop bc			;71d9
	ld a,c			;71da
	ld (0e203h),a		;71db   ; el estado que toque
	jp esconde_los_sprites_4_y_5		;71de

; ----------------------------------------------------------------------
; DATOS ventanas_71E1: tres entradas de 12 bytes que p01:713E escoge con
;   (ix+1) - 3; empiezan por la ventana de X contra (0xE205), como las de
;   0x711F
;   0x71e1..0x7205  (36 bytes)
DATA_ventanas_71E1:
	defb 056h,090h,070h,05dh,080h,060h,07bh,088h,080h,07dh,07bh,075h	; 71e1  V.p].`{..}{u
	defb 001h,030h,001h,001h,080h,001h,07bh,028h,080h,01dh,07bh,075h	; 71ed  .0....{(..{u
	defb 0b6h,0f0h,0ffh,0bdh,080h,0c0h,07bh,0e8h,080h,0ddh,07bh,075h	; 71f9  ......{...{u

; ======================================================================
; CODIGO 0x7205..0x723c  (55 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; CAERSE POR UN HUECO (LAS VARIANTES 6 Y 7). La version corta: una ventana de tres bytes -principio, final y punto medio-, sin fila que valga y sin salvarse de ninguna manera. Cae dentro y al estado 3. Y solo cuenta si el estado es cero: aqui no se entra ni saltando ni cayendo.
; ----------------------------------------------------------------------
caerse_por_un_hueco_6_y_7:
	ld a,(ix+002h)		;7205   ; la clase del objeto
	cp 00eh		;7208   ; la 14 son los huecos
	ret nz			;720a
	ld a,(0e203h)		;720b   ; el ESTADO de lo que se maneja
	cp 003h		;720e   ; en el 3 ya se esta dentro
	ret z			;7210
	cp 00fh		;7211   ; y en el 15 tampoco
	ret z			;7213
	and a			;7214   ; solo con el estado a cero
	ret nz			;7215
	ld a,(ix+001h)		;7216   ; la variante
	sub 006h		;7219
	ld hl,0723ch		;721b   ; la ventana de la 6...
	jr z,mira_la_ventana_de_tres		;721e
	ld hl,0723fh		;7220   ; ...o la de la 7
mira_la_ventana_de_tres:
	ld a,(0e205h)		;7223   ; la columna del jugador
	cp (hl)			;7226   ; por debajo, fuera
	ret c			;7227
	inc hl			;7228
	cp (hl)			;7229   ; por encima, fuera
	ret nc			;722a
	inc hl			;722b
	cp (hl)			;722c   ; y contra el punto medio...
	ld a,000h		;722d   ; ...a la izquierda...
	jr c,L_7233		;722f
	ld a,080h		;7231   ; ...o a la derecha
L_7233:
	ld (0e20bh),a		;7233   ; por que lado se ha entrado
	ld a,003h		;7236   ; y dentro: el estado 3
	ld (0e203h),a		;7238   ; el ESTADO de lo que se maneja
	ret			;723b

; ----------------------------------------------------------------------
; DATOS ventanas_723C: dos entradas de 3 bytes que p01:721B escoge con (ix+1)
;   - 6, contra la X (0xE205)
;   0x723c..0x7242  (6 bytes)
DATA_ventanas_723C:
	defb 018h,058h,038h	; 723c
	defb 088h,0c8h,0a8h	; 723f

; ======================================================================
; CODIGO 0x7242..0x72bc  (122 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; CAERSE POR UN HUECO (LAS VARIANTES 8 Y 9). Como la de 0x70D1 pero con una ventana de cuatro bytes: principio, final, punto medio y la fila a partir de la cual cuenta. Aqui la salvacion es 0xE1F1 -que sube la variante 0x1B y da 768 puntos- y la entrada de verdad es 0xE172. Perder es siempre el estado 0x15.
; ----------------------------------------------------------------------
caerse_por_un_hueco_8_y_9:
	ld a,(ix+002h)		;7242   ; la clase del objeto
	cp 00eh		;7245   ; la 14 son los huecos
	ret nz			;7247
	ld a,(0e203h)		;7248   ; el ESTADO de lo que se maneja
	cp 003h		;724b   ; en el 3 ya se esta dentro
	ret z			;724d
	ld a,(ix+001h)		;724e   ; la variante
	sub 008h		;7251
	ld hl,072bch		;7253   ; la ventana de la 8...
	jr z,mira_la_ventana_de_cuatro		;7256
	ld hl,072c0h		;7258   ; ...o la de la 9
mira_la_ventana_de_cuatro:
	ld a,(0e205h)		;725b   ; la columna del jugador
	cp (hl)			;725e   ; por debajo, fuera
	ret c			;725f
	inc hl			;7260
	cp (hl)			;7261   ; por encima, fuera
	ret nc			;7262
	inc hl			;7263
	ld d,(hl)			;7264   ; el punto medio, guardado
	inc hl			;7265
	ld a,(0e204h)		;7266   ; y la fila
	cp (hl)			;7269   ; si no llega, no ha caido
	ret c			;726a
	ld a,(0e1f1h)		;726b   ; ¿lleva lo de 0xE1F1?
	and a			;726e
	jr nz,con_lo_de_0xE1F1_se_salva_8_y_9		;726f
	ld a,(0e172h)		;7271   ; ¿y lo de 0xE172?
	and a			;7274
	jr nz,con_lo_de_0xE172_se_entra		;7275
	xor a			;7277   ; sin nada de eso, se acabo la fase
	ld (0e21dh),a		;7278   ; por que paso va la secuencia
	ld (0e097h),a		;727b   ; la bandera de que la fase se ha acabado
	ld a,015h		;727e   ; el estado 0x15: perder
	ld (0e203h),a		;7280   ; el ESTADO de lo que se maneja
	ld a,08ch		;7283   ; y el efecto 0x8C
	jp 0413ah		;7285   ; banco 0: pide_sonido_si_esta_activo
con_lo_de_0xE172_se_entra:
	ld a,(0e205h)		;7288   ; la columna del jugador
	cp d			;728b   ; contra el punto medio
	ld a,000h		;728c   ; por la izquierda...
	jr c,L_7292		;728e
	ld a,080h		;7290   ; ...o por la derecha
L_7292:
	ld (0e20bh),a		;7292   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	call 09ecfh		;7295   ; banco 2
	call 09485h		;7298   ; banco 2
	ld a,003h		;729b   ; y dentro: el estado 3
	ld (0e203h),a		;729d   ; el ESTADO de lo que se maneja
esconde_los_sprites_4_y_5:
	ld a,0e0h		;72a0   ; 0xE0 en la fila: fuera de la pantalla
	ld (0ee90h),a		;72a2   ; el hueco de sprite 4
	ld (0ee94h),a		;72a5   ; el hueco de sprite 5
	ret			;72a8
con_lo_de_0xE1F1_se_salva_8_y_9:
	ld a,(ix+001h)		;72a9   ; la variante del hueco
	add a,01bh		;72ac   ; sube 0x1B: el hueco pasa a ser otra cosa
	ld (ix+001h),a		;72ae
	ld a,01ah		;72b1   ; el efecto 0x1A
	call 0413ah		;72b3   ; banco 0: pide_sonido_si_esta_activo
	ld de,00300h		;72b6   ; y 768 puntos
	jp 09367h		;72b9   ; banco 2

; ----------------------------------------------------------------------
; DATOS ventanas_72BC: dos entradas de 4 bytes que p01:7253 escoge con (ix+1)
;   - 8, contra la X (0xE205)
;   0x72bc..0x72c4  (8 bytes)
DATA_ventanas_72BC:
	defb 020h,050h,038h,078h	; 72bc
	defb 090h,0c0h,0a8h,078h	; 72c0

; ======================================================================
; CODIGO 0x72c4..0x730f  (75 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; SUBIRSE A ALGO (LAS VARIANTES 10 Y 11). Otra cosa de la clase 14, y esta no es un hueco: la ventana lleva DOS cortes, y por fuera de ellos se entra de lado -al estado 3- y por dentro se sube encima, que es el estado 0x12. Al subirse se planta en la fila 0x98, el modo del juego pasa a ser el que traiga (ix+4) y se deja el aviso 0x20.
; ----------------------------------------------------------------------
subirse_a_algo:
	ld a,(ix+002h)		;72c4   ; la clase del objeto
	cp 00eh		;72c7
	ret nz			;72c9
	ld a,(0e203h)		;72ca   ; el ESTADO de lo que se maneja
	and a			;72cd   ; solo con el estado a cero
	ret nz			;72ce
	ld a,(ix+001h)		;72cf   ; la variante
	sub 00ah		;72d2
	ld hl,0730fh		;72d4   ; la ventana de la 10...
	jr z,L_72DC		;72d7
	ld hl,07313h		;72d9   ; ...o la de la 11
L_72DC:
	ld a,(0e205h)		;72dc   ; la columna del jugador
	cp (hl)			;72df   ; por debajo, fuera
	ret c			;72e0
	inc hl			;72e1
	cp (hl)			;72e2   ; por encima, fuera
	ret nc			;72e3
	inc hl			;72e4
	cp (hl)			;72e5   ; por delante del primer corte se entra de lado...
	ld c,000h		;72e6
	jp c,entra_de_lado		;72e8
	inc hl			;72eb
	cp (hl)			;72ec   ; ...y por detras del segundo, tambien
	ld c,080h		;72ed
	jp nc,entra_de_lado		;72ef
	ld a,012h		;72f2   ; en medio: el estado 0x12, encima
	ld (0e203h),a		;72f4   ; el ESTADO de lo que se maneja
	ld a,(ix+004h)		;72f7   ; el modo del juego lo trae el objeto
	ld (0e0a2h),a		;72fa   ; el modo en el que esta el juego
	ld l,098h		;72fd   ; la fila 0x98, clavada
	ld a,(0e205h)		;72ff   ; y la columna, la que hubiera
	ld h,a			;7302
	ld (0e204h),hl		;7303   ; la Y en la pantalla de lo que se maneja
	call 0a8dbh		;7306   ; banco 3: y a colocar los cuatro sprites
	ld a,020h		;7309   ; el aviso 0x20
	ld (0e096h),a		;730b   ; los avisos que deja el cuadro
	ret			;730e

; ----------------------------------------------------------------------
; DATOS ventanas_730F: dos entradas de 4 bytes que p01:72D4 escoge con (ix+1)
;   - 0x0A, contra la X (0xE205)
;   0x730f..0x7317  (8 bytes)
DATA_ventanas_730F:
	defb 001h,058h,014h,03ch	; 730f
	defb 090h,0e8h,0a4h,0cch	; 7313

; ======================================================================
; CODIGO 0x7317..0x739b  (132 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; MONTARSE (LAS VARIANTES 12 Y 13). La misma ventana de dos cortes que la de 0x72C4, pero lo que sale de dentro es el estado 4, el que reparte la tabla de sprites de otra manera (p00:42FB). Coloca la figura en la fila 0x98 y le pone debajo los sprites 4 y 5, en la 0xB4, con el color 0x0F o el 9 segun el decorado; suena el efecto 0x0B y se arranca la cuenta de 0xE20E con 0x20.
; ----------------------------------------------------------------------
montarse:
	ld a,(ix+002h)		;7317   ; la clase del objeto
	cp 00eh		;731a
	ret nz			;731c
	ld a,(0e203h)		;731d   ; el ESTADO de lo que se maneja
	and a			;7320   ; solo con el estado a cero
	ret nz			;7321
	ld a,(ix+001h)		;7322   ; la variante
	sub 00ch		;7325
	ld hl,0739bh		;7327   ; la ventana de la 12...
	jr z,L_732F		;732a
	ld hl,0739fh		;732c   ; ...o la de la 13
L_732F:
	ld a,(0e205h)		;732f   ; la X en la pantalla de lo que se maneja
	cp (hl)			;7332   ; por debajo, fuera
	ret c			;7333
	inc hl			;7334
	cp (hl)			;7335   ; por encima, fuera
	ret nc			;7336
	inc hl			;7337
	cp (hl)			;7338   ; por delante del primer corte se entra de lado...
	ld c,000h		;7339
	jr c,entra_de_lado		;733b
	inc hl			;733d
	cp (hl)			;733e   ; ...y por detras del segundo, tambien
	ld c,080h		;733f
	jr nc,entra_de_lado		;7341
	ld a,004h		;7343   ; en medio: el estado 4
	ld (0e203h),a		;7345   ; el ESTADO de lo que se maneja
	ld a,(ix+004h)		;7348   ; dos bytes mas que trae el objeto
	ld (0e215h),a		;734b
	ld a,(ix+005h)		;734e
	ld (0e0d2h),a		;7351
	ld l,098h		;7354   ; la fila 0x98
	ld a,(0e205h)		;7356   ; la X en la pantalla de lo que se maneja
	ld h,a			;7359
	ld (0e204h),hl		;735a   ; la Y en la pantalla de lo que se maneja
	call 0a8dbh		;735d   ; banco 3: los cuatro sprites, colocados
	ld l,0b4h		;7360   ; y debajo, en la fila 0xB4...
	ld a,(0e205h)		;7362   ; la X en la pantalla de lo que se maneja
	ld h,a			;7365
	ld (0ee90h),hl		;7366   ; ...los sprites 4...
	add a,010h		;7369
	ld h,a			;736b
	ld (0ee94h),hl		;736c   ; ...y 5, este dieciseis columnas mas alla
	ld l,04ch		;736f   ; el dibujo 0x4C para los dos
	ld a,(0e0a1h)		;7371   ; el DECORADO, de 0 a 9
	cp 002h		;7374   ; hasta el decorado 2 en blanco...
	ld c,00fh		;7376
	jr c,L_737C		;7378
	ld c,009h		;737a   ; ...y de ahi en adelante en rojo
L_737C:
	ld h,c			;737c
	ld (0ee92h),hl		;737d   ; a los dos sprites
	ld (0ee96h),hl		;7380
	ld a,00bh		;7383   ; el efecto 0x0B
	call 0413ah		;7385   ; banco 0: pide_sonido_si_esta_activo
	ld a,020h		;7388
	ld (0e20eh),a		;738a   ; y la cuenta de 0xE20E, a 0x20
	ret			;738d
entra_de_lado:
	ld a,c			;738e   ; por que lado
	ld (0e20bh),a		;738f   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
y_al_estado_3:
	call 09485h		;7392   ; banco 2: aviso
	ld a,003h		;7395   ; el estado 3
	ld (0e203h),a		;7397   ; el ESTADO de lo que se maneja
	ret			;739a

; ----------------------------------------------------------------------
; DATOS ventanas_739B: dos entradas de 4 bytes que p01:7327 escoge con (ix+1)
;   - 0x0C, contra la X (0xE205)
;   0x739b..0x73a3  (8 bytes)
DATA_ventanas_739B:
	defb 010h,098h,024h,07ch	; 739b
	defb 050h,0d8h,064h,0bch	; 739f

; ======================================================================
; CODIGO 0x73a3..0x73f5  (82 bytes)
; ======================================================================


L_73A3:
	ret			;73a3

; ----------------------------------------------------------------------
; CAERSE POR UN HUECO (LAS VARIANTES 0x11 Y 0x12). Ventana de tres bytes con fila, una sola salvacion -0xE1F1, que sube la variante 0x14- y perder con el estado 0x16. En el estado 8 esta rutina no cuenta.
; ----------------------------------------------------------------------
caerse_por_un_hueco_11_y_12:
	ld a,(ix+002h)		;73a4   ; la clase del objeto
	cp 00eh		;73a7
	ret nz			;73a9
	ld a,(0e203h)		;73aa   ; el ESTADO de lo que se maneja
	cp 008h		;73ad   ; en el 8 no cuenta
	ret z			;73af
	ld a,(ix+001h)		;73b0   ; la variante
	sub 011h		;73b3
	ld hl,073f5h		;73b5   ; la ventana de la 0x11...
	jr z,L_73BD		;73b8
	ld hl,073f8h		;73ba   ; ...o la de la 0x12
L_73BD:
	ld a,(0e205h)		;73bd   ; la columna del jugador
	cp (hl)			;73c0   ; por debajo, fuera
	ret c			;73c1
	inc hl			;73c2
	cp (hl)			;73c3   ; por encima, fuera
	ret nc			;73c4
	inc hl			;73c5
	ld a,(0e204h)		;73c6   ; y la fila
	cp (hl)			;73c9   ; si no llega, no ha caido
	ret c			;73ca
	ld a,(0e1f1h)		;73cb   ; ¿lleva lo de 0xE1F1?
	and a			;73ce
	jr nz,con_lo_de_0xE1F1_se_salva_11_y_12		;73cf
	xor a			;73d1   ; si no, se acabo la fase
	ld (0e21dh),a		;73d2   ; por que paso va la secuencia
	ld (0e097h),a		;73d5   ; la bandera de que la fase se ha acabado
	ld a,016h		;73d8   ; el estado 0x16: perder
	ld (0e203h),a		;73da   ; el ESTADO de lo que se maneja
	ld a,08ch		;73dd   ; y el efecto 0x8C
	jp 0413ah		;73df   ; banco 0: pide_sonido_si_esta_activo
con_lo_de_0xE1F1_se_salva_11_y_12:
	ld a,(ix+001h)		;73e2   ; la variante del hueco
	add a,014h		;73e5   ; sube 0x14
	ld (ix+001h),a		;73e7
	ld a,01ah		;73ea   ; el efecto 0x1A
	call 0413ah		;73ec   ; banco 0: pide_sonido_si_esta_activo
	ld de,00300h		;73ef   ; y 768 puntos
	jp 09367h		;73f2   ; banco 2

; ----------------------------------------------------------------------
; DATOS ventanas_73F5: dos entradas de 3 bytes que p01:73B5 escoge con (ix+1)
;   - 0x11, contra la X (0xE205)
;   0x73f5..0x73fb  (6 bytes)
DATA_ventanas_73F5:
	defb 010h,0a8h,088h	; 73f5
	defb 040h,0d8h,088h	; 73f8

; ======================================================================
; CODIGO 0x73fb..0x7442  (71 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ENTRAR (LAS VARIANTES 0x13 Y 0x14), SOLO EN EL DECORADO 7. Ventana de cuatro bytes, y ni se pierde ni se salva: se entra y ya, al estado 10. Ademas de estar en el decorado 7 hace falta que 0xE168 este a cero.
; ----------------------------------------------------------------------
entrar_en_el_decorado_7:
	ld a,(ix+002h)		;73fb   ; la clase del objeto
	cp 00eh		;73fe
	ret nz			;7400
	ld a,(0e0a1h)		;7401   ; el DECORADO, de 0 a 9
	cp 007h		;7404   ; solo en el decorado 7
	ret nz			;7406
	ld a,(0e203h)		;7407   ; el ESTADO de lo que se maneja
	cp 00ah		;740a   ; en el 10 ya se esta dentro
	ret z			;740c
	ld a,(0e168h)		;740d   ; y 0xE168 lo impide
	and a			;7410
	ret nz			;7411
	ld a,(ix+001h)		;7412   ; la variante
	sub 013h		;7415
	ld hl,07442h		;7417   ; la ventana de la 0x13...
	jr z,L_741F		;741a
	ld hl,07446h		;741c   ; ...o la de la 0x14
L_741F:
	ld a,(0e205h)		;741f   ; la X en la pantalla de lo que se maneja
	cp (hl)			;7422   ; por debajo, fuera
	ret c			;7423
	inc hl			;7424
	cp (hl)			;7425   ; por encima, fuera
	ret nc			;7426
	inc hl			;7427
	ld d,(hl)			;7428   ; el punto medio, guardado
	inc hl			;7429
	ld a,(0e204h)		;742a   ; y la fila
	cp (hl)			;742d   ; si no llega, no se entra
	ret c			;742e
	ld a,(0e205h)		;742f   ; la X en la pantalla de lo que se maneja
	cp d			;7432   ; contra el punto medio
	ld a,000h		;7433   ; por la izquierda...
	jr c,L_7439		;7435
	ld a,080h		;7437   ; ...o por la derecha
L_7439:
	ld (0e20bh),a		;7439   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	ld a,00ah		;743c   ; y dentro: el estado 10
	ld (0e203h),a		;743e   ; el ESTADO de lo que se maneja
	ret			;7441

; ----------------------------------------------------------------------
; DATOS ventanas_7442: dos entradas de 4 bytes que p01:7417 escoge con (ix+1)
;   - 0x13, contra la X (0xE205)
;   0x7442..0x744a  (8 bytes)
DATA_ventanas_7442:
	defb 038h,054h,046h,080h	; 7442
	defb 098h,0b4h,0a6h,080h	; 7446

; ======================================================================
; CODIGO 0x744a..0x7491  (71 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; CAERSE (LAS VARIANTES 0x15 A 0x19). Cinco ventanas y ninguna salida: la ventana es un rectangulo entero -dos cortes en columna y dos en fila- y quien caiga dentro pierde la vida, con el estado 0x15 y el efecto 0x8C. No hay nada que se pueda llevar que salve de estas.
; ----------------------------------------------------------------------
caerse_15_a_19:
	ld a,(ix+002h)		;744a   ; la clase del objeto
	cp 00eh		;744d
	ret nz			;744f
	ld a,(ix+001h)		;7450   ; la variante
	sub 015h		;7453
	ld hl,07491h		;7455   ; la ventana de la 0x15...
	jr z,mira_el_rectangulo_entero		;7458
	dec a			;745a
	ld hl,07495h		;745b   ; ...la de la 0x16...
	jr z,mira_el_rectangulo_entero		;745e
	dec a			;7460
	ld hl,07499h		;7461   ; ...la de la 0x17...
	jr z,mira_el_rectangulo_entero		;7464
	dec a			;7466
	ld hl,0749dh		;7467   ; ...la de la 0x18...
	jr z,mira_el_rectangulo_entero		;746a
	ld hl,074a1h		;746c   ; ...o la de la 0x19
mira_el_rectangulo_entero:
	ld a,(0e205h)		;746f   ; la columna del jugador
	cp (hl)			;7472   ; por la izquierda, fuera
	ret c			;7473
	inc hl			;7474
	cp (hl)			;7475   ; por la derecha, fuera
	ret nc			;7476
	inc hl			;7477
	ld a,(0e204h)		;7478   ; y ahora la fila
	cp (hl)			;747b   ; por arriba, fuera
	ret c			;747c
	inc hl			;747d
	cp (hl)			;747e   ; por abajo, fuera
	ret nc			;747f
	xor a			;7480   ; dentro: se acabo la fase
	ld (0e21dh),a		;7481   ; por que paso va la secuencia
	ld (0e097h),a		;7484   ; la bandera de que la fase se ha acabado
	ld a,015h		;7487   ; el estado 0x15: perder
	ld (0e203h),a		;7489   ; el ESTADO de lo que se maneja
	ld a,08ch		;748c   ; y el efecto 0x8C
	jp 0413ah		;748e   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS ventanas_7491: cinco entradas de 4 bytes que p01:7455 escoge con
;   (ix+1) - 0x15, contra la X (0xE205)
;   0x7491..0x74a5  (20 bytes)
DATA_ventanas_7491:
	defb 040h,070h,018h,040h	; 7491
	defb 090h,0c0h,018h,040h	; 7495
	defb 008h,038h,048h,070h	; 7499
	defb 058h,088h,058h,080h	; 749d
	defb 0b0h,0e0h,048h,070h	; 74a1

; ======================================================================
; CODIGO 0x74a5..0x7524  (127 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; COGER ALGO (LAS VARIANTES 0x1A A 0x1F). Las dos mitades de la tabla comparten ventana -0x74B2 le resta 3 a las de arriba para que caigan en las mismas tres- y lo que cambia es el premio: de la 0x1A a la 0x1C suman uno al bonus con el efecto 0x0E, y de la 0x1D a la 0x1F suman UNA VIDA en BCD con el efecto 0x38. Las vidas topan en 0x99: si el `daa` se desborda, se quedan en 99. Y en las dos, el objeto se borra y sus dos sprites se van de la pantalla.
; ----------------------------------------------------------------------
coger_algo:
	ld a,(ix+002h)		;74a5   ; la clase del objeto
	cp 00eh		;74a8
	ret nz			;74aa
	ld a,(ix+001h)		;74ab   ; la variante
	cp 01dh		;74ae   ; de la 0x1D para arriba...
	jr c,L_74B4		;74b0
	sub 003h		;74b2   ; ...se le quitan 3 y comparte ventana
L_74B4:
	sub 01ah		;74b4   ; la ventana de la primera...
	ld hl,07524h		;74b6
	jr z,L_74C4		;74b9
	dec a			;74bb   ; ...la de la segunda...
	ld hl,07528h		;74bc
	jr z,L_74C4		;74bf
	ld hl,0752ch		;74c1   ; ...o la de la tercera
L_74C4:
	ld a,(0e205h)		;74c4   ; la columna del jugador
	cp (hl)			;74c7   ; por la izquierda, fuera
	ret c			;74c8
	inc hl			;74c9
	cp (hl)			;74ca   ; por la derecha, fuera
	ret nc			;74cb
	inc hl			;74cc
	ld a,(0e204h)		;74cd   ; y ahora la fila
	cp (hl)			;74d0   ; por arriba, fuera
	ret c			;74d1
	inc hl			;74d2
	cp (hl)			;74d3   ; por abajo, fuera
	ret nc			;74d4
	ld a,(ix+001h)		;74d5   ; la variante otra vez
	cp 01dh		;74d8   ; ¿de las que dan vida?
	jr c,coger_algo_da_bonus		;74da
	ld a,(0e090h)		;74dc   ; las vidas, en BCD
	add a,001h		;74df   ; una mas
	daa			;74e1
	ld (0e090h),a		;74e2   ; las VIDAS, en BCD
	jr nc,L_74EC		;74e5   ; y si se desbordan...
	ld a,099h		;74e7   ; ...se quedan en 99
	ld (0e090h),a		;74e9   ; las VIDAS, en BCD
L_74EC:
	ld a,038h		;74ec   ; el efecto 0x38, el de la vida
	call 0413ah		;74ee   ; banco 0: pide_sonido_si_esta_activo
	jr borra_el_objeto_cogido		;74f1
coger_algo_da_bonus:
	ld a,(0e0d0h)		;74f3   ; el bonus
	add a,001h		;74f6   ; uno mas, en BCD
	daa			;74f8
	ld (0e0d0h),a		;74f9   ; lo que queda de bonus por pasar al marcador
	ld a,00eh		;74fc   ; y el efecto 0x0E
	call 0413ah		;74fe   ; banco 0: pide_sonido_si_esta_activo
borra_el_objeto_cogido:
	push ix		;7501   ; el registro del objeto
	pop hl			;7503
	ld a,010h		;7504   ; sus dieciseis bytes
borra_el_objeto_vuelta:
	ld (hl),000h		;7506
	inc l			;7508
	dec a			;7509
	jr nz,borra_el_objeto_vuelta		;750a
	ld a,(0e0e3h)		;750c   ; que hueco de sprite tenia
	add a,a			;750f   ; por cuatro, que es lo que ocupa un sprite
	add a,a			;7510
	ld c,a			;7511
	ld hl,0ee80h		;7512
	call 04056h		;7515   ; banco 0: a_mas_hl
	ld (hl),0e0h		;7518   ; 0xE0 en la fila: fuera de la pantalla
	ld a,c			;751a
	ld hl,0eea4h		;751b   ; y su companero de 0xEEA4, tambien
	call 04056h		;751e   ; banco 0: a_mas_hl
	ld (hl),0e0h		;7521
	ret			;7523

; ----------------------------------------------------------------------
; DATOS ventanas_7524: tres entradas de 4 bytes que p01:74B6 escoge con (ix+1)
;   - 0x1D, contra la X (0xE205)
;   0x7524..0x7530  (12 bytes)
DATA_ventanas_7524:
	defb 070h,090h,018h,038h	; 7524
	defb 038h,058h,050h,070h	; 7528
	defb 088h,0a8h,050h,070h	; 752c

; ======================================================================
; CODIGO 0x7530..0x7b23  (1523 bytes)
; ======================================================================


L_7530:
	ret			;7530

; ----------------------------------------------------------------------
; CHOCAR CON LOS TRES DE 0xE310. Los tres huecos de objeto, de 0x20 bytes cada uno. Solo cuentan los que esten puestos y no marcados con 0x10 -que es "ya chocado"- y que ademas tengan su byte 7 entre 0xA8 y 0xB0, o sea a la altura del jugador. El rectangulo es de 0x28 de alto por 0x20 de ancho, y en el decorado 7 de 0x20 por 0x20. En el estado 0x10 no se choca con nada.
; ----------------------------------------------------------------------
choca_con_los_tres_de_0xE310:
	ld a,(0e203h)		;7531   ; el ESTADO de lo que se maneja
	cp 010h		;7534   ; en el 0x10 no se choca
	ret z			;7536
	ld hl,0e310h		;7537   ; los tres huecos
	ld b,003h		;753a
choca_con_uno_de_los_tres:
	push bc			;753c
	ld c,020h		;753d   ; de entrada, 0x20 al hueco siguiente
	ld a,(hl)			;753f   ; ¿esta puesto?
	and a			;7540
	jr z,choca_al_hueco_siguiente		;7541
	cp 010h		;7543   ; y el 0x10 es el que ya ha chocado
	jr z,choca_al_hueco_siguiente		;7545
	ld a,l			;7547
	add a,007h		;7548   ; su byte 7
	ld l,a			;754a
	ld c,019h		;754b   ; y este salta 0x19 + 0x07: tambien 0x20
	ld a,(hl)			;754d
	cp 0a8h		;754e   ; por encima de la 0xA8...
	jr c,choca_al_hueco_siguiente		;7550
	cp 0b0h		;7552   ; ...y por debajo de la 0xB0: fuera
	jr nc,choca_al_hueco_siguiente		;7554
	ld a,l			;7556
	sub 005h		;7557   ; atras, a su fila y su columna
	ld l,a			;7559
	ld e,(hl)			;755a
	inc l			;755b
	ld d,(hl)			;755c
	ld a,(0e0a1h)		;755d   ; el decorado
	cp 007h		;7560   ; el 7 tiene su propia medida
	jr z,choca_en_el_decorado_7		;7562
	ld a,(0e204h)		;7564   ; la fila del jugador
	add a,01ch		;7567   ; el margen en fila
	sub e			;7569
	cp 028h		;756a   ; 0x28 de alto
	jr nc,choca_no_le_ha_dado		;756c
	ld a,(0e205h)		;756e   ; y la columna
	add a,018h		;7571   ; su margen
	sub d			;7573
	cp 020h		;7574   ; y 0x20 de ancho
	jr nc,choca_no_le_ha_dado		;7576
	jr L_758E		;7578
choca_en_el_decorado_7:
	ld a,(0e204h)		;757a   ; la fila del jugador
	add a,014h		;757d   ; aqui el margen es 0x14...
	sub e			;757f
	cp 020h		;7580   ; ...y el alto 0x20
	jr nc,choca_no_le_ha_dado		;7582
	ld a,(0e205h)		;7584   ; la columna, igual que antes
	add a,018h		;7587
	sub d			;7589
	cp 020h		;758a
	jr nc,choca_no_le_ha_dado		;758c
L_758E:
	push hl			;758e
	call que_pasa_al_chocar		;758f   ; han chocado
	pop hl			;7592
choca_no_le_ha_dado:
	ld c,01dh		;7593   ; 0x1D + 0x03: el hueco siguiente
choca_al_hueco_siguiente:
	ld a,c			;7595   ; el salto hasta el hueco siguiente
	add a,l			;7596
	ld l,a			;7597
	pop bc			;7598
	djnz choca_con_uno_de_los_tres		;7599
	ret			;759b

; ----------------------------------------------------------------------
; QUE PASA AL CHOCAR. Depende de la clase del bicho, y de lo que se lleve encima: las clases 6 y 12 las para lo que cuente 0xE164, las clases 1 y 13 lo que cuente 0xE165, y las clases 5 y 14 la marca de 0xE170. Cada vez que uno de esos para un golpe se GASTA una unidad, el bicho se marca con 0x10 y suena el efecto 0x17. Con 0xE1F1 puesto no hace falta nada de eso: se para cualquier golpe. Y si no hay con que pararlo, se pierde la vida.
; ----------------------------------------------------------------------
que_pasa_al_chocar:
	dec l			;759c   ; atras, a la clase del bicho
	dec l			;759d
	dec l			;759e
	ld a,(0e1f1h)		;759f   ; ¿lleva lo de 0xE1F1?
	and a			;75a2
	jr nz,parado_y_256_puntos		;75a3   ; con eso se para cualquier golpe
	ld a,(hl)			;75a5   ; la clase
	cp 006h		;75a6   ; la 6...
	jr z,lo_de_0xE164_para_el_golpe		;75a8
	cp 00ch		;75aa   ; ...y la 12 las para lo de 0xE164
	jr z,lo_de_0xE164_para_el_golpe		;75ac
	cp 001h		;75ae   ; la 1...
	jr z,lo_de_0xE165_para_el_golpe		;75b0
	cp 00dh		;75b2   ; ...y la 13 las para lo de 0xE165
	jr z,lo_de_0xE165_para_el_golpe		;75b4
	cp 005h		;75b6   ; la 5...
	jr z,lo_de_0xE170_para_el_golpe		;75b8
	cp 00eh		;75ba   ; ...y la 14 las para lo de 0xE170
	jr z,lo_de_0xE170_para_el_golpe		;75bc
chocar_cuesta_la_vida:
	xor a			;75be   ; se acabo la fase
	ld (0e21dh),a		;75bf   ; por que paso va la secuencia
	ld (0e097h),a		;75c2   ; la bandera de que la fase se ha acabado
	ld a,(0e0a1h)		;75c5   ; el decorado
	ld c,016h		;75c8   ; en el 4 y en el 5 se pierde con el estado 0x16...
	cp 004h		;75ca
	jr z,L_75DB		;75cc
	cp 005h		;75ce
	jr z,L_75DB		;75d0
	ld a,(0e203h)		;75d2   ; ...y tambien si se iba en el estado 4...
	cp 004h		;75d5
	jr z,L_75DB		;75d7
	ld c,015h		;75d9   ; ...y en el resto con el 0x15
L_75DB:
	ld a,c			;75db
	ld (0e203h),a		;75dc   ; el ESTADO de lo que se maneja
	ld a,08ch		;75df   ; y el efecto 0x8C
	jp 0413ah		;75e1   ; banco 0: pide_sonido_si_esta_activo
lo_de_0xE164_para_el_golpe:
	ld a,(0e164h)		;75e4   ; ¿queda?
	and a			;75e7
	jr z,chocar_cuesta_la_vida		;75e8   ; si no queda, se pierde
	dec a			;75ea   ; se gasta uno
	ld (0e164h),a		;75eb
	ld (hl),010h		;75ee   ; el bicho, marcado como ya chocado
	ld a,017h		;75f0   ; el efecto 0x17, el de pararlo
	call 0413ah		;75f2   ; banco 0: pide_sonido_si_esta_activo
	ld c,004h		;75f5   ; banco 3: y a soltar el objeto 4
	jp 0baa3h		;75f7   ; banco 3
lo_de_0xE165_para_el_golpe:
	ld a,(0e165h)		;75fa   ; ¿queda?
	and a			;75fd
	jr z,chocar_cuesta_la_vida		;75fe   ; si no queda, se pierde
	dec a			;7600   ; se gasta uno
	ld (0e165h),a		;7601
	ld (hl),010h		;7604   ; el bicho, marcado
	ld a,017h		;7606   ; el efecto 0x17
	call 0413ah		;7608   ; banco 0: pide_sonido_si_esta_activo
	ld c,005h		;760b   ; banco 3: y el objeto 5
	jp 0baa3h		;760d   ; banco 3
lo_de_0xE170_para_el_golpe:
	ld a,(0e170h)		;7610   ; esta no se gasta: o esta o no esta
	and a			;7613
	jr nz,parado_y_256_puntos		;7614
	jr chocar_cuesta_la_vida		;7616   ; y si no esta, se pierde
parado_y_256_puntos:
	ld (hl),010h		;7618   ; el bicho, marcado
	ld a,017h		;761a   ; el efecto 0x17
	call 0413ah		;761c   ; banco 0: pide_sonido_si_esta_activo
	ld de,00100h		;761f   ; y 256 puntos por pararlo
	jp 09367h		;7622   ; banco 2

; ----------------------------------------------------------------------
; CHOCAR CON LOS TRES DE 0xE370. Los otros tres huecos, estos de 0x10 bytes. El primer byte es la clase y ademas la marca de que este puesto. El rectangulo es mas pequeno que el de los de 0xE310 -0x1C de alto por 0x14 de ancho, y 0x14 por 0x14 en el decorado 7-, que es lo que cabe esperar de bichos mas pequenos.
; ----------------------------------------------------------------------
choca_con_los_tres_de_0xE370:
	ld a,(0e203h)		;7625   ; el ESTADO de lo que se maneja
	cp 010h		;7628   ; en el 0x10 no se choca
	ret z			;762a
	ld hl,0e370h		;762b   ; los tres huecos
	ld b,003h		;762e
choca_con_uno_de_los_de_0xE370:
	push bc			;7630
	ld c,010h		;7631   ; de entrada, 0x10 al hueco siguiente
	ld a,(hl)			;7633   ; ¿esta puesto?
	and a			;7634
	jr z,al_hueco_siguiente_de_0xE370		;7635
	ld c,a			;7637   ; la clase, guardada
	inc l			;7638
	inc l			;7639
	ld e,(hl)			;763a   ; su fila...
	inc l			;763b
	inc l			;763c
	ld d,(hl)			;763d   ; ...y su columna
	ld a,(0e0a1h)		;763e   ; el DECORADO, de 0 a 9
	cp 007h		;7641   ; el 7 tiene su propia medida
	jr z,choca_con_los_de_0xE370_en_el_decorado_7		;7643
	ld a,(0e204h)		;7645   ; la fila del jugador
	add a,010h		;7648   ; el margen en fila
	sub e			;764a
	cp 01ch		;764b   ; 0x1C de alto
	jr nc,no_le_ha_dado_ninguno_de_0xE370		;764d
	ld a,(0e205h)		;764f   ; y la columna
	add a,012h		;7652   ; su margen
	sub d			;7654
	cp 014h		;7655   ; y 0x14 de ancho
	jr nc,no_le_ha_dado_ninguno_de_0xE370		;7657
	jr L_766F		;7659
choca_con_los_de_0xE370_en_el_decorado_7:
	ld a,(0e204h)		;765b   ; la fila del jugador
	add a,008h		;765e   ; aqui el margen es 8...
	sub e			;7660
	cp 014h		;7661   ; ...y el alto 0x14
	jr nc,no_le_ha_dado_ninguno_de_0xE370		;7663
	ld a,(0e205h)		;7665   ; la X en la pantalla de lo que se maneja
	add a,012h		;7668
	sub d			;766a
	cp 014h		;766b
	jr nc,no_le_ha_dado_ninguno_de_0xE370		;766d
L_766F:
	push hl			;766f
	call que_pasa_al_chocar_con_uno_de_0xE370		;7670   ; han chocado
	pop hl			;7673
no_le_ha_dado_ninguno_de_0xE370:
	ld c,00ch		;7674   ; 0x0C + 0x04: el hueco siguiente
al_hueco_siguiente_de_0xE370:
	ld a,c			;7676   ; el salto hasta el hueco siguiente
	add a,l			;7677
	ld l,a			;7678
	pop bc			;7679
	djnz choca_con_uno_de_los_de_0xE370		;767a
	ret			;767c

; ----------------------------------------------------------------------
; QUE PASA AL CHOCAR CON UNO DE 0xE370. Otra vez por la clase: la 4 no mata -si 0xE16B esta puesto no hace nada, y si no, para el juego 0x80 cuadros con el efecto 0x10- y la 6 la para lo que cuente 0xE163, gastando uno. Con 0xE1F1 puesto se para cualquiera, con el efecto 0x18. En todos los casos en que se para, el bicho se borra entero.
; ----------------------------------------------------------------------
que_pasa_al_chocar_con_uno_de_0xE370:
	ld a,(0e1f1h)		;767d   ; ¿lleva lo de 0xE1F1?
	and a			;7680
	jr nz,lo_de_0xE1F1_para_cualquiera		;7681
	ld a,c			;7683   ; la clase
	cp 004h		;7684   ; la 4 no mata...
	jr z,la_clase_4_no_mata		;7686
	cp 006h		;7688   ; ...y la 6 la para lo de 0xE163
	jr z,lo_de_0xE163_para_la_clase_6		;768a
chocar_con_uno_de_0xE370_cuesta_la_vida:
	xor a			;768c   ; se acabo la fase
	ld (0e21dh),a		;768d   ; por que paso va la secuencia
	ld (0e097h),a		;7690   ; la bandera de que la fase se ha acabado
	ld a,l			;7693
	sub 004h		;7694   ; atras, al principio del hueco
	ld l,a			;7696
	ld b,010h		;7697   ; y sus dieciseis bytes...
	xor a			;7699
borra_el_de_0xE370_vuelta:
	ld (hl),a			;769a
	inc l			;769b
	djnz borra_el_de_0xE370_vuelta		;769c
	ld a,(0e0a1h)		;769e   ; el decorado
	ld c,016h		;76a1   ; en el 4 y en el 5 se pierde con el estado 0x16...
	cp 004h		;76a3
	jr z,L_76B4		;76a5
	cp 005h		;76a7
	jr z,L_76B4		;76a9
	ld a,(0e203h)		;76ab   ; ...y tambien si se iba en el estado 4...
	cp 004h		;76ae
	jr z,L_76B4		;76b0
	ld c,015h		;76b2   ; ...y en el resto con el 0x15
L_76B4:
	ld a,c			;76b4
	ld (0e203h),a		;76b5   ; el ESTADO de lo que se maneja
	ld a,08ch		;76b8   ; y el efecto 0x8C
	jp 0413ah		;76ba   ; banco 0: pide_sonido_si_esta_activo
lo_de_0xE1F1_para_cualquiera:
	ld a,018h		;76bd   ; el efecto 0x18
	call 0413ah		;76bf   ; banco 0: pide_sonido_si_esta_activo
borra_el_de_0xE370:
	ld a,l			;76c2
	sub 004h		;76c3   ; atras, al principio del hueco
	ld l,a			;76c5
	ld b,010h		;76c6   ; sus dieciseis bytes
	xor a			;76c8
borra_el_de_0xE370_bucle:
	ld (hl),a			;76c9
	inc l			;76ca
	djnz borra_el_de_0xE370_bucle		;76cb
	ret			;76cd
la_clase_4_no_mata:
	ld a,(0e16bh)		;76ce   ; ¿esta puesto 0xE16B?
	and a			;76d1
	jr nz,borra_el_de_0xE370		;76d2   ; si lo esta, no pasa nada de nada
	ld a,080h		;76d4   ; y si no, 0x80 cuadros de pausa...
	ld (0e0dch),a		;76d6   ; la pausa que se hace al perder o al cambiar de fase
	ld a,010h		;76d9   ; ...con el efecto 0x10
	call 0413ah		;76db   ; banco 0: pide_sonido_si_esta_activo
	jr borra_el_de_0xE370		;76de
lo_de_0xE163_para_la_clase_6:
	ld a,(0e163h)		;76e0   ; ¿queda?
	and a			;76e3
	jr z,chocar_con_uno_de_0xE370_cuesta_la_vida		;76e4   ; si no queda, se pierde
	dec a			;76e6   ; se gasta uno
	ld (0e163h),a		;76e7
	push hl			;76ea
	ld c,003h		;76eb   ; banco 3: y a soltar el objeto 3
	call 0baa3h		;76ed   ; banco 3
	pop hl			;76f0
	jr borra_el_de_0xE370		;76f1

; ----------------------------------------------------------------------
; CHOCAR CON LO QUE SE HA LANZADO. El registro de 0xE540, el del banco 3, y solo en su tiempo 4, que es el ultimo tramo de la bajada. Rectangulo de 0x28 de alto por 0x20 de ancho, y aqui no hay nada que salve: se pierde la vida y punto.
; ----------------------------------------------------------------------
choca_con_lo_que_se_lanza:
	ld hl,0e540h		;76f3   ; el registro de lo que se lanza
	ld a,(hl)			;76f6
	cp 004h		;76f7   ; solo en el tiempo 4
	ret nz			;76f9
	ld a,007h		;76fa   ; su fila...
	add a,l			;76fc
	ld l,a			;76fd
	ld e,(hl)			;76fe
	inc l			;76ff
	inc l			;7700
	ld d,(hl)			;7701   ; ...y su columna
	ld a,(0e204h)		;7702   ; la fila del jugador
	add a,018h		;7705   ; el margen
	sub e			;7707
	cp 028h		;7708   ; 0x28 de alto
	ret nc			;770a
	ld a,(0e205h)		;770b   ; y la columna
	add a,018h		;770e   ; su margen
	sub d			;7710
	cp 020h		;7711   ; y 0x20 de ancho
	ret nc			;7713
	xor a			;7714   ; se acabo la fase
	ld (0e21dh),a		;7715   ; por que paso va la secuencia
	ld (0e097h),a		;7718   ; la bandera de que la fase se ha acabado
	ld a,l			;771b
	sub 009h		;771c   ; atras, al principio del registro
	ld l,a			;771e
	ld b,010h		;771f   ; y sus dieciseis bytes, borrados
	xor a			;7721
borra_lo_que_se_lanza_vuelta:
	ld (hl),a			;7722
	inc l			;7723
	djnz borra_lo_que_se_lanza_vuelta		;7724
	ld a,015h		;7726   ; el estado 0x15: perder
	ld (0e203h),a		;7728   ; el ESTADO de lo que se maneja
	ld a,08ch		;772b   ; y el efecto 0x8C
	jp 0413ah		;772d   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; LO QUE SE DISPARA, CONTRA LOS TRES DE 0xE310. El mismo recorrido que el de 0x7531, pero quien choca no es el jugador sino lo que ha salido del segundo boton (0xE502 y 0xE503). La franja de altura es otra -de la 0x88 a la 0xA8, mas arriba que la del jugador- y el rectangulo, de 0x18 por 0x18.
; ----------------------------------------------------------------------
lo_disparado_contra_los_de_0xE310:
	ld hl,0e310h		;7730   ; los tres huecos
	ld b,003h		;7733
lo_disparado_contra_uno:
	push bc			;7735
	ld c,020h		;7736   ; de entrada, 0x20 al hueco siguiente
	ld a,(hl)			;7738   ; ¿esta puesto?
	and a			;7739
	jr z,lo_disparado_al_hueco_siguiente		;773a
	cp 010h		;773c   ; y el 0x10 es el que ya ha chocado
	jr z,lo_disparado_al_hueco_siguiente		;773e
	ld a,l			;7740
	add a,007h		;7741   ; su byte 7
	ld l,a			;7743
	ld c,019h		;7744
	ld a,(hl)			;7746
	cp 088h		;7747   ; por encima de la 0x88...
	jr c,lo_disparado_al_hueco_siguiente		;7749
	cp 0a8h		;774b   ; ...y por debajo de la 0xA8: fuera
	jr nc,lo_disparado_al_hueco_siguiente		;774d
	ld a,l			;774f
	sub 005h		;7750   ; atras, a su fila y su columna
	ld l,a			;7752
	ld e,(hl)			;7753
	inc l			;7754
	ld d,(hl)			;7755
	ld a,(0e502h)		;7756   ; la fila de lo disparado
	add a,00ch		;7759   ; el margen
	sub e			;775b
	cp 018h		;775c   ; 0x18 de alto
	jr nc,lo_disparado_no_le_ha_dado		;775e
	ld a,(0e503h)		;7760   ; y su columna
	add a,00ch		;7763   ; su margen
	sub d			;7765
	cp 018h		;7766   ; y 0x18 de ancho
	jr nc,lo_disparado_no_le_ha_dado		;7768
	push hl			;776a
	call lo_disparado_le_ha_dado		;776b   ; le ha dado
	pop hl			;776e
lo_disparado_no_le_ha_dado:
	ld c,01dh		;776f
lo_disparado_al_hueco_siguiente:
	ld a,c			;7771   ; el salto hasta el hueco siguiente
	add a,l			;7772
	ld l,a			;7773
	pop bc			;7774
	djnz lo_disparado_contra_uno		;7775
	ret			;7777

; ----------------------------------------------------------------------
; LE HA DADO. El bicho se marca con 0x10, suena el efecto 0x17, caen 256 puntos y lo disparado se borra: los dieciseis bytes de 0xE500 a cero y 0xE0 en la fila de su sprite, que es lo que lo saca de la pantalla.
; ----------------------------------------------------------------------
lo_disparado_le_ha_dado:
	dec l			;7778   ; atras, a la clase del bicho
	dec l			;7779
	dec l			;777a
	ld (hl),010h		;777b   ; marcado como ya chocado
	ld a,017h		;777d   ; el efecto 0x17
	call 0413ah		;777f   ; banco 0: pide_sonido_si_esta_activo
	ld de,00100h		;7782   ; y 256 puntos
	call 09367h		;7785   ; banco 2
	ld b,010h		;7788   ; los dieciseis bytes de lo disparado
	ld hl,0e500h		;778a
borra_lo_disparado_vuelta:
	ld (hl),000h		;778d
	inc l			;778f
	djnz borra_lo_disparado_vuelta		;7790
	ld a,l			;7792
	sub 00eh		;7793   ; atras, a la fila de su sprite
	ld l,a			;7795
	ld (hl),0e0h		;7796   ; 0xE0: fuera de la pantalla
	ret			;7798

; ----------------------------------------------------------------------
; LO QUE SE DISPARA, CONTRA EL BLANCO DE 0xE535. Un solo blanco, y este NO se muere de un tiro: cada acierto suma uno a 0xE53C y hace falta llegar a VEINTE. El vigesimo es el que arranca la otra cosa: los cuatro registros de 0xE550 se ponen a 5, se llama a dos rutinas de preparacion, 0xE53A apunta a 0xAE0A y 0xE530 pasa a 2. Los diecinueve anteriores solo suenan.
; ----------------------------------------------------------------------
lo_disparado_contra_el_blanco:
	ld a,(0e535h)		;7799   ; la fila del blanco
	sub 008h		;779c   ; menos ocho: el margen va restado aqui
	ld e,a			;779e
	ld a,(0e536h)		;779f   ; y su columna
	sub 008h		;77a2
	ld d,a			;77a4
	ld a,(0e502h)		;77a5   ; la fila de lo disparado
	add a,010h		;77a8   ; su margen
	sub e			;77aa
	cp 020h		;77ab   ; 0x20 de alto
	ret nc			;77ad
	ld a,(0e503h)		;77ae   ; y su columna
	add a,010h		;77b1   ; su margen
	sub d			;77b3
	cp 020h		;77b4   ; y 0x20 de ancho
	ret nc			;77b6
	ld b,010h		;77b7   ; los dieciseis bytes de lo disparado
	ld hl,0e500h		;77b9
borra_lo_disparado_del_blanco:
	ld (hl),000h		;77bc
	inc l			;77be
	djnz borra_lo_disparado_del_blanco		;77bf
	ld a,l			;77c1
	sub 00eh		;77c2   ; atras, a la fila de su sprite
	ld l,a			;77c4
	ld (hl),0e0h		;77c5   ; 0xE0: fuera de la pantalla
	ld a,021h		;77c7   ; el efecto 0x21
	call 0413ah		;77c9   ; banco 0: pide_sonido_si_esta_activo
	ld hl,0e53ch		;77cc   ; la cuenta de aciertos
	inc (hl)			;77cf   ; uno mas
	ld a,(hl)			;77d0
	cp 014h		;77d1   ; y hasta el VEINTE no pasa nada
	ret nz			;77d3
	ld hl,0e550h		;77d4   ; los cuatro registros de 0xE550...
	ld b,004h		;77d7
pone_los_cuatro_de_0xE550:
	ld (hl),005h		;77d9   ; ...a 5
	ld a,008h		;77db   ; de ocho en ocho
	call 04056h		;77dd   ; banco 0: a_mas_hl
	djnz pone_los_cuatro_de_0xE550		;77e0
	call las_cuatro_tiras_a_la_vram		;77e2
	call L_7C9F		;77e5
	ld hl,0ae0ah		;77e8   ; y el guion de 0xAE0A
	ld (0e53ah),hl		;77eb
	ld a,002h		;77ee   ; 0xE530 a 2
	ld (0e530h),a		;77f0
	xor a			;77f3
	ld (0e531h),a		;77f4   ; y lo demas a cero
	ld (0e532h),a		;77f7
	ld (0e533h),a		;77fa
	xor a			;77fd   ; la pose 0
	call 0a8f5h		;77fe   ; banco 3
	ld c,001h		;7801
	ld de,00000h		;7803
	jp 09369h		;7806   ; banco 2
apostar_entrada:
	call 04c38h		;7809
	ld de,0b1fbh		;780c   ; los dos guiones del cartel
	call L_7DF7		;780f
	ld de,0b387h		;7812
	call L_7DF7		;7815
	ld hl,0e12ah		;7818   ; y al paso 1
	ld (hl),001h		;781b
	ret			;781d
apostar_paso_1:
	ld a,(0e12ah)		;781e   ; ¿el paso 1?
	dec a			;7821
	jr nz,L_7851		;7822
	ld hl,0e132h		;7824   ; lo que salga, a cero
	ld (hl),000h		;7827
	ld de,0b1cah		;7829   ; los cuatro guiones del cartel
	call L_7E11		;782c
	ld de,0b1e5h		;782f
	call L_7E11		;7832
	ld de,0b1eeh		;7835
	call L_7E11		;7838
	ld de,0b15eh		;783b
	call L_7DF7		;783e
	xor a			;7841   ; la cuenta, a cero
	ld (0e12bh),a		;7842
	call L_786E		;7845
	xor a			;7848
	ld (0e096h),a		;7849   ; y sin avisos
L_784C:
	ld hl,0e12ah		;784c
	inc (hl)			;784f
	ret			;7850
L_7851:
	dec a			;7851
	jr nz,apostar_paso_2		;7852
	ld a,(0e006h)		;7854   ; las teclas recien pulsadas
	and 010h		;7857
	jr nz,L_788A		;7859
	ld a,(0e006h)		;785b   ; las teclas recien pulsadas
	and 00ch		;785e
	ret z			;7860
	ld a,023h		;7861
	call 0413ah		;7863   ; banco 0: pide_sonido_si_esta_activo
	ld a,(0e12bh)		;7866
	xor 001h		;7869
	ld (0e12bh),a		;786b
L_786E:
	ld hl,07b2ah		;786e
	xor 001h		;7871
	push af			;7873
	call 04055h		;7874   ; banco 0: dos_por_a_mas_hl
	call L_7896		;7877
	ex de,hl			;787a
	pop af			;787b
	xor 001h		;787c
	ld hl,07b2ah		;787e
	call 04055h		;7881   ; banco 0: dos_por_a_mas_hl
	call L_7896		;7884
	jp borra_y_pinta_el_cursor		;7887
L_788A:
	ld a,(0e12bh)		;788a
	and a			;788d
	jr z,L_784C		;788e
	ld a,002h		;7890
	ld (0e096h),a		;7892   ; los avisos que deja el cuadro
	ret			;7895
L_7896:
	ld a,(hl)			;7896
	inc hl			;7897
	ld h,(hl)			;7898
	ld l,a			;7899
	ret			;789a
apostar_paso_2:
	dec a			;789b   ; ¿el paso 2?
	jr nz,L_78BE		;789c
	ld de,0b15eh		;789e   ; los dos guiones de la pantalla
	call L_7E11		;78a1
	ld de,0b18ah		;78a4
	call L_7DF7		;78a7
	ld hl,0e135h		;78aa   ; la bolsa, a cero
	ld (hl),000h		;78ad
	ld hl,03989h		;78af   ; y el cero, pintado en la pantalla
	call pinta_la_bolsa		;78b2
	jp L_784C		;78b5
pinta_la_bolsa:
	ld de,0e136h		;78b8   ; la bolsa
	jp 09481h		;78bb   ; banco 2: y a pintarla
L_78BE:
	dec a			;78be
	jp nz,apostar_paso_4		;78bf
	ld a,(0e006h)		;78c2   ; las teclas recien pulsadas
	ld b,a			;78c5
	and 010h		;78c6
	ld a,(0e007h)		;78c8   ; el estado de los mandos del cuadro anterior
	ld (0e13ch),a		;78cb
	jp nz,cierra_el_cambio		;78ce
	ld a,b			;78d1
	and 00fh		;78d2
	jr z,la_espera_entre_cambios		;78d4
	ld a,030h		;78d6
	ld (0e130h),a		;78d8
	jr cambia_dinero		;78db
la_espera_entre_cambios:
	ld hl,0e130h		;78dd   ; la espera
	ld a,(hl)			;78e0
	and a			;78e1   ; si no hay espera, se atiende al mando
	jr z,espera_entre_cambios		;78e2
	dec (hl)			;78e4   ; y si la hay, se descuenta
	ret			;78e5
espera_entre_cambios:
	inc hl			;78e6
	inc (hl)			;78e7   ; un cuadro mas
	ld a,(hl)			;78e8
	and 003h		;78e9   ; uno de cada cuatro
	ret nz			;78eb
	ld a,(0e13ch)		;78ec   ; las teclas guardadas
	ld b,a			;78ef
	and 00fh		;78f0   ; sin ninguna de las cuatro, nada
	ret z			;78f2

; ----------------------------------------------------------------------
; CAMBIAR DINERO DE UN SITIO A OTRO. Dos bolsas: el marcador (0xE089) y la de 0xE135, y los cuatro sentidos del mando mueven de una a otra. Arriba y abajo -bits 3 y 2- mueven de UNO en uno, y derecha e izquierda -bits 1 y 0- de DIEZ en diez. Lo que no cabe no se mueve: las dos rutinas de BCD vuelven con el acarreo puesto y nada cambia, y entonces suena el 0x25 en vez del 0x23.
; ----------------------------------------------------------------------
cambia_dinero:
	ld a,b			;78f3   ; las teclas
	ld ix,0e135h		;78f4   ; la bolsa de 0xE135
	ld d,001h		;78f8   ; el 1 que se lleva al byte alto
	ld c,001h		;78fa   ; de uno en uno
	and 008h		;78fc   ; el bit 3 saca de la bolsa
	jr nz,saca_de_la_bolsa		;78fe
	ld a,b			;7900
	and 004h		;7901   ; el bit 2 mete en la bolsa
	jr nz,mete_en_la_bolsa		;7903
	ld c,00ah		;7905   ; y los otros dos, de diez en diez
	ld a,b			;7907
	and 002h		;7908   ; el bit 1 saca...
	jr nz,saca_de_la_bolsa		;790a
	ld a,b			;790c
	and 001h		;790d   ; ...y el bit 0 mete
	ret z			;790f   ; sin ninguno de los cuatro, nada
mete_en_la_bolsa:
	ld ix,0e089h		;7910   ; del marcador...
	push bc			;7914
	call resta_en_bcd_de_dos_bytes		;7915   ; ...se resta
	pop bc			;7918
	jr c,L_7970		;7919   ; si no llega, no se mueve nada
	ld ix,0e135h		;791b   ; y a la bolsa...
	call suma_en_bcd_de_dos_bytes		;791f   ; ...se suma
	jr suena_y_repinta_el_cambio		;7922
saca_de_la_bolsa:
	ld ix,0e135h		;7924   ; de la bolsa...
	push bc			;7928
	call resta_en_bcd_de_dos_bytes		;7929   ; ...se resta
	pop bc			;792c
	jr c,L_7970		;792d   ; si no llega, no se mueve nada
	ld ix,0e089h		;792f   ; y al marcador...
	call suma_en_bcd_de_dos_bytes		;7933   ; ...se suma
suena_y_repinta_el_cambio:
	ld a,023h		;7936   ; el efecto 0x23, el de que si ha entrado
	call 0413ah		;7938   ; banco 0: pide_sonido_si_esta_activo
L_793B:
	push ix		;793b
	pop de			;793d
	inc de			;793e
	call 0947bh		;793f   ; banco 2: y a repintar la cifra
	ld hl,03989h		;7942   ; en su sitio de la pantalla
	jp pinta_la_bolsa		;7945
cierra_el_cambio:
	ld de,(0e135h)		;7948   ; la bolsa
	ld a,d			;794c
	or e			;794d
	ld a,025h		;794e   ; con la bolsa vacia solo suena el 0x25
	jp z,0413ah		;7950
	ld a,003h		;7953   ; y si lleva algo, LOS TRES RODILLOS a girar
	ld (0e12ch),a		;7955
	ld de,0b18ah		;7958
	call L_7E11		;795b
	ld de,0b1bdh		;795e
	call L_7DF7		;7961
	ld a,029h		;7964
	call 0413ah		;7966   ; banco 0: pide_sonido_si_esta_activo
	xor a			;7969
	ld (0e130h),a		;796a
	jp L_784C		;796d
L_7970:
	ld a,025h		;7970
	call 0413ah		;7972   ; banco 0: pide_sonido_si_esta_activo
	jr L_793B		;7975
apostar_paso_4:
	dec a			;7977   ; ¿el paso 4?
	jr nz,los_rodillos		;7978
	ld hl,0e130h		;797a
	inc (hl)			;797d   ; un cuadro mas
	ld a,(hl)			;797e
	cp 010h		;797f   ; los dieciseis primeros...
	jr nc,L_7989		;7981
	ld de,0b39fh		;7983   ; ...pintan un guion...
	jp L_7DF7		;7986
L_7989:
	ld de,0b387h		;7989   ; ...y de ahi en adelante, el otro
	call L_7DF7		;798c
	jp L_784C		;798f

; ----------------------------------------------------------------------
; LOS RODILLOS. Cada rodillo saca su dibujo del registro R -`ld a,r / and 0x0F`, o sea uno de dieciseis- y con el lee dos tablas: 0x7B34 da el valor, que se guarda en 0xE12F hacia atras, y 0x7B2E el caracter que se pinta. Los rodillos se paran de uno en uno con el disparo, con el efecto 0x2A, y cuando cae el ultimo suena el 0x2B y se pasa a la cuenta.
; ----------------------------------------------------------------------
los_rodillos:
	dec a			;7992   ; ¿el paso 5?
	jr nz,la_cuenta_de_lo_apostado		;7993
	ld hl,0e12ch		;7995   ; cuantos rodillos quedan por parar
	ld b,(hl)			;7998
	ld de,0e12fh		;7999   ; donde se guardan los valores
	ld hl,03a1ah		;799c   ; y donde se pintan
gira_un_rodillo:
	push bc			;799f
	push hl			;79a0
	ld a,r		;79a1   ; el registro R: el azar de la casa
	and 00fh		;79a3   ; uno de dieciseis
	push hl			;79a5
	ld hl,07b34h		;79a6   ; la tabla de valores
	call 04056h		;79a9   ; banco 0: a_mas_hl
	ld a,(hl)			;79ac
	ld (de),a			;79ad   ; guardado
	ld hl,07b2eh		;79ae   ; y la de caracteres
	call 04056h		;79b1   ; banco 0: a_mas_hl
	ld c,(hl)			;79b4
	pop hl			;79b5
	call pinta_los_cuatro_caracteres		;79b6   ; pintado en su casilla
	pop hl			;79b9
	dec hl			;79ba   ; la casilla anterior
	dec hl			;79bb
	dec hl			;79bc
	dec hl			;79bd
	dec de			;79be
	pop bc			;79bf
	djnz gira_un_rodillo		;79c0
	ld a,(0e006h)		;79c2   ; las teclas
	and 010h		;79c5   ; ¿el disparo?
	ret z			;79c7
	ld a,02ah		;79c8   ; el efecto 0x2A: un rodillo parado
	ld hl,0e12ch		;79ca
	dec (hl)			;79cd   ; uno menos
	jp nz,0413ah		;79ce   ; y si quedan, se sigue girando
	ld a,02bh		;79d1   ; el efecto 0x2B: ya estan los tres
	call 0413ah		;79d3   ; banco 0: pide_sonido_si_esta_activo
	call L_7AF0		;79d6
	ld a,080h		;79d9   ; y 0x80 cuadros de espera
	ld (0e130h),a		;79db
	jp L_784C		;79de

; ----------------------------------------------------------------------
; LA CUENTA DE LO APOSTADO. Segun lo que haya salido (0xE132): con 0xFF o con 0 se pierde todo -la bolsa a cero y el rotulo de 0xB1E5- y con cualquier otra cosa se busca el multiplicador en la tabla de 0x7B23 y se multiplica la apuesta a base de SUMARLA a si misma, que es como se multiplica en un Z80.
; ----------------------------------------------------------------------
la_cuenta_de_lo_apostado:
	dec a			;79e1   ; ¿el paso 6?
	jp nz,apostar_paso_7		;79e2
	ld hl,0e130h		;79e5
	dec (hl)			;79e8   ; la espera, un cuadro menos
	ret nz			;79e9
	ld hl,0b1ddh		;79ea   ; el rotulo de siempre
	ld (0e137h),hl		;79ed
	ld a,(0e132h)		;79f0   ; lo que ha salido
	inc a			;79f3   ; el 0xFF...
	jr z,se_pierde_lo_apostado		;79f4
	dec a			;79f6   ; ...y el 0 pierden
	jr nz,se_gana_lo_apostado		;79f7
se_pierde_lo_apostado:
	xor a			;79f9
	ld (0e135h),a		;79fa   ; la bolsa, a cero
	ld (0e136h),a		;79fd
	ld hl,0b1e5h		;7a00   ; y el rotulo de perder
	ld (0e137h),hl		;7a03
	jr pinta_el_resultado		;7a06
se_gana_lo_apostado:
	dec a			;7a08
	ld hl,07b23h		;7a09   ; los multiplicadores
	call 04056h		;7a0c   ; banco 0: a_mas_hl
	ld b,(hl)			;7a0f   ; el que toca
	ld ix,0e135h		;7a10   ; la bolsa
	ld l,(ix+000h)		;7a14
	ld h,(ix+001h)		;7a17
multiplica_sumando:
	dec b			;7a1a   ; una vez menos
	jr z,pinta_el_resultado		;7a1b
	ld c,l			;7a1d   ; el byte bajo de la bolsa
	ld d,001h		;7a1e   ; el 1 que se lleva
	call suma_en_bcd_de_dos_bytes		;7a20   ; sumada a si misma, EN BCD
	inc ix		;7a23
	ld c,h			;7a25   ; y el byte alto
	ld d,001h		;7a26
	call suma_en_bcd_de_dos_bytes		;7a28
	ld a,(ix+000h)		;7a2b   ; ¿se ha pasado de 0x10?
	dec ix		;7a2e
	cp 010h		;7a30
	jr nc,L_7A36		;7a32
	jr multiplica_sumando		;7a34
L_7A36:
	call L_7A60		;7a36   ; entonces, tope
pinta_el_resultado:
	ld de,0b1bdh		;7a39   ; los tres guiones del cartel...
	call L_7E11		;7a3c
	ld de,0b1cah		;7a3f
	call L_7DF7		;7a42
	ld de,(0e137h)		;7a45   ; ...y el que diga lo que ha salido
	call L_7DF7		;7a49
	ld de,0b1eeh		;7a4c
	call L_7DF7		;7a4f
	ld hl,03947h		;7a52   ; la bolsa, pintada
	call pinta_la_bolsa		;7a55
	ld a,020h		;7a58   ; y 0x20 cuadros de espera
	ld (0e130h),a		;7a5a
	jp L_784C		;7a5d
L_7A60:
	ld a,099h		;7a60
	ld (ix+000h),a		;7a62
	and 00fh		;7a65
	ld (ix+001h),a		;7a67
	ret			;7a6a
apostar_paso_7:
	dec a			;7a6b   ; ¿el paso 7?
	jr nz,apostar_paso_8		;7a6c
	ld hl,0e130h		;7a6e
	dec (hl)			;7a71   ; la espera, un cuadro menos
	ret nz			;7a72   ; y hasta cero, nada
	jp L_784C		;7a73
apostar_paso_8:
	dec a			;7a76   ; ¿el paso 8?
	jr nz,L_7AB2		;7a77
	ld hl,03947h		;7a79   ; el sitio del cartel en la pantalla
	call pinta_la_bolsa		;7a7c
	ld ix,0e135h		;7a7f
	ld c,001h		;7a83
	ld d,c			;7a85
	call resta_en_bcd_de_dos_bytes		;7a86
	jr c,L_7AAA		;7a89
	ld ix,0e089h		;7a8b
	ld c,001h		;7a8f
	ld d,c			;7a91
	call suma_en_bcd_de_dos_bytes		;7a92
	ld a,(ix+001h)		;7a95
	cp 010h		;7a98
	call nc,L_7A60		;7a9a
	call 0947bh		;7a9d   ; banco 2
	ld a,(0e051h)		;7aa0   ; la prioridad del efecto que suena
	and a			;7aa3
	ret nz			;7aa4
	ld a,02ch		;7aa5
	jp 0413ah		;7aa7   ; banco 0: pide_sonido_si_esta_activo
L_7AAA:
	ld a,032h		;7aaa
	call 0413ah		;7aac   ; banco 0: pide_sonido_si_esta_activo
	jp L_784C		;7aaf
L_7AB2:
	dec a			;7ab2
	jr nz,se_puede_apostar_otra_vez		;7ab3
	ld a,040h		;7ab5
	ld (0e130h),a		;7ab7
	jp L_784C		;7aba

; ----------------------------------------------------------------------
; ¿OTRA VEZ? Al acabarse la espera mira tres cosas: si el marcador esta a cero se sale, si lo que salio fue 0xFF tambien, y si no, 0xE169 y la cuenta de 0xE134 deciden si se deja seguir apostando.
; ----------------------------------------------------------------------
se_puede_apostar_otra_vez:
	ld hl,0e130h		;7abd
	dec (hl)			;7ac0   ; la espera, un cuadro menos
	ret nz			;7ac1
	ld hl,(0e089h)		;7ac2   ; el marcador, cifras bajas (BCD)
	ld a,l			;7ac5
	or h			;7ac6
	ld a,001h		;7ac7   ; sin dinero no se sigue
	jr z,se_acabo_de_apostar		;7ac9
	ld a,(0e132h)		;7acb   ; lo que salio
	cp 0ffh		;7ace   ; con 0xFF tampoco
	ld a,001h		;7ad0
	jr z,se_acabo_de_apostar		;7ad2
	inc a			;7ad4
	ld hl,0e169h		;7ad5   ; y esto dice cuantas veces se deja
	ld b,(hl)			;7ad8
	dec b			;7ad9
	jr z,L_7AEA		;7ada
	ld hl,0e134h		;7adc
	dec (hl)			;7adf   ; una menos
	jr nz,L_7AEA		;7ae0
se_acabo_de_apostar:
	ld (0e096h),a		;7ae2   ; el aviso que toque
	xor a			;7ae5
	ld (0e134h),a		;7ae6
	ret			;7ae9
L_7AEA:
	ld a,001h		;7aea
	ld (0e12ah),a		;7aec
	ret			;7aef
L_7AF0:
	ld c,003h		;7af0
	ld de,0e12dh		;7af2
	ld hl,0e132h		;7af5
	ld a,(de)			;7af8
	ld (0e133h),a		;7af9
L_7AFC:
	and a			;7afc
	jr nz,compara_con_lo_que_salio		;7afd
	inc (hl)			;7aff
compara_con_lo_que_salio:
	dec c			;7b00   ; ¿queda alguno?
	jr z,lo_que_salio_al_final		;7b01
	inc de			;7b03
	ld a,(de)			;7b04   ; el byte siguiente
	ld b,a			;7b05
	ld a,(0e133h)		;7b06   ; contra lo que llevaba
	cp b			;7b09   ; si es el mismo, sigue valiendo
	jr z,L_7B10		;7b0a
	xor a			;7b0c   ; y si no, se borra: ya no hay racha
	ld (0e133h),a		;7b0d
L_7B10:
	ld a,b			;7b10
	jr L_7AFC		;7b11
lo_que_salio_al_final:
	ld a,(0e133h)		;7b13   ; lo que llevaba
	and a			;7b16
	ret z			;7b17   ; con cero, nada
	cp 005h		;7b18   ; el 5 es el premio gordo...
	jr nz,L_7B1F		;7b1a
	ld (hl),0ffh		;7b1c   ; ...y se marca con 0xFF
	ret			;7b1e
L_7B1F:
	add a,003h		;7b1f   ; y los demas, tres mas
	ld (hl),a			;7b21
	ret			;7b22

; ----------------------------------------------------------------------
; DATOS cuentas_7B23: siete bytes que p01:7A09 indexa con A - 1 y lleva a B,
;   una cuenta
;   0x7b23..0x7b2a  (7 bytes)
DATA_cuentas_7B23:
	defb 001h,002h,004h,008h,00ah,00fh,014h	; 7b23

; ----------------------------------------------------------------------
; DATOS dos_punteros_7B2A: dos palabras que p01:786E y p01:787E eligen con
;   (0xE12B), que va y viene entre 0 y 1
;   0x7b2a..0x7b2e  (4 bytes)
DATA_dos_punteros_7B2A:
	defb 0a4h,039h	; 7b2a
	defb 0aah,039h	; 7b2c

; ----------------------------------------------------------------------
; DATOS bytes_7B2E: seis bytes que p01:79AE indexa y lleva a C
;   0x7b2e..0x7b34  (6 bytes)
DATA_bytes_7B2E:
	defb 07ch,088h,08ch,080h,090h,084h	; 7b2e

; ----------------------------------------------------------------------
; DATOS dieciseis_bytes_7B34: dieciseis bytes que p01:79A6 indexa con el
;   nibble bajo de A y escribe en (DE)
;   0x7b34..0x7b44  (16 bytes)
DATA_dieciseis_bytes_7B34:
	defb 000h,001h,004h,003h,002h,000h,001h,000h,001h,002h,005h,000h,001h,000h,002h,003h	; 7b34  ................

; ======================================================================
; CODIGO 0x7b44..0x7b50  (12 bytes)
; ======================================================================


L_7B44:
	ld hl,0e502h		;7b44
	ld de,0eea8h		;7b47
	ld bc,00004h		;7b4a
	ldir		;7b4d
	ret			;7b4f

; ----------------------------------------------------------------------
; DATOS codigo_muerto_7B50: catorce bytes que se leen limpios como codigo -`ld
;   a,(0E0C5h) / and a / ret nz / ld a,(0E115h) / and a / ret z`...- pero a
;   los que no salta nadie
;   0x7b50..0x7b5e  (14 bytes)
DATA_codigo_muerto_7B50:
	defb 03ah,0c5h,0e0h,0a7h,0c0h,03ah,015h,0e1h,0a7h,0c8h,032h,021h,0e2h,0c9h	; 7b50  :....:....2!..

; ======================================================================
; CODIGO 0x7b5e..0x7cee  (400 bytes)
; ======================================================================


L_7B5E:
	di			;7b5e   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;7b5f
	ld (08000h),a		;7b61   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;7b64   ; y en su copia de RAM
	ei			;7b67   ; el mapa ya esta entero
	di			;7b68   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;7b69
	ld (0a000h),a		;7b6b   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;7b6e   ; y en su copia de RAM
	ei			;7b71   ; el mapa ya esta entero
	ld a,r		;7b72
	and 007h		;7b74
	ld hl,0ba0bh		;7b76
	call 04055h		;7b79   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;7b7c
	inc hl			;7b7d
	ld d,(hl)			;7b7e
	call 042bch		;7b7f   ; banco 0: pinta_guion_con_mascara
	jp L_7C8A		;7b82
L_7B85:
	di			;7b85   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;7b86
	ld (08000h),a		;7b88   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;7b8b   ; y en su copia de RAM
	ei			;7b8e   ; el mapa ya esta entero
	di			;7b8f   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;7b90
	ld (0a000h),a		;7b92   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;7b95   ; y en su copia de RAM
	ei			;7b98   ; el mapa ya esta entero
	call L_7BAE		;7b99
L_7B9C:
	ld a,(de)			;7b9c
	inc de			;7b9d
	ld (hl),a			;7b9e
	ld a,020h		;7b9f
	call 04056h		;7ba1   ; banco 0: a_mas_hl
	djnz L_7B9C		;7ba4
	call L_7C8A		;7ba6
	ld a,(0e0b8h)		;7ba9
	and a			;7bac
	ret			;7bad
L_7BAE:
	ld hl,0e0b8h		;7bae
	dec (hl)			;7bb1
L_7BB2:
	ld a,(hl)			;7bb2
	ld hl,0eb80h		;7bb3
	srl a		;7bb6
	jr c,L_7BBC		;7bb8
	xor 01fh		;7bba
L_7BBC:
	add a,060h		;7bbc
	call 04056h		;7bbe   ; banco 0: a_mas_hl
	ld b,015h		;7bc1
	ret			;7bc3
L_7BC4:
	di			;7bc4   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;7bc5
	ld (08000h),a		;7bc7   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;7bca   ; y en su copia de RAM
	ei			;7bcd   ; el mapa ya esta entero
	di			;7bce   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;7bcf
	ld (0a000h),a		;7bd1   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;7bd4   ; y en su copia de RAM
	ei			;7bd7   ; el mapa ya esta entero
	ld hl,0e0b8h		;7bd8
	call L_7BB2		;7bdb
	ld b,005h		;7bde
	ld a,0a0h		;7be0
	call 04056h		;7be2   ; banco 0: a_mas_hl
	jr L_7B9C		;7be5
L_7BE7:
	di			;7be7   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;7be8
	ld (08000h),a		;7bea   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;7bed   ; y en su copia de RAM
	ei			;7bf0   ; el mapa ya esta entero
	di			;7bf1   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;7bf2
	ld (0a000h),a		;7bf4   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;7bf7   ; y en su copia de RAM
	ei			;7bfa   ; el mapa ya esta entero
	call 0418ch		;7bfb   ; banco 0: descomprime
	jp L_7C8A		;7bfe
L_7C01:
	di			;7c01   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7c02
	ld (08000h),a		;7c04   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7c07   ; y en su copia de RAM
	ei			;7c0a   ; el mapa ya esta entero
	di			;7c0b   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7c0c
	ld (0a000h),a		;7c0e   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7c11   ; y en su copia de RAM
	ei			;7c14   ; el mapa ya esta entero
	ld a,(0e537h)		;7c15
	ld hl,07ceeh		;7c18
	call 04055h		;7c1b   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;7c1e
	inc hl			;7c1f
	ld d,(hl)			;7c20
	ld (0e538h),de		;7c21
	ld hl,0e531h		;7c25
	ld a,(hl)			;7c28
	add a,a			;7c29
	ld c,a			;7c2a
	add a,a			;7c2b
	add a,c			;7c2c
	ld c,a			;7c2d
	inc l			;7c2e
	ld a,(hl)			;7c2f
	add a,a			;7c30
	add a,c			;7c31
	ld hl,0a842h		;7c32
	call 04056h		;7c35   ; banco 0: a_mas_hl
	ld a,(hl)			;7c38
	inc hl			;7c39
	ld h,(hl)			;7c3a
	ld l,a			;7c3b
	jr L_7C74		;7c3c
L_7C3E:
	di			;7c3e   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7c3f
	ld (08000h),a		;7c41   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7c44   ; y en su copia de RAM
	ei			;7c47   ; el mapa ya esta entero
	di			;7c48   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7c49
	ld (0a000h),a		;7c4b   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7c4e   ; y en su copia de RAM
	ei			;7c51   ; el mapa ya esta entero
	ld a,(0e530h)		;7c52
	and a			;7c55
	jr z,L_7C8A		;7c56
	cp 003h		;7c58
	ld hl,0a854h		;7c5a
	jr c,L_7C74		;7c5d
	ld hl,0ada2h		;7c5f
	call 0418ch		;7c62   ; banco 0: descomprime
	ld hl,0e531h		;7c65
	ld a,(hl)			;7c68
	add a,a			;7c69
	ld hl,0ab60h		;7c6a
	call 04056h		;7c6d   ; banco 0: a_mas_hl
	ld a,(hl)			;7c70
	inc hl			;7c71
	ld h,(hl)			;7c72
	ld l,a			;7c73
L_7C74:
	ld de,(0e538h)		;7c74
L_7C78:
	dec hl			;7c78
L_7C79:
	inc hl			;7c79
	ld a,(hl)			;7c7a
	call 0405bh		;7c7b   ; banco 0: a_mas_de
	inc hl			;7c7e
copia_hasta_el_0xFF:
	ld a,(hl)			;7c7f   ; el byte
	inc a			;7c80   ; el 0xFF cierra...
	jr z,L_7C8A		;7c81
	inc a			;7c83   ; ...y el 0xFE abre el trozo siguiente
	jr z,L_7C79		;7c84
	ldi		;7c86   ; y lo demas se copia tal cual
	jr copia_hasta_el_0xFF		;7c88
L_7C8A:
	di			;7c8a   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;7c8b
	ld (08000h),a		;7c8d   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;7c90   ; y en su copia de RAM
	ei			;7c93   ; el mapa ya esta entero
	di			;7c94   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;7c95
	ld (0a000h),a		;7c97   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;7c9a   ; y en su copia de RAM
	ei			;7c9d   ; el mapa ya esta entero
	ret			;7c9e
L_7C9F:
	di			;7c9f   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7ca0
	ld (08000h),a		;7ca2   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7ca5   ; y en su copia de RAM
	ei			;7ca8   ; el mapa ya esta entero
	di			;7ca9   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7caa
	ld (0a000h),a		;7cac   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7caf   ; y en su copia de RAM
	ei			;7cb2   ; el mapa ya esta entero
	ld a,(0e537h)		;7cb3
	ld hl,07ceeh		;7cb6
	call 04055h		;7cb9   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;7cbc
	inc hl			;7cbd
	ld d,(hl)			;7cbe
	ld hl,0e531h		;7cbf
	ld a,(hl)			;7cc2
	add a,a			;7cc3
	ld c,a			;7cc4
	add a,a			;7cc5
	add a,c			;7cc6
	ld c,a			;7cc7
	inc l			;7cc8
	ld a,(hl)			;7cc9
	add a,a			;7cca
	add a,c			;7ccb
	ld hl,0a842h		;7ccc
	call 04056h		;7ccf   ; banco 0: a_mas_hl
	ld a,(hl)			;7cd2
	inc hl			;7cd3
	ld h,(hl)			;7cd4
	ld l,a			;7cd5
	dec hl			;7cd6
L_7CD7:
	inc hl			;7cd7
	ld a,(hl)			;7cd8
	call 0405bh		;7cd9   ; banco 0: a_mas_de
	inc hl			;7cdc
llena_de_unos_hasta_el_0xFF:
	ld a,(hl)			;7cdd   ; el byte
	inc a			;7cde   ; el 0xFF cierra...
	jr z,L_7CEB		;7cdf
	inc a			;7ce1   ; ...y el 0xFE abre el trozo siguiente
	jr z,L_7CD7		;7ce2
	ld a,001h		;7ce4   ; y lo demas se marca con un 1
	ld (de),a			;7ce6
	inc de			;7ce7
	inc hl			;7ce8
	jr llena_de_unos_hasta_el_0xFF		;7ce9
L_7CEB:
	jp L_7C8A		;7ceb

; ----------------------------------------------------------------------
; DATOS cinco_bases_E538: cinco direcciones de RAM (0xED2B a 0xED2F) que
;   p01:7C18 y p01:7CB6 indexan con (0xE537) y dejan en 0xE538, la base de las
;   tiras del banco 11
;   0x7cee..0x7cf8  (10 bytes)
DATA_cinco_bases_E538:
	defb 02bh,0edh	; 7cee
	defb 02ch,0edh	; 7cf0
	defb 02dh,0edh	; 7cf2
	defb 02eh,0edh	; 7cf4
	defb 02fh,0edh	; 7cf6

; ======================================================================
; CODIGO 0x7cf8..0x7d6c  (116 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LAS CUATRO TIRAS DEL BANCO 11, A LA VRAM. Mete los bancos 10 y 11 y recorre los cuatro registros de 0xE550 con sus sprites a partir del 10. Cada registro, segun su primer byte, o copia dos bytes sueltos (el tipo 1) o descomprime una tira entera de las de 0xAD62.
; ----------------------------------------------------------------------
las_cuatro_tiras_a_la_vram:
	di			;7cf8   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7cf9
	ld (08000h),a		;7cfb   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7cfe   ; y en su copia de RAM
	ei			;7d01   ; el mapa ya esta entero
	di			;7d02   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7d03
	ld (0a000h),a		;7d05   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7d08   ; y en su copia de RAM
	ei			;7d0b   ; el mapa ya esta entero
	ld b,004h		;7d0c   ; cuatro registros
	ld hl,0e550h		;7d0e   ; los registros
	ld de,0eea8h		;7d11   ; y sus sprites, desde el 10
una_tira_a_la_vram:
	ld a,(hl)			;7d14   ; el tipo del registro
	dec a			;7d15   ; el 1 va aparte
	jr z,dos_bytes_sueltos		;7d16
	push hl			;7d18
	push de			;7d19
	dec a			;7d1a
	ld c,a			;7d1b
	ld hl,07d6ch		;7d1c   ; las cuatro bases de destino
	ld a,b			;7d1f
	dec a			;7d20
	call 04055h		;7d21   ; la que toca a este registro
	ld e,(hl)			;7d24
	inc hl			;7d25
	ld d,(hl)			;7d26
	ld a,c			;7d27
	ld hl,0ad62h		;7d28   ; las tiras del banco 11
	call 04055h		;7d2b   ; banco 0: dos_por_a_mas_hl
	ld a,(hl)			;7d2e   ; la que toca
	inc hl			;7d2f
	ld h,(hl)			;7d30
	ld l,a			;7d31
	ld c,0ffh		;7d32
	dec hl			;7d34   ; y atras uno, que el bucle empieza adelantando
lee_el_desplazamiento_de_la_tira:
	inc hl			;7d35
	ld a,(hl)			;7d36   ; el desplazamiento, 16 bits
	inc hl			;7d37
	push hl			;7d38
	ld h,(hl)			;7d39
	ld l,a			;7d3a
	add hl,de			;7d3b   ; sumado a la base
	ex de,hl			;7d3c
	pop hl			;7d3d
	inc hl			;7d3e
copia_los_bytes_de_la_tira:
	ld a,(hl)			;7d3f   ; el byte
	inc a			;7d40   ; el 0xFF cierra la tira...
	jr z,al_registro_siguiente_de_las_tiras		;7d41
	inc a			;7d43   ; ...y el 0xFE abre el trozo siguiente
	jr z,lee_el_desplazamiento_de_la_tira		;7d44
	ldi		;7d46   ; y lo demas, se copia tal cual
	jr copia_los_bytes_de_la_tira		;7d48
al_registro_siguiente_de_las_tiras:
	pop de			;7d4a
	pop hl			;7d4b
	ld a,008h		;7d4c   ; ocho bytes el registro...
	call 04056h		;7d4e   ; banco 0: a_mas_hl
	ld a,004h		;7d51   ; ...y cuatro el sprite
	call 0405bh		;7d53   ; banco 0: a_mas_de
	jr a_la_tira_siguiente		;7d56
dos_bytes_sueltos:
	inc l			;7d58
	ld a,(hl)			;7d59   ; el primer byte...
	ld (de),a			;7d5a
	inc l			;7d5b
	inc e			;7d5c
	ld a,(hl)			;7d5d   ; ...y el segundo
	ld (de),a			;7d5e
	ld a,006h		;7d5f   ; seis mas hasta el registro siguiente
	call 04056h		;7d61   ; banco 0: a_mas_hl
	inc e			;7d64
	inc e			;7d65
	inc e			;7d66
a_la_tira_siguiente:
	djnz una_tira_a_la_vram		;7d67
	jp L_7C8A		;7d69

; ----------------------------------------------------------------------
; DATOS cuatro_bases_7D6C: cuatro direcciones de RAM (0xEE3A, 0xEE33, 0xEE2C,
;   0xEE25) que p01:7D1C indexa con B - 1: la base DE de las tiras largas del
;   banco 11
;   0x7d6c..0x7d74  (8 bytes)
DATA_cuatro_bases_7D6C:
	defb 03ah,0eeh	; 7d6c
	defb 033h,0eeh	; 7d6e
	defb 02ch,0eeh	; 7d70
	defb 025h,0eeh	; 7d72

; ======================================================================
; CODIGO 0x7d74..0x7ef6  (386 bytes)
; ======================================================================


L_7D74:
	di			;7d74   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7d75
	ld (08000h),a		;7d77   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7d7a   ; y en su copia de RAM
	ei			;7d7d   ; el mapa ya esta entero
	di			;7d7e   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7d7f
	ld (0a000h),a		;7d81   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7d84   ; y en su copia de RAM
	ei			;7d87   ; el mapa ya esta entero
	ld hl,(0e53ah)		;7d88
	ld e,(hl)			;7d8b
	inc hl			;7d8c
	ld d,(hl)			;7d8d
	inc hl			;7d8e
	ld a,(hl)			;7d8f
	inc a			;7d90
	jr z,L_7D99		;7d91
	dec a			;7d93
	inc hl			;7d94
	ld (de),a			;7d95
	ld (0e53ah),hl		;7d96
L_7D99:
	jp L_7C8A		;7d99
L_7D9C:
	di			;7d9c   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7d9d
	ld (08000h),a		;7d9f   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7da2   ; y en su copia de RAM
	ei			;7da5   ; el mapa ya esta entero
	di			;7da6   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7da7
	ld (0a000h),a		;7da9   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7dac   ; y en su copia de RAM
	ei			;7daf   ; el mapa ya esta entero
	jp L_7C78		;7db0
L_7DB3:
	di			;7db3   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;7db4
	ld (08000h),a		;7db6   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;7db9   ; y en su copia de RAM
	ei			;7dbc   ; el mapa ya esta entero
	di			;7dbd   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;7dbe
	ld (0a000h),a		;7dc0   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;7dc3   ; y en su copia de RAM
	ei			;7dc6   ; el mapa ya esta entero
	ld hl,0bc99h		;7dc7
	ld de,0eee0h		;7dca
	ld bc,00020h		;7dcd
	ldir		;7dd0
	jp L_7C8A		;7dd2
L_7DD5:
	di			;7dd5   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;7dd6
	ld (08000h),a		;7dd8   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;7ddb   ; y en su copia de RAM
	ei			;7dde   ; el mapa ya esta entero
	di			;7ddf   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;7de0
	ld (0a000h),a		;7de2   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;7de5   ; y en su copia de RAM
	ei			;7de8   ; el mapa ya esta entero
	ld hl,0bcb9h		;7de9
	ld de,0eee0h		;7dec
	ld bc,00020h		;7def
	ldir		;7df2
	jp L_7C8A		;7df4
L_7DF7:
	di			;7df7   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7df8
	ld (08000h),a		;7dfa   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7dfd   ; y en su copia de RAM
	ei			;7e00   ; el mapa ya esta entero
	di			;7e01   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7e02
	ld (0a000h),a		;7e04   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7e07   ; y en su copia de RAM
	ei			;7e0a   ; el mapa ya esta entero
	call 042bch		;7e0b   ; banco 0: pinta_guion_con_mascara
	jp L_7C8A		;7e0e
L_7E11:
	di			;7e11   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7e12
	ld (08000h),a		;7e14   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7e17   ; y en su copia de RAM
	ei			;7e1a   ; el mapa ya esta entero
	di			;7e1b   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7e1c
	ld (0a000h),a		;7e1e   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7e21   ; y en su copia de RAM
	ei			;7e24   ; el mapa ya esta entero
	ld c,000h		;7e25
	call 042beh		;7e27   ; banco 0: pinta_guion_lee_destino
	jp L_7C8A		;7e2a
L_7E2D:
	di			;7e2d   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7e2e
	ld (08000h),a		;7e30   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7e33   ; y en su copia de RAM
	ei			;7e36   ; el mapa ya esta entero
	di			;7e37   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7e38
	ld (0a000h),a		;7e3a   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7e3d   ; y en su copia de RAM
	ei			;7e40   ; el mapa ya esta entero
	call 0418ch		;7e41   ; banco 0: descomprime
	jp L_7C8A		;7e44
L_7E47:
	ld a,(0e0a1h)		;7e47   ; el DECORADO, de 0 a 9
	cp 008h		;7e4a
	ret nz			;7e4c
	ld a,(0e003h)		;7e4d   ; el contador de cuadros
	and 007h		;7e50
	ret nz			;7e52
	ld b,00ch		;7e53
	ld hl,0e570h		;7e55
la_cuenta_y_el_paso_del_centelleo:
	dec (hl)			;7e58   ; un cuadro menos
	ld a,(hl)			;7e59
	inc l			;7e5a
	dec a			;7e5b   ; al llegar a 1...
	jr z,L_7E6D		;7e5c
	inc a			;7e5e   ; ...o a cero, se cambia de paso
	jr z,L_7E70		;7e5f
	ld a,b			;7e61
	cp 008h		;7e62   ; por debajo de 8, un paso...
	ld c,0f1h		;7e64
	jr c,L_7E6A		;7e66
	ld c,002h		;7e68   ; ...y por encima, el otro
L_7E6A:
	ld (hl),c			;7e6a
	jr escribe_los_tres_bytes_del_centelleo		;7e6b
L_7E6D:
	inc (hl)			;7e6d
	jr escribe_los_tres_bytes_del_centelleo		;7e6e
L_7E70:
	inc (hl)			;7e70
	dec l			;7e71
	ld (hl),020h		;7e72
	inc l			;7e74
escribe_los_tres_bytes_del_centelleo:
	ld a,(hl)			;7e75   ; el byte
	inc l			;7e76
	ld e,(hl)			;7e77   ; y donde va
	inc l			;7e78
	ld d,(hl)			;7e79
	ld (de),a			;7e7a   ; escrito
	inc l			;7e7b   ; tres bytes por entrada
	djnz la_cuenta_y_el_paso_del_centelleo		;7e7c
	ret			;7e7e
L_7E7F:
	call 04224h		;7e7f   ; banco 0: borra_la_pantalla_entera
	xor a			;7e82
	ld (0e08fh),a		;7e83
	call 09346h		;7e86   ; banco 2
	ld hl,0f0f6h		;7e89
	inc (hl)			;7e8c
	ld a,(hl)			;7e8d
	and 007h		;7e8e
	ld b,a			;7e90
	add a,a			;7e91
	add a,b			;7e92
	ld hl,07ef6h		;7e93
	call 04056h		;7e96   ; banco 0: a_mas_hl
	ld a,(hl)			;7e99
	ld (0e092h),a		;7e9a   ; la FASE, de 1 a 24
	inc hl			;7e9d
	ld e,(hl)			;7e9e
	inc hl			;7e9f
	ld d,(hl)			;7ea0
	ld (0e13ah),de		;7ea1
	call 046e3h		;7ea5   ; banco 0: monta_la_fase_desde_el_decorado
	ld hl,(0e08dh)		;7ea8   ; lo que queda de fase
	push hl			;7eab
	ld hl,00000h		;7eac
	ld (0e089h),hl		;7eaf   ; el marcador, cifras bajas (BCD)
	ld (0e08dh),hl		;7eb2   ; lo que queda de fase
	ld (0e08bh),hl		;7eb5   ; el TIEMPO que queda
	call 0463fh		;7eb8   ; banco 0: empieza_una_vida
	call 09431h		;7ebb   ; banco 2
	pop hl			;7ebe
	ld (0e08dh),hl		;7ebf   ; lo que queda de fase
	ld hl,00100h		;7ec2
	ld (0e08bh),hl		;7ec5   ; el TIEMPO que queda
	call 04232h		;7ec8   ; banco 0: borra_el_area_de_juego
	call 051cdh		;7ecb
	call 04995h		;7ece
	call 049fch		;7ed1
	call 049d2h		;7ed4
	call 0966bh		;7ed7   ; banco 2
	call 057fbh		;7eda
	call 09689h		;7edd   ; banco 2
	call monta_el_decorado		;7ee0
	call anima_el_fondo		;7ee3
	call 04265h		;7ee6   ; banco 0: sube_el_area_de_juego
	ld c,002h		;7ee9
	call 0ba2fh		;7eeb
	xor a			;7eee
	ld (0e009h),a		;7eef
	ld (0e003h),a		;7ef2   ; el contador de cuadros
	ret			;7ef5

; ----------------------------------------------------------------------
; DATOS escenas_de_la_demo: ocho entradas de 3 bytes que p01:7E93 elige con
;   (0xF0F6) & 7: la fase (0xE092) y el puntero a su partida grabada (0xE13A).
;   Las fases son 13, 14, 15, 17, 18, 19, 20, 24
;   0x7ef6..0x7f0e  (24 bytes)
DATA_escenas_de_la_demo:
	defb 00dh,030h,0b4h	; 7ef6
	defb 00eh,0f7h,0b4h	; 7ef9
	defb 00fh,0b0h,0b5h	; 7efc
	defb 011h,07fh,0b6h	; 7eff
	defb 012h,038h,0b7h	; 7f02
	defb 013h,027h,0b8h	; 7f05
	defb 014h,072h,0b9h	; 7f08
	defb 018h,007h,0bah	; 7f0b

; ======================================================================
; CODIGO 0x7f0e..0x7f62  (84 bytes)
; ======================================================================


L_7F0E:
	jp 0451ch		;7f0e   ; banco 0: cuadro
L_7F11:
	di			;7f11   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;7f12
	ld (08000h),a		;7f14   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;7f17   ; y en su copia de RAM
	ei			;7f1a   ; el mapa ya esta entero
	di			;7f1b   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;7f1c
	ld (0a000h),a		;7f1e   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;7f21   ; y en su copia de RAM
	ei			;7f24   ; el mapa ya esta entero
	di			;7f25
	ld de,(0e13ah)		;7f26
	ld a,(0e009h)		;7f2a
	and a			;7f2d
	jr nz,L_7F40		;7f2e
	inc de			;7f30
	inc de			;7f31
	ld a,(de)			;7f32
	inc a			;7f33
	jr z,L_7F5D		;7f34
	ld (0e13ah),de		;7f36
	inc de			;7f3a
	ld a,(de)			;7f3b
	ld (0e009h),a		;7f3c
	dec de			;7f3f
L_7F40:
	ld hl,0e009h		;7f40
	dec (hl)			;7f43
	ld a,(de)			;7f44
	call 044beh		;7f45   ; banco 0: guarda_lo_que_se_acaba_de_pulsar
L_7F48:
	di			;7f48   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;7f49
	ld (08000h),a		;7f4b   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;7f4e   ; y en su copia de RAM
	ei			;7f51   ; el mapa ya esta entero
	di			;7f52   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;7f53
	ld (0a000h),a		;7f55   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;7f58   ; y en su copia de RAM
	ei			;7f5b   ; el mapa ya esta entero
	ret			;7f5c
L_7F5D:
	ld (0e097h),a		;7f5d   ; la bandera de que la fase se ha acabado
	jr L_7F48		;7f60

; ----------------------------------------------------------------------
; DATOS relleno_del_banco_1: 158 bytes a 0xFF hasta el final de los 8 KB del
;   banco: espacio libre
;   0x7f62..0x8000  (158 bytes)
DATA_relleno_del_banco_1:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f62  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f72  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f82  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f92  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fa2  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fb2  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fc2  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fd2  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fe2  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7ff2  ..............
