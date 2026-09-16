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
	ld bc,(0e000h)		;800f   ; el estado en C y el subestado en B, de un tiron; la variable de fase
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
	defw 083a9h	; 8025  -> estado_7
	defw 084e1h	; 8027  -> estado_8
	defw 08538h	; 8029  -> estado_9
	defw 085d2h	; 802b  -> estado_10
	defw 08648h	; 802d  -> estado_11_espera
	defw 086c6h	; 802f  -> estado_12
	defw 08800h	; 8031  -> estado_13_la_pausa
	defw 08806h	; 8033  -> estado_14
	defw 08933h	; 8035  -> estado_15

; ======================================================================
; CODIGO 0x8037..0x86c2  (1675 bytes)
; ======================================================================


estado_0:
	djnz estado_0_subestado_1		;8037   ; el subestado
	ld a,(0e003h)		;8039   ; el contador de cuadros
	rra			;803c   ; uno de cada dos
	ret nc			;803d
	call destapa_una_columna		;803e
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
	call monta_la_rejilla		;805b
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
	call 07f11h		;8075   ; banco 1
	call 07f0eh		;8078   ; banco 1
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
	call 07e7fh		;808e   ; banco 1
pon_la_espera_y_avanza:
	ld (0e004h),a		;8091   ; lo que haya en A pasa a ser la espera
avanza_el_subestado:
	ld hl,0e001h		;8094   ; el subestado
	inc (hl)			;8097   ; uno mas
	ret			;8098

; ----------------------------------------------------------------------
; ESTADO 3: EL MENU. El que espera a que se pulse algo, hace parpadear el rotulo y deja elegir entre LEVEL 1 y LEVEL 2. La eleccion vive en 0xE082 y los dos rotulos que se intercambian son los guiones 0x8E0A y 0x8E14.
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
	call cambia_de_nivel		;80dc
	call L_91F7		;80df
	ld a,(0e006h)		;80e2   ; las teclas recien pulsadas
	and 010h		;80e5   ; el bit 4: la barra o el disparo
	ret z			;80e7   ; si no se ha pulsado, a esperar
	ld a,0aah		;80e8   ; el efecto 0xAA
	call 0413ah		;80ea   ; banco 0: pide_sonido_si_esta_activo
	ld c,000h		;80ed
	call L_9201		;80ef
	call mira_si_es_una_de_las_dos_claves		;80f2
	ld a,(0e082h)		;80f5   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
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
	call borra_la_partida		;8138
	ld a,(0e082h)		;813b   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
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
	call escena_despacha_por_0xE0B5		;814d
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
	call monta_la_pantalla_entera		;817c
	call 057fbh		;817f
	call L_9689		;8182
	call 06000h		;8185   ; el mapa del decorado
	call 06539h		;8188   ; banco 1
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
	call escena_despacha_por_0xE0B5		;81b9
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
	ld a,(0e0a2h)		;81cc   ; el modo en el que esta el juego; y con el modo distinto de cero, tampoco
	and a			;81cf
	jr nz,estado_5_mira_la_pausa		;81d0
	ld a,(0e006h)		;81d2   ; las teclas recien pulsadas
	and 080h		;81d5   ; el bit 7: la tecla de parar
	jr z,estado_5_mira_la_pausa		;81d7   ; si no esta, a jugar
	rlca			;81d9   ; el bit sube al acarreo y baja al 0
	ld (0e07ah),a		;81da   ; la marca de silencio general; y con el se calla o se descalla el sonido
	ld a,(0e0a0h)		;81dd   ; la bandera de pausa
	cpl			;81e0   ; se le da la vuelta
	ld (0e0a0h),a		;81e1   ; la bandera de PAUSA
	and a			;81e4   ; ¿ha quedado en pausa o ha salido de ella?
	jr z,estado_5_sale_de_la_pausa		;81e5
	xor a			;81e7
	ld (0e0b5h),a		;81e8
	ld (0e126h),a		;81eb
	ld hl,0e0deh		;81ee   ; LA CUENTA DE PAUSAS, y de ella depende el final: sube al ENTRAR en pausa, no al salir, asi que parar y seguir cuenta UNA
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
	jp estado_13_la_pausa		;8211   ; y con pausa, al estado de parado
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
	call monta_la_pantalla_entera		;8238
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

; ----------------------------------------------------------------------
; ESTADO 6: SE ACABO LA FASE. Nueve subestados que llevan del "se acabo" al "empieza la siguiente", y en medio esta la cuenta de la fase: 0x8317 sube el numero que se pinta EN BCD, 0x831D hace girar el 1-2-3 del decorado y 0x8326 sube la fase de verdad. Cuando esa llega a 0x19 -o sea 25- se acaba el juego, y ahi esta escrito que las fases son VEINTICUATRO.
; ----------------------------------------------------------------------
estado_6:
	djnz estado_6_subestado_1		;8278
	call 04265h		;827a   ; subir la zona de juego
	call 042fbh		;827d   ; y los sprites
	call L_96F9		;8280   ; lo que haya que rematar en el banco 2
	call 0a985h		;8283   ; y en el 3
	ld a,(0e096h)		;8286   ; los avisos que deja el cuadro
	and a			;8289
	ret nz			;828a
	ld a,040h		;828b   ; 0x40 cuadros de espera
	ld (0e004h),a		;828d   ; el contador de espera del estado
	jp avanza_el_subestado		;8290
estado_6_subestado_1:
	djnz estado_6_subestado_2		;8293
	ld hl,0e004h		;8295
	dec (hl)			;8298   ; la espera
	ret nz			;8299
	ld a,001h		;829a
	ld (0e0e1h),a		;829c   ; una bandera
	ld (0e096h),a		;829f   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;82a2
estado_6_subestado_2:
	djnz estado_6_subestado_3		;82a5
	call L_94AA		;82a7
	ld a,(0e096h)		;82aa   ; los avisos que deja el cuadro
	and a			;82ad
	ret nz			;82ae
	ld a,040h		;82af
	ld (0e004h),a		;82b1   ; el contador de espera del estado
	jp avanza_el_subestado		;82b4
estado_6_subestado_3:
	djnz estado_6_mira_si_toca_bonus		;82b7
	ld hl,0e004h		;82b9
	dec (hl)			;82bc
	ret nz			;82bd
	jp avanza_el_subestado		;82be

; ----------------------------------------------------------------------
; ¿TOCA ALGO AL ACABAR ESTA FASE? Solo en las fases cuyo 1-2-3 de decorado vale 3, que son las multiplos de tres. En la 12 se apunta un 2 en 0xE0B9 y en la 24 se va a decidir el final; en las demas se salta un subestado y no pasa nada.
; ----------------------------------------------------------------------
estado_6_mira_si_toca_bonus:
	djnz estado_6_subestado_5		;82c1
	ld a,(0e093h)		;82c3   ; el valor 1-2-3 de la fase; el 1-2-3 del decorado
	cp 003h		;82c6   ; solo en el 3 puede tocar
	jr nz,estado_6_sin_bonus		;82c8
	ld a,(0e092h)		;82ca   ; la FASE, de 1 a 24
	cp 00ch		;82cd   ; la 12...
	ld c,002h		;82cf
	jr z,estado_6_apunta_el_bonus		;82d1
	cp 018h		;82d3   ; ...o la 24
	jr z,decide_el_final		;82d5
estado_6_sin_bonus:
	ld hl,0e001h		;82d7   ; el subestado
	inc (hl)			;82da   ; se salta uno
	jp avanza_el_subestado		;82db

; ----------------------------------------------------------------------
; EL FINAL BUENO Y EL FINAL MALO, Y DE QUE DEPENDEN. Aqui se decide, y no depende de como se juegue: depende de LAS VECES QUE SE HAYA PULSADO LA PAUSA. Se cogen los dos bits bajos de 0xE0DE y se les resta uno; si queda cero -o sea, si la cuenta de pausas deja resto 1 al dividir entre cuatro- 0xE0B9 se queda a cero, y si no, a uno. Luego p00:5F19 escoge con esa 0xE0B9 cual de los dos textos sube al acabar: con cero el de 0x5F63, que dice que se ha rescatado a la princesa, y con uno el de 0x5F6D, que dice que no.
; O sea que el final bueno pide haber pausado 1, 5, 9, 13... veces, y CERO no vale. El hallazgo es de MANUEL PAZOS, que lo conto en una charla; lo que hay aqui es donde esta escrito en el binario y la regla exacta.
; ----------------------------------------------------------------------
decide_el_final:
	ld a,(0e0deh)		;82de   ; las veces que se ha parado
	and 003h		;82e1   ; sus dos bits bajos
	dec a			;82e3   ; menos uno: solo el resto 1 deja cero
	ld c,000h		;82e4   ; con resto 1, el final BUENO
	jr z,estado_6_apunta_el_bonus		;82e6
	inc c			;82e8   ; y con cualquier otro, el malo
estado_6_apunta_el_bonus:
	ld a,c			;82e9
	ld (0e0b9h),a		;82ea   ; que clase de bonus toca
	xor a			;82ed
	ld (0e0b7h),a		;82ee
	inc a			;82f1
	ld (0e096h),a		;82f2   ; los avisos que deja el cuadro
	jp avanza_el_subestado		;82f5
estado_6_subestado_5:
	djnz estado_6_pasa_de_fase		;82f8
	call 04265h		;82fa   ; banco 0: sube_el_area_de_juego
	call 042fbh		;82fd   ; banco 0: sube_los_sprites
	call 0aa80h		;8300   ; banco 3
	ld a,(0e096h)		;8303   ; los avisos que deja el cuadro
	and a			;8306
	ret nz			;8307
	jp avanza_el_subestado		;8308
estado_6_pasa_de_fase:
	djnz estado_6_se_acabo_el_juego		;830b
	call 042edh		;830d   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;8310   ; banco 0: borra_el_area_de_juego; y borrar la zona de juego
	ld hl,0e091h		;8313   ; el numero de fase que se pinta
	ld a,(hl)			;8316
	add a,001h		;8317   ; uno mas, EN BCD
	daa			;8319
	ld (hl),a			;831a
	inc l			;831b   ; dos bytes mas alla: el 1-2-3 del decorado
	inc l			;831c
	inc (hl)			;831d   ; uno mas
	ld a,(hl)			;831e
	cp 004h		;831f   ; al llegar a 4...
	jr nz,estado_6_sube_la_fase		;8321
	ld (hl),001h		;8323   ; ...vuelve a 1
estado_6_sube_la_fase:
	dec l			;8325
	inc (hl)			;8326   ; la FASE, una mas
	ld a,(hl)			;8327
	cp 019h		;8328   ; y en la 25 se acabo: son VEINTICUATRO
	jp z,avanza_el_subestado		;832a
	call 04660h		;832d   ; banco 0: monta_la_fase; montar la fase siguiente
	ld a,003h		;8330   ; y al estado 3
	jp pon_el_estado		;8332
estado_6_se_acabo_el_juego:
	djnz estado_6_los_rotulos_del_final		;8335
	call 04224h		;8337   ; banco 0: borra_la_pantalla_entera; borrar la pantalla entera
	ld hl,0eb80h		;833a   ; el espejo de pantalla, entero
	ld de,0eb81h		;833d
	ld bc,002ffh		;8340   ; 767 bytes
	ld (hl),000h		;8343
	ldir		;8345
	ld a,0c2h		;8347   ; el efecto 0xC2
	call 0413ah		;8349   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;834c
estado_6_los_rotulos_del_final:
	djnz estado_6_entre_fases		;834f
	call 04265h		;8351   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call 05e6eh		;8354   ; banco 0: rotulos_que_suben; y el texto que sube
	ld a,(0e096h)		;8357   ; los avisos que deja el cuadro
	and a			;835a
	ret nz			;835b
	ld (0e002h),a		;835c   ; las banderas de la partida, a cero
	jp estado_a_0xFF		;835f   ; y a empezar de nuevo
estado_6_entre_fases:
	call 0a083h		;8362   ; banco 3
	call 042dfh		;8365
	call 04265h		;8368   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	ld a,(0e093h)		;836b   ; el valor 1-2-3 de la fase; el 1-2-3 del decorado
	cp 003h		;836e   ; en el 3 se pasa de largo
	jp z,pasa_al_estado_siguiente		;8370
	ld a,0e0h		;8373   ; 0xE0: un sprite fuera de la pantalla
	ld (0eec4h),a		;8375
	ld a,(0e0a1h)		;8378   ; el DECORADO, de 0 a 9
	cp 004h		;837b   ; el 4 y el 5 llevan un efecto...
	ld c,002h		;837d
	ld b,098h		;837f
	jr z,estado_6_suena_el_paso_de_fase		;8381
	cp 005h		;8383
	jr z,estado_6_suena_el_paso_de_fase		;8385
	cp 007h		;8387   ; ...el 7 otro...
	ld c,003h		;8389
	jr z,estado_6_suena_el_paso_de_fase		;838b
	ld c,001h		;838d   ; ...y los demas, el de siempre
	ld b,086h		;838f
estado_6_suena_el_paso_de_fase:
	ld a,b			;8391
	call 0413ah		;8392   ; banco 0: pide_sonido_si_esta_activo; el efecto que toque
	ld a,c			;8395
	ld (0e21eh),a		;8396   ; y la clase de paso de fase
	ld a,017h		;8399
	ld (0e203h),a		;839b   ; el ESTADO de lo que se maneja
	call 055f7h		;839e
estado_6_avisa_y_avanza:
	ld a,001h		;83a1
	ld (0e096h),a		;83a3   ; los avisos que deja el cuadro; un aviso
	jp avanza_el_subestado		;83a6

; ----------------------------------------------------------------------
; ESTADO 7: LA META. Los subestados que rematan una fase cuando se llega al final, con la comprobacion de las cuatro ranuras de 0xE550 y el parpadeo del borde de la pantalla.
; ----------------------------------------------------------------------
estado_7:
	djnz estado_7_subestado_1		;83a9
	call 042fbh		;83ab   ; banco 0: sube_los_sprites
	call L_96F9		;83ae
	call 0a985h		;83b1   ; banco 3
	ld a,(0e203h)		;83b4   ; el ESTADO de lo que se maneja
	cp 00ch		;83b7   ; hasta el 12 no se sigue
	ret nz			;83b9
	call 07db3h		;83ba   ; lo que sea, en el banco 1
	jp avanza_el_subestado		;83bd
estado_7_subestado_1:
	djnz estado_7_la_tanda_larga		;83c0
	call 04265h		;83c2   ; banco 0: sube_el_area_de_juego
	call 04332h		;83c5   ; banco 0: sube_los_sprites_desde_arriba; subir la mitad de arriba de los sprites
	call 0b12bh		;83c8   ; banco 3
	call 07cf8h		;83cb   ; banco 1
	ld hl,0e550h		;83ce   ; las cuatro ranuras de 0xE550
	ld b,004h		;83d1   ; cuatro
estado_7_mira_las_ranuras:
	ld a,(hl)			;83d3   ; lo que hay en la ranura
	cp 002h		;83d4
	ret c			;83d6   ; si alguna esta por debajo de 2, no se sigue
	ld a,008h		;83d7   ; ocho bytes de una a la siguiente
	call 04056h		;83d9   ; banco 0: a_mas_hl
	djnz estado_7_mira_las_ranuras		;83dc
	call 0b165h		;83de   ; banco 3
	jp avanza_el_subestado		;83e1
estado_7_la_tanda_larga:
	djnz estado_7_parpadea_el_borde		;83e4
	call 04258h		;83e6   ; banco 0: sube_la_mitad_de_abajo; subir la mitad de abajo
	call 042fbh		;83e9   ; banco 0: sube_los_sprites
	call L_96F9		;83ec
	call 0a985h		;83ef   ; banco 3
	call 0bd8ah		;83f2   ; banco 3
	call 0bdcah		;83f5   ; banco 3
	call 07b44h		;83f8   ; banco 1
	call 07c9fh		;83fb   ; banco 1
	call 0ae6ah		;83fe   ; banco 3
	call 0af82h		;8401   ; banco 3
	call 0b184h		;8404   ; banco 3
	call 07c01h		;8407   ; banco 1
	call 0b2c2h		;840a   ; banco 3
	call 07cf8h		;840d   ; banco 1
	call L_921B		;8410
	call L_9469		;8413
	call 076f3h		;8416   ; banco 1
	call 07799h		;8419   ; banco 1
	ld a,001h		;841c   ; una bandera
	ld (0e0e0h),a		;841e
	ld a,(0e097h)		;8421   ; la bandera de que la fase se ha acabado
	and a			;8424
	ld a,00dh		;8425   ; si no se ha acabado, al estado 13
	jp z,pon_el_estado		;8427
	xor a			;842a
	ld (0e0e0h),a		;842b
	ld a,(0e530h)		;842e   ; una ranura
	cp 002h		;8431   ; y solo con un 2 se sigue
	ret nz			;8433
	call 07c3eh		;8434   ; banco 1
	ld a,07ah		;8437   ; el efecto 0x7A
	call 0413ah		;8439   ; banco 0: pide_sonido_si_esta_activo
	call 042e8h		;843c
	call 05561h		;843f
	jp avanza_el_subestado		;8442
estado_7_parpadea_el_borde:
	djnz estado_7_prepara_la_siguiente		;8445
	ld a,(0e530h)		;8447   ; una ranura
	cp 003h		;844a   ; por debajo de 3 no parpadea
	jr c,estado_7_sigue		;844c
	ld a,(0e003h)		;844e   ; el contador de cuadros
	rra			;8451   ; el bit 0 al acarreo
	ld b,000h		;8452   ; un cuadro el borde negro...
	jr c,L_8458		;8454
	ld b,00eh		;8456   ; ...y el otro gris
L_8458:
	call 044b6h		;8458   ; banco 0: escribe_el_registro_7; el registro 7 del VDP, que es el del borde
estado_7_sigue:
	call 04265h		;845b   ; banco 0: sube_el_area_de_juego
	call 042fbh		;845e   ; banco 0: sube_los_sprites
	call 0afafh		;8461   ; banco 3
	call 07c3eh		;8464   ; banco 1
	ld a,(0e530h)		;8467   ; la ranura
	and a			;846a
	ret nz			;846b   ; mientras no llegue a cero, se sigue parpadeando
	ld b,000h		;846c   ; y al acabar, borde negro
	call 044b6h		;846e   ; banco 0: escribe_el_registro_7
	jp avanza_el_subestado		;8471
estado_7_prepara_la_siguiente:
	djnz estado_7_ultimo		;8474
	ld a,001h		;8476
	ld (0e21eh),a		;8478   ; la clase de paso de fase
	ld a,018h		;847b
	ld (0e203h),a		;847d   ; el ESTADO de lo que se maneja
	xor a			;8480
	ld (0e0ddh),a		;8481
	ld a,(0e08bh)		;8484   ; el TIEMPO que queda
	and 00fh		;8487   ; los cuatro bits de abajo
	cp 002h		;8489   ; y de ahi salen cinco posiciones distintas
	ld c,028h		;848b
	jr z,estado_7_guarda_la_posicion		;848d
	cp 004h		;848f
	ld c,048h		;8491
	jr z,estado_7_guarda_la_posicion		;8493
	cp 006h		;8495
	ld c,068h		;8497
	jr z,estado_7_guarda_la_posicion		;8499
	cp 008h		;849b
	ld c,088h		;849d
	jr z,estado_7_guarda_la_posicion		;849f
	ld c,001h		;84a1   ; y la de por defecto
estado_7_guarda_la_posicion:
	ld a,c			;84a3
	ld (0e21ch),a		;84a4   ; apuntada
	call 05667h		;84a7
	call 0550ch		;84aa
	ld a,005h		;84ad   ; y al estado 5, o sea a jugar
	call pon_el_estado		;84af
	jp estado_6_avisa_y_avanza		;84b2
