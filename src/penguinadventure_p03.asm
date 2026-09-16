; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS codigo_que_viene_del_banco_2: el final de un `ld a,4` que empieza en
;   p02:9FFF y el codigo que le sigue sin salir de la ranura: `call 0A8F5h /
;   ld a,(0E0A2h) / cp 3 / ret c / ld a,4 / ld (0EE83h),a`... El trazador por
;   bancos no lo lista porque la instruccion cruza la frontera de 0xA000; se
;   deja como datos, con su lectura aqui
;   0xa000..0xa019  (25 bytes)
DATA_codigo_que_viene_del_banco_2:
	defb 004h,0cdh,0f5h,0a8h,03ah,0a2h,0e0h,0feh,003h,0d8h,03eh,004h,032h,083h,0eeh,032h	; a000  ....:.....>.2..2
	defb 087h,0eeh,032h,08bh,0eeh,032h,08fh,0eeh,0c9h	; a010  ..2..2...

; ======================================================================
; CODIGO 0xa019..0xa093  (122 bytes)
; ======================================================================


L_A019:
	call vacia_la_barra_y_la_pinta		;a019
	ld a,(0e003h)		;a01c   ; el contador de cuadros
	rra			;a01f
	ret c			;a020
	ld a,(0e204h)		;a021   ; la Y en la pantalla de lo que se maneja
	add a,001h		;a024
	ld (0e204h),a		;a026   ; la Y en la pantalla de lo que se maneja
	cp 0c0h		;a029
	jr c,L_A033		;a02b
	ld a,011h		;a02d
	ld (0e203h),a		;a02f   ; el ESTADO de lo que se maneja
	ret			;a032
L_A033:
	call L_A8DB		;a033
	ld a,004h		;a036
	jp pon_la_pose_en_lo_que_se_maneja		;a038
L_A03B:
	ld a,(0e003h)		;a03b   ; el contador de cuadros
	rra			;a03e
	ret c			;a03f
	ld a,(0e204h)		;a040   ; la Y en la pantalla de lo que se maneja
	sub 001h		;a043
	ld (0e204h),a		;a045   ; la Y en la pantalla de lo que se maneja
	cp 098h		;a048
	jr nc,L_A07B		;a04a
	ld a,004h		;a04c
	ld (0e203h),a		;a04e   ; el ESTADO de lo que se maneja
	ld a,020h		;a051
	ld (0e20eh),a		;a053
	ld a,0b4h		;a056
	ld l,a			;a058
	ld a,(0e205h)		;a059   ; la X en la pantalla de lo que se maneja
	ld h,a			;a05c
	ld (0ee90h),hl		;a05d   ; el hueco de sprite 4
	add a,010h		;a060
	ld h,a			;a062
	ld (0ee94h),hl		;a063   ; el hueco de sprite 5
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
	jp pon_la_pose_en_lo_que_se_maneja		;a080

; ----------------------------------------------------------------------
; VACIAR LA BARRA Y PINTARLA. Pone a cero el nivel de la barra de nueve (0xE4C0) y salta a pintarla al banco 0. Es lo primero que hacen las tres secuencias de este banco, porque durante ellas la barra no cuenta.
; ----------------------------------------------------------------------
vacia_la_barra_y_la_pinta:
	xor a			;a083
	ld (0e4c0h),a		;a084   ; la barra, a cero
	jp 05f77h		;a087   ; banco 0: y a pintarla

; ----------------------------------------------------------------------
; LA PRIMERA SECUENCIA, EN TRES PASOS. Despacha por 0xE21D: 0 espera treinta y dos cuadros, 1 baja la figura y 2 la deja quieta hasta que se acaba la cuenta.
; ----------------------------------------------------------------------
secuencia_de_A08A:
	call vacia_la_barra_y_la_pinta		;a08a
	ld a,(0e21dh)		;a08d   ; por que paso va
	call 04060h		;a090   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_A090: 3 punteros pegados detras del `call despacha` de
;   p03:A090: la rutina a la que se salta con A
;   0xa093..0xa099  (6 bytes)
DATA_despacho_de_A090:
	defb 099h,0a0h	; a093
	defb 0c2h,0a0h	; a095
	defb 06ah,0a1h	; a097

; ======================================================================
; CODIGO 0xa099..0xa183  (234 bytes)
; ======================================================================


secuencia_de_A08A_espera:
	call L_A8DB		;a099   ; los cuatro sprites, colocados
	ld a,00bh		;a09c   ; y la pose 11
	call pon_la_pose_en_lo_que_se_maneja		;a09e
	ld a,(0e0a2h)		;a0a1   ; en el modo 1...
	dec a			;a0a4
	jr nz,secuencia_de_A08A_cuenta		;a0a5
	ld a,004h		;a0a7
	ld (0ee83h),a		;a0a9   ; ...los cuatro se pintan de azul
	ld (0ee87h),a		;a0ac
	ld (0ee8bh),a		;a0af
	ld (0ee8fh),a		;a0b2
secuencia_de_A08A_cuenta:
	ld hl,0e21bh		;a0b5
	inc (hl)			;a0b8   ; un cuadro mas
	ld a,(hl)			;a0b9
	cp 020h		;a0ba   ; y a los treinta y dos...
	ret nz			;a0bc
	ld hl,0e21dh		;a0bd   ; ...al paso siguiente
	inc (hl)			;a0c0
	ret			;a0c1

; ----------------------------------------------------------------------
; BAJAR LA FIGURA. Dos filas por cuadro hasta la 0x90, o hasta la 0xC0 si el juego esta en el modo 1. Al llegar suena el efecto 0x8F y arranca una cuenta de 0x80 cuadros.
; ----------------------------------------------------------------------
secuencia_de_A08A_baja:
	ld hl,0e204h		;a0c2   ; la fila
	ld a,(0e0a2h)		;a0c5   ; el modo en el que esta el juego
	dec a			;a0c8
	jr nz,L_A0D3		;a0c9
	ld a,(hl)			;a0cb   ; en el modo 1 llega hasta la 0xC0...
	cp 0c0h		;a0cc
	jp nc,la_figura_llega_abajo_en_el_modo_1		;a0ce
	jr L_A0D8		;a0d1
L_A0D3:
	ld a,(hl)			;a0d3   ; ...y en los demas hasta la 0x90
	cp 090h		;a0d4
	jr nc,la_figura_llega_abajo		;a0d6
L_A0D8:
	inc (hl)			;a0d8   ; dos filas por cuadro
	inc (hl)			;a0d9

; ----------------------------------------------------------------------
; LA FIGURA DE SEIS SPRITES. No es el cuadro de dos por dos de siempre: son seis sprites colocados a mano uno a uno, y sus seis parejas de dibujo y color salen de los doce bytes de 0xA183 -0x0A, 0x0A, 0x0A, 0x0E, 1 y 1-. En el modo 1 se les pisa el color de los sprites 4 y 5 con el 4, el azul.
; ----------------------------------------------------------------------
coloca_la_figura_de_seis:
	ld hl,(0e204h)		;a0da   ; la fila y la columna de lo que se maneja
	ld a,l			;a0dd
	add a,008h		;a0de   ; ocho filas mas abajo
	ld l,a			;a0e0
	ld d,h			;a0e1
	ld a,003h		;a0e2   ; y tres columnas a la derecha
	add a,h			;a0e4
	ld h,a			;a0e5
	ld (0ee80h),hl		;a0e6   ; el sprite 0
	ld a,00ah		;a0e9   ; diez columnas mas
	add a,h			;a0eb
	ld h,a			;a0ec
	ld (0ee84h),hl		;a0ed   ; el sprite 1 de lo que se maneja: arriba a la derecha
	ld a,003h		;a0f0   ; tres filas y cinco columnas atras
	add a,l			;a0f2
	ld l,a			;a0f3
	ld a,h			;a0f4
	sub 005h		;a0f5
	ld h,a			;a0f7
	ld (0ee88h),hl		;a0f8   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ld a,005h		;a0fb   ; cinco columnas mas
	add a,l			;a0fd
	ld l,a			;a0fe
	ld (0ee8ch),hl		;a0ff   ; el sprite 3 de lo que se maneja: abajo a la derecha
	ld a,008h		;a102   ; ocho filas mas abajo, y a la columna de partida
	add a,l			;a104
	ld l,a			;a105
	ld h,d			;a106
	ld (0ee90h),hl		;a107   ; el hueco de sprite 4
	ld a,010h		;a10a   ; y el ultimo, dieciseis columnas a la derecha
	add a,h			;a10c
	ld h,a			;a10d
	ld (0ee94h),hl		;a10e   ; el hueco de sprite 5
	ld hl,0a183h		;a111   ; los doce bytes de dibujo y color
	ld de,0ee82h		;a114   ; al byte 2 del sprite 0
	ldi		;a117
	ldi		;a119
	inc e			;a11b   ; saltandose la fila y la columna de cada uno
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
	ld a,(0e0a2h)		;a139   ; en el modo 1...
	dec a			;a13c
	ret nz			;a13d
	ld a,004h		;a13e
	ld (0ee93h),a		;a140   ; ...los sprites 4 y 5 tambien de azul
	ld (0ee97h),a		;a143
	ret			;a146
la_figura_llega_abajo:
	ld a,090h		;a147   ; clavada en la fila 0x90
	ld (0e204h),a		;a149   ; la Y en la pantalla de lo que se maneja
	call coloca_la_figura_de_seis		;a14c
	ld hl,0e21dh		;a14f   ; al paso siguiente
	inc (hl)			;a152
	ld hl,0e21bh		;a153   ; con una cuenta de 0x80 cuadros
	ld (hl),080h		;a156
	ld a,08fh		;a158   ; y el efecto 0x8F
	jp 0413ah		;a15a   ; banco 0: pide_sonido_si_esta_activo
la_figura_llega_abajo_en_el_modo_1:
	ld a,0c0h		;a15d   ; aqui la fila es la 0xC0
	ld (0e204h),a		;a15f   ; la Y en la pantalla de lo que se maneja
	call coloca_la_figura_de_seis		;a162
	xor a			;a165   ; y se limpian los avisos: la secuencia ha terminado
	ld (0e096h),a		;a166   ; los avisos que deja el cuadro
	ret			;a169
secuencia_de_A08A_espera_al_final:
	ld hl,0e21bh		;a16a
	dec (hl)			;a16d   ; se descuenta la cuenta
	jr z,secuencia_de_A08A_acaba		;a16e
	ld a,(hl)			;a170
	cp 040h		;a171   ; justo a la mitad...
	ret nz			;a173
	ld a,(0e0e0h)		;a174   ; ...y solo si 0xE0E0 esta puesto...
	and a			;a177
	ret z			;a178
	ld a,083h		;a179   ; ...suena el efecto 0x83
	jp 0413ah		;a17b   ; banco 0: pide_sonido_si_esta_activo
secuencia_de_A08A_acaba:
	xor a			;a17e
	ld (0e096h),a		;a17f   ; sin avisos: se acabo
	ret			;a182

; ----------------------------------------------------------------------
; DATOS doce_bytes_a_los_sprites: doce bytes que p03:A111 copia con ldi a la
;   tabla de atributos a partir de 0xEE82, dos por sprite y saltando los otros
;   dos
;   0xa183..0xa18f  (12 bytes)
DATA_doce_bytes_a_los_sprites:
	defb 0d0h,00ah	; a183
	defb 0d4h,00ah	; a185
	defb 0b8h,00ah	; a187
	defb 0bch,00eh	; a189
	defb 0d8h,001h	; a18b
	defb 0dch,001h	; a18d

