; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x8017  (23 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LA MAQUINA DE ESTADOS. Dieciseis estados y, dentro de cada uno, tantos SUBESTADOS como haga falta. El truco esta en el `ld bc,(0xE000)` de 0x800F: con una sola instruccion se cargan los dos, el estado en C y el subestado en B, y luego el despachador de la casa salta por C mientras cada estado va bajando B con `djnz` hasta dar con el subestado que toca. Salir de un subestado es tan corto como `inc (hl)` sobre 0xE001, que es lo que hace 0x8094.
; Y el detalle de 0x800B: en los estados 0, 1 y 2 se mete 0x8A55 en la PILA antes de despachar, de modo que cuando el estado haga `ret` no vuelva a quien le llamo sino ahi. Es una forma de encadenar sin gastar una llamada.
; ----------------------------------------------------------------------
maquina_de_estados:
	ld hl,0e003h		;8000   ; el contador de cuadros
	inc (hl)			;8003   ; uno mas, y es el reloj de todo el juego
	ld a,(0e000h)		;8004   ; la variable de fase
	cp 003h		;8007   ; los estados 0, 1 y 2 son los de la presentacion
	jr nc,L_800F		;8009
	ld hl,08a55h		;800b   ; y en ellos se cuela un destino en la pila
	push hl			;800e
L_800F:
	ld bc,(0e000h)		;800f   ; la variable de fase
	ld a,c			;8013   ; se despacha por el estado
	call 04060h		;8014   ; el despachador de la casa: la tabla va pegada detras

; ----------------------------------------------------------------------
; DATOS estados_del_juego: Los dieciseis estados, y la tabla acaba justo donde
;   empieza el primero de ellos: 0x8037, 0x8060, 0x8073, 0x8099, 0x814B,
;   0x81C5, 0x8278, 0x83A9, 0x84E1, 0x8538, 0x85D2, 0x8648, 0x86C6, 0x8800,
;   0x8806 y 0x8933.
;   0x8017..0x8037  (32 bytes)
DATA_estados_del_juego:
	defw 08037h	; 8017  -> estado_0
	defw 08060h	; 8019  -> estado_1
	defw 08073h	; 801b  -> L_8073
	defw 08099h	; 801d  -> estado_3
	defw 0814bh	; 801f  -> estado_4
	defw 081c5h	; 8021  -> estado_5_jugar
	defw 08278h	; 8023  -> estado_6
	defw 083a9h	; 8025  -> L_83A9
	defw 084e1h	; 8027  -> L_84E1
	defw 08538h	; 8029  -> L_8538
	defw 085d2h	; 802b  -> L_85D2
	defw 08648h	; 802d  -> L_8648
	defw 086c6h	; 802f  -> L_86C6
	defw 08800h	; 8031  -> L_8800
	defw 08806h	; 8033  -> L_8806
	defw 08933h	; 8035  -> L_8933

; ======================================================================
; CODIGO 0x8037..0x86c2  (1675 bytes)
; ======================================================================


estado_0:
	djnz estado_0_subestado_1		;8037   ; el subestado
	ld a,(0e003h)		;8039   ; el contador de cuadros
	rra			;803c   ; uno de cada dos
	ret nc			;803d
	call L_8AB8		;803e
	ret nz			;8041
	xor a			;8042   ; a cero
	jr pon_la_espera_y_avanza		;8043
estado_0_subestado_1:
	djnz estado_0_subestado_2		;8045
	ld hl,0e004h		;8047   ; el contador de espera
	dec (hl)			;804a
	ret nz			;804b   ; mientras no llegue a cero, nada
	call 05c95h		;804c   ; montar la presentacion
	jp pasa_al_estado_siguiente		;804f
estado_0_subestado_2:
	call 0449eh		;8052   ; los ocho registros del VDP
	call 04224h		;8055   ; borrar la pantalla
	call 05b91h		;8058
	call L_8A8D		;805b
	jr avanza_el_subestado		;805e
estado_1:
	call 042fbh		;8060   ; subir los sprites
	call 05cd6h		;8063   ; el cuadro de la presentacion
	ld a,(0e00fh)		;8066   ; una bandera de la presentacion
	and a			;8069
	ret nz			;806a
	ld a,0cbh		;806b   ; el efecto 0xCB
	call 04145h		;806d   ; banco 0: pide_sonido
	jp pasa_al_estado_siguiente		;8070
L_8073:
	djnz estado_2		;8073
	call 07f11h		;8075
	call 07f0eh		;8078
	ld a,(0e097h)		;807b   ; la bandera de que la fase se ha acabado
	or a			;807e
	ret nz			;807f
estado_a_0xFF:
	ld a,0ffh		;8080   ; 0xFF: el estado se dara la vuelta a 0 al sumarle uno
pon_el_estado:
	ld (0e000h),a		;8082   ; la variable de fase
	jp pasa_al_estado_siguiente		;8085
estado_2:
	call 04224h		;8088   ; borrar la pantalla
	call 05bb6h		;808b
	call 07e7fh		;808e
pon_la_espera_y_avanza:
	ld (0e004h),a		;8091   ; lo que haya en A pasa a ser la espera
avanza_el_subestado:
	ld hl,0e001h		;8094   ; el subestado
	inc (hl)			;8097   ; uno mas
	ret			;8098

; ----------------------------------------------------------------------
; ESTADO 3: EL MENU. El que espera a que se pulse algo, hace parpadear el rotulo y deja elegir entre uno y dos jugadores. La eleccion vive en 0xE082 y los dos rotulos que se intercambian son los guiones 0x8E0A y 0x8E14.
; ----------------------------------------------------------------------
estado_3:
	djnz estado_3_subestado_2		;8099   ; el subestado
	ld hl,0e004h		;809b   ; el contador
	dec (hl)			;809e
	jr z,estado_3_suena		;809f   ; cuando llega a cero, otra cosa
	bit 2,(hl)		;80a1   ; el bit 2 del contador es lo que hace el parpadeo
	ld de,08de7h		;80a3   ; el rotulo
	jp z,042bch		;80a6   ; pintado
	ld c,000h		;80a9   ; o borrado, con la mascara a cero
	jp 042beh		;80ab   ; banco 0: pinta_guion_lee_destino
estado_3_suena:
	ld a,0cbh		;80ae   ; el efecto 0xCB
	call 04145h		;80b0   ; banco 0: pide_sonido
	jr avanza_el_subestado		;80b3
estado_3_subestado_2:
	djnz estado_3_espera_a_que_pulsen		;80b5
	call 04224h		;80b7   ; borrar la pantalla
	call 05bb6h		;80ba
	ld de,08df8h		;80bd   ; tres rotulos, uno detras de otro
	call 042bch		;80c0   ; banco 0: pinta_guion_con_mascara
	ld de,08e0ah		;80c3
	call 042bch		;80c6   ; banco 0: pinta_guion_con_mascara
	ld de,08e14h		;80c9
	call 042bch		;80cc   ; banco 0: pinta_guion_con_mascara
	ld c,0ffh		;80cf   ; con la mascara abierta
	call L_9201		;80d1
	jr avanza_el_subestado		;80d4
estado_3_espera_a_que_pulsen:
	djnz estado_3_parpadeo_final		;80d6
	ld hl,0e004h		;80d8   ; el contador
	dec (hl)			;80db
	call L_9505		;80dc
	call L_91F7		;80df
	ld a,(0e006h)		;80e2   ; las teclas recien pulsadas
	and 010h		;80e5   ; el bit 4: la barra o el disparo
	ret z			;80e7   ; si no se ha pulsado, a esperar
	ld a,0aah		;80e8   ; el efecto 0xAA
	call 0413ah		;80ea   ; banco 0: pide_sonido_si_esta_activo
	ld c,000h		;80ed
	call L_9201		;80ef
	call L_9634		;80f2
	ld a,(0e082h)		;80f5   ; uno o dos jugadores
	and a			;80f8
	ld de,08e14h		;80f9   ; el rotulo de uno...
	jr z,L_8101		;80fc
	ld de,08e0ah		;80fe   ; ...o el de dos
L_8101:
	ld c,000h		;8101
	call 042beh		;8103   ; banco 0: pinta_guion_lee_destino
	ld a,050h		;8106   ; y 0x50 cuadros de espera
	jr pon_la_espera_y_avanza		;8108
estado_3_parpadeo_final:
	djnz estado_3_arranca_la_partida		;810a
	ld hl,0e004h		;810c   ; el contador
	dec (hl)			;810f
	jr z,avanza_el_subestado		;8110
	ld a,(0e004h)		;8112   ; el bit 3: el parpadeo, mas rapido que el de antes
	bit 3,a		;8115
	ld c,0ffh		;8117
	jr z,L_811C		;8119
	inc c			;811b
L_811C:
	ld de,08e0ah		;811c
	ld hl,08e14h		;811f
	ld a,(0e082h)		;8122   ; el que este elegido va en un color y el otro en el otro
	and a			;8125
	jr z,L_8129		;8126
	ex de,hl			;8128   ; y se intercambian
L_8129:
	push hl			;8129
	call 042beh		;812a   ; banco 0: pinta_guion_lee_destino
	pop de			;812d
	ld c,000h		;812e
	jp 042beh		;8130   ; banco 0: pinta_guion_lee_destino
estado_3_arranca_la_partida:
	djnz estado_3_ultimo		;8133
	call 04224h		;8135   ; borrar la pantalla
	call L_9346		;8138
	ld a,(0e082h)		;813b   ; uno o dos jugadores
	ld (0e08fh),a		;813e   ; queda apuntado para la partida
	call 046e3h		;8141   ; y a montar la fase
	jr pasa_al_estado_siguiente		;8144
estado_3_ultimo:
	ld a,050h		;8146   ; 0x50 cuadros
	jp pon_la_espera_y_avanza		;8148

; ----------------------------------------------------------------------
; ESTADO 4: MONTAR LA FASE. La tanda mas larga de llamadas del cartucho, y se lee de un vistazo lo que hace falta para empezar: esconder los tres sprites de arriba, borrar la pantalla, cargar los caracteres del decorado con las tres rutinas de los tres tercios, montar el mapa y subirlo, y poner el contador de cuadros a cero.
; ----------------------------------------------------------------------
estado_4:
	djnz estado_4_ya_montada		;814b   ; el subestado
	call L_8AEC		;814d
	ld a,(0e012h)		;8150   ; una espera
	and a			;8153
	ret nz			;8154
	ld hl,03b00h		;8155   ; la Y del sprite 0
	ld a,0e0h		;8158   ; 0xE0: fuera de la pantalla
	call 0004dh		;815a   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b04h		;815d   ; la del 1
	ld a,0e0h		;8160
	call 0004dh		;8162   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b08h		;8165   ; y la del 2
	ld a,0e0h		;8168
	call 0004dh		;816a   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;816d   ; borrar la zona de juego
	call 051cdh		;8170   ; el marcador
	call 04995h		;8173   ; los caracteres del tercio de arriba
	call 049fch		;8176   ; los del de en medio
	call 049d2h		;8179   ; y los del de abajo
	call L_966B		;817c
	call 057fbh		;817f
	call L_9689		;8182
	call 06000h		;8185   ; el mapa del decorado
	call 06539h		;8188
	call 04265h		;818b   ; subir la zona de juego
	call L_9493		;818e
	xor a			;8191
	ld (0e003h),a		;8192   ; el contador de cuadros, a cero
	ld (0e004h),a		;8195   ; el contador de espera del estado
pasa_al_estado_siguiente:
	ld hl,0e000h		;8198   ; el estado
	inc (hl)			;819b   ; uno mas
	inc l			;819c   ; y el subestado, a cero
	ld (hl),000h		;819d
	ret			;819f
estado_4_ya_montada:
	call 0481bh		;81a0
	call 0463fh		;81a3   ; empezar una vida
	call L_9431		;81a6
	call L_9409		;81a9
	call L_93FB		;81ac
	call 0424bh		;81af   ; banco 0: sube_el_marcador
	xor a			;81b2
	ld (0e0b5h),a		;81b3
	ld (0e126h),a		;81b6
	call L_8AEC		;81b9
	ld a,0adh		;81bc   ; el efecto 0xAD
	call 0413ah		;81be   ; banco 0: pide_sonido_si_esta_activo
	xor a			;81c1
	jp pon_la_espera_y_avanza		;81c2

; ----------------------------------------------------------------------
; ESTADO 5: JUGAR. Y aqui esta LA PAUSA. El bit 7 de las teclas recien pulsadas es la tecla de parar, y lo que hace es dar la vuelta a 0xE0A0: con esa bandera puesta el juego se va al estado 13 y se queda ahi hasta que se vuelva a pulsar. De paso calla el sonido -0xE07A- y esconde dos de los tres sprites de arriba, dejando solo el primero con la Y a 0xD0.
; ----------------------------------------------------------------------
estado_5_jugar:
	ld a,(0e0a5h)		;81c5   ; el modo del juego
	cp 002h		;81c8   ; con 2 o mas no se admite pausa
	jr nc,estado_5_mira_la_pausa		;81ca
	ld a,(0e0a2h)		;81cc   ; y con el modo distinto de cero, tampoco
	and a			;81cf
	jr nz,estado_5_mira_la_pausa		;81d0
	ld a,(0e006h)		;81d2   ; las teclas recien pulsadas
	and 080h		;81d5   ; el bit 7: la tecla de parar
	jr z,estado_5_mira_la_pausa		;81d7   ; si no esta, a jugar
	rlca			;81d9   ; el bit sube al acarreo y baja al 0
	ld (0e07ah),a		;81da   ; y con el se calla o se descalla el sonido
	ld a,(0e0a0h)		;81dd   ; la bandera de pausa
	cpl			;81e0   ; se le da la vuelta
	ld (0e0a0h),a		;81e1   ; la bandera de PAUSA
	and a			;81e4   ; ¿ha quedado en pausa o ha salido de ella?
	jr z,estado_5_sale_de_la_pausa		;81e5
	xor a			;81e7
	ld (0e0b5h),a		;81e8
	ld (0e126h),a		;81eb
	ld hl,0e0deh		;81ee   ; la cuenta de veces que se ha parado
	inc (hl)			;81f1
	ld a,03ah		;81f2   ; el efecto 0x3A, que reinicia las voces
	call 0413ah		;81f4   ; banco 0: pide_sonido_si_esta_activo
	ld hl,03b00h		;81f7   ; el sprite 0
	ld a,0d0h		;81fa   ; 0xD0, que lo deja visible pero abajo del todo
	call 0004dh		;81fc   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;81ff   ; borrar la zona de juego
	call 05b91h		;8202
	call 0481bh		;8205
	call L_93C5		;8208
estado_5_mira_la_pausa:
	ld a,(0e0a0h)		;820b   ; la bandera de pausa
	and a			;820e
	jr z,estado_5_el_cuadro		;820f   ; sin pausa, se juega
	jp L_8800		;8211   ; y con pausa, al estado de parado
estado_5_sale_de_la_pausa:
	ld hl,03b00h		;8214   ; el sprite 0, abajo
	ld a,0d0h		;8217
	call 0004dh		;8219   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b04h		;821c   ; y los otros dos, fuera
	ld a,0e0h		;821f
	call 0004dh		;8221   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b08h		;8224
	ld a,0e0h		;8227
	call 0004dh		;8229   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;822c   ; banco 0: borra_el_area_de_juego
	call 04995h		;822f   ; otra vez los caracteres de los tres tercios
	call 049fch		;8232
	call 049d2h		;8235
	call L_966B		;8238
	call 05974h		;823b
	call L_9689		;823e
	call 04265h		;8241   ; subir la zona de juego
	call 042fbh		;8244   ; y los sprites
estado_5_el_cuadro:
	call 0451ch		;8247   ; EL CUADRO: todo el juego pasa por esa llamada
	ld hl,0e000h		;824a   ; el estado
	ld a,(0e097h)		;824d   ; la bandera de que la fase se ha acabado
	and a			;8250
	jr nz,estado_5_por_que_se_sale		;8251   ; si no se ha acabado, se mira por que otra razon se sale
	ld (hl),00dh		;8253   ; y si se ha acabado, al estado 13
	jr estado_5_sale		;8255
estado_5_por_que_se_sale:
	ld a,(0e096h)		;8257   ; los avisos que ha dejado el cuadro
	and a			;825a
	ret z			;825b   ; sin ninguno, se sigue jugando
	rra			;825c   ; y con el bit que sea puesto se salta tantos estados como haga falta
	jr c,estado_5_sale		;825d
	rra			;825f
	jr c,avanza_dos		;8260
	rra			;8262
	jr c,avanza_tres		;8263
	rra			;8265
	jr c,avanza_cuatro		;8266
	rra			;8268
	jr c,avanza_cinco		;8269
	inc (hl)			;826b   ; cada `inc (hl)` es un estado mas
avanza_cinco:
	inc (hl)			;826c
avanza_cuatro:
	inc (hl)			;826d
avanza_tres:
	inc (hl)			;826e
avanza_dos:
	inc (hl)			;826f
	inc (hl)			;8270
estado_5_sale:
	xor a			;8271   ; los avisos, a cero
	ld (0e096h),a		;8272   ; los avisos que deja el cuadro
	jp pasa_al_estado_siguiente		;8275
estado_6:
	djnz L_8293		;8278
	call 04265h		;827a   ; subir la zona de juego
	call 042fbh		;827d   ; y los sprites
	call L_96F9		;8280
	call 0a985h		;8283
	ld a,(0e096h)		;8286   ; los avisos que deja el cuadro
	and a			;8289
	ret nz			;828a
	ld a,040h		;828b
	ld (0e004h),a		;828d   ; el contador de espera del estado
	jp avanza_el_subestado		;8290
L_8293:
	djnz L_82A5		;8293
	ld hl,0e004h		;8295
	dec (hl)			;8298
	ret nz			;8299
	ld a,001h		;829a
	ld (0e0e1h),a		;829c
	ld (0e096h),a		;829f   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;82a2
L_82A5:
	djnz L_82B7		;82a5
	call L_94AA		;82a7
	ld a,(0e096h)		;82aa   ; los avisos que deja el cuadro
	and a			;82ad
	ret nz			;82ae
	ld a,040h		;82af
	ld (0e004h),a		;82b1   ; el contador de espera del estado
	jp avanza_el_subestado		;82b4
L_82B7:
	djnz L_82C1		;82b7
	ld hl,0e004h		;82b9
	dec (hl)			;82bc
	ret nz			;82bd
	jp avanza_el_subestado		;82be
L_82C1:
	djnz L_82F8		;82c1
	ld a,(0e093h)		;82c3   ; el valor 1-2-3 de la fase
	cp 003h		;82c6
	jr nz,L_82D7		;82c8
	ld a,(0e092h)		;82ca   ; la FASE, de 1 a 13
	cp 00ch		;82cd
	ld c,002h		;82cf
	jr z,L_82E9		;82d1
	cp 018h		;82d3
	jr z,L_82DE		;82d5
L_82D7:
	ld hl,0e001h		;82d7
	inc (hl)			;82da
	jp avanza_el_subestado		;82db
L_82DE:
	ld a,(0e0deh)		;82de
	and 003h		;82e1
	dec a			;82e3
	ld c,000h		;82e4
	jr z,L_82E9		;82e6
	inc c			;82e8
L_82E9:
	ld a,c			;82e9
	ld (0e0b9h),a		;82ea
	xor a			;82ed
	ld (0e0b7h),a		;82ee
	inc a			;82f1
	ld (0e096h),a		;82f2   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;82f5
L_82F8:
	djnz L_830B		;82f8
	call 04265h		;82fa   ; banco 0: sube_el_area_de_juego
	call 042fbh		;82fd   ; banco 0: sube_los_sprites
	call 0aa80h		;8300
	ld a,(0e096h)		;8303   ; los avisos que deja el cuadro
	and a			;8306
	ret nz			;8307
	jp avanza_el_subestado		;8308
L_830B:
	djnz L_8335		;830b
	call 042edh		;830d   ; banco 0: esconde_los_sprites
	call 04232h		;8310   ; banco 0: borra_el_area_de_juego
	ld hl,0e091h		;8313
	ld a,(hl)			;8316
	add a,001h		;8317
	daa			;8319
	ld (hl),a			;831a
	inc l			;831b
	inc l			;831c
	inc (hl)			;831d
	ld a,(hl)			;831e
	cp 004h		;831f
	jr nz,L_8325		;8321
	ld (hl),001h		;8323
L_8325:
	dec l			;8325
	inc (hl)			;8326
	ld a,(hl)			;8327
	cp 019h		;8328
	jp z,avanza_el_subestado		;832a
	call 04660h		;832d   ; banco 0: monta_la_fase
	ld a,003h		;8330
	jp pon_el_estado		;8332
L_8335:
	djnz L_834F		;8335
	call 04224h		;8337   ; banco 0: borra_la_pantalla_entera
	ld hl,0eb80h		;833a
	ld de,0eb81h		;833d
	ld bc,002ffh		;8340
	ld (hl),000h		;8343
	ldir		;8345
	ld a,0c2h		;8347
	call 0413ah		;8349   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;834c
L_834F:
	djnz L_8362		;834f
	call 04265h		;8351   ; banco 0: sube_el_area_de_juego
	call 05e6eh		;8354   ; banco 0: rotulos_que_suben
	ld a,(0e096h)		;8357   ; los avisos que deja el cuadro
	and a			;835a
	ret nz			;835b
	ld (0e002h),a		;835c
	jp estado_a_0xFF		;835f
L_8362:
	call 0a083h		;8362
	call 042dfh		;8365
	call 04265h		;8368   ; banco 0: sube_el_area_de_juego
	ld a,(0e093h)		;836b   ; el valor 1-2-3 de la fase
	cp 003h		;836e
	jp z,pasa_al_estado_siguiente		;8370
	ld a,0e0h		;8373
	ld (0eec4h),a		;8375
	ld a,(0e0a1h)		;8378   ; el DECORADO, de 0 a 9
	cp 004h		;837b
	ld c,002h		;837d
	ld b,098h		;837f
	jr z,L_8391		;8381
	cp 005h		;8383
	jr z,L_8391		;8385
	cp 007h		;8387
	ld c,003h		;8389
	jr z,L_8391		;838b
	ld c,001h		;838d
	ld b,086h		;838f
L_8391:
	ld a,b			;8391
	call 0413ah		;8392   ; banco 0: pide_sonido_si_esta_activo
	ld a,c			;8395
	ld (0e21eh),a		;8396
	ld a,017h		;8399
	ld (0e203h),a		;839b   ; por donde va la rotacion de los sprites
	call 055f7h		;839e
L_83A1:
	ld a,001h		;83a1
	ld (0e096h),a		;83a3   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;83a6
L_83A9:
	djnz L_83C0		;83a9
	call 042fbh		;83ab   ; banco 0: sube_los_sprites
	call L_96F9		;83ae
	call 0a985h		;83b1
	ld a,(0e203h)		;83b4   ; por donde va la rotacion de los sprites
	cp 00ch		;83b7
	ret nz			;83b9
	call 07db3h		;83ba
	jp avanza_el_subestado		;83bd
L_83C0:
	djnz L_83E4		;83c0
	call 04265h		;83c2   ; banco 0: sube_el_area_de_juego
	call 04332h		;83c5   ; banco 0: sube_los_sprites_desde_arriba
	call 0b12bh		;83c8
	call 07cf8h		;83cb
	ld hl,0e550h		;83ce
	ld b,004h		;83d1
L_83D3:
	ld a,(hl)			;83d3
	cp 002h		;83d4
	ret c			;83d6
	ld a,008h		;83d7
	call 04056h		;83d9   ; banco 0: a_mas_hl
	djnz L_83D3		;83dc
	call 0b165h		;83de
	jp avanza_el_subestado		;83e1
L_83E4:
	djnz L_8445		;83e4
	call 04258h		;83e6   ; banco 0: sube_la_mitad_de_abajo
	call 042fbh		;83e9   ; banco 0: sube_los_sprites
	call L_96F9		;83ec
	call 0a985h		;83ef
	call 0bd8ah		;83f2
	call 0bdcah		;83f5
	call 07b44h		;83f8
	call 07c9fh		;83fb
	call 0ae6ah		;83fe
	call 0af82h		;8401
	call 0b184h		;8404
	call 07c01h		;8407
	call 0b2c2h		;840a
	call 07cf8h		;840d
	call L_921B		;8410
	call L_9469		;8413
	call 076f3h		;8416
	call 07799h		;8419
	ld a,001h		;841c
	ld (0e0e0h),a		;841e
	ld a,(0e097h)		;8421   ; la bandera de que la fase se ha acabado
	and a			;8424
	ld a,00dh		;8425
	jp z,pon_el_estado		;8427
	xor a			;842a
	ld (0e0e0h),a		;842b
	ld a,(0e530h)		;842e
	cp 002h		;8431
	ret nz			;8433
	call 07c3eh		;8434
	ld a,07ah		;8437
	call 0413ah		;8439   ; banco 0: pide_sonido_si_esta_activo
	call 042e8h		;843c
	call 05561h		;843f
	jp avanza_el_subestado		;8442
L_8445:
	djnz L_8474		;8445
	ld a,(0e530h)		;8447
	cp 003h		;844a
	jr c,L_845B		;844c
	ld a,(0e003h)		;844e   ; el contador de cuadros
	rra			;8451
	ld b,000h		;8452
	jr c,L_8458		;8454
	ld b,00eh		;8456
L_8458:
	call 044b6h		;8458   ; banco 0: escribe_el_registro_7
L_845B:
	call 04265h		;845b   ; banco 0: sube_el_area_de_juego
	call 042fbh		;845e   ; banco 0: sube_los_sprites
	call 0afafh		;8461
	call 07c3eh		;8464
	ld a,(0e530h)		;8467
	and a			;846a
	ret nz			;846b
	ld b,000h		;846c
	call 044b6h		;846e   ; banco 0: escribe_el_registro_7
	jp avanza_el_subestado		;8471
L_8474:
	djnz L_84B5		;8474
	ld a,001h		;8476
	ld (0e21eh),a		;8478
	ld a,018h		;847b
	ld (0e203h),a		;847d   ; por donde va la rotacion de los sprites
	xor a			;8480
	ld (0e0ddh),a		;8481
	ld a,(0e08bh)		;8484   ; el largo de la fase
	and 00fh		;8487
	cp 002h		;8489
	ld c,028h		;848b
	jr z,L_84A3		;848d
	cp 004h		;848f
	ld c,048h		;8491
	jr z,L_84A3		;8493
	cp 006h		;8495
	ld c,068h		;8497
	jr z,L_84A3		;8499
	cp 008h		;849b
	ld c,088h		;849d
	jr z,L_84A3		;849f
	ld c,001h		;84a1
L_84A3:
	ld a,c			;84a3
	ld (0e21ch),a		;84a4
	call 05667h		;84a7
	call 0550ch		;84aa
	ld a,005h		;84ad
	call pon_el_estado		;84af
	jp L_83A1		;84b2
L_84B5:
	call 04265h		;84b5   ; banco 0: sube_el_area_de_juego
	ld a,001h		;84b8
	ld (0ee83h),a		;84ba
	ld (0ee87h),a		;84bd
	ld (0ee8bh),a		;84c0
	ld (0ee8fh),a		;84c3
	ld a,00bh		;84c6
	ld (0e203h),a		;84c8   ; por donde va la rotacion de los sprites
	ld a,003h		;84cb
	ld (0e0a5h),a		;84cd   ; por que vuelta de la fase va
	ld a,062h		;84d0
	call 0413ah		;84d2   ; banco 0: pide_sonido_si_esta_activo
	call 0ae0fh		;84d5
	call 0ae23h		;84d8
	call 057c2h		;84db
	jp avanza_el_subestado		;84de
L_84E1:
	djnz L_84F8		;84e1
	call 04332h		;84e3   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;84e6
	call 0a985h		;84e9
	call 0be41h		;84ec
	ld a,(0e203h)		;84ef   ; por donde va la rotacion de los sprites
	cp 019h		;84f2
	ret nz			;84f4
	jp avanza_el_subestado		;84f5
L_84F8:
	djnz L_852A		;84f8
	call 042edh		;84fa   ; banco 0: esconde_los_sprites
	call 04232h		;84fd   ; banco 0: borra_el_area_de_juego
	call 0b5e1h		;8500
	call 0463fh		;8503   ; banco 0: empieza_una_vida
	call 04995h		;8506
	call 049fch		;8509
	call 049d2h		;850c
	call 057fbh		;850f
	call L_966B		;8512
	xor a			;8515
	call L_9453		;8516
	call 06000h		;8519
	call 06539h		;851c
	call 04265h		;851f   ; banco 0: sube_el_area_de_juego
	call L_9493		;8522
	ld a,004h		;8525
	jp pon_el_estado		;8527
L_852A:
	call 042e8h		;852a
	call 07db3h		;852d
	ld a,0c5h		;8530
	call 0413ah		;8532   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8535
L_8538:
	djnz L_8558		;8538
	call 042fbh		;853a   ; banco 0: sube_los_sprites
	call L_96F9		;853d
	ld a,(0e096h)		;8540   ; los avisos que deja el cuadro
	and a			;8543
	ret nz			;8544
	ld (0e0ceh),a		;8545
	inc a			;8548
	ld (0e096h),a		;8549   ; los avisos que deja el cuadro
	call 042e8h		;854c
	call 04232h		;854f   ; banco 0: borra_el_area_de_juego
	call 05b91h		;8552
	jp avanza_el_subestado		;8555
L_8558:
	djnz L_8565		;8558
	call 0b63fh		;855a
	ld a,(0e096h)		;855d   ; los avisos que deja el cuadro
	and a			;8560
	ret nz			;8561
	jp avanza_el_subestado		;8562
L_8565:
	djnz L_8596		;8565
	call 04232h		;8567   ; banco 0: borra_el_area_de_juego
	call 0b6f8h		;856a
	call 0463fh		;856d   ; banco 0: empieza_una_vida
	call 04995h		;8570
	call 049fch		;8573
	call 049d2h		;8576
	call 057fbh		;8579
	call L_9689		;857c
	call L_966B		;857f
	call L_9431		;8582
	call 06000h		;8585
	call 06539h		;8588
	call 04265h		;858b   ; banco 0: sube_el_area_de_juego
	ld a,01fh		;858e
	call 0413ah		;8590   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8593
L_8596:
	djnz L_85BD		;8596
	call 04332h		;8598   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;859b
	call 0a985h		;859e
	ld a,(0e203h)		;85a1   ; por donde va la rotacion de los sprites
	and a			;85a4
	ld c,020h		;85a5
	jr z,L_85AE		;85a7
	cp 005h		;85a9
	ret nz			;85ab
	ld c,006h		;85ac
L_85AE:
	ld a,c			;85ae
	call 0413ah		;85af   ; banco 0: pide_sonido_si_esta_activo
	call 042e8h		;85b2
	call L_9493		;85b5
	ld a,004h		;85b8
	jp pon_el_estado		;85ba
L_85BD:
	ld a,056h		;85bd
	call 0413ah		;85bf   ; banco 0: pide_sonido_si_esta_activo
L_85C2:
	call 04265h		;85c2   ; banco 0: sube_el_area_de_juego
	ld a,01ah		;85c5
	ld (0e203h),a		;85c7   ; por donde va la rotacion de los sprites
	ld a,001h		;85ca
	ld (0e096h),a		;85cc   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;85cf
L_85D2:
	djnz L_85E3		;85d2
	call 04332h		;85d4   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;85d7
	ld a,(0e203h)		;85da   ; por donde va la rotacion de los sprites
	cp 011h		;85dd
	ret nz			;85df
	jp avanza_el_subestado		;85e0
L_85E3:
	djnz L_8620		;85e3
	call 042edh		;85e5   ; banco 0: esconde_los_sprites
	call 04232h		;85e8   ; banco 0: borra_el_area_de_juego
	call 0b8ddh		;85eb
	call 0463fh		;85ee   ; banco 0: empieza_una_vida
	ld a,002h		;85f1
	ld (0e4c0h),a		;85f3
	ld (0e4c1h),a		;85f6
	call 04995h		;85f9
	call 049fch		;85fc
	call 049d2h		;85ff
	call 057fbh		;8602
	call L_966B		;8605
	xor a			;8608
	call L_9453		;8609
	call 06000h		;860c
	call 06539h		;860f
	call 04265h		;8612   ; banco 0: sube_el_area_de_juego
	call 07db3h		;8615
	ld a,01fh		;8618
	call 0413ah		;861a   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;861d
L_8620:
	djnz L_863D		;8620
	call 04332h		;8622   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;8625
	call 0a985h		;8628
	ld a,(0e203h)		;862b   ; por donde va la rotacion de los sprites
	and a			;862e
	ret nz			;862f
	ld a,020h		;8630
	call 0413ah		;8632   ; banco 0: pide_sonido_si_esta_activo
	call L_9493		;8635
	ld a,004h		;8638
	jp pon_el_estado		;863a
L_863D:
	call 042dfh		;863d
	ld a,092h		;8640
	call 0413ah		;8642   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8645
L_8648:
	djnz L_865B		;8648
	call 04332h		;864a   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;864d
	call 0a985h		;8650
	ld a,(0e203h)		;8653   ; por donde va la rotacion de los sprites
	and a			;8656
	ret nz			;8657
	jp avanza_el_subestado		;8658
L_865B:
	djnz L_868F		;865b
	call 042edh		;865d   ; banco 0: esconde_los_sprites
	call 04232h		;8660   ; banco 0: borra_el_area_de_juego
	call 0b94ah		;8663
	call 0463fh		;8666   ; banco 0: empieza_una_vida
	call 04995h		;8669
	call 049fch		;866c
	call 049d2h		;866f
	call 057fbh		;8672
	call L_9689		;8675
	call L_966B		;8678
	call L_9431		;867b
	call 06000h		;867e
	call 06539h		;8681
	call 04265h		;8684   ; banco 0: sube_el_area_de_juego
	call L_9493		;8687
	ld a,004h		;868a
	jp pon_el_estado		;868c
L_868F:
	call 042e8h		;868f
	ld a,001h		;8692
	ld (0e21eh),a		;8694
	ld a,01bh		;8697
	ld (0e203h),a		;8699   ; por donde va la rotacion de los sprites
	call 07db3h		;869c
	ld a,0f8h		;869f
	ld (0e21fh),a		;86a1
	ld c,00eh		;86a4
	ld hl,0ee90h		;86a6
L_86A9:
	ld b,004h		;86a9
	ld de,086c2h		;86ab
L_86AE:
	ld a,(de)			;86ae
	ld (hl),a			;86af
	inc de			;86b0
	inc l			;86b1
	djnz L_86AE		;86b2
	dec c			;86b4
	jr nz,L_86A9		;86b5
	call 056a0h		;86b7
	ld a,089h		;86ba
	call 0413ah		;86bc   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;86bf

; ----------------------------------------------------------------------
; DATOS sin identificar  0x86c2..0x86c6  (4 bytes)
DATA_86C2:
	defb 0e0h,078h,034h,00ah	; 86c2

; ======================================================================
; CODIGO 0x86c6..0x8a55  (911 bytes)
; ======================================================================


L_86C6:
	djnz L_86D7		;86c6
	call 04332h		;86c8   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;86cb
	ld a,(0e203h)		;86ce   ; por donde va la rotacion de los sprites
	cp 011h		;86d1
	ret nz			;86d3
	jp avanza_el_subestado		;86d4
L_86D7:
	djnz L_86ED		;86d7
	call 042edh		;86d9   ; banco 0: esconde_los_sprites
	call 04232h		;86dc   ; banco 0: borra_el_area_de_juego
	call L_9431		;86df
	call 06befh		;86e2
	ld a,01fh		;86e5
	call 0413ah		;86e7   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;86ea
L_86ED:
	djnz L_8735		;86ed
	call 04332h		;86ef   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;86f2
	call 0a985h		;86f5
	ld a,(0e203h)		;86f8   ; por donde va la rotacion de los sprites
	and a			;86fb
	ret nz			;86fc
	ld a,020h		;86fd
	call 0413ah		;86ff   ; banco 0: pide_sonido_si_esta_activo
	ld a,(0e0a2h)		;8702   ; el modo en el que esta el juego
	sub 003h		;8705
	ld c,06bh		;8707
	jr z,L_8712		;8709
	dec a			;870b
	ld c,06eh		;870c
	jr z,L_8712		;870e
	ld c,068h		;8710
L_8712:
	ld a,c			;8712
	call 0413ah		;8713   ; banco 0: pide_sonido_si_esta_activo
	call 0a8dbh		;8716
	xor a			;8719
	call 0a8f5h		;871a
	ld a,004h		;871d
	ld (0ee83h),a		;871f
	ld (0ee87h),a		;8722
	ld (0ee8bh),a		;8725
	ld (0ee8fh),a		;8728
	call 042fbh		;872b   ; banco 0: sube_los_sprites
	xor a			;872e
	ld (0e096h),a		;872f   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;8732
L_8735:
	djnz L_8751		;8735
	call 06e1eh		;8737
	ld a,(0e096h)		;873a   ; los avisos que deja el cuadro
	and a			;873d
	ret z			;873e
	dec a			;873f
	ld a,000h		;8740
	ld (0e096h),a		;8742   ; los avisos que deja el cuadro
	jp nz,avanza_el_subestado		;8745
	ld hl,0e001h		;8748
	inc (hl)			;874b
	inc (hl)			;874c
	inc (hl)			;874d
	jp avanza_el_subestado		;874e
L_8751:
	djnz L_8769		;8751
	ld hl,03b00h		;8753
	ld a,0d0h		;8756
	call 0004dh		;8758   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;875b   ; banco 0: borra_el_area_de_juego
	call 07809h		;875e
	ld a,074h		;8761
	call 0413ah		;8763   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8766
L_8769:
	djnz L_8783		;8769
	call 0781eh		;876b
	ld a,(0e096h)		;876e   ; los avisos que deja el cuadro
	and a			;8771
	ret z			;8772
	dec a			;8773
	ld a,000h		;8774
	ld (0e096h),a		;8776   ; los avisos que deja el cuadro
	jp nz,avanza_el_subestado		;8779
	ld hl,0e001h		;877c
	inc (hl)			;877f
	jp avanza_el_subestado		;8780
L_8783:
	djnz L_87AE		;8783
	call 04232h		;8785   ; banco 0: borra_el_area_de_juego
	call 06c7fh		;8788
	call 042fbh		;878b   ; banco 0: sube_los_sprites
	ld a,(0e0a2h)		;878e   ; el modo en el que esta el juego
	sub 003h		;8791
	ld c,06bh		;8793
	jr z,L_879E		;8795
	dec a			;8797
	ld c,06eh		;8798
	jr z,L_879E		;879a
	ld c,068h		;879c
L_879E:
	ld a,c			;879e
	call 0413ah		;879f   ; banco 0: pide_sonido_si_esta_activo
	xor a			;87a2
	ld (0e096h),a		;87a3   ; los avisos que deja el cuadro
	ld a,003h		;87a6
	ld (0e001h),a		;87a8   ; el SUBESTADO
	jp avanza_el_subestado		;87ab
L_87AE:
	djnz L_87DC		;87ae
	call 042edh		;87b0   ; banco 0: esconde_los_sprites
	call 04232h		;87b3   ; banco 0: borra_el_area_de_juego
	call 07015h		;87b6
	call 0463fh		;87b9   ; banco 0: empieza_una_vida
	call 04995h		;87bc
	call 049fch		;87bf
	call 049d2h		;87c2
	call 057fbh		;87c5
	call L_9689		;87c8
	call L_966B		;87cb
	call L_9431		;87ce
	call 04265h		;87d1   ; banco 0: sube_el_area_de_juego
	ld a,095h		;87d4
	call 0413ah		;87d6   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;87d9
L_87DC:
	djnz L_87F2		;87dc
	call 04332h		;87de   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;87e1
	ld a,(0e203h)		;87e4   ; por donde va la rotacion de los sprites
	cp 004h		;87e7
	ret nz			;87e9
	call L_9493		;87ea
	ld a,004h		;87ed
	jp pon_el_estado		;87ef
L_87F2:
	call 042dfh		;87f2
	call 04265h		;87f5   ; banco 0: sube_el_area_de_juego
	ld a,092h		;87f8
	call 0413ah		;87fa   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;87fd
L_8800:
	call L_8AEC		;8800
	jp 0be41h		;8803
L_8806:
	djnz L_881D		;8806
	call 04332h		;8808   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;880b
	call 0a985h		;880e
	ld a,(0e096h)		;8811   ; los avisos que deja el cuadro
	and a			;8814
	ret nz			;8815
	xor a			;8816
	ld (0e0e0h),a		;8817
	jp avanza_el_subestado		;881a
L_881D:
	djnz L_8869		;881d
	call 042edh		;881f   ; banco 0: esconde_los_sprites
	call 04232h		;8822   ; banco 0: borra_el_area_de_juego
	ld a,(0e0a2h)		;8825   ; el modo en el que esta el juego
	dec a			;8828
	jr nz,L_8833		;8829
	ld a,008h		;882b
	call pon_el_estado		;882d
	jp L_85C2		;8830
L_8833:
	ld hl,0e090h		;8833
	ld a,(hl)			;8836
	or a			;8837
	jp z,pasa_al_estado_siguiente		;8838
	sub 001h		;883b
	daa			;883d
	ld (hl),a			;883e
	call 04708h		;883f   ; banco 0: reempieza
	call 0463fh		;8842   ; banco 0: empieza_una_vida
	call 05b91h		;8845
	call 0481bh		;8848
	call L_9431		;884b
	call L_9409		;884e
	call L_93FB		;8851
	call 07b5eh		;8854
	xor a			;8857
	ld (0e0b5h),a		;8858
	ld (0e126h),a		;885b
	inc a			;885e
	ld (0e10eh),a		;885f
	call L_8AEC		;8862
	xor a			;8865
	jp pon_la_espera_y_avanza		;8866
L_8869:
	dec b			;8869
	jp nz,L_8919		;886a
	call L_8AEC		;886d
	ld hl,0e004h		;8870
	dec (hl)			;8873
	ret nz			;8874
	xor a			;8875
	ld (0e10eh),a		;8876
	ld hl,03b00h		;8879
	ld a,0e0h		;887c
	call 0004dh		;887e   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b04h		;8881
	ld a,0e0h		;8884
	call 0004dh		;8886   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b08h		;8889
	ld a,0e0h		;888c
	call 0004dh		;888e   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;8891   ; banco 0: borra_el_area_de_juego
	call 04995h		;8894
	call 049fch		;8897
	call 049d2h		;889a
	call 057fbh		;889d
	ld a,(0e0a5h)		;88a0   ; por que vuelta de la fase va
	cp 002h		;88a3
	jr z,L_88BC		;88a5
	cp 003h		;88a7
	jr z,L_88DA		;88a9
	call L_966B		;88ab
	call L_9689		;88ae
	call 04265h		;88b1   ; banco 0: sube_el_area_de_juego
	call L_9493		;88b4
	ld a,004h		;88b7
	jp pon_el_estado		;88b9
L_88BC:
	ld a,(0e093h)		;88bc   ; el valor 1-2-3 de la fase
	cp 003h		;88bf
	jr nz,L_8902		;88c1
	call 0537ah		;88c3
	call 053cfh		;88c6
	call 05424h		;88c9
	call 05498h		;88cc
	call 04265h		;88cf   ; banco 0: sube_el_area_de_juego
	call L_9493		;88d2
	ld a,004h		;88d5
	jp pon_el_estado		;88d7
L_88DA:
	call 0537ah		;88da
	call 053cfh		;88dd
	call 05424h		;88e0
	call 05498h		;88e3
	call 057c2h		;88e6
	xor a			;88e9
	ld (0e540h),a		;88ea
	call 0b165h		;88ed
	ld a,065h		;88f0
	call 0413ah		;88f2   ; banco 0: pide_sonido_si_esta_activo
	ld a,007h		;88f5
	ld (0e000h),a		;88f7   ; la variable de fase
	ld a,003h		;88fa
	ld (0e001h),a		;88fc   ; el SUBESTADO
	jp 04265h		;88ff   ; banco 0: sube_el_area_de_juego
L_8902:
	call 05212h		;8902
	call 05256h		;8905
	call 0529ah		;8908
	call 0530ah		;890b
	call 04265h		;890e   ; banco 0: sube_el_area_de_juego
	call L_9493		;8911
	ld a,004h		;8914
	jp pon_el_estado		;8916
L_8919:
	call 042dfh		;8919
	call 04265h		;891c   ; banco 0: sube_el_area_de_juego
	call 05750h		;891f
	xor a			;8922
	ld (0e21dh),a		;8923
	ld (0e21bh),a		;8926
	inc a			;8929
	ld (0e096h),a		;892a   ; los avisos que deja el cuadro
	ld (0e097h),a		;892d   ; la bandera de que la fase se ha acabado
	jp avanza_el_subestado		;8930
L_8933:
	dec b			;8933
	jp nz,L_8A0F		;8934
	ld a,(0f0f7h)		;8937
	cp 0feh		;893a
	call nc,L_8A42		;893c
	ld a,(0e012h)		;893f
	or a			;8942
	ret nz			;8943
	ld a,(0e0dfh)		;8944
	and a			;8947
	jp z,L_8A01		;8948
	ld a,(0e0c6h)		;894b
	ld c,a			;894e
	ld a,(0e0c7h)		;894f
	ld b,a			;8952
	ld a,(0e0c8h)		;8953
	ld e,a			;8956
	ld a,(0e0c9h)		;8957
	ld d,a			;895a
	ld a,(0e0cah)		;895b
	ld l,a			;895e
	ld a,(0e0cbh)		;895f
	ld h,a			;8962
	push bc			;8963
	push de			;8964
	push hl			;8965
	ld a,(0e091h)		;8966   ; el numero de fase tal como se pinta
	ld c,a			;8969
	ld a,(0e092h)		;896a   ; la FASE, de 1 a 13
	ld b,a			;896d
	ld a,(0e093h)		;896e   ; el valor 1-2-3 de la fase
	ld e,a			;8971
	ld a,(0e08fh)		;8972
	ld d,a			;8975
	push de			;8976
	push bc			;8977
	ld hl,0e086h		;8978
	ld de,0e087h		;897b
	ld bc,000d9h		;897e
	ld (hl),000h		;8981
	ldir		;8983
	ld a,(0f0f7h)		;8985
	cp 0feh		;8988
	jr z,L_89A6		;898a
	ld hl,0e160h		;898c
	ld de,0e161h		;898f
	ld bc,0008fh		;8992
	ld (hl),000h		;8995
	ldir		;8997
	ld hl,0eba0h		;8999
	ld de,0eba1h		;899c
	ld bc,00040h		;899f
	ld (hl),000h		;89a2
	ldir		;89a4
L_89A6:
	ld hl,0e1f0h		;89a6
	ld de,0e1f1h		;89a9
	ld bc,0098fh		;89ac
	ld (hl),000h		;89af
	ldir		;89b1
	ld hl,0ebe0h		;89b3
	ld de,0ebe1h		;89b6
	ld bc,0031fh		;89b9
	ld (hl),000h		;89bc
	ldir		;89be
	pop bc			;89c0
	pop de			;89c1
	ld hl,0e090h		;89c2
	ld (hl),002h		;89c5
	inc l			;89c7
	ld (hl),c			;89c8
	inc l			;89c9
	ld (hl),b			;89ca
	inc l			;89cb
	ld (hl),e			;89cc
	inc l			;89cd
	inc l			;89ce
	ld (hl),005h		;89cf
	inc l			;89d1
	ld (hl),000h		;89d2
	inc l			;89d4
	ld (hl),001h		;89d5
	ld a,d			;89d7
	ld (0e08fh),a		;89d8
	pop hl			;89db
	pop de			;89dc
	pop bc			;89dd
	ld a,c			;89de
	ld (0e0c6h),a		;89df
	ld a,b			;89e2
	ld (0e0c7h),a		;89e3
	ld a,e			;89e6
	ld (0e0c8h),a		;89e7
	ld a,d			;89ea
	ld (0e0c9h),a		;89eb
	ld a,l			;89ee
	ld (0e0cah),a		;89ef
	ld a,h			;89f2
	ld (0e0cbh),a		;89f3
	call 046e3h		;89f6   ; banco 0: monta_la_fase_desde_el_decorado
	call 04232h		;89f9   ; banco 0: borra_el_area_de_juego
	ld a,003h		;89fc
	jp pon_el_estado		;89fe
L_8A01:
	ld hl,0e002h		;8a01
	ld a,(hl)			;8a04
	and 0bfh		;8a05
	ld (hl),a			;8a07
	xor a			;8a08
	ld (0e082h),a		;8a09   ; uno o dos jugadores
	jp estado_a_0xFF		;8a0c
L_8A0F:
	call 04224h		;8a0f   ; banco 0: borra_la_pantalla_entera
	ld a,0c8h		;8a12
	call 0413ah		;8a14   ; banco 0: pide_sonido_si_esta_activo
	call 05b91h		;8a17
	ld de,08e30h		;8a1a
	call 042bch		;8a1d   ; banco 0: pinta_guion_con_mascara
	ld de,0e085h		;8a20
	ld hl,03971h		;8a23
	call L_93E3		;8a26
	ld hl,03991h		;8a29
	ld de,0e088h		;8a2c
	call L_93E3		;8a2f
	ld a,(0f0f7h)		;8a32
	cp 0feh		;8a35
	jr c,L_8A3F		;8a37
	ld de,08e1eh		;8a39
	call 042bch		;8a3c   ; banco 0: pinta_guion_con_mascara
L_8A3F:
	jp avanza_el_subestado		;8a3f
L_8A42:
	ld a,(0e006h)		;8a42   ; las teclas recien pulsadas
	and 040h		;8a45
	ret z			;8a47
	ld a,001h		;8a48
	ld (0e0dfh),a		;8a4a
	ld de,08e1eh		;8a4d
	ld c,000h		;8a50
	jp 042beh		;8a52   ; banco 0: pinta_guion_lee_destino

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8a55..0x8a8d  (56 bytes)
DATA_8A55:
	defb 0cdh,0c8h,044h,021h,081h,0e0h,0cdh,0c1h,044h,0b7h,0c8h,021h,004h,0e0h,036h,000h	; 8a55  ..D!....D..!..6.
	defb 021h,000h,0e0h,046h,010h,00eh,0e6h,030h,0c8h,03eh,040h,032h,002h,0e0h,036h,003h	; 8a65  !..F...0.>@2..6.
	defb 023h,036h,000h,0c9h,07eh,0a7h,020h,006h,03ah,001h,0e0h,0feh,003h,0c8h,036h,001h	; 8a75  #6..~. .:.....6.
	defb 03eh,0cbh,0cdh,045h,041h,0c3h,095h,05ch	; 8a85  >..EA..\

; ======================================================================
; CODIGO 0x8a8d..0x8d09  (636 bytes)
; ======================================================================


L_8A8D:
	ld hl,00000h		;8a8d
	ld (0e00ah),hl		;8a90
	call 047e2h		;8a93   ; banco 0: pinta_del_banco_6
	ld hl,00a00h		;8a96
	ld bc,003f0h		;8a99
	xor a			;8a9c
	call 00056h		;8a9d   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;8aa0
	ld a,040h		;8aa3
	ld c,006h		;8aa5
	ld de,0000bh		;8aa7
L_8AAA:
	ld b,015h		;8aaa
L_8AAC:
	call 0004dh		;8aac   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;8aaf
	inc a			;8ab0
	djnz L_8AAC		;8ab1
	add hl,de			;8ab3
	dec c			;8ab4
	jr nz,L_8AAA		;8ab5
	ret			;8ab7
L_8AB8:
	ld bc,(0e00ah)		;8ab8
	ld a,0ebh		;8abc
	inc b			;8abe
L_8ABF:
	add a,015h		;8abf
	djnz L_8ABF		;8ac1
	ld l,a			;8ac3
	ld h,b			;8ac4
	add hl,hl			;8ac5
	add hl,hl			;8ac6
	add hl,hl			;8ac7
	ld de,00a00h		;8ac8
	add hl,de			;8acb
	ld a,c			;8acc
	call 04056h		;8acd   ; banco 0: a_mas_hl
	ld b,015h		;8ad0
	ld de,00008h		;8ad2
	ld a,0f0h		;8ad5
L_8AD7:
	call 0004dh		;8ad7   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;8ada
	djnz L_8AD7		;8adb
	ld hl,0e00ah		;8add
	ld a,(hl)			;8ae0
	inc a			;8ae1
	and 007h		;8ae2
	ld (hl),a			;8ae4
	ret nz			;8ae5
	inc hl			;8ae6
	inc (hl)			;8ae7
	ld a,(hl)			;8ae8
	cp 006h		;8ae9
	ret			;8aeb
L_8AEC:
	ld a,(0e0b5h)		;8aec
	ld b,a			;8aef
	djnz L_8AFE		;8af0
	ld hl,0e126h		;8af2
	dec (hl)			;8af5
	jp z,L_8CF3		;8af6
L_8AF9:
	ld hl,0e004h		;8af9
	inc (hl)			;8afc
	ret			;8afd
L_8AFE:
	djnz L_8B15		;8afe
	call L_8B51		;8b00
	ld hl,0e121h		;8b03
	sub (hl)			;8b06
	dec a			;8b07
	jp nz,L_8CF3		;8b08
	ld a,050h		;8b0b
	ld (0e004h),a		;8b0d   ; el contador de espera del estado
	ld b,005h		;8b10
	jp L_8CFA		;8b12
L_8B15:
	djnz L_8B5C		;8b15
	call L_8B51		;8b17
	dec a			;8b1a
	cp 006h		;8b1b
	jp nc,L_8CF3		;8b1d
	ld hl,08d85h		;8b20
	ld b,a			;8b23
	add a,a			;8b24
	ld c,a			;8b25
	add a,a			;8b26
	add a,b			;8b27
	add a,c			;8b28
	call 04056h		;8b29   ; banco 0: a_mas_hl
	ld a,(hl)			;8b2c
	inc hl			;8b2d
	ld e,(hl)			;8b2e
	inc hl			;8b2f
	ld d,(hl)			;8b30
	inc hl			;8b31
	ld c,(hl)			;8b32
	inc hl			;8b33
	ld b,(hl)			;8b34
	inc hl			;8b35
	push af			;8b36
	ld a,(hl)			;8b37
	inc hl			;8b38
	ld h,(hl)			;8b39
	ld l,a			;8b3a
	pop af			;8b3b
	ld (0e126h),a		;8b3c
	ld a,(hl)			;8b3f
	and a			;8b40
	jp z,L_8CF3		;8b41
	ld (0e124h),de		;8b44
	ld (0e11fh),bc		;8b48
	ld b,006h		;8b4c
	jp L_8CFA		;8b4e
L_8B51:
	ld de,(0e11fh)		;8b51
L_8B55:
	inc de			;8b55
	ld (0e11fh),de		;8b56
	ld a,(de)			;8b5a
	ret			;8b5b
L_8B5C:
	djnz L_8B83		;8b5c
	call L_8B51		;8b5e
	ld b,008h		;8b61
	ld l,a			;8b63
	call L_8B55		;8b64
	ld h,a			;8b67
L_8B68:
	call 0004ah		;8b68   ; BIOS RDVRM - Reads the content of VRAM
	ld c,a			;8b6b
	and 0f0h		;8b6c
	cp 010h		;8b6e
	jr nz,L_8B74		;8b70
	ld a,090h		;8b72
L_8B74:
	or c			;8b74
	call 0004dh		;8b75   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;8b78
	djnz L_8B68		;8b79
	call L_8CFF		;8b7b
	ld b,002h		;8b7e
	jp L_8CFA		;8b80
L_8B83:
	dec b			;8b83
	jp nz,L_8C44		;8b84
	ld hl,(0e141h)		;8b87
	dec hl			;8b8a
	ld (0e141h),hl		;8b8b
	ld a,l			;8b8e
	or h			;8b8f
	jp z,L_8C34		;8b90
	ld a,(0e143h)		;8b93
	and a			;8b96
	jp nz,L_8BFE		;8b97
	ld ix,08d09h		;8b9a
	bit 4,l		;8b9e
	jr z,L_8BA6		;8ba0
	ld ix,08d16h		;8ba2
L_8BA6:
	ld a,(ix+000h)		;8ba6
	ld b,a			;8ba9
	inc ix		;8baa
	ld de,03b00h		;8bac
L_8BAF:
	ld hl,0e122h		;8baf
	ld a,(ix+000h)		;8bb2
	push af			;8bb5
	ld a,(0e139h)		;8bb6
	and a			;8bb9
	jr z,L_8BC1		;8bba
	pop af			;8bbc
	neg		;8bbd
	jr L_8BC2		;8bbf
L_8BC1:
	pop af			;8bc1
L_8BC2:
	add a,(hl)			;8bc2
	ld c,a			;8bc3
	inc hl			;8bc4
	ld a,(hl)			;8bc5
	add a,(ix+001h)		;8bc6
	ex de,hl			;8bc9
	call 0004dh		;8bca   ; BIOS WRTVRM - Writes data in VRAM
	ld a,c			;8bcd
	inc hl			;8bce
	call 0004dh		;8bcf   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(ix+002h)		;8bd2
	ld c,a			;8bd5
	ld a,(0e139h)		;8bd6
	and a			;8bd9
	jr z,L_8BE0		;8bda
	ld a,004h		;8bdc
	add a,c			;8bde
	ld c,a			;8bdf
L_8BE0:
	ld a,c			;8be0
	inc hl			;8be1
	call 0004dh		;8be2   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(ix+003h)		;8be5
	inc hl			;8be8
	call 0004dh		;8be9   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;8bec
	ex de,hl			;8bed
	inc ix		;8bee
	inc ix		;8bf0
	inc ix		;8bf2
	inc ix		;8bf4
	djnz L_8BAF		;8bf6
	ld a,0d0h		;8bf8
	ex de,hl			;8bfa
	jp 0004dh		;8bfb   ; BIOS WRTVRM - Writes data in VRAM
L_8BFE:
	dec a			;8bfe
	jr nz,L_8C11		;8bff
	ld ix,08d23h		;8c01
	bit 4,l		;8c05
	jp z,L_8BA6		;8c07
	ld ix,08d34h		;8c0a
	jp L_8BA6		;8c0e
L_8C11:
	dec a			;8c11
	jr nz,L_8C24		;8c12
	ld ix,08d41h		;8c14
	bit 4,l		;8c18
	jp z,L_8BA6		;8c1a
	ld ix,08d52h		;8c1d
	jp L_8BA6		;8c21
L_8C24:
	ld ix,08d63h		;8c24
	bit 4,l		;8c28
	jp z,L_8BA6		;8c2a
	ld ix,08d74h		;8c2d
	jp L_8BA6		;8c31
L_8C34:
	ld hl,00200h		;8c34
	ld (0e141h),hl		;8c37
	ld hl,0e143h		;8c3a
	inc (hl)			;8c3d
	ld a,(hl)			;8c3e
	sub 004h		;8c3f
	ret nz			;8c41
	ld (hl),a			;8c42
	ret			;8c43
L_8C44:
	djnz L_8C70		;8c44
	ld a,(0e003h)		;8c46   ; el contador de cuadros
	and 003h		;8c49
	jp nz,L_8AF9		;8c4b
	ld de,(0e124h)		;8c4e
	ld a,(de)			;8c52
	ld l,a			;8c53
	inc de			;8c54
	ld a,(de)			;8c55
	ld h,a			;8c56
	inc de			;8c57
	ld a,(de)			;8c58
	call 0004dh		;8c59   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;8c5c
	ld (0e124h),de		;8c5d
	call L_8CFF		;8c61
	ld hl,0e126h		;8c64
	dec (hl)			;8c67
	ld b,002h		;8c68
	jp z,L_8CFA		;8c6a
	jp L_8AF9		;8c6d
L_8C70:
	xor a			;8c70
	ld (0e139h),a		;8c71
	ld hl,0e126h		;8c74
	inc (hl)			;8c77
	ld a,(hl)			;8c78
	cp 00fh		;8c79
	jr z,L_8CA6		;8c7b
	ld hl,03923h		;8c7d
	ld (0e124h),hl		;8c80
	ld hl,08e7ch		;8c83
	dec a			;8c86
	jr z,L_8C9C		;8c87
	ld b,a			;8c89
L_8C8A:
	ld de,0001ah		;8c8a
	add hl,de			;8c8d
	push hl			;8c8e
	ld hl,(0e124h)		;8c8f
	ld de,00020h		;8c92
	add hl,de			;8c95
	ld (0e124h),hl		;8c96
	pop hl			;8c99
	djnz L_8C8A		;8c9a
L_8C9C:
	ex de,hl			;8c9c
	ld hl,(0e124h)		;8c9d
	ld bc,0001ah		;8ca0
	jp 0428fh		;8ca3   ; banco 0: copia_a_vram
L_8CA6:
	ld b,040h		;8ca6
	ld a,(0e10eh)		;8ca8
	and a			;8cab
	jr z,L_8CB0		;8cac
	ld b,001h		;8cae
L_8CB0:
	ld a,b			;8cb0
	ld (0e126h),a		;8cb1
	ld hl,00200h		;8cb4
	ld (0e141h),hl		;8cb7
	xor a			;8cba
	ld (0e143h),a		;8cbb
	ld a,(0e092h)		;8cbe   ; la FASE, de 1 a 13
	dec a			;8cc1
	ld b,a			;8cc2
	cp 00eh		;8cc3
	ld (0e121h),a		;8cc5
	jr c,L_8CCF		;8cc8
	ld a,001h		;8cca
	ld (0e139h),a		;8ccc
L_8CCF:
	ld a,b			;8ccf
	ld hl,0917bh		;8cd0
	call 04055h		;8cd3   ; banco 0: dos_por_a_mas_hl
	ld e,(hl)			;8cd6
	inc hl			;8cd7
	ld d,(hl)			;8cd8
	ld (0e122h),de		;8cd9
	ld de,08fe7h		;8cdd
	ld (0e11fh),de		;8ce0
	ld a,b			;8ce4
	and a			;8ce5
	jp nz,L_8CF3		;8ce6
	ld a,050h		;8ce9
	ld (0e004h),a		;8ceb   ; el contador de espera del estado
	ld b,005h		;8cee
	jp L_8CFA		;8cf0
L_8CF3:
	ld hl,0e0b5h		;8cf3
	inc (hl)			;8cf6
	jp L_8AF9		;8cf7
L_8CFA:
	ld hl,0e0b5h		;8cfa
	ld (hl),b			;8cfd
	ret			;8cfe
L_8CFF:
	ld a,(0e012h)		;8cff
	and a			;8d02
	ret nz			;8d03
	ld a,039h		;8d04
	jp 0413ah		;8d06   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS sin identificar  0x8d09..0x91ad  (1188 bytes)
DATA_8D09:
	defb 003h,008h,004h,0e0h,00ah,000h,0feh,0d8h,00fh,000h,000h,0d0h,001h,003h,000h,003h	; 8d09  ................
	defb 0f8h,00ah,005h,000h,0f0h,00fh,000h,0ffh,0e8h,001h,004h,003h,003h,050h,00ah,005h	; 8d19  .............P..
	defb 000h,048h,00fh,008h,00fh,040h,001h,001h,0ffh,038h,001h,003h,003h,005h,068h,00ah	; 8d29  .H...@...8....h.
	defb 006h,000h,060h,00fh,002h,000h,058h,001h,004h,002h,004h,080h,00ah,002h,001h,078h	; 8d39  ..`...X........x
	defb 00fh,0fch,000h,070h,001h,00ch,00eh,088h,001h,004h,003h,005h,0a0h,00ah,003h,000h	; 8d49  ...p............
	defb 098h,00fh,0fch,000h,090h,001h,00ch,00eh,088h,001h,004h,002h,0f6h,0a8h,00fh,003h	; 8d59  ................
	defb 003h,0c0h,006h,008h,001h,0b8h,00ah,004h,0fdh,0b0h,001h,004h,002h,0f7h,0c8h,00fh	; 8d69  ................
	defb 003h,003h,0c0h,006h,008h,001h,0b8h,00ah,004h,0fdh,0b0h,001h,008h,0dch,090h,013h	; 8d79  ................
	defb 090h,0c6h,0e0h,009h,0f4h,090h,02bh,090h,0c7h,0e0h,00ch,00fh,091h,047h,090h,0c8h	; 8d89  ......+......G..
	defb 0e0h,003h,033h,091h,05fh,090h,0c9h,0e0h,009h,03ch,091h,07bh,090h,0cah,0e0h,00ch	; 8d99  ..3._....<.{....
	defb 057h,091h,09bh,090h,0cbh,0e0h,0c9h,038h,028h,029h,033h,023h,02fh,032h,025h,0feh	; 8da9  W......8()3#/2%.
	defb 0e9h,038h,033h,023h,02fh,032h,025h,0ffh,089h,038h,033h,034h,021h,027h,025h,0feh	; 8db9  .83#/2%..834!'%.
	defb 0a9h,038h,02ch,029h,036h,025h,033h,0ffh,02ch,025h,036h,025h,02ch,000h,000h,000h	; 8dc9  .8,)6%3.,%6%,...
	defb 010h,011h,0ffh,02ch,025h,036h,025h,02ch,000h,000h,000h,010h,012h,0ffh,0aah,03ah	; 8dd9  ...,%6%,.......:
	defb 030h,035h,033h,028h,042h,033h,030h,021h,023h,025h,042h,02bh,025h,039h,0ffh,029h	; 8de9  053(B30!#%B+%9.)
	defb 039h,02ch,025h,036h,025h,02ch,000h,033h,025h,02ch,025h,023h,034h,0ffh,01bh,01ch	; 8df9  9,%6%,.3%,%#4...
	defb 0ffh,08dh,039h,02ch,025h,036h,025h,02ch,000h,011h,0ffh,0edh,039h,02ch,025h,036h	; 8e09  ..9,%6%,....9,%6
	defb 025h,02ch,000h,012h,0ffh,0c9h,038h,026h,015h,000h,02bh,025h,039h,000h,023h,02fh	; 8e19  %,....8&..+%9.#/
	defb 02eh,034h,029h,02eh,035h,025h,0ffh,00bh,039h,027h,021h,02dh,025h,000h,000h,02fh	; 8e29  .4).5%..9'!-%../
	defb 036h,025h,032h,0feh,069h,039h,028h,029h,033h,023h,02fh,032h,025h,0feh,089h,039h	; 8e39  6%2.i9()3#/2%..9
	defb 033h,023h,02fh,032h,025h,0ffh,002h,038h,034h,029h,02dh,025h,0feh,00ah,038h,024h	; 8e49  3#/2%..84)-%..8$
	defb 029h,033h,034h,0feh,013h,038h,01bh,01ch,0feh,019h,038h,01dh,0ffh,00ah,038h,000h	; 8e59  )34..8....8...8.
	defb 020h,022h,02fh,02eh,035h,033h,020h,0ffh,00ah,038h,000h,020h,037h,021h,032h,030h	; 8e69   "/.53 ..8. 7!20
	defb 020h,000h,0ffh,044h,045h,046h,047h,048h,049h,04ah,04bh,04ch,043h,04dh,043h,043h	; 8e79   ..DEFGHIJKLCMCC
	defb 04dh,04dh,043h,043h,043h,045h,046h,048h,049h,04ah,045h,043h,0ceh,0c9h,054h,055h	; 8e89  MMCCCEFHIJEC..TU
	defb 041h,041h,041h,041h,041h,041h,041h,041h,060h,061h,042h,042h,042h,062h,063h,042h	; 8e99  AAAAAAAA`aBBBbcB
	defb 042h,042h,042h,064h,065h,066h,0cfh,0cah,056h,041h,041h,041h,041h,041h,041h,041h	; 8ea9  BBBdef..VAAAAAAA
	defb 041h,041h,067h,07ch,042h,042h,042h,068h,069h,042h,042h,042h,042h,06ah,06bh,06ch	; 8eb9  AAg|BBBhiBBBBjkl
	defb 050h,04eh,057h,0cch,0d1h,041h,08eh,08fh,090h,091h,06dh,041h,098h,099h,09ah,042h	; 8ec9  PNW..A....mA...B
	defb 042h,042h,042h,089h,08ah,08bh,07fh,080h,081h,05fh,0d0h,04fh,05eh,0cdh,0d2h,058h	; 8ed9  BBB......_.O^..X
	defb 059h,05ah,05bh,092h,06eh,06fh,097h,07ah,09bh,042h,042h,070h,042h,082h,040h,040h	; 8ee9  YZ[.no.z.BBpB.@@
	defb 040h,083h,084h,07dh,051h,043h,05ch,0a9h,0aah,0abh,041h,041h,041h,093h,094h,095h	; 8ef9  @..}QC\...AAA...
	defb 096h,07bh,09ch,042h,042h,09fh,0a0h,0a1h,0a2h,0a3h,0a4h,0a5h,0a6h,07eh,052h,0cbh	; 8f09  .{.BB........~R.
	defb 05dh,0a8h,041h,071h,042h,072h,073h,074h,075h,076h,077h,078h,09dh,042h,079h,09eh	; 8f19  ].AqBrstuvwx.By.
	defb 085h,086h,087h,08ch,08dh,040h,0a7h,088h,053h,044h,041h,0b3h,0b2h,0b1h,0b0h,0afh	; 8f29  .....@..SDA.....
	defb 05ah,05bh,05ch,05dh,05eh,05fh,094h,095h,096h,097h,042h,042h,08bh,09bh,09ah,099h	; 8f39  Z[\]^_....BB....
	defb 098h,059h,0d3h,0cch,041h,041h,060h,042h,042h,0aeh,061h,062h,063h,064h,065h,066h	; 8f49  .Y..AA`BB.abcdef
	defb 067h,068h,069h,06ah,09fh,09eh,09dh,09ch,040h,040h,08ch,058h,047h,0cdh,041h,06bh	; 8f59  ghij....@@.XG.Ak
	defb 042h,042h,06ch,0adh,06dh,0a9h,0a8h,0a7h,0a6h,0a5h,0a4h,0a3h,0a2h,0a1h,0a0h,08ah	; 8f69  BBl.m...........
	defb 08dh,08eh,040h,040h,08fh,06eh,0d2h,0ceh,041h,06fh,070h,071h,072h,0ach,0abh,0aah	; 8f79  ..@@.n..Aopqr...
	defb 041h,073h,042h,042h,074h,075h,076h,041h,041h,077h,042h,090h,040h,091h,092h,078h	; 8f89  AsBBtuvAAwB.@..x
	defb 0d0h,045h,041h,041h,041h,041h,041h,079h,07ah,07bh,07ch,042h,042h,07dh,041h,041h	; 8f99  .EAAAAAyz{|BB}AA
	defb 041h,07eh,07fh,042h,080h,042h,093h,042h,042h,081h,0d0h,0cfh,057h,041h,041h,041h	; 8fa9  A~.B.B.BB...WAAA
	defb 041h,082h,083h,084h,042h,042h,085h,086h,041h,041h,041h,087h,088h,042h,089h,042h	; 8fb9  A...BB..AAA..B.B
	defb 042h,042h,042h,042h,0d1h,046h,049h,043h,04ah,04bh,043h,04ch,043h,04dh,04eh,04fh	; 8fc9  BBBB.FICJKCLCMNO
	defb 050h,043h,043h,051h,052h,053h,054h,055h,056h,043h,043h,043h,04ch,043h,048h,001h	; 8fd9  PCCQRSTUVCCCLCH.
	defb 000h,070h,00ch,001h,001h,078h,00ch,002h,000h,080h,00ch,002h,000h,088h,00ch,003h	; 8fe9  .p...x..........
	defb 000h,090h,00ch,003h,000h,098h,00ch,004h,000h,0a0h,00ch,004h,000h,0a8h,00ch,005h	; 8ff9  ................
	defb 000h,0b0h,00ch,006h,000h,0b8h,00ch,006h,000h,0c0h,00ch,006h,002h,0c8h,00ch,007h	; 9009  ................
	defb 000h,0d8h,00ch,008h,000h,0e0h,00ch,008h,000h,0e8h,00ch,008h,000h,0a0h,014h,009h	; 9019  ................
	defb 000h,0a8h,014h,009h,003h,0b0h,014h,00ah,000h,0b8h,014h,00ah,000h,0f0h,00ch,00ah	; 9029  ................
	defb 000h,0f8h,00ch,00bh,000h,000h,00dh,00bh,000h,008h,00dh,00ch,000h,010h,00dh,00ch	; 9039  ................
	defb 000h,018h,00dh,00dh,000h,020h,00dh,00dh,004h,028h,00dh,00eh,000h,038h,00dh,00eh	; 9049  ..... ...(...8..
	defb 000h,0c0h,014h,00fh,000h,0c8h,014h,00fh,005h,0d0h,014h,00fh,000h,0d8h,014h,010h	; 9059  ................
	defb 000h,0e0h,014h,011h,000h,0e8h,014h,011h,000h,0f0h,014h,011h,000h,0f8h,014h,012h	; 9069  ................
	defb 000h,000h,015h,012h,006h,008h,015h,013h,000h,010h,015h,013h,000h,018h,015h,014h	; 9079  ................
	defb 000h,020h,015h,014h,000h,028h,015h,014h,000h,028h,015h,014h,000h,030h,015h,015h	; 9089  . ...(...(...0..
	defb 000h,038h,015h,015h,000h,040h,015h,016h,000h,048h,015h,016h,000h,050h,015h,016h	; 9099  .8...@...H...P..
	defb 000h,058h,015h,016h,000h,060h,015h,017h,000h,068h,015h,017h,000h,070h,015h,017h	; 90a9  .X...`...h...p..
	defb 000h,078h,015h,017h,000h,080h,015h,017h,000h,088h,015h,018h,000h,090h,015h,018h	; 90b9  .x..............
	defb 000h,098h,015h,018h,000h,040h,00dh,018h,000h,048h,00dh,018h,000h,050h,00dh,018h	; 90c9  .....@...H...P..
	defb 000h,058h,00dh,089h,039h,0ach,069h,039h,0adh,06ah,039h,0aeh,06bh,039h,0afh,06ch	; 90d9  .X..9.i9.j9.k9.l
	defb 039h,0b0h,06dh,039h,0b1h,08dh,039h,0b2h,08eh,039h,0b3h,08fh,039h,0b4h,06fh,039h	; 90e9  9.m9..9..9..9.o9
	defb 0b5h,070h,039h,0b6h,071h,039h,0b7h,091h,039h,0b8h,0b1h,039h,0b9h,0d1h,039h,0bah	; 90f9  .p9.q9..9..9..9.
	defb 0f1h,039h,0bbh,011h,03ah,0b4h,012h,03ah,0b5h,0f2h,039h,0bch,0d2h,039h,0bdh,0b2h	; 9109  .9..:..:..9..9..
	defb 039h,0beh,092h,039h,0bfh,093h,039h,0c0h,094h,039h,0c1h,095h,039h,0c2h,096h,039h	; 9119  9..9..9..9..9..9
	defb 0c3h,097h,039h,0c4h,0b7h,039h,0c5h,0d7h,039h,0c6h,0d9h,039h,0c7h,0f9h,039h,0c8h	; 9129  ..9..9..9..9..9.
	defb 019h,03ah,0b6h,018h,03ah,0b7h,038h,03ah,0b8h,058h,03ah,0b9h,078h,03ah,0bah,077h	; 9139  .:..:.8:.X:.x:.w
	defb 03ah,0bbh,076h,03ah,0bch,075h,03ah,0bdh,074h,03ah,0beh,054h,03ah,0bfh,053h,03ah	; 9149  :.v:.u:.t:.T:.S:
	defb 0c0h,073h,03ah,0c1h,093h,03ah,0c2h,092h,03ah,0c3h,091h,03ah,0c4h,090h,03ah,0c5h	; 9159  .s:..:..:..:..:.
	defb 08fh,03ah,0c6h,08eh,03ah,0c7h,08dh,03ah,0c8h,08ch,03ah,0c9h,06ch,03ah,0cah,04ch	; 9169  .:..:..:..:.l:.L
	defb 03ah,0cbh,033h,052h,048h,052h,056h,052h,04bh,070h,069h,07ah,063h,062h,07bh,052h	; 9179  :.3RHRVRKpizcb{R
	defb 08bh,064h,07fh,083h,091h,083h,099h,062h,0a9h,062h,0b9h,062h,0cah,062h,0cfh,08ah	; 9189  .d.....b.b.b.b..
	defb 0c3h,08ah,0b3h,092h,0abh,092h,08fh,09ah,07fh,09ah,069h,09ah,057h,082h,035h,096h	; 9199  ..........i.W.5.
	defb 030h,08ah,03dh,070h	; 91a9

; ======================================================================
; CODIGO 0x91ad..0x91bc  (15 bytes)
; ======================================================================


L_91AD:
	ld a,(0e0a1h)		;91ad   ; el DECORADO, de 0 a 9
	sub 009h		;91b0
	jr z,L_91B9		;91b2
	ld a,(0e007h)		;91b4   ; el estado de los mandos del cuadro anterior
	and 003h		;91b7
L_91B9:
	call 04060h		;91b9   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0x91bc..0x91c4  (8 bytes)
DATA_91BC:
	defb 0f6h,091h,0c4h,091h,0e2h,091h,0f6h,091h	; 91bc  ........

; ======================================================================
; CODIGO 0x91c4..0x935f  (411 bytes)
; ======================================================================


L_91C4:
	ld hl,0e202h		;91c4
	ld (hl),000h		;91c7
	dec l			;91c9
	inc (hl)			;91ca
	ld a,(hl)			;91cb
	sub 006h		;91cc
	ret nz			;91ce
	ld (hl),a			;91cf
	ld a,(0e160h)		;91d0
	and a			;91d3
	ld c,007h		;91d4
	jr z,L_91DA		;91d6
	ld c,005h		;91d8
L_91DA:
	ld hl,0e4c0h		;91da
	ld a,(hl)			;91dd
	cp c			;91de
	ret c			;91df
	dec (hl)			;91e0
	ret			;91e1
L_91E2:
	ld hl,0e201h		;91e2
	ld (hl),000h		;91e5
	inc l			;91e7
	inc (hl)			;91e8
	ld a,(hl)			;91e9
	sub 004h		;91ea
	ret nz			;91ec
	ld (hl),a			;91ed
	ld hl,0e4c0h		;91ee
	ld a,(hl)			;91f1
	cp 019h		;91f2
	ret nc			;91f4
	inc (hl)			;91f5
L_91F6:
	ret			;91f6
L_91F7:
	ld hl,0e004h		;91f7
	bit 3,(hl)		;91fa
	ld c,0ffh		;91fc
	jr nz,L_9201		;91fe
	inc c			;9200
L_9201:
	ld hl,0398ah		;9201
	ld de,039eah		;9204
	ld a,(0e082h)		;9207   ; uno o dos jugadores
	or a			;920a
	jr z,L_920E		;920b
	ex de,hl			;920d
L_920E:
	push de			;920e
	call L_9215		;920f
	pop hl			;9212
	ld c,000h		;9213
L_9215:
	ld de,08e07h		;9215
	jp 042c1h		;9218   ; banco 0: pinta_guion_bucle
L_921B:
	ld a,(0e0a2h)		;921b   ; el modo en el que esta el juego
	cp 002h		;921e
	ret nc			;9220
	ld a,(0e0a4h)		;9221
	and a			;9224
	jr nz,L_928A		;9225
	ld a,(0e003h)		;9227   ; el contador de cuadros
	and 01fh		;922a
	ret nz			;922c
	ld hl,0e08bh		;922d
	ld a,(hl)			;9230
	sub 001h		;9231
	daa			;9233
	ld (hl),a			;9234
	inc l			;9235
	ld a,(hl)			;9236
	sbc a,000h		;9237
	daa			;9239
	ld (hl),a			;923a
	ld hl,(0e08bh)		;923b   ; el largo de la fase
	ld a,h			;923e
	and a			;923f
	jr nz,L_9250		;9240
	ld a,l			;9242
	cp 015h		;9243
	jr nc,L_9250		;9245
	and 001h		;9247
	jr nz,L_9250		;9249
	ld a,019h		;924b
	call z,0413ah		;924d
L_9250:
	ld a,l			;9250
	or h			;9251
	ret nz			;9252
	ld a,(0e0a2h)		;9253   ; el modo en el que esta el juego
	dec a			;9256
	jr z,L_9284		;9257
	xor a			;9259
	ld (0e097h),a		;925a   ; la bandera de que la fase se ha acabado
	ld a,(0e203h)		;925d   ; por donde va la rotacion de los sprites
	cp 004h		;9260
	ld c,016h		;9262
	jr z,L_9277		;9264
	cp 005h		;9266
	jr z,L_9277		;9268
	cp 006h		;926a
	jr z,L_9277		;926c
	cp 007h		;926e
	jr z,L_9277		;9270
	cp 008h		;9272
	jr z,L_9277		;9274
	dec c			;9276
L_9277:
	ld a,c			;9277
	ld (0e203h),a		;9278   ; por donde va la rotacion de los sprites
	xor a			;927b
	ld (0e21dh),a		;927c
	ld a,08ch		;927f
	jp 0413ah		;9281   ; banco 0: pide_sonido_si_esta_activo
L_9284:
	ld a,001h		;9284
	ld (0e0a4h),a		;9286
	ret			;9289
L_928A:
	ld hl,0e440h		;928a
	ld b,005h		;928d
L_928F:
	ld a,(hl)			;928f
	and a			;9290
	ret nz			;9291
	ld a,010h		;9292
	call 04056h		;9294   ; banco 0: a_mas_hl
	djnz L_928F		;9297
	ld a,004h		;9299
	ld (0e096h),a		;929b   ; los avisos que deja el cuadro
	ret			;929e
L_929F:
	ld a,(0e1f1h)		;929f
	and a			;92a2
	ret z			;92a3
	ld hl,(0e1f2h)		;92a4
	dec hl			;92a7
	ld (0e1f2h),hl		;92a8
	ld a,l			;92ab
	or h			;92ac
	jr z,L_92E3		;92ad
	ld de,00080h		;92af
	rst 20h			;92b2
	jr nc,L_92CE		;92b3
	ld de,00004h		;92b5
	rst 20h			;92b8
	jr c,L_92CE		;92b9
	ld a,(0e003h)		;92bb   ; el contador de cuadros
	and 00fh		;92be
	jr nz,L_92CE		;92c0
	ld a,(0e0a5h)		;92c2   ; por que vuelta de la fase va
	cp 002h		;92c5
	jr nc,L_92CE		;92c7
	ld a,01bh		;92c9
	call 0413ah		;92cb   ; banco 0: pide_sonido_si_esta_activo
L_92CE:
	ld a,l			;92ce
	and 00fh		;92cf
	ld c,a			;92d1
	ld hl,0ee83h		;92d2
	ld b,004h		;92d5
L_92D7:
	ld a,(hl)			;92d7
	dec a			;92d8
	jr nz,L_92DC		;92d9
	ld (hl),c			;92db
L_92DC:
	inc l			;92dc
	inc l			;92dd
	inc l			;92de
	inc l			;92df
	djnz L_92D7		;92e0
	ret			;92e2
L_92E3:
	ld (0e1f1h),a		;92e3
	ld (0e1f2h),a		;92e6
	jp L_9493		;92e9
L_92EC:
	ld a,(0e0a1h)		;92ec   ; el DECORADO, de 0 a 9
	cp 001h		;92ef
	ret z			;92f1
	cp 003h		;92f2
	ret z			;92f4
	cp 005h		;92f5
	ret nc			;92f7
	ld bc,0001fh		;92f8
	ld a,(0e0a6h)		;92fb
	and a			;92fe
	jr z,L_9322		;92ff
	dec a			;9301
	jr z,L_9314		;9302
	ld a,(0e510h)		;9304
	ld hl,0e511h		;9307
	ld de,0e510h		;930a
	ldir		;930d
	ld (0e52fh),a		;930f
	jr L_9322		;9312
L_9314:
	ld a,(0e52fh)		;9314
	ld hl,0e52eh		;9317
	ld de,0e52fh		;931a
	lddr		;931d
	ld (0e510h),a		;931f
L_9322:
	jp 061f3h		;9322
L_9325:
	ld hl,02000h		;9325
	ld bc,00080h		;9328
	xor a			;932b
	call 04293h		;932c   ; banco 0: llena_los_tres_tercios
	ld hl,00000h		;932f
	ld de,00008h		;9332
	ld b,010h		;9335
L_9337:
	push bc			;9337
	ld bc,00008h		;9338
	push hl			;933b
	call 04293h		;933c   ; banco 0: llena_los_tres_tercios
	pop hl			;933f
	add hl,de			;9340
	inc a			;9341
	pop bc			;9342
	djnz L_9337		;9343
	ret			;9345
L_9346:
	ld hl,0e086h		;9346
	ld bc,00e7ah		;9349
	ld d,h			;934c
	ld e,l			;934d
	inc e			;934e
	ld (hl),000h		;934f
	ldir		;9351
	ld hl,0935fh		;9353
	ld de,0e090h		;9356
	ld bc,00008h		;9359
	ldir		;935c
	ret			;935e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x935f..0x9367  (8 bytes)
DATA_935F:
	defb 002h,001h,001h,001h,000h,005h,000h,001h	; 935f  ........

; ======================================================================
; CODIGO 0x9367..0x94a0  (313 bytes)
; ======================================================================


L_9367:
	ld c,000h		;9367
L_9369:
	ld a,(0e002h)		;9369
	add a,a			;936c
	ret p			;936d
	ld hl,0e086h		;936e
	ld a,(hl)			;9371
	add a,e			;9372
	daa			;9373
	ld (hl),a			;9374
	inc l			;9375
	ld a,(hl)			;9376
	adc a,d			;9377
	daa			;9378
	ld (hl),a			;9379
	inc hl			;937a
	ld a,(hl)			;937b
	adc a,c			;937c
	daa			;937d
	ld (hl),a			;937e
	jr nc,L_938B		;937f
	ld hl,09999h		;9381
	ld (0e083h),hl		;9384   ; los datos del juego
	ld (0e084h),hl		;9387
	ret			;938a
L_938B:
	ex de,hl			;938b
	ld hl,0e095h		;938c
	cp (hl)			;938f
	jr c,L_93AC		;9390
	ld a,(hl)			;9392
	add a,005h		;9393
	daa			;9395
	jr nc,L_939A		;9396
	ld a,0ffh		;9398
L_939A:
	ld (hl),a			;939a
	ld hl,0e090h		;939b
	ld a,001h		;939e
	add a,(hl)			;93a0
	daa			;93a1
	ld (hl),a			;93a2
	jr nc,L_93A7		;93a3
	ld (hl),099h		;93a5
L_93A7:
	ld a,037h		;93a7
	call 0413ah		;93a9   ; banco 0: pide_sonido_si_esta_activo
L_93AC:
	ex de,hl			;93ac
	ld b,003h		;93ad
	ld de,0e085h		;93af
L_93B2:
	ld a,(de)			;93b2
	sub (hl)			;93b3
	jr c,L_93BB		;93b4
	ret nz			;93b6
	dec l			;93b7
	dec e			;93b8
	djnz L_93B2		;93b9
L_93BB:
	ld bc,00003h		;93bb
	ld e,085h		;93be
	ld l,088h		;93c0
	lddr		;93c2
	ret			;93c4
L_93C5:
	call L_93E7		;93c5
	call L_9409		;93c8
	call L_93FB		;93cb
	ld de,08dafh		;93ce
	call 042bch		;93d1   ; banco 0: pinta_guion_con_mascara
	ld de,0e085h		;93d4
	ld hl,038d1h		;93d7
	call L_93E3		;93da
	ld hl,038f1h		;93dd
	ld de,0e088h		;93e0
L_93E3:
	ld b,003h		;93e3
	jr L_9417		;93e5
L_93E7:
	ld a,(0e08fh)		;93e7
	and a			;93ea
	ld de,08dd1h		;93eb
	jr z,L_93F3		;93ee
	ld de,08ddch		;93f0
L_93F3:
	ld hl,03869h		;93f3
	ld c,0ffh		;93f6
	jp 042c1h		;93f8   ; banco 0: pinta_guion_bucle
L_93FB:
	ld de,08dc9h		;93fb
	call 042bch		;93fe   ; banco 0: pinta_guion_con_mascara
	ld hl,038b1h		;9401
	ld de,0e090h		;9404
	jr L_9415		;9407
L_9409:
	ld de,08dc1h		;9409
	call 042bch		;940c   ; banco 0: pinta_guion_con_mascara
	ld hl,03891h		;940f
	ld de,0e091h		;9412
L_9415:
	ld b,001h		;9415
L_9417:
	ld a,(de)			;9417
	rra			;9418
	rra			;9419
	rra			;941a
	rra			;941b
	and 00fh		;941c
	add a,010h		;941e
	call 0004dh		;9420   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9423
L_9424:
	ld a,(de)			;9424
	and 00fh		;9425
	add a,010h		;9427
	call 0004dh		;9429   ; BIOS WRTVRM - Writes data in VRAM
	dec e			;942c
	inc hl			;942d
	djnz L_9417		;942e
	ret			;9430
L_9431:
	ld de,08e4fh		;9431
	call 042bch		;9434   ; banco 0: pinta_guion_con_mascara
	call L_9469		;9437
	call L_9471		;943a
	jp L_947B		;943d
L_9440:
	ld a,(0e0a2h)		;9440   ; el modo en el que esta el juego
	and a			;9443
	ret z			;9444
	ld a,(0e0a4h)		;9445
	and a			;9448
	jr z,L_944F		;9449
	ld c,000h		;944b
	jr L_9453		;944d
L_944F:
	ld a,(0e003h)		;944f   ; el contador de cuadros
	ld c,a			;9452
L_9453:
	ld a,(0e0a2h)		;9453   ; el modo en el que esta el juego
	dec a			;9456
	ld de,08e66h		;9457
	jr z,L_945F		;945a
	ld de,08e71h		;945c
L_945F:
	bit 3,c		;945f
	ld c,0ffh		;9461
	jr z,L_9466		;9463
	inc c			;9465
L_9466:
	jp 042beh		;9466   ; banco 0: pinta_guion_lee_destino
L_9469:
	ld hl,03806h		;9469
	ld de,0e08ch		;946c
	jr L_9481		;946f
L_9471:
	ld hl,0380eh		;9471
	ld de,0e08eh		;9474
	ld b,002h		;9477
	jr L_9417		;9479
L_947B:
	ld hl,03815h		;947b
	ld de,0e08ah		;947e
L_9481:
	ld b,002h		;9481
	jr L_9424		;9483
L_9485:
	ld a,(0e203h)		;9485   ; por donde va la rotacion de los sprites
	sub 00fh		;9488
	ret nz			;948a
	ld (0e1f0h),a		;948b
	ld l,a			;948e
	ld h,a			;948f
	ld (0e1f4h),hl		;9490
L_9493:
	ld a,(0e0a1h)		;9493   ; el DECORADO, de 0 a 9
	ld hl,094a0h		;9496
	call 04056h		;9499   ; banco 0: a_mas_hl
	ld a,(hl)			;949c
	jp 0413ah		;949d   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; DATOS sin identificar  0x94a0..0x94aa  (10 bytes)
DATA_94A0:
	defb 03bh,03eh,041h,044h,047h,04ah,04dh,050h,053h,05fh	; 94a0  ;>ADGJMPS_

; ======================================================================
; CODIGO 0x94aa..0x965f  (437 bytes)
; ======================================================================


L_94AA:
	ld a,(0e0e1h)		;94aa
	and a			;94ad
	jr z,L_94D1		;94ae
	ld a,(0e003h)		;94b0   ; el contador de cuadros
	and 01fh		;94b3
	ret nz			;94b5
	ld hl,0e08ch		;94b6
	ld a,(hl)			;94b9
	and a			;94ba
	jr z,L_94CC		;94bb
	dec (hl)			;94bd
	call L_9469		;94be
	ld de,02000h		;94c1
	call L_9367		;94c4
	ld a,02dh		;94c7
	jp 0413ah		;94c9   ; banco 0: pide_sonido_si_esta_activo
L_94CC:
	ld hl,0e0e1h		;94cc
	dec (hl)			;94cf
	ret			;94d0
L_94D1:
	ld hl,(0e08bh)		;94d1   ; el largo de la fase
	ld a,h			;94d4
	or l			;94d5
	jr z,L_9500		;94d6
	ld a,(0e003h)		;94d8   ; el contador de cuadros
	and 003h		;94db
	jr nz,L_94E6		;94dd
	push af			;94df
	ld a,02eh		;94e0
	call 0413ah		;94e2   ; banco 0: pide_sonido_si_esta_activo
	pop af			;94e5
L_94E6:
	rra			;94e6
	ret c			;94e7
	ld a,l			;94e8
	sub 001h		;94e9
	daa			;94eb
	ld l,a			;94ec
	jr nc,L_94F4		;94ed
	ld a,h			;94ef
	sub 001h		;94f0
	daa			;94f2
	ld h,a			;94f3
L_94F4:
	ld (0e08bh),hl		;94f4   ; el largo de la fase
	ld de,00020h		;94f7
	call L_9367		;94fa
	jp L_9469		;94fd
L_9500:
	xor a			;9500
	ld (0e096h),a		;9501   ; los avisos que deja el cuadro
	ret			;9504
L_9505:
	call L_9522		;9505
	ld a,(0e006h)		;9508   ; las teclas recien pulsadas
	ld c,a			;950b
	and 001h		;950c
	jr nz,L_9514		;950e
	ld a,c			;9510
	and 002h		;9511
	ret z			;9513
L_9514:
	ld a,(0e082h)		;9514   ; uno o dos jugadores
	cpl			;9517
	and 001h		;9518
	ld (0e082h),a		;951a   ; uno o dos jugadores
	ld a,023h		;951d
	jp 0413ah		;951f   ; banco 0: pide_sonido_si_esta_activo
L_9522:
	ld a,002h		;9522
	call 00141h		;9524   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,000h		;9527
	rla			;9529
	rla			;952a
	ld e,000h		;952b
	jr c,L_9530		;952d
	inc e			;952f
L_9530:
	ld a,(0e0e4h)		;9530
	ld b,a			;9533
	ld a,e			;9534
	ld (0e0e4h),a		;9535
	xor b			;9538
	jr z,L_9540		;9539
	ld a,b			;953b
	and a			;953c
	jp z,L_9626		;953d
L_9540:
	ld a,003h		;9540
	call 00141h		;9542   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,001h		;9545
	and 040h		;9547
	ld e,000h		;9549
	jr nz,L_954E		;954b
	inc e			;954d
L_954E:
	ld a,(0e0e5h)		;954e
	ld b,a			;9551
	ld a,e			;9552
	ld (0e0e5h),a		;9553
	xor b			;9556
	jr z,L_955E		;9557
	ld a,b			;9559
	and a			;955a
	jp z,L_9626		;955b
L_955E:
	ld a,004h		;955e
	call 00141h		;9560   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,002h		;9563
	rra			;9565
	ld e,000h		;9566
	jr c,L_956B		;9568
	inc e			;956a
L_956B:
	ld a,(0e0e7h)		;956b
	ld b,a			;956e
	ld a,e			;956f
	ld (0e0e7h),a		;9570
	xor b			;9573
	jr z,L_957B		;9574
	ld a,b			;9576
	and a			;9577
	jp z,L_9626		;9578
L_957B:
	ld a,004h		;957b
	call 00141h		;957d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,003h		;9580
	and 004h		;9582
	ld e,000h		;9584
	jr nz,L_9589		;9586
	inc e			;9588
L_9589:
	ld a,(0e0eah)		;9589
	ld b,a			;958c
	ld a,e			;958d
	ld (0e0eah),a		;958e
	xor b			;9591
	jr z,L_9599		;9592
	ld a,b			;9594
	and a			;9595
	jp z,L_9626		;9596
L_9599:
	ld a,004h		;9599
	call 00141h		;959b   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,004h		;959e
	and 008h		;95a0
	ld e,000h		;95a2
	jr nz,L_95A7		;95a4
	inc e			;95a6
L_95A7:
	ld a,(0e0ebh)		;95a7
	ld b,a			;95aa
	ld a,e			;95ab
	ld (0e0ebh),a		;95ac
	xor b			;95af
	jr z,L_95B6		;95b0
	ld a,b			;95b2
	and a			;95b3
	jr z,L_9626		;95b4
L_95B6:
	ld a,004h		;95b6
	call 00141h		;95b8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,005h		;95bb
	and 010h		;95bd
	ld e,000h		;95bf
	jr nz,L_95C4		;95c1
	inc e			;95c3
L_95C4:
	ld a,(0e0e6h)		;95c4
	ld b,a			;95c7
	ld a,e			;95c8
	ld (0e0e6h),a		;95c9
	xor b			;95cc
	jr z,L_95D3		;95cd
	ld a,b			;95cf
	and a			;95d0
	jr z,L_9626		;95d1
L_95D3:
	ld a,004h		;95d3
	call 00141h		;95d5   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,006h		;95d8
	rla			;95da
	ld e,000h		;95db
	jr c,L_95E0		;95dd
	inc e			;95df
L_95E0:
	ld a,(0e0ech)		;95e0
	ld b,a			;95e3
	ld a,e			;95e4
	ld (0e0ech),a		;95e5
	xor b			;95e8
	jr z,L_95EF		;95e9
	ld a,b			;95eb
	and a			;95ec
	jr z,L_9626		;95ed
L_95EF:
	ld a,005h		;95ef
	call 00141h		;95f1   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,007h		;95f4
	and 004h		;95f6
	ld e,000h		;95f8
	jr nz,L_95FD		;95fa
	inc e			;95fc
L_95FD:
	ld a,(0e0e9h)		;95fd
	ld b,a			;9600
	ld a,e			;9601
	ld (0e0e9h),a		;9602
	xor b			;9605
	jr z,L_960C		;9606
	ld a,b			;9608
	and a			;9609
	jr z,L_9626		;960a
L_960C:
	ld a,005h		;960c
	call 00141h		;960e   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,008h		;9611
	rla			;9613
	ld e,000h		;9614
	jr c,L_9619		;9616
	inc e			;9618
L_9619:
	ld a,(0e0e8h)		;9619
	ld b,a			;961c
	ld a,e			;961d
	ld (0e0e8h),a		;961e
	xor b			;9621
	ret z			;9622
	ld a,b			;9623
	and a			;9624
	ret nz			;9625
L_9626:
	ld a,c			;9626
	ld de,0f0f8h		;9627
	ld hl,0f0f9h		;962a
	ld bc,00005h		;962d
	ldir		;9630
	ld (de),a			;9632
	ret			;9633
L_9634:
	ld hl,0f0f8h		;9634
	ld de,0965fh		;9637
	ld b,006h		;963a
L_963C:
	ld a,(de)			;963c
	cp (hl)			;963d
	jr nz,L_964A		;963e
	inc hl			;9640
	inc de			;9641
	djnz L_963C		;9642
	ld a,0feh		;9644
	ld (0f0f7h),a		;9646
	ret			;9649
L_964A:
	ld hl,0f0f8h		;964a
	ld de,09665h		;964d
	ld b,006h		;9650
L_9652:
	ld a,(de)			;9652
	cp (hl)			;9653
	ret nz			;9654
	inc hl			;9655
	inc de			;9656
	djnz L_9652		;9657
	ld a,0ffh		;9659
	ld (0f0f7h),a		;965b
	ret			;965e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x965f..0x966b  (12 bytes)
DATA_965F:
	defb 004h,005h,006h,001h,002h,005h,002h,000h,008h,007h,003h,001h	; 965f  ............

; ======================================================================
; CODIGO 0x966b..0x9693  (40 bytes)
; ======================================================================


L_966B:
	call 04cd1h		;966b
	call 04d7fh		;966e
	call 04e1ah		;9671
	call 04eb6h		;9674
	call 04f5bh		;9677
	call 04fach		;967a
	call 0502dh		;967d
	call 050aah		;9680
	call 05127h		;9683
	jp 05166h		;9686
L_9689:
	call 05b1fh		;9689
	ld a,(0e092h)		;968c   ; la FASE, de 1 a 13
	dec a			;968f
	call 04060h		;9690   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9693..0x96c3  (48 bytes)
DATA_9693:
	defb 0c3h,096h,0c3h,096h,0c3h,096h,0c3h,096h,0c9h,096h,0d2h,096h,0c3h,096h,0c4h,096h	; 9693  ................
	defb 0d2h,096h,0c9h,096h,0c9h,096h,0d2h,096h,0ebh,096h,0d2h,096h,0d7h,096h,0dfh,096h	; 96a3  ................
	defb 0e5h,096h,0ebh,096h,0c9h,096h,0f0h,096h,0d7h,096h,0f0h,096h,0c9h,096h,0d7h,096h	; 96b3  ................

; ======================================================================
; CODIGO 0x96c3..0x96ff  (60 bytes)
; ======================================================================


L_96C3:
	ret			;96c3
L_96C4:
	call 05a74h		;96c4
	jr L_96F6		;96c7
L_96C9:
	call 059c9h		;96c9
	call 05a74h		;96cc
	jp 05ae6h		;96cf
L_96D2:
	call 05990h		;96d2
	jr L_96DA		;96d5
L_96D7:
	call 05b58h		;96d7
L_96DA:
	call 05a02h		;96da
	jr L_96F6		;96dd
L_96DF:
	call 05990h		;96df
	jp 05a74h		;96e2
L_96E5:
	call 05a3bh		;96e5
	jp 05ae6h		;96e8
L_96EB:
	call 05b58h		;96eb
	jr L_96F3		;96ee
L_96F0:
	call 05990h		;96f0
L_96F3:
	call 05a3bh		;96f3
L_96F6:
	jp 05aadh		;96f6
L_96F9:
	ld a,(0e203h)		;96f9   ; por donde va la rotacion de los sprites
	call 04060h		;96fc   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS sin identificar  0x96ff..0x9737  (56 bytes)
DATA_96FF:
	defb 037h,097h,09dh,097h,009h,098h,0b0h,098h,061h,099h,0e0h,099h,063h,09ah,0dbh,09ah	; 96ff  7.......a...c...
	defb 074h,09bh,0f2h,09bh,080h,09ch,058h,09dh,069h,09dh,0bah,09dh,01eh,09eh,0adh,09eh	; 970f  t.....X.i.......
	defb 080h,09fh,0c9h,09fh,019h,0a0h,03bh,0a0h,083h,0a0h,08ah,0a0h,08fh,0a1h,011h,0a2h	; 971f  ......;.........
	defb 0beh,0a5h,0fdh,0a6h,0b3h,0a7h,0c8h,0a7h	; 972f  ........

; ======================================================================
; CODIGO 0x9737..0x97ff  (200 bytes)
; ======================================================================


L_9737:
	call 0a84bh		;9737
	ld a,(0e0a5h)		;973a   ; por que vuelta de la fase va
	cp 002h		;973d
	jr z,L_9773		;973f
	ld a,(0e0a1h)		;9741   ; el DECORADO, de 0 a 9
	cp 009h		;9744
	jr z,L_9773		;9746
	ld a,(0e006h)		;9748   ; las teclas recien pulsadas
	and 010h		;974b
	jr z,L_9773		;974d
	ld a,0ffh		;974f
	ld (0e208h),a		;9751
	ld a,001h		;9754
	ld (0e207h),a		;9756
	ld a,(0e209h)		;9759
	ld (0e20ah),a		;975c
	ld a,(0e161h)		;975f
	and a			;9762
	ld a,001h		;9763
	ld b,003h		;9765
	jr z,L_976C		;9767
	inc a			;9769
	ld b,004h		;976a
L_976C:
	ld (0e203h),a		;976c   ; por donde va la rotacion de los sprites
	ld a,b			;976f
	jp 04145h		;9770   ; banco 0: pide_sonido
L_9773:
	ld a,(0e0a1h)		;9773   ; el DECORADO, de 0 a 9
	cp 009h		;9776
	jr z,L_9780		;9778
	ld a,(0e209h)		;977a
	call 0a87ah		;977d
L_9780:
	call 0a8dbh		;9780
	ld hl,0e206h		;9783
	ld a,(0e003h)		;9786   ; el contador de cuadros
	and 007h		;9789
	jr nz,L_978E		;978b
	inc (hl)			;978d
L_978E:
	ld a,(hl)			;978e
	rra			;978f
	ld c,000h		;9790
	jr nc,L_9799		;9792
	inc c			;9794
	rra			;9795
	jr nc,L_9799		;9796
	inc c			;9798
L_9799:
	ld a,c			;9799
	jp 0a8f5h		;979a
L_979D:
	ld hl,0e16fh		;979d
	bit 0,(hl)		;97a0
	ld a,(0e20ah)		;97a2
	jr z,L_97AD		;97a5
	call 0a84bh		;97a7
	ld a,(0e209h)		;97aa
L_97AD:
	call 0a87ah		;97ad
	ld a,(0e003h)		;97b0   ; el contador de cuadros
	and 003h		;97b3
	jr nz,L_97F0		;97b5
	ld a,(0e207h)		;97b7
	dec a			;97ba
	jr nz,L_97CD		;97bb
	ld hl,0e208h		;97bd
	inc (hl)			;97c0
	ld a,(hl)			;97c1
	cp 005h		;97c2
	jr nz,L_97E4		;97c4
	dec (hl)			;97c6
	ld hl,0e207h		;97c7
	inc (hl)			;97ca
	jr L_97F0		;97cb
L_97CD:
	ld hl,0e208h		;97cd
	inc (hl)			;97d0
	ld a,(hl)			;97d1
	cp 00ah		;97d2
	jr nz,L_97E4		;97d4
	xor a			;97d6
	ld (hl),a			;97d7
	ld (0e207h),a		;97d8
	ld (0e203h),a		;97db   ; por donde va la rotacion de los sprites
	ld (0e20ah),a		;97de
	jp 0bbd6h		;97e1
L_97E4:
	ld hl,097ffh		;97e4
	call 04056h		;97e7   ; banco 0: a_mas_hl
	ld a,(hl)			;97ea
	ld hl,0e204h		;97eb
	add a,(hl)			;97ee
	ld (hl),a			;97ef
L_97F0:
	call 0a8dbh		;97f0
	ld a,(0e208h)		;97f3
	rra			;97f6
	ld a,003h		;97f7
	jr c,L_97FC		;97f9
	inc a			;97fb
L_97FC:
	jp 0a8f5h		;97fc

; ----------------------------------------------------------------------
; DATOS sin identificar  0x97ff..0x9809  (10 bytes)
DATA_97FF:
	defb 0fch,0fdh,0feh,0ffh,0ffh,001h,001h,002h,003h,004h	; 97ff  ..........

; ======================================================================
; CODIGO 0x9809..0x9896  (141 bytes)
; ======================================================================


L_9809:
	ld hl,0e16fh		;9809
	bit 0,(hl)		;980c
	ld a,(0e20ah)		;980e
	jr z,L_9819		;9811
	call 0a84bh		;9813
	ld a,(0e209h)		;9816
L_9819:
	call 0a87ah		;9819
	ld a,(0e207h)		;981c
	dec a			;981f
	jr nz,L_985D		;9820
	ld a,(0e208h)		;9822
	cp 004h		;9825
	jr c,L_9845		;9827
	cp 0ffh		;9829
	jr z,L_9845		;982b
	ld a,(0e007h)		;982d   ; el estado de los mandos del cuadro anterior
	and 010h		;9830
	jr nz,L_9845		;9832
	ld a,(0e208h)		;9834
	sub 004h		;9837
	ld hl,09896h		;9839
	call 04056h		;983c   ; banco 0: a_mas_hl
	ld a,(hl)			;983f
	ld (0e208h),a		;9840
	jr L_9857		;9843
L_9845:
	ld a,(0e003h)		;9845   ; el contador de cuadros
	and 003h		;9848
	jr nz,L_9887		;984a
	ld hl,0e208h		;984c
	inc (hl)			;984f
	ld a,(hl)			;9850
	cp 00ah		;9851
	jr nz,L_987B		;9853
	ld (hl),009h		;9855
L_9857:
	ld hl,0e207h		;9857
	inc (hl)			;985a
	jr L_9887		;985b
L_985D:
	ld a,(0e003h)		;985d   ; el contador de cuadros
	and 003h		;9860
	jr nz,L_9887		;9862
	ld hl,0e208h		;9864
	inc (hl)			;9867
	ld a,(hl)			;9868
	cp 014h		;9869
	jr nz,L_987B		;986b
	xor a			;986d
	ld (hl),a			;986e
	ld (0e207h),a		;986f
	ld (0e203h),a		;9872   ; por donde va la rotacion de los sprites
	ld (0e20ah),a		;9875
	jp 0bbd6h		;9878
L_987B:
	ld hl,0989ch		;987b
	call 04056h		;987e   ; banco 0: a_mas_hl
	ld a,(hl)			;9881
	ld hl,0e204h		;9882
	add a,(hl)			;9885
	ld (hl),a			;9886
L_9887:
	call 0a8dbh		;9887
	ld a,(0e208h)		;988a
	rra			;988d
	ld a,003h		;988e
	jr c,L_9893		;9890
	inc a			;9892
L_9893:
	jp 0a8f5h		;9893

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9896..0x98b0  (26 bytes)
DATA_9896:
	defb 00eh,00dh,00ch,00bh,00ah,009h,0fah,0fbh,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 9896  ................
	defb 001h,001h,001h,002h,002h,003h,004h,005h,005h,006h	; 98a6  ..........

; ======================================================================
; CODIGO 0x98b0..0x9953  (163 bytes)
; ======================================================================


L_98B0:
	call 0a083h		;98b0
	ld a,(0e20bh)		;98b3
	and 03fh		;98b6
	jr nz,L_98CD		;98b8
	ld a,008h		;98ba
	ld (0e20ch),a		;98bc
	ld hl,0e20bh		;98bf
	inc (hl)			;98c2
	ld a,007h		;98c3
	call 04145h		;98c5   ; banco 0: pide_sonido
	ld a,090h		;98c8
	ld (0e204h),a		;98ca   ; la X en la pantalla de lo que se maneja
L_98CD:
	ld a,(0e003h)		;98cd   ; el contador de cuadros
	and 003h		;98d0
	jr nz,L_990B		;98d2
	ld hl,0e20ch		;98d4
	dec (hl)			;98d7
	ld a,(0e20bh)		;98d8
	and 03fh		;98db
	dec a			;98dd
	ld hl,09953h		;98de
	jr z,L_98E6		;98e1
	ld hl,0995bh		;98e3
L_98E6:
	ld a,(0e20ch)		;98e6
	call 04056h		;98e9   ; banco 0: a_mas_hl
	ld a,(hl)			;98ec
	ld hl,0e204h		;98ed
	add a,(hl)			;98f0
	ld (hl),a			;98f1
	ld a,(0e20bh)		;98f2
	rla			;98f5
	ld a,004h		;98f6
	jr nc,L_98FB		;98f8
	rlca			;98fa
L_98FB:
	push af			;98fb
	call 0a87ah		;98fc
	pop af			;98ff
	push af			;9900
	call 0a87ah		;9901
	pop af			;9904
	call 0a87ah		;9905
	call 0a8dbh		;9908
L_990B:
	ld a,(0e20bh)		;990b
	rla			;990e
	ld a,005h		;990f
	jr nc,L_9914		;9911
	inc a			;9913
L_9914:
	call 0a8f5h		;9914
	ld a,(0e20ch)		;9917
	and a			;991a
	ret nz			;991b
	ld a,006h		;991c
	ld (0e20ch),a		;991e
	ld hl,0e20bh		;9921
	inc (hl)			;9924
	ld a,(hl)			;9925
	and 03fh		;9926
	cp 002h		;9928
	jr nz,L_9931		;992a
	ld a,008h		;992c
	jp 04145h		;992e   ; banco 0: pide_sonido
L_9931:
	push af			;9931
	ld a,009h		;9932
	call 04145h		;9934   ; banco 0: pide_sonido
	pop af			;9937
	cp 004h		;9938
	ret nz			;993a
	xor a			;993b
	ld (0e203h),a		;993c   ; por donde va la rotacion de los sprites
	xor a			;993f
	ld (hl),a			;9940
	ld (0e20ch),a		;9941
	ld (0e201h),a		;9944
	ld (0e202h),a		;9947
	call 062a4h		;994a
	call 06507h		;994d
	jp 068e2h		;9950

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9953..0x9961  (14 bytes)
DATA_9953:
	defb 003h,002h,002h,001h,0ffh,0feh,0feh,0fdh,002h,002h,001h,0ffh,0feh,0feh	; 9953  ..............

; ======================================================================
; CODIGO 0x9961..0x9ad1  (368 bytes)
; ======================================================================


L_9961:
	call 0a083h		;9961
	ld hl,0e20eh		;9964
	ld a,(hl)			;9967
	and a			;9968
	jr z,L_996E		;9969
	dec (hl)			;996b
	jr L_999C		;996c
L_996E:
	ld a,(0e006h)		;996e   ; las teclas recien pulsadas
	and 010h		;9971
	jr z,L_999C		;9973
	ld a,090h		;9975
	ld (0e204h),a		;9977   ; la X en la pantalla de lo que se maneja
	call 062a4h		;997a
	call 06507h		;997d
	call 068e2h		;9980
	xor a			;9983
	ld (0e203h),a		;9984   ; por donde va la rotacion de los sprites
	ld (0e20dh),a		;9987
	ld (0e20eh),a		;998a
	ld (0e201h),a		;998d
	ld (0e202h),a		;9990
	ld a,0e0h		;9993
	ld (0ee90h),a		;9995
	ld (0ee94h),a		;9998
	ret			;999b
L_999C:
	ld a,(0e215h)		;999c
	and a			;999f
	jr z,L_99C0		;99a0
	ld a,(0e006h)		;99a2   ; las teclas recien pulsadas
	and 002h		;99a5
	jr z,L_99C0		;99a7
	ld a,012h		;99a9
	ld (0e203h),a		;99ab   ; por donde va la rotacion de los sprites
	ld a,(0e215h)		;99ae
	ld (0e0a2h),a		;99b1   ; el modo en el que esta el juego
	ld a,(0e0d2h)		;99b4
	ld (0e0a3h),a		;99b7
	ld a,008h		;99ba
	ld (0e096h),a		;99bc   ; los avisos que deja el cuadro
	ret			;99bf
L_99C0:
	ld hl,0e20dh		;99c0
	ld a,(0e003h)		;99c3   ; el contador de cuadros
	and 007h		;99c6
	jr nz,L_99CB		;99c8
	inc (hl)			;99ca
L_99CB:
	ld a,(hl)			;99cb
	rra			;99cc
	ld a,098h		;99cd
	ld b,003h		;99cf
	jr nc,L_99D6		;99d1
	ld a,09eh		;99d3
	inc b			;99d5
L_99D6:
	ld (0e204h),a		;99d6   ; la X en la pantalla de lo que se maneja
	call 0a8dbh		;99d9
	ld a,b			;99dc
	jp 0a8f5h		;99dd
L_99E0:
	call 0a84bh		;99e0
	ld a,(0e0a5h)		;99e3   ; por que vuelta de la fase va
	cp 002h		;99e6
	jr z,L_9A17		;99e8
	ld a,(0e006h)		;99ea   ; las teclas recien pulsadas
	and 010h		;99ed
	jr z,L_9A17		;99ef
	ld a,0ffh		;99f1
	ld (0e208h),a		;99f3
	ld a,001h		;99f6
	ld (0e207h),a		;99f8
	ld a,(0e209h)		;99fb
	ld (0e20ah),a		;99fe
	ld a,090h		;9a01
	ld (0e204h),a		;9a03   ; la X en la pantalla de lo que se maneja
	ld a,(0e161h)		;9a06
	and a			;9a09
	ld a,006h		;9a0a
	jr z,L_9A0F		;9a0c
	inc a			;9a0e
L_9A0F:
	ld (0e203h),a		;9a0f   ; por donde va la rotacion de los sprites
	ld a,005h		;9a12
	jp 04145h		;9a14   ; banco 0: pide_sonido
L_9A17:
	ld a,(0e209h)		;9a17
	call 0a87ah		;9a1a
L_9A1D:
	ld hl,(0e204h)		;9a1d   ; la X en la pantalla de lo que se maneja
	ld d,h			;9a20
	ld (0ee88h),hl		;9a21
	ld a,010h		;9a24
	add a,h			;9a26
	ld h,a			;9a27
	ld (0ee8ch),hl		;9a28
	ld a,008h		;9a2b
	add a,l			;9a2d
	ld l,a			;9a2e
	ld (0ee84h),hl		;9a2f
	ld h,d			;9a32
	ld (0ee80h),hl		;9a33   ; la tabla de atributos de los 32 sprites
	ld a,(0e003h)		;9a36   ; el contador de cuadros
	and 020h		;9a39
	jr z,L_9A48		;9a3b
	ld a,(0ee88h)		;9a3d
	add a,002h		;9a40
	ld (0ee88h),a		;9a42
	ld (0ee8ch),a		;9a45
L_9A48:
	ld a,00ah		;9a48
	call 0a8f5h		;9a4a
	ld a,(0e003h)		;9a4d   ; el contador de cuadros
	and 010h		;9a50
	ld hl,00004h		;9a52
	jr z,L_9A5A		;9a55
	ld hl,0080ch		;9a57
L_9A5A:
	ld a,l			;9a5a
	ld (0ee86h),a		;9a5b
	ld a,h			;9a5e
	ld (0ee82h),a		;9a5f
	ret			;9a62
L_9A63:
	ld hl,0e16fh		;9a63
	bit 0,(hl)		;9a66
	ld a,(0e20ah)		;9a68
	jr z,L_9A73		;9a6b
	call 0a84bh		;9a6d
	ld a,(0e209h)		;9a70
L_9A73:
	call 0a87ah		;9a73
	ld a,(0e003h)		;9a76   ; el contador de cuadros
	and 003h		;9a79
	jr nz,L_9AC2		;9a7b
	ld a,(0e207h)		;9a7d
	dec a			;9a80
	jr nz,L_9A93		;9a81
	ld hl,0e208h		;9a83
	inc (hl)			;9a86
	ld a,(hl)			;9a87
	cp 005h		;9a88
	jr nz,L_9AB6		;9a8a
	dec (hl)			;9a8c
	ld hl,0e207h		;9a8d
	inc (hl)			;9a90
	jr L_9AC2		;9a91
L_9A93:
	ld hl,0e208h		;9a93
	inc (hl)			;9a96
	ld a,(hl)			;9a97
	cp 00ah		;9a98
	jr nz,L_9AB6		;9a9a
	xor a			;9a9c
	ld (hl),a			;9a9d
	ld (0e207h),a		;9a9e
	ld (0e20ah),a		;9aa1
	ld a,005h		;9aa4
	ld (0e203h),a		;9aa6   ; por donde va la rotacion de los sprites
	ld a,0a0h		;9aa9
	ld (0e204h),a		;9aab   ; la X en la pantalla de lo que se maneja
	ld a,006h		;9aae
	call 04145h		;9ab0   ; banco 0: pide_sonido
	jp 0bbd6h		;9ab3
L_9AB6:
	ld hl,09ad1h		;9ab6
	call 04056h		;9ab9   ; banco 0: a_mas_hl
	ld a,(hl)			;9abc
	ld hl,0e204h		;9abd
	add a,(hl)			;9ac0
	ld (hl),a			;9ac1
L_9AC2:
	call 0a8dbh		;9ac2
	ld a,(0e208h)		;9ac5
	rra			;9ac8
	ld a,003h		;9ac9
	jr c,L_9ACE		;9acb
	inc a			;9acd
L_9ACE:
	jp 0a8f5h		;9ace

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9ad1..0x9adb  (10 bytes)
DATA_9AD1:
	defb 0fbh,0fch,0fdh,0feh,0ffh,001h,002h,003h,004h,005h	; 9ad1  ..........

; ======================================================================
; CODIGO 0x9adb..0x9c74  (409 bytes)
; ======================================================================


L_9ADB:
	ld hl,0e16fh		;9adb
	bit 0,(hl)		;9ade
	ld a,(0e20ah)		;9ae0
	jr z,L_9AEB		;9ae3
	call 0a84bh		;9ae5
	ld a,(0e209h)		;9ae8
L_9AEB:
	call 0a87ah		;9aeb
	ld a,(0e207h)		;9aee
	dec a			;9af1
	jr nz,L_9B2F		;9af2
	ld a,(0e208h)		;9af4
	cp 004h		;9af7
	jr c,L_9B17		;9af9
	cp 0ffh		;9afb
	jr z,L_9B17		;9afd
	ld a,(0e007h)		;9aff   ; el estado de los mandos del cuadro anterior
	and 010h		;9b02
	jr nz,L_9B17		;9b04
	ld a,(0e208h)		;9b06
	sub 004h		;9b09
	ld hl,09896h		;9b0b
	call 04056h		;9b0e   ; banco 0: a_mas_hl
	ld a,(hl)			;9b11
	ld (0e208h),a		;9b12
	jr L_9B29		;9b15
L_9B17:
	ld a,(0e003h)		;9b17   ; el contador de cuadros
	and 003h		;9b1a
	jr nz,L_9B65		;9b1c
	ld hl,0e208h		;9b1e
	inc (hl)			;9b21
	ld a,(hl)			;9b22
	cp 00ah		;9b23
	jr nz,L_9B59		;9b25
	ld (hl),009h		;9b27
L_9B29:
	ld hl,0e207h		;9b29
	inc (hl)			;9b2c
	jr L_9B65		;9b2d
L_9B2F:
	ld a,(0e003h)		;9b2f   ; el contador de cuadros
	and 003h		;9b32
	jr nz,L_9B65		;9b34
	ld hl,0e208h		;9b36
	inc (hl)			;9b39
	ld a,(hl)			;9b3a
	cp 014h		;9b3b
	jr nz,L_9B59		;9b3d
	xor a			;9b3f
	ld (hl),a			;9b40
	ld (0e207h),a		;9b41
	ld (0e20ah),a		;9b44
	ld a,005h		;9b47
	ld (0e203h),a		;9b49   ; por donde va la rotacion de los sprites
	ld a,0a0h		;9b4c
	ld (0e204h),a		;9b4e   ; la X en la pantalla de lo que se maneja
	ld a,006h		;9b51
	call 04145h		;9b53   ; banco 0: pide_sonido
	jp 0bbd6h		;9b56
L_9B59:
	ld hl,0989ch		;9b59
	call 04056h		;9b5c   ; banco 0: a_mas_hl
	ld a,(hl)			;9b5f
	ld hl,0e204h		;9b60
	add a,(hl)			;9b63
	ld (hl),a			;9b64
L_9B65:
	call 0a8dbh		;9b65
	ld a,(0e208h)		;9b68
	rra			;9b6b
	ld a,003h		;9b6c
	jr c,L_9B71		;9b6e
	inc a			;9b70
L_9B71:
	jp 0a8f5h		;9b71
L_9B74:
	call 0a083h		;9b74
	ld a,(0e20bh)		;9b77
	and 03fh		;9b7a
	jr nz,L_9B91		;9b7c
	ld a,008h		;9b7e
	ld (0e20ch),a		;9b80
	ld hl,0e20bh		;9b83
	inc (hl)			;9b86
	ld a,007h		;9b87
	call 04145h		;9b89   ; banco 0: pide_sonido
	ld a,0a0h		;9b8c
	ld (0e204h),a		;9b8e   ; la X en la pantalla de lo que se maneja
L_9B91:
	ld a,(0e003h)		;9b91   ; el contador de cuadros
	and 003h		;9b94
	jr nz,L_9BB2		;9b96
	ld hl,0e20ch		;9b98
	dec (hl)			;9b9b
	ld a,(0e20bh)		;9b9c
	rla			;9b9f
	ld a,004h		;9ba0
	jr nc,L_9BA5		;9ba2
	rlca			;9ba4
L_9BA5:
	push af			;9ba5
	call 0a87ah		;9ba6
	pop af			;9ba9
	push af			;9baa
	call 0a87ah		;9bab
	pop af			;9bae
	call 0a87ah		;9baf
L_9BB2:
	call L_9A1D		;9bb2
	ld a,(0e20ch)		;9bb5
	and a			;9bb8
	ret nz			;9bb9
	ld a,006h		;9bba
	ld (0e20ch),a		;9bbc
	ld hl,0e20bh		;9bbf
	inc (hl)			;9bc2
	ld a,(hl)			;9bc3
	and 03fh		;9bc4
	cp 002h		;9bc6
	jr nz,L_9BCF		;9bc8
	ld a,008h		;9bca
	jp 04145h		;9bcc   ; banco 0: pide_sonido
L_9BCF:
	push af			;9bcf
	ld a,009h		;9bd0
	call 04145h		;9bd2   ; banco 0: pide_sonido
	pop af			;9bd5
	cp 004h		;9bd6
	ret nz			;9bd8
	ld a,005h		;9bd9
	ld (0e203h),a		;9bdb   ; por donde va la rotacion de los sprites
	xor a			;9bde
	ld (hl),a			;9bdf
	ld (0e20ch),a		;9be0
	ld (0e201h),a		;9be3
	ld (0e202h),a		;9be6
	call 062a4h		;9be9
	call 06507h		;9bec
	jp 068e2h		;9bef
L_9BF2:
	ld a,(0e006h)		;9bf2   ; las teclas recien pulsadas
	and 010h		;9bf5
	jr z,L_9C00		;9bf7
	call 0bbd6h		;9bf9
	xor a			;9bfc
	ld (0e212h),a		;9bfd
L_9C00:
	ld a,(0e003h)		;9c00   ; el contador de cuadros
	and 003h		;9c03
	jr nz,L_9C31		;9c05
	ld hl,0e212h		;9c07
	ld a,(hl)			;9c0a
	cp 00ch		;9c0b
	jr nc,L_9C1B		;9c0d
	ld a,(hl)			;9c0f
	inc (hl)			;9c10
	ld hl,09c74h		;9c11
	call 04056h		;9c14   ; banco 0: a_mas_hl
	ld a,(hl)			;9c17
	ld (0e214h),a		;9c18
L_9C1B:
	ld a,(0e214h)		;9c1b
	ld hl,0e204h		;9c1e
	add a,(hl)			;9c21
	ld (hl),a			;9c22
	cp 040h		;9c23
	jr nc,L_9C2B		;9c25
	ld (hl),040h		;9c27
	jr L_9C31		;9c29
L_9C2B:
	cp 091h		;9c2b
	jr c,L_9C31		;9c2d
	ld (hl),090h		;9c2f
L_9C31:
	call 0a84bh		;9c31
	ld a,(0e209h)		;9c34
	call 0a87ah		;9c37
L_9C3A:
	ld hl,(0e204h)		;9c3a   ; la X en la pantalla de lo que se maneja
	ld d,h			;9c3d
	ld (0ee84h),hl		;9c3e
	ld a,010h		;9c41
	add a,h			;9c43
	ld h,a			;9c44
	ld (0ee88h),hl		;9c45
	ld a,h			;9c48
	sub 008h		;9c49
	ld h,a			;9c4b
	ld a,00dh		;9c4c
	add a,l			;9c4e
	ld l,a			;9c4f
	ld (0ee8ch),hl		;9c50
	ld a,003h		;9c53
	add a,l			;9c55
	ld l,a			;9c56
	ld (0ee80h),hl		;9c57   ; la tabla de atributos de los 32 sprites
	ld hl,0e213h		;9c5a
	ld a,(0e003h)		;9c5d   ; el contador de cuadros
	and 007h		;9c60
	jr nz,L_9C65		;9c62
	inc (hl)			;9c64
L_9C65:
	ld a,(hl)			;9c65
	rra			;9c66
	ld c,007h		;9c67
	jr nc,L_9C70		;9c69
	inc c			;9c6b
	rra			;9c6c
	jr nc,L_9C70		;9c6d
	inc c			;9c6f
L_9C70:
	ld a,c			;9c70
	jp 0a8f5h		;9c71

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9c74..0x9c80  (12 bytes)
DATA_9C74:
	defb 0fch,0fdh,0fdh,0feh,0feh,0ffh,0ffh,0ffh,001h,002h,003h,004h	; 9c74  ............

; ======================================================================
; CODIGO 0x9c80..0x9d4a  (202 bytes)
; ======================================================================


L_9C80:
	call 0a083h		;9c80
	ld a,(0e20bh)		;9c83
	and 03fh		;9c86
	jr nz,L_9C98		;9c88
	ld a,008h		;9c8a
	ld (0e20ch),a		;9c8c
	ld hl,0e20bh		;9c8f
	inc (hl)			;9c92
	ld a,007h		;9c93
	call 04145h		;9c95   ; banco 0: pide_sonido
L_9C98:
	ld a,(0e003h)		;9c98   ; el contador de cuadros
	and 003h		;9c9b
	jr nz,L_9CF7		;9c9d
	ld hl,0e20ch		;9c9f
	dec (hl)			;9ca2
	ld a,(0e20bh)		;9ca3
	and 03fh		;9ca6
	dec a			;9ca8
	ld hl,09d4ah		;9ca9
	jr z,L_9CB1		;9cac
	ld hl,09d52h		;9cae
L_9CB1:
	ld a,(0e20ch)		;9cb1
	call 04056h		;9cb4   ; banco 0: a_mas_hl
	ld a,(hl)			;9cb7
	ld hl,0e204h		;9cb8
	add a,(hl)			;9cbb
	cp 090h		;9cbc
	jr nc,L_9CC1		;9cbe
	ld (hl),a			;9cc0
L_9CC1:
	ld a,(0e20bh)		;9cc1
	rla			;9cc4
	ld a,004h		;9cc5
	jr nc,L_9CCA		;9cc7
	rlca			;9cc9
L_9CCA:
	push af			;9cca
	call 0a87ah		;9ccb
	pop af			;9cce
	push af			;9ccf
	call 0a87ah		;9cd0
	pop af			;9cd3
	call 0a87ah		;9cd4
	ld hl,(0e204h)		;9cd7   ; la X en la pantalla de lo que se maneja
	ld d,h			;9cda
	ld (0ee84h),hl		;9cdb
	ld a,010h		;9cde
	add a,h			;9ce0
	ld h,a			;9ce1
	ld (0ee88h),hl		;9ce2
	ld a,h			;9ce5
	sub 008h		;9ce6
	ld h,a			;9ce8
	ld a,00dh		;9ce9
	add a,l			;9ceb
	ld l,a			;9cec
	ld (0ee8ch),hl		;9ced
	ld a,003h		;9cf0
	add a,l			;9cf2
	ld l,a			;9cf3
	ld (0ee80h),hl		;9cf4   ; la tabla de atributos de los 32 sprites
L_9CF7:
	ld a,(0e20bh)		;9cf7
	rla			;9cfa
	ld c,008h		;9cfb
	jr nc,L_9D00		;9cfd
	inc c			;9cff
L_9D00:
	ld a,(0e20ch)		;9d00
	and 004h		;9d03
	jr z,L_9D09		;9d05
	ld c,007h		;9d07
L_9D09:
	ld a,c			;9d09
	call 0a8f5h		;9d0a
	ld a,(0e20ch)		;9d0d
	and a			;9d10
	ret nz			;9d11
	ld a,006h		;9d12
	ld (0e20ch),a		;9d14
	ld hl,0e20bh		;9d17
	inc (hl)			;9d1a
	ld a,(hl)			;9d1b
	and 03fh		;9d1c
	cp 002h		;9d1e
	jr nz,L_9D27		;9d20
	ld a,008h		;9d22
	jp 04145h		;9d24   ; banco 0: pide_sonido
L_9D27:
	push af			;9d27
	ld a,009h		;9d28
	call 04145h		;9d2a   ; banco 0: pide_sonido
	pop af			;9d2d
	cp 004h		;9d2e
	ret nz			;9d30
	ld a,009h		;9d31
	ld (0e203h),a		;9d33   ; por donde va la rotacion de los sprites
	xor a			;9d36
	ld (hl),a			;9d37
	ld (0e20ch),a		;9d38
	ld (0e201h),a		;9d3b
	ld (0e202h),a		;9d3e
	call 062a4h		;9d41
	call 06507h		;9d44
	jp 068e2h		;9d47

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9d4a..0x9d58  (14 bytes)
DATA_9D4A:
	defb 005h,004h,004h,003h,001h,000h,000h,0ffh,004h,004h,003h,001h,000h,000h	; 9d4a  ..............

; ======================================================================
; CODIGO 0x9d58..0x9fff  (679 bytes)
; ======================================================================


L_9D58:
	ld hl,0e204h		;9d58
	ld a,(hl)			;9d5b
	cp 092h		;9d5c
	jr nc,L_9D64		;9d5e
	inc (hl)			;9d60
	jp 0a8dbh		;9d61
L_9D64:
	ld hl,0e203h		;9d64
	inc (hl)			;9d67
	ret			;9d68
L_9D69:
	call 0a84bh		;9d69
	ld a,(0e006h)		;9d6c   ; las teclas recien pulsadas
	and 010h		;9d6f
	jr z,L_9D97		;9d71
	ld a,0ffh		;9d73
	ld (0e208h),a		;9d75
	ld a,001h		;9d78
	ld (0e207h),a		;9d7a
	ld a,(0e209h)		;9d7d
	ld (0e20ah),a		;9d80
	ld a,(0e161h)		;9d83
	and a			;9d86
	ld a,00dh		;9d87
	ld b,003h		;9d89
	jr z,L_9D90		;9d8b
	inc a			;9d8d
	ld b,004h		;9d8e
L_9D90:
	ld (0e203h),a		;9d90   ; por donde va la rotacion de los sprites
	ld a,b			;9d93
	jp 0413ah		;9d94   ; banco 0: pide_sonido_si_esta_activo
L_9D97:
	ld a,(0e209h)		;9d97
	call 0a87ah		;9d9a
	call 0a8dbh		;9d9d
	ld hl,0e206h		;9da0
	ld a,(0e003h)		;9da3   ; el contador de cuadros
	and 007h		;9da6
	jr nz,L_9DAB		;9da8
	inc (hl)			;9daa
L_9DAB:
	ld a,(hl)			;9dab
	rra			;9dac
	ld c,000h		;9dad
	jr nc,L_9DB6		;9daf
	inc c			;9db1
	rra			;9db2
	jr nc,L_9DB6		;9db3
	inc c			;9db5
L_9DB6:
	ld a,c			;9db6
	jp 0a8f5h		;9db7
L_9DBA:
	ld hl,0e16fh		;9dba
	bit 0,(hl)		;9dbd
	ld a,(0e20ah)		;9dbf
	jr z,L_9DCA		;9dc2
	call 0a84bh		;9dc4
	ld a,(0e209h)		;9dc7
L_9DCA:
	call 0a87ah		;9dca
	ld a,(0e003h)		;9dcd   ; el contador de cuadros
	and 003h		;9dd0
	jr nz,L_9E0F		;9dd2
	ld a,(0e207h)		;9dd4
	dec a			;9dd7
	jr nz,L_9DEA		;9dd8
	ld hl,0e208h		;9dda
	inc (hl)			;9ddd
	ld a,(hl)			;9dde
	cp 005h		;9ddf
	jr nz,L_9E03		;9de1
	dec (hl)			;9de3
	ld hl,0e207h		;9de4
	inc (hl)			;9de7
	jr L_9E0F		;9de8
L_9DEA:
	ld hl,0e208h		;9dea
	inc (hl)			;9ded
	ld a,(hl)			;9dee
	cp 00ah		;9def
	jr nz,L_9E03		;9df1
	xor a			;9df3
	ld (hl),a			;9df4
	ld (0e207h),a		;9df5
	ld (0e20ah),a		;9df8
	ld a,00ch		;9dfb
	ld (0e203h),a		;9dfd   ; por donde va la rotacion de los sprites
	jp 0b48dh		;9e00
L_9E03:
	ld hl,097ffh		;9e03
	call 04056h		;9e06   ; banco 0: a_mas_hl
	ld a,(hl)			;9e09
	ld hl,0e204h		;9e0a
	add a,(hl)			;9e0d
	ld (hl),a			;9e0e
L_9E0F:
	call 0a8dbh		;9e0f
	ld a,(0e208h)		;9e12
	rra			;9e15
	ld a,003h		;9e16
	jr c,L_9E1B		;9e18
	inc a			;9e1a
L_9E1B:
	jp 0a8f5h		;9e1b
L_9E1E:
	ld hl,0e16fh		;9e1e
	bit 0,(hl)		;9e21
	ld a,(0e20ah)		;9e23
	jr z,L_9E2E		;9e26
	call 0a84bh		;9e28
	ld a,(0e209h)		;9e2b
L_9E2E:
	call 0a87ah		;9e2e
	ld a,(0e207h)		;9e31
	dec a			;9e34
	jr nz,L_9E72		;9e35
	ld a,(0e208h)		;9e37
	cp 004h		;9e3a
	jr c,L_9E5A		;9e3c
	cp 0ffh		;9e3e
	jr z,L_9E5A		;9e40
	ld a,(0e007h)		;9e42   ; el estado de los mandos del cuadro anterior
	and 010h		;9e45
	jr nz,L_9E5A		;9e47
	ld a,(0e208h)		;9e49
	sub 004h		;9e4c
	ld hl,09896h		;9e4e
	call 04056h		;9e51   ; banco 0: a_mas_hl
	ld a,(hl)			;9e54
	ld (0e208h),a		;9e55
	jr L_9E6C		;9e58
L_9E5A:
	ld a,(0e003h)		;9e5a   ; el contador de cuadros
	and 003h		;9e5d
	jr nz,L_9E9E		;9e5f
	ld hl,0e208h		;9e61
	inc (hl)			;9e64
	ld a,(hl)			;9e65
	cp 00ah		;9e66
	jr nz,L_9E92		;9e68
	ld (hl),009h		;9e6a
L_9E6C:
	ld hl,0e207h		;9e6c
	inc (hl)			;9e6f
	jr L_9E9E		;9e70
L_9E72:
	ld a,(0e003h)		;9e72   ; el contador de cuadros
	and 003h		;9e75
	jr nz,L_9E9E		;9e77
	ld hl,0e208h		;9e79
	inc (hl)			;9e7c
	ld a,(hl)			;9e7d
	cp 014h		;9e7e
	jr nz,L_9E92		;9e80
	xor a			;9e82
	ld (hl),a			;9e83
	ld (0e207h),a		;9e84
	ld (0e20ah),a		;9e87
	ld a,00ch		;9e8a
	ld (0e203h),a		;9e8c   ; por donde va la rotacion de los sprites
	jp 0b48dh		;9e8f
L_9E92:
	ld hl,0989ch		;9e92
	call 04056h		;9e95   ; banco 0: a_mas_hl
	ld a,(hl)			;9e98
	ld hl,0e204h		;9e99
	add a,(hl)			;9e9c
	ld (hl),a			;9e9d
L_9E9E:
	call 0a8dbh		;9e9e
	ld a,(0e208h)		;9ea1
	rra			;9ea4
	ld a,003h		;9ea5
	jr c,L_9EAA		;9ea7
	inc a			;9ea9
L_9EAA:
	jp 0a8f5h		;9eaa
L_9EAD:
	ld hl,(0e1f4h)		;9ead
	dec hl			;9eb0
	ld (0e1f4h),hl		;9eb1
	ld a,l			;9eb4
	or h			;9eb5
	jr nz,L_9EEB		;9eb6
L_9EB8:
	ld a,0e0h		;9eb8
	ld (0ee90h),a		;9eba
	ld (0ee94h),a		;9ebd
	ld a,011h		;9ec0
	ld (0e203h),a		;9ec2   ; por donde va la rotacion de los sprites
	xor a			;9ec5
	ld (0e1f0h),a		;9ec6
	ld (0e1f4h),a		;9ec9
	call L_9493		;9ecc
L_9ECF:
	ld a,(0e0a1h)		;9ecf   ; el DECORADO, de 0 a 9
	cp 002h		;9ed2
	jr z,L_9EE8		;9ed4
	cp 003h		;9ed6
	jr z,L_9EE8		;9ed8
	cp 006h		;9eda
	jr z,L_9EE8		;9edc
	cp 004h		;9ede
	jr z,L_9EE5		;9ee0
	cp 005h		;9ee2
	ret nz			;9ee4
L_9EE5:
	jp 058f0h		;9ee5
L_9EE8:
	jp 0592ch		;9ee8
L_9EEB:
	ld de,00080h		;9eeb
	rst 20h			;9eee
	jr nc,L_9F0A		;9eef
	ld de,00004h		;9ef1
	rst 20h			;9ef4
	jr c,L_9F0A		;9ef5
	ld a,(0e003h)		;9ef7   ; el contador de cuadros
	and 00fh		;9efa
	jr nz,L_9F0A		;9efc
	ld a,(0e0a5h)		;9efe   ; por que vuelta de la fase va
	cp 002h		;9f01
	jr nc,L_9F0A		;9f03
	ld a,01bh		;9f05
	call 0413ah		;9f07   ; banco 0: pide_sonido_si_esta_activo
L_9F0A:
	ld a,(0e006h)		;9f0a   ; las teclas recien pulsadas
	and 010h		;9f0d
	jr z,L_9F18		;9f0f
	call 0bbd6h		;9f11
	xor a			;9f14
	ld (0e212h),a		;9f15
L_9F18:
	ld a,(0e003h)		;9f18   ; el contador de cuadros
	and 003h		;9f1b
	jr nz,L_9F48		;9f1d
	ld hl,0e212h		;9f1f
	ld a,(hl)			;9f22
	cp 00ch		;9f23
	jr nc,L_9F33		;9f25
	ld a,(hl)			;9f27
	inc (hl)			;9f28
	ld hl,09c74h		;9f29
	call 04056h		;9f2c   ; banco 0: a_mas_hl
	ld a,(hl)			;9f2f
	ld (0e214h),a		;9f30
L_9F33:
	ld a,(0e214h)		;9f33
	ld hl,0e204h		;9f36
	add a,(hl)			;9f39
	ld (hl),a			;9f3a
	cp 040h		;9f3b
	jr nc,L_9F43		;9f3d
	ld (hl),040h		;9f3f
	jr L_9F48		;9f41
L_9F43:
	cp 091h		;9f43
	jp nc,L_9EB8		;9f45
L_9F48:
	call 0a84bh		;9f48
	ld a,(0e209h)		;9f4b
	call 0a87ah		;9f4e
	ld hl,(0e204h)		;9f51   ; la X en la pantalla de lo que se maneja
	ld a,01dh		;9f54
	add a,l			;9f56
	ld l,a			;9f57
	ld (0e20fh),hl		;9f58
	call 0a8dbh		;9f5b
	ld hl,(0e20fh)		;9f5e
	ld (0ee90h),hl		;9f61
	ld a,010h		;9f64
	add a,h			;9f66
	ld h,a			;9f67
	ld (0ee94h),hl		;9f68
	ld a,(0e209h)		;9f6b
	bit 2,a		;9f6e
	ld c,001h		;9f70
	jr nz,L_9F7C		;9f72
	bit 3,a		;9f74
	ld c,002h		;9f76
	jr nz,L_9F7C		;9f78
	ld c,000h		;9f7a
L_9F7C:
	ld a,c			;9f7c
	jp 0a8f5h		;9f7d
L_9F80:
	call 0a083h		;9f80
	ld a,(0e003h)		;9f83   ; el contador de cuadros
	rra			;9f86
	ret c			;9f87
	ld a,(0e204h)		;9f88   ; la X en la pantalla de lo que se maneja
	cp 0f8h		;9f8b
	jr nz,L_9F9A		;9f8d
	ld a,0e0h		;9f8f
	ld (0ee98h),a		;9f91
	ld a,019h		;9f94
	ld (0e203h),a		;9f96   ; por donde va la rotacion de los sprites
	ret			;9f99
L_9F9A:
	dec a			;9f9a
	ld (0e204h),a		;9f9b   ; la X en la pantalla de lo que se maneja
	ld hl,(0e204h)		;9f9e   ; la X en la pantalla de lo que se maneja
	ld a,l			;9fa1
	add a,008h		;9fa2
	ld l,a			;9fa4
	ld a,h			;9fa5
	add a,008h		;9fa6
	ld h,a			;9fa8
	ld (0e0bbh),hl		;9fa9
	call 0a8dbh		;9fac
	ld hl,(0e0bbh)		;9faf
	ld (0ee98h),hl		;9fb2
	ld a,004h		;9fb5
	call 0a8f5h		;9fb7
	ld a,(0e003h)		;9fba   ; el contador de cuadros
	and 008h		;9fbd
	ld a,07ch		;9fbf
	jr z,L_9FC5		;9fc1
	ld a,080h		;9fc3
L_9FC5:
	ld (0ee9ah),a		;9fc5
	ret			;9fc8
L_9FC9:
	ld a,(0e204h)		;9fc9   ; la X en la pantalla de lo que se maneja
	add a,003h		;9fcc
	ld (0e204h),a		;9fce   ; la X en la pantalla de lo que se maneja
	cp 0f8h		;9fd1
	jr nc,L_9FFC		;9fd3
	cp 090h		;9fd5
	jr c,L_9FFC		;9fd7
	ld a,(0e0a1h)		;9fd9   ; el DECORADO, de 0 a 9
	cp 004h		;9fdc
	ld c,005h		;9fde
	ld b,0a0h		;9fe0
	ld e,006h		;9fe2
	jr z,L_9FF0		;9fe4
	cp 005h		;9fe6
	jr z,L_9FF0		;9fe8
	ld c,000h		;9fea
	ld b,090h		;9fec
	ld e,020h		;9fee
L_9FF0:
	ld a,c			;9ff0
	ld (0e203h),a		;9ff1   ; por donde va la rotacion de los sprites
	ld a,b			;9ff4
	ld (0e204h),a		;9ff5   ; la X en la pantalla de lo que se maneja
	ld a,e			;9ff8
	jp 0413ah		;9ff9   ; banco 0: pide_sonido_si_esta_activo
L_9FFC:
	call 0a8dbh		;9ffc

; ----------------------------------------------------------------------
; DATOS sin identificar  0x9fff..0xa000  (1 bytes)
DATA_9FFF:
	defb 03eh	; 9fff