estado_7_ultimo:
	call 04265h		;84b5   ; banco 0: sube_el_area_de_juego
	ld a,001h		;84b8   ; color 1 en los cuatro primeros sprites
	ld (0ee83h),a		;84ba
	ld (0ee87h),a		;84bd
	ld (0ee8bh),a		;84c0
	ld (0ee8fh),a		;84c3
	ld a,00bh		;84c6
	ld (0e203h),a		;84c8   ; el ESTADO de lo que se maneja
	ld a,003h		;84cb
	ld (0e0a5h),a		;84cd   ; por que vuelta de la fase va; la vuelta 3
	ld a,062h		;84d0
	call 0413ah		;84d2   ; banco 0: pide_sonido_si_esta_activo
	call 0ae0fh		;84d5   ; banco 3
	call 0ae23h		;84d8   ; banco 3
	call 057c2h		;84db
	jp avanza_el_subestado		;84de

; ----------------------------------------------------------------------
; LOS ESTADOS 8 A 11: LAS TRANSICIONES. Cuatro estados que se parecen mucho y que hacen lo mismo con distintos motivos -perder una vida, entrar al bonus, salir de el, empezar la vuelta siguiente-. El patron es siempre el mismo: subir los sprites y esperar a que (0xE203) llegue a cierto numero, y cuando llega, esconder los sprites, borrar la zona de juego, montar la escena otra vez con las tres cargas de caracteres y volver al estado 4.
; ----------------------------------------------------------------------
estado_8:
	djnz estado_8_monta_otra_vez		;84e1
	call 04332h		;84e3   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;84e6
	call 0a985h		;84e9   ; banco 3
	call 0be41h		;84ec   ; banco 3
	ld a,(0e203h)		;84ef   ; el ESTADO de lo que se maneja
	cp 019h		;84f2   ; en el 0x19 se acaba
	ret nz			;84f4
	jp avanza_el_subestado		;84f5
estado_8_monta_otra_vez:
	djnz estado_8_ultimo		;84f8
	call 042edh		;84fa   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;84fd   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 0b5e1h		;8500   ; montar la fase de bonus, en el banco 3
	call 0463fh		;8503   ; banco 0: empieza_una_vida; empezar una vida
	call 04995h		;8506   ; los caracteres del tercio de arriba
	call 049fch		;8509   ; los del de en medio
	call 049d2h		;850c   ; y los del de abajo
	call 057fbh		;850f
	call monta_la_pantalla_entera		;8512
	xor a			;8515
	call L_9453		;8516
	call 06000h		;8519   ; banco 1
	call 06539h		;851c   ; banco 1
	call 04265h		;851f   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call L_9493		;8522
	ld a,004h		;8525   ; y al estado 4
	jp pon_el_estado		;8527
estado_8_ultimo:
	call 042e8h		;852a
	call 07db3h		;852d   ; banco 1
	ld a,0c5h		;8530   ; el efecto 0xC5
	call 0413ah		;8532   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8535
estado_9:
	djnz estado_9_la_cuenta_del_bonus		;8538
	call 042fbh		;853a   ; banco 0: sube_los_sprites; subir los sprites
	call L_96F9		;853d
	ld a,(0e096h)		;8540   ; los avisos que deja el cuadro
	and a			;8543
	ret nz			;8544   ; mientras haya alguno, se espera
	ld (0e0ceh),a		;8545   ; el paso de la cuenta del bonus, a cero
	inc a			;8548
	ld (0e096h),a		;8549   ; los avisos que deja el cuadro
	call 042e8h		;854c
	call 04232h		;854f   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 05b91h		;8552
	jp avanza_el_subestado		;8555
estado_9_la_cuenta_del_bonus:
	djnz estado_9_monta_otra_vez		;8558
	call 0b63fh		;855a   ; la cuenta del bonus, en el banco 3
	ld a,(0e096h)		;855d   ; los avisos que deja el cuadro
	and a			;8560
	ret nz			;8561   ; mientras dure, se espera
	jp avanza_el_subestado		;8562
estado_9_monta_otra_vez:
	djnz estado_9_espera_la_transicion		;8565
	call 04232h		;8567   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 0b6f8h		;856a   ; banco 3
	call 0463fh		;856d   ; banco 0: empieza_una_vida; empezar una vida
	call 04995h		;8570   ; los tres tercios de caracteres
	call 049fch		;8573
	call 049d2h		;8576
	call 057fbh		;8579
	call L_9689		;857c
	call monta_la_pantalla_entera		;857f
	call L_9431		;8582
	call 06000h		;8585   ; banco 1
	call 06539h		;8588   ; banco 1
	call 04265h		;858b   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	ld a,01fh		;858e   ; el efecto 0x1F
	call 0413ah		;8590   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8593
estado_9_espera_la_transicion:
	djnz estado_9_ultimo		;8596
	call 04332h		;8598   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;859b
	call 0a985h		;859e   ; banco 3
	ld a,(0e203h)		;85a1   ; el ESTADO de lo que se maneja
	and a			;85a4
	ld c,020h		;85a5   ; con cero, un efecto...
	jr z,estado_9_suena_y_vuelve		;85a7
	cp 005h		;85a9   ; ...y con cinco, otro
	ret nz			;85ab
	ld c,006h		;85ac
estado_9_suena_y_vuelve:
	ld a,c			;85ae
	call 0413ah		;85af   ; banco 0: pide_sonido_si_esta_activo
	call 042e8h		;85b2
	call L_9493		;85b5
	ld a,004h		;85b8   ; y al estado 4
	jp pon_el_estado		;85ba
estado_9_ultimo:
	ld a,056h		;85bd   ; el efecto 0x56
	call 0413ah		;85bf   ; banco 0: pide_sonido_si_esta_activo
avisa_y_avanza_con_paso:
	call 04265h		;85c2   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	ld a,01ah		;85c5
	ld (0e203h),a		;85c7   ; el ESTADO de lo que se maneja, a 0x1A
	ld a,001h		;85ca
	ld (0e096h),a		;85cc   ; los avisos que deja el cuadro; y un aviso
	jp avanza_el_subestado		;85cf
estado_10:
	djnz estado_10_monta_otra_vez		;85d2
	call 04332h		;85d4   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;85d7
	ld a,(0e203h)		;85da   ; el ESTADO de lo que se maneja
	cp 011h		;85dd   ; en el 0x11 se acaba
	ret nz			;85df
	jp avanza_el_subestado		;85e0
estado_10_monta_otra_vez:
	djnz estado_10_espera		;85e3
	call 042edh		;85e5   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;85e8   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 0b8ddh		;85eb   ; banco 3
	call 0463fh		;85ee   ; banco 0: empieza_una_vida; empezar una vida
	ld a,002h		;85f1
	ld (0e4c0h),a		;85f3   ; el nivel de la barra de nueve
	ld (0e4c1h),a		;85f6
	call 04995h		;85f9
	call 049fch		;85fc
	call 049d2h		;85ff
	call 057fbh		;8602
	call monta_la_pantalla_entera		;8605
	xor a			;8608
	call L_9453		;8609
	call 06000h		;860c   ; banco 1
	call 06539h		;860f   ; banco 1
	call 04265h		;8612   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call 07db3h		;8615   ; banco 1
	ld a,01fh		;8618   ; el efecto 0x1F
	call 0413ah		;861a   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;861d
estado_10_espera:
	djnz estado_10_ultimo		;8620
	call 04332h		;8622   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;8625
	call 0a985h		;8628   ; banco 3
	ld a,(0e203h)		;862b   ; el ESTADO de lo que se maneja
	and a			;862e
	ret nz			;862f   ; hasta cero no se sigue
	ld a,020h		;8630   ; el efecto 0x20
	call 0413ah		;8632   ; banco 0: pide_sonido_si_esta_activo
	call L_9493		;8635
	ld a,004h		;8638   ; y al estado 4
	jp pon_el_estado		;863a
estado_10_ultimo:
	call 042dfh		;863d
	ld a,092h		;8640   ; el efecto 0x92
	call 0413ah		;8642   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8645
estado_11_espera:
	djnz estado_11_monta_otra_vez		;8648
	call 04332h		;864a   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;864d
	call 0a985h		;8650   ; banco 3
	ld a,(0e203h)		;8653   ; el ESTADO de lo que se maneja
	and a			;8656   ; hasta cero no se sigue
	ret nz			;8657
	jp avanza_el_subestado		;8658
estado_11_monta_otra_vez:
	djnz estado_11_ultimo		;865b
	call 042edh		;865d   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;8660   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 0b94ah		;8663   ; banco 3
	call 0463fh		;8666   ; banco 0: empieza_una_vida; empezar una vida
	call 04995h		;8669   ; los tres tercios de caracteres
	call 049fch		;866c
	call 049d2h		;866f
	call 057fbh		;8672
	call L_9689		;8675
	call monta_la_pantalla_entera		;8678
	call L_9431		;867b
	call 06000h		;867e   ; banco 1
	call 06539h		;8681   ; banco 1
	call 04265h		;8684   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call L_9493		;8687
	ld a,004h		;868a   ; y al estado 4
	jp pon_el_estado		;868c
estado_11_ultimo:
	call 042e8h		;868f
	ld a,001h		;8692   ; la clase de paso de fase
	ld (0e21eh),a		;8694   ; por que tiempo va la otra secuencia
	ld a,01bh		;8697
	ld (0e203h),a		;8699   ; el ESTADO de lo que se maneja, a 0x1B
	call 07db3h		;869c   ; banco 1
	ld a,0f8h		;869f   ; un valor de trabajo
	ld (0e21fh),a		;86a1   ; el paso de montar y desmontar la figura
	ld c,00eh		;86a4   ; catorce sprites
	ld hl,0ee90h		;86a6   ; desde el hueco 4
estado_11_llena_los_sprites:
	ld b,004h		;86a9   ; cuatro bytes por sprite
	ld de,086c2h		;86ab   ; la plantilla de sprite
estado_11_copia_el_sprite:
	ld a,(de)			;86ae
	ld (hl),a			;86af
	inc de			;86b0
	inc l			;86b1
	djnz estado_11_copia_el_sprite		;86b2
	dec c			;86b4   ; un sprite menos
	jr nz,estado_11_llena_los_sprites		;86b5
	call 056a0h		;86b7
	ld a,089h		;86ba   ; el efecto 0x89
	call 0413ah		;86bc   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;86bf

; ----------------------------------------------------------------------
; DATOS sprite_de_relleno: Los cuatro bytes -Y 0xE0, X 0x78, patron 0x34 y
;   color 0x0A- que 0x86A9 repite en los catorce sprites de arriba. La Y a
;   0xE0 los deja fuera de la pantalla: se preparan escondidos y luego se van
;   bajando.
;   0x86c2..0x86c6  (4 bytes)
DATA_sprite_de_relleno:
	defb 0e0h,078h,034h,00ah	; 86c2