; ======================================================================
; CODIGO 0xa18f..0xa198  (9 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LA SEGUNDA SECUENCIA, TAMBIEN EN TRES PASOS. La misma forma que la de 0xA08A y el mismo 0xE21D, pero aqui el primer paso puede saltarse el segundo: si 0xE0D3 esta puesto, sube el paso dos veces de una vez.
; ----------------------------------------------------------------------
secuencia_de_A18F:
	call vacia_la_barra_y_la_pinta		;a18f
	ld a,(0e21dh)		;a192   ; por que paso va
	call 04060h		;a195   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_A195: 3 punteros pegados detras del `call despacha` de
;   p03:A195: la rutina a la que se salta con A
;   0xa198..0xa19e  (6 bytes)
DATA_despacho_de_A195:
	defb 09eh,0a1h	; a198
	defb 0bfh,0a1h	; a19a
	defb 0eeh,0a1h	; a19c

; ======================================================================
; CODIGO 0xa19e..0xa21b  (125 bytes)
; ======================================================================


secuencia_de_A18F_espera:
	call L_A8DB		;a19e   ; los cuatro sprites, colocados
	ld a,00bh		;a1a1   ; y la pose 11
	call pon_la_pose_en_lo_que_se_maneja		;a1a3
	ld hl,0e21bh		;a1a6
	inc (hl)			;a1a9   ; un cuadro mas
	ld a,(hl)			;a1aa
	cp 020h		;a1ab   ; y a los treinta y dos...
	ret nz			;a1ad
	ld a,(0e0d3h)		;a1ae   ; ...mira 0xE0D3
	and a			;a1b1
	jr nz,secuencia_de_A18F_se_salta_uno		;a1b2
	ld hl,0e21dh		;a1b4   ; si no esta puesto, al paso siguiente
	inc (hl)			;a1b7
	ret			;a1b8
secuencia_de_A18F_se_salta_uno:
	ld hl,0e21dh		;a1b9
	inc (hl)			;a1bc   ; y si lo esta, se salta un paso entero
	inc (hl)			;a1bd
	ret			;a1be
secuencia_de_A18F_baja:
	ld hl,0e204h		;a1bf   ; la fila
	ld a,(hl)			;a1c2
	cp 090h		;a1c3   ; hasta la 0x90
	jr nc,L_A1D1		;a1c5
	inc (hl)			;a1c7   ; dos filas por cuadro
	inc (hl)			;a1c8
secuencia_de_A18F_dibuja:
	call L_A8DB		;a1c9   ; los cuatro sprites, colocados
	ld a,00bh		;a1cc   ; y la pose 11
	jp pon_la_pose_en_lo_que_se_maneja		;a1ce
L_A1D1:
	cp 092h		;a1d1
	jr nc,L_A1DA		;a1d3
	ld a,090h		;a1d5
	ld (0e204h),a		;a1d7   ; la Y en la pantalla de lo que se maneja
L_A1DA:
	call secuencia_de_A18F_dibuja		;a1da
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
	jp pon_la_pose_en_lo_que_se_maneja		;a1fc
L_A1FF:
	ld a,0c0h		;a1ff
	ld (0e204h),a		;a201   ; la Y en la pantalla de lo que se maneja
	call L_A1F7		;a204
	ld hl,0e21bh		;a207
	dec (hl)			;a20a
	ret nz			;a20b
	xor a			;a20c
	ld (0e096h),a		;a20d   ; los avisos que deja el cuadro
	ret			;a210
L_A211:
	call vacia_la_barra_y_la_pinta		;a211
	ld a,(0e21eh)		;a214   ; por que tiempo va la otra secuencia
	dec a			;a217
	call 04060h		;a218   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_A218: 6 punteros pegados detras del `call despacha` de
;   p03:A218: la rutina a la que se salta con A
;   0xa21b..0xa227  (12 bytes)
DATA_despacho_de_A218:
	defb 027h,0a2h	; a21b
	defb 05ah,0a2h	; a21d
	defb 07ah,0a2h	; a21f
	defb 099h,0a2h	; a221
	defb 0cfh,0a2h	; a223
	defb 083h,0a3h	; a225

; ======================================================================
; CODIGO 0xa227..0xa39a  (371 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; VOLVER AL CENTRO. Lleva al jugador a la columna 0x70 -el centro justo- a un pixel por cuadro, venga del lado que venga. En cuanto llega, salta al tiempo 4 con 0x18 cuadros de espera y suena el efecto 0xB0. Hay tres copias de esta rutina, una por secuencia, y solo se diferencian en lo que pintan mientras anda.
; ----------------------------------------------------------------------
vuelve_al_centro:
	ld hl,0e205h		;a227   ; la columna del jugador
	ld a,(hl)			;a22a
	cp 070h		;a22b   ; ¿ya esta en el centro?
	jr z,ya_esta_en_el_centro		;a22d
	jr nc,L_A234		;a22f   ; por la derecha, un pixel a la izquierda...
	inc (hl)			;a231   ; ...y por la izquierda, uno a la derecha
	jr anda_hacia_el_centro		;a232
L_A234:
	dec (hl)			;a234
anda_hacia_el_centro:
	call L_A8DB		;a235   ; los cuatro sprites, colocados
	ld a,(0e003h)		;a238   ; el contador de cuadros
	rra			;a23b   ; tres rotaciones: ocho cuadros por dibujo
	rra			;a23c
	rra			;a23d
	ld c,000h		;a23e   ; la pose 0...
	jr nc,L_A247		;a240
	inc c			;a242   ; ...la 1...
	rra			;a243
	jr c,L_A247		;a244
	inc c			;a246   ; ...o la 2
L_A247:
	ld a,c			;a247
	jp pon_la_pose_en_lo_que_se_maneja		;a248   ; la pose que toque
ya_esta_en_el_centro:
	ld a,004h		;a24b   ; el tiempo 4
	ld (0e21eh),a		;a24d   ; por que tiempo va la otra secuencia
	ld a,018h		;a250   ; con 0x18 cuadros de espera
	ld (0e21ch),a		;a252   ; la cuenta de la espera
	ld a,0b0h		;a255   ; y el efecto 0xB0
	jp 0413ah		;a257   ; banco 0: pide_sonido_si_esta_activo
vuelve_al_centro_pintando_desde_el_banco_2:
	ld hl,0e205h		;a25a   ; la columna del jugador
	ld a,(hl)			;a25d
	cp 070h		;a25e   ; ¿ya esta en el centro?
	jr z,ya_esta_en_el_centro_bis		;a260
	jr nc,L_A267		;a262
	inc (hl)			;a264
	jr L_A268		;a265
L_A267:
	dec (hl)			;a267
L_A268:
	jp 09a1dh		;a268   ; banco 2: y a pintar
ya_esta_en_el_centro_bis:
	ld a,004h		;a26b
	ld (0e21eh),a		;a26d   ; por que tiempo va la otra secuencia
	ld a,018h		;a270
	ld (0e21ch),a		;a272   ; la cuenta de la espera
	ld a,0b0h		;a275
	jp 0413ah		;a277   ; banco 0: pide_sonido_si_esta_activo
vuelve_al_centro_con_el_otro_pintor:
	ld hl,0e205h		;a27a   ; la columna del jugador
	ld a,(hl)			;a27d
	cp 070h		;a27e
	jr z,ya_esta_en_el_centro_ter		;a280
	jr nc,L_A287		;a282
	inc (hl)			;a284
	jr L_A288		;a285
L_A287:
	dec (hl)			;a287
L_A288:
	jp 09c3ah		;a288   ; banco 2: el otro pintor
ya_esta_en_el_centro_ter:
	ld hl,0e21eh		;a28b
	inc (hl)			;a28e   ; al tiempo siguiente
	ld a,018h		;a28f
	ld (0e21ch),a		;a291   ; la cuenta de la espera
	ld a,0b0h		;a294
	jp 0413ah		;a296   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; EL CENTELLEO DE LOS NUEVE SPRITES. Cambia entre dos juegos enteros de atributos -0xA3C6 y 0xA3EA, 36 bytes cada uno, que son nueve sprites- y lo hace cada 8 o cada 16 cuadros segun sea par o impar la cuenta que queda: o sea que el centelleo se va acelerando segun se acaba.
; ----------------------------------------------------------------------
el_centelleo_de_los_nueve:
	ld a,(0e21ch)		;a299   ; la cuenta de la espera
	rra			;a29c
	ld c,008h		;a29d   ; par, cada ocho cuadros...
	jr nc,cuenta_para_el_centelleo		;a29f
	ld c,010h		;a2a1   ; ...impar, cada dieciseis
cuenta_para_el_centelleo:
	ld hl,0e222h		;a2a3
	inc (hl)			;a2a6   ; un cuadro mas
	ld a,(hl)			;a2a7
	cp c			;a2a8   ; ¿toca cambiar?
	ret nz			;a2a9
	ld (hl),000h		;a2aa   ; vuelta a empezar
	ld hl,0e21ch		;a2ac
	dec (hl)			;a2af   ; y un paso menos de la espera
	jr z,se_acabo_el_centelleo		;a2b0   ; al acabarse, al tiempo siguiente
	bit 0,(hl)		;a2b2   ; y mientras, un juego de atributos...
	ld hl,0a3c6h		;a2b4
	jr z,L_A2BC		;a2b7
	ld hl,0a3eah		;a2b9   ; ...o el otro
L_A2BC:
	ld de,0ee80h		;a2bc   ; los nueve sprites
	ld bc,00024h		;a2bf   ; 36 bytes: nueve por cuatro
	ldir		;a2c2
	ret			;a2c4
se_acabo_el_centelleo:
	ld hl,0e21eh		;a2c5
	inc (hl)			;a2c8   ; al tiempo siguiente
	ld a,010h		;a2c9   ; con 0x10 de espera
	ld (0e21ch),a		;a2cb   ; la cuenta de la espera
	ret			;a2ce

; ----------------------------------------------------------------------
; LOS NUEVE DIBUJOS DEL PREMIO, Y EL PREMIO. Una cuenta que baja de 0x0E a 0, un dibujo nuevo cada dieciseis cuadros: 0xA47A, 0xA492, 0xA4AA, 0xA4C2, 0xA4DA, 0xA4F2, 0xA50A, 0xA522 y 0xA53A, veinticuatro bytes cada uno a 0xEEA4. Y en el paso 6 esta LO QUE DECIDE: se mira la ULTIMA CIFRA DEL TIEMPO QUE QUEDA (0xE08B) y, si es 7, 5 o 3, suena el efecto 0xAA; con cualquier otra, el 0xA1. Dos efectos distintos para dos finales distintos, y lo que los separa es una cifra del reloj.
; ----------------------------------------------------------------------
los_nueve_dibujos_del_premio:
	ld a,(0e003h)		;a2cf   ; el contador de cuadros
	and 00fh		;a2d2   ; uno de cada dieciseis
	ret nz			;a2d4
	ld hl,0e21ch		;a2d5
	dec (hl)			;a2d8   ; un paso menos
	ld a,(hl)			;a2d9
	cp 00eh		;a2da   ; el paso 14...
	ld hl,0a47ah		;a2dc
	jr z,el_dibujo_a_los_sprites		;a2df
	cp 00dh		;a2e1   ; ...el 13...
	ld hl,0a492h		;a2e3
	jr z,el_dibujo_a_los_sprites		;a2e6
	cp 00ch		;a2e8   ; ...el 12...
	ld hl,0a4aah		;a2ea
	jr z,el_dibujo_a_los_sprites		;a2ed
	cp 00bh		;a2ef   ; ...el 11...
	ld hl,0a4c2h		;a2f1
	jr z,el_dibujo_a_los_sprites		;a2f4
	cp 00ah		;a2f6   ; ...el 10...
	ld hl,0a4dah		;a2f8
	jr z,el_dibujo_a_los_sprites		;a2fb
	cp 009h		;a2fd   ; ...el 9...
	ld hl,0a4f2h		;a2ff
	jr z,el_dibujo_a_los_sprites		;a302
	cp 008h		;a304   ; ...el 8...
	ld hl,0a50ah		;a306
	jr z,el_dibujo_a_los_sprites		;a309
	cp 007h		;a30b   ; ...el 7...
	ld hl,0a522h		;a30d
	jr z,el_dibujo_a_los_sprites		;a310
	cp 006h		;a312   ; ...y el 6, que ademas reparte
	ld hl,0a53ah		;a314
	jr z,la_cifra_que_decide		;a317
	and a			;a319   ; y hasta el cero, nada mas
	ret nz			;a31a
	ld a,030h		;a31b   ; el efecto 0x30
	call 0413ah		;a31d   ; banco 0: pide_sonido_si_esta_activo
	ld hl,0e21eh		;a320   ; al tiempo siguiente
	inc (hl)			;a323
	ld a,002h		;a324   ; con dos de espera
	ld (0e21ch),a		;a326   ; la cuenta de la espera
	ret			;a329
la_cifra_que_decide:
	ld a,(0e08bh)		;a32a   ; el tiempo que queda
	and 00fh		;a32d   ; su ultima cifra
	cp 007h		;a32f   ; ¿un 7?
	ld c,0aah		;a331   ; pues el efecto 0xAA
	jr z,suena_lo_que_toque		;a333
	cp 005h		;a335   ; ¿un 5?
	jr z,suena_lo_que_toque		;a337
	cp 003h		;a339   ; ¿o un 3?
	jr z,suena_lo_que_toque		;a33b
	ld c,0a1h		;a33d   ; y con cualquier otra, el 0xA1
suena_lo_que_toque:
	ld a,c			;a33f
	call 0413ah		;a340   ; banco 0: pide_sonido_si_esta_activo
el_dibujo_a_los_sprites:
	ld de,0eea4h		;a343   ; a partir del sprite 9
	ld bc,00018h		;a346
	ldir		;a349
	ld a,(0e08bh)		;a34b   ; el TIEMPO que queda
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
pinta_el_juego_de_0xA3A2:
	ld hl,0e21ch		;a383
	dec (hl)			;a386   ; un paso menos de la espera
	jr z,L_A395		;a387   ; al acabarse, a lo siguiente
	ld hl,0a3a2h		;a389   ; el juego de atributos de 0xA3A2
	ld de,0ee80h		;a38c   ; los nueve sprites
	ld bc,00024h		;a38f   ; 36 bytes
	ldir		;a392
	ret			;a394
L_A395:
	xor a			;a395
	ld (0e096h),a		;a396   ; los avisos que deja el cuadro
	ret			;a399

; ----------------------------------------------------------------------
; DATOS cuatro_parejas_E0E2: cuatro parejas que p03:A35F indexa con (0xE0E2) y
;   lleva a 0xEEA7 y 0xEEAB
;   0xa39a..0xa3a2  (8 bytes)
DATA_cuatro_parejas_E0E2:
	defb 005h,004h	; a39a
	defb 006h,00ah	; a39c
	defb 002h,00ch	; a39e
	defb 009h,006h	; a3a0

; ----------------------------------------------------------------------
; DATOS atributos_de_nueve_sprites: seis juegos de 36 bytes, nueve atributos
;   de sprite cada uno, que se copian con ldir a 0xEE80: los cargan p03:A389
;   (0xA3A2), A2B4 y A2B9 (0xA3C6 o 0xA3EA), A6D1 (0xA40E), AAF0 (0xA432) y
;   AB06/AC26 (0xA456)
;   0xa3a2..0xa47a  (216 bytes)
DATA_atributos_de_nueve_sprites:
	defb 087h,07fh,040h,00ah,0a0h,073h,050h,00ah,0a2h,085h,054h,00ah,085h,07dh,03ch,00fh,095h,079h,048h,00fh,081h,078h,034h,001h,081h,088h,038h,001h,091h,076h,044h,001h,091h,086h,04ch,001h	; a3a2  ..@..sP...T..}<..yH..x4...8..vD...L.
	defb 08dh,070h,060h,00ah,0a3h,075h,070h,00ah,0e0h,000h,000h,000h,089h,06fh,058h,00fh,09bh,076h,068h,00fh,08dh,06ah,05ch,001h,08eh,07ah,064h,001h,09eh,07ah,06ch,001h,0e0h,000h,000h,000h	; a3c6  .p`..up......oX..vh..j\..zd..zl.....
	defb 08fh,070h,07ch,00ah,0a3h,075h,070h,00ah,0e0h,000h,000h,000h,08ah,06fh,074h,00fh,09bh,076h,080h,00fh,08fh,06ah,078h,001h,090h,07ah,084h,001h,0a0h,07ah,088h,001h,0e0h,000h,000h,000h	; a3ea  .p|..up......ot..v...jx..z...z......
	defb 0a1h,074h,098h,00ah,0bdh,077h,0b0h,00ah,0bch,08bh,0b4h,00ah,09ch,075h,094h,00fh,0ach,06ch,0a4h,00fh,0a4h,070h,09ch,004h,0a4h,080h,0a0h,004h,0b4h,073h,0a8h,004h,0b4h,083h,0ach,004h	; a40e  .t...w.......u...l...p.......s......
	defb 0a4h,078h,03ch,00ah,0bbh,074h,04ch,00ah,0bbh,07ch,050h,00ah,09eh,078h,038h,00fh,0b1h,078h,048h,00fh,09dh,078h,034h,001h,0adh,070h,040h,001h,0adh,080h,044h,001h,0e0h,000h,000h,000h	; a432  .x<..tL..|P..x8..xH..x4..p@...D.....
	defb 081h,07fh,0a0h,00ah,09ah,073h,0b0h,00ah,09ch,085h,0b4h,00ah,07fh,07dh,09ch,00fh,08fh,079h,0a8h,00fh,07bh,078h,094h,001h,07bh,088h,098h,001h,08bh,076h,0a4h,001h,08bh,086h,0ach,001h	; a456  .....s.......}...y..{x..{....v......

; ----------------------------------------------------------------------
; DATOS nueve_juegos_de_24: nueve bloques de 24 bytes que p03:A2DC escoge
;   segun A (de 0x0E a 6) y pasa a p03:A343 o A32A
;   0xa47a..0xa552  (216 bytes)
DATA_nueve_juegos_de_24:
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,077h,088h,08ch,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a47a  ........w...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,077h,088h,090h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a492  ........w...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,076h,089h,094h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a4aa  ........v...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,075h,08ah,098h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a4c2  ........u...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,070h,08fh,09ch,00fh,080h,08bh,0a0h,00fh,0e0h,000h,000h,00fh,0e0h,000h,000h,00fh	; a4da  ........p...............
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,06bh,08eh,0a4h,00fh,06fh,09ch,0a8h,00fh,07bh,08ch,0ach,00fh,0e0h,000h,000h,00fh	; a4f2  ........k...o...{.......
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,067h,08fh,0b0h,00fh,06ah,09dh,0b4h,00fh,077h,08dh,0b8h,00fh,07ah,09dh,0bch,00fh	; a50a  ........g...j...w...z...
	defb 0e0h,000h,000h,008h,0e0h,000h,000h,008h,062h,093h,0c0h,00fh,062h,0a3h,0c4h,00fh,072h,08eh,0c8h,00fh,072h,09eh,0cch,00fh	; a522  ........b...b...r...r...
	defb 066h,098h,0d0h,008h,066h,098h,0d4h,00ah,062h,093h,0c0h,00fh,062h,0a3h,0c4h,00fh,072h,08eh,0c8h,00fh,072h,09eh,0cch,00fh	; a53a  f...f...b...b...r...r...

; ----------------------------------------------------------------------
; DATOS atributos_de_nueve_sprites_2: tres juegos mas de 36 bytes para 0xEE80:
;   p03:A636 (0xA552) y p03:A686 (0xA576 o 0xA59A)
;   0xa552..0xa5be  (108 bytes)
DATA_atributos_de_nueve_sprites_2:
	defb 0a4h,078h,03ch,00ah,0bbh,074h,04ch,00ah,0bbh,07ch,050h,00ah,09eh,078h,038h,00fh,0b1h,078h,048h,00fh,09dh,078h,034h,004h,0adh,070h,040h,004h,0adh,080h,044h,004h,0e0h,000h,000h,000h	; a552  .x<..tL..|P..x8..xH..x4..p@...D.....
	defb 0a0h,07dh,054h,00ah,0bfh,07ah,06ch,00ah,0b3h,08ah,070h,00ah,0a2h,07ch,05ch,00fh,0b2h,07ah,068h,00fh,0a2h,076h,058h,004h,0a2h,086h,060h,004h,0b2h,076h,064h,004h,0e0h,000h,000h,000h	; a576  .}T..zl...p..|\..zh..vX...`..vd.....
	defb 0a0h,073h,074h,00ah,0bfh,076h,08ch,00ah,0b3h,066h,090h,00ah,0a2h,074h,07ch,00fh,0b2h,076h,088h,00fh,0a2h,07ah,078h,004h,0a2h,06ah,080h,004h,0b2h,07ah,084h,004h,0e0h,000h,000h,000h	; a59a  .st..v...f...t|..v...zx..j...z......

; ======================================================================
; CODIGO 0xa5be..0xa5c8  (10 bytes)
; ======================================================================


L_A5BE:
	call vacia_la_barra_y_la_pinta		;a5be
	ld a,(0e21eh)		;a5c1   ; por que tiempo va la otra secuencia
	dec a			;a5c4
	call 04060h		;a5c5   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_A5C5: 4 punteros pegados detras del `call despacha` de
;   p03:A5C5: la rutina a la que se salta con A
;   0xa5c8..0xa5d0  (8 bytes)
DATA_despacho_de_A5C5:
	defb 0d0h,0a5h	; a5c8
	defb 033h,0a6h	; a5ca
	defb 069h,0a6h	; a5cc
	defb 0cbh,0a6h	; a5ce

; ======================================================================
; CODIGO 0xa5d0..0xa623  (83 bytes)
; ======================================================================


L_A5D0:
	ld a,0e0h		;a5d0
	ld (0ee80h),a		;a5d2   ; la tabla de atributos de los 32 sprites
	ld (0ee84h),a		;a5d5   ; el sprite 1 de lo que se maneja: arriba a la derecha
	ld (0ee88h),a		;a5d8   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ld (0ee8ch),a		;a5db   ; el sprite 3 de lo que se maneja: abajo a la derecha
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
	ld (0e21ch),a		;a614   ; la cuenta de la espera
	ld a,r		;a617
	rra			;a619
	ld a,0b6h		;a61a
	jr c,L_A620		;a61c
	ld a,0b3h		;a61e
L_A620:
	jp 0413ah		;a620   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS destinos_de_la_tira_AE85: ocho direcciones de RAM (0xEDED, 0xEDF0...)
;   que p03:A5EF indexa con (0xE0DD) - 1 y pasa en DE a p01:7D9C junto con la
;   tira de 0xAE85
;   0xa623..0xa633  (16 bytes)
DATA_destinos_de_la_tira_AE85:
	defb 0edh,0edh	; a623
	defb 0f0h,0edh	; a625
	defb 0eah,0edh	; a627
	defb 0f3h,0edh	; a629
	defb 0e7h,0edh	; a62b
	defb 0f6h,0edh	; a62d
	defb 0e4h,0edh	; a62f
	defb 0f9h,0edh	; a631

; ======================================================================
; CODIGO 0xa633..0xa7d2  (415 bytes)
; ======================================================================


pinta_el_juego_de_0xA552:
	ld de,0ee80h		;a633   ; los nueve sprites
	ld hl,0a552h		;a636   ; el juego de atributos de 0xA552
	ld bc,00024h		;a639   ; 36 bytes
	ldir		;a63c
	ld a,(0e0ddh)		;a63e   ; y 0xE0DD dice cuantos mas
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
	ld (0e21ch),a		;a665   ; la cuenta de la espera
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
	ld (0e21ch),a		;a67f   ; la cuenta de la espera
	ret			;a682
L_A683:
	bit 0,(hl)		;a683
	push hl			;a685
	ld hl,0a576h		;a686
	jr z,pinta_el_juego_que_traiga_HL		;a689
	ld hl,0a59ah		;a68b
pinta_el_juego_que_traiga_HL:
	ld de,0ee80h		;a68e   ; los nueve sprites
	ld bc,00024h		;a691   ; 36 bytes
	ldir		;a694
	pop hl			;a696
	bit 0,(hl)		;a697   ; y segun el bit 0, un guion...
	ld hl,0aea3h		;a699   ; ...o el otro
	jr z,L_A6A1		;a69c
	ld hl,0aeb2h		;a69e
L_A6A1:
	ld a,(0e0ddh)		;a6a1   ; 0xE0DD dice cuantos mas
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
pinta_el_juego_de_0xA40E:
	ld hl,0e21ch		;a6cb
	dec (hl)			;a6ce   ; un paso menos de la espera
	jr z,L_A6F8		;a6cf   ; al acabarse, a lo siguiente
	ld hl,0a40eh		;a6d1   ; el juego de atributos de 0xA40E
	ld de,0ee80h		;a6d4   ; los nueve sprites
	ld bc,00024h		;a6d7   ; 36 bytes
	ldir		;a6da
	ld a,(0e0ddh)		;a6dc   ; y 0xE0DD decide lo que sigue
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
	jr nc,mueve_con_el_empujon_de_0xE214		;a715
	ld a,(hl)			;a717
	inc (hl)			;a718
	ld hl,09c74h		;a719
	call 04056h		;a71c   ; banco 0: a_mas_hl
	ld a,(hl)			;a71f
	ld (0e214h),a		;a720
mueve_con_el_empujon_de_0xE214:
	ld a,(0e214h)		;a723   ; el empujon que toca
	ld hl,0e204h		;a726   ; la fila de lo que se maneja
	add a,(hl)			;a729
	ld (hl),a			;a72a   ; sumado
	cp 020h		;a72b   ; por arriba, el tope es la fila 0x20...
	jr nc,L_A733		;a72d
	ld (hl),020h		;a72f
	jr L_A739		;a731
L_A733:
	cp 081h		;a733   ; ...y por abajo la 0x80
	jr c,L_A739		;a735
	ld (hl),080h		;a737
L_A739:
	call mira_hacia_donde_se_pide_ir		;a739
	ld a,(0e209h)		;a73c   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	call mueve_de_lado		;a73f

; ----------------------------------------------------------------------
; LA SEGUNDA FIGURA, LA DE LOS SPRITES 5 A 8. La misma posicion que lo que se maneja (0xE204, 0xE205), pero repartida en T y no en cuadro: el 6 y el 7 arriba, uno al lado del otro, y el 8 y el 5 debajo, ocho pixeles metidos hacia dentro. La pose la escoge el contador de 0xE213, que sube uno cada ocho cuadros, y de sus dos bits bajos salen las poses 7, 8, 7 y 9: un aleteo de tres dibujos con el 7 de descanso.
; ----------------------------------------------------------------------
L_A742:
	ld hl,(0e204h)		;a742   ; la Y en la pantalla de lo que se maneja
	ld d,h			;a745
	ld (0ee98h),hl		;a746   ; el hueco de sprite 6, el del bicho que vuela
	ld a,010h		;a749
	add a,h			;a74b
	ld h,a			;a74c
	ld (0ee9ch),hl		;a74d   ; el hueco de sprite 7
	ld a,h			;a750
	sub 008h		;a751
	ld h,a			;a753
	ld a,00dh		;a754
	add a,l			;a756
	ld l,a			;a757
	ld (0eea0h),hl		;a758   ; el hueco de sprite 8
	ld a,003h		;a75b
	add a,l			;a75d
	ld l,a			;a75e
	ld (0ee94h),hl		;a75f   ; el hueco de sprite 5
	ld hl,0e213h		;a762
	ld a,(0e003h)		;a765   ; el contador de cuadros
	and 007h		;a768
	jr nz,escoge_la_pose_de_la_segunda_figura		;a76a
	inc (hl)			;a76c
escoge_la_pose_de_la_segunda_figura:
	ld a,(hl)			;a76d   ; los dos bits bajos del contador
	rra			;a76e
	ld c,007h		;a76f   ; sin ninguno, la pose 7
	jr nc,pon_la_pose_en_los_sprites_5_a_8		;a771
	inc c			;a773   ; con el bit 0, la 8
	rra			;a774
	jr nc,pon_la_pose_en_los_sprites_5_a_8		;a775
	inc c			;a777   ; y con los dos, la 9

; ----------------------------------------------------------------------
; PONER UNA POSE EN LOS SPRITES 5 A 8. Ocho bytes de la tabla de 0xA91D -cuatro parejas de patron y color- a los bytes 2 y 3 de los sprites 6, 7, 8 y 5. Y luego les pisa el color: 4 a los dos de arriba, 0x0F al 8 y 0x0A al 5. Eso es lo que hace que esta figura salga en cuatro colores y no en uno.
; ----------------------------------------------------------------------
pon_la_pose_en_los_sprites_5_a_8:
	ld a,c			;a778
	add a,a			;a779   ; por ocho: cada pose ocupa ocho bytes
	add a,a			;a77a
	ld hl,0a91dh		;a77b   ; la tabla de poses
	call 04055h		;a77e   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a781
	inc hl			;a782
	ld d,(hl)			;a783
	ld (0ee96h),de		;a784   ; el patron y el color del sprite 6
	inc hl			;a788
	ld e,(hl)			;a789
	inc hl			;a78a
	ld d,(hl)			;a78b
	ld (0ee9ah),de		;a78c   ; los del 7
	inc hl			;a790
	ld e,(hl)			;a791
	inc hl			;a792
	ld d,(hl)			;a793
	ld (0ee9eh),de		;a794   ; los del 8
	inc hl			;a798
	ld e,(hl)			;a799
	inc hl			;a79a
	ld d,(hl)			;a79b
	ld (0eea2h),de		;a79c   ; y los del 5
	ld a,004h		;a7a0   ; el color 4...
	ld (0ee9bh),a		;a7a2   ; ...a los sprites 6 y 7
	ld (0ee9fh),a		;a7a5
	ld a,00fh		;a7a8   ; el 0x0F, blanco, al 8
	ld (0eea3h),a		;a7aa
	ld a,00ah		;a7ad   ; y el 0x0A al 5
	ld (0ee97h),a		;a7af
	ret			;a7b2
L_A7B3:
	call vacia_la_barra_y_la_pinta		;a7b3
	ld a,(0e204h)		;a7b6   ; la Y en la pantalla de lo que se maneja
	add a,001h		;a7b9
	ld (0e204h),a		;a7bb   ; la Y en la pantalla de lo que se maneja
	cp 0c0h		;a7be
	jp c,L_A742		;a7c0
	xor a			;a7c3
	ld (0e096h),a		;a7c4   ; los avisos que deja el cuadro
	ret			;a7c7
L_A7C8:
	call vacia_la_barra_y_la_pinta		;a7c8
	ld a,(0e21eh)		;a7cb   ; por que tiempo va la otra secuencia
	dec a			;a7ce
	call 04060h		;a7cf   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_A7CF: 3 punteros pegados detras del `call despacha` de
;   p03:A7CF: la rutina a la que se salta con A
;   0xa7d2..0xa7d8  (6 bytes)
DATA_despacho_de_A7CF:
	defb 0d8h,0a7h	; a7d2
	defb 00ah,0a8h	; a7d4
	defb 019h,0a8h	; a7d6

; ======================================================================
; CODIGO 0xa7d8..0xa91d  (325 bytes)
; ======================================================================


L_A7D8:
	xor a			;a7d8
	call pon_la_pose_en_lo_que_se_maneja		;a7d9
	ld hl,0e21fh		;a7dc
	inc (hl)			;a7df
	ld a,(hl)			;a7e0
	cp 090h		;a7e1
	jr z,el_cuarto_tiempo_arranca_la_cuenta		;a7e3
	ld c,a			;a7e5
	and 00fh		;a7e6
	jr nz,L_A7FB		;a7e8
	ld a,(0e220h)		;a7ea   ; cuantos sprites lleva puestos la figura
	ld b,a			;a7ed
	ld hl,0ee94h		;a7ee
	add a,a			;a7f1
	call 04055h		;a7f2   ; banco 0: dos_por_a_mas_hl
	ld (hl),c			;a7f5
	inc b			;a7f6
	ld a,b			;a7f7
	ld (0e220h),a		;a7f8   ; cuantos sprites lleva puestos la figura
L_A7FB:
	ld a,c			;a7fb
	ld (0ee90h),a		;a7fc   ; el hueco de sprite 4
	ret			;a7ff
el_cuarto_tiempo_arranca_la_cuenta:
	ld hl,0e21eh		;a800   ; el tiempo siguiente
	inc (hl)			;a803
	ld a,010h		;a804   ; y 16 cuadros de espera
	ld (0e21ch),a		;a806   ; la cuenta de la espera
	ret			;a809
el_tiempo_de_esperar:
	ld a,00ch		;a80a   ; la pose 12, quieta
	call pon_la_pose_en_lo_que_se_maneja		;a80c
	ld hl,0e21ch		;a80f
	dec (hl)			;a812   ; se descuenta la espera...
	ret nz			;a813
	ld hl,0e21eh		;a814
	inc (hl)			;a817   ; ...y al acabarse, al tiempo siguiente
	ret			;a818
se_deshace_la_figura:
	ld hl,0e21fh		;a819   ; el contador, ahora hacia atras
	dec (hl)			;a81c
	ld a,(hl)			;a81d
	ld c,a			;a81e
	and 00fh		;a81f   ; cada dieciseis pasos...
	jr nz,L_A835		;a821
	ld a,(0e220h)		;a823   ; ...se quita un sprite de los de 0xEE94 en adelante
	ld b,a			;a826
	ld hl,0ee94h		;a827
	add a,a			;a82a
	call 04055h		;a82b   ; banco 0: dos_por_a_mas_hl
	ld (hl),0e0h		;a82e   ; con 0xE0 en la fila, que es fuera de la pantalla
	dec b			;a830
	ld a,b			;a831
	ld (0e220h),a		;a832   ; y uno menos puestos
L_A835:
	ld a,c			;a835
	ld (0ee90h),a		;a836   ; el hueco de sprite 4
	ld hl,0e204h		;a839   ; y la figura baja una fila por cuadro
	dec (hl)			;a83c
	call L_A8DB		;a83d
	ld a,(0e204h)		;a840   ; la Y en la pantalla de lo que se maneja
	cp 0f8h		;a843   ; hasta la 0xF8, ya fuera de la pantalla
	ret nz			;a845
	xor a			;a846   ; y ahi se acaba: el estado vuelve a cero
	ld (0e203h),a		;a847   ; el ESTADO de lo que se maneja
	ret			;a84a

; ----------------------------------------------------------------------
; HACIA DONDE SE PIDE IR. Los bits 2 y 3 del mando son izquierda y derecha, y lo que deja en 0xE209 es 4 o 8. Con los dos a la vez no se mueve. Y mira primero las teclas recien pulsadas y despues las del cuadro anterior, de modo que un cambio de lado tiene efecto en el mismo cuadro en que se pide.
; ----------------------------------------------------------------------
mira_hacia_donde_se_pide_ir:
	ld a,(0e007h)		;a84b   ; las del cuadro anterior
	and 00ch		;a84e   ; izquierda y derecha
	ld b,a			;a850
	ld c,000h		;a851   ; de entrada, quieto
	jr z,L_A875		;a853
	ld a,(0e006h)		;a855   ; las recien pulsadas
	and 00ch		;a858
	cp 00ch		;a85a   ; con las dos a la vez no se va a ningun lado
	ret z			;a85c
	bit 2,a		;a85d   ; el bit 2 es la izquierda
	ld c,004h		;a85f
	jr nz,L_A875		;a861
	bit 3,a		;a863   ; y el bit 3 la derecha
	ld c,008h		;a865
	jr nz,L_A875		;a867
	ld a,b			;a869   ; y si no hay ninguna recien pulsada, vale la del cuadro anterior
	cp 00ch		;a86a
	ret z			;a86c
	bit 2,a		;a86d
	ld c,004h		;a86f
	jr nz,L_A875		;a871
	ld c,008h		;a873
L_A875:
	ld a,c			;a875
	ld (0e209h),a		;a876   ; hacia donde se mueve
	ret			;a879

; ----------------------------------------------------------------------
; MOVERSE DE LADO. Un pixel por cuadro, o DOS si 0xE16D esta puesto, y con tope en la columna 0x14 por la izquierda y 0xCC por la derecha: esos son los dos bordes por los que no se puede pasar. Y al final, si nadie lo frena, se suma el arrastre de 0xE0A6, que es el que te lleva de lado sin tocar nada.
; ----------------------------------------------------------------------
mueve_de_lado:
	ld hl,0e205h		;a87a   ; la columna
	and 00ch		;a87d   ; izquierda y derecha
	jr z,y_luego_el_arrastre		;a87f   ; con ninguna o con las dos, no se mueve
	cp 00ch		;a881
	jr z,y_luego_el_arrastre		;a883
	cp 008h		;a885   ; el 8 es la derecha
	jr z,L_A89E		;a887
	ld a,(0e16dh)		;a889   ; ¿va al doble?
	and a			;a88c
	ld c,001h		;a88d   ; un pixel...
	jr z,mueve_a_la_izquierda		;a88f
	inc c			;a891   ; ...o dos
mueve_a_la_izquierda:
	ld a,(hl)			;a892
	sub c			;a893   ; restando de la columna
	ld (hl),a			;a894
	ld a,(hl)			;a895
	cp 014h		;a896   ; y el tope de la izquierda es 0x14
	jr nc,y_luego_el_arrastre		;a898
	ld (hl),014h		;a89a
	jr y_luego_el_arrastre		;a89c
L_A89E:
	ld a,(0e16dh)		;a89e
	and a			;a8a1
	ld c,001h		;a8a2
	jr z,mueve_a_la_derecha		;a8a4
	inc c			;a8a6
mueve_a_la_derecha:
	ld a,(hl)			;a8a7
	add a,c			;a8a8   ; sumando a la columna
	ld (hl),a			;a8a9
	ld a,(hl)			;a8aa
	cp 0cdh		;a8ab   ; y el de la derecha 0xCC
	jr c,y_luego_el_arrastre		;a8ad
	ld (hl),0cch		;a8af
y_luego_el_arrastre:
	ld a,(0e20bh)		;a8b1   ; si esto esta puesto, no se arrastra
	and a			;a8b4
	ret nz			;a8b5
	ld a,(0e003h)		;a8b6   ; el contador de cuadros
	rra			;a8b9   ; y solo un cuadro de cada dos
	ret nc			;a8ba
	ld a,(0e16eh)		;a8bb   ; esto tambien lo frena
	and a			;a8be
	ret nz			;a8bf
	ld a,(0e0a6h)		;a8c0   ; y si no hay arrastre, nada
	and a			;a8c3
	ret z			;a8c4
	rra			;a8c5   ; el bit 0 dice hacia que lado
	ld a,001h		;a8c6
	jr c,arrastra_con_sus_topes		;a8c8
	ld a,0ffh		;a8ca
arrastra_con_sus_topes:
	add a,(hl)			;a8cc   ; sumado a la columna
	ld (hl),a			;a8cd
	cp 0cdh		;a8ce   ; con los mismos dos topes que antes
	jr c,L_A8D5		;a8d0
	ld (hl),0cch		;a8d2
	ret			;a8d4
L_A8D5:
	cp 014h		;a8d5
	ret nc			;a8d7
	ld (hl),014h		;a8d8
	ret			;a8da
L_A8DB:
	ld hl,(0e204h)		;a8db   ; la Y en la pantalla de lo que se maneja
	ld d,h			;a8de
	ld (0ee80h),hl		;a8df   ; la tabla de atributos de los 32 sprites
	ld a,010h		;a8e2
	add a,h			;a8e4
	ld h,a			;a8e5
	ld (0ee84h),hl		;a8e6   ; el sprite 1 de lo que se maneja: arriba a la derecha
	ld a,010h		;a8e9
	add a,l			;a8eb
	ld l,a			;a8ec
	ld (0ee8ch),hl		;a8ed   ; el sprite 3 de lo que se maneja: abajo a la derecha
	ld h,d			;a8f0
	ld (0ee88h),hl		;a8f1   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ret			;a8f4

; ----------------------------------------------------------------------
; PONER UNA POSE EN LO QUE SE MANEJA. La misma tabla de 0xA91D y las mismas cuatro parejas de patron y color, pero a los sprites 0, 1, 2 y 3, que son los que p03:A8DB coloca en cuadro. Aqui no se pisa ningun color: sale el que traiga la pose.
; ----------------------------------------------------------------------
pon_la_pose_en_lo_que_se_maneja:
	add a,a			;a8f5   ; por cuatro...
	add a,a			;a8f6
	ld hl,0a91dh		;a8f7   ; ...y la rutina de 0x4055 dobla otra vez: ocho bytes por pose
	call 04055h		;a8fa   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a8fd
	inc hl			;a8fe
	ld d,(hl)			;a8ff
	ld (0ee82h),de		;a900   ; el patron y el color del sprite 0
	inc hl			;a904
	ld e,(hl)			;a905
	inc hl			;a906
	ld d,(hl)			;a907
	ld (0ee86h),de		;a908   ; los del 1
	inc hl			;a90c
	ld e,(hl)			;a90d
	inc hl			;a90e
	ld d,(hl)			;a90f
	ld (0ee8ah),de		;a910   ; los del 2
	inc hl			;a914
	ld e,(hl)			;a915
	inc hl			;a916
	ld d,(hl)			;a917
	ld (0ee8eh),de		;a918   ; y los del 3
	ret			;a91c

; ----------------------------------------------------------------------
; DATOS poses_A91D: TRECE POSES de ocho bytes, no 26 de cuatro: cada una son
;   las cuatro parejas de (patron, color) de una figura de dos por dos
;   sprites. p03:A8F5 las lleva a los sprites 0 a 3 -lo que se maneja- y
;   p03:A778 a los sprites 6, 7, 8 y 5. Los patrones van de cuatro en cuatro,
;   que es lo que ocupa un sprite de 16 por 16
;   0xa91d..0xa985  (104 bytes)
DATA_poses_A91D:
	defb 018h,001h,01ch,001h	; a91d
	defb 010h,001h,014h,001h	; a921
	defb 020h,001h,024h,001h	; a925
	defb 000h,001h,008h,001h	; a929
	defb 028h,001h,02ch,001h	; a92d
	defb 00ch,001h,004h,001h	; a931
	defb 018h,001h,01ch,001h	; a935
	defb 058h,001h,05ch,001h	; a939
	defb 068h,001h,06ch,001h	; a93d
	defb 060h,001h,064h,001h	; a941
	defb 020h,001h,024h,001h	; a945
	defb 000h,001h,050h,001h	; a949
	defb 028h,001h,02ch,001h	; a94d
	defb 054h,001h,004h,001h	; a951
	defb 004h,00ah,010h,001h	; a955
	defb 014h,001h,000h,00fh	; a959
	defb 008h,00ah,018h,001h	; a95d
	defb 01ch,001h,000h,00fh	; a961
	defb 00ch,00ah,020h,001h	; a965
	defb 024h,001h,000h,00fh	; a969
	defb 000h,00fh,000h,00fh	; a96d
	defb 018h,001h,01ch,001h	; a971
	defb 0c0h,001h,0c4h,001h	; a975
	defb 0c8h,001h,0cch,001h	; a979
	defb 038h,001h,03ch,001h	; a97d
	defb 040h,001h,044h,001h	; a981

; ======================================================================
; CODIGO 0xa985..0xa98b  (6 bytes)
; ======================================================================


L_A985:
	ld a,(0e203h)		;a985   ; el ESTADO de lo que se maneja
	call 04060h		;a988   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_A988: 28 punteros pegados detras del `call despacha` de
;   p03:A988: la rutina a la que se salta con A
;   0xa98b..0xa9c3  (56 bytes)
DATA_despacho_de_A988:
	defb 0c3h,0a9h	; a98b
	defb 0d7h,0a9h	; a98d
	defb 00bh,0aah	; a98f
	defb 0c3h,0a9h	; a991
	defb 06ch,0aah	; a993
	defb 06ch,0aah	; a995
	defb 061h,0aah	; a997
	defb 075h,0aah	; a999
	defb 06ch,0aah	; a99b
	defb 0c3h,0a9h	; a99d
	defb 0c3h,0a9h	; a99f
	defb 03fh,0aah	; a9a1
	defb 049h,0aah	; a9a3
	defb 051h,0aah	; a9a5
	defb 051h,0aah	; a9a7
	defb 0c3h,0a9h	; a9a9
	defb 0c3h,0a9h	; a9ab
	defb 0c3h,0a9h	; a9ad
	defb 06ch,0aah	; a9af
	defb 06ch,0aah	; a9b1
	defb 0c3h,0a9h	; a9b3
	defb 06ch,0aah	; a9b5
	defb 06ch,0aah	; a9b7
	defb 06ch,0aah	; a9b9
	defb 06ch,0aah	; a9bb
	defb 06ch,0aah	; a9bd
	defb 06ch,0aah	; a9bf
	defb 0c3h,0a9h	; a9c1

; ======================================================================
; CODIGO 0xa9c3..0xa9f7  (52 bytes)
; ======================================================================


L_A9C3:
	ld hl,(0e204h)		;a9c3   ; la Y en la pantalla de lo que se maneja
	ld l,0aeh		;a9c6
los_dos_sprites_de_debajo:
	ld a,004h		;a9c8   ; cuatro columnas mas
	add a,h			;a9ca
	ld h,a			;a9cb
	ld (0eec8h),hl		;a9cc   ; al sprite 18
	ld a,008h		;a9cf   ; y ocho mas
	add a,h			;a9d1
	ld h,a			;a9d2
	ld (0eecch),hl		;a9d3   ; al sprite 19
	ret			;a9d6
L_A9D7:
	ld a,(0e208h)		;a9d7   ; el paso dentro del salto
	cp 0ffh		;a9da
	jr z,L_A9C3		;a9dc
	ld hl,0a9f7h		;a9de
L_A9E1:
	call 04055h		;a9e1   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;a9e4
	inc hl			;a9e5
	ld d,(hl)			;a9e6
	ld a,(0e205h)		;a9e7   ; la X en la pantalla de lo que se maneja
	ld l,0aeh		;a9ea
	add a,e			;a9ec
	ld h,a			;a9ed
	ld (0eec8h),hl		;a9ee
	add a,d			;a9f1
	ld h,a			;a9f2
	ld (0eecch),hl		;a9f3
	ret			;a9f6

; ----------------------------------------------------------------------
; DATOS diez_palabras_A9F7: diez palabras que p03:A9DE indexa y pone en DE
;   0xa9f7..0xaa0b  (20 bytes)
DATA_diez_palabras_A9F7:
	defb 005h,006h	; a9f7
	defb 006h,004h	; a9f9
	defb 007h,002h	; a9fb
	defb 008h,000h	; a9fd
	defb 008h,000h	; a9ff
	defb 008h,000h	; aa01
	defb 008h,000h	; aa03
	defb 007h,002h	; aa05
	defb 006h,004h	; aa07
	defb 005h,006h	; aa09

; ======================================================================
; CODIGO 0xaa0b..0xaa17  (12 bytes)
; ======================================================================


L_AA0B:
	ld a,(0e208h)		;aa0b   ; el paso dentro del salto
	cp 0ffh		;aa0e
	jr z,$-77		;aa10
	ld hl,0aa17h		;aa12
	jr $-52		;aa15

; ----------------------------------------------------------------------
; DATOS veinte_palabras_AA17: veinte palabras de la misma forma: p03:AA12
;   carga HL = 0xAA17 y vuelve al mismo lector de p03:A9DE
;   0xaa17..0xaa3f  (40 bytes)
DATA_veinte_palabras_AA17:
	defb 005h,006h	; aa17
	defb 006h,004h	; aa19
	defb 007h,002h	; aa1b
	defb 008h,000h	; aa1d
	defb 008h,000h	; aa1f
	defb 008h,000h	; aa21
	defb 008h,000h	; aa23
	defb 008h,000h	; aa25
	defb 008h,000h	; aa27
	defb 008h,000h	; aa29
	defb 008h,000h	; aa2b
	defb 008h,000h	; aa2d
	defb 008h,000h	; aa2f
	defb 008h,000h	; aa31
	defb 008h,000h	; aa33
	defb 008h,000h	; aa35
	defb 008h,000h	; aa37
	defb 007h,002h	; aa39
	defb 006h,004h	; aa3b
	defb 005h,006h	; aa3d

; ======================================================================
; CODIGO 0xaa3f..0xaa8a  (75 bytes)
; ======================================================================


L_AA3F:
	ld hl,(0e204h)		;aa3f   ; la Y en la pantalla de lo que se maneja
	ld a,l			;aa42
	add a,01eh		;aa43
	ld l,a			;aa45
	jp los_dos_sprites_de_debajo		;aa46
L_AA49:
	ld hl,(0e204h)		;aa49   ; la Y en la pantalla de lo que se maneja
	ld l,0b0h		;aa4c
	jp los_dos_sprites_de_debajo		;aa4e
L_AA51:
	ld hl,(0e204h)		;aa51   ; la Y en la pantalla de lo que se maneja
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
; DATOS despacho_de_AA87: 3 punteros pegados detras del `call despacha` de
;   p03:AA87: la rutina a la que se salta con A
;   0xaa8a..0xaa90  (6 bytes)
DATA_despacho_de_AA87:
	defb 05bh,0abh	; aa8a
	defb 041h,0ach	; aa8c
	defb 090h,0aah	; aa8e

; ======================================================================
; CODIGO 0xaa90..0xad88  (760 bytes)
; ======================================================================


L_AA90:
	djnz el_paso_1_monta_la_pantalla		;aa90
	call L_ACD6		;aa92
	ret nz			;aa95
	ld de,0b2ech		;aa96
	ld (0e4e0h),de		;aa99   ; la tabla de cambio de color, nibble alto
	jp L_AAE6		;aa9d
el_paso_1_monta_la_pantalla:
	djnz L_AAB1		;aaa0   ; si no es el 1, al siguiente
	call 05667h		;aaa2   ; las cuatro piezas de la pantalla
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
	ld (0e204h),a		;aad2   ; la Y en la pantalla de lo que se maneja
	ld a,06dh		;aad5
	ld (0e205h),a		;aad7   ; la X en la pantalla de lo que se maneja
	jr L_AAE6		;aada
L_AADC:
	djnz L_AAE8		;aadc
	ld a,(0e204h)		;aade   ; la Y en la pantalla de lo que se maneja
	cp 082h		;aae1
	jp nz,L_ACE6		;aae3
L_AAE6:
	jr L_AB28		;aae6
L_AAE8:
	djnz el_ultimo_del_recorrido		;aae8
L_AAEA:
	ld a,(0e003h)		;aaea   ; el contador de cuadros
	and 00fh		;aaed
	ret nz			;aaef
	ld hl,0a432h		;aaf0
	call L_AD0B		;aaf3
	call L_AD14		;aaf6
	jr L_AB51		;aaf9
el_ultimo_del_recorrido:
	djnz L_AB13		;aafb   ; si no es el ultimo, nada de esto
	ld a,(0e012h)		;aafd   ; y 0xE012 tambien lo frena
	and a			;ab00
	ret nz			;ab01
	xor a			;ab02   ; el recorrido, otra vez al principio
	ld (0e0b8h),a		;ab03
	ld hl,0a456h		;ab06   ; el juego de atributos de 0xA456
	call L_AD0B		;ab09
	ld a,0a4h		;ab0c   ; y el efecto 0xA4
	call 04145h		;ab0e   ; banco 0: pide_sonido
	jr L_AB28		;ab11
L_AB13:
	djnz L_AB2A		;ab13
	ld a,(0e003h)		;ab15   ; el contador de cuadros
	and 003h		;ab18
	ret nz			;ab1a
	ld a,(0e0b8h)		;ab1b
	cp 011h		;ab1e
	jp c,los_cuatro_sprites_del_que_anda		;ab20
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
	ld (0e205h),a		;ab87   ; la X en la pantalla de lo que se maneja
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
	ld (0e204h),a		;aba0   ; la Y en la pantalla de lo que se maneja
	jr L_AB75		;aba3
L_ABA5:
	djnz L_ABBC		;aba5
L_ABA7:
	ld a,(0e204h)		;aba7   ; la Y en la pantalla de lo que se maneja
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
	ld (0e204h),a		;abeb   ; la Y en la pantalla de lo que se maneja
	call L_A8DB		;abee
	xor a			;abf1
	ld hl,0e0b8h		;abf2
	dec (hl)			;abf5
	jp nz,pon_la_pose_en_lo_que_se_maneja		;abf6
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
	djnz el_paso_de_la_columna_final		;ac41
	jp L_AB5D		;ac43
el_paso_de_la_columna_final:
	djnz el_paso_de_los_ocho_bytes		;ac46   ; si no es este, al siguiente
	call 048fch		;ac48
	call 05717h		;ac4b
	ld hl,0b963h		;ac4e   ; el guion de 0xB963
	ld (0e4e2h),hl		;ac51   ; apuntado para luego
	jp L_AB6F		;ac54
el_paso_de_los_ocho_bytes:
	djnz L_AC67		;ac57   ; si no es este, al siguiente
	ld hl,0ae07h		;ac59   ; los ocho bytes de 0xAE07...
	ld bc,00008h		;ac5c
	ld de,0ee98h		;ac5f   ; ...a los sprites 6 y 7
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
	ld (0e205h),a		;ac90   ; la X en la pantalla de lo que se maneja
	ld a,0bfh		;ac93
	ld (0e204h),a		;ac95   ; la Y en la pantalla de lo que se maneja
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
	jr z,pinta_seis_sprites_y_avanza		;acc3
	ld hl,0adefh		;acc5
pinta_seis_sprites_y_avanza:
	ld bc,00018h		;acc8   ; 24 bytes: seis sprites
	ld de,0ee80h		;accb   ; desde el primero
	ldir		;acce
	ld hl,0e0b8h		;acd0
	ld a,(hl)			;acd3   ; y un paso mas del recorrido
	inc (hl)			;acd4
	ret			;acd5
L_ACD6:
	call 07baeh		;acd6   ; banco 1
	xor a			;acd9
	ld de,00020h		;acda
borra_una_columna_de_la_tabla:
	ld (hl),a			;acdd   ; un byte
	add hl,de			;acde   ; y 0x20 mas alla: la fila siguiente
	djnz borra_una_columna_de_la_tabla		;acdf
	ld a,(0e0b8h)		;ace1   ; y al acabar, por que paso va
	and a			;ace4
	ret			;ace5
L_ACE6:
	ld a,(0e003h)		;ace6   ; el contador de cuadros
	and 003h		;ace9
	ret nz			;aceb
	ld a,(0e204h)		;acec   ; la Y en la pantalla de lo que se maneja
	dec a			;acef
	ld (0e204h),a		;acf0   ; la Y en la pantalla de lo que se maneja
	call L_A8DB		;acf3
	ld a,(0e204h)		;acf6   ; la Y en la pantalla de lo que se maneja
	and 001h		;acf9
	jr z,L_AD08		;acfb
	ld a,(0e204h)		;acfd   ; la Y en la pantalla de lo que se maneja
	and 002h		;ad00
	ld a,001h		;ad02
	jr z,L_AD08		;ad04
	ld a,002h		;ad06
L_AD08:
	jp pon_la_pose_en_lo_que_se_maneja		;ad08
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
	ld (0e204h),a		;ad39   ; la Y en la pantalla de lo que se maneja
	call L_A8DB		;ad3c
	ld a,(0e0b8h)		;ad3f
	and 001h		;ad42
	ld a,003h		;ad44
	jr z,L_AD49		;ad46
	inc a			;ad48
L_AD49:
	jp pon_la_pose_en_lo_que_se_maneja		;ad49
L_AD4C:
	ld hl,0adaah		;ad4c
	ld de,0eef0h		;ad4f
	ld bc,00010h		;ad52
	ldir		;ad55
	ret			;ad57

; ----------------------------------------------------------------------
; LOS CUATRO SPRITES DEL QUE ANDA. Las diecisiete parejas de 0xAD88, indexadas por (0xE0B8) por dos: la primera coordenada va al sprite 28 y, cinco menos, a los sprites 29, 30 y 31; la segunda va a los cuatro igual. Y al final sube (0xE0B8), o sea que cada llamada lo adelanta un paso: los diecisiete son el recorrido entero.
; ----------------------------------------------------------------------
los_cuatro_sprites_del_que_anda:
	call L_AD4C		;ad58
	ld a,(0e0b8h)		;ad5b   ; por que paso va
	sla a		;ad5e   ; dos bytes por paso
	ld hl,0ad88h		;ad60   ; las diecisiete parejas
	call 04056h		;ad63   ; banco 0: a_mas_hl
	ld a,(hl)			;ad66
	ld (0eef0h),a		;ad67   ; al sprite 28
	sub 005h		;ad6a   ; cinco menos...
	ld (0eef4h),a		;ad6c   ; ...a los sprites 29...
	ld (0eef8h),a		;ad6f   ; ...30...
	ld (0eefch),a		;ad72   ; ...y 31
	inc hl			;ad75
	ld a,(hl)			;ad76   ; y la otra coordenada
	ld (0eef1h),a		;ad77
	ld (0eef5h),a		;ad7a
	ld (0eef9h),a		;ad7d
	ld (0eefdh),a		;ad80
	ld hl,0e0b8h		;ad83   ; un paso mas para la proxima
	inc (hl)			;ad86
	ret			;ad87

; ----------------------------------------------------------------------
; DATOS parejas_por_E0B8: diecisiete parejas que p03:AD60 indexa con (0xE0B8)
;   por dos: el primer byte va a 0xEEF0 y, menos cinco, a 0xEEF4 y 0xEEF8
;   0xad88..0xadaa  (34 bytes)
DATA_parejas_por_E0B8:
	defb 038h,080h	; ad88
	defb 03ch,080h	; ad8a
	defb 041h,080h	; ad8c
	defb 047h,080h	; ad8e
	defb 04eh,080h	; ad90
	defb 056h,080h	; ad92
	defb 05eh,080h	; ad94
	defb 067h,080h	; ad96
	defb 070h,080h	; ad98
	defb 067h,07fh	; ad9a
	defb 05eh,07eh	; ad9c
	defb 056h,07ch	; ad9e
	defb 050h,07ah	; ada0
	defb 056h,078h	; ada2
	defb 05eh,076h	; ada4
	defb 067h,075h	; ada6
	defb 070h,074h	; ada8

; ----------------------------------------------------------------------
; DATOS dieciseis_a_EEF0: dieciseis bytes que p03:AD4C copia con ldir a 0xEEF0
;   0xadaa..0xadba  (16 bytes)
DATA_dieciseis_a_EEF0:
	defb 038h,080h,0f0h,00ah,033h,080h,0f4h,001h,033h,080h,0f8h,008h,026h,077h,0fch,002h	; adaa  8...3...3...&w..

; ----------------------------------------------------------------------
; DATOS arco_por_E0B8: veintinueve valores de Y, simetricos (0x79 baja hasta
;   0x50 y vuelve a 0x79: un arco), que p03:AD2F indexa con (0xE0B8) y pone en
;   0xE204
;   0xadba..0xadd7  (29 bytes)
DATA_arco_por_E0B8:
	defb 079h,071h,06dh,068h,064h,060h,05dh,05ah,058h,056h,054h,053h,052h,051h,050h,051h	; adba  yqmhd`]ZXVTSRQPQ
	defb 052h,053h,054h,056h,058h,05ah,05dh,060h,064h,068h,06dh,071h,079h	; adca  RSTVXZ]`dhmqy

; ----------------------------------------------------------------------
; DATOS atributos_ADD7: dos juegos de 24 bytes que p03:ACC0 y ACC5 copian con
;   ldir a 0xEE80 segun el bit 0 de A, y ocho bytes (0xAE07) que p03:AC59
;   copia a 0xEE98
;   0xadd7..0xae0f  (56 bytes)
DATA_atributos_ADD7:
	defb 07bh,070h,0b8h,001h,07bh,080h,0bch,001h,08bh,070h,0c0h,001h,08bh,080h,0c4h,001h,0d1h,000h,000h,000h,0d1h,000h,000h,000h	; add7  {p..{....p..............
	defb 07bh,070h,0c8h,001h,07bh,080h,0cch,001h,08bh,070h,0d0h,001h,08bh,080h,0d4h,001h,07bh,070h,0d8h,00fh,07bh,080h,0dch,00fh	; adef  {p..{....p......{p..{...
	defb 047h,078h,0e0h,001h,047h,088h,0e4h,001h	; ae07  Gx..G...

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
; DATOS ocho_a_E530: ocho bytes que p03:AE0F copia con ldir a 0xE530
;   0xae1b..0xae23  (8 bytes)
DATA_ocho_a_E530:
	defb 001h,000h,000h,030h,000h,080h,080h,002h	; ae1b  ...0....

; ======================================================================
; CODIGO 0xae23..0xae3a  (23 bytes)
; ======================================================================


monta_los_cuatro_registros_y_sus_sprites:
	ld hl,0ae3ah		;ae23   ; los treinta y dos bytes de 0xAE3A...
	ld de,0e550h		;ae26   ; ...a los cuatro registros de 0xE550
	ld bc,00020h		;ae29
	ldir		;ae2c
	ld hl,0ae5ah		;ae2e   ; y los dieciseis de 0xAE5A...
	ld de,0eea8h		;ae31   ; ...a los sprites 10, 11, 12 y 13
	ld bc,00010h		;ae34
	ldir		;ae37
	ret			;ae39

; ----------------------------------------------------------------------
; DATOS treinta_y_dos_y_dieciseis: 32 bytes que p03:AE23 copia a 0xE550 y 16
;   (0xAE5A) que p03:AE2E copia a 0xEEA8
;   0xae3a..0xae6a  (48 bytes)
DATA_treinta_y_dos_y_dieciseis:
	defb 001h,0ffh,028h,041h,000h,000h,000h,000h,001h,0ffh,060h,001h,000h,000h,000h,000h	; ae3a  ..(A......`.....
	defb 001h,0ffh,098h,021h,000h,000h,000h,000h,001h,0ffh,0d0h,061h,000h,000h,000h,000h	; ae4a  ...!.......a....
	defb 0e0h,000h,0a0h,004h,0e0h,000h,0a0h,004h,0e0h,000h,0a0h,004h,0e0h,000h,0a0h,004h	; ae5a  ................

; ======================================================================
; CODIGO 0xae6a..0xaf4b  (225 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL BLANCO SE MUEVE. Solo mientras 0xE530 valga 1 y no haya nada en vuelo (0xE540 en 1 o 2). El modo lo lleva 0xE534: con 1 va hacia un lado y con 2 hacia el otro, y en los dos casos la cuenta de 0xE533 baja y toca dos puntos por el camino -en 0x40 cambia de dibujo y en 0x20 se mueve de verdad a la columna siguiente-. Al llegar a cero, a lanzar.
; ----------------------------------------------------------------------
el_blanco_se_mueve:
	ld a,(0e530h)		;ae6a   ; ¿esta en marcha?
	dec a			;ae6d
	ret nz			;ae6e
	ld a,(0e540h)		;ae6f   ; ¿hay algo en vuelo?
	dec a			;ae72   ; en el tiempo 1...
	ret z			;ae73
	dec a			;ae74   ; ...y en el 2, no se mueve
	ret z			;ae75
	ld hl,0e534h		;ae76   ; el modo
	ld a,(hl)			;ae79
	dec l			;ae7a
	and a			;ae7b
	jr z,L_AED2		;ae7c   ; el 0 va por otro lado
	dec a			;ae7e   ; el 1, hacia delante
	jr z,el_blanco_va_hacia_atras		;ae7f
	dec (hl)			;ae81   ; la cuenta, un paso menos
	jp z,el_blanco_lanza		;ae82   ; y a cero, a lanzar
	ld a,(hl)			;ae85
	cp 040h		;ae86   ; a mitad de camino, el dibujo
	jr z,el_blanco_cambia_de_dibujo		;ae88
	cp 020h		;ae8a   ; y a un cuarto, el paso de verdad
	jr z,el_blanco_da_un_paso_adelante		;ae8c
	ret			;ae8e
el_blanco_cambia_de_dibujo:
	dec l			;ae8f
	dec l			;ae90
	ld (hl),002h		;ae91   ; el dibujo 2
	ret			;ae93
el_blanco_da_un_paso_adelante:
	ld a,(0e537h)		;ae94   ; en que columna esta
	inc a			;ae97   ; la siguiente
	ld (0e537h),a		;ae98
	dec l			;ae9b
	dec l			;ae9c
	ld (hl),001h		;ae9d   ; el dibujo 1
	ld hl,0af4bh		;ae9f   ; las cinco columnas
	call 04056h		;aea2   ; banco 0: a_mas_hl
	ld a,(hl)			;aea5
	ld (0e536h),a		;aea6   ; y la que le toca ahora
	ret			;aea9
el_blanco_va_hacia_atras:
	dec (hl)			;aeaa   ; la cuenta, un paso menos
	jr z,el_blanco_lanza		;aeab   ; y a cero, a lanzar
	ld a,(hl)			;aead
	cp 040h		;aeae   ; a mitad de camino, el dibujo
	jr z,el_blanco_cambia_de_dibujo_bis		;aeb0
	cp 020h		;aeb2   ; y a un cuarto, el paso de verdad
	jr z,el_blanco_da_un_paso_atras		;aeb4
	ret			;aeb6
el_blanco_cambia_de_dibujo_bis:
	dec l			;aeb7
	dec l			;aeb8
	ld (hl),001h		;aeb9   ; el dibujo 1
	ret			;aebb
el_blanco_da_un_paso_atras:
	ld a,(0e537h)		;aebc   ; en que columna esta
	dec a			;aebf   ; la anterior
	ld (0e537h),a		;aec0
	dec l			;aec3
	dec l			;aec4
	ld (hl),002h		;aec5   ; el dibujo 2
	ld hl,0af4bh		;aec7   ; las cinco columnas
	call 04056h		;aeca   ; banco 0: a_mas_hl
	ld a,(hl)			;aecd   ; y la que le toca ahora
	ld (0e536h),a		;aece
	ret			;aed1
L_AED2:
	dec (hl)			;aed2
	ret z			;aed3
	inc l			;aed4
	inc l			;aed5
	inc l			;aed6
	ld a,(0e205h)		;aed7   ; la X en la pantalla de lo que se maneja
	add a,010h		;aeda
	cp (hl)			;aedc
	jr nc,L_AF03		;aedd
	dec l			;aedf
	dec l			;aee0
	dec l			;aee1
	ld a,(0e537h)		;aee2
	and a			;aee5
	jr z,el_blanco_lanza		;aee6
	ld c,a			;aee8
	ld a,(0e092h)		;aee9   ; la FASE, de 1 a 24
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
	jr z,el_blanco_lanza		;af0b
	ld c,a			;af0d
	ld a,(0e092h)		;af0e   ; la FASE, de 1 a 24
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

; ----------------------------------------------------------------------
; Y A LANZAR. La cuenta de espera sale de la tabla de 0xAF69, que tiene un byte por fase: o sea que cada fase tiene su ritmo. Coloca el blanco en la columna que le toque y arma lo que se lanza.
; ----------------------------------------------------------------------
el_blanco_lanza:
	ld a,(0e092h)		;af28   ; la fase
	ld de,0af69h		;af2b   ; un byte de espera por fase
	call 0405bh		;af2e   ; banco 0: a_mas_de
	ld a,(de)			;af31
	ld (hl),a			;af32   ; esa es la cuenta
	inc l			;af33
	ld (hl),000h		;af34   ; y lo demas, a cero
	dec l			;af36
	dec l			;af37
	dec l			;af38
	ld (hl),000h		;af39
	ld a,(0e537h)		;af3b   ; en que columna esta
	ld hl,0af4bh		;af3e   ; las cinco columnas
	call 04056h		;af41   ; banco 0: a_mas_hl
	ld a,(hl)			;af44
	ld (0e536h),a		;af45   ; la que le toca
	jp arma_lo_que_se_lanza		;af48   ; y a armar lo que se lanza

; ----------------------------------------------------------------------
; DATOS bytes_por_fase_AF4B: tres tablas pegadas: cinco bytes en 0xAF4B que
;   p03:AE9F, AEC7 y AEF8 llevan a 0xE536, y dos de 25 bytes, 0xAF50 y 0xAF69,
;   que p03:AEEC, AF11 y AF2B indexan con la fase (0xE092) desde 1
;   0xaf4b..0xaf82  (55 bytes)
DATA_bytes_por_fase_AF4B:
	defb 070h,078h,080h,088h,090h	; af4b
	defb 000h,060h,060h,060h,05ch	; af50
	defb 05ch,05ch,058h,058h,058h	; af55
	defb 054h,054h,054h,050h,050h	; af5a
	defb 050h,04ch,04ch,04ch,048h	; af5f
	defb 048h,048h,044h,044h,044h	; af64
	defb 000h,030h,030h,030h,02ch	; af69
	defb 02ch,02ch,028h,028h,028h	; af6e
	defb 024h,024h,024h,020h,020h	; af73
	defb 020h,01ch,01ch,01ch,018h	; af78
	defb 018h,018h,014h,014h,014h	; af7d

; ======================================================================
; CODIGO 0xaf82..0xafb7  (53 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; DE QUE LADO ESTA EL JUGADOR. Compara la columna del jugador -corrida dieciseis, que es el centro de su figura- con la del blanco, y de ahi sale el tipo que va a 0xE532: 0 si esta a menos de 0x20, o sea enfrente; 1 si esta a la izquierda y 2 si esta a la derecha. Ese es el tipo que lee luego 0xB195 para decidir por donde sale lo que se lanza.
; ----------------------------------------------------------------------
de_que_lado_esta_el_jugador:
	ld a,(0e530h)		;af82   ; ¿esta en marcha?
	dec a			;af85
	ret nz			;af86
	ld a,(0e540h)		;af87   ; ¿hay algo en vuelo?
	dec a			;af8a
	ret z			;af8b
	dec a			;af8c
	ret z			;af8d
	ld hl,0e536h		;af8e   ; la columna del blanco
	ld a,(0e205h)		;af91   ; la del jugador...
	add a,010h		;af94   ; ...por su centro
	sub (hl)			;af96
	jr nc,el_jugador_esta_a_la_derecha		;af97
	neg		;af99   ; esta a la izquierda
	cp 020h		;af9b   ; ¿a mas de 0x20?
	ld a,001h		;af9d   ; pues el tipo 1
	jr nc,guarda_de_que_lado_esta		;af9f
	xor a			;afa1   ; y si no, enfrente: el tipo 0
	jr guarda_de_que_lado_esta		;afa2
el_jugador_esta_a_la_derecha:
	cp 020h		;afa4   ; ¿a mas de 0x20?
	ld a,002h		;afa6   ; pues el tipo 2
	jr nc,guarda_de_que_lado_esta		;afa8
	xor a			;afaa   ; y si no, enfrente
guarda_de_que_lado_esta:
	ld (0e532h),a		;afab   ; el tipo, para 0xB195
	ret			;afae
L_AFAF:
	ld a,(0e530h)		;afaf
	sub 002h		;afb2
	call 04060h		;afb4   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_AFB4: 3 punteros pegados detras del `call despacha` de
;   p03:AFB4: la rutina a la que se salta con A
;   0xafb7..0xafbd  (6 bytes)
DATA_despacho_de_AFB4:
	defb 0bdh,0afh	; afb7
	defb 0d4h,0afh	; afb9
	defb 0afh,0b0h	; afbb

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

; ----------------------------------------------------------------------
; EL DESPLAZAMIENTO DEL FONDO. Uno de cada ocho cuadros le suma 0x20 a los dos bytes de 0xE538, y de paso cuenta los pasos en 0xE531: al llegar a diez, apaga 0xE530 y con eso se para todo lo del blanco.
; ----------------------------------------------------------------------
el_desplazamiento_del_fondo:
	ld a,(0e003h)		;b0af   ; el contador de cuadros
	and 007h		;b0b2   ; uno de cada ocho
	ret nz			;b0b4
	ld hl,(0e538h)		;b0b5   ; el desplazamiento
	ld de,00020h		;b0b8   ; 0x20 mas
	add hl,de			;b0bb
	ld (0e538h),hl		;b0bc
	ld hl,0e531h		;b0bf   ; y un paso mas
	inc (hl)			;b0c2
	ld a,(hl)			;b0c3
	sub 00ah		;b0c4   ; a los diez pasos...
	ret nz			;b0c6
	ld (0e530h),a		;b0c7   ; ...se para todo
	ret			;b0ca

; ----------------------------------------------------------------------
; DATOS doce_caracteres_de_8: doce bloques de 8 bytes que el banco 3 manda a
;   la VRAM con copia_a_vram (p00:428F) desde p03:AFE8 a p03:B0A3: patrones en
;   0x2D98/0x2E80 y colores en 0x0D98/0x0E80
;   0xb0cb..0xb12b  (96 bytes)
DATA_doce_caracteres_de_8:
	defb 03ch,07eh,0fbh,0f5h,0fbh,07eh,03ch,0efh	; b0cb  <~...~<.
	defb 000h,000h,038h,06ch,05ch,038h,0d7h,0f7h	; b0d3  ..8l\8..
	defb 000h,000h,01ch,036h,03ah,01ch,0ebh,0efh	; b0db  ...6:...
	defb 03ch,07eh,0dfh,0afh,0dfh,07eh,03ch,0f7h	; b0e3  <~...~<.
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,060h	; b0eb  .......`
	defb 066h,066h,0f6h,0f6h,0f6h,0f6h,060h,060h	; b0f3  ff....``
	defb 066h,066h,0f6h,0f6h,0f6h,0f6h,060h,060h	; b0fb  ff....``
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,060h	; b103  .......`
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,040h	; b10b  .......@
	defb 044h,044h,0f4h,0f4h,0f4h,0f4h,040h,040h	; b113  DD....@@
	defb 044h,044h,0f4h,0f4h,0f4h,0f4h,040h,040h	; b11b  DD....@@
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,040h	; b123  .......@

; ======================================================================
; CODIGO 0xb12b..0xb174  (73 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LOS CUATRO DE 0xE550. Cuatro registros de siete bytes y sus sprites a partir del 10 (0xEEA8). Solo se mueven los del tipo 1, y lo que hacen es bajar de tres en tres hasta la fila 0xA0; alli se apuntan en el byte de antes, se van de la pantalla con 0xE0 en la fila y suena el efecto 0x1D. El cuarto byte del registro, si no es cero, los frena: se descuenta y se quedan donde estan.
; ----------------------------------------------------------------------
los_cuatro_de_0xE550:
	ld b,004h		;b12b   ; cuatro
	ld hl,0e550h		;b12d   ; los cuatro registros
	ld de,0eea8h		;b130   ; y sus sprites, desde el 10
mueve_uno_de_0xE550:
	ld a,(hl)			;b133   ; el tipo
	inc l			;b134
	dec a			;b135   ; solo se mueve el 1
	jr nz,al_registro_siguiente_de_0xE550		;b136
	inc l			;b138
	inc l			;b139
	ld a,(hl)			;b13a   ; ¿esta frenado?
	and a			;b13b
	jr nz,se_descuenta_el_freno		;b13c   ; si lo esta, se descuenta y ya
	dec l			;b13e
	dec l			;b13f
	ld a,(hl)			;b140   ; la fila
	add a,003h		;b141   ; tres mas abajo
	ld (hl),a			;b143
	cp 0a0h		;b144   ; hasta la 0xA0
	jr c,al_registro_siguiente_de_0xE550		;b146
	dec l			;b148
	inc (hl)			;b149   ; alli se apunta
	inc l			;b14a
	ld a,0e0h		;b14b   ; 0xE0 en la fila: fuera de la pantalla
	ld (de),a			;b14d
	ld a,01dh		;b14e   ; y el efecto 0x1D
	call 0413ah		;b150   ; banco 0: pide_sonido_si_esta_activo
	jr al_registro_siguiente_de_0xE550		;b153
se_descuenta_el_freno:
	dec (hl)			;b155
	dec l			;b156
	dec l			;b157
al_registro_siguiente_de_0xE550:
	ld a,007h		;b158   ; siete bytes el registro...
	call 04056h		;b15a   ; banco 0: a_mas_hl
	ld a,004h		;b15d   ; ...y cuatro el sprite
	call 0405bh		;b15f   ; banco 0: a_mas_de
	djnz mueve_uno_de_0xE550		;b162
	ret			;b164

; ----------------------------------------------------------------------
; ARMAR LO QUE SE LANZA. Copia de un tiron los dieciseis bytes del registro de 0xB174 a 0xE540, y solo si el primero de alli esta a cero, o sea si no hay ya uno en vuelo: nunca hay dos a la vez.
; ----------------------------------------------------------------------
arma_lo_que_se_lanza:
	ld hl,0b174h		;b165   ; el registro de partida
	ld de,0e540h		;b168
	ld a,(de)			;b16b   ; ¿hay ya uno en vuelo?
	and a			;b16c
	ret nz			;b16d   ; si lo hay, no se arma otro
	ld bc,00010h		;b16e   ; los dieciseis bytes del registro
	ldir		;b171
	ret			;b173

; ----------------------------------------------------------------------
; DATOS dieciseis_a_E540: dieciseis bytes que p03:B165 copia con ldir a 0xE540
;   si el primero de alli esta a cero
;   0xb174..0xb184  (16 bytes)
DATA_dieciseis_a_E540:
	defb 001h,000h,000h,000h,000h,000h,000h,0e0h,000h,000h,09ch,00ah,020h,000h,000h,000h	; b174  ............ ...

; ======================================================================
; CODIGO 0xb184..0xb18a  (6 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LO QUE SE LANZA, EN CINCO TIEMPOS. El despachador de la casa sobre 0xE540: 0 quieto, 1 aparecer y apuntar, y 2, 3 y 4 los tres tramos de la bajada. Los tiempos se encadenan solos, cada uno subiendo 0xE540 cuando llega a su fila.
; ----------------------------------------------------------------------
lo_que_se_lanza:
	ld a,(0e540h)		;b184   ; por que tiempo va
	call 04060h		;b187   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_B187: 5 punteros pegados detras del `call despacha` de
;   p03:B187: la rutina a la que se salta con A
;   0xb18a..0xb194  (10 bytes)
DATA_despacho_de_B187:
	defb 094h,0b1h	; b18a
	defb 095h,0b1h	; b18c
	defb 036h,0b2h	; b18e
	defb 060h,0b2h	; b190
	defb 08ah,0b2h	; b192

; ======================================================================
; CODIGO 0xb194..0xb212  (126 bytes)
; ======================================================================


lo_que_se_lanza_quieto:
	ret			;b194   ; el tiempo 0 no hace nada

; ----------------------------------------------------------------------
; APARECER Y PARPADEAR. Se planta en la fila 0x7C y en la columna que diga 0xE536 mas un desvio que depende de 0xE532 -el tipo: -6, -28 o +16-, y se queda 32 cuadros cambiando entre los dibujos 0xA4 y 0xA8 cada ocho. Ese parpadeo es el aviso: mientras dura, todavia no se ha lanzado.
; ----------------------------------------------------------------------
lo_que_se_lanza_aparece:
	ld a,(0e536h)		;b195   ; de donde sale
	ld c,a			;b198
	ld a,(0e532h)		;b199   ; y de que tipo es
	and a			;b19c
	ld b,0fah		;b19d   ; el tipo 0 se desvia seis columnas a la izquierda...
	jr z,L_B1A8		;b19f
	dec a			;b1a1
	ld b,0e4h		;b1a2   ; ...el 1 veintiocho...
	jr z,L_B1A8		;b1a4
	ld b,010h		;b1a6   ; ...y el resto dieciseis a la derecha
L_B1A8:
	ld a,c			;b1a8
	add a,b			;b1a9   ; la columna de salida
	ld h,a			;b1aa
	ld l,000h		;b1ab   ; sin fraccion
	ld (0e548h),hl		;b1ad   ; la columna, con sus dos bytes
	ld hl,07c00h		;b1b0   ; y la fila, la 0x7C
	ld (0e546h),hl		;b1b3
	ld hl,0e54ch		;b1b6   ; la cuenta del parpadeo
	dec (hl)			;b1b9   ; al acabarse, a apuntar
	jr z,lo_que_se_lanza_apunta		;b1ba
	bit 3,(hl)		;b1bc   ; el bit 3: cambia de dibujo cada ocho cuadros
	ld a,0a4h		;b1be   ; uno...
	jr nz,L_B1C4		;b1c0
	ld a,0a8h		;b1c2   ; ...y otro
L_B1C4:
	ld (0e54ah),a		;b1c4   ; el dibujo que toca
	ret			;b1c7

; ----------------------------------------------------------------------
; APUNTAR. Aqui es donde deja de ser adorno: mira donde esta lo que se maneja (0xE205) y escoge uno de los tres pasos del registro de su tipo -a la izquierda, recto o a la derecha- segun de que lado le quede y a que distancia. Si la diferencia es menor de 16 columnas, va recto. Y suena el efecto 0x1E, que es el del lanzamiento.
; ----------------------------------------------------------------------
lo_que_se_lanza_apunta:
	ld hl,0e540h		;b1c8   ; al tiempo siguiente
	inc (hl)			;b1cb
	ld a,(0e532h)		;b1cc   ; de que tipo es
	and a			;b1cf
	ld de,0b212h		;b1d0   ; y cada tipo tiene sus tres pasos
	jr z,L_B1DE		;b1d3
	dec a			;b1d5
	ld de,0b21eh		;b1d6
	jr z,L_B1DE		;b1d9
	ld de,0b22ah		;b1db
L_B1DE:
	ld b,000h		;b1de
	ld hl,0e549h		;b1e0   ; la columna donde esta
	ld a,(0e205h)		;b1e3   ; y donde esta lo que se maneja, por el centro
	add a,010h		;b1e6
	sub (hl)			;b1e8
	jr nc,L_B1EE		;b1e9   ; a la derecha...
	inc b			;b1eb
	neg		;b1ec   ; ...o a la izquierda, y en valor absoluto
L_B1EE:
	cp 010h		;b1ee   ; ¿a menos de 16 columnas?
	ld c,004h		;b1f0   ; entonces recto
	jr c,L_B1FB		;b1f2
	dec b			;b1f4
	ld c,000h		;b1f5   ; y si no, a un lado...
	jr z,L_B1FB		;b1f7
	ld c,008h		;b1f9   ; ...o al otro
L_B1FB:
	ld a,c			;b1fb
	call 0405bh		;b1fc   ; el paso escogido
	ex de,hl			;b1ff
	ld de,0e542h		;b200   ; sus cuatro bytes, al registro
	ld bc,00004h		;b203
	ldir		;b206
	ld a,0ach		;b208   ; el dibujo del vuelo
	ld (0e54ah),a		;b20a
	ld a,01eh		;b20d   ; y el efecto 0x1E: se ha lanzado
	jp 0413ah		;b20f   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS tres_registros_de_12: tres registros de 12 bytes que p03:B1D0 escoge
;   segun A (0, 1 u otro) y lee en DE
;   0xb212..0xb236  (36 bytes)
DATA_tres_registros_de_12:
	defb 06ah,000h,01eh,0ffh,06ah,000h,000h,000h,06ah,000h,0e2h,000h	; b212  j...j...j...
	defb 06ah,000h,0d9h,0feh,06ah,000h,01eh,0ffh,06ah,000h,000h,000h	; b21e  j...j...j...
	defb 06ah,000h,000h,000h,06ah,000h,0e2h,000h,06ah,000h,027h,001h	; b22a  j...j...j.'.

; ======================================================================
; CODIGO 0xb236..0xb30b  (213 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; PRIMER TRAMO DE LA BAJADA. Los tres tramos son la misma cuenta: suma el paso de la fila (0xE542) y el de la columna (0xE544) a la posicion, los dos con un byte de fraccion por debajo, y mira la fila entera. Este llega hasta la 0x88; alli pasa al tramo siguiente y cambia al dibujo 0xB0. Los dibujos van 0xAC, 0xB0 y 0xB4 segun baja.
; ----------------------------------------------------------------------
lo_que_se_lanza_baja_hasta_0x88:
	ld hl,0e542h		;b236   ; el paso de la fila
	ld e,(hl)			;b239
	inc l			;b23a
	ld d,(hl)			;b23b
	inc l			;b23c
	ld c,(hl)			;b23d   ; y el de la columna
	inc l			;b23e
	ld b,(hl)			;b23f
	inc l			;b240
	ld a,e			;b241   ; la fraccion de la fila...
	add a,(hl)			;b242
	ld (hl),a			;b243
	inc hl			;b244
	ld a,d			;b245   ; ...y su parte entera, con el acarreo
	adc a,(hl)			;b246
	ld (hl),a			;b247
	inc l			;b248
	ld a,c			;b249   ; lo mismo con la columna
	add a,(hl)			;b24a
	ld (hl),a			;b24b
	inc hl			;b24c
	ld a,b			;b24d
	adc a,(hl)			;b24e
	ld (hl),a			;b24f
	dec l			;b250
	dec l			;b251
	ld a,(hl)			;b252   ; la fila entera
	cp 088h		;b253   ; ¿ha llegado a la 0x88?
	ret c			;b255
	ld hl,0e540h		;b256   ; pues al tramo siguiente
	inc (hl)			;b259
	ld a,0b0h		;b25a   ; con su dibujo
	ld (0e54ah),a		;b25c
	ret			;b25f
lo_que_se_lanza_baja_hasta_0x90:
	ld hl,0e542h		;b260
	ld e,(hl)			;b263   ; el paso de la fila
	inc l			;b264
	ld d,(hl)			;b265
	inc l			;b266
	ld c,(hl)			;b267   ; y el de la columna
	inc l			;b268
	ld b,(hl)			;b269
	inc l			;b26a
	ld a,e			;b26b   ; la fraccion de la fila...
	add a,(hl)			;b26c
	ld (hl),a			;b26d
	inc hl			;b26e
	ld a,d			;b26f   ; ...y su parte entera, con el acarreo
	adc a,(hl)			;b270
	ld (hl),a			;b271
	inc l			;b272
	ld a,c			;b273   ; lo mismo con la columna
	add a,(hl)			;b274
	ld (hl),a			;b275
	inc hl			;b276
	ld a,b			;b277
	adc a,(hl)			;b278
	ld (hl),a			;b279
	dec l			;b27a
	dec l			;b27b
	ld a,(hl)			;b27c   ; la fila entera
	cp 090h		;b27d   ; este acaba en la fila 0x90
	ret c			;b27f
	ld hl,0e540h		;b280
	inc (hl)			;b283
	ld a,0b4h		;b284   ; y el dibujo, el tercero
	ld (0e54ah),a		;b286
	ret			;b289
lo_que_se_lanza_baja_hasta_el_final:
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
	cp 010h		;b2a4   ; si se ha ido por la izquierda...
	jr c,lo_que_se_lanza_se_va		;b2a6
	cp 0e0h		;b2a8   ; ...o por la derecha, se acabo
	jr nc,lo_que_se_lanza_se_va		;b2aa
	dec l			;b2ac
	dec l			;b2ad
	ld a,(hl)			;b2ae   ; la fila entera
	cp 0a8h		;b2af   ; y por abajo, la 0xA8
	ret c			;b2b1

; ----------------------------------------------------------------------
; QUITARLO DE EN MEDIO. Borra los dieciseis bytes del registro -con lo que 0xE540 vuelve a cero y se puede armar otro- y le mete 0xE0 a la fila para que el sprite se vaya de la pantalla.
; ----------------------------------------------------------------------
lo_que_se_lanza_se_va:
	ld hl,0e540h		;b2b2
	ld b,010h		;b2b5   ; los dieciseis bytes del registro
	xor a			;b2b7
lo_que_se_lanza_borra_vuelta:
	ld (hl),a			;b2b8
	inc l			;b2b9
	djnz lo_que_se_lanza_borra_vuelta		;b2ba
	ld a,0e0h		;b2bc   ; 0xE0 en la fila: fuera de la pantalla
	ld (0e547h),a		;b2be
	ret			;b2c1

; ----------------------------------------------------------------------
; Y AL SPRITE. Las partes enteras de la fila y de la columna al sprite 29 (0xEEF4), y detras el dibujo y el color que traiga el registro.
; ----------------------------------------------------------------------
lo_que_se_lanza_a_su_sprite:
	ld a,(0e547h)		;b2c2   ; la fila entera
	ld l,a			;b2c5
	ld a,(0e549h)		;b2c6   ; y la columna entera
	ld h,a			;b2c9
	ld (0eef4h),hl		;b2ca   ; al sprite 29
	ld a,(0e54ah)		;b2cd   ; el dibujo...
	ld l,a			;b2d0
	ld a,(0e54bh)		;b2d1   ; ...y el color
	ld h,a			;b2d4
	ld (0eef6h),hl		;b2d5   ; a los otros dos bytes del sprite
	ret			;b2d8

; ----------------------------------------------------------------------
; CHOCAR CON LO QUE HAY EN 0xE0C0. El rectangulo es de 0x20 de ancho por 0x24 de alto, con margen de 0x18 y 0x1C. Y hay TRES pasos de transicion en los que no se choca -el 3, el 8 y el 10-, que son en los que el juego esta cambiando de escena.
; ----------------------------------------------------------------------
choca_con_lo_de_0xE0C0:
	ld a,(0e0c0h)		;b2d9   ; ¿hay algo de eso puesto?
	and a			;b2dc
	ret z			;b2dd   ; si no, no hay con que chocar
	ld a,(0e203h)		;b2de   ; el ESTADO de lo que se maneja
	cp 003h		;b2e1   ; en el 3...
	ret z			;b2e3
	cp 008h		;b2e4   ; ...en el 8...
	ret z			;b2e6
	cp 00ah		;b2e7   ; ...y en el 10 no se choca
	ret z			;b2e9
	ld hl,(0e204h)		;b2ea   ; la Y en la pantalla de lo que se maneja; la posicion de lo que se maneja
	ld de,(0e0c3h)		;b2ed   ; y la del objeto
	ld a,l			;b2f1
	add a,01ch		;b2f2   ; el margen en Y
	sub e			;b2f4   ; menos la del objeto
	cp 024h		;b2f5   ; ¿cabe en los 0x24 de alto?
	ret nc			;b2f7   ; si no, no se han tocado
	ld a,h			;b2f8
	add a,018h		;b2f9   ; y ahora el margen en X
	sub d			;b2fb
	cp 020h		;b2fc   ; ¿cabe en los 0x20 de ancho?
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
; COGER ESTO DA TIEMPO. Le suma 0x50 EN BCD al tiempo que queda (0xE08B), que es el que corre sin parar a uno cada 32 cuadros. Es la unica cosa de todo el cartucho que toca ese contador despues de montada la fase: el tiempo extra solo sale de aqui.
; ----------------------------------------------------------------------
coger_alarga_la_fase:
	ld hl,(0e08bh)		;b31e   ; el TIEMPO que queda
	ld a,050h		;b321   ; 0x50 mas
	add a,l			;b323
	daa			;b324   ; en BCD
	ld l,a			;b325
	jr nc,L_B329		;b326   ; con su acarreo al byte alto
	inc h			;b328
L_B329:
	ld (0e08bh),hl		;b329   ; el TIEMPO que queda; y guardado
	ld a,027h		;b32c   ; el efecto 0x27
	jp 0413ah		;b32e   ; banco 0: pide_sonido_si_esta_activo
coger_arranca_el_movimiento:
	call 058b1h		;b331
	ld a,070h		;b334   ; se coloca en la columna 0x70
	ld (0e204h),a		;b336   ; la Y en la pantalla de lo que se maneja
	ld a,00fh		;b339   ; el ESTADO de lo que se maneja, a 15
	ld (0e203h),a		;b33b   ; el ESTADO de lo que se maneja
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
	ld a,(0e203h)		;b370   ; el ESTADO de lo que se maneja
	cp 003h		;b373   ; el 3...
	ret z			;b375
	cp 008h		;b376   ; ...el 8...
	ret z			;b378
	cp 00ah		;b379   ; ...y el 10 no chocan
	ret z			;b37b
	ld hl,(0e204h)		;b37c   ; la Y en la pantalla de lo que se maneja; la posicion de lo que se maneja
	ld de,(0e0dah)		;b37f   ; y la del objeto
	ld a,l			;b383
	add a,01ch		;b384   ; el margen en Y
	sub e			;b386
	cp 028h		;b387   ; 0x28 de alto
	ret nc			;b389
	ld a,h			;b38a
	add a,018h		;b38b   ; el margen en X
	sub d			;b38d
	cp 020h		;b38e   ; y 0x20 de ancho
	ret nc			;b390
	ld a,(0e0d7h)		;b391   ; lo que era
	ld c,a			;b394
	call L_BA2F		;b395
	ld a,024h		;b398   ; el efecto 0x24
	call 0413ah		;b39a   ; banco 0: pide_sonido_si_esta_activo
	jp L_BFAB		;b39d

; ----------------------------------------------------------------------
; CHOCAR CON EL QUE VUELA. El rectangulo mas grande de los tres -0x20 de ancho por 0x30 de alto- y el unico que acaba mal: pone el modo a 1, que es el de perder, y deja un aviso de 2 para que la maquina de estados se salte dos estados.
; ----------------------------------------------------------------------
choca_con_el_que_vuela:
	ld a,(0e0bdh)		;b3a0   ; ¿esta en pantalla?
	and a			;b3a3
	ret z			;b3a4
	ld a,(0e203h)		;b3a5   ; el ESTADO de lo que se maneja
	cp 003h		;b3a8
	ret z			;b3aa
	cp 008h		;b3ab
	ret z			;b3ad
	cp 00ah		;b3ae
	ret z			;b3b0
	ld hl,(0e204h)		;b3b1   ; la Y en la pantalla de lo que se maneja; la posicion de lo que se maneja
	ld de,(0e0bbh)		;b3b4   ; y la del que vuela
	ld a,l			;b3b8
	add a,020h		;b3b9   ; el margen en Y
	sub e			;b3bb
	cp 030h		;b3bc   ; 0x30 de alto: el mas largo de los tres
	ret nc			;b3be
	ld a,h			;b3bf
	add a,020h		;b3c0   ; el margen en X
	sub d			;b3c2
	cp 020h		;b3c3   ; y 0x20 de ancho
	ret nc			;b3c5
	call el_que_vuela_se_va		;b3c6   ; el que vuela se va
	xor a			;b3c9
	ld (0e1f1h),a		;b3ca
	ld (0e1f2h),a		;b3cd
	inc a			;b3d0
	ld (0e0a2h),a		;b3d1   ; el modo en el que esta el juego; modo 1: se ha perdido
	inc a			;b3d4
	ld (0e096h),a		;b3d5   ; los avisos que deja el cuadro; y un aviso de 2
	ld a,(0e0adh)		;b3d8
	ld (0e0a3h),a		;b3db   ; por que vuelta va
	ld a,010h		;b3de
	ld (0e203h),a		;b3e0   ; el ESTADO de lo que se maneja, a 16
	ret			;b3e3

; ----------------------------------------------------------------------
; RECOGER. Los tres huecos de 0xE3A0, de dieciseis bytes cada uno, y una cuenta distinta de las de arriba: aqui no hay rectangulo fijo, el ancho que se admite DEPENDE de lo lejos que este -0xB41C dobla la diferencia en Y y se la suma al margen-, que es lo que hace que valga tocarlo tanto de cerca como de lejos. Recoger da un punto de los de uno en uno y 0x10 de los de golpe, y suena el efecto 0x0C.
; ----------------------------------------------------------------------
recoger:
	ld a,(0e203h)		;b3e4   ; el ESTADO de lo que se maneja
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
	ld hl,(0e204h)		;b40d   ; la Y en la pantalla de lo que se maneja
	ld a,e			;b410
	sub l			;b411   ; la diferencia en Y
	ld e,a			;b412
	sub 00ah		;b413   ; si esta a mas de diez, no
	jr nc,recoger_hueco_siguiente		;b415
	ld a,013h		;b417   ; y de ahi sale el margen en X...
	add a,e			;b419
	ld l,a			;b41a
	ld a,e			;b41b
	add a,a			;b41c   ; ...doblando la diferencia en Y: cuanto mas lejos, mas se perdona
	add a,017h		;b41d
	ld e,a			;b41f
	ld a,d			;b420
	sub h			;b421   ; la diferencia en X
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
	ld a,(0e203h)		;b444   ; el ESTADO de lo que se maneja
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
	ld a,(0e205h)		;b48d   ; la X en la pantalla de lo que se maneja
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
	call 07c9fh		;b4c8   ; banco 1; y con las cuatro llenas, esto
	ld hl,0ae0ah		;b4cb
	ld (0e53ah),hl		;b4ce
	ld a,002h		;b4d1
	ld (0e530h),a		;b4d3   ; lo que abre queda en marcha
	xor a			;b4d6
	ld (0e531h),a		;b4d7
	ld (0e532h),a		;b4da
	ld (0e533h),a		;b4dd
	call pon_la_pose_en_lo_que_se_maneja		;b4e0
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
	ld de,(0e08dh)		;b4fc   ; lo que queda de fase
	rst 20h			;b500   ; DCOMPR: ¿hemos llegado?
	ret nz			;b501
	ld hl,0ffffh		;b502   ; y una vez que sale, no vuelve a salir
	ld (0e0abh),hl		;b505
	ld a,(0e203h)		;b508   ; el ESTADO de lo que se maneja
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
	ld (0e0bdh),a		;b52a   ; en que tiempo va el bicho que vuela: 0 nada, 1 aparecer, 2 mover
	ret			;b52d

; ----------------------------------------------------------------------
; EL BICHO QUE VUELA, EN TRES TIEMPOS. Se despacha por 0xE0BD con el despachador de la casa: 0 no hace nada, 1 lo coloca y 2 lo mueve.
; ----------------------------------------------------------------------
el_que_vuela:
	ld a,(0e0bdh)		;b52e   ; en que tiempo va
	call 04060h		;b531   ; el despachador, con la tabla pegada detras; banco 0: despacha

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
	ld a,(0e205h)		;b540   ; la X en la pantalla de lo que se maneja
	cp 078h		;b543   ; y segun este en la mitad izquierda o en la derecha...
	ld h,0e8h		;b545   ; ...entra por la derecha del todo (X 0xE8)...
	ld a,000h		;b547
	jr c,L_B54E		;b549
	ld h,008h		;b54b   ; ...o por la izquierda (X 0x08): siempre por el lado contrario
	inc a			;b54d
L_B54E:
	ld (0e0bbh),hl		;b54e   ; su posicion
	ld (0e0bfh),a		;b551   ; y hacia donde va
	xor a			;b554
	ld (0e0beh),a		;b555   ; el paso del vaiven, a cero
el_que_vuela_quieto:
	ret			;b558

; ----------------------------------------------------------------------
; EL VAIVEN. Cruza la pantalla de lado a lado a un pixel por cuadro impar, siempre en la misma direccion; lo que ondula es la FILA, que le suma un valor de una tabla de 32 que se recorre en circulo. Y suena uno de cada ocho cuadros.
; ----------------------------------------------------------------------
el_que_vuela_se_mueve:
	ld a,(0e003h)		;b559   ; el contador de cuadros
	and 007h		;b55c   ; uno de cada ocho
	jr nz,L_B565		;b55e
	ld a,002h		;b560   ; el efecto 2
	call 0413ah		;b562   ; banco 0: pide_sonido_si_esta_activo
L_B565:
	ld a,(0e003h)		;b565   ; el contador otra vez; el contador de cuadros
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
	add a,l			;b57b   ; sumado a la fila: eso es lo que ondula
	ld l,a			;b57c
	ld a,(0e0bfh)		;b57d   ; hacia donde va
	and 00fh		;b580
	ld c,0ffh		;b582   ; a la izquierda...
	jr z,L_B588		;b584
	ld c,001h		;b586   ; ...o a la derecha
L_B588:
	ld a,h			;b588
	add a,c			;b589   ; la columna, un paso
	ld h,a			;b58a
	cp 008h		;b58b   ; por la izquierda se sale
	jr c,el_que_vuela_se_va		;b58d
	cp 0e9h		;b58f   ; y por la derecha tambien
	jr nc,el_que_vuela_se_va		;b591
	ld (0e0bbh),hl		;b593   ; la posicion nueva
	ld hl,(0e0bbh)		;b596   ; la fila del bicho que vuela
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
	ld (0ee98h),a		;b5ae   ; el hueco de sprite 6, el del bicho que vuela
	ld l,a			;b5b1
	xor a			;b5b2
	ld h,a			;b5b3
	ld (0e0bbh),hl		;b5b4   ; y todo lo suyo, a cero
	ld (0e0bdh),a		;b5b7   ; en que tiempo va el bicho que vuela: 0 nada, 1 aparecer, 2 mover
	ld (0e0beh),a		;b5ba   ; el paso del vaiven del que vuela, de 32
	ld (0e0bfh),a		;b5bd   ; hacia que lado cruza el que vuela
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
; MONTAR LA FASE DE BONUS, QUE NO ES UNA FASE. Se reconoce por el decorado que pone: el 8, que es la Tierra vista desde el espacio. Y NO es una de las veinticuatro: recorriendo las veinticuatro entradas de la tabla de 0xACBA -de donde p01:6226 saca el decorado de cada fase- salen los decorados 0 a 7 y ni una sola vez el 8. Lo que lo remata es que aqui se guarda el TIEMPO de verdad en 0xE0CC antes de cambiarlo: es un prestamo, y hay que devolverlo. El decorado 9 esta en el mismo caso, y lo pone 0xB932 en otra escena aparte. Borra 2.335 bytes de variables y los 672 de la zona de juego, se guarda el TIEMPO de verdad en 0xE0CC y lo cambia por uno de los diez de la tabla de 0xB635, que van de 0x85 a 0x40: cuanto mas veces se ha llegado aqui, mas corta es.
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
	ld (0e0a6h),a		;b5fd   ; el arrastre de lado que se lleva solo
	ld a,008h		;b600   ; el decorado 8: la Tierra desde el espacio
	ld (0e0a1h),a		;b602   ; el DECORADO, de 0 a 9
	ld hl,(0e08bh)		;b605   ; el TIEMPO de verdad
	ld (0e0cch),hl		;b608   ; se guarda aparte, que luego hay que devolverlo
	ld a,(0e0a3h)		;b60b   ; cuantas veces se ha llegado al bonus
	ld hl,0b635h		;b60e   ; la tabla de largos
	call 04056h		;b611   ; banco 0: a_mas_hl
	ld e,(hl)			;b614
	inc hl			;b615
	ld d,000h		;b616
	ld (0e08bh),de		;b618   ; el TIEMPO que queda; y ese es el tiempo del bonus
	ld hl,09000h		;b61c   ; 0x9000: una distancia a la que no se llega
	ld (0e08dh),hl		;b61f   ; lo que queda de fase; asi no sale ningun enemigo
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
	call 04060h		;b642   ; banco 0: despacha; el despachador, con la tabla detras

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
	ld (0e203h),a		;b713   ; el ESTADO de lo que se maneja
	inc hl			;b716
	ld a,0f8h		;b717
	ld (0e204h),a		;b719   ; la Y en la pantalla de lo que se maneja
	ld hl,(0e0cch)		;b71c
	ld (0e08bh),hl		;b71f   ; el TIEMPO que queda
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
	ld (0e08dh),de		;b736   ; lo que queda de fase
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
	ld (0e0a6h),a		;b751   ; el arrastre de lado que se lleva solo
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
	ld (0e301h),de		;b767   ; la distancia a la que toca el objeto siguiente
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
; DATOS registros_de_17_por_E0A3: dieciseis registros de 17 bytes que p03:B72F
;   indexa con (0xE0A3) * 17: la distancia (0xE08D), el valor de la fase
;   (0xE093), el decorado (0xE0A1), (0xE0B6), (0xE0A9) y el resto
;   0xb79b..0xb8ab  (272 bytes)
DATA_registros_de_17_por_E0A3:
	defb 070h,002h,001h,003h,002h,000h,000h,0ffh,0ffh,003h,000h,000h,0ffh,0ffh,000h,000h,002h	; b79b  p................
	defb 060h,002h,003h,000h,003h,002h,000h,036h,002h,005h,000h,000h,050h,002h,012h,000h,002h	; b7ac  `......6....P....
	defb 095h,002h,001h,000h,001h,004h,000h,010h,002h,005h,000h,000h,090h,002h,013h,000h,001h	; b7bd  .................
	defb 095h,000h,003h,001h,003h,004h,000h,0ffh,0ffh,006h,000h,000h,090h,000h,01eh,000h,003h	; b7ce  .................
	defb 090h,000h,002h,005h,000h,008h,000h,0ffh,0ffh,006h,000h,000h,0ffh,0ffh,01eh,000h,003h	; b7df  .................
	defb 090h,003h,003h,000h,003h,004h,000h,080h,003h,005h,000h,000h,085h,003h,018h,000h,002h	; b7f0  .................
	defb 070h,004h,002h,006h,000h,000h,000h,064h,004h,001h,000h,000h,060h,004h,009h,000h,000h	; b801  p......d....`....
	defb 080h,007h,001h,006h,000h,000h,000h,028h,007h,003h,000h,000h,030h,007h,016h,000h,001h	; b812  .......(....0....
	defb 050h,003h,002h,005h,000h,004h,000h,036h,003h,003h,000h,000h,040h,003h,00dh,000h,002h	; b823  P......6....@....
	defb 010h,004h,003h,002h,002h,00ah,000h,032h,003h,009h,000h,000h,090h,003h,037h,000h,004h	; b834  .......2......7..
	defb 080h,002h,003h,002h,002h,002h,005h,064h,002h,003h,0c6h,0e0h,070h,002h,012h,000h,002h	; b845  .......d....p....
	defb 060h,005h,003h,001h,000h,000h,003h,032h,005h,001h,0c7h,0e0h,050h,005h,002h,000h,001h	; b856  `......2....P....
	defb 080h,008h,003h,000h,000h,000h,003h,000h,007h,000h,0c8h,0e0h,060h,007h,000h,000h,000h	; b867  ............`....
	defb 025h,005h,003h,002h,000h,002h,002h,028h,003h,002h,0c9h,0e0h,000h,005h,014h,000h,002h	; b878  %......(.........
	defb 005h,008h,003h,003h,001h,002h,003h,048h,007h,002h,0cah,0e0h,095h,007h,00ah,000h,001h	; b889  .......H.........
	defb 049h,010h,003h,002h,000h,004h,003h,042h,008h,003h,0cbh,0e0h,040h,010h,00dh,000h,001h	; b89a  I......B....@....

; ======================================================================
; CODIGO 0xb8ab..0xbaad  (514 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ¿TOCA YA? El aviso de 0xE0AF es una distancia: cuando lo que queda de fase (0xE08D) llega justo a ella, se dispara. Con 0xFFFF puesto no se dispara nunca, que es la forma de la casa de decir "nunca". Al dispararse sube 0xE0B6, copia 0xE0B2 a 0xE0B3 y escoge el efecto: el 0x31 si 0xE166 esta puesto y el valor es 2.
; ----------------------------------------------------------------------
mira_si_toca_ya:
	ld hl,(0e0afh)		;b8ab   ; la distancia apuntada
	ld a,h			;b8ae
	and l			;b8af   ; ¿son las dos 0xFF?
	cp 0ffh		;b8b0
	ret z			;b8b2   ; entonces no toca nunca
	ld de,(0e08dh)		;b8b3   ; lo que queda de fase
	rst 20h			;b8b7   ; DCOMPR: ¿hemos llegado?
	ret nz			;b8b8   ; si no, a esperar
	ld hl,0e0b6h		;b8b9
	inc (hl)			;b8bc   ; un paso mas
	ld a,(0e0b2h)		;b8bd   ; lo que sea que traiga
	ld (0e0b3h),a		;b8c0   ; copiado
	ld c,a			;b8c3
	ld a,(0e166h)		;b8c4   ; y si 0xE166 esta puesto...
	and a			;b8c7
	jr z,L_B8D4		;b8c8
	ld a,c			;b8ca
	cp 002h		;b8cb   ; ...y ademas vale 2...
	jr nz,L_B8D4		;b8cd
	ld a,031h		;b8cf   ; ...el efecto 0x31
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
	ld (0e0bdh),a		;b902   ; en que tiempo va el bicho que vuela: 0 nada, 1 aparecer, 2 mover
	ld (0e0bbh),a		;b905   ; la fila del bicho que vuela
	ld (0e0bch),a		;b908   ; la columna del bicho que vuela
	ld (0e0beh),a		;b90b   ; el paso del vaiven del que vuela, de 32
	ld (0e0bfh),a		;b90e   ; hacia que lado cruza el que vuela
	ld (0e0c0h),a		;b911   ; cual de las cuatro cosas que se cogen esta puesta
	ld (0e0c1h),a		;b914
	ld (0e0c2h),a		;b917
	ld (0e0c3h),a		;b91a   ; la fila de eso que se coge
	ld (0e0c4h),a		;b91d   ; la columna de eso que se coge
	ld (0e0d7h),a		;b920   ; cual es el otro objeto con el que se choca
	ld (0e0d8h),a		;b923
	ld (0e0d9h),a		;b926
	ld (0e0dah),a		;b929   ; la fila de ese otro objeto
	ld (0e0dbh),a		;b92c   ; la columna de ese otro objeto
	ld (0e0a6h),a		;b92f   ; el arrastre de lado que se lleva solo
	ld a,009h		;b932
	ld (0e0a1h),a		;b934   ; el DECORADO, de 0 a 9
	ld hl,070f8h		;b937
	ld (0e204h),hl		;b93a   ; la Y en la pantalla de lo que se maneja
	ld de,00150h		;b93d
	ld (0e08dh),de		;b940   ; lo que queda de fase
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
	ld (0e08dh),de		;b977   ; lo que queda de fase
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
	ld a,(0e092h)		;b99a   ; la FASE, de 1 a 24
	add a,c			;b99d
	ld (0e092h),a		;b99e   ; la FASE, de 1 a 24
	xor a			;b9a1
	ld (0e0a6h),a		;b9a2   ; el arrastre de lado que se lleva solo
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
	ld (0e301h),de		;b9bd   ; la distancia a la que toca el objeto siguiente
	inc hl			;b9c1
	ld a,(hl)			;b9c2
	ld (0e300h),a		;b9c3   ; por que pareja del guion de la fase va
	inc hl			;b9c6
	ld de,(0e08bh)		;b9c7   ; el TIEMPO que queda
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
	ld (0e08bh),de		;b9e0   ; el TIEMPO que queda
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
	call prepara_lo_propio_de_la_fase		;ba29
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

; ----------------------------------------------------------------------
; QUE DIBUJO LE TOCA A LO QUE SE LLEVA. El numero de objeto menos tres, y solo valen los que caen entre 0 y 9; de los del medio, los 4, 5 y 6 se juntan con los de arriba restandoles otros tres. Con el indice que sale se lee una pareja de la tabla de 0xBAAD.
; ----------------------------------------------------------------------
el_dibujo_de_lo_que_se_lleva:
	ld a,c			;ba45   ; el objeto
	sub 003h		;ba46   ; los tres primeros no llevan dibujo
	jr c,repinta_la_fila_del_marcador		;ba48
	cp 00ah		;ba4a   ; ni los que pasan de trece
	jr nc,repinta_la_fila_del_marcador		;ba4c
	cp 004h		;ba4e   ; del 3 al 6 van directos
	jr c,coge_la_pareja_del_dibujo		;ba50
	cp 007h		;ba52   ; el 7, el 8 y el 9 tampoco llevan
	jr c,repinta_la_fila_del_marcador		;ba54
	sub 003h		;ba56   ; y del 10 en adelante comparten los de antes
coge_la_pareja_del_dibujo:
	ld hl,0baadh		;ba58   ; la tabla de parejas
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

; ----------------------------------------------------------------------
; REPINTAR LA FILA DEL MARCADOR, CARACTER A CARACTER. Lee de la VRAM con RDVRM, pasa cada caracter por la traduccion de p01:6FB8 y lo devuelve con WRTVRM. Doce caracteres por vuelta y dos vueltas, que son las dos filas del cartel.
; ----------------------------------------------------------------------
repinta_la_fila_del_marcador:
	ld hl,03830h		;ba78   ; la fila de la pantalla
	push hl			;ba7b
	push bc			;ba7c
	ld c,002h		;ba7d   ; dos vueltas
	ld hl,0383bh		;ba7f   ; de donde se lee...
	ld de,0383dh		;ba82   ; ...y donde se escribe
repinta_doce_caracteres:
	ld b,00ch		;ba85   ; doce caracteres
repinta_un_caracter:
	call 0004ah		;ba87   ; BIOS RDVRM - Reads the content of VRAM | BIOS RDVRM: se lee el que hay
	ex de,hl			;ba8a
	call 06fb8h		;ba8b   ; banco 1: se traduce
	call 0004dh		;ba8e   ; BIOS WRTVRM - Writes data in VRAM | y BIOS WRTVRM: se devuelve
	ex de,hl			;ba91
	dec de			;ba92
	dec hl			;ba93
	djnz repinta_un_caracter		;ba94
	ld hl,0385bh		;ba96
	ld de,0385dh		;ba99
	dec c			;ba9c
	jr nz,repinta_doce_caracteres		;ba9d
	pop bc			;ba9f
	pop hl			;baa0
	jr L_BA67		;baa1
L_BAA3:
	ld a,c			;baa3
	ld de,0e160h		;baa4
	call 0405bh		;baa7   ; banco 0: a_mas_de
	jp el_dibujo_de_lo_que_se_lleva		;baaa

; ----------------------------------------------------------------------
; DATOS siete_direcciones_y_valores: siete direcciones de la tabla de nombres
;   (0x3822, 0x3824...) que p03:BA58 indexa con A - 3, y detras (0xBABB)
;   diecinueve bytes que p03:BA35 lleva a 0xE160
;   0xbaad..0xbace  (33 bytes)
DATA_siete_direcciones_y_valores:
	defb 022h,038h	; baad
	defb 024h,038h	; baaf
	defb 026h,038h	; bab1
	defb 028h,038h	; bab3
	defb 02ah,038h	; bab5
	defb 02ch,038h	; bab7
	defb 02eh,038h	; bab9
	defb 001h,001h	; babb
	defb 001h,003h	; babd
	defb 003h,003h	; babf
	defb 001h,001h	; bac1
	defb 001h,001h	; bac3
	defb 002h,002h	; bac5
	defb 001h,001h	; bac7
	defb 001h,001h	; bac9
	defb 001h,001h	; bacb
	defb 001h	; bacd

; ======================================================================
; CODIGO 0xbace..0xbbd2  (260 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LO QUE SOLO SALE EN EL DECORADO 7. La primera instruccion lo dice todo: si (0xE0A1) no es 7, esta rutina se va sin hacer nada. Se dispara cuando lo que se maneja pasa de la columna 0x48, y a partir de ahi va bajando por su cuenta durante 0x40 cuadros, cambiando de dibujo cada cuatro.
; ----------------------------------------------------------------------
lo_del_decorado_7:
	ld a,(0e0a1h)		;bace   ; el DECORADO, de 0 a 9
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
	ld a,(0e204h)		;baf8   ; la Y en la pantalla de lo que se maneja
	cp 048h		;bafb   ; hasta la columna 0x48 no sale
	ret c			;bafd
	ld hl,0e217h		;bafe   ; cuantas veces ha salido
	inc (hl)			;bb01
	ld c,(hl)			;bb02
	ld a,001h		;bb03
	ld (0e216h),a		;bb05   ; y queda en marcha
	ld hl,(0e204h)		;bb08   ; la Y en la pantalla de lo que se maneja; su posicion sale de la del jugador
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
	ld de,(0e08dh)		;bb33   ; lo que queda de fase
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
	ld a,(0e205h)		;bb51   ; la X en la pantalla de lo que se maneja
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
	ld (0eea0h),a		;bbbf   ; el hueco de sprite 8
	ld l,a			;bbc2
	xor a			;bbc3
	ld h,a			;bbc4
	ld (0e0c3h),hl		;bbc5   ; la fila de eso que se coge
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
	jr z,mira_0xE1F0_y_0xE1F1		;bbeb
cambia_a_uno_normal:
	ld a,c			;bbed
	ld (0e0c0h),a		;bbee   ; el nuevo
	ld a,00dh		;bbf1   ; el efecto 0x0D
	jp 0413ah		;bbf3   ; banco 0: pide_sonido_si_esta_activo
cambia_al_dos:
	ld a,(0e0a1h)		;bbf6   ; el DECORADO, de 0 a 9
	cp 007h		;bbf9   ; en el 7, otra cosa
	jr z,L_BC09		;bbfb
	ld a,(0e1f1h)		;bbfd
mira_solo_0xE1F0:
	and a			;bc00
	jr nz,L_BC09		;bc01
	ld a,(0e1f0h)		;bc03   ; ¿esta puesto 0xE1F0?
	and a			;bc06
	jr z,cambia_a_uno_normal		;bc07   ; si no, uno normal
L_BC09:
	ld a,c			;bc09   ; y si lo esta, el siguiente
	jr cambia_al_siguiente		;bc0a
mira_0xE1F0_y_0xE1F1:
	ld a,(0e1f0h)		;bc0c   ; ¿esta puesto 0xE1F0?
	and a			;bc0f
	jr nz,L_BC18		;bc10
	ld a,(0e1f1h)		;bc12   ; ¿y 0xE1F1?
	and a			;bc15
	jr z,cambia_a_uno_normal		;bc16   ; si no hay ninguno, uno normal
L_BC18:
	ld a,c			;bc18   ; y si hay alguno, el siguiente
	jr cambia_al_siguiente		;bc19

; ----------------------------------------------------------------------
; REPASAR LAS CINCO RANURAS DE LO QUE SE LLEVA. Las de 0xE440, de 16 bytes cada una, y busca las que cumplan las cuatro condiciones: que la ranura este ocupada, que su segundo byte sea menor de 3, que el tercero valga 7 justo y que el cuarto no sea cero. La que las cumple se dispara: se le pone el cuarto byte a cero y sale volando por el aire.
; ----------------------------------------------------------------------
repasa_lo_que_se_lleva:
	ld hl,0e440h		;bc1b   ; las cinco ranuras
	ld b,005h		;bc1e
repasa_una_ranura:
	ld c,010h		;bc20   ; el salto hasta la ranura siguiente, que se va acortando segun se avanza
	ld a,(hl)			;bc22   ; ¿ocupada?
	and a			;bc23
	jr z,L_BC43		;bc24
	dec c			;bc26
	inc l			;bc27
	ld a,(hl)			;bc28
	cp 003h		;bc29   ; menor de 3
	jr nc,L_BC43		;bc2b
	dec c			;bc2d
	inc l			;bc2e
	ld a,(hl)			;bc2f
	cp 007h		;bc30   ; y el tercero, 7 justo
	jr nz,L_BC43		;bc32
	dec c			;bc34
	inc l			;bc35
	ld a,(hl)			;bc36
	and a			;bc37   ; y el cuarto, que no sea cero
	jr z,L_BC43		;bc38
	ld (hl),000h		;bc3a   ; se marca como gastado
	push hl			;bc3c
	push bc			;bc3d
	call suelta_en_un_hueco		;bc3e   ; y a volar
	pop bc			;bc41
	pop hl			;bc42
L_BC43:
	ld a,c			;bc43
	add a,l			;bc44   ; a la ranura siguiente
	ld l,a			;bc45
	djnz repasa_una_ranura		;bc46
	ret			;bc48

; ----------------------------------------------------------------------
; SOLTARLO EN UN HUECO LIBRE. Los tres huecos de 0xE3A0 y el primero que este a cero. Si los tres estan cogidos no pasa nada: no hay mas de tres cosas por el aire a la vez.
; ----------------------------------------------------------------------
suelta_en_un_hueco:
	dec l			;bc49   ; atras, al principio de la ranura
	dec l			;bc4a
	dec l			;bc4b
	push hl			;bc4c
	pop ix		;bc4d
	ld hl,0e3a0h		;bc4f
	ld b,003h		;bc52
busca_hueco_libre:
	ld a,(hl)			;bc54   ; ¿este esta libre?
	and a			;bc55
	jr z,llena_el_hueco		;bc56
	ld a,010h		;bc58   ; y si no, el siguiente, dieciseis mas alla
	add a,l			;bc5a
	ld l,a			;bc5b
	djnz busca_hueco_libre		;bc5c
	ret			;bc5e   ; con los tres cogidos, no sale nada

; ----------------------------------------------------------------------
; LLENAR EL HUECO. De donde sale depende de la variante y de por que lado este el jugador: la columna es 0x66 o 0x8A, y a un lado o al otro se le suma uno. La fila, 0x60, y el dibujo de arranque el 0x88 con el 0x40 debajo. El color es el 6, o el 0x0E a partir del decorado 2.
; ----------------------------------------------------------------------
llena_el_hueco:
	ld (hl),001h		;bc5f   ; ocupado
	inc l			;bc61
	ld a,(ix+001h)		;bc62   ; la variante
	dec a			;bc65
	ld de,06660h		;bc66   ; la fila 0x60 y la columna 0x66
	ld a,(0e205h)		;bc69   ; y donde esta el jugador
	ld c,001h		;bc6c
	jr nz,llena_el_hueco_de_la_otra_variante		;bc6e
	cp 046h		;bc70   ; a la izquierda de la 0x46...
	jr c,llena_el_hueco_escribe		;bc72
	inc c			;bc74   ; ...o a la derecha
	jr llena_el_hueco_escribe		;bc75
llena_el_hueco_de_la_otra_variante:
	cp 0aah		;bc77   ; el corte de la otra variante es la 0xAA
	ld d,08ah		;bc79   ; y sale de la columna 0x8A
	jr c,llena_el_hueco_escribe		;bc7b
	inc c			;bc7d
llena_el_hueco_escribe:
	ld (hl),c			;bc7e   ; a que lado va
	inc l			;bc7f
	ld (hl),000h		;bc80   ; el paso de la curva, a cero
	inc l			;bc82
	ld (hl),e			;bc83   ; la fila...
	inc l			;bc84
	ld (hl),d			;bc85   ; ...y la columna
	inc l			;bc86
	ld (hl),088h		;bc87   ; el dibujo de la pieza de arriba
	inc l			;bc89
	ld a,(0e0a1h)		;bc8a   ; y el color depende del decorado
	cp 002h		;bc8d
	ld (hl),006h		;bc8f   ; el 6 en los dos primeros...
	jr c,llena_el_hueco_la_pieza_de_abajo		;bc91
	ld (hl),00eh		;bc93   ; ...y el 0x0E en el resto
llena_el_hueco_la_pieza_de_abajo:
	ld a,e			;bc95   ; dieciseis filas mas abajo
	add a,010h		;bc96
	inc l			;bc98
	ld (hl),a			;bc99
	inc l			;bc9a
	ld (hl),d			;bc9b   ; la misma columna
	inc l			;bc9c
	ld (hl),040h		;bc9d   ; y su dibujo, el 0x40
	ret			;bc9f

; ----------------------------------------------------------------------
; MOVER LOS TRES POR EL AIRE. Un cuadro de cada dos. La fila la lleva la curva de 48 valores de 0xBD08 -tres arriba y luego cada vez mas abajo: eso es el arco- y la columna va de dos en dos, a la izquierda o a la derecha segun la variante. Se acaba por los tres lados: columna menor de 8, columna 0xE9 o mas, y fila 0xC1 o mas.
; ----------------------------------------------------------------------
mueve_los_del_aire:
	ld a,(0e003h)		;bca0   ; uno de cada dos cuadros
	rra			;bca3
	ret c			;bca4
	ld hl,0e3a0h		;bca5   ; los tres huecos
	ld b,003h		;bca8
mueve_uno_del_aire:
	ld a,(hl)			;bcaa   ; ¿es de los que vuelan?
	dec a			;bcab
	ld a,010h		;bcac   ; y si no, al hueco siguiente
	jr nz,L_BD03		;bcae
	inc l			;bcb0
	ld a,(hl)			;bcb1   ; la variante
	ld c,0feh		;bcb2   ; la de la izquierda va de dos en dos hacia atras...
	dec a			;bcb4
	jr z,mueve_uno_del_aire_sigue		;bcb5
	ld c,002h		;bcb7   ; ...y la otra hacia delante
mueve_uno_del_aire_sigue:
	inc l			;bcb9
	inc (hl)			;bcba   ; un paso mas de la curva
	ld a,(hl)			;bcbb
	ld de,0bd08h		;bcbc   ; la curva de 48
	call 0405bh		;bcbf   ; banco 0: a_mas_de
	ld a,(de)			;bcc2   ; lo que toca sumar a la fila
	ld d,(hl)			;bcc3
	inc l			;bcc4
	add a,(hl)			;bcc5   ; sumado
	ld (hl),a			;bcc6
	ld e,a			;bcc7
	inc l			;bcc8
	ld a,(hl)			;bcc9   ; y la columna, de dos en dos
	add a,c			;bcca
	ld (hl),a			;bccb
	ld c,a			;bccc
	cp 008h		;bccd   ; por la izquierda se sale...
	jr c,$+105		;bccf
	cp 0e9h		;bcd1   ; ...por la derecha tambien...
	jr nc,$+101		;bcd3
	ld a,e			;bcd5
	cp 0c1h		;bcd6   ; ...y por abajo, en la fila 0xC1
	jr nc,$+96		;bcd8
	inc l			;bcda
	ld a,d			;bcdb   ; el paso por el que va
	cp 00ch		;bcdc   ; hasta el 12, los dibujos 0x88 y 0x40...
	ld de,08840h		;bcde
	jr c,pone_los_dos_dibujos		;bce1
	cp 014h		;bce3   ; ...hasta el 20, los 0x8C y 0x44...
	ld de,08c44h		;bce5
	jr c,pone_los_dos_dibujos		;bce8
	cp 01ch		;bcea   ; ...hasta el 28, los 0x90 y 0x48...
	ld de,09048h		;bcec
	jr c,pone_los_dos_dibujos		;bcef
	ld de,09430h		;bcf1   ; ...y de ahi en adelante, los 0x94 y 0x30
pone_los_dos_dibujos:
	ld (hl),d			;bcf4   ; el dibujo de arriba
	inc l			;bcf5
	inc l			;bcf6
	inc (hl)			;bcf7   ; la pieza de abajo baja dos filas mas
	inc (hl)			;bcf8
	inc l			;bcf9
	ld (hl),c			;bcfa   ; su columna
	inc l			;bcfb
	ld (hl),e			;bcfc   ; y su dibujo
	ld a,l			;bcfd
	sub 005h		;bcfe   ; atras, al principio del hueco
	ld l,a			;bd00
al_hueco_siguiente:
	ld a,00ch		;bd01   ; doce mas, que con los cuatro de antes son los dieciseis del hueco
L_BD03:
	add a,l			;bd03
	ld l,a			;bd04
	djnz mueve_uno_del_aire		;bd05
	ret			;bd07

; ----------------------------------------------------------------------
; DATOS curva_de_48: 48 valores de una curva que p03:BCBC indexa y suma a la
;   coordenada
;   0xbd08..0xbd38  (48 bytes)
DATA_curva_de_48:
	defb 0fdh,0fdh,0fdh,0feh,0feh,0feh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd08  ................
	defb 000h,000h,000h,000h,003h,003h,003h,003h,005h,005h,005h,005h,007h,007h,007h,007h	; bd18  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h	; bd28  ................

; ======================================================================
; CODIGO 0xbd38..0xbe4d  (277 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; BORRAR EL HUECO. Los dieciseis bytes a cero y 0xE0 en las dos filas -la de la pieza de arriba y la de la de abajo-, que es como se sacan los dos sprites de la pantalla.
; ----------------------------------------------------------------------
borra_el_hueco_del_aire:
	push hl			;bd38
	ld a,l			;bd39
	sub 004h		;bd3a   ; atras, al principio del hueco
	ld l,a			;bd3c
	ld c,010h		;bd3d   ; los dieciseis bytes
	xor a			;bd3f
	push hl			;bd40
	pop ix		;bd41
borra_el_hueco_vuelta:
	ld (hl),a			;bd43
	inc l			;bd44
	dec c			;bd45
	jr nz,borra_el_hueco_vuelta		;bd46
	ld (ix+003h),0e0h		;bd48   ; 0xE0 en la fila de la pieza de arriba...
	ld (ix+007h),0e0h		;bd4c   ; ...y en la de la de abajo
	pop hl			;bd50
	jr $-80		;bd51

; ----------------------------------------------------------------------
; LOS TRES HUECOS, A SUS SPRITES. Los cuatro bytes del primer sprite de cada hueco van a los sprites 14, 15 y 16, y los tres del segundo a los sprites 20, 21 y 22 -de estos no se copia el color, que se queda con el que tuviera-. En los decorados 8 y 9 no se copia nada: alli esos sprites son de otra cosa.
; ----------------------------------------------------------------------
los_del_aire_a_sus_sprites:
	ld a,(0e0a1h)		;bd53   ; el decorado
	cp 008h		;bd56   ; en el 8...
	ret z			;bd58
	cp 009h		;bd59   ; ...y en el 9, nada de esto
	ret z			;bd5b
	ld de,0eeb8h		;bd5c   ; los sprites 14, 15 y 16
	ld hl,0e3a3h		;bd5f   ; la pieza de arriba del primer hueco
	ld b,003h		;bd62
	ld c,0ffh		;bd64
copia_la_pieza_de_arriba:
	ldi		;bd66   ; fila...
	ldi		;bd68   ; ...columna...
	ldi		;bd6a   ; ...dibujo...
	ldi		;bd6c   ; ...y color
	ld a,00ch		;bd6e   ; y al hueco siguiente
	add a,l			;bd70
	ld l,a			;bd71
	djnz copia_la_pieza_de_arriba		;bd72
	ld de,0eed0h		;bd74
	ld hl,0e3a7h		;bd77
	ld b,003h		;bd7a
copia_la_pieza_de_abajo:
	ldi		;bd7c   ; fila...
	ldi		;bd7e   ; ...columna...
	ldi		;bd80   ; ...y dibujo, sin tocarle el color
	ld a,00dh		;bd82   ; al hueco siguiente
	add a,l			;bd84
	ld l,a			;bd85
	inc e			;bd86   ; y saltandose el color del sprite
	djnz copia_la_pieza_de_abajo		;bd87
	ret			;bd89

; ----------------------------------------------------------------------
; EL SEGUNDO BOTON. El bit 5 de las teclas recien pulsadas -que es el otro disparo del joystick, o su tecla- suelta algo desde la posicion del jugador: diez a la izquierda y ocho mas abajo, con el dibujo 0x34 y el color 8, y suena el efecto 0x0A. Solo uno a la vez: 0xE500 es la marca de que ya hay uno suelto.
; ----------------------------------------------------------------------
el_segundo_boton:
	ld a,(0e162h)		;bd8a   ; ¿esta permitido?
	and a			;bd8d
	ret z			;bd8e
	ld a,(0e203h)		;bd8f   ; el ESTADO de lo que se maneja
	cp 003h		;bd92   ; el 3, el 4, el 8 y el 10 no valen
	ret z			;bd94
	cp 004h		;bd95
	ret z			;bd97
	cp 008h		;bd98
	ret z			;bd9a
	cp 00ah		;bd9b
	ret z			;bd9d
	ld a,(0e006h)		;bd9e   ; las teclas recien pulsadas
	and 020h		;bda1   ; el bit 5: el segundo boton
	ret z			;bda3   ; si no se ha pulsado, nada
	ld hl,0e500h		;bda4   ; la marca de que ya hay uno
	ld a,(hl)			;bda7
	and a			;bda8
	ret nz			;bda9   ; y si lo hay, no sale otro
	ld (hl),001h		;bdaa   ; queda marcado
	inc l			;bdac
	ld (hl),000h		;bdad   ; el contador de vida, a cero
	inc l			;bdaf
	ld de,(0e204h)		;bdb0   ; la Y en la pantalla de lo que se maneja; la posicion del jugador
	ld a,e			;bdb4
	sub 00ah		;bdb5   ; diez a la izquierda
	ld e,a			;bdb7
	ld a,008h		;bdb8   ; y ocho mas abajo
	add a,d			;bdba
	ld d,a			;bdbb
	ld (hl),e			;bdbc
	inc l			;bdbd
	ld (hl),d			;bdbe
	inc l			;bdbf
	ld (hl),034h		;bdc0   ; el dibujo
	inc l			;bdc2
	ld (hl),008h		;bdc3   ; y el color
	ld a,00ah		;bdc5   ; el efecto 0x0A
	jp 04145h		;bdc7   ; banco 0: pide_sonido

; ----------------------------------------------------------------------
; MOVERLO. Va a la izquierda un pixel por cuadro y cambia de dibujo dos veces por el camino -0x34, 0x38 y 0x3C-. A los 0x18 cuadros se acaba y se borra el hueco entero.
; ----------------------------------------------------------------------
mueve_lo_del_segundo_boton:
	ld hl,0e500h		;bdca   ; la marca
	ld a,(hl)			;bdcd
	and a			;bdce
	ret z			;bdcf   ; si no hay ninguno, nada
	inc l			;bdd0
	inc (hl)			;bdd1   ; un cuadro mas de vida
	ld a,(hl)			;bdd2
	ld c,a			;bdd3
	cp 018h		;bdd4   ; a los 0x18 se acaba
	jr z,se_acabo_lo_del_segundo_boton		;bdd6
	ld a,0ffh		;bdd8   ; 0xFF, o sea menos uno...
	inc l			;bdda
	add a,(hl)			;bddb   ; ...a la columna: va a la izquierda
	ld (hl),a			;bddc
	ld a,c			;bddd
	cp 008h		;bdde   ; los ocho primeros cuadros, un dibujo...
	ld c,034h		;bde0
	jr c,guarda_el_dibujo_del_segundo_boton		;bde2
	cp 010h		;bde4   ; ...hasta el dieciseis, otro...
	ld c,038h		;bde6
	jr c,guarda_el_dibujo_del_segundo_boton		;bde8
	ld c,03ch		;bdea   ; ...y el resto, el tercero
guarda_el_dibujo_del_segundo_boton:
	inc l			;bdec
	inc l			;bded
	ld (hl),c			;bdee
	ret			;bdef
se_acabo_lo_del_segundo_boton:
	dec l			;bdf0
	ld b,010h		;bdf1   ; los dieciseis bytes del hueco
	xor a			;bdf3
	push hl			;bdf4
	pop ix		;bdf5
borra_el_hueco_del_segundo_boton:
	ld (hl),a			;bdf7
	inc l			;bdf8
	djnz borra_el_hueco_del_segundo_boton		;bdf9
	ld (ix+002h),0e0h		;bdfb   ; y la Y a 0xE0: fuera de la pantalla
	ret			;bdff

; ----------------------------------------------------------------------
; LAS TRES FASES CON ALGO PROPIO. Borra los seis bytes de 0xE110 y, solo si la fase es la 3, la 6 o la 13, les pone un valor distinto a cada una. Las otras veintiuna se quedan a cero, o sea sin esa cosa.
; ----------------------------------------------------------------------
prepara_lo_propio_de_la_fase:
	xor a			;be00
	ld hl,0e110h		;be01   ; los seis bytes de 0xE110
	ld de,0e111h		;be04
	ld bc,00005h		;be07   ; cinco mas el primero
	ld (hl),a			;be0a
	ldir		;be0b
	ld (0e0c5h),a		;be0d
	ld (0e221h),a		;be10
	ld a,(0e092h)		;be13   ; la FASE, de 1 a 24
	ld hl,0e112h		;be16
	ld bc,00708h		;be19   ; los valores de la 3
	cp 003h		;be1c   ; la fase 3...
	jr z,guarda_lo_propio_de_la_fase		;be1e
	ld hl,0e111h		;be20   ; ...los de la 6...
	ld bc,00005h		;be23
	cp 006h		;be26   ; ...la fase 6...
	jr z,guarda_lo_propio_de_la_fase		;be28
	ld hl,0e112h		;be2a   ; ...y los de la 13
	ld c,0b4h		;be2d
	cp 00dh		;be2f   ; si no es ninguna de las tres, nada
	ret nz			;be31
guarda_lo_propio_de_la_fase:
	ld (hl),c			;be32
	inc hl			;be33
	ld (hl),b			;be34
	ld (0e116h),bc		;be35   ; y una copia aparte
	ret			;be39
L_BE3A:
	ld hl,(0e116h)		;be3a
	ld (0e112h),hl		;be3d
	ret			;be40

; ----------------------------------------------------------------------
; EL PORTERO DE LOS SECRETOS. Se despacha por la fase, y diecinueve de las veinticuatro entradas van a un `ret`. Ademas, si 0xE115 ya esta encendido -o sea, si el premio de esta fase ya se ha conseguido- no se vuelve a mirar.
; ----------------------------------------------------------------------
mira_el_secreto_de_la_fase:
	ld a,(0e115h)		;be41   ; ¿ya se ha conseguido el premio?
	or a			;be44
	ret nz			;be45   ; entonces no hay nada que mirar
	ld a,(0e092h)		;be46   ; la FASE, de 1 a 24
	dec a			;be49   ; la tabla va desde 1
	call 04060h		;be4a   ; banco 0: despacha; el despachador, con la tabla pegada detras

; ----------------------------------------------------------------------
; DATOS secretos_por_fase: Una entrada por cada una de las veinticuatro fases.
;   Diecinueve apuntan a 0xBF2B, que es un `ret`: en esas fases no hay
;   secreto. Las cinco que si lo tienen son la 6 (0xBE7D), la 9 (0xBEA6), la
;   13 (0xBEC0), la 14 (0xBEEC) y la 16 (0xBF18).
;   0xbe4d..0xbe7d  (48 bytes)
DATA_secretos_por_fase:
	defw 0bf2bh	; be4d  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be4f  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be51  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be53  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be55  -> no_hay_secreto_en_esta_fase
	defw 0be7dh	; be57  -> secreto_de_la_fase_6
	defw 0bf2bh	; be59  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be5b  -> no_hay_secreto_en_esta_fase
	defw 0bea6h	; be5d  -> secreto_de_la_fase_9
	defw 0bf2bh	; be5f  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be61  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be63  -> no_hay_secreto_en_esta_fase
	defw 0bec0h	; be65  -> secreto_de_la_fase_13
	defw 0beech	; be67  -> secreto_de_la_fase_14
	defw 0bf2bh	; be69  -> no_hay_secreto_en_esta_fase
	defw 0bf18h	; be6b  -> secreto_de_la_fase_16
	defw 0bf2bh	; be6d  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be6f  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be71  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be73  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be75  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be77  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be79  -> no_hay_secreto_en_esta_fase
	defw 0bf2bh	; be7b  -> no_hay_secreto_en_esta_fase

; ======================================================================
; CODIGO 0xbe7d..0xbf2c  (175 bytes)
; ======================================================================


secreto_de_la_fase_6:
	ld a,(0e167h)		;be7d   ; una bandera
	and a			;be80
	jr nz,secreto_de_la_fase_6_activo		;be81
	ld hl,(0e116h)		;be83   ; y si no esta, se devuelve el valor guardado
	ld (0e111h),hl		;be86
	ret			;be89
secreto_de_la_fase_6_activo:
	ld de,0e111h		;be8a
	ld c,00dh		;be8d   ; el premio 0x0D
	ld a,(de)			;be8f   ; y hasta que 0xE111 no llegue a cero, nada
	or a			;be90
	ret nz			;be91
consigue_el_premio:
	ld hl,0e160h		;be92   ; la lista de premios ya conseguidos
	ld a,c			;be95
	call 04056h		;be96   ; banco 0: a_mas_hl; el que toca
	ld a,(hl)			;be99
	and a			;be9a   ; si ya lo tiene, no se repite
	ret nz			;be9b
	ld hl,0e110h		;be9c
	ld (hl),c			;be9f   ; apuntado
	ld hl,0e115h		;bea0
	ld (hl),001h		;bea3   ; y encendido el aviso
	ret			;bea5
secreto_de_la_fase_9:
	ld c,011h		;bea6   ; el premio 0x11
	ld a,(0e203h)		;bea8   ; el ESTADO de lo que se maneja
	cp 010h		;beab   ; solo en el 0x10
	jp nz,falla_la_secuencia		;bead
	ld a,(0e114h)		;beb0   ; un contador
	cp 00ah		;beb3   ; a los diez, premio
	jp z,consigue_el_premio		;beb5
	ld a,(0e006h)		;beb8   ; las teclas recien pulsadas
	and 010h		;bebb   ; el bit 4: la barra o el disparo
	ret z			;bebd   ; si no, a esperar
	jr avanza_la_secuencia		;bebe
secreto_de_la_fase_13:
	ld a,(0e167h)		;bec0   ; una bandera
	and a			;bec3
	ret z			;bec4
	ld hl,0e112h		;bec5   ; el contador de este
	ld c,00eh		;bec8   ; el premio 0x0E
	ld a,(0e0a6h)		;beca   ; en que va
	cp 001h		;becd
	ld d,01ch		;becf   ; con un 1, el tope es 0x1C...
	jr z,secreto_de_la_fase_13_por_arriba		;bed1
	cp 002h		;bed3
	jp nz,L_BE3A		;bed5
	ld d,0c4h		;bed8   ; ...y con un 2, 0xC4
	ld a,(0e205h)		;beda   ; la X en la pantalla de lo que se maneja
	cp d			;bedd   ; contra el tope
	ret c			;bede
	jp secreto_de_la_fase_13_cuenta		;bedf
secreto_de_la_fase_13_por_arriba:
	ld a,(0e205h)		;bee2   ; la X en la pantalla de lo que se maneja
	cp d			;bee5
	ret nc			;bee6
secreto_de_la_fase_13_cuenta:
	dec (hl)			;bee7   ; un paso menos
	jp z,consigue_el_premio		;bee8   ; y a cero, premio
	ret			;beeb

; ----------------------------------------------------------------------
; SECRETO DE LA FASE 14: DOS DIRECCIONES SEGUIDAS. Izquierda y derecha, en ese orden y sin equivocarse, mientras el paso de la transicion sea 4.
; ----------------------------------------------------------------------
secreto_de_la_fase_14:
	ld a,(0e167h)		;beec   ; una bandera
	and a			;beef
	ret z			;bef0
	ld a,(0e203h)		;bef1   ; el ESTADO de lo que se maneja
	cp 004h		;bef4   ; solo en el 4
	jp nz,falla_la_secuencia		;bef6
	ld hl,0bf2ch		;bef9   ; la secuencia: dos pasos
	ld b,002h		;befc   ; dos
	ld c,010h		;befe   ; y el premio 0x10
comprueba_la_secuencia:
	ld a,(0e114h)		;bf00   ; por que paso va
	cp b			;bf03   ; si ya estan todos, premio
	jp z,consigue_el_premio		;bf04
	call 04056h		;bf07   ; banco 0: a_mas_hl; el paso que toca
	ld d,(hl)			;bf0a   ; la direccion que hay que pulsar
	ld a,(0e006h)		;bf0b   ; las teclas recien pulsadas; lo recien pulsado
	and a			;bf0e
	ret z			;bf0f   ; si no se ha pulsado nada, se espera
	and d			;bf10   ; y si no es la que toca...
	jr z,falla_la_secuencia		;bf11   ; ...vuelta a empezar
avanza_la_secuencia:
	ld hl,0e114h		;bf13   ; el paso
	inc (hl)			;bf16   ; uno mas
	ret			;bf17

; ----------------------------------------------------------------------
; SECRETO DE LA FASE 16: CUATRO DIRECCIONES, Y EN PAUSA. La condicion de la primera instruccion es lo que lo esconde: (0xE0A0) es la bandera de PAUSA, y si esta a cero la rutina se va sin mirar nada. O sea que la secuencia -arriba, derecha, abajo, izquierda- solo cuenta con el juego PARADO.
; ----------------------------------------------------------------------
secreto_de_la_fase_16:
	ld a,(0e0a0h)		;bf18   ; la bandera de PAUSA
	and a			;bf1b
	jr z,falla_la_secuencia		;bf1c   ; sin pausa, ni se mira
	ld hl,0bf2eh		;bf1e   ; la secuencia: cuatro pasos
	ld b,004h		;bf21   ; cuatro
	ld c,012h		;bf23   ; y el premio 0x12
	jr comprueba_la_secuencia		;bf25
falla_la_secuencia:
	xor a			;bf27
	ld (0e114h),a		;bf28   ; el paso, a cero: hay que empezar de nuevo
no_hay_secreto_en_esta_fase:
	ret			;bf2b

; ----------------------------------------------------------------------
; DATOS secuencias_de_los_secretos: Las dos secuencias, en mascaras de los
;   mandos tal como los deja p00:44C8 (bit 0 arriba, bit 1 abajo, bit 2
;   izquierda, bit 3 derecha). La de la fase 14 son dos pasos desde 0xBF2C
;   -0x04 y 0x08, o sea izquierda y derecha- y la de la fase 16 cuatro desde
;   0xBF2E -0x01, 0x08, 0x02 y 0x04: arriba, derecha, abajo e izquierda-. Se
;   solapan a proposito: la de dos empieza dos bytes antes que la de cuatro.
;   0xbf2c..0xbf32  (6 bytes)
DATA_secuencias_de_los_secretos:
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
	ld a,(0e0c0h)		;bf42   ; cual de las cuatro cosas que se cogen esta puesta
	ld hl,0e0bdh		;bf45
	or (hl)			;bf48
	ret nz			;bf49
	ld l,06ch		;bf4a
	ld a,(0e205h)		;bf4c   ; la X en la pantalla de lo que se maneja
	cp 070h		;bf4f
	ld h,0e8h		;bf51
	ld a,000h		;bf53
	jr c,L_BF5A		;bf55
	ld h,008h		;bf57
	inc a			;bf59
L_BF5A:
	ld (0e0dah),hl		;bf5a   ; la fila de ese otro objeto
	ld (0e0d9h),a		;bf5d
	ld a,(0e110h)		;bf60
	ld (0e0d7h),a		;bf63   ; cual es el otro objeto con el que se choca
	xor a			;bf66
	ld (0e0d8h),a		;bf67
	ld (0e110h),a		;bf6a
	ld a,022h		;bf6d
	jp 0413ah		;bf6f   ; banco 0: pide_sonido_si_esta_activo
L_BF72:
	ld a,(0e0d7h)		;bf72   ; cual es el otro objeto con el que se choca
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
	ld hl,(0e0dah)		;bf8a   ; la fila de ese otro objeto
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
	ld (0e0dah),hl		;bfa4   ; la fila de ese otro objeto
	ld (0eea4h),hl		;bfa7
	ret			;bfaa
L_BFAB:
	ld a,0e0h		;bfab
	ld (0eea4h),a		;bfad
	ld l,a			;bfb0
	xor a			;bfb1
	ld h,a			;bfb2
	ld (0e0dah),hl		;bfb3   ; la fila de ese otro objeto
	ld (0e0d7h),a		;bfb6   ; cual es el otro objeto con el que se choca
	ld (0e0d8h),a		;bfb9
	ld (0e0d9h),a		;bfbc
	ret			;bfbf

; ----------------------------------------------------------------------
; DATOS relleno_del_banco_3: 64 bytes a 0xFF hasta el final del banco: espacio
;   libre
;   0xbfc0..0xc000  (64 bytes)
DATA_relleno_del_banco_3:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bah,0b1h,090h	; bfe0  ................
	defb 0ach,0b7h,09ch,0b7h,093h,080h,000h,087h,0a7h,081h,08fh,0a1h,0a4h,010h,043h,0aah	; bff0  ..............C.