; ======================================================================
; CODIGO 0x86c6..0x8d09  (1603 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; ESTADO 12: LA ESCENA LARGA. El estado con mas subestados de todos -nueve-, y el unico que se salta subestados a proposito: 0x8748 sube 0xE001 tres veces de golpe y 0x877C una, segun lo que devuelva la rutina del banco 1 en 0xE096. O sea que la escena tiene ramas.
; ----------------------------------------------------------------------
estado_12:
	djnz estado_12_subestado_1		;86c6
	call 04332h		;86c8   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;86cb
	ld a,(0e203h)		;86ce   ; el ESTADO de lo que se maneja
	cp 011h		;86d1   ; en el 0x11 se sigue
	ret nz			;86d3
	jp avanza_el_subestado		;86d4
estado_12_subestado_1:
	djnz estado_12_subestado_2		;86d7
	call 042edh		;86d9   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;86dc   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call L_9431		;86df
	call 06befh		;86e2   ; banco 1
	ld a,01fh		;86e5   ; el efecto 0x1F
	call 0413ah		;86e7   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;86ea
estado_12_subestado_2:
	djnz estado_12_la_rama		;86ed
	call 04332h		;86ef   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;86f2
	call 0a985h		;86f5   ; banco 3
	ld a,(0e203h)		;86f8   ; el ESTADO de lo que se maneja
	and a			;86fb   ; hasta cero no se sigue
	ret nz			;86fc
	ld a,020h		;86fd   ; el efecto 0x20
	call 0413ah		;86ff   ; banco 0: pide_sonido_si_esta_activo
	ld a,(0e0a2h)		;8702   ; el modo en el que esta el juego
	sub 003h		;8705   ; el 3 lleva un efecto...
	ld c,06bh		;8707
	jr z,estado_12_suena		;8709
	dec a			;870b   ; ...el 4 otro...
	ld c,06eh		;870c
	jr z,estado_12_suena		;870e
	ld c,068h		;8710   ; ...y los demas el de siempre
estado_12_suena:
	ld a,c			;8712
	call 0413ah		;8713   ; banco 0: pide_sonido_si_esta_activo
	call 0a8dbh		;8716   ; banco 3
	xor a			;8719
	call 0a8f5h		;871a   ; banco 3
	ld a,004h		;871d
	ld (0ee83h),a		;871f   ; color 4 en los cuatro primeros sprites
	ld (0ee87h),a		;8722
	ld (0ee8bh),a		;8725
	ld (0ee8fh),a		;8728
	call 042fbh		;872b   ; banco 0: sube_los_sprites; subir los sprites
	xor a			;872e
	ld (0e096h),a		;872f   ; los avisos que deja el cuadro; y los avisos, a cero
	jp avanza_el_subestado		;8732
estado_12_la_rama:
	djnz estado_12_subestado_4		;8735
	call 06e1eh		;8737   ; la escena, en el banco 1
	ld a,(0e096h)		;873a   ; los avisos que deja el cuadro; lo que ha devuelto
	and a			;873d
	ret z			;873e   ; sin aviso, se sigue esperando
	dec a			;873f   ; con un 1 se avanza uno...
	ld a,000h		;8740
	ld (0e096h),a		;8742   ; los avisos que deja el cuadro
	jp nz,avanza_el_subestado		;8745
	ld hl,0e001h		;8748   ; ...y con otra cosa se saltan TRES subestados de golpe
	inc (hl)			;874b
	inc (hl)			;874c
	inc (hl)			;874d
	jp avanza_el_subestado		;874e
estado_12_subestado_4:
	djnz estado_12_subestado_5		;8751
	ld hl,03b00h		;8753   ; el sprite 0
	ld a,0d0h		;8756   ; a la fila 0xD0
	call 0004dh		;8758   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;875b   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 07809h		;875e   ; banco 1
	ld a,074h		;8761   ; el efecto 0x74
	call 0413ah		;8763   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;8766
estado_12_subestado_5:
	djnz estado_12_subestado_6		;8769
	call 0781eh		;876b   ; banco 1
	ld a,(0e096h)		;876e   ; los avisos que deja el cuadro
	and a			;8771
	ret z			;8772   ; sin aviso, se espera
	dec a			;8773
	ld a,000h		;8774
	ld (0e096h),a		;8776   ; los avisos que deja el cuadro
	jp nz,avanza_el_subestado		;8779
	ld hl,0e001h		;877c   ; y aqui se salta UN subestado
	inc (hl)			;877f
	jp avanza_el_subestado		;8780
estado_12_subestado_6:
	djnz estado_12_subestado_7		;8783
	call 04232h		;8785   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 06c7fh		;8788   ; banco 1
	call 042fbh		;878b   ; banco 0: sube_los_sprites; subir los sprites
	ld a,(0e0a2h)		;878e   ; el modo en el que esta el juego; el modo, otra vez con sus tres efectos
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
	ld a,003h		;87a6   ; y el subestado vuelve al 3: la escena da la vuelta
	ld (0e001h),a		;87a8   ; el SUBESTADO
	jp avanza_el_subestado		;87ab
estado_12_subestado_7:
	djnz estado_12_subestado_8		;87ae
	call 042edh		;87b0   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;87b3   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 07015h		;87b6   ; banco 1
	call 0463fh		;87b9   ; banco 0: empieza_una_vida; empezar una vida
	call 04995h		;87bc   ; los tres tercios de caracteres
	call 049fch		;87bf
	call 049d2h		;87c2
	call 057fbh		;87c5
	call L_9689		;87c8
	call monta_la_pantalla_entera		;87cb
	call L_9431		;87ce
	call 04265h		;87d1   ; banco 0: sube_el_area_de_juego
	ld a,095h		;87d4
	call 0413ah		;87d6   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;87d9
estado_12_subestado_8:
	djnz estado_12_ultimo		;87dc
	call 04332h		;87de   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;87e1
	ld a,(0e203h)		;87e4   ; el ESTADO de lo que se maneja
	cp 004h		;87e7   ; en el 4 se acaba
	ret nz			;87e9
	call L_9493		;87ea
	ld a,004h		;87ed   ; y al estado 4
	jp pon_el_estado		;87ef
estado_12_ultimo:
	call 042dfh		;87f2
	call 04265h		;87f5   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	ld a,092h		;87f8   ; el efecto 0x92
	call 0413ah		;87fa   ; banco 0: pide_sonido_si_esta_activo
	jp avanza_el_subestado		;87fd

; ----------------------------------------------------------------------
; ESTADO 13: PARADO. Dos llamadas y ya esta. Es donde se queda el juego mientras la pausa este puesta, y de aqui solo se sale por el estado 5, que es quien mira la tecla.
; ----------------------------------------------------------------------
estado_13_la_pausa:
	call escena_despacha_por_0xE0B5		;8800   ; lo que hay que hacer aunque este parado
	jp 0be41h		;8803   ; y lo del banco 3

; ----------------------------------------------------------------------
; ESTADO 14: PERDER UNA VIDA. Aqui esta la cuenta: 0x8833 baja 0xE090 EN BCD y, si ya estaba a cero, se pasa al estado siguiente -que es el de fin de partida-. Si quedaba alguna, se rehace la escena y se vuelve al 4.
; ----------------------------------------------------------------------
estado_14:
	djnz estado_14_quita_una_vida		;8806
	call 04332h		;8808   ; banco 0: sube_los_sprites_desde_arriba
	call L_96F9		;880b
	call 0a985h		;880e   ; banco 3
	ld a,(0e096h)		;8811   ; los avisos que deja el cuadro
	and a			;8814
	ret nz			;8815   ; mientras haya alguno, se espera
	xor a			;8816
	ld (0e0e0h),a		;8817
	jp avanza_el_subestado		;881a
estado_14_quita_una_vida:
	djnz estado_14_espera_y_rehace		;881d
	call 042edh		;881f   ; banco 0: esconde_los_sprites; esconder los sprites
	call 04232h		;8822   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	ld a,(0e0a2h)		;8825   ; el modo en el que esta el juego
	dec a			;8828   ; en el modo 1 se va al estado 8
	jr nz,L_8833		;8829
	ld a,008h		;882b
	call pon_el_estado		;882d
	jp avisa_y_avanza_con_paso		;8830
L_8833:
	ld hl,0e090h		;8833   ; LAS VIDAS
	ld a,(hl)			;8836
	or a			;8837   ; si no queda ninguna, se acabo la partida
	jp z,pasa_al_estado_siguiente		;8838
	sub 001h		;883b   ; una menos...
	daa			;883d   ; ...EN BCD
	ld (hl),a			;883e
	call 04708h		;883f   ; banco 0: reempieza; rehacer sin perder la cuenta
	call 0463fh		;8842   ; banco 0: empieza_una_vida; empezar una vida
	call 05b91h		;8845
	call 0481bh		;8848
	call L_9431		;884b
	call L_9409		;884e
	call L_93FB		;8851
	call 07b5eh		;8854   ; banco 1
	xor a			;8857
	ld (0e0b5h),a		;8858
	ld (0e126h),a		;885b
	inc a			;885e
	ld (0e10eh),a		;885f
	call escena_despacha_por_0xE0B5		;8862
	xor a			;8865
	jp pon_la_espera_y_avanza		;8866   ; y sin espera
estado_14_espera_y_rehace:
	dec b			;8869   ; este subestado se mira con `dec b`, no con `djnz`
	jp nz,L_8919		;886a
	call escena_despacha_por_0xE0B5		;886d
	ld hl,0e004h		;8870   ; la espera
	dec (hl)			;8873
	ret nz			;8874   ; mientras dure, nada
	xor a			;8875
	ld (0e10eh),a		;8876
	ld hl,03b00h		;8879   ; los tres sprites de arriba...
	ld a,0e0h		;887c   ; ...fuera de la pantalla
	call 0004dh		;887e   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b04h		;8881
	ld a,0e0h		;8884
	call 0004dh		;8886   ; BIOS WRTVRM - Writes data in VRAM
	ld hl,03b08h		;8889
	ld a,0e0h		;888c
	call 0004dh		;888e   ; BIOS WRTVRM - Writes data in VRAM
	call 04232h		;8891   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	call 04995h		;8894   ; los tres tercios de caracteres
	call 049fch		;8897
	call 049d2h		;889a
	call 057fbh		;889d
	ld a,(0e0a5h)		;88a0   ; por que vuelta de la fase va
	cp 002h		;88a3   ; la 2 y la 3 tienen su propia carga
	jr z,estado_14_vuelta_2		;88a5
	cp 003h		;88a7
	jr z,estado_14_vuelta_3		;88a9
	call monta_la_pantalla_entera		;88ab
	call L_9689		;88ae
	call 04265h		;88b1   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call L_9493		;88b4
	ld a,004h		;88b7   ; y al estado 4
	jp pon_el_estado		;88b9
estado_14_vuelta_2:
	ld a,(0e093h)		;88bc   ; el valor 1-2-3 de la fase
	cp 003h		;88bf   ; solo el 3 lleva la carga especial
	jr nz,estado_14_vuelta_2_normal		;88c1
	call 0537ah		;88c3
	call 053cfh		;88c6
	call 05424h		;88c9
	call 05498h		;88cc
	call 04265h		;88cf   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call L_9493		;88d2
	ld a,004h		;88d5   ; y al estado 4
	jp pon_el_estado		;88d7
estado_14_vuelta_3:
	call 0537ah		;88da
	call 053cfh		;88dd
	call 05424h		;88e0
	call 05498h		;88e3
	call 057c2h		;88e6
	xor a			;88e9
	ld (0e540h),a		;88ea   ; una bandera a cero
	call 0b165h		;88ed   ; banco 3
	ld a,065h		;88f0   ; el efecto 0x65
	call 0413ah		;88f2   ; banco 0: pide_sonido_si_esta_activo
	ld a,007h		;88f5
	ld (0e000h),a		;88f7   ; la variable de fase; al estado 7...
	ld a,003h		;88fa
	ld (0e001h),a		;88fc   ; ...y al subestado 3
	jp 04265h		;88ff   ; banco 0: sube_el_area_de_juego; subir la zona de juego
estado_14_vuelta_2_normal:
	call 05212h		;8902
	call 05256h		;8905
	call 0529ah		;8908
	call 0530ah		;890b
	call 04265h		;890e   ; banco 0: sube_el_area_de_juego; subir la zona de juego
	call L_9493		;8911
	ld a,004h		;8914
	jp pon_el_estado		;8916
L_8919:
	call 042dfh		;8919
	call 04265h		;891c   ; banco 0: sube_el_area_de_juego
	call 05750h		;891f
	xor a			;8922
	ld (0e21dh),a		;8923   ; por que paso va la secuencia
	ld (0e21bh),a		;8926   ; la cuenta de cuadros del paso en el que va la secuencia
	inc a			;8929
	ld (0e096h),a		;892a   ; los avisos que deja el cuadro
	ld (0e097h),a		;892d   ; la bandera de que la fase se ha acabado
	jp avanza_el_subestado		;8930

; ----------------------------------------------------------------------
; ESTADO 15: FIN DE PARTIDA, Y EL CONTINUE. Lo interesante esta en como se hace el continue: no hay ninguna rutina que "guarde la partida". Lo que hay es un borrado de RAM con las seis cosas que importan a salvo en la PILA -0xE0C6 a 0xE0CB, y por otro lado el numero de fase, la fase, el 1-2-3 y lo de el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2-, y despues de borrar se vuelven a poner. Y las vidas se dejan en DOS, no en las que hubiera al empezar.
; ----------------------------------------------------------------------
estado_15:
	dec b			;8933   ; este se mira con `dec b`, no con `djnz`
	jp nz,estado_15_pinta_el_fin		;8934
	ld a,(0f0f7h)		;8937   ; una bandera que INIT deja a cero
	cp 0feh		;893a   ; y que aqui vale 0xFE
	call nc,mira_si_quiere_continuar		;893c
	ld a,(0e012h)		;893f   ; otra
	or a			;8942
	ret nz			;8943
	ld a,(0e0dfh)		;8944   ; ¿se puede continuar?
	and a			;8947
	jp z,estado_15_se_acabo_del_todo		;8948   ; si no, se acabo del todo
	ld a,(0e0c6h)		;894b   ; las seis cosas de 0xE0C6...
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
	push bc			;8963   ; ...a la pila
	push de			;8964
	push hl			;8965
	ld a,(0e091h)		;8966   ; el numero de fase tal como se pinta
	ld c,a			;8969
	ld a,(0e092h)		;896a   ; la FASE, de 1 a 24
	ld b,a			;896d
	ld a,(0e093h)		;896e   ; el valor 1-2-3 de la fase
	ld e,a			;8971
	ld a,(0e08fh)		;8972   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
	ld d,a			;8975
	push de			;8976   ; y tambien a la pila
	push bc			;8977
	ld hl,0e086h		;8978   ; y ahora se borra la RAM
	ld de,0e087h		;897b
	ld bc,000d9h		;897e   ; 217 bytes desde 0xE086
	ld (hl),000h		;8981
	ldir		;8983
	ld a,(0f0f7h)		;8985   ; la bandera de antes
	cp 0feh		;8988
	jr z,estado_15_borra_lo_demas		;898a
	ld hl,0e160h		;898c   ; otros 143 bytes
	ld de,0e161h		;898f
	ld bc,0008fh		;8992
	ld (hl),000h		;8995
	ldir		;8997
	ld hl,0eba0h		;8999   ; y 64 mas del espejo de pantalla
	ld de,0eba1h		;899c
	ld bc,00040h		;899f
	ld (hl),000h		;89a2
	ldir		;89a4
estado_15_borra_lo_demas:
	ld hl,0e1f0h		;89a6   ; 2.447 bytes de variables de fase
	ld de,0e1f1h		;89a9
	ld bc,0098fh		;89ac
	ld (hl),000h		;89af
	ldir		;89b1
	ld hl,0ebe0h		;89b3   ; y 800 del espejo de la zona de juego
	ld de,0ebe1h		;89b6
	ld bc,0031fh		;89b9
	ld (hl),000h		;89bc
	ldir		;89be
	pop bc			;89c0   ; lo que se salvo
	pop de			;89c1
	ld hl,0e090h		;89c2   ; las vidas...
	ld (hl),002h		;89c5   ; ...que quedan en DOS
	inc l			;89c7
	ld (hl),c			;89c8   ; el numero de fase
	inc l			;89c9
	ld (hl),b			;89ca   ; la fase
	inc l			;89cb
	ld (hl),e			;89cc   ; el 1-2-3
	inc l			;89cd
	inc l			;89ce
	ld (hl),005h		;89cf   ; y un cinco cuatro bytes mas alla
	inc l			;89d1
	ld (hl),000h		;89d2
	inc l			;89d4
	ld (hl),001h		;89d5
	ld a,d			;89d7
	ld (0e08fh),a		;89d8   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
	pop hl			;89db   ; y las seis de 0xE0C6, de vuelta
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
	call 046e3h		;89f6   ; banco 0: monta_la_fase_desde_el_decorado; montar la fase desde el decorado
	call 04232h		;89f9   ; banco 0: borra_el_area_de_juego; borrar la zona de juego
	ld a,003h		;89fc   ; y al estado 3
	jp pon_el_estado		;89fe
estado_15_se_acabo_del_todo:
	ld hl,0e002h		;8a01   ; las banderas de la partida
	ld a,(hl)			;8a04
	and 0bfh		;8a05   ; se le quita el bit 6
	ld (hl),a			;8a07
	xor a			;8a08
	ld (0e082h),a		;8a09   ; y el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2, a cero
	jp estado_a_0xFF		;8a0c   ; y vuelta a la presentacion
estado_15_pinta_el_fin:
	call 04224h		;8a0f   ; banco 0: borra_la_pantalla_entera; borrar la pantalla entera
	ld a,0c8h		;8a12   ; el efecto 0xC8
	call 0413ah		;8a14   ; banco 0: pide_sonido_si_esta_activo
	call 05b91h		;8a17
	ld de,08e30h		;8a1a   ; el rotulo del final
	call 042bch		;8a1d   ; banco 0: pinta_guion_con_mascara; pintado
	ld de,0e085h		;8a20   ; el marcador
	ld hl,03971h		;8a23   ; donde va en la pantalla
	call L_93E3		;8a26
	ld hl,03991h		;8a29   ; y la otra cifra
	ld de,0e088h		;8a2c
	call L_93E3		;8a2f
	ld a,(0f0f7h)		;8a32   ; la bandera de continue
	cp 0feh		;8a35   ; con 0xFE o mas...
	jr c,estado_15_avanza		;8a37
	ld de,08e1eh		;8a39   ; ...se pinta el rotulo de continuar
	call 042bch		;8a3c   ; banco 0: pinta_guion_con_mascara
estado_15_avanza:
	jp avanza_el_subestado		;8a3f

; ----------------------------------------------------------------------
; ¿QUIERE CONTINUAR? Mira el bit 6 de las teclas recien pulsadas y, si esta, enciende 0xE0DF y repinta el rotulo con la mascara a cero -o sea, lo borra-. Lo llama el propio estado 15 desde 0x893C, y solo mientras la bandera de 0xF0F7 lo permita.
; ----------------------------------------------------------------------
mira_si_quiere_continuar:
	ld a,(0e006h)		;8a42   ; las teclas recien pulsadas
	and 040h		;8a45   ; el bit 6
	ret z			;8a47   ; si no se ha pulsado, nada
	ld a,001h		;8a48
	ld (0e0dfh),a		;8a4a   ; se apunta que si
	ld de,08e1eh		;8a4d   ; el rotulo de continuar
	ld c,000h		;8a50   ; con la mascara a cero: se borra
	jp 042beh		;8a52   ; banco 0: pinta_guion_lee_destino

; ----------------------------------------------------------------------
; LO QUE LA MAQUINA DE ESTADOS METE EN LA PILA. No la llama ningun `call`: p02:800B hace `ld hl,0x8A55` y `push hl` antes de despachar, asi que el `ret` del estado cae aqui. Es un `call` escrito del reves, y sirve para que los tres estados de la presentacion compartan la salida sin gastar una llamada. Lo que hace es mirar si se ha pulsado algo para arrancar la partida.
; ----------------------------------------------------------------------
salida_de_la_presentacion:
	call 044c8h		;8a55   ; leer los mandos
	ld hl,0e081h		;8a58   ; y quedarse con lo recien pulsado
	call 044c1h		;8a5b
	or a			;8a5e   ; si no se ha tocado nada, se sigue en la presentacion
	ret z			;8a5f
	ld hl,0e004h		;8a60   ; la espera, a cero
	ld (hl),000h		;8a63
	ld hl,0e000h		;8a65   ; el estado
	ld b,(hl)			;8a68
	djnz salida_desde_el_estado_0		;8a69   ; el 0 va por otro lado
	and 030h		;8a6b   ; en los demas, los bits 4 y 5: la barra o el disparo
	ret z			;8a6d   ; y si no son esos, nada
	ld a,040h		;8a6e   ; el bit 6 de las banderas: se enciende el sonido
	ld (0e002h),a		;8a70
	ld (hl),003h		;8a73   ; al estado 3, que es el menu
	inc hl			;8a75
	ld (hl),000h		;8a76   ; y al subestado 0
	ret			;8a78
salida_desde_el_estado_0:
	ld a,(hl)			;8a79   ; el estado
	and a			;8a7a
	jr nz,salida_arranca_la_presentacion		;8a7b
	ld a,(0e001h)		;8a7d   ; el subestado
	cp 003h		;8a80   ; en el 3 no se hace nada
	ret z			;8a82
salida_arranca_la_presentacion:
	ld (hl),001h		;8a83   ; al estado 1
	ld a,0cbh		;8a85   ; el efecto 0xCB
	call 04145h		;8a87   ; banco 0: pide_sonido
	jp 05c95h		;8a8a   ; y a montar la presentacion

; ----------------------------------------------------------------------
; LA REJILLA DE LA PANTALLA DE FIN. Llena 0x0A00 de la VRAM con ceros y luego escribe en la tabla de nombres una rejilla de seis filas por veintiuna casillas con caracteres consecutivos desde 0x40: cada casilla su propio dibujo, que es como se hace un cartel grande sin repetir nada.
; ----------------------------------------------------------------------
monta_la_rejilla:
	ld hl,00000h		;8a8d
	ld (0e00ah),hl		;8a90
	call 047e2h		;8a93   ; banco 0: pinta_del_banco_6; el guion del banco 6
	ld hl,00a00h		;8a96   ; 0x0A00 de la VRAM
	ld bc,003f0h		;8a99   ; 1008 bytes
	xor a			;8a9c
	call 00056h		;8a9d   ; BIOS FILVRM - Fills VRAM with value | a cero
	ld hl,03907h		;8aa0   ; la esquina de la rejilla
	ld a,040h		;8aa3   ; el primer caracter
	ld c,006h		;8aa5   ; seis filas
	ld de,0000bh		;8aa7   ; y once casillas de salto al final de cada una
monta_la_rejilla_fila:
	ld b,015h		;8aaa   ; veintiuna casillas
monta_la_rejilla_casilla:
	call 0004dh		;8aac   ; BIOS WRTVRM - Writes data in VRAM | BIOS WRTVRM
	inc hl			;8aaf
	inc a			;8ab0   ; y el caracter siguiente
	djnz monta_la_rejilla_casilla		;8ab1
	add hl,de			;8ab3   ; a la fila de abajo
	dec c			;8ab4
	jr nz,monta_la_rejilla_fila		;8ab5
	ret			;8ab7

; ----------------------------------------------------------------------
; IR DESTAPANDO EL CARTEL. Con la rejilla puesta, el cartel se ensena columna a columna escribiendo 0xF0 en los ocho bytes de cada caracter. 0xE00A lleva la columna y 0xE00B la pasada, y se acaba a las seis.
; ----------------------------------------------------------------------
destapa_una_columna:
	ld bc,(0e00ah)		;8ab8   ; por donde va
	ld a,0ebh		;8abc   ; el primer caracter de la rejilla
	inc b			;8abe
destapa_calcula_la_fila:
	add a,015h		;8abf   ; veintiuna casillas por fila
	djnz destapa_calcula_la_fila		;8ac1
	ld l,a			;8ac3
	ld h,b			;8ac4
	add hl,hl			;8ac5   ; por ocho: cada caracter son ocho bytes
	add hl,hl			;8ac6
	add hl,hl			;8ac7
	ld de,00a00h		;8ac8   ; la base de los patrones del cartel
	add hl,de			;8acb
	ld a,c			;8acc
	call 04056h		;8acd   ; banco 0: a_mas_hl; y la columna que toca
	ld b,015h		;8ad0   ; veintiuna filas
	ld de,00008h		;8ad2   ; ocho bytes de una a la siguiente
	ld a,0f0h		;8ad5   ; 0xF0: media casilla encendida
destapa_escribe:
	call 0004dh		;8ad7   ; BIOS WRTVRM - Writes data in VRAM | BIOS WRTVRM
	add hl,de			;8ada
	djnz destapa_escribe		;8adb
	ld hl,0e00ah		;8add   ; la columna
	ld a,(hl)			;8ae0
	inc a			;8ae1   ; la siguiente
	and 007h		;8ae2   ; de ocho en ocho
	ld (hl),a			;8ae4
	ret nz			;8ae5   ; y hasta que no da la vuelta no cuenta una pasada
	inc hl			;8ae6
	inc (hl)			;8ae7   ; una pasada mas
	ld a,(hl)			;8ae8
	cp 006h		;8ae9   ; seis pasadas y se acabo
	ret			;8aeb
escena_despacha_por_0xE0B5:
	ld a,(0e0b5h)		;8aec   ; por que paso va la escena
	ld b,a			;8aef
	djnz L_8AFE		;8af0   ; el 1 es el primero
	ld hl,0e126h		;8af2   ; y si no hay paso, se descuenta la cuenta
	dec (hl)			;8af5
	jp z,L_8CF3		;8af6   ; al acabarse, se acaba la escena
escena_avanza_el_subestado:
	ld hl,0e004h		;8af9
	inc (hl)			;8afc   ; un subestado mas
	ret			;8afd
L_8AFE:
	djnz escena_paso_1		;8afe
	call lee_el_byte_del_guion		;8b00
	ld hl,0e121h		;8b03
	sub (hl)			;8b06
	dec a			;8b07
	jp nz,L_8CF3		;8b08
	ld a,050h		;8b0b
	ld (0e004h),a		;8b0d   ; el contador de espera del estado
	ld b,005h		;8b10
	jp L_8CFA		;8b12

; ----------------------------------------------------------------------
; EL GUION DE LA ESCENA, PASO 1: LA ENTRADA. Lee un byte del guion, lo usa de indice en la tabla de SIETE bytes de 0x8D85 -hasta seis entradas- y de ahi saca una cuenta (0xE126), un puntero de texto (0xE124) y otro puntero que se queda en 0xE11F. Si el destino esta a cero, la escena se acaba.
; ----------------------------------------------------------------------
escena_paso_1:
	djnz escena_paso_2		;8b15   ; si no es el paso 1, al siguiente
	call lee_el_byte_del_guion		;8b17   ; el byte siguiente del guion
	dec a			;8b1a
	cp 006h		;8b1b   ; solo hay seis entradas
	jp nc,L_8CF3		;8b1d
	ld hl,08d85h		;8b20   ; la tabla de siete bytes
	ld b,a			;8b23
	add a,a			;8b24   ; por siete
	ld c,a			;8b25
	add a,a			;8b26
	add a,b			;8b27
	add a,c			;8b28
	call 04056h		;8b29   ; la entrada que toca
	ld a,(hl)			;8b2c   ; la cuenta
	inc hl			;8b2d
	ld e,(hl)			;8b2e   ; el puntero del texto
	inc hl			;8b2f
	ld d,(hl)			;8b30
	inc hl			;8b31
	ld c,(hl)			;8b32   ; y el del guion
	inc hl			;8b33
	ld b,(hl)			;8b34
	inc hl			;8b35
	push af			;8b36
	ld a,(hl)			;8b37
	inc hl			;8b38
	ld h,(hl)			;8b39
	ld l,a			;8b3a
	pop af			;8b3b
	ld (0e126h),a		;8b3c   ; la cuenta, guardada
	ld a,(hl)			;8b3f
	and a			;8b40   ; con el destino a cero, se acabo
	jp z,L_8CF3		;8b41
	ld (0e124h),de		;8b44   ; el texto...
	ld (0e11fh),bc		;8b48   ; ...y el guion
	ld b,006h		;8b4c   ; y al paso 6
	jp L_8CFA		;8b4e

; ----------------------------------------------------------------------
; EL BYTE SIGUIENTE DEL GUION. El puntero vive en 0xE11F y se adelanta ANTES de leer, o sea que apunta siempre al ultimo byte servido, no al siguiente.
; ----------------------------------------------------------------------
lee_el_byte_del_guion:
	ld de,(0e11fh)		;8b51   ; el puntero del guion
adelanta_y_lee:
	inc de			;8b55   ; se adelanta primero...
	ld (0e11fh),de		;8b56
	ld a,(de)			;8b5a   ; ...y se lee despues
	ret			;8b5b

; ----------------------------------------------------------------------
; EL PASO 2: RETOCAR OCHO COLORES. Lee ocho bytes de la VRAM uno a uno y, a los que tengan 1 en el nibble alto, les mete 9: o sea que un color se cambia por otro sin volver a pintar nada.
; ----------------------------------------------------------------------
escena_paso_2:
	djnz escena_paso_3		;8b5c   ; si no es el paso 2, al siguiente
	call lee_el_byte_del_guion		;8b5e   ; de donde
	ld b,008h		;8b61   ; ocho bytes
	ld l,a			;8b63
	call adelanta_y_lee		;8b64
	ld h,a			;8b67
retoca_un_color:
	call 0004ah		;8b68   ; BIOS RDVRM - Reads the content of VRAM | BIOS RDVRM: el que hay
	ld c,a			;8b6b
	and 0f0h		;8b6c   ; su nibble alto
	cp 010h		;8b6e   ; ¿es el 1?
	jr nz,L_8B74		;8b70
	ld a,090h		;8b72   ; pues el 9
L_8B74:
	or c			;8b74
	call 0004dh		;8b75   ; BIOS WRTVRM - Writes data in VRAM | y devuelto
	inc hl			;8b78
	djnz retoca_un_color		;8b79
	call L_8CFF		;8b7b
	ld b,002h		;8b7e
	jp L_8CFA		;8b80

; ----------------------------------------------------------------------
; EL PASO 3: LOS SPRITES DE LA ESCENA. Una cuenta larga en 0xE141 que baja de 0x200, y el bit 4 del byte bajo escoge entre dos juegos de sprites: eso es lo que hace que la figura se mueva sola. 0xE143 dice cual de las cuatro parejas de juegos toca -0x8D09/0x8D16, 0x8D23/0x8D34, 0x8D41/0x8D52 y 0x8D63/0x8D74- y da la vuelta al llegar a cuatro.
; ----------------------------------------------------------------------
escena_paso_3:
	dec b			;8b83   ; si no es el paso 3, al siguiente
	jp nz,escena_paso_4		;8b84
	ld hl,(0e141h)		;8b87   ; la cuenta larga
	dec hl			;8b8a   ; uno menos
	ld (0e141h),hl		;8b8b
	ld a,l			;8b8e
	or h			;8b8f   ; al llegar a cero, se cambia de pareja
	jp z,cambia_de_pareja_de_juegos		;8b90
	ld a,(0e143h)		;8b93   ; que pareja toca
	and a			;8b96
	jp nz,la_segunda_pareja_de_juegos		;8b97
	ld ix,08d09h		;8b9a   ; la primera...
	bit 4,l		;8b9e   ; ...y su bit 4 escoge cual de las dos
	jr z,pinta_los_sprites_de_la_escena		;8ba0
	ld ix,08d16h		;8ba2
pinta_los_sprites_de_la_escena:
	ld a,(ix+000h)		;8ba6   ; cuantos sprites
	ld b,a			;8ba9
	inc ix		;8baa
	ld de,03b00h		;8bac   ; la tabla de atributos, en la VRAM
pinta_un_sprite_de_la_escena:
	ld hl,0e122h		;8baf   ; los dos desplazamientos
	ld a,(ix+000h)		;8bb2
	push af			;8bb5
	ld a,(0e139h)		;8bb6   ; ¿va mirando al otro lado?
	and a			;8bb9
	jr z,L_8BC1		;8bba
	pop af			;8bbc
	neg		;8bbd   ; pues el desplazamiento, cambiado de signo
	jr escribe_el_sprite_en_la_vram		;8bbf
L_8BC1:
	pop af			;8bc1
escribe_el_sprite_en_la_vram:
	add a,(hl)			;8bc2   ; la fila
	ld c,a			;8bc3
	inc hl			;8bc4
	ld a,(hl)			;8bc5
	add a,(ix+001h)		;8bc6   ; y la columna
	ex de,hl			;8bc9
	call 0004dh		;8bca   ; BIOS WRTVRM - Writes data in VRAM | BIOS WRTVRM: la fila
	ld a,c			;8bcd
	inc hl			;8bce
	call 0004dh		;8bcf   ; BIOS WRTVRM - Writes data in VRAM | y la columna
	ld a,(ix+002h)		;8bd2   ; el dibujo
	ld c,a			;8bd5
	ld a,(0e139h)		;8bd6   ; mirando al otro lado...
	and a			;8bd9
	jr z,L_8BE0		;8bda
	ld a,004h		;8bdc   ; ...son cuatro dibujos mas alla
	add a,c			;8bde
	ld c,a			;8bdf
L_8BE0:
	ld a,c			;8be0
	inc hl			;8be1
	call 0004dh		;8be2   ; BIOS WRTVRM - Writes data in VRAM | el dibujo
	ld a,(ix+003h)		;8be5   ; y el color
	inc hl			;8be8
	call 0004dh		;8be9   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;8bec
	ex de,hl			;8bed
	inc ix		;8bee   ; cuatro bytes por sprite
	inc ix		;8bf0
	inc ix		;8bf2
	inc ix		;8bf4
	djnz pinta_un_sprite_de_la_escena		;8bf6
	ld a,0d0h		;8bf8   ; y al acabar, 0xD0 en la fila del siguiente: los demas no se pintan
	ex de,hl			;8bfa
	jp 0004dh		;8bfb   ; BIOS WRTVRM - Writes data in VRAM
la_segunda_pareja_de_juegos:
	dec a			;8bfe   ; ¿la segunda pareja?
	jr nz,la_tercera_pareja_de_juegos		;8bff
	ld ix,08d23h		;8c01   ; el primer juego...
	bit 4,l		;8c05   ; ...y su bit 4 escoge cual de los dos
	jp z,pinta_los_sprites_de_la_escena		;8c07
	ld ix,08d34h		;8c0a
	jp pinta_los_sprites_de_la_escena		;8c0e
la_tercera_pareja_de_juegos:
	dec a			;8c11   ; ¿la tercera pareja?
	jr nz,la_cuarta_pareja_de_juegos		;8c12
	ld ix,08d41h		;8c14   ; el primer juego...
	bit 4,l		;8c18   ; ...y su bit 4 escoge
	jp z,pinta_los_sprites_de_la_escena		;8c1a
	ld ix,08d52h		;8c1d
	jp pinta_los_sprites_de_la_escena		;8c21
la_cuarta_pareja_de_juegos:
	ld ix,08d63h		;8c24   ; la cuarta, la que queda
	bit 4,l		;8c28   ; y su bit 4 escoge
	jp z,pinta_los_sprites_de_la_escena		;8c2a
	ld ix,08d74h		;8c2d
	jp pinta_los_sprites_de_la_escena		;8c31
cambia_de_pareja_de_juegos:
	ld hl,00200h		;8c34   ; la cuenta, otra vez a 0x200
	ld (0e141h),hl		;8c37
	ld hl,0e143h		;8c3a
	inc (hl)			;8c3d   ; la pareja siguiente
	ld a,(hl)			;8c3e
	sub 004h		;8c3f   ; y a la cuarta...
	ret nz			;8c41
	ld (hl),a			;8c42   ; ...vuelta a la primera
	ret			;8c43

; ----------------------------------------------------------------------
; EL PASO 4: EL TEXTO, CARACTER A CARACTER. Uno de cada cuatro cuadros: lee del guion de 0xE124 una direccion de pantalla y un caracter, y lo escribe con WRTVRM. Cuando se acaba la cuenta de 0xE126, al paso 2.
; ----------------------------------------------------------------------
escena_paso_4:
	djnz escena_paso_5		;8c44   ; si no es el paso 4, al siguiente
	ld a,(0e003h)		;8c46   ; el contador de cuadros
	and 003h		;8c49   ; uno de cada cuatro
	jp nz,escena_avanza_el_subestado		;8c4b
	ld de,(0e124h)		;8c4e   ; el guion del texto
	ld a,(de)			;8c52   ; la direccion de pantalla...
	ld l,a			;8c53
	inc de			;8c54
	ld a,(de)			;8c55
	ld h,a			;8c56
	inc de			;8c57
	ld a,(de)			;8c58   ; ...y el caracter
	call 0004dh		;8c59   ; BIOS WRTVRM - Writes data in VRAM | BIOS WRTVRM
	inc de			;8c5c
	ld (0e124h),de		;8c5d   ; el guion, adelantado
	call L_8CFF		;8c61
	ld hl,0e126h		;8c64
	dec (hl)			;8c67   ; un caracter menos
	ld b,002h		;8c68
	jp z,L_8CFA		;8c6a   ; y al acabarse, al paso 2
	jp escena_avanza_el_subestado		;8c6d

; ----------------------------------------------------------------------
; EL PASO 5: LA LINEA SIGUIENTE. Copia de un tiron los 26 bytes de una linea a la tabla de nombres: la linea de origen esta 0x1A mas alla de la anterior en 0x8E7C y la de destino 0x20 mas alla en la pantalla, empezando en 0x3923. Se llega hasta la linea 15, y alli se acaba.
; ----------------------------------------------------------------------
escena_paso_5:
	xor a			;8c70
	ld (0e139h),a		;8c71   ; mirando hacia el lado de siempre
	ld hl,0e126h		;8c74
	inc (hl)			;8c77   ; una linea mas
	ld a,(hl)			;8c78
	cp 00fh		;8c79   ; ¿la quince?
	jr z,se_acabo_el_texto		;8c7b
	ld hl,03923h		;8c7d   ; la primera linea de la pantalla
	ld (0e124h),hl		;8c80
	ld hl,08e7ch		;8c83   ; y el primer texto
	dec a			;8c86   ; la primera va directa
	jr z,copia_la_linea		;8c87
	ld b,a			;8c89
salta_a_la_linea_que_toca:
	ld de,0001ah		;8c8a   ; 26 bytes por linea de texto...
	add hl,de			;8c8d
	push hl			;8c8e
	ld hl,(0e124h)		;8c8f
	ld de,00020h		;8c92   ; ...y 32 por linea de pantalla
	add hl,de			;8c95
	ld (0e124h),hl		;8c96
	pop hl			;8c99
	djnz salta_a_la_linea_que_toca		;8c9a
copia_la_linea:
	ex de,hl			;8c9c
	ld hl,(0e124h)		;8c9d
	ld bc,0001ah		;8ca0   ; los 26 caracteres
	jp 0428fh		;8ca3   ; banco 0: de un tiron a la VRAM
se_acabo_el_texto:
	ld b,040h		;8ca6   ; 0x40 de espera...
	ld a,(0e10eh)		;8ca8   ; ...o solo 1 si 0xE10E esta puesto
	and a			;8cab
	jr z,arranca_la_espera_del_final		;8cac
	ld b,001h		;8cae
arranca_la_espera_del_final:
	ld a,b			;8cb0
	ld (0e126h),a		;8cb1   ; la espera
	ld hl,00200h		;8cb4   ; la cuenta larga, otra vez a 0x200
	ld (0e141h),hl		;8cb7
	xor a			;8cba
	ld (0e143h),a		;8cbb   ; la pareja de juegos, a la primera
	ld a,(0e092h)		;8cbe   ; y la fase
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
	jp escena_avanza_el_subestado		;8cf7
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
; DATOS listas_de_sprites_para_IX: ocho listas que p02:8B9A, 8BA2, 8C01, 8C0A,
;   8C14, 8C1D, 8C24 y 8C2D ponen en IX: un byte con la cuenta B y B atributos
;   de sprite de 4 bytes que p02:8BA6 manda a 0x3B00 (las de 13 bytes llevan
;   tres, las de 17 cuatro)
;   0x8d09..0x8d85  (124 bytes)
DATA_listas_de_sprites_para_IX:
	defb 003h,008h,004h,0e0h,00ah,000h,0feh,0d8h,00fh,000h,000h,0d0h,001h,003h,000h,003h,0f8h	; 8d09  .................
	defb 00ah,005h,000h,0f0h,00fh,000h,0ffh,0e8h,001h,004h,003h,003h,050h,00ah,005h,000h,048h	; 8d1a  ............P...H
	defb 00fh,008h,00fh,040h,001h,001h,0ffh,038h,001h,003h,003h,005h,068h,00ah,006h,000h,060h	; 8d2b  ...@...8....h...`
	defb 00fh,002h,000h,058h,001h,004h,002h,004h,080h,00ah,002h,001h,078h,00fh,0fch,000h,070h	; 8d3c  ...X........x...p
	defb 001h,00ch,00eh,088h,001h,004h,003h,005h,0a0h,00ah,003h,000h,098h,00fh,0fch,000h,090h	; 8d4d  .................
	defb 001h,00ch,00eh,088h,001h,004h,002h,0f6h,0a8h,00fh,003h,003h,0c0h,006h,008h,001h,0b8h	; 8d5e  .................
	defb 00ah,004h,0fdh,0b0h,001h,004h,002h,0f7h,0c8h,00fh,003h,003h,0c0h,006h,008h,001h,0b8h	; 8d6f  .................
	defb 00ah,004h,0fdh,0b0h,001h	; 8d80

; ----------------------------------------------------------------------
; DATOS entradas_de_7_8D85: seis entradas de 7 bytes: p02:8B20 multiplica A
;   por siete sobre 0x8D85
;   0x8d85..0x8daf  (42 bytes)
DATA_entradas_de_7_8D85:
	defb 008h,0dch,090h,013h,090h,0c6h,0e0h	; 8d85
	defb 009h,0f4h,090h,02bh,090h,0c7h,0e0h	; 8d8c
	defb 00ch,00fh,091h,047h,090h,0c8h,0e0h	; 8d93
	defb 003h,033h,091h,05fh,090h,0c9h,0e0h	; 8d9a
	defb 009h,03ch,091h,07bh,090h,0cah,0e0h	; 8da1
	defb 00ch,057h,091h,09bh,090h,0cbh,0e0h	; 8da8

; ----------------------------------------------------------------------
; DATOS tira_8DAF: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara; lo cargan p02:93D1 (18 bytes)
;   0x8daf..0x8dc1  (18 bytes)
DATA_tira_8DAF:
	defb 0c9h,038h,028h,029h,033h,023h,02fh,032h,025h,0feh,0e9h,038h,033h,023h,02fh,032h	; 8daf  .8()3#/2%..83#/2
	defb 025h,0ffh	; 8dbf

; ----------------------------------------------------------------------
; DATOS tira_8DC1: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara; se entra por 0x8DC1, 0x8DC9; lo cargan
;   p02:93FE, p02:940C (16 bytes)
;   0x8dc1..0x8dd1  (16 bytes)
DATA_tira_8DC1:
	defb 089h,038h,033h,034h,021h,027h,025h,0feh,0a9h,038h,02ch,029h,036h,025h,033h,0ffh	; 8dc1  .834!'%..8,)6%3.

; ----------------------------------------------------------------------
; DATOS dos_rotulos_8DD1: dos guiones de bytes (0xFF acaba) que p02:93EB y
;   93F0 pasan en DE a p00:42C1 con HL = 0x3869: uno u otro segun A
;   0x8dd1..0x8de7  (22 bytes)
DATA_dos_rotulos_8DD1:
	defb 02ch,025h,036h,025h,02ch,000h,000h,000h,010h,011h,0ffh	; 8dd1  ,%6%,......
	defb 02ch,025h,036h,025h,02ch,000h,000h,000h,010h,012h,0ffh	; 8ddc  ,%6%,......

; ----------------------------------------------------------------------
; DATOS tira_8DE7: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara y pinta_guion_lee_destino; lo cargan p02:80A6,
;   p02:80AB (17 bytes)
;   0x8de7..0x8df8  (17 bytes)
DATA_tira_8DE7:
	defb 0aah,03ah,030h,035h,033h,028h,042h,033h,030h,021h,023h,025h,042h,02bh,025h,039h	; 8de7  .:053(B30!#%B+%9
	defb 0ffh	; 8df7

; ----------------------------------------------------------------------
; DATOS tira_8DF8: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara; lo cargan p02:80C0 (15 bytes)
;   0x8df8..0x8e07  (15 bytes)
DATA_tira_8DF8:
	defb 029h,039h,02ch,025h,036h,025h,02ch,000h,033h,025h,02ch,025h,023h,034h,0ffh	; 8df8  )9,%6%,.3%,%#4.

; ----------------------------------------------------------------------
; DATOS tres_bytes_8E07: el guion `1B 1C FF` que p02:9215 pasa a p00:42C1: dos
;   caracteres y el 0xFF que acaba
;   0x8e07..0x8e0a  (3 bytes)
DATA_tres_bytes_8E07:
	defb 01bh,01ch,0ffh	; 8e07

; ----------------------------------------------------------------------
; DATOS tira_8E0A: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara y pinta_guion_lee_destino; lo cargan p02:80C6,
;   p02:8103 (10 bytes)
;   0x8e0a..0x8e14  (10 bytes)
DATA_tira_8E0A:
	defb 08dh,039h,02ch,025h,036h,025h,02ch,000h,011h,0ffh	; 8e0a  .9,%6%,...

; ----------------------------------------------------------------------
; DATOS tira_8E14: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara y pinta_guion_lee_destino; lo cargan p02:80CC,
;   p02:812A (10 bytes)
;   0x8e14..0x8e1e  (10 bytes)
DATA_tira_8E14:
	defb 0edh,039h,02ch,025h,036h,025h,02ch,000h,012h,0ffh	; 8e14  .9,%6%,...

; ----------------------------------------------------------------------
; DATOS tira_8E1E: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara y pinta_guion_lee_destino; lo cargan p02:8A3C,
;   p02:8A52 (18 bytes)
;   0x8e1e..0x8e30  (18 bytes)
DATA_tira_8E1E:
	defb 0c9h,038h,026h,015h,000h,02bh,025h,039h,000h,023h,02fh,02eh,034h,029h,02eh,035h	; 8e1e  .8&..+%9.#/.4).5
	defb 025h,0ffh	; 8e2e

; ----------------------------------------------------------------------
; DATOS tira_8E30: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara; lo cargan p02:8A1D (31 bytes)
;   0x8e30..0x8e4f  (31 bytes)
DATA_tira_8E30:
	defb 00bh,039h,027h,021h,02dh,025h,000h,000h,02fh,036h,025h,032h,0feh,069h,039h,028h	; 8e30  .9'!-%../6%2.i9(
	defb 029h,033h,023h,02fh,032h,025h,0feh,089h,039h,033h,023h,02fh,032h,025h,0ffh	; 8e40  )3#/2%..93#/2%.

; ----------------------------------------------------------------------
; DATOS tira_8E4F: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_con_mascara; lo cargan p02:9434 (23 bytes)
;   0x8e4f..0x8e66  (23 bytes)
DATA_tira_8E4F:
	defb 002h,038h,034h,029h,02dh,025h,0feh,00ah,038h,024h,029h,033h,034h,0feh,013h,038h	; 8e4f  .84)-%..8$)34..8
	defb 01bh,01ch,0feh,019h,038h,01dh,0ffh	; 8e5f

; ----------------------------------------------------------------------
; DATOS rotulo_8E66: guion con su destino delante (0x380A) y bytes hasta el
;   0xFF, que p02:9457 carga en DE para el pintor con mascara
;   0x8e66..0x8e71  (11 bytes)
DATA_rotulo_8E66:
	defb 00ah,038h,000h,020h,022h,02fh,02eh,035h,033h,020h,0ffh	; 8e66  .8. "/.53 .

; ----------------------------------------------------------------------
; DATOS tira_8E71: guion de bytes sueltos (0xFF acaba, 0xFE otro destino) que
;   lee pinta_guion_lee_destino; lo cargan p02:9466 (11 bytes)
;   0x8e71..0x8e7c  (11 bytes)
DATA_tira_8E71:
	defb 00ah,038h,000h,020h,037h,021h,032h,030h,020h,000h,0ffh	; 8e71  .8. 7!20 ..

; ----------------------------------------------------------------------
; DATOS imagen_de_14_filas: una imagen de 14 filas de 26 caracteres: p02:8C83
;   copia la fila (0xE126) - 1 con copia_a_vram a 0x3923 + 0x20 por fila, y a
;   la fila 15 lo deja (p02:8C79)
;   0x8e7c..0x8fe8  (364 bytes)
DATA_imagen_de_14_filas:
	defb 044h,045h,046h,047h,048h,049h,04ah,04bh,04ch,043h,04dh,043h,043h,04dh,04dh,043h,043h,043h,045h,046h,048h,049h,04ah,045h,043h,0ceh	; 8e7c  DEFGHIJKLCMCCMMCCCEFHIJEC.
	defb 0c9h,054h,055h,041h,041h,041h,041h,041h,041h,041h,041h,060h,061h,042h,042h,042h,062h,063h,042h,042h,042h,042h,064h,065h,066h,0cfh	; 8e96  .TUAAAAAAAA`aBBBbcBBBBdef.
	defb 0cah,056h,041h,041h,041h,041h,041h,041h,041h,041h,041h,067h,07ch,042h,042h,042h,068h,069h,042h,042h,042h,042h,06ah,06bh,06ch,050h	; 8eb0  .VAAAAAAAAAg|BBBhiBBBBjklP
	defb 04eh,057h,0cch,0d1h,041h,08eh,08fh,090h,091h,06dh,041h,098h,099h,09ah,042h,042h,042h,042h,089h,08ah,08bh,07fh,080h,081h,05fh,0d0h	; 8eca  NW..A....mA...BBBB......_.
	defb 04fh,05eh,0cdh,0d2h,058h,059h,05ah,05bh,092h,06eh,06fh,097h,07ah,09bh,042h,042h,070h,042h,082h,040h,040h,040h,083h,084h,07dh,051h	; 8ee4  O^..XYZ[.no.z.BBpB.@@@..}Q
	defb 043h,05ch,0a9h,0aah,0abh,041h,041h,041h,093h,094h,095h,096h,07bh,09ch,042h,042h,09fh,0a0h,0a1h,0a2h,0a3h,0a4h,0a5h,0a6h,07eh,052h	; 8efe  C\...AAA....{.BB........~R
	defb 0cbh,05dh,0a8h,041h,071h,042h,072h,073h,074h,075h,076h,077h,078h,09dh,042h,079h,09eh,085h,086h,087h,08ch,08dh,040h,0a7h,088h,053h	; 8f18  .].AqBrstuvwx.By......@..S
	defb 044h,041h,0b3h,0b2h,0b1h,0b0h,0afh,05ah,05bh,05ch,05dh,05eh,05fh,094h,095h,096h,097h,042h,042h,08bh,09bh,09ah,099h,098h,059h,0d3h	; 8f32  DA.....Z[\]^_....BB.....Y.
	defb 0cch,041h,041h,060h,042h,042h,0aeh,061h,062h,063h,064h,065h,066h,067h,068h,069h,06ah,09fh,09eh,09dh,09ch,040h,040h,08ch,058h,047h	; 8f4c  .AA`BB.abcdefghij....@@.XG
	defb 0cdh,041h,06bh,042h,042h,06ch,0adh,06dh,0a9h,0a8h,0a7h,0a6h,0a5h,0a4h,0a3h,0a2h,0a1h,0a0h,08ah,08dh,08eh,040h,040h,08fh,06eh,0d2h	; 8f66  .AkBBl.m.............@@.n.
	defb 0ceh,041h,06fh,070h,071h,072h,0ach,0abh,0aah,041h,073h,042h,042h,074h,075h,076h,041h,041h,077h,042h,090h,040h,091h,092h,078h,0d0h	; 8f80  .Aopqr...AsBBtuvAAwB.@..x.
	defb 045h,041h,041h,041h,041h,041h,079h,07ah,07bh,07ch,042h,042h,07dh,041h,041h,041h,07eh,07fh,042h,080h,042h,093h,042h,042h,081h,0d0h	; 8f9a  EAAAAAyz{|BB}AAA~.B.B.BB..
	defb 0cfh,057h,041h,041h,041h,041h,082h,083h,084h,042h,042h,085h,086h,041h,041h,041h,087h,088h,042h,089h,042h,042h,042h,042h,042h,0d1h	; 8fb4  .WAAAA...BB..AAA..B.BBBBB.
	defb 046h,049h,043h,04ah,04bh,043h,04ch,043h,04dh,04eh,04fh,050h,043h,043h,051h,052h,053h,054h,055h,056h,043h,043h,043h,04ch,043h,048h	; 8fce  FICJKCLCMNOPCCQRSTUVCCCLCH

; ----------------------------------------------------------------------
; DATOS tira_de_E11F: la tira que p02:8B51 va leyendo byte a byte con
;   (0xE11F): p02:8CDD pone el puntero en 0x8FE7, el byte ANTERIOR, porque
;   0x8B55 incrementa antes de leer. Lleva direcciones de VRAM y valores;
;   llega hasta la tabla de 0x917B
;   0x8fe8..0x917b  (403 bytes)
DATA_tira_de_E11F:
	defb 001h,000h,070h,00ch,001h,001h,078h,00ch,002h,000h,080h,00ch,002h,000h,088h,00ch	; 8fe8  ..p...x.........
	defb 003h,000h,090h,00ch,003h,000h,098h,00ch,004h,000h,0a0h,00ch,004h,000h,0a8h,00ch	; 8ff8  ................
	defb 005h,000h,0b0h,00ch,006h,000h,0b8h,00ch,006h,000h,0c0h,00ch,006h,002h,0c8h,00ch	; 9008  ................
	defb 007h,000h,0d8h,00ch,008h,000h,0e0h,00ch,008h,000h,0e8h,00ch,008h,000h,0a0h,014h	; 9018  ................
	defb 009h,000h,0a8h,014h,009h,003h,0b0h,014h,00ah,000h,0b8h,014h,00ah,000h,0f0h,00ch	; 9028  ................
	defb 00ah,000h,0f8h,00ch,00bh,000h,000h,00dh,00bh,000h,008h,00dh,00ch,000h,010h,00dh	; 9038  ................
	defb 00ch,000h,018h,00dh,00dh,000h,020h,00dh,00dh,004h,028h,00dh,00eh,000h,038h,00dh	; 9048  ...... ...(...8.
	defb 00eh,000h,0c0h,014h,00fh,000h,0c8h,014h,00fh,005h,0d0h,014h,00fh,000h,0d8h,014h	; 9058  ................
	defb 010h,000h,0e0h,014h,011h,000h,0e8h,014h,011h,000h,0f0h,014h,011h,000h,0f8h,014h	; 9068  ................
	defb 012h,000h,000h,015h,012h,006h,008h,015h,013h,000h,010h,015h,013h,000h,018h,015h	; 9078  ................
	defb 014h,000h,020h,015h,014h,000h,028h,015h,014h,000h,028h,015h,014h,000h,030h,015h	; 9088  .. ...(...(...0.
	defb 015h,000h,038h,015h,015h,000h,040h,015h,016h,000h,048h,015h,016h,000h,050h,015h	; 9098  ..8...@...H...P.
	defb 016h,000h,058h,015h,016h,000h,060h,015h,017h,000h,068h,015h,017h,000h,070h,015h	; 90a8  ..X...`...h...p.
	defb 017h,000h,078h,015h,017h,000h,080h,015h,017h,000h,088h,015h,018h,000h,090h,015h	; 90b8  ..x.............
	defb 018h,000h,098h,015h,018h,000h,040h,00dh,018h,000h,048h,00dh,018h,000h,050h,00dh	; 90c8  ......@...H...P.
	defb 018h,000h,058h,00dh,089h,039h,0ach,069h,039h,0adh,06ah,039h,0aeh,06bh,039h,0afh	; 90d8  ..X..9.i9.j9.k9.
	defb 06ch,039h,0b0h,06dh,039h,0b1h,08dh,039h,0b2h,08eh,039h,0b3h,08fh,039h,0b4h,06fh	; 90e8  l9.m9..9..9..9.o
	defb 039h,0b5h,070h,039h,0b6h,071h,039h,0b7h,091h,039h,0b8h,0b1h,039h,0b9h,0d1h,039h	; 90f8  9.p9.q9..9..9..9
	defb 0bah,0f1h,039h,0bbh,011h,03ah,0b4h,012h,03ah,0b5h,0f2h,039h,0bch,0d2h,039h,0bdh	; 9108  ..9..:..:..9..9.
	defb 0b2h,039h,0beh,092h,039h,0bfh,093h,039h,0c0h,094h,039h,0c1h,095h,039h,0c2h,096h	; 9118  .9..9..9..9..9..
	defb 039h,0c3h,097h,039h,0c4h,0b7h,039h,0c5h,0d7h,039h,0c6h,0d9h,039h,0c7h,0f9h,039h	; 9128  9..9..9..9..9..9
	defb 0c8h,019h,03ah,0b6h,018h,03ah,0b7h,038h,03ah,0b8h,058h,03ah,0b9h,078h,03ah,0bah	; 9138  ..:..:.8:.X:.x:.
	defb 077h,03ah,0bbh,076h,03ah,0bch,075h,03ah,0bdh,074h,03ah,0beh,054h,03ah,0bfh,053h	; 9148  w:.v:.u:.t:.T:.S
	defb 03ah,0c0h,073h,03ah,0c1h,093h,03ah,0c2h,092h,03ah,0c3h,091h,03ah,0c4h,090h,03ah	; 9158  :.s:..:..:..:..:
	defb 0c5h,08fh,03ah,0c6h,08eh,03ah,0c7h,08dh,03ah,0c8h,08ch,03ah,0c9h,06ch,03ah,0cah	; 9168  ..:..:..:..:.l:.
	defb 04ch,03ah,0cbh	; 9178

; ----------------------------------------------------------------------
; DATOS palabras_por_fase_917B: 25 palabras: p02:8CD0 lleva a 0xE122 la de la
;   fase (0xE092) - 1
;   0x917b..0x91ad  (50 bytes)
DATA_palabras_por_fase_917B:
	defb 033h,052h	; 917b
	defb 048h,052h	; 917d
	defb 056h,052h	; 917f
	defb 04bh,070h	; 9181
	defb 069h,07ah	; 9183
	defb 063h,062h	; 9185
	defb 07bh,052h	; 9187
	defb 08bh,064h	; 9189
	defb 07fh,083h	; 918b
	defb 091h,083h	; 918d
	defb 099h,062h	; 918f
	defb 0a9h,062h	; 9191
	defb 0b9h,062h	; 9193
	defb 0cah,062h	; 9195
	defb 0cfh,08ah	; 9197
	defb 0c3h,08ah	; 9199
	defb 0b3h,092h	; 919b
	defb 0abh,092h	; 919d
	defb 08fh,09ah	; 919f
	defb 07fh,09ah	; 91a1
	defb 069h,09ah	; 91a3
	defb 057h,082h	; 91a5
	defb 035h,096h	; 91a7
	defb 030h,08ah	; 91a9
	defb 03dh,070h	; 91ab

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
; DATOS despacho_de_91B9: 4 punteros pegados detras del `call despacha` de
;   p02:91B9: la rutina a la que se salta con A
;   0x91bc..0x91c4  (8 bytes)
DATA_despacho_de_91B9:
	defb 0f6h,091h	; 91bc
	defb 0c4h,091h	; 91be
	defb 0e2h,091h	; 91c0
	defb 0f6h,091h	; 91c2

; ======================================================================
; CODIGO 0x91c4..0x935f  (411 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; SUBIR LA BARRA CADA SEIS PASOS. Borra 0xE202, cuenta en 0xE201 y, cada seis, mira 0xE160 para decidir el tope: 7 si esta a cero y 5 si no. Eso es lo que hace que la barra suba antes o despues segun lo que se lleve.
; ----------------------------------------------------------------------
sube_la_barra_cada_seis:
	ld hl,0e202h		;91c4   ; el otro contador, a cero
	ld (hl),000h		;91c7
	dec l			;91c9
	inc (hl)			;91ca   ; uno mas
	ld a,(hl)			;91cb
	sub 006h		;91cc   ; ¿ya van seis?
	ret nz			;91ce
	ld (hl),a			;91cf   ; vuelta a cero
	ld a,(0e160h)		;91d0   ; y 0xE160 escoge el tope
	and a			;91d3
	ld c,007h		;91d4   ; sin el, el 7...
	jr z,L_91DA		;91d6
	ld c,005h		;91d8   ; ...y con el, el 5
L_91DA:
	ld hl,0e4c0h		;91da   ; el nivel de la barra
	ld a,(hl)			;91dd
	cp c			;91de
	ret c			;91df
	dec (hl)			;91e0
	ret			;91e1

; ----------------------------------------------------------------------
; BAJAR LA BARRA CADA CUATRO PASOS. La pareja de la anterior, con el otro contador: cada cuatro pasos sube el nivel de 0xE4C0, con tope en 0x19. Ojo al sentido: un numero MAS ALTO es un periodo mas largo, o sea que se anda mas despacio.
; ----------------------------------------------------------------------
baja_la_barra_cada_cuatro:
	ld hl,0e201h		;91e2   ; el otro contador, a cero
	ld (hl),000h		;91e5
	inc l			;91e7
	inc (hl)			;91e8   ; uno mas
	ld a,(hl)			;91e9
	sub 004h		;91ea   ; ¿ya van cuatro?
	ret nz			;91ec
	ld (hl),a			;91ed   ; vuelta a cero
	ld hl,0e4c0h		;91ee   ; el nivel de la barra
	ld a,(hl)			;91f1
	cp 019h		;91f2   ; con tope en 0x19
	ret nc			;91f4
	inc (hl)			;91f5   ; uno mas
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
	ld a,(0e082h)		;9207   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
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
	ld hl,(0e08bh)		;923b   ; el TIEMPO que queda
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
	ld a,(0e203h)		;925d   ; el ESTADO de lo que se maneja
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
	ld (0e203h),a		;9278   ; el ESTADO de lo que se maneja
	xor a			;927b
	ld (0e21dh),a		;927c   ; por que paso va la secuencia
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
	jr nz,al_sprite_siguiente		;92d9
	ld (hl),c			;92db
al_sprite_siguiente:
	inc l			;92dc   ; cuatro bytes por sprite
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
	ld a,(0e0a6h)		;92fb   ; el arrastre de lado que se lleva solo
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
	jp 061f3h		;9322   ; banco 1
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

; ----------------------------------------------------------------------
; BORRAR LA PARTIDA. Los 0xE7A bytes de 0xE086 en adelante a cero, y luego los ocho de 0x935F a 0xE090: dos vidas, y unos y ceros que son con lo que se empieza.
; ----------------------------------------------------------------------
borra_la_partida:
	ld hl,0e086h		;9346   ; desde el marcador
	ld bc,00e7ah		;9349   ; 3.706 bytes
	ld d,h			;934c
	ld e,l			;934d
	inc e			;934e
	ld (hl),000h		;934f
	ldir		;9351
	ld hl,0935fh		;9353   ; y los ocho de partida
	ld de,0e090h		;9356   ; a 0xE090
	ld bc,00008h		;9359
	ldir		;935c
	ret			;935e

; ----------------------------------------------------------------------
; DATOS ocho_bytes_a_E090: ocho bytes que p02:9353 copia con ldir a 0xE090
;   0x935f..0x9367  (8 bytes)
DATA_ocho_bytes_a_E090:
	defb 002h,001h,001h,001h,000h,005h,000h,001h	; 935f  ........

; ======================================================================
; CODIGO 0x9367..0x94a0  (313 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; SUMAR PUNTOS. El marcador son TRES bytes en BCD -0xE086, 0xE087 y 0xE088-, o sea seis cifras, y topa en 999999. Se entra por 0x9367 con DE y C a cero, o por 0x9369 con los tres. Y aqui esta la VIDA EXTRA: cuando el byte alto del marcador alcanza a 0xE095, ese umbral sube 5 EN BCD -o sea 50.000 puntos mas- y se da una vida. Con 0xE002 en negativo no se suma nada.
; ----------------------------------------------------------------------
suma_puntos:
	ld c,000h		;9367   ; el byte alto, a cero
suma_puntos_con_los_tres:
	ld a,(0e002h)		;9369   ; la bandera de 0xE002
	add a,a			;936c   ; si tiene el bit 7 puesto, no se suma nada
	ret p			;936d
	ld hl,0e086h		;936e   ; el marcador, tres bytes
	ld a,(hl)			;9371
	add a,e			;9372   ; las cifras bajas, EN BCD
	daa			;9373
	ld (hl),a			;9374
	inc l			;9375
	ld a,(hl)			;9376
	adc a,d			;9377   ; las de en medio, con su acarreo
	daa			;9378
	ld (hl),a			;9379
	inc hl			;937a
	ld a,(hl)			;937b
	adc a,c			;937c   ; y las altas
	daa			;937d
	ld (hl),a			;937e
	jr nc,mira_la_vida_extra		;937f   ; ¿se ha pasado de 999999?
	ld hl,09999h		;9381   ; pues clavado en 999999
	ld (0e083h),hl		;9384   ; los datos del juego
	ld (0e084h),hl		;9387
	ret			;938a
mira_la_vida_extra:
	ex de,hl			;938b
	ld hl,0e095h		;938c   ; el umbral de la vida extra
	cp (hl)			;938f   ; ¿lo ha alcanzado el byte alto?
	jr c,L_93AC		;9390   ; si no, nada
	ld a,(hl)			;9392
	add a,005h		;9393   ; el umbral sube 5: otros 50.000
	daa			;9395
	jr nc,L_939A		;9396   ; y si se desborda...
	ld a,0ffh		;9398   ; ...se queda en 0xFF, que no se alcanza nunca
L_939A:
	ld (hl),a			;939a
	ld hl,0e090h		;939b   ; las vidas
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

; ----------------------------------------------------------------------
; ¿ES RECORD? Compara el marcador con el record cifra a cifra, de la mas alta a la mas baja. Si el marcador es menor se sale; si es mayor, los tres bytes del marcador se copian al record con `lddr`.
; ----------------------------------------------------------------------
mira_si_es_record:
	ld a,(de)			;93b2   ; la cifra del marcador
	sub (hl)			;93b3   ; menos la del record
	jr c,guarda_el_record		;93b4   ; si el marcador es menor, no es record
	ret nz			;93b6   ; si es mayor, es record
	dec l			;93b7   ; y si son iguales, a la cifra siguiente
	dec e			;93b8
	djnz mira_si_es_record		;93b9
guarda_el_record:
	ld bc,00003h		;93bb   ; los tres bytes
	ld e,085h		;93be
	ld l,088h		;93c0
	lddr		;93c2   ; copiados hacia atras
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
	ld a,(0e203h)		;9485   ; el ESTADO de lo que se maneja
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
; DATOS sonido_por_decorado: diez numeros de sonido, uno por decorado:
;   p02:9496 coge el de (0xE0A1) y lo pide (p00:413A)
;   0x94a0..0x94aa  (10 bytes)
DATA_sonido_por_decorado:
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
	call suma_puntos		;94c4
	ld a,02dh		;94c7
	jp 0413ah		;94c9   ; banco 0: pide_sonido_si_esta_activo
L_94CC:
	ld hl,0e0e1h		;94cc
	dec (hl)			;94cf
	ret			;94d0
L_94D1:
	ld hl,(0e08bh)		;94d1   ; el TIEMPO que queda
	ld a,h			;94d4
	or l			;94d5
	jr z,L_9500		;94d6
	ld a,(0e003h)		;94d8   ; el contador de cuadros
	and 003h		;94db
	jr nz,el_tiempo_a_puntos		;94dd
	push af			;94df
	ld a,02eh		;94e0
	call 0413ah		;94e2   ; banco 0: pide_sonido_si_esta_activo
	pop af			;94e5

; ----------------------------------------------------------------------
; EL TIEMPO SE CAMBIA POR PUNTOS. Un cuadro de cada dos: le quita uno al tiempo EN BCD y suma 0x20 puntos. Asi es como se vacia el reloj al acabar la fase, y por eso se oye ese repiqueteo.
; ----------------------------------------------------------------------
el_tiempo_a_puntos:
	rra			;94e6   ; un cuadro de cada dos
	ret c			;94e7
	ld a,l			;94e8
	sub 001h		;94e9   ; uno menos, EN BCD
	daa			;94eb
	ld l,a			;94ec
	jr nc,guarda_el_tiempo_y_suma		;94ed
	ld a,h			;94ef   ; y el byte alto, con su prestamo
	sub 001h		;94f0
	daa			;94f2
	ld h,a			;94f3
guarda_el_tiempo_y_suma:
	ld (0e08bh),hl		;94f4   ; el TIEMPO que queda
	ld de,00020h		;94f7   ; 0x20 puntos por unidad de tiempo
	call suma_puntos		;94fa
	jp L_9469		;94fd
L_9500:
	xor a			;9500
	ld (0e096h),a		;9501   ; los avisos que deja el cuadro
	ret			;9504

; ----------------------------------------------------------------------
; UNO O DOS JUGADORES, Y DE PASO LAS CLAVES. Los bits 0 y 1 de las teclas recien pulsadas dan la vuelta a 0xE082 con el efecto 0x23. Pero antes llama a 0x9522, que es donde esta lo bueno: el vigilante de las dos claves secretas.
; ----------------------------------------------------------------------
cambia_de_nivel:
	call vigila_las_claves		;9505   ; primero, el vigilante de las claves
	ld a,(0e006h)		;9508   ; las teclas
	ld c,a			;950b
	and 001h		;950c   ; el bit 0...
	jr nz,cambia_de_uno_a_dos		;950e
	ld a,c			;9510
	and 002h		;9511   ; ...o el bit 1
	ret z			;9513   ; sin ninguno, nada
cambia_de_uno_a_dos:
	ld a,(0e082h)		;9514   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
	cpl			;9517   ; se le da la vuelta
	and 001h		;9518
	ld (0e082h),a		;951a   ; el NIVEL elegido: 0 es LEVEL 1 y 1 es LEVEL 2
	ld a,023h		;951d   ; y el efecto 0x23
	jp 0413ah		;951f   ; banco 0: pide_sonido_si_esta_activo

; ----------------------------------------------------------------------
; EL VIGILANTE DE LAS CLAVES. Mira NUEVE teclas, una a una, con SNSMAT de la BIOS -que devuelve un bit a CERO por tecla pulsada- y a cada una le guarda su estado del cuadro anterior en un byte propio. Cuando una acaba de pulsarse -antes suelta, ahora pulsada- se apunta su numero en la cola de seis de 0xF0F8. Las nueve teclas, en orden alfabetico y con el numero que les toca, son: 0 = A (fila 2, bit 6), 1 = I (fila 3, bit 6), 2 = K (fila 4, bit 0), 3 = M (fila 4, bit 2), 4 = N (fila 4, bit 3), 5 = O (fila 4, bit 4), 6 = R (fila 4, bit 7), 7 = U (fila 5, bit 2) y 8 = Z (fila 5, bit 7). Y no son nueve cualesquiera: son exactamente las letras que hacen falta para escribir las dos claves de 0x965F.
; ----------------------------------------------------------------------
vigila_las_claves:
	ld a,002h		;9522   ; fila 2 de la matriz
	call 00141h		;9524   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | BIOS SNSMAT: un bit a CERO por tecla pulsada
	ld c,000h		;9527   ; esta es la tecla numero 0: la A
	rla			;9529   ; dos rotaciones para sacar el bit 6...
	rla			;952a
	ld e,000h		;952b
	jr c,mira_si_acaba_de_pulsarse_la_A		;952d   ; ...y si esta a cero, esta pulsada
	inc e			;952f
mira_si_acaba_de_pulsarse_la_A:
	ld a,(0e0e4h)		;9530   ; como estaba antes
	ld b,a			;9533
	ld a,e			;9534
	ld (0e0e4h),a		;9535   ; y como esta ahora
	xor b			;9538   ; ¿ha cambiado?
	jr z,la_tecla_I		;9539   ; si no, a la tecla siguiente
	ld a,b			;953b   ; y si antes estaba suelta, es que ACABA de pulsarse
	and a			;953c
	jp z,apunta_la_tecla_en_la_cola		;953d
la_tecla_I:
	ld a,003h		;9540   ; fila 3
	call 00141h		;9542   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,001h		;9545   ; la numero 1: la I
	and 040h		;9547   ; su bit 6
	ld e,000h		;9549
	jr nz,mira_si_acaba_de_pulsarse_la_I		;954b
	inc e			;954d
mira_si_acaba_de_pulsarse_la_I:
	ld a,(0e0e5h)		;954e   ; como estaba la I antes
	ld b,a			;9551
	ld a,e			;9552
	ld (0e0e5h),a		;9553   ; y como esta ahora
	xor b			;9556   ; ¿ha cambiado?
	jr z,la_tecla_K		;9557
	ld a,b			;9559   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;955a
	jp z,apunta_la_tecla_en_la_cola		;955b
la_tecla_K:
	ld a,004h		;955e   ; fila 4
	call 00141h		;9560   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,002h		;9563   ; la numero 2: la K
	rra			;9565   ; su bit 0
	ld e,000h		;9566
	jr c,mira_si_acaba_de_pulsarse_la_K		;9568
	inc e			;956a
mira_si_acaba_de_pulsarse_la_K:
	ld a,(0e0e7h)		;956b   ; como estaba la K antes
	ld b,a			;956e
	ld a,e			;956f
	ld (0e0e7h),a		;9570   ; y como esta ahora
	xor b			;9573   ; ¿ha cambiado?
	jr z,la_tecla_M		;9574
	ld a,b			;9576   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;9577
	jp z,apunta_la_tecla_en_la_cola		;9578
la_tecla_M:
	ld a,004h		;957b
	call 00141h		;957d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,003h		;9580   ; la numero 3: la M
	and 004h		;9582   ; su bit 2
	ld e,000h		;9584
	jr nz,mira_si_acaba_de_pulsarse_la_M		;9586
	inc e			;9588
mira_si_acaba_de_pulsarse_la_M:
	ld a,(0e0eah)		;9589   ; como estaba la M antes
	ld b,a			;958c
	ld a,e			;958d
	ld (0e0eah),a		;958e   ; y como esta ahora
	xor b			;9591   ; ¿ha cambiado?
	jr z,la_tecla_N		;9592
	ld a,b			;9594   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;9595
	jp z,apunta_la_tecla_en_la_cola		;9596
la_tecla_N:
	ld a,004h		;9599
	call 00141h		;959b   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,004h		;959e   ; la numero 4: la N
	and 008h		;95a0   ; su bit 3
	ld e,000h		;95a2
	jr nz,mira_si_acaba_de_pulsarse_la_N		;95a4
	inc e			;95a6
mira_si_acaba_de_pulsarse_la_N:
	ld a,(0e0ebh)		;95a7   ; como estaba la N antes
	ld b,a			;95aa
	ld a,e			;95ab
	ld (0e0ebh),a		;95ac   ; y como esta ahora
	xor b			;95af   ; ¿ha cambiado?
	jr z,la_tecla_O		;95b0
	ld a,b			;95b2   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;95b3
	jr z,apunta_la_tecla_en_la_cola		;95b4
la_tecla_O:
	ld a,004h		;95b6
	call 00141h		;95b8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,005h		;95bb   ; la numero 5: la O
	and 010h		;95bd   ; su bit 4
	ld e,000h		;95bf
	jr nz,mira_si_acaba_de_pulsarse_la_O		;95c1
	inc e			;95c3
mira_si_acaba_de_pulsarse_la_O:
	ld a,(0e0e6h)		;95c4   ; como estaba la O antes
	ld b,a			;95c7
	ld a,e			;95c8
	ld (0e0e6h),a		;95c9   ; y como esta ahora
	xor b			;95cc   ; ¿ha cambiado?
	jr z,la_tecla_R		;95cd
	ld a,b			;95cf   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;95d0
	jr z,apunta_la_tecla_en_la_cola		;95d1
la_tecla_R:
	ld a,004h		;95d3
	call 00141h		;95d5   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,006h		;95d8   ; la numero 6: la R
	rla			;95da   ; su bit 7
	ld e,000h		;95db
	jr c,mira_si_acaba_de_pulsarse_la_R		;95dd
	inc e			;95df
mira_si_acaba_de_pulsarse_la_R:
	ld a,(0e0ech)		;95e0   ; como estaba la R antes
	ld b,a			;95e3
	ld a,e			;95e4
	ld (0e0ech),a		;95e5   ; y como esta ahora
	xor b			;95e8   ; ¿ha cambiado?
	jr z,la_tecla_U		;95e9
	ld a,b			;95eb   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;95ec
	jr z,apunta_la_tecla_en_la_cola		;95ed
la_tecla_U:
	ld a,005h		;95ef   ; fila 5
	call 00141h		;95f1   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,007h		;95f4   ; la numero 7: la U
	and 004h		;95f6   ; su bit 2
	ld e,000h		;95f8
	jr nz,mira_si_acaba_de_pulsarse_la_U		;95fa
	inc e			;95fc
mira_si_acaba_de_pulsarse_la_U:
	ld a,(0e0e9h)		;95fd   ; como estaba la U antes
	ld b,a			;9600
	ld a,e			;9601
	ld (0e0e9h),a		;9602   ; y como esta ahora
	xor b			;9605   ; ¿ha cambiado?
	jr z,la_tecla_Z		;9606
	ld a,b			;9608   ; y si antes estaba suelta, ACABA de pulsarse
	and a			;9609
	jr z,apunta_la_tecla_en_la_cola		;960a
la_tecla_Z:
	ld a,005h		;960c
	call 00141h		;960e   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	ld c,008h		;9611   ; la numero 8: la Z
	rla			;9613   ; su bit 7
	ld e,000h		;9614
	jr c,mira_si_acaba_de_pulsarse_la_Z		;9616
	inc e			;9618
mira_si_acaba_de_pulsarse_la_Z:
	ld a,(0e0e8h)		;9619   ; como estaba la Z antes
	ld b,a			;961c
	ld a,e			;961d
	ld (0e0e8h),a		;961e   ; y como esta ahora
	xor b			;9621   ; ¿ha cambiado?
	ret z			;9622
	ld a,b			;9623
	and a			;9624   ; y si antes estaba suelta, ACABA de pulsarse
	ret nz			;9625

; ----------------------------------------------------------------------
; APUNTAR LA TECLA EN LA COLA. Seis bytes de 0xF0F8 a 0xF0FD: se corren todos uno a la izquierda y la tecla nueva entra por el final. O sea que ahi estan siempre las SEIS ULTIMAS teclas pulsadas, en orden.
; ----------------------------------------------------------------------
apunta_la_tecla_en_la_cola:
	ld a,c			;9626   ; la tecla que acaba de pulsarse
	ld de,0f0f8h		;9627   ; la cola de seis
	ld hl,0f0f9h		;962a
	ld bc,00005h		;962d   ; los cinco de atras se corren
	ldir		;9630
	ld (de),a			;9632   ; y la nueva, al final
	ret			;9633

; ----------------------------------------------------------------------
; ¿ES UNA DE LAS DOS CLAVES? Compara las seis ultimas teclas con las dos secuencias de 0x965F. Con los numeros de arriba, la primera es 4-5-6-1-2-5 = **NORIKO** y la segunda 2-0-8-7-3-1 = **KAZUMI**. La primera deja 0xFE en 0xF0F7 y la segunda 0xFF; con cualquiera de las dos aparece el CONTINUE al acabarse la partida (p02:8937 y p02:8A32). Y hay una diferencia entre ellas: con 0xFE justo, el borrado del fin de partida se salta los 143 bytes de 0xE160 y los 64 del espejo de pantalla (p02:8985), asi que NORIKO conserva ademas lo que se llevara encima.
; ----------------------------------------------------------------------
mira_si_es_una_de_las_dos_claves:
	ld hl,0f0f8h		;9634   ; las seis ultimas teclas
	ld de,0965fh		;9637   ; contra la primera clave: NORIKO
	ld b,006h		;963a
L_963C:
	ld a,(de)			;963c   ; byte a byte
	cp (hl)			;963d
	jr nz,mira_si_es_la_segunda_clave		;963e
	inc hl			;9640
	inc de			;9641
	djnz L_963C		;9642
	ld a,0feh		;9644   ; 0xFE: continue Y lo que se lleva
	ld (0f0f7h),a		;9646
	ret			;9649
mira_si_es_la_segunda_clave:
	ld hl,0f0f8h		;964a   ; las seis ultimas teclas
	ld de,09665h		;964d   ; contra la segunda: KAZUMI
	ld b,006h		;9650
compara_la_segunda_clave:
	ld a,(de)			;9652
	cp (hl)			;9653
	ret nz			;9654
	inc hl			;9655
	inc de			;9656
	djnz compara_la_segunda_clave		;9657
	ld a,0ffh		;9659   ; 0xFF: continue a secas
	ld (0f0f7h),a		;965b
	ret			;965e

; ----------------------------------------------------------------------
; DATOS las_dos_claves: LAS DOS CLAVES SECRETAS, seis teclas cada una, que
;   p02:9637 y p02:964D comparan con la cola de 0xF0F8. Con los numeros que
;   reparte p02:9522 (0=A 1=I 2=K 3=M 4=N 5=O 6=R 7=U 8=Z), la primera es
;   4-5-6-1-2-5 = NORIKO y la segunda 2-0-8-7-3-1 = KAZUMI
;   0x965f..0x966b  (12 bytes)
DATA_las_dos_claves:
	defb 004h,005h,006h,001h,002h,005h	; 965f
	defb 002h,000h,008h,007h,003h,001h	; 9665

; ======================================================================
; CODIGO 0x966b..0x9693  (40 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; MONTAR LA PANTALLA ENTERA. Nueve llamadas seguidas al banco 0, una por trozo, y la decima se salta. Aqui no hay bucle ni tabla: estan escritas una detras de otra, que es lo mas corto cuando son siempre las mismas.
; ----------------------------------------------------------------------
monta_la_pantalla_entera:
	call 04cd1h		;966b   ; el primer trozo
	call 04d7fh		;966e
	call 04e1ah		;9671
	call 04eb6h		;9674
	call 04f5bh		;9677
	call 04fach		;967a
	call 0502dh		;967d
	call 050aah		;9680
	call 05127h		;9683
	jp 05166h		;9686   ; y el ultimo, con salto en vez de llamada
L_9689:
	call 05b1fh		;9689
	ld a,(0e092h)		;968c   ; la FASE, de 1 a 24
	dec a			;968f
	call 04060h		;9690   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_9690: 24 punteros pegados detras del `call despacha` de
;   p02:9690: la rutina a la que se salta con A
;   0x9693..0x96c3  (48 bytes)
DATA_despacho_de_9690:
	defb 0c3h,096h	; 9693
	defb 0c3h,096h	; 9695
	defb 0c3h,096h	; 9697
	defb 0c3h,096h	; 9699
	defb 0c9h,096h	; 969b
	defb 0d2h,096h	; 969d
	defb 0c3h,096h	; 969f
	defb 0c4h,096h	; 96a1
	defb 0d2h,096h	; 96a3
	defb 0c9h,096h	; 96a5
	defb 0c9h,096h	; 96a7
	defb 0d2h,096h	; 96a9
	defb 0ebh,096h	; 96ab
	defb 0d2h,096h	; 96ad
	defb 0d7h,096h	; 96af
	defb 0dfh,096h	; 96b1
	defb 0e5h,096h	; 96b3
	defb 0ebh,096h	; 96b5
	defb 0c9h,096h	; 96b7
	defb 0f0h,096h	; 96b9
	defb 0d7h,096h	; 96bb
	defb 0f0h,096h	; 96bd
	defb 0c9h,096h	; 96bf
	defb 0d7h,096h	; 96c1

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
	ld a,(0e203h)		;96f9   ; el ESTADO de lo que se maneja
	call 04060h		;96fc   ; banco 0: despacha

; ----------------------------------------------------------------------
; DATOS despacho_de_96FC: 28 punteros pegados detras del `call despacha` de
;   p02:96FC: la rutina a la que se salta con A
;   0x96ff..0x9737  (56 bytes)
DATA_despacho_de_96FC:
	defb 037h,097h	; 96ff
	defb 09dh,097h	; 9701
	defb 009h,098h	; 9703
	defb 0b0h,098h	; 9705
	defb 061h,099h	; 9707
	defb 0e0h,099h	; 9709
	defb 063h,09ah	; 970b
	defb 0dbh,09ah	; 970d
	defb 074h,09bh	; 970f
	defb 0f2h,09bh	; 9711
	defb 080h,09ch	; 9713
	defb 058h,09dh	; 9715
	defb 069h,09dh	; 9717
	defb 0bah,09dh	; 9719
	defb 01eh,09eh	; 971b
	defb 0adh,09eh	; 971d
	defb 080h,09fh	; 971f
	defb 0c9h,09fh	; 9721
	defb 019h,0a0h	; 9723
	defb 03bh,0a0h	; 9725
	defb 083h,0a0h	; 9727
	defb 08ah,0a0h	; 9729
	defb 08fh,0a1h	; 972b
	defb 011h,0a2h	; 972d
	defb 0beh,0a5h	; 972f
	defb 0fdh,0a6h	; 9731
	defb 0b3h,0a7h	; 9733
	defb 0c8h,0a7h	; 9735

; ======================================================================
; CODIGO 0x9737..0x97ff  (200 bytes)
; ======================================================================


L_9737:
	call 0a84bh		;9737   ; banco 3
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
	ld (0e208h),a		;9751   ; el paso dentro del salto
	ld a,001h		;9754
	ld (0e207h),a		;9756   ; el tramo del salto: 1 subiendo, 2 bajando
	ld a,(0e209h)		;9759   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	ld (0e20ah),a		;975c   ; la direccion congelada mientras dura el salto
	ld a,(0e161h)		;975f
	and a			;9762
	ld a,001h		;9763
	ld b,003h		;9765
	jr z,L_976C		;9767
	inc a			;9769
	ld b,004h		;976a
L_976C:
	ld (0e203h),a		;976c   ; el ESTADO de lo que se maneja
	ld a,b			;976f
	jp 04145h		;9770   ; banco 0: pide_sonido
L_9773:
	ld a,(0e0a1h)		;9773   ; el DECORADO, de 0 a 9
	cp 009h		;9776
	jr z,L_9780		;9778
	ld a,(0e209h)		;977a   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	call 0a87ah		;977d   ; banco 3
L_9780:
	call 0a8dbh		;9780   ; banco 3
	ld hl,0e206h		;9783
	ld a,(0e003h)		;9786   ; el contador de cuadros
	and 007h		;9789
	jr nz,la_pose_por_los_dos_bits		;978b
	inc (hl)			;978d
la_pose_por_los_dos_bits:
	ld a,(hl)			;978e   ; el contador de la animacion
	rra			;978f
	ld c,000h		;9790   ; sin ningun bit, la pose 0
	jr nc,L_9799		;9792
	inc c			;9794   ; con el bit 0, la 1
	rra			;9795
	jr nc,L_9799		;9796
	inc c			;9798   ; y con los dos, la 2
L_9799:
	ld a,c			;9799
	jp 0a8f5h		;979a   ; banco 3: a ponerla
L_979D:
	ld hl,0e16fh		;979d
	bit 0,(hl)		;97a0
	ld a,(0e20ah)		;97a2   ; la direccion congelada mientras dura el salto
	jr z,L_97AD		;97a5
	call 0a84bh		;97a7   ; banco 3
	ld a,(0e209h)		;97aa   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
L_97AD:
	call 0a87ah		;97ad   ; banco 3
	ld a,(0e003h)		;97b0   ; el contador de cuadros
	and 003h		;97b3
	jr nz,L_97F0		;97b5
	ld a,(0e207h)		;97b7   ; el tramo del salto: 1 subiendo, 2 bajando
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
	ld (0e207h),a		;97d8   ; el tramo del salto: 1 subiendo, 2 bajando
	ld (0e203h),a		;97db   ; el ESTADO de lo que se maneja
	ld (0e20ah),a		;97de   ; la direccion congelada mientras dura el salto
	jp 0bbd6h		;97e1   ; banco 3
L_97E4:
	ld hl,097ffh		;97e4
	call 04056h		;97e7   ; banco 0: a_mas_hl
	ld a,(hl)			;97ea
	ld hl,0e204h		;97eb
	add a,(hl)			;97ee
	ld (hl),a			;97ef
L_97F0:
	call 0a8dbh		;97f0   ; banco 3
	ld a,(0e208h)		;97f3   ; el paso dentro del salto
	rra			;97f6
	ld a,003h		;97f7
	jr c,L_97FC		;97f9
	inc a			;97fb
L_97FC:
	jp 0a8f5h		;97fc   ; banco 3

; ----------------------------------------------------------------------
; DATOS arco_del_salto_97FF: diez desplazamientos con signo que p02:97E4 y
;   9E03 suman a la Y de lo que se maneja (0xE204)
;   0x97ff..0x9809  (10 bytes)
DATA_arco_del_salto_97FF:
	defb 0fch,0fdh,0feh,0ffh,0ffh,001h,001h,002h,003h,004h	; 97ff  ..........

; ======================================================================
; CODIGO 0x9809..0x9896  (141 bytes)
; ======================================================================


L_9809:
	ld hl,0e16fh		;9809
	bit 0,(hl)		;980c
	ld a,(0e20ah)		;980e   ; la direccion congelada mientras dura el salto
	jr z,L_9819		;9811
	call 0a84bh		;9813   ; banco 3
	ld a,(0e209h)		;9816   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
L_9819:
	call 0a87ah		;9819   ; banco 3
	ld a,(0e207h)		;981c   ; el tramo del salto: 1 subiendo, 2 bajando
	dec a			;981f
	jr nz,L_985D		;9820
	ld a,(0e208h)		;9822   ; el paso dentro del salto
	cp 004h		;9825
	jr c,L_9845		;9827
	cp 0ffh		;9829
	jr z,L_9845		;982b
	ld a,(0e007h)		;982d   ; el estado de los mandos del cuadro anterior
	and 010h		;9830
	jr nz,L_9845		;9832
	ld a,(0e208h)		;9834   ; el paso dentro del salto
	sub 004h		;9837
	ld hl,09896h		;9839
	call 04056h		;983c   ; banco 0: a_mas_hl
	ld a,(hl)			;983f
	ld (0e208h),a		;9840   ; el paso dentro del salto
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
	ld (0e207h),a		;986f   ; el tramo del salto: 1 subiendo, 2 bajando
	ld (0e203h),a		;9872   ; el ESTADO de lo que se maneja
	ld (0e20ah),a		;9875   ; la direccion congelada mientras dura el salto
	jp 0bbd6h		;9878   ; banco 3
L_987B:
	ld hl,0989ch		;987b
	call 04056h		;987e   ; banco 0: a_mas_hl
	ld a,(hl)			;9881
	ld hl,0e204h		;9882
	add a,(hl)			;9885
	ld (hl),a			;9886
L_9887:
	call 0a8dbh		;9887   ; banco 3
	ld a,(0e208h)		;988a   ; el paso dentro del salto
	rra			;988d
	ld a,003h		;988e
	jr c,L_9893		;9890
	inc a			;9892
L_9893:
	jp 0a8f5h		;9893   ; banco 3

; ----------------------------------------------------------------------
; DATOS empujones_9896: dos tablas pegadas: la de 0x9896, que p02:9839, 9B0B y
;   9E4E indexan con A - 4 y llevan a 0xE208, y la de 0x989C, que p02:987B,
;   9B59 y 9E92 suman a la Y (0xE204)
;   0x9896..0x98b0  (26 bytes)
DATA_empujones_9896:
	defb 00eh,00dh,00ch,00bh,00ah,009h,0fah,0fbh,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 9896  ................
	defb 001h,001h,001h,002h,002h,003h,004h,005h,005h,006h	; 98a6  ..........

; ======================================================================
; CODIGO 0x98b0..0x9953  (163 bytes)
; ======================================================================


L_98B0:
	call 0a083h		;98b0   ; banco 3
	ld a,(0e20bh)		;98b3   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	and 03fh		;98b6
	jr nz,L_98CD		;98b8
	ld a,008h		;98ba
	ld (0e20ch),a		;98bc   ; la cuenta de cuadros del paso de la caida
	ld hl,0e20bh		;98bf
	inc (hl)			;98c2
	ld a,007h		;98c3
	call 04145h		;98c5   ; banco 0: pide_sonido
	ld a,090h		;98c8
	ld (0e204h),a		;98ca   ; la Y en la pantalla de lo que se maneja
L_98CD:
	ld a,(0e003h)		;98cd   ; el contador de cuadros
	and 003h		;98d0
	jr nz,L_990B		;98d2
	ld hl,0e20ch		;98d4
	dec (hl)			;98d7
	ld a,(0e20bh)		;98d8   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	and 03fh		;98db
	dec a			;98dd
	ld hl,09953h		;98de
	jr z,L_98E6		;98e1
	ld hl,0995bh		;98e3
L_98E6:
	ld a,(0e20ch)		;98e6   ; la cuenta de cuadros del paso de la caida
	call 04056h		;98e9   ; banco 0: a_mas_hl
	ld a,(hl)			;98ec
	ld hl,0e204h		;98ed
	add a,(hl)			;98f0
	ld (hl),a			;98f1
	ld a,(0e20bh)		;98f2   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	rla			;98f5
	ld a,004h		;98f6
	jr nc,L_98FB		;98f8
	rlca			;98fa
L_98FB:
	push af			;98fb
	call 0a87ah		;98fc   ; banco 3
	pop af			;98ff
	push af			;9900
	call 0a87ah		;9901   ; banco 3
	pop af			;9904
	call 0a87ah		;9905   ; banco 3
	call 0a8dbh		;9908   ; banco 3
L_990B:
	ld a,(0e20bh)		;990b   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	rla			;990e
	ld a,005h		;990f
	jr nc,L_9914		;9911
	inc a			;9913
L_9914:
	call 0a8f5h		;9914   ; banco 3
	ld a,(0e20ch)		;9917   ; la cuenta de cuadros del paso de la caida
	and a			;991a
	ret nz			;991b
	ld a,006h		;991c
	ld (0e20ch),a		;991e   ; la cuenta de cuadros del paso de la caida
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
	ld (0e203h),a		;993c   ; el ESTADO de lo que se maneja
	xor a			;993f
	ld (hl),a			;9940
	ld (0e20ch),a		;9941   ; la cuenta de cuadros del paso de la caida
	ld (0e201h),a		;9944
	ld (0e202h),a		;9947
	call 062a4h		;994a   ; banco 1
	call 06507h		;994d   ; banco 1
	jp 068e2h		;9950   ; banco 1

; ----------------------------------------------------------------------
; DATOS empujones_9953: dos tablas de ocho y seis desplazamientos que p02:98DE
;   escoge (0x9953 o 0x995B) e indexa con (0xE20C) para sumarlos a la Y
;   (0xE204)
;   0x9953..0x9961  (14 bytes)
DATA_empujones_9953:
	defb 003h,002h,002h,001h,0ffh,0feh,0feh,0fdh	; 9953  ........
	defb 002h,002h,001h,0ffh,0feh,0feh	; 995b

; ======================================================================
; CODIGO 0x9961..0x9ad1  (368 bytes)
; ======================================================================


L_9961:
	call 0a083h		;9961   ; banco 3
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
	ld (0e204h),a		;9977   ; la Y en la pantalla de lo que se maneja
	call 062a4h		;997a   ; banco 1
	call 06507h		;997d   ; banco 1
	call 068e2h		;9980   ; banco 1
	xor a			;9983
	ld (0e203h),a		;9984   ; el ESTADO de lo que se maneja
	ld (0e20dh),a		;9987
	ld (0e20eh),a		;998a
	ld (0e201h),a		;998d
	ld (0e202h),a		;9990
	ld a,0e0h		;9993
	ld (0ee90h),a		;9995   ; el hueco de sprite 4
	ld (0ee94h),a		;9998   ; el hueco de sprite 5
	ret			;999b
L_999C:
	ld a,(0e215h)		;999c
	and a			;999f
	jr z,L_99C0		;99a0
	ld a,(0e006h)		;99a2   ; las teclas recien pulsadas
	and 002h		;99a5
	jr z,L_99C0		;99a7
	ld a,012h		;99a9
	ld (0e203h),a		;99ab   ; el ESTADO de lo que se maneja
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
	jr nz,la_fila_y_la_pose_por_un_bit		;99c8
	inc (hl)			;99ca
la_fila_y_la_pose_por_un_bit:
	ld a,(hl)			;99cb   ; el contador
	rra			;99cc
	ld a,098h		;99cd   ; sin el bit, la fila 0x98 y la pose 3...
	ld b,003h		;99cf
	jr nc,L_99D6		;99d1
	ld a,09eh		;99d3   ; ...y con el, la 0x9E y la 4
	inc b			;99d5
L_99D6:
	ld (0e204h),a		;99d6   ; la Y en la pantalla de lo que se maneja
	call 0a8dbh		;99d9   ; banco 3: los cuatro sprites, colocados
	ld a,b			;99dc
	jp 0a8f5h		;99dd   ; banco 3: y la pose
L_99E0:
	call 0a84bh		;99e0   ; banco 3
	ld a,(0e0a5h)		;99e3   ; por que vuelta de la fase va
	cp 002h		;99e6
	jr z,L_9A17		;99e8
	ld a,(0e006h)		;99ea   ; las teclas recien pulsadas
	and 010h		;99ed
	jr z,L_9A17		;99ef
	ld a,0ffh		;99f1
	ld (0e208h),a		;99f3   ; el paso dentro del salto
	ld a,001h		;99f6
	ld (0e207h),a		;99f8   ; el tramo del salto: 1 subiendo, 2 bajando
	ld a,(0e209h)		;99fb   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	ld (0e20ah),a		;99fe   ; la direccion congelada mientras dura el salto
	ld a,090h		;9a01
	ld (0e204h),a		;9a03   ; la Y en la pantalla de lo que se maneja
	ld a,(0e161h)		;9a06
	and a			;9a09
	ld a,006h		;9a0a
	jr z,L_9A0F		;9a0c
	inc a			;9a0e
L_9A0F:
	ld (0e203h),a		;9a0f   ; el ESTADO de lo que se maneja
	ld a,005h		;9a12
	jp 04145h		;9a14   ; banco 0: pide_sonido
L_9A17:
	ld a,(0e209h)		;9a17   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	call 0a87ah		;9a1a   ; banco 3
L_9A1D:
	ld hl,(0e204h)		;9a1d   ; la Y en la pantalla de lo que se maneja
	ld d,h			;9a20
	ld (0ee88h),hl		;9a21   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ld a,010h		;9a24
	add a,h			;9a26
	ld h,a			;9a27
	ld (0ee8ch),hl		;9a28   ; el sprite 3 de lo que se maneja: abajo a la derecha
	ld a,008h		;9a2b
	add a,l			;9a2d
	ld l,a			;9a2e
	ld (0ee84h),hl		;9a2f   ; el sprite 1 de lo que se maneja: arriba a la derecha
	ld h,d			;9a32
	ld (0ee80h),hl		;9a33   ; la tabla de atributos de los 32 sprites
	ld a,(0e003h)		;9a36   ; el contador de cuadros
	and 020h		;9a39
	jr z,L_9A48		;9a3b
	ld a,(0ee88h)		;9a3d   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	add a,002h		;9a40
	ld (0ee88h),a		;9a42   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ld (0ee8ch),a		;9a45   ; el sprite 3 de lo que se maneja: abajo a la derecha
L_9A48:
	ld a,00ah		;9a48
	call 0a8f5h		;9a4a   ; banco 3
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
	ld a,(0e20ah)		;9a68   ; la direccion congelada mientras dura el salto
	jr z,L_9A73		;9a6b
	call 0a84bh		;9a6d   ; banco 3
	ld a,(0e209h)		;9a70   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
L_9A73:
	call 0a87ah		;9a73   ; banco 3
	ld a,(0e003h)		;9a76   ; el contador de cuadros
	and 003h		;9a79
	jr nz,L_9AC2		;9a7b
	ld a,(0e207h)		;9a7d   ; el tramo del salto: 1 subiendo, 2 bajando
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
	ld (0e207h),a		;9a9e   ; el tramo del salto: 1 subiendo, 2 bajando
	ld (0e20ah),a		;9aa1   ; la direccion congelada mientras dura el salto
	ld a,005h		;9aa4
	ld (0e203h),a		;9aa6   ; el ESTADO de lo que se maneja
	ld a,0a0h		;9aa9
	ld (0e204h),a		;9aab   ; la Y en la pantalla de lo que se maneja
	ld a,006h		;9aae
	call 04145h		;9ab0   ; banco 0: pide_sonido
	jp 0bbd6h		;9ab3   ; banco 3
L_9AB6:
	ld hl,09ad1h		;9ab6
	call 04056h		;9ab9   ; banco 0: a_mas_hl
	ld a,(hl)			;9abc
	ld hl,0e204h		;9abd
	add a,(hl)			;9ac0
	ld (hl),a			;9ac1
L_9AC2:
	call 0a8dbh		;9ac2   ; banco 3
	ld a,(0e208h)		;9ac5   ; el paso dentro del salto
	rra			;9ac8
	ld a,003h		;9ac9
	jr c,L_9ACE		;9acb
	inc a			;9acd
L_9ACE:
	jp 0a8f5h		;9ace   ; banco 3

; ----------------------------------------------------------------------
; DATOS arco_del_salto_9AD1: diez desplazamientos con signo que p02:9AB6 suma
;   a la Y (0xE204)
;   0x9ad1..0x9adb  (10 bytes)
DATA_arco_del_salto_9AD1:
	defb 0fbh,0fch,0fdh,0feh,0ffh,001h,002h,003h,004h,005h	; 9ad1  ..........

; ======================================================================
; CODIGO 0x9adb..0x9c74  (409 bytes)
; ======================================================================


L_9ADB:
	ld hl,0e16fh		;9adb
	bit 0,(hl)		;9ade
	ld a,(0e20ah)		;9ae0   ; la direccion congelada mientras dura el salto
	jr z,L_9AEB		;9ae3
	call 0a84bh		;9ae5   ; banco 3
	ld a,(0e209h)		;9ae8   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
L_9AEB:
	call 0a87ah		;9aeb   ; banco 3
	ld a,(0e207h)		;9aee   ; el tramo del salto: 1 subiendo, 2 bajando
	dec a			;9af1
	jr nz,L_9B2F		;9af2
	ld a,(0e208h)		;9af4   ; el paso dentro del salto
	cp 004h		;9af7
	jr c,L_9B17		;9af9
	cp 0ffh		;9afb
	jr z,L_9B17		;9afd
	ld a,(0e007h)		;9aff   ; el estado de los mandos del cuadro anterior
	and 010h		;9b02
	jr nz,L_9B17		;9b04
	ld a,(0e208h)		;9b06   ; el paso dentro del salto
	sub 004h		;9b09
	ld hl,09896h		;9b0b
	call 04056h		;9b0e   ; banco 0: a_mas_hl
	ld a,(hl)			;9b11
	ld (0e208h),a		;9b12   ; el paso dentro del salto
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
	ld (0e207h),a		;9b41   ; el tramo del salto: 1 subiendo, 2 bajando
	ld (0e20ah),a		;9b44   ; la direccion congelada mientras dura el salto
	ld a,005h		;9b47
	ld (0e203h),a		;9b49   ; el ESTADO de lo que se maneja
	ld a,0a0h		;9b4c
	ld (0e204h),a		;9b4e   ; la Y en la pantalla de lo que se maneja
	ld a,006h		;9b51
	call 04145h		;9b53   ; banco 0: pide_sonido
	jp 0bbd6h		;9b56   ; banco 3
L_9B59:
	ld hl,0989ch		;9b59
	call 04056h		;9b5c   ; banco 0: a_mas_hl
	ld a,(hl)			;9b5f
	ld hl,0e204h		;9b60
	add a,(hl)			;9b63
	ld (hl),a			;9b64
L_9B65:
	call 0a8dbh		;9b65   ; banco 3
	ld a,(0e208h)		;9b68   ; el paso dentro del salto
	rra			;9b6b
	ld a,003h		;9b6c
	jr c,L_9B71		;9b6e
	inc a			;9b70
L_9B71:
	jp 0a8f5h		;9b71   ; banco 3
L_9B74:
	call 0a083h		;9b74   ; banco 3
	ld a,(0e20bh)		;9b77   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	and 03fh		;9b7a
	jr nz,L_9B91		;9b7c
	ld a,008h		;9b7e
	ld (0e20ch),a		;9b80   ; la cuenta de cuadros del paso de la caida
	ld hl,0e20bh		;9b83
	inc (hl)			;9b86
	ld a,007h		;9b87
	call 04145h		;9b89   ; banco 0: pide_sonido
	ld a,0a0h		;9b8c
	ld (0e204h),a		;9b8e   ; la Y en la pantalla de lo que se maneja
L_9B91:
	ld a,(0e003h)		;9b91   ; el contador de cuadros
	and 003h		;9b94
	jr nz,L_9BB2		;9b96
	ld hl,0e20ch		;9b98
	dec (hl)			;9b9b
	ld a,(0e20bh)		;9b9c   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	rla			;9b9f
	ld a,004h		;9ba0
	jr nc,L_9BA5		;9ba2
	rlca			;9ba4
L_9BA5:
	push af			;9ba5
	call 0a87ah		;9ba6   ; banco 3
	pop af			;9ba9
	push af			;9baa
	call 0a87ah		;9bab   ; banco 3
	pop af			;9bae
	call 0a87ah		;9baf   ; banco 3
L_9BB2:
	call L_9A1D		;9bb2
	ld a,(0e20ch)		;9bb5   ; la cuenta de cuadros del paso de la caida
	and a			;9bb8
	ret nz			;9bb9
	ld a,006h		;9bba
	ld (0e20ch),a		;9bbc   ; la cuenta de cuadros del paso de la caida
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
	ld (0e203h),a		;9bdb   ; el ESTADO de lo que se maneja
	xor a			;9bde
	ld (hl),a			;9bdf
	ld (0e20ch),a		;9be0   ; la cuenta de cuadros del paso de la caida
	ld (0e201h),a		;9be3
	ld (0e202h),a		;9be6
	call 062a4h		;9be9   ; banco 1
	call 06507h		;9bec   ; banco 1
	jp 068e2h		;9bef   ; banco 1
L_9BF2:
	ld a,(0e006h)		;9bf2   ; las teclas recien pulsadas
	and 010h		;9bf5
	jr z,L_9C00		;9bf7
	call 0bbd6h		;9bf9   ; banco 3
	xor a			;9bfc
	ld (0e212h),a		;9bfd
L_9C00:
	ld a,(0e003h)		;9c00   ; el contador de cuadros
	and 003h		;9c03
	jr nz,y_luego_el_mando		;9c05
	ld hl,0e212h		;9c07
	ld a,(hl)			;9c0a
	cp 00ch		;9c0b
	jr nc,mueve_de_fila_con_topes		;9c0d
	ld a,(hl)			;9c0f
	inc (hl)			;9c10
	ld hl,09c74h		;9c11
	call 04056h		;9c14   ; banco 0: a_mas_hl
	ld a,(hl)			;9c17
	ld (0e214h),a		;9c18

; ----------------------------------------------------------------------
; MOVERSE ARRIBA Y ABAJO, ENTRE LA 0x40 Y LA 0x90. Le suma a la fila el empujon de 0xE214 y la deja clavada entre esas dos: son los topes de este tramo del juego, mas estrechos que los de 0x14 y 0xCC del movimiento de lado.
; ----------------------------------------------------------------------
mueve_de_fila_con_topes:
	ld a,(0e214h)		;9c1b   ; el empujon
	ld hl,0e204h		;9c1e   ; la fila
	add a,(hl)			;9c21
	ld (hl),a			;9c22   ; sumado
	cp 040h		;9c23   ; por arriba, la fila 0x40...
	jr nc,L_9C2B		;9c25
	ld (hl),040h		;9c27
	jr y_luego_el_mando		;9c29
L_9C2B:
	cp 091h		;9c2b   ; ...y por abajo, la 0x90
	jr c,y_luego_el_mando		;9c2d
	ld (hl),090h		;9c2f
y_luego_el_mando:
	call 0a84bh		;9c31   ; banco 3: hacia donde se pide ir
	ld a,(0e209h)		;9c34   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	call 0a87ah		;9c37   ; banco 3
L_9C3A:
	ld hl,(0e204h)		;9c3a   ; la Y en la pantalla de lo que se maneja
	ld d,h			;9c3d
	ld (0ee84h),hl		;9c3e   ; el sprite 1 de lo que se maneja: arriba a la derecha
	ld a,010h		;9c41
	add a,h			;9c43
	ld h,a			;9c44
	ld (0ee88h),hl		;9c45   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ld a,h			;9c48
	sub 008h		;9c49
	ld h,a			;9c4b
	ld a,00dh		;9c4c
	add a,l			;9c4e
	ld l,a			;9c4f
	ld (0ee8ch),hl		;9c50   ; el sprite 3 de lo que se maneja: abajo a la derecha
	ld a,003h		;9c53
	add a,l			;9c55
	ld l,a			;9c56
	ld (0ee80h),hl		;9c57   ; la tabla de atributos de los 32 sprites
	ld hl,0e213h		;9c5a
	ld a,(0e003h)		;9c5d   ; el contador de cuadros
	and 007h		;9c60
	jr nz,la_pose_por_los_dos_bits_desde_la_7		;9c62
	inc (hl)			;9c64
la_pose_por_los_dos_bits_desde_la_7:
	ld a,(hl)			;9c65   ; el contador de la animacion
	rra			;9c66
	ld c,007h		;9c67   ; aqui las poses empiezan en la 7
	jr nc,L_9C70		;9c69
	inc c			;9c6b
	rra			;9c6c
	jr nc,L_9C70		;9c6d
	inc c			;9c6f
L_9C70:
	ld a,c			;9c70
	jp 0a8f5h		;9c71   ; banco 3

; ----------------------------------------------------------------------
; DATOS empujon_E214: doce desplazamientos que p02:9C11, 9F29 y p03:A719
;   indexan y dejan en 0xE214 antes de sumarlos a la X
;   0x9c74..0x9c80  (12 bytes)
DATA_empujon_E214:
	defb 0fch,0fdh,0fdh,0feh,0feh,0ffh,0ffh,0ffh,001h,002h,003h,004h	; 9c74  ............

; ======================================================================
; CODIGO 0x9c80..0x9d4a  (202 bytes)
; ======================================================================


L_9C80:
	call 0a083h		;9c80   ; banco 3
	ld a,(0e20bh)		;9c83   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	and 03fh		;9c86
	jr nz,L_9C98		;9c88
	ld a,008h		;9c8a
	ld (0e20ch),a		;9c8c   ; la cuenta de cuadros del paso de la caida
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
	ld a,(0e20bh)		;9ca3   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	and 03fh		;9ca6
	dec a			;9ca8
	ld hl,09d4ah		;9ca9
	jr z,L_9CB1		;9cac
	ld hl,09d52h		;9cae
L_9CB1:
	ld a,(0e20ch)		;9cb1   ; la cuenta de cuadros del paso de la caida
	call 04056h		;9cb4   ; banco 0: a_mas_hl
	ld a,(hl)			;9cb7
	ld hl,0e204h		;9cb8
	add a,(hl)			;9cbb
	cp 090h		;9cbc
	jr nc,L_9CC1		;9cbe
	ld (hl),a			;9cc0
L_9CC1:
	ld a,(0e20bh)		;9cc1   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	rla			;9cc4
	ld a,004h		;9cc5
	jr nc,L_9CCA		;9cc7
	rlca			;9cc9
L_9CCA:
	push af			;9cca
	call 0a87ah		;9ccb   ; banco 3
	pop af			;9cce
	push af			;9ccf
	call 0a87ah		;9cd0   ; banco 3
	pop af			;9cd3
	call 0a87ah		;9cd4   ; banco 3
	ld hl,(0e204h)		;9cd7   ; la Y en la pantalla de lo que se maneja
	ld d,h			;9cda
	ld (0ee84h),hl		;9cdb   ; el sprite 1 de lo que se maneja: arriba a la derecha
	ld a,010h		;9cde
	add a,h			;9ce0
	ld h,a			;9ce1
	ld (0ee88h),hl		;9ce2   ; el sprite 2 de lo que se maneja: abajo a la izquierda
	ld a,h			;9ce5
	sub 008h		;9ce6
	ld h,a			;9ce8
	ld a,00dh		;9ce9
	add a,l			;9ceb
	ld l,a			;9cec
	ld (0ee8ch),hl		;9ced   ; el sprite 3 de lo que se maneja: abajo a la derecha
	ld a,003h		;9cf0
	add a,l			;9cf2
	ld l,a			;9cf3
	ld (0ee80h),hl		;9cf4   ; la tabla de atributos de los 32 sprites
L_9CF7:
	ld a,(0e20bh)		;9cf7   ; por que lado se ha entrado: 0 por la izquierda, 0x80 por la derecha
	rla			;9cfa
	ld c,008h		;9cfb
	jr nc,L_9D00		;9cfd
	inc c			;9cff
L_9D00:
	ld a,(0e20ch)		;9d00   ; la cuenta de cuadros del paso de la caida
	and 004h		;9d03
	jr z,L_9D09		;9d05
	ld c,007h		;9d07
L_9D09:
	ld a,c			;9d09
	call 0a8f5h		;9d0a   ; banco 3
	ld a,(0e20ch)		;9d0d   ; la cuenta de cuadros del paso de la caida
	and a			;9d10
	ret nz			;9d11
	ld a,006h		;9d12
	ld (0e20ch),a		;9d14   ; la cuenta de cuadros del paso de la caida
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
	ld (0e203h),a		;9d33   ; el ESTADO de lo que se maneja
	xor a			;9d36
	ld (hl),a			;9d37
	ld (0e20ch),a		;9d38   ; la cuenta de cuadros del paso de la caida
	ld (0e201h),a		;9d3b
	ld (0e202h),a		;9d3e
	call 062a4h		;9d41   ; banco 1
	call 06507h		;9d44   ; banco 1
	jp 068e2h		;9d47   ; banco 1

; ----------------------------------------------------------------------
; DATOS empujones_9D4A: dos tablas de ocho y seis valores que p02:9CA9 escoge
;   (0x9D4A o 0x9D52) e indexa con (0xE20C) sobre la Y (0xE204)
;   0x9d4a..0x9d58  (14 bytes)
DATA_empujones_9D4A:
	defb 005h,004h,004h,003h,001h,000h,000h,0ffh	; 9d4a  ........
	defb 004h,004h,003h,001h,000h,000h	; 9d52

; ======================================================================
; CODIGO 0x9d58..0x9fff  (679 bytes)
; ======================================================================


L_9D58:
	ld hl,0e204h		;9d58
	ld a,(hl)			;9d5b
	cp 092h		;9d5c
	jr nc,L_9D64		;9d5e
	inc (hl)			;9d60
	jp 0a8dbh		;9d61   ; banco 3
L_9D64:
	ld hl,0e203h		;9d64
	inc (hl)			;9d67
	ret			;9d68
L_9D69:
	call 0a84bh		;9d69   ; banco 3
	ld a,(0e006h)		;9d6c   ; las teclas recien pulsadas
	and 010h		;9d6f
	jr z,L_9D97		;9d71
	ld a,0ffh		;9d73
	ld (0e208h),a		;9d75   ; el paso dentro del salto
	ld a,001h		;9d78
	ld (0e207h),a		;9d7a   ; el tramo del salto: 1 subiendo, 2 bajando
	ld a,(0e209h)		;9d7d   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	ld (0e20ah),a		;9d80   ; la direccion congelada mientras dura el salto
	ld a,(0e161h)		;9d83
	and a			;9d86
	ld a,00dh		;9d87
	ld b,003h		;9d89
	jr z,L_9D90		;9d8b
	inc a			;9d8d
	ld b,004h		;9d8e
L_9D90:
	ld (0e203h),a		;9d90   ; el ESTADO de lo que se maneja
	ld a,b			;9d93
	jp 0413ah		;9d94   ; banco 0: pide_sonido_si_esta_activo
L_9D97:
	ld a,(0e209h)		;9d97   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	call 0a87ah		;9d9a   ; banco 3
	call 0a8dbh		;9d9d   ; banco 3
	ld hl,0e206h		;9da0
	ld a,(0e003h)		;9da3   ; el contador de cuadros
	and 007h		;9da6
	jr nz,la_pose_por_los_dos_bits_bis		;9da8
	inc (hl)			;9daa
la_pose_por_los_dos_bits_bis:
	ld a,(hl)			;9dab   ; el contador de la animacion
	rra			;9dac
	ld c,000h		;9dad   ; sin ningun bit, la pose 0
	jr nc,L_9DB6		;9daf
	inc c			;9db1
	rra			;9db2
	jr nc,L_9DB6		;9db3
	inc c			;9db5
L_9DB6:
	ld a,c			;9db6
	jp 0a8f5h		;9db7   ; banco 3: a ponerla
L_9DBA:
	ld hl,0e16fh		;9dba
	bit 0,(hl)		;9dbd
	ld a,(0e20ah)		;9dbf   ; la direccion congelada mientras dura el salto
	jr z,L_9DCA		;9dc2
	call 0a84bh		;9dc4   ; banco 3
	ld a,(0e209h)		;9dc7   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
L_9DCA:
	call 0a87ah		;9dca   ; banco 3
	ld a,(0e003h)		;9dcd   ; el contador de cuadros
	and 003h		;9dd0
	jr nz,L_9E0F		;9dd2
	ld a,(0e207h)		;9dd4   ; el tramo del salto: 1 subiendo, 2 bajando
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
	ld (0e207h),a		;9df5   ; el tramo del salto: 1 subiendo, 2 bajando
	ld (0e20ah),a		;9df8   ; la direccion congelada mientras dura el salto
	ld a,00ch		;9dfb
	ld (0e203h),a		;9dfd   ; el ESTADO de lo que se maneja
	jp 0b48dh		;9e00   ; banco 3
L_9E03:
	ld hl,097ffh		;9e03
	call 04056h		;9e06   ; banco 0: a_mas_hl
	ld a,(hl)			;9e09
	ld hl,0e204h		;9e0a
	add a,(hl)			;9e0d
	ld (hl),a			;9e0e
L_9E0F:
	call 0a8dbh		;9e0f   ; banco 3
	ld a,(0e208h)		;9e12   ; el paso dentro del salto
	rra			;9e15
	ld a,003h		;9e16
	jr c,L_9E1B		;9e18
	inc a			;9e1a
L_9E1B:
	jp 0a8f5h		;9e1b   ; banco 3
L_9E1E:
	ld hl,0e16fh		;9e1e
	bit 0,(hl)		;9e21
	ld a,(0e20ah)		;9e23   ; la direccion congelada mientras dura el salto
	jr z,L_9E2E		;9e26
	call 0a84bh		;9e28   ; banco 3
	ld a,(0e209h)		;9e2b   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
L_9E2E:
	call 0a87ah		;9e2e   ; banco 3
	ld a,(0e207h)		;9e31   ; el tramo del salto: 1 subiendo, 2 bajando
	dec a			;9e34
	jr nz,L_9E72		;9e35
	ld a,(0e208h)		;9e37   ; el paso dentro del salto
	cp 004h		;9e3a
	jr c,L_9E5A		;9e3c
	cp 0ffh		;9e3e
	jr z,L_9E5A		;9e40
	ld a,(0e007h)		;9e42   ; el estado de los mandos del cuadro anterior
	and 010h		;9e45
	jr nz,L_9E5A		;9e47
	ld a,(0e208h)		;9e49   ; el paso dentro del salto
	sub 004h		;9e4c
	ld hl,09896h		;9e4e
	call 04056h		;9e51   ; banco 0: a_mas_hl
	ld a,(hl)			;9e54
	ld (0e208h),a		;9e55   ; el paso dentro del salto
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
	ld (0e207h),a		;9e84   ; el tramo del salto: 1 subiendo, 2 bajando
	ld (0e20ah),a		;9e87   ; la direccion congelada mientras dura el salto
	ld a,00ch		;9e8a
	ld (0e203h),a		;9e8c   ; el ESTADO de lo que se maneja
	jp 0b48dh		;9e8f   ; banco 3
L_9E92:
	ld hl,0989ch		;9e92
	call 04056h		;9e95   ; banco 0: a_mas_hl
	ld a,(hl)			;9e98
	ld hl,0e204h		;9e99
	add a,(hl)			;9e9c
	ld (hl),a			;9e9d
L_9E9E:
	call 0a8dbh		;9e9e   ; banco 3
	ld a,(0e208h)		;9ea1   ; el paso dentro del salto
	rra			;9ea4
	ld a,003h		;9ea5
	jr c,L_9EAA		;9ea7
	inc a			;9ea9
L_9EAA:
	jp 0a8f5h		;9eaa   ; banco 3
descuenta_la_cuenta_de_0xE1F4:
	ld hl,(0e1f4h)		;9ead   ; la cuenta de 16 bits
	dec hl			;9eb0   ; uno menos
	ld (0e1f4h),hl		;9eb1
	ld a,l			;9eb4
	or h			;9eb5   ; y hasta cero, se sigue
	jr nz,L_9EEB		;9eb6
L_9EB8:
	ld a,0e0h		;9eb8
	ld (0ee90h),a		;9eba   ; el hueco de sprite 4
	ld (0ee94h),a		;9ebd   ; el hueco de sprite 5
	ld a,011h		;9ec0
	ld (0e203h),a		;9ec2   ; el ESTADO de lo que se maneja
	xor a			;9ec5
	ld (0e1f0h),a		;9ec6
	ld (0e1f4h),a		;9ec9
	call L_9493		;9ecc

; ----------------------------------------------------------------------
; AVISAR AL DECORADO. Solo cinco de los diez decorados tienen algo que hacer aqui: el 2, el 3 y el 6 van a 0x592C y el 4 y el 5 a 0x58F0. Los otros cinco no hacen nada.
; ----------------------------------------------------------------------
avisa_al_decorado:
	ld a,(0e0a1h)		;9ecf   ; el decorado
	cp 002h		;9ed2   ; el 2...
	jr z,L_9EE8		;9ed4
	cp 003h		;9ed6   ; ...el 3...
	jr z,L_9EE8		;9ed8
	cp 006h		;9eda   ; ...y el 6 por un lado
	jr z,L_9EE8		;9edc
	cp 004h		;9ede   ; el 4...
	jr z,L_9EE5		;9ee0
	cp 005h		;9ee2   ; ...y el 5 por otro; y los demas, nada
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
	call 0bbd6h		;9f11   ; banco 3
	xor a			;9f14
	ld (0e212h),a		;9f15
L_9F18:
	ld a,(0e003h)		;9f18   ; el contador de cuadros
	and 003h		;9f1b
	jr nz,L_9F48		;9f1d
	ld hl,0e212h		;9f1f
	ld a,(hl)			;9f22
	cp 00ch		;9f23
	jr nc,mueve_de_fila_con_topes_bis		;9f25
	ld a,(hl)			;9f27
	inc (hl)			;9f28
	ld hl,09c74h		;9f29
	call 04056h		;9f2c   ; banco 0: a_mas_hl
	ld a,(hl)			;9f2f
	ld (0e214h),a		;9f30
mueve_de_fila_con_topes_bis:
	ld a,(0e214h)		;9f33   ; el empujon
	ld hl,0e204h		;9f36   ; la fila
	add a,(hl)			;9f39
	ld (hl),a			;9f3a   ; sumado
	cp 040h		;9f3b   ; por arriba, la fila 0x40...
	jr nc,L_9F43		;9f3d
	ld (hl),040h		;9f3f
	jr L_9F48		;9f41
L_9F43:
	cp 091h		;9f43   ; ...y por abajo, la 0x90, que aqui acaba el tramo
	jp nc,L_9EB8		;9f45
L_9F48:
	call 0a84bh		;9f48   ; banco 3
	ld a,(0e209h)		;9f4b   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	call 0a87ah		;9f4e   ; banco 3
	ld hl,(0e204h)		;9f51   ; la Y en la pantalla de lo que se maneja
	ld a,01dh		;9f54
	add a,l			;9f56
	ld l,a			;9f57
	ld (0e20fh),hl		;9f58
	call 0a8dbh		;9f5b   ; banco 3
	ld hl,(0e20fh)		;9f5e
	ld (0ee90h),hl		;9f61   ; el hueco de sprite 4
	ld a,010h		;9f64
	add a,h			;9f66
	ld h,a			;9f67
	ld (0ee94h),hl		;9f68   ; el hueco de sprite 5
	ld a,(0e209h)		;9f6b   ; hacia donde se mueve lo que se maneja: 4 izquierda, 8 derecha
	bit 2,a		;9f6e
	ld c,001h		;9f70
	jr nz,L_9F7C		;9f72
	bit 3,a		;9f74
	ld c,002h		;9f76
	jr nz,L_9F7C		;9f78
	ld c,000h		;9f7a
L_9F7C:
	ld a,c			;9f7c
	jp 0a8f5h		;9f7d   ; banco 3
L_9F80:
	call 0a083h		;9f80   ; banco 3
	ld a,(0e003h)		;9f83   ; el contador de cuadros
	rra			;9f86
	ret c			;9f87
	ld a,(0e204h)		;9f88   ; la Y en la pantalla de lo que se maneja
	cp 0f8h		;9f8b
	jr nz,L_9F9A		;9f8d
	ld a,0e0h		;9f8f
	ld (0ee98h),a		;9f91   ; el hueco de sprite 6, el del bicho que vuela
	ld a,019h		;9f94
	ld (0e203h),a		;9f96   ; el ESTADO de lo que se maneja
	ret			;9f99
L_9F9A:
	dec a			;9f9a
	ld (0e204h),a		;9f9b   ; la Y en la pantalla de lo que se maneja
	ld hl,(0e204h)		;9f9e   ; la Y en la pantalla de lo que se maneja
	ld a,l			;9fa1
	add a,008h		;9fa2
	ld l,a			;9fa4
	ld a,h			;9fa5
	add a,008h		;9fa6
	ld h,a			;9fa8
	ld (0e0bbh),hl		;9fa9   ; la fila del bicho que vuela
	call 0a8dbh		;9fac   ; banco 3
	ld hl,(0e0bbh)		;9faf   ; la fila del bicho que vuela
	ld (0ee98h),hl		;9fb2   ; el hueco de sprite 6, el del bicho que vuela
	ld a,004h		;9fb5
	call 0a8f5h		;9fb7   ; banco 3
	ld a,(0e003h)		;9fba   ; el contador de cuadros
	and 008h		;9fbd
	ld a,07ch		;9fbf
	jr z,L_9FC5		;9fc1
	ld a,080h		;9fc3
L_9FC5:
	ld (0ee9ah),a		;9fc5
	ret			;9fc8
L_9FC9:
	ld a,(0e204h)		;9fc9   ; la Y en la pantalla de lo que se maneja
	add a,003h		;9fcc
	ld (0e204h),a		;9fce   ; la Y en la pantalla de lo que se maneja
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
	ld (0e203h),a		;9ff1   ; el ESTADO de lo que se maneja
	ld a,b			;9ff4
	ld (0e204h),a		;9ff5   ; la Y en la pantalla de lo que se maneja
	ld a,e			;9ff8
	jp 0413ah		;9ff9   ; banco 0: pide_sonido_si_esta_activo
L_9FFC:
	call 0a8dbh		;9ffc   ; banco 3

; ----------------------------------------------------------------------
; DATOS medio_ld_a: el 0x3E de un `ld a,4` partido entre dos bancos: el 0x04
;   es el primer byte del banco 3, que va detras en 0xA000. El trazador de un
;   solo banco no puede listar una instruccion a caballo (tools/bancos.py,
;   `partidas`)
;   0x9fff..0xa000  (1 bytes)
DATA_medio_ld_a:
	defb 03eh	; 9fff
