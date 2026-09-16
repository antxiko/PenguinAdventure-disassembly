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



; ----------------------------------------------------------------------
; ARRANCAR UNA VOZ. Copia los 21 bytes de una plantilla a la voz y la deja callada.
; ----------------------------------------------------------------------
arranca_una_voz:
	ld bc,00015h		;8000   ; los 21 bytes de una voz
	ldir		;8003   ; la plantilla, encima de la voz
	ld c,a			;8005   ; C se queda con el numero de efecto, que el borrado no toca
	xor a			;8006
	ld (0e07ah),a		;8007   ; y la marca de efecto, a cero
	ret			;800a   ; la voz queda arrancada y callada

; ----------------------------------------------------------------------
; REPETIR UN TROZO. El mando 0xFE de la partitura: detras lleva cuantas vueltas hay que dar y adonde volver. El contador vive en la propia voz (+0x0B), asi que cada voz lleva su cuenta. PERO CON UN CERO DETRAS NO REPITE NADA: `FE 00` son dos bytes que cambian de lenguaje (0x8039).
; ----------------------------------------------------------------------
repite_un_trozo:
	inc hl			;800b   ; el byte de detras del 0xFE
	ld a,(hl)			;800c
	or a			;800d   ; un cero no son vueltas: es el cambio de lenguaje de 0x8039
	jr z,cambia_de_lenguaje		;800e
	ld a,(ix+00bh)		;8010   ; por que vuelta va
	inc a			;8013
	cp (hl)			;8014   ; contra las que pide la partitura
	jr z,repite_se_acabaron_las_vueltas		;8015   ; si ya estan dadas, se sigue de largo
	jp m,L_801B		;8017
	dec a			;801a
L_801B:
	ld (ix+00bh),a		;801b   ; una vuelta mas
	inc hl			;801e   ; y se vuelve al sitio que dice la partitura
	ld a,(hl)			;801f
	ld (ix+003h),a		;8020   ; el puntero, byte bajo
	inc hl			;8023
	ld a,(hl)			;8024
	ld (ix+004h),a		;8025   ; y byte alto
	jr L_8033		;8028
repite_se_acabaron_las_vueltas:
	inc hl			;802a   ; se saltan los dos bytes del destino
	inc hl			;802b
	xor a			;802c   ; y la cuenta a cero, por si se vuelve a pasar por aqui
	ld (ix+00bh),a		;802d
L_8030:
	call apunta_donde_se_quedo		;8030
L_8033:
	inc (ix+000h)		;8033   ; un mando mas de la partitura
	jp un_paso_de_partitura		;8036   ; y a atenderlo

; ----------------------------------------------------------------------
; CAMBIAR DE LENGUAJE. `FE 00` le da la vuelta a la marca +0x0E de la voz y sigue en el byte de detras (0x8030). Con la marca puesta la partitura se lee con mando_de_efecto (0x820C: notas de un byte, prefijos D0, F0 y E0) y sin ella con mando_de_musica (0x80F8: instrumento, ruido y notas de dos bytes), y una misma partitura salta de uno a otro. Comprobado recorriendo las 206 partituras de la tabla de 0x873A: con esta lectura cierran todas en su 0xFF y cubren los bancos 14 y 15 sin un solo hueco de mas; leyendo `FE 00` como vueltas sin fin salian destinos imposibles como 0x0228.
; ----------------------------------------------------------------------
cambia_de_lenguaje:
	ld a,(ix+00eh)		;8039   ; la marca de efecto
	or a			;803c   ; ¿hay efecto?
	jr z,L_8044		;803d   ; si lo hay, por un lado; si no, por el otro
	dec (ix+00eh)		;803f   ; si estaba puesta, se quita
	jr L_8047		;8042
L_8044:
	inc (ix+00eh)		;8044   ; y si no, se pone
L_8047:
	jr L_8030		;8047   ; y en los dos casos se apunta donde se quedo

; ----------------------------------------------------------------------
; EL REGISTRO 7 DEL PSG, EL DE LA MEZCLA. Es el unico registro del PSG que comparten las tres voces -tres bits para el tono y tres para el ruido-, asi que no se puede escribir a lo bruto: hay que respetar lo que hayan puesto las otras. Por eso se guarda una copia en 0xE079 y aqui se le encienden o se le apagan solo los bits de esta voz.
; ----------------------------------------------------------------------
pon_la_mezcla:
	ld a,(0e079h)		;8049   ; la copia de lo que hay ahora en el registro 7
	ld e,a			;804c
	ld a,(ix+005h)		;804d   ; el instrumento de esta voz
	and 003h		;8050   ; los dos bits de abajo dicen si suena tono, ruido o los dos
	ld d,a			;8052
	ld a,c			;8053   ; el numero de voz
	cp 001h		;8054
	jr z,L_8059		;8056
	dec a			;8058
L_8059:
	ld b,a			;8059
	bit 1,d		;805a   ; el bit 1: el ruido
	call z,enciende_el_bit		;805c   ; apagado, se enciende el bit
	bit 1,d		;805f
	call nz,apaga_el_bit		;8061   ; encendido, se apaga
	ld a,b			;8064   ; el numero de voz otra vez
	rlca			;8065   ; tres vueltas: los bits de ruido van tres mas arriba
	rlca			;8066
	rlca			;8067
	bit 0,d		;8068   ; y ahora el bit 0, el del tono
	call z,enciende_el_bit		;806a
	bit 0,d		;806d
	call nz,apaga_el_bit		;806f
escribe_la_mezcla:
	ld (0e079h),a		;8072   ; la copia nueva
	ld e,a			;8075
	ld a,007h		;8076   ; registro 7
	jp 00093h		;8078   ; BIOS WRTPSG - Writes data to PSG-register | BIOS WRTPSG
apaga_el_bit:
	cpl			;807b   ; el bit del reves
	and e			;807c   ; y se borra de la copia
	ld e,a			;807d
	ret			;807e
enciende_el_bit:
	or e			;807f   ; se anade a la copia
	ld e,a			;8080
	ret			;8081

; ----------------------------------------------------------------------
; EL CUADRO DEL SONIDO. La llama la interrupcion (p00:4030) con los bancos 14 y 15 puestos, y es lo unico del cartucho que se ejecuta SIEMPRE, aunque el juego vaya con retraso. Recorre las cuatro voces de 0xE010 y a cada una le da un paso de su partitura.
; ----------------------------------------------------------------------
cuadro_de_sonido:
	ld a,(0e079h)		;8082   ; la copia del registro de mezcla
	call escribe_la_mezcla		;8085   ; se vuelve a escribir tal cual: deja el PSG como estaba
	ld c,001h		;8088   ; C lleva la voz, y va de dos en dos
	ld ix,0e010h		;808a   ; la primera voz
	exx			;808e   ; el juego de registros de repuesto guarda la cuenta
	ld b,004h		;808f   ; cuatro voces
	ld de,00015h		;8091   ; 21 bytes de una a la siguiente
cuadro_de_sonido_voz:
	exx			;8094
	ld a,c			;8095   ; la voz que toca
	cp 001h		;8096
	jr nz,cuadro_de_sonido_efecto		;8098   ; la voz 1 es la que puede llevar el efecto de encima
	ld a,(0e07ah)		;809a   ; la bandera de silencio general
	or a			;809d
	jr z,cuadro_de_sonido_atiende		;809e
	ld a,c			;80a0
	ld hl,0e064h		;80a1   ; la plantilla de voz callada
	ld de,0e010h		;80a4
	call arranca_una_voz		;80a7   ; y se le mete tal cual
cuadro_de_sonido_atiende:
	ld a,(ix+002h)		;80aa   ; ¿esta callada?
	or a			;80ad
	jr nz,L_80BA		;80ae   ; si no esta callada, hay partitura que seguir
	ld a,c			;80b0
	cp 007h		;80b1   ; la voz 7 -el ruido- no se corta igual
	jr z,L_80B8		;80b3
	call calla_la_voz		;80b5   ; callar la voz
L_80B8:
	jr cuadro_de_sonido_siguiente		;80b8
L_80BA:
	call un_paso_de_partitura		;80ba   ; y si no, un paso de partitura
cuadro_de_sonido_siguiente:
	inc c			;80bd   ; la voz siguiente, de dos en dos
	inc c			;80be
	exx			;80bf
	add ix,de		;80c0   ; y 21 bytes mas alla en la RAM
	djnz cuadro_de_sonido_voz		;80c2   ; hasta las cuatro
	ret			;80c4   ; las cuatro voces atendidas
cuadro_de_sonido_efecto:
	ld a,(0e0a0h)		;80c5   ; la bandera del efecto que manda sobre todo
	or a			;80c8
	jr z,cuadro_de_sonido_atiende		;80c9   ; sin efecto, se atiende normal
	ld h,000h		;80cb   ; el volumen entra a cero
	call escribe_el_volumen		;80cd   ; y se escribe directamente
	jr cuadro_de_sonido_siguiente		;80d0

; ----------------------------------------------------------------------
; UN PASO DE PARTITURA. El corazon del reproductor: baja el contador de la nota que suena y, si llega a cero, lee el mando siguiente. EL LENGUAJE, que sale de las comparaciones de 0x80E8 y 0x80F8: 0xFE repite un trozo, 0xFF y arriba callan la voz, un byte de nibble alto 2 cambia el INSTRUMENTO -y si ademas trae el bit 3, la envolvente del PSG-, uno de nibble alto 1 pone el RUIDO, y cualquier otro es una NOTA, con el volumen en el nibble alto.
; ----------------------------------------------------------------------
un_paso_de_partitura:
	ld a,(ix+00eh)		;80d2   ; ¿hay un efecto sonando encima?
	or a			;80d5
	jp nz,atiende_el_efecto		;80d6
	ld (ix+010h),000h		;80d9   ; la marca de efecto, a cero
	dec (ix+000h)		;80dd   ; un cuadro menos de la nota que suena
	ret nz			;80e0   ; y mientras dure, no se lee nada
lee_el_mando:
	ld l,(ix+003h)		;80e1   ; el puntero a la partitura
	ld h,(ix+004h)		;80e4
	ld a,(hl)			;80e7   ; el mando
	cp 0feh		;80e8   ; 0xFE: repetir un trozo
	jp z,repite_un_trozo		;80ea
	jp nc,calla_la_voz		;80ed   ; 0xFF y arriba: se acabo, a callar
	ld a,(ix+00eh)		;80f0   ; si hay efecto, el mando se lee de otra manera
	or a			;80f3
	ld a,(hl)			;80f4
	jp nz,mando_de_efecto		;80f5
mando_de_musica:
	and 0f0h		;80f8   ; el nibble de arriba
	cp 020h		;80fa   ; 2: cambiar de instrumento
	jr nz,mando_de_ruido		;80fc
	ld a,(hl)			;80fe   ; y el instrumento es el byte entero
	ld (ix+005h),a		;80ff
	inc hl			;8102
	ld a,(ix+010h)		;8103   ; si lo que suena es un efecto, el volumen no se toca
	or a			;8106
	ld a,(hl)			;8107
	jr nz,L_810D		;8108
	ld (ix+001h),a		;810a   ; y si no, el volumen nuevo
L_810D:
	ld (ix+014h),a		;810d   ; pero se apunta igual, para cuando acabe el efecto
	inc hl			;8110
	ld a,(ix+005h)		;8111   ; el instrumento otra vez
	cp 020h		;8114   ; el 0x20 pelado es un caso aparte
	jr nz,L_8124		;8116
	dec hl			;8118
	xor a			;8119
	ld b,a			;811a
	ld a,(ix+010h)		;811b
	or a			;811e
	jp nz,apunta_el_guion_del_efecto		;811f
	jr L_8159		;8122
L_8124:
	bit 3,a		;8124   ; el bit 3 del instrumento: lleva envolvente
	jr z,mando_de_ruido		;8126
	ld a,(hl)			;8128   ; el periodo de la envolvente, byte bajo
	ld e,a			;8129
	ld a,00ch		;812a
	call 00093h		;812c   ; BIOS WRTPSG - Writes data to PSG-register | registro 12 del PSG
	inc hl			;812f
	ld a,(hl)			;8130   ; y byte alto
	ld e,a			;8131
	ld a,00bh		;8132
	call 00093h		;8134   ; BIOS WRTPSG - Writes data to PSG-register | registro 11
	inc hl			;8137
mando_de_ruido:
	ld a,(hl)			;8138   ; el mando siguiente
	and 0f0h		;8139
	cp 010h		;813b   ; 1: el ruido
	jr nz,mando_de_nota		;813d
	ld a,(hl)			;813f
	and 00fh		;8140   ; los cuatro bits de abajo son el periodo
	add a,a			;8142   ; por dos
	ld e,a			;8143
	ld a,006h		;8144   ; registro 6 del PSG, el del ruido
	call 00093h		;8146   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;8149
mando_de_nota:
	ld a,(hl)			;814a   ; el nibble de arriba es el VOLUMEN
	and 0f0h		;814b
	ld b,a			;814d
	xor (hl)			;814e   ; y el de abajo, con el byte siguiente, la nota
	ld d,a			;814f
	inc hl			;8150
	ld e,(hl)			;8151   ; el segundo byte
	ld a,(ix+010h)		;8152   ; si es un efecto, por otro camino
	or a			;8155
	jp nz,apunta_el_guion_del_efecto		;8156
L_8159:
	call apunta_donde_se_quedo		;8159
nota_a_sonar:
	ex de,hl			;815c
	call escribe_el_periodo		;815d   ; el periodo de la nota al PSG
	ld a,b			;8160
	rrca			;8161   ; cuatro vueltas: el volumen baja al nibble de abajo
	rrca			;8162
	rrca			;8163
	rrca			;8164
	ld h,a			;8165
	ld a,(ix+010h)		;8166   ; ¿es efecto?
	or a			;8169
	jp z,nota_de_musica		;816a
	ld a,(ix+014h)		;816d   ; el volumen que le tocaria a la musica se guarda aparte
	ld (ix+013h),a		;8170
	jr escribe_el_volumen		;8173
nota_de_musica:
	ld a,(ix+001h)		;8175   ; y la duracion sale del volumen apuntado
	ld (ix+000h),a		;8178
	jr escribe_el_volumen		;817b

; ----------------------------------------------------------------------
; CALLAR UNA VOZ. Pone a cero los siete campos que hacen que suene y devuelve la mezcla sin sus bits. Si la voz es la del ruido hace ademas una cosa mas: mira 0xE07C, y si hay un efecto pendiente lo arranca ahi mismo.
; ----------------------------------------------------------------------
calla_la_voz:
	xor a			;817d
	ld (ix+002h),a		;817e   ; deja de estar callada... y todo lo demas a cero
	ld h,a			;8181
	ld (ix+005h),a		;8182   ; el instrumento
	ld (ix+00bh),a		;8185   ; la cuenta de repeticiones
	ld (ix+00eh),a		;8188   ; la marca de efecto
	ld (ix+00fh),a		;818b
	ld (ix+010h),a		;818e   ; y la de que suena un efecto
	ld a,c			;8191   ; el numero de voz
	cp 007h		;8192   ; por debajo de 7 no hay nada mas que hacer
	jr c,escribe_el_volumen		;8194
	ld l,000h		;8196
	dec c			;8198
	dec c			;8199
	call escribe_el_periodo_al_psg		;819a   ; la voz del ruido, que se apaga aparte
	call escribe_el_volumen_de_verdad		;819d
	ld a,(0e07ch)		;81a0   ; ¿habia un efecto esperando?
	ld b,a			;81a3
	or a			;81a4
	ret z			;81a5   ; si no lo habia, se acabo
	xor a			;81a6
	ld (0e07ch),a		;81a7   ; se borra la peticion
	ld a,b			;81aa
	jp pide_un_efecto		;81ab   ; y se arranca el efecto
baja_el_barrido:
	dec (ix+00ah)		;81ae
baja_el_volumen:
	ld a,(ix+008h)		;81b1   ; el volumen que va bajando
	dec a			;81b4
	ret m			;81b5   ; si ya estaba a cero, nada
	ld (ix+008h),a		;81b6
	ld h,a			;81b9

; ----------------------------------------------------------------------
; ESCRIBIR EL VOLUMEN. El registro de volumen de cada voz sale de la cuenta de 0x81D2: `rrca` sobre el numero de voz y 0x88 encima, que da 8, 9 o 10. Y si el instrumento trae el bit 3, en vez del volumen se le mete 0x10, que es lo que le dice al PSG "el volumen lo lleva la envolvente".
; ----------------------------------------------------------------------
escribe_el_volumen:
	ld a,(0e051h)		;81ba   ; la bandera de silencio de esta voz
	ld e,a			;81bd
	ld a,c			;81be
	cp 005h		;81bf   ; por debajo de 5 se escribe siempre
	jr c,escribe_el_volumen_de_verdad		;81c1
	jr nz,L_81CA		;81c3
	ld a,e			;81c5
	or a			;81c6
	ret nz			;81c7
	jr escribe_el_volumen_de_verdad		;81c8
L_81CA:
	ld a,e			;81ca
	or a			;81cb
	ret z			;81cc
	dec c			;81cd
	dec c			;81ce
escribe_el_volumen_de_verdad:
	call pon_la_mezcla		;81cf   ; primero la mezcla, que es de todos
	ld a,c			;81d2
	rrca			;81d3   ; media vuelta al numero de voz...
	add a,088h		;81d4   ; ...y 0x88 encima: sale el registro 8, 9 o 10
	ld d,a			;81d6
	bit 3,(ix+005h)		;81d7   ; el bit 3 del instrumento: envolvente
	jr z,escribe_el_volumen_al_psg		;81db
	ld e,h			;81dd   ; la forma de la envolvente
	ld a,00dh		;81de
	call 00093h		;81e0   ; BIOS WRTPSG - Writes data to PSG-register | registro 13 del PSG
	ld a,010h		;81e3   ; y 0x10 en el volumen: "que mande la envolvente"
	ld h,a			;81e5
escribe_el_volumen_al_psg:
	ld a,d			;81e6
	ld e,h			;81e7
	jp 00093h		;81e8   ; BIOS WRTPSG - Writes data to PSG-register | BIOS WRTPSG con el registro que toque

; ----------------------------------------------------------------------
; EL EFECTO, QUE MANDA SOBRE LA MUSICA. Mientras 0x0E de la voz no sea cero, lo que se atiende es el efecto y no la partitura: la nota va bajando de volumen sola, cuadro a cuadro, hasta que se acaba y la musica vuelve a tener la voz.
; ----------------------------------------------------------------------
atiende_el_efecto:
	dec (ix+000h)		;81eb   ; un cuadro menos
	jp z,lee_el_mando		;81ee   ; y cuando se acaba, se vuelve a la partitura
	ld a,(ix+010h)		;81f1   ; ¿es un efecto de los otros?
	or a			;81f4
	jp nz,un_paso_de_efecto		;81f5
	dec (ix+00ah)		;81f8   ; el barrido, un paso
	ld a,(ix+00ah)		;81fb
	cp (ix+000h)		;81fe   ; contra lo que queda de nota
	jr nz,baja_el_barrido		;8201
	ld e,a			;8203
	ld a,(ix+00dh)		;8204   ; y contra el tope
	cp e			;8207
	ld a,e			;8208
	jr nc,baja_el_volumen		;8209
	ret			;820b
mando_de_efecto:
	ld a,(hl)			;820c   ; el mando
	and 0f0h		;820d
	cp 0d0h		;820f   ; 0xD0: fija un campo del efecto
	ld a,(hl)			;8211
	jr nz,L_821B		;8212
	and 00fh		;8214   ; los cuatro bits de abajo
	ld (ix+006h),a		;8216
	inc hl			;8219
	ld a,(hl)			;821a
L_821B:
	cp 0f0h		;821b   ; 0xF0 y arriba: el barrido
	jr c,mando_de_efecto_mas		;821d
	and 00fh		;821f   ; los cuatro de abajo, y dos mas
	inc a			;8221
	inc a			;8222
	ld (ix+007h),a		;8223
	inc hl			;8226   ; el byte siguiente
	ld a,(hl)			;8227
	and 0f0h		;8228
	rrca			;822a   ; cuatro vueltas: el nibble de arriba
	rrca			;822b
	rrca			;822c
	rrca			;822d
	ld (ix+00ch),a		;822e
	ld a,(hl)			;8231
	and 00fh		;8232   ; los cuatro de abajo
	ld (ix+00dh),a		;8234
	inc hl			;8237
	ld a,(hl)			;8238   ; el byte siguiente
mando_de_efecto_mas:
	cp 0e0h		;8239   ; 0xE0 y arriba: mandos de efecto
	jr c,nota_del_efecto		;823b
	and 00fh		;823d   ; los cuatro de abajo
	cp 008h		;823f   ; por debajo de 8, es el desplazamiento de octava
	jr c,mando_octava		;8241
	jr nz,L_824B		;8243
	ld (ix+00fh),a		;8245   ; el 8 justo enciende una bandera
	inc hl			;8248
	jr mando_de_efecto		;8249
L_824B:
	cp 00fh		;824b   ; el 0x0F apaga el efecto
	jr z,L_8256		;824d
	sub 008h		;824f   ; y del 9 al 14 se guarda restandole 8
	ld (ix+010h),a		;8251
	jr L_8263		;8254
L_8256:
	xor a			;8256   ; a cero las dos banderas
	ld (ix+00fh),a		;8257
	ld (ix+010h),a		;825a
	inc hl			;825d
	jr mando_de_efecto		;825e
mando_octava:
	ld (ix+009h),a		;8260   ; el desplazamiento de octava
L_8263:
	inc hl			;8263
	ld a,(hl)			;8264
nota_del_efecto:
	and 00fh		;8265   ; los cuatro de abajo del mando
	ld b,a			;8267
	ld a,(ix+006h)		;8268   ; y el valor base de la duracion
	jr z,L_8272		;826b
L_826D:
	add a,(ix+006h)		;826d   ; se multiplica sumando: B veces
	djnz L_826D		;8270
L_8272:
	ld (ix+001h),a		;8272   ; y esa es la duracion de la nota
	ld a,(hl)			;8275   ; el byte de la nota
	call apunta_donde_se_quedo		;8276   ; al PSG
	and 0f0h		;8279   ; el nibble de arriba
	rrca			;827b   ; cuatro vueltas para bajarlo
	rrca			;827c
	rrca			;827d
	rrca			;827e
	ld b,a			;827f
	ld a,(ix+010h)		;8280   ; ¿es un efecto?
	or a			;8283
	jr z,nota_normal		;8284
	add a,a			;8286   ; dos bytes por entrada
	ld de,08358h		;8287   ; la tabla de guiones de efecto
	add a,e			;828a
	ld e,a			;828b
	jr nc,L_828F		;828c
	inc d			;828e
L_828F:
	ld a,(de)			;828f   ; el puntero de ese efecto
	ld l,a			;8290
	inc de			;8291
	ld a,(de)			;8292
	ld h,a			;8293
	ld a,(ix+001h)		;8294   ; la duracion
	ld (ix+000h),a		;8297
	ld a,b			;829a
	add a,a			;829b   ; otra vez dos por entrada
	add a,l			;829c
	ld l,a			;829d
	jr nc,L_82A1		;829e
	inc h			;82a0
L_82A1:
	ld e,(hl)			;82a1   ; y de ahi sale el guion que hay que seguir
	ld (ix+011h),e		;82a2
	inc hl			;82a5
	ld d,(hl)			;82a6
	ld (ix+012h),d		;82a7
	ex de,hl			;82aa
	ld a,(hl)			;82ab   ; su primer mando
	jp mando_de_musica		;82ac
nota_normal:
	ld a,b			;82af   ; el numero de nota
	sub 00ch		;82b0   ; el 12 es un caso aparte: no hay semitono numero doce
	jr z,L_82B7		;82b2
	ld a,(ix+007h)		;82b4   ; y si no, el valor de siempre
L_82B7:
	ld (ix+008h),a		;82b7
	ld d,a			;82ba
	ld e,(ix+001h)		;82bb   ; la duracion
	ld (ix+000h),e		;82be
	ld a,(ix+00ch)		;82c1   ; el barrido se suma a la duracion
	add a,e			;82c4
	ld (ix+00ah),a		;82c5
	ld a,b			;82c8
	ld hl,0834eh		;82c9   ; LA TABLA DE LOS DOCE SEMITONOS
	add a,l			;82cc   ; el que toca
	ld l,a			;82cd
	jr nc,L_82D1		;82ce
	inc h			;82d0
L_82D1:
	ld l,(hl)			;82d1   ; su periodo, que es de un solo byte
	ld h,000h		;82d2
	ld a,(ix+009h)		;82d4   ; el desplazamiento de octava
	or a			;82d7
	jr z,L_82DE		;82d8
	ld b,a			;82da
L_82DB:
	add hl,hl			;82db   ; y cada vuelta es una octava mas grave: el periodo se dobla
	djnz L_82DB		;82dc
L_82DE:
	call escribe_el_periodo		;82de   ; el periodo, al PSG
	jp escribe_el_volumen		;82e1   ; y el volumen detras
escribe_el_periodo:
	ld a,(0e051h)		;82e4   ; la bandera de silencio
	ld e,a			;82e7
	ld a,c			;82e8   ; el numero de voz
	cp 005h		;82e9   ; la 5 y las de arriba tienen reglas propias
	jr c,escribe_el_periodo_al_psg		;82eb
	jr nz,L_82F4		;82ed
	ld a,e			;82ef   ; si la bandera esta puesta, esta voz no suena
	or a			;82f0
	ret nz			;82f1
	jr escribe_el_periodo_al_psg		;82f2
L_82F4:
	ld a,e			;82f4
	or a			;82f5
	ret z			;82f6
	dec c			;82f7   ; se escribe como si fuera la voz de dos antes
	dec c			;82f8
	call escribe_el_periodo_al_psg		;82f9
	inc c			;82fc
	inc c			;82fd
	ret			;82fe
escribe_el_periodo_al_psg:
	ld a,(ix+00fh)		;82ff   ; la bandera de medio tono
	or a			;8302
	jr z,L_8306		;8303
	inc hl			;8305   ; que corre el periodo un byte
L_8306:
	ld a,c			;8306   ; el registro del periodo de esta voz
	ld e,h			;8307   ; byte ALTO primero
	call 00093h		;8308   ; BIOS WRTPSG - Writes data to PSG-register | BIOS WRTPSG
	ld a,c			;830b
	dec a			;830c   ; y el registro de al lado es el byte bajo
	ld e,l			;830d
	call 00093h		;830e   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(ix+010h)		;8311   ; ¿es un efecto?
	or a			;8314
	ret nz			;8315
	ld a,(ix+00eh)		;8316   ; ¿o queda efecto sonando?
	or a			;8319
	ret z			;831a
	ld h,d			;831b
	ld a,002h		;831c   ; instrumento 2 mientras dure
	ld (ix+005h),a		;831e
	ret			;8321
apunta_donde_se_quedo:
	inc hl			;8322   ; el byte siguiente de la partitura
	ld (ix+003h),l		;8323   ; y se guarda en la voz, byte bajo y alto
	ld (ix+004h),h		;8326
	ret			;8329
un_paso_de_efecto:
	dec (ix+013h)		;832a   ; un cuadro menos del paso del efecto
	ret nz			;832d
	ld l,(ix+011h)		;832e   ; el puntero al guion del efecto
	ld h,(ix+012h)		;8331
	ld a,(hl)			;8334   ; su mando
	cp 0ffh		;8335   ; 0xFF: se acabo el efecto
	jr z,L_8346		;8337
	jp mando_de_musica		;8339   ; y si no, se lee como un mando de musica
apunta_el_guion_del_efecto:
	inc hl			;833c
	ld (ix+011h),l		;833d   ; donde se quedo el guion del efecto
	ld (ix+012h),h		;8340
	jp nota_a_sonar		;8343
L_8346:
	xor a			;8346
	ld h,a			;8347
	ld (ix+005h),a		;8348
	jp escribe_el_volumen		;834b

; ----------------------------------------------------------------------
; DATOS los_doce_semitonos: Los doce semitonos de una octava, en periodos del
;   PSG y de un solo byte: 0x6B, 0x65, 0x5F, 0x5A, 0x55, 0x50, 0x4C, 0x47,
;   0x43, 0x40, 0x3C y 0x39. Que sean doce y que el primero valga casi el
;   doble que el ultimo -107 contra 57- es lo que dice que son una octava
;   entera. La octava en la que suena la pone 0x82DB doblando el periodo
;   tantas veces como diga el desplazamiento, que es lo mismo que bajar
;   octavas.
;   0x834e..0x835a  (12 bytes)
DATA_los_doce_semitonos:
	defb 06bh,065h,05fh,05ah,055h,050h,04ch,047h,043h,040h,03ch,039h	; 834e  ke_ZUPLGC@<9

; ----------------------------------------------------------------------
; DATOS guiones_de_efecto: Los punteros a las TRES tablas de sub-efectos,
;   dentro de este mismo banco: 0x8360, 0x84DD y 0x85D6. 0x8287 los indexa con
;   la bandera de 0x10 de la voz, DESDE UNO -por eso la tabla se direcciona
;   como si empezara en 0x8358-. Son tres y no mas porque la primera tabla
;   empieza justo detras, en 0x8360 (antes aqui se leian doce punteros "en
;   parejas", y los nueve de mas eran la tabla de al lado)
;   0x835a..0x8360  (6 bytes)
DATA_guiones_de_efecto:
	defw 08360h	; 835a  -> DATA_sub_efecto_1
	defw 084ddh	; 835c  -> DATA_sub_efecto_2
	defw 085d6h	; 835e  -> DATA_sub_efecto_3

; ----------------------------------------------------------------------
; DATOS sub_efecto_1: 13 punteros a los guiones de musica del sub-efecto 1:
;   p14:8287 la saca de 0x8358 + 2*1 y la indexa con el nibble alto de la
;   nota. Acaba donde empieza su primer guion
;   0x8360..0x837a  (26 bytes)
DATA_sub_efecto_1:
	defb 07ah,083h	; 8360
	defb 080h,083h	; 8362
	defb 08eh,083h	; 8364
	defb 0a1h,083h	; 8366
	defb 0afh,083h	; 8368
	defb 0bdh,083h	; 836a
	defb 0e6h,083h	; 836c
	defb 00fh,084h	; 836e
	defb 038h,084h	; 8370
	defb 067h,084h	; 8372
	defb 096h,084h	; 8374
	defb 0c1h,084h	; 8376
	defb 0cfh,084h	; 8378

; ----------------------------------------------------------------------
; DATOS tira_837A: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 0) que lee p14:8287; lo cargan sub-efecto 1 nota 0 (6
;   bytes)
;   0x837a..0x8380  (6 bytes)
DATA_tira_837A:
	defb 021h,001h,010h,0a0h,000h,0ffh	; 837a

; ----------------------------------------------------------------------
; DATOS tira_8380: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 1) que lee p14:8287; lo cargan sub-efecto 1 nota 1 (14
;   bytes)
;   0x8380..0x838e  (14 bytes)
DATA_tira_8380:
	defb 023h,001h,013h,091h,080h,022h,001h,082h,000h,072h,070h,063h,030h,0ffh	; 8380  #...."...rpc0.

; ----------------------------------------------------------------------
; DATOS tira_838E: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 2) que lee p14:8287; lo cargan sub-efecto 1 nota 2 (19
;   bytes)
;   0x838e..0x83a1  (19 bytes)
DATA_tira_838E:
	defb 023h,001h,010h,0cah,000h,021h,004h,010h,0a0h,000h,090h,000h,080h,000h,070h,000h	; 838e  #....!........p.
	defb 060h,000h,0ffh	; 839e

; ----------------------------------------------------------------------
; DATOS tira_83A1: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 3) que lee p14:8287; lo cargan sub-efecto 1 nota 3 (14
;   bytes)
;   0x83a1..0x83af  (14 bytes)
DATA_tira_83A1:
	defb 023h,001h,013h,0c1h,030h,022h,001h,0c1h,0a0h,092h,020h,072h,0f0h,0ffh	; 83a1  #...0".... r..

; ----------------------------------------------------------------------
; DATOS tira_83AF: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 4) que lee p14:8287; lo cargan sub-efecto 1 nota 4 (14
;   bytes)
;   0x83af..0x83bd  (14 bytes)
DATA_tira_83AF:
	defb 023h,001h,013h,0c1h,080h,022h,001h,0c2h,000h,092h,070h,073h,030h,0ffh	; 83af  #...."....ps0.

; ----------------------------------------------------------------------
; DATOS tira_83BD: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 5) que lee p14:8287; lo cargan sub-efecto 1 nota 5 (41
;   bytes)
;   0x83bd..0x83e6  (41 bytes)
DATA_tira_83BD:
	defb 022h,001h,0b1h,050h,0a1h,05ah,0a1h,065h,091h,070h,091h,07ah,091h,085h,081h,090h	; 83bd  "..P.Z.e.p.z....
	defb 081h,09ah,081h,0a5h,081h,0b0h,071h,0bah,071h,0c5h,071h,0d0h,071h,0dah,071h,0e5h	; 83cd  ......q.q.q.q.q.
	defb 071h,0f0h,061h,0fah,062h,025h,052h,030h,0ffh	; 83dd  q.a.b%R0.

; ----------------------------------------------------------------------
; DATOS tira_83E6: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 6) que lee p14:8287; lo cargan sub-efecto 1 nota 6 (41
;   bytes)
;   0x83e6..0x840f  (41 bytes)
DATA_tira_83E6:
	defb 022h,001h,0b1h,0a0h,0a1h,0aah,0a1h,0b5h,091h,0c0h,091h,0cah,091h,0d5h,081h,0e0h	; 83e6  "...............
	defb 081h,0eah,081h,0f5h,082h,000h,072h,00ah,072h,015h,072h,020h,072h,02ah,072h,035h	; 83f6  ......r.r.r r*r5
	defb 072h,040h,062h,04ah,062h,055h,052h,060h,0ffh	; 8406  r@bJbUR`.

; ----------------------------------------------------------------------
; DATOS tira_840F: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 7) que lee p14:8287; lo cargan sub-efecto 1 nota 7 (41
;   bytes)
;   0x840f..0x8438  (41 bytes)
DATA_tira_840F:
	defb 022h,001h,0b1h,000h,0a1h,00ah,0a1h,015h,091h,020h,091h,02ah,091h,035h,081h,040h	; 840f  "........ .*.5.@
	defb 081h,04ah,081h,055h,081h,060h,071h,06ah,071h,075h,071h,080h,071h,08ah,071h,095h	; 841f  .J.U.`qjquq.q.q.
	defb 071h,0a0h,061h,0aah,061h,0b5h,051h,0c0h,0ffh	; 842f  q.a.a.Q..

; ----------------------------------------------------------------------
; DATOS tira_8438: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 8) que lee p14:8287; lo cargan sub-efecto 1 nota 8 (47
;   bytes)
;   0x8438..0x8467  (47 bytes)
DATA_tira_8438:
	defb 022h,001h,0c2h,000h,0b2h,00ah,0b2h,015h,0a2h,020h,0a2h,02ah,0a2h,035h,092h,040h	; 8438  "........ .*.5.@
	defb 092h,04ah,092h,055h,092h,060h,082h,06ah,082h,075h,082h,080h,082h,08ah,082h,095h	; 8448  .J.U.`.j.u......
	defb 072h,0a0h,072h,0aah,072h,0b5h,072h,0c0h,062h,0cah,062h,0d5h,052h,0e0h,0ffh	; 8458  r.r.r.r.b.b.R..

; ----------------------------------------------------------------------
; DATOS tira_8467: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 9) que lee p14:8287; lo cargan sub-efecto 1 nota 9 (47
;   bytes)
;   0x8467..0x8496  (47 bytes)
DATA_tira_8467:
	defb 022h,001h,0d3h,000h,0c3h,00ah,0c3h,015h,0b3h,020h,0b3h,02ah,0b3h,035h,0a3h,040h	; 8467  "........ .*.5.@
	defb 0a3h,04ah,0a3h,055h,0a3h,060h,093h,06ah,093h,075h,093h,080h,093h,08ah,093h,095h	; 8477  .J.U.`.j.u......
	defb 083h,0a0h,083h,0aah,083h,0b5h,073h,0c0h,073h,0cah,063h,0d5h,053h,0e0h,0ffh	; 8487  ......s.s.c.S..

; ----------------------------------------------------------------------
; DATOS tira_8496: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 10) que lee p14:8287; lo cargan sub-efecto 1 nota 10
;   (43 bytes)
;   0x8496..0x84c1  (43 bytes)
DATA_tira_8496:
	defb 022h,001h,0e4h,000h,0d4h,015h,0c4h,030h,0c4h,045h,0b4h,060h,0b4h,075h,0b4h,090h	; 8496  "......0.E.`.u..
	defb 0a4h,0b0h,0a4h,0d0h,0a4h,0f0h,0a5h,010h,095h,030h,095h,050h,094h,070h,094h,090h	; 84a6  .........0.P.p..
	defb 094h,0b0h,084h,0d0h,084h,0f0h,075h,010h,065h,030h,0ffh	; 84b6  ......u.e0.

; ----------------------------------------------------------------------
; DATOS tira_84C1: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 11) que lee p14:8287; lo cargan sub-efecto 1 nota 11
;   (14 bytes)
;   0x84c1..0x84cf  (14 bytes)
DATA_tira_84C1:
	defb 023h,001h,013h,081h,080h,022h,001h,072h,000h,062h,070h,053h,030h,0ffh	; 84c1  #....".r.bpS0.

; ----------------------------------------------------------------------
; DATOS tira_84CF: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 1, nota 12) que lee p14:8287; lo cargan sub-efecto 1 nota 12
;   (14 bytes)
;   0x84cf..0x84dd  (14 bytes)
DATA_tira_84CF:
	defb 023h,001h,013h,061h,080h,022h,001h,052h,000h,042h,070h,033h,030h,0ffh	; 84cf  #..a.".R.Bp30.

; ----------------------------------------------------------------------
; DATOS sub_efecto_2: 13 punteros a los guiones de musica del sub-efecto 2:
;   p14:8287 la saca de 0x8358 + 2*2 y la indexa con el nibble alto de la
;   nota. Acaba donde empieza su primer guion
;   0x84dd..0x84f7  (26 bytes)
DATA_sub_efecto_2:
	defb 0f7h,084h	; 84dd
	defb 008h,085h	; 84df
	defb 019h,085h	; 84e1
	defb 02ah,085h	; 84e3
	defb 03dh,085h	; 84e5
	defb 04eh,085h	; 84e7
	defb 05fh,085h	; 84e9
	defb 070h,085h	; 84eb
	defb 081h,085h	; 84ed
	defb 092h,085h	; 84ef
	defb 0a3h,085h	; 84f1
	defb 0b4h,085h	; 84f3
	defb 0c5h,085h	; 84f5

; ----------------------------------------------------------------------
; DATOS tira_84F7: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 0) que lee p14:8287; lo cargan sub-efecto 2 nota 0 (17
;   bytes)
;   0x84f7..0x8508  (17 bytes)
DATA_tira_84F7:
	defb 022h,004h,090h,036h,080h,036h,070h,036h,060h,036h,050h,036h,040h,036h,030h,036h	; 84f7  "..6.6p6`6P6@606
	defb 0ffh	; 8507

; ----------------------------------------------------------------------
; DATOS tira_8508: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 1) que lee p14:8287; lo cargan sub-efecto 2 nota 1 (17
;   bytes)
;   0x8508..0x8519  (17 bytes)
DATA_tira_8508:
	defb 022h,004h,090h,040h,080h,040h,070h,040h,060h,040h,050h,040h,040h,040h,030h,040h	; 8508  "..@.@p@`@P@@@0@
	defb 0ffh	; 8518

; ----------------------------------------------------------------------
; DATOS tira_8519: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 2) que lee p14:8287; lo cargan sub-efecto 2 nota 2 (17
;   bytes)
;   0x8519..0x852a  (17 bytes)
DATA_tira_8519:
	defb 022h,004h,090h,02fh,080h,02fh,070h,02fh,060h,02fh,050h,02fh,040h,02fh,030h,02fh	; 8519  ".././p/`/P/@/0/
	defb 0ffh	; 8529

; ----------------------------------------------------------------------
; DATOS tira_852A: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 3) que lee p14:8287; lo cargan sub-efecto 2 nota 3 (19
;   bytes)
;   0x852a..0x853d  (19 bytes)
DATA_tira_852A:
	defb 022h,004h,090h,02dh,080h,02dh,070h,02dh,060h,02dh,050h,02dh,040h,02dh,030h,02dh	; 852a  "..-.-p-`-P-@-0-
	defb 020h,02dh,0ffh	; 853a

; ----------------------------------------------------------------------
; DATOS tira_853D: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 4) que lee p14:8287; lo cargan sub-efecto 2 nota 4 (17
;   bytes)
;   0x853d..0x854e  (17 bytes)
DATA_tira_853D:
	defb 022h,004h,090h,02ah,080h,02ah,070h,02ah,060h,02ah,050h,02ah,040h,02ah,030h,02ah	; 853d  "..*.*p*`*P*@*0*
	defb 0ffh	; 854d

; ----------------------------------------------------------------------
; DATOS tira_854E: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 5) que lee p14:8287; lo cargan sub-efecto 2 nota 5 (17
;   bytes)
;   0x854e..0x855f  (17 bytes)
DATA_tira_854E:
	defb 022h,004h,090h,028h,080h,028h,070h,028h,060h,028h,050h,028h,040h,028h,030h,028h	; 854e  "..(.(p(`(P(@(0(
	defb 0ffh	; 855e

; ----------------------------------------------------------------------
; DATOS tira_855F: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 6) que lee p14:8287; lo cargan sub-efecto 2 nota 6 (17
;   bytes)
;   0x855f..0x8570  (17 bytes)
DATA_tira_855F:
	defb 022h,004h,090h,026h,080h,026h,070h,026h,060h,026h,050h,026h,040h,026h,030h,026h	; 855f  "..&.&p&`&P&@&0&
	defb 0ffh	; 856f

; ----------------------------------------------------------------------
; DATOS tira_8570: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 7) que lee p14:8287; lo cargan sub-efecto 2 nota 7 (17
;   bytes)
;   0x8570..0x8581  (17 bytes)
DATA_tira_8570:
	defb 022h,004h,090h,024h,080h,024h,070h,024h,060h,024h,050h,024h,040h,024h,030h,024h	; 8570  "..$.$p$`$P$@$0$
	defb 0ffh	; 8580

; ----------------------------------------------------------------------
; DATOS tira_8581: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 8) que lee p14:8287; lo cargan sub-efecto 2 nota 8 (17
;   bytes)
;   0x8581..0x8592  (17 bytes)
DATA_tira_8581:
	defb 022h,004h,090h,022h,080h,022h,070h,022h,060h,022h,050h,022h,040h,022h,030h,022h	; 8581  ".."."p"`"P"@"0"
	defb 0ffh	; 8591

; ----------------------------------------------------------------------
; DATOS tira_8592: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 9) que lee p14:8287; lo cargan sub-efecto 2 nota 9 (17
;   bytes)
;   0x8592..0x85a3  (17 bytes)
DATA_tira_8592:
	defb 022h,004h,090h,020h,080h,020h,070h,020h,060h,020h,050h,020h,040h,020h,030h,020h	; 8592  ".. . p ` P @ 0
	defb 0ffh	; 85a2

; ----------------------------------------------------------------------
; DATOS tira_85A3: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 10) que lee p14:8287; lo cargan sub-efecto 2 nota 10
;   (17 bytes)
;   0x85a3..0x85b4  (17 bytes)
DATA_tira_85A3:
	defb 022h,004h,090h,01eh,080h,01eh,070h,01eh,060h,01eh,050h,01eh,040h,01eh,030h,01eh	; 85a3  ".....p.`.P.@.0.
	defb 0ffh	; 85b3

; ----------------------------------------------------------------------
; DATOS tira_85B4: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 11) que lee p14:8287; lo cargan sub-efecto 2 nota 11
;   (17 bytes)
;   0x85b4..0x85c5  (17 bytes)
DATA_tira_85B4:
	defb 022h,004h,090h,01ch,080h,01ch,070h,01ch,060h,01ch,050h,01ch,040h,01ch,030h,01ch	; 85b4  ".....p.`.P.@.0.
	defb 0ffh	; 85c4

; ----------------------------------------------------------------------
; DATOS tira_85C5: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 2, nota 12) que lee p14:8287; lo cargan sub-efecto 2 nota 12
;   (17 bytes)
;   0x85c5..0x85d6  (17 bytes)
DATA_tira_85C5:
	defb 022h,004h,090h,039h,080h,039h,070h,039h,060h,039h,050h,039h,040h,039h,030h,039h	; 85c5  "..9.9p9`9P9@909
	defb 0ffh	; 85d5

; ----------------------------------------------------------------------
; DATOS sub_efecto_3: 12 punteros a los guiones de musica del sub-efecto 3:
;   p14:8287 la saca de 0x8358 + 2*3 y la indexa con el nibble alto de la
;   nota. Acaba donde empieza su primer guion
;   0x85d6..0x85ee  (24 bytes)
DATA_sub_efecto_3:
	defb 0eeh,085h	; 85d6
	defb 0ffh,085h	; 85d8
	defb 010h,086h	; 85da
	defb 021h,086h	; 85dc
	defb 032h,086h	; 85de
	defb 043h,086h	; 85e0
	defb 054h,086h	; 85e2
	defb 065h,086h	; 85e4
	defb 076h,086h	; 85e6
	defb 087h,086h	; 85e8
	defb 098h,086h	; 85ea
	defb 0a9h,086h	; 85ec

; ----------------------------------------------------------------------
; DATOS tira_85EE: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 0) que lee p14:8287; lo cargan sub-efecto 3 nota 0 (17
;   bytes)
;   0x85ee..0x85ff  (17 bytes)
DATA_tira_85EE:
	defb 022h,004h,090h,050h,080h,050h,070h,050h,060h,050h,050h,050h,040h,050h,030h,050h	; 85ee  "..P.PpP`PPP@P0P
	defb 0ffh	; 85fe

; ----------------------------------------------------------------------
; DATOS tira_85FF: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 1) que lee p14:8287; lo cargan sub-efecto 3 nota 1 (17
;   bytes)
;   0x85ff..0x8610  (17 bytes)
DATA_tira_85FF:
	defb 022h,002h,090h,032h,080h,032h,070h,032h,060h,032h,050h,032h,040h,032h,030h,032h	; 85ff  "..2.2p2`2P2@202
	defb 0ffh	; 860f

; ----------------------------------------------------------------------
; DATOS tira_8610: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 2) que lee p14:8287; lo cargan sub-efecto 3 nota 2 (17
;   bytes)
;   0x8610..0x8621  (17 bytes)
DATA_tira_8610:
	defb 022h,004h,090h,018h,080h,018h,070h,018h,060h,018h,050h,018h,040h,018h,030h,018h	; 8610  ".....p.`.P.@.0.
	defb 0ffh	; 8620

; ----------------------------------------------------------------------
; DATOS tira_8621: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 3) que lee p14:8287; lo cargan sub-efecto 3 nota 3 (17
;   bytes)
;   0x8621..0x8632  (17 bytes)
DATA_tira_8621:
	defb 022h,002h,090h,02fh,080h,02fh,070h,02fh,060h,02fh,050h,02fh,040h,02fh,030h,02fh	; 8621  ".././p/`/P/@/0/
	defb 0ffh	; 8631

; ----------------------------------------------------------------------
; DATOS tira_8632: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 4) que lee p14:8287; lo cargan sub-efecto 3 nota 4 (17
;   bytes)
;   0x8632..0x8643  (17 bytes)
DATA_tira_8632:
	defb 022h,004h,090h,055h,080h,055h,070h,055h,060h,055h,050h,055h,040h,055h,030h,055h	; 8632  "..U.UpU`UPU@U0U
	defb 0ffh	; 8642

; ----------------------------------------------------------------------
; DATOS tira_8643: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 5) que lee p14:8287; lo cargan sub-efecto 3 nota 5 (17
;   bytes)
;   0x8643..0x8654  (17 bytes)
DATA_tira_8643:
	defb 022h,002h,090h,02ah,080h,02ah,070h,02ah,060h,02ah,050h,02ah,040h,02ah,030h,02ah	; 8643  "..*.*p*`*P*@*0*
	defb 0ffh	; 8653

; ----------------------------------------------------------------------
; DATOS tira_8654: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 6) que lee p14:8287; lo cargan sub-efecto 3 nota 6 (17
;   bytes)
;   0x8654..0x8665  (17 bytes)
DATA_tira_8654:
	defb 022h,002h,090h,026h,080h,026h,070h,026h,060h,026h,050h,026h,040h,026h,030h,026h	; 8654  "..&.&p&`&P&@&0&
	defb 0ffh	; 8664

; ----------------------------------------------------------------------
; DATOS tira_8665: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 7) que lee p14:8287; lo cargan sub-efecto 3 nota 7 (17
;   bytes)
;   0x8665..0x8676  (17 bytes)
DATA_tira_8665:
	defb 022h,004h,090h,047h,080h,047h,070h,047h,060h,047h,050h,047h,040h,047h,030h,047h	; 8665  "..G.GpG`GPG@G0G
	defb 0ffh	; 8675

; ----------------------------------------------------------------------
; DATOS tira_8676: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 8) que lee p14:8287; lo cargan sub-efecto 3 nota 8 (17
;   bytes)
;   0x8676..0x8687  (17 bytes)
DATA_tira_8676:
	defb 022h,004h,090h,043h,080h,043h,070h,043h,060h,043h,050h,043h,040h,043h,030h,043h	; 8676  "..C.CpC`CPC@C0C
	defb 0ffh	; 8686

; ----------------------------------------------------------------------
; DATOS tira_8687: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 9) que lee p14:8287; lo cargan sub-efecto 3 nota 9 (17
;   bytes)
;   0x8687..0x8698  (17 bytes)
DATA_tira_8687:
	defb 022h,004h,090h,03ch,080h,03ch,070h,03ch,060h,03ch,050h,03ch,040h,03ch,030h,03ch	; 8687  "..<.<p<`<P<@<0<
	defb 0ffh	; 8697

; ----------------------------------------------------------------------
; DATOS tira_8698: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 10) que lee p14:8287; lo cargan sub-efecto 3 nota 10
;   (17 bytes)
;   0x8698..0x86a9  (17 bytes)
DATA_tira_8698:
	defb 022h,004h,090h,048h,080h,048h,070h,048h,060h,048h,050h,048h,040h,048h,030h,048h	; 8698  "..H.HpH`HPH@H0H
	defb 0ffh	; 86a8

; ----------------------------------------------------------------------
; DATOS tira_86A9: guion de musica de un sub-efecto (hasta un 0xFF)
;   (sub-efecto 3, nota 11) que lee p14:8287; lo cargan sub-efecto 3 nota 11
;   (17 bytes)
;   0x86a9..0x86ba  (17 bytes)
DATA_tira_86A9:
	defb 022h,004h,090h,01bh,080h,01bh,070h,01bh,060h,01bh,050h,01bh,040h,01bh,030h,01bh	; 86a9  ".....p.`.P.@.0.
	defb 0ffh	; 86b9

; ======================================================================
; CODIGO 0x86ba..0x873a  (128 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; PEDIR UN EFECTO. La segunda puerta del banco, la que llama p00:416C con el numero de efecto en A. No todos los efectos mandan lo mismo: hay una tabla de PRIORIDADES en 0xE051, y un efecto solo entra si el que esta sonando vale menos que el. Asi el ruido de un salto no se come a la musica del final.
; ----------------------------------------------------------------------
pide_un_efecto:
	cp 03ah		;86ba   ; el 0x3A es el que reinicia las voces
	jr nz,pide_un_efecto_elige_voz		;86bc
	ld hl,0e010h		;86be   ; la primera voz
	ld de,0e064h		;86c1   ; y la plantilla de voz callada
	call arranca_una_voz		;86c4
	ld a,c			;86c7
pide_un_efecto_elige_voz:
	ld c,a			;86c8   ; C se queda con el numero de efecto
	ld hl,0e012h		;86c9   ; la segunda voz
	ld b,001h		;86cc   ; y de momento, una sola
	ld a,c			;86ce
	cp 03bh		;86cf   ; por debajo de 0x3B son efectos cortos
	jr c,pide_un_efecto_corto		;86d1
	cp 0cbh		;86d3   ; el 0xCB gasta una voz mas
	jr nz,L_86D8		;86d5
	inc b			;86d7
L_86D8:
	inc b			;86d8   ; y los de arriba, tres
	inc b			;86d9
	cp 08ch		;86da   ; el 0x8C ademas borra la prioridad
	jr nz,arranca_el_efecto_en_la_voz		;86dc
	xor a			;86de
	ld (0e051h),a		;86df   ; la prioridad del efecto que suena
	ld a,c			;86e2
	jr arranca_el_efecto_en_la_voz		;86e3
pide_un_efecto_corto:
	ld a,c			;86e5
	cp 039h		;86e6   ; el 0x39 y el 0x3A entran siempre
	jr z,arranca_el_efecto_en_la_voz		;86e8
	cp 03ah		;86ea
	jr z,arranca_el_efecto_en_la_voz		;86ec
	ld l,051h		;86ee   ; la prioridad del que suena ahora
	ld a,(0e03ch)		;86f0   ; pero si el juego esta en cierto estado, no entra ninguno
	cp 07ah		;86f3
	ret nc			;86f5
	ld a,(hl)			;86f6   ; la prioridad de ahora
	ld e,a			;86f7
	ld a,c			;86f8
	cp 005h		;86f9   ; dos efectos se cuelan una posicion mas arriba
	jr nz,L_86FE		;86fb
	inc a			;86fd
L_86FE:
	cp 024h		;86fe
	jr nz,L_8703		;8700
	inc a			;8702
L_8703:
	cp e			;8703   ; y si el nuevo no gana, no entra
	ret c			;8704
	ld a,c			;8705
arranca_el_efecto_en_la_voz:
	ld de,08738h		;8706   ; la tabla de guiones de efecto, al final del banco
	add a,a			;8709   ; dos bytes por entrada, con el acarreo a mano
	jr nc,L_870D		;870a
	inc d			;870c
L_870D:
	add a,e			;870d   ; DE = 0x8738 + 2*efecto
	ld e,a			;870e
	jr nc,L_8712		;870f
	inc d			;8711
L_8712:
	dec l			;8712   ; dos bytes atras: al principio del campo
	dec l			;8713
arranca_el_efecto_bucle:
	ld (hl),001h		;8714   ; la voz, en marcha
	inc l			;8716   ; y de dos en dos por los campos
	inc l			;8717
	ld (hl),c			;8718   ; el numero de efecto queda apuntado en la voz
	inc l			;8719
	ld a,(de)			;871a   ; el guion, byte bajo...
	ld (hl),a			;871b
	inc l			;871c
	inc de			;871d
	ld a,(de)			;871e   ; ...y byte alto
	ld (hl),a			;871f
	ld a,007h		;8720   ; siete campos mas alla
	add a,l			;8722
	ld l,a			;8723
	xor a			;8724   ; a cero
	ld (hl),a			;8725
	ld a,003h		;8726   ; y tres mas
	add a,l			;8728
	ld l,a			;8729
	ld a,001h		;872a   ; la marca de que lo que suena es un efecto
	ld (hl),a			;872c
	inc l			;872d
	dec a			;872e   ; y las dos de al lado, a cero
	ld (hl),a			;872f
	inc l			;8730
	ld (hl),a			;8731
	ld a,005h		;8732
	add a,l			;8734
	ld l,a			;8735
	inc de			;8736
	djnz arranca_el_efecto_bucle		;8737
	ret			;8739

; ----------------------------------------------------------------------
; DATOS partituras_de_cada_sonido: 206 punteros, desde el sonido 1: p14:8706
;   hace DE = 0x8738 + 2*A y cada voz del sonido coge la palabra siguiente
;   (una voz por debajo de 0x3B, tres por encima y cuatro el 0xCB). La tabla
;   acaba donde empieza la primera partitura
;   0x873a..0x88d6  (412 bytes)
DATA_partituras_de_cada_sonido:
	defb 01ah,08bh	; 873a
	defb 060h,08bh	; 873c
	defb 028h,092h	; 873e
	defb 0bah,094h	; 8740
	defb 045h,092h	; 8742
	defb 0edh,094h	; 8744
	defb 0afh,092h	; 8746
	defb 0cah,092h	; 8748
	defb 0d5h,092h	; 874a
	defb 0e0h,092h	; 874c
	defb 016h,093h	; 874e
	defb 09ah,092h	; 8750
	defb 040h,08fh	; 8752
	defb 09bh,08eh	; 8754
	defb 0d7h,091h	; 8756
	defb 0e8h,091h	; 8758
	defb 04ah,08eh	; 875a
	defb 0ffh,08ch	; 875c
	defb 03eh,08dh	; 875e
	defb 07fh,08dh	; 8760
	defb 031h,093h	; 8762
	defb 077h,091h	; 8764
	defb 05ch,08dh	; 8766
	defb 025h,091h	; 8768
	defb 0a0h,094h	; 876a
	defb 02eh,091h	; 876c
	defb 089h,094h	; 876e
	defb 08eh,093h	; 8770
	defb 06ah,093h	; 8772
	defb 0a7h,08dh	; 8774
	defb 0b1h,08ch	; 8776
	defb 0f0h,08ch	; 8778
	defb 086h,08ch	; 877a
	defb 042h,095h	; 877c
	defb 0c7h,093h	; 877e
	defb 054h,094h	; 8780
	defb 04bh,094h	; 8782
	defb 01dh,08fh	; 8784
	defb 0e8h,08eh	; 8786
	defb 0d4h,093h	; 8788
	defb 04fh,08fh	; 878a
	defb 089h,08fh	; 878c
	defb 0a4h,08fh	; 878e
	defb 054h,090h	; 8790
	defb 031h,08bh	; 8792
	defb 050h,08bh	; 8794
	defb 05fh,090h	; 8796
	defb 002h,091h	; 8798
	defb 0b6h,091h	; 879a
	defb 0feh,0bfh	; 879c
	defb 0adh,08bh	; 879e
	defb 0bch,08bh	; 87a0
	defb 0cbh,08bh	; 87a2
	defb 0dah,08bh	; 87a4
	defb 023h,08eh	; 87a6
	defb 0e9h,08bh	; 87a8
	defb 0afh,094h	; 87aa
	defb 0b3h,095h	; 87ac
	defb 0c1h,095h	; 87ae
	defb 05dh,096h	; 87b0
	defb 02dh,097h	; 87b2
	defb 023h,098h	; 87b4
	defb 076h,099h	; 87b6
	defb 083h,09ah	; 87b8
	defb 069h,09bh	; 87ba
	defb 002h,09ch	; 87bc
	defb 0b3h,09ch	; 87be
	defb 0fdh,09ch	; 87c0
	defb 040h,09eh	; 87c2
	defb 011h,09fh	; 87c4
	defb 042h,0a0h	; 87c6
	defb 0d1h,0a0h	; 87c8
	defb 04dh,0a1h	; 87ca
	defb 08dh,0a1h	; 87cc
	defb 03bh,0a2h	; 87ce
	defb 01ah,0a3h	; 87d0
	defb 0a5h,0a3h	; 87d2
	defb 01bh,0a4h	; 87d4
	defb 084h,0a4h	; 87d6
	defb 0edh,0a4h	; 87d8
	defb 06ch,0a5h	; 87da
	defb 00eh,0a6h	; 87dc
	defb 073h,0a6h	; 87de
	defb 0fbh,0a6h	; 87e0
	defb 000h,0a8h	; 87e2
	defb 0d6h,0b5h	; 87e4
	defb 0fah,08ah	; 87e6
	defb 006h,08bh	; 87e8
	defb 0f2h,08fh	; 87ea
	defb 023h,090h	; 87ec
	defb 0feh,0bfh	; 87ee
	defb 0dah,0a8h	; 87f0
	defb 03eh,0a9h	; 87f2
	defb 0fbh,0a9h	; 87f4
	defb 043h,0aah	; 87f6
	defb 09ah,0aah	; 87f8
	defb 02dh,0abh	; 87fa
	defb 057h,0abh	; 87fc
	defb 09ah,0abh	; 87fe
	defb 0e8h,0abh	; 8800
	defb 061h,0abh	; 8802
	defb 0afh,0abh	; 8804
	defb 0eah,0abh	; 8806
	defb 04eh,0ach	; 8808
	defb 0dfh,0ach	; 880a
	defb 068h,0adh	; 880c
	defb 02ah,0aeh	; 880e
	defb 099h,0aeh	; 8810
	defb 0e3h,0aeh	; 8812
	defb 056h,0afh	; 8814
	defb 084h,0afh	; 8816
	defb 0b4h,0afh	; 8818
	defb 0c4h,0b0h	; 881a
	defb 0e8h,0b0h	; 881c
	defb 017h,0b1h	; 881e
	defb 06eh,0b0h	; 8820
	defb 08ah,0b0h	; 8822
	defb 0aah,0b0h	; 8824
	defb 033h,0b9h	; 8826
	defb 02fh,0b9h	; 8828
	defb 031h,0b9h	; 882a
	defb 030h,0b1h	; 882c
	defb 0edh,0b1h	; 882e
	defb 06dh,0b2h	; 8830
	defb 094h,08ah	; 8832
	defb 0a3h,08ah	; 8834
	defb 0c4h,08ah	; 8836
	defb 0cbh,08ah	; 8838
	defb 0d1h,08ah	; 883a
	defb 0feh,0bfh	; 883c
	defb 0cch,08dh	; 883e
	defb 0feh,0bfh	; 8840
	defb 0feh,0bfh	; 8842
	defb 070h,08ch	; 8844
	defb 0feh,0bfh	; 8846
	defb 0feh,0bfh	; 8848
	defb 0a6h,0b2h	; 884a
	defb 0c7h,0b2h	; 884c
	defb 0feh,0bfh	; 884e
	defb 006h,0b3h	; 8850
	defb 027h,0b3h	; 8852
	defb 0feh,0bfh	; 8854
	defb 040h,0b3h	; 8856
	defb 04dh,0b3h	; 8858
	defb 05ah,0b3h	; 885a
	defb 052h,0b5h	; 885c
	defb 069h,0b5h	; 885e
	defb 0feh,0bfh	; 8860
	defb 080h,0b5h	; 8862
	defb 0abh,0b5h	; 8864
	defb 0feh,0bfh	; 8866
	defb 0d6h,0b5h	; 8868
	defb 0feh,0bfh	; 886a
	defb 0feh,0bfh	; 886c
	defb 081h,0b3h	; 886e
	defb 0a4h,0b3h	; 8870
	defb 0c1h,0b3h	; 8872
	defb 0deh,0b3h	; 8874
	defb 001h,0b4h	; 8876
	defb 01eh,0b4h	; 8878
	defb 03bh,0b4h	; 887a
	defb 07ah,0b4h	; 887c
	defb 0b7h,0b4h	; 887e
	defb 0e0h,0b4h	; 8880
	defb 021h,0b5h	; 8882
	defb 0feh,0bfh	; 8884
	defb 07dh,08bh	; 8886
	defb 093h,08bh	; 8888
	defb 07bh,08bh	; 888a
	defb 03bh,0b4h	; 888c
	defb 07ah,0b4h	; 888e
	defb 0feh,0bfh	; 8890
	defb 004h,0b6h	; 8892
	defb 05bh,0b6h	; 8894
	defb 07bh,0b6h	; 8896
	defb 09eh,0b6h	; 8898
	defb 0efh,0b6h	; 889a
	defb 00ah,0b7h	; 889c
	defb 05bh,0b7h	; 889e
	defb 0a0h,0b7h	; 88a0
	defb 0ddh,0b7h	; 88a2
	defb 011h,0b8h	; 88a4
	defb 060h,0b8h	; 88a6
	defb 085h,0b8h	; 88a8
	defb 0bch,0b8h	; 88aa
	defb 001h,0b9h	; 88ac
	defb 011h,0b9h	; 88ae
	defb 0d6h,088h	; 88b0
	defb 049h,089h	; 88b2
	defb 0feh,089h	; 88b4
	defb 049h,0b9h	; 88b6
	defb 068h,0bah	; 88b8
	defb 0efh,0bah	; 88ba
	defb 00eh,0bch	; 88bc
	defb 042h,0bdh	; 88be
	defb 015h,0beh	; 88c0
	defb 044h,0bfh	; 88c2
	defb 051h,0bfh	; 88c4
	defb 05ch,0bfh	; 88c6
	defb 068h,0bfh	; 88c8
	defb 098h,0bfh	; 88ca
	defb 0cbh,0bfh	; 88cc
	defb 0feh,0bfh	; 88ce
	defb 0feh,0bfh	; 88d0
	defb 0feh,0bfh	; 88d2
	defb 0feh,0bfh	; 88d4

; ----------------------------------------------------------------------
; DATOS tira_88D6: partitura de sonido (voz del sonido 0xBC) que lee
;   pide_un_efecto; lo cargan 0x873A[187] (115 bytes)
;   0x88d6..0x8949  (115 bytes)
DATA_tira_88D6:
	defb 0efh,0dah,0f9h,012h,0e2h,0c0h,070h,0e1h,000h,030h,0fah,012h,072h,070h,050h,030h	; 88d6  ......p..0..rpP0
	defb 052h,0a2h,032h,030h,030h,030h,052h,022h,0f8h,012h,0e1h,030h,020h,000h,0e2h,0a0h	; 88e6  R.2000R"...0 ...
	defb 070h,0a0h,0feh,004h,0eeh,088h,0f9h,012h,0e1h,030h,020h,000h,0e2h,0a0h,070h,0a0h	; 88f6  p........0 ...p.
	defb 0feh,004h,0fch,088h,0e1h,072h,071h,0a0h,052h,020h,050h,0a0h,0e0h,032h,030h,020h	; 8906  .....rq.R P..20
	defb 000h,022h,0e1h,0a2h,0fah,012h,0e0h,002h,000h,0e1h,0a0h,080h,0a2h,070h,0a0h,0e0h	; 8916  ."...........p..
	defb 030h,050h,0e1h,0aah,0f9h,021h,0e0h,072h,070h,050h,030h,052h,0a2h,0dbh,032h,030h	; 8926  0P...!.rpP0R..20
	defb 030h,030h,052h,022h,004h,002h,003h,007h,0d4h,0eah,041h,071h,0ebh,0b0h,0b8h,0efh	; 8936  00R"......Aq....
	defb 0dbh,0c6h,0ffh	; 8946

; ----------------------------------------------------------------------
; DATOS tira_8949: partitura de sonido (voz del sonido 0xBD) que lee
;   pide_un_efecto; lo cargan 0x873A[188] (181 bytes)
;   0x8949..0x89fe  (181 bytes)
DATA_tira_8949:
	defb 0efh,0dah,0f9h,012h,0e2h,0c0h,030h,070h,0e1h,000h,0e2h,002h,000h,000h,000h,0e3h	; 8949  ......0p........
	defb 0a2h,0a2h,082h,080h,080h,080h,0a2h,072h,0e0h,001h,0e1h,070h,0e0h,033h,020h,000h	; 8959  .......r...p.3 .
	defb 0e1h,0a0h,070h,0a0h,070h,050h,030h,020h,0e2h,0a0h,0e1h,020h,0e0h,000h,0e1h,0a0h	; 8969  ..p.pP0 ... ....
	defb 080h,070h,050h,030h,0f8h,000h,0e1h,071h,080h,0d5h,0f8h,000h,070h,080h,0feh,00ah	; 8979  .pP0...q....p...
	defb 085h,089h,0f9h,000h,070h,080h,0feh,009h,08dh,089h,070h,050h,030h,020h,0dah,0ebh	; 8989  ....p.....pP0 ..
	defb 072h,071h,090h,003h,000h,090h,0eah,032h,030h,020h,000h,022h,0ebh,092h,0efh,0d5h	; 8999  rq.....20 ."....
	defb 0f7h,000h,0e1h,000h,0e2h,030h,080h,0e1h,000h,030h,000h,0feh,002h,0ach,089h,0f8h	; 89a9  .....0...0......
	defb 010h,0e2h,0a0h,030h,070h,0a0h,0e1h,030h,0e2h,0a0h,0d6h,030h,070h,0d7h,0a0h,0e1h	; 89b9  ...0p..0...0p...
	defb 030h,0d8h,0e2h,0a0h,0d6h,0e2h,050h,0dah,0a0h,0e1h,030h,050h,030h,0e2h,0a0h,050h	; 89c9  0.....P...0P0..P
	defb 0a0h,0e1h,020h,050h,020h,0e2h,0a0h,0f9h,012h,0e2h,002h,000h,000h,000h,0e3h,0a2h	; 89d9  .. P ...........
	defb 0a2h,0dbh,082h,080h,080h,080h,0a2h,072h,054h,042h,023h,048h,0d2h,0c0h,0d4h,0eah	; 89e9  .......rTB#H....
	defb 040h,070h,0ebh,0b8h,0ffh	; 89f9

; ----------------------------------------------------------------------
; DATOS tira_89FE: partitura de sonido (voz del sonido 0xBE) que lee
;   pide_un_efecto; lo cargan 0x873A[189] (150 bytes)
;   0x89fe..0x8a94  (150 bytes)
DATA_tira_89FE:
	defb 0efh,0dah,0fah,023h,0e3h,0c0h,000h,000h,000h,0fbh,023h,032h,030h,030h,030h,052h	; 89fe  ...#......#2000R
	defb 022h,032h,030h,030h,030h,052h,022h,001h,000h,001h,000h,021h,020h,021h,020h,031h	; 8a0e  "2000R"....! ! 1
	defb 030h,031h,030h,051h,050h,051h,050h,001h,000h,000h,000h,000h,021h,020h,020h,020h	; 8a1e  010QPQP.....!
	defb 020h,030h,030h,030h,030h,030h,030h,051h,050h,050h,050h,050h,0fah,012h,0e3h,071h	; 8a2e   000000QPPPP...q
	defb 0c0h,071h,0c0h,0a1h,0c0h,051h,0c0h,031h,0c0h,031h,0c0h,051h,0c0h,0a1h,0c0h,0fah	; 8a3e  .q...Q.1.1.Q....
	defb 012h,0e3h,080h,0e2h,000h,0f9h,011h,030h,0feh,002h,04dh,08ah,0fah,012h,0e3h,070h	; 8a4e  .......0..M....p
	defb 0a0h,0f9h,011h,0e2h,030h,0feh,002h,05ah,08ah,0fah,012h,0e3h,050h,0a0h,0f9h,011h	; 8a5e  ....0..Z....P...
	defb 0e2h,030h,0feh,002h,067h,08ah,0fah,012h,0e3h,050h,0a0h,0f9h,011h,0e2h,020h,0feh	; 8a6e  .0..g....P.... .
	defb 002h,074h,08ah,0fbh,023h,0e3h,032h,030h,030h,030h,052h,022h,0dbh,032h,030h,030h	; 8a7e  .t..#.2000R".200
	defb 030h,052h,022h,00bh,009h,0ffh	; 8a8e

; ----------------------------------------------------------------------
; DATOS tira_8A94: partitura de sonido (voz del sonido 0x7D) que lee
;   pide_un_efecto; lo cargan 0x873A[124] (15 bytes)
;   0x8a94..0x8aa3  (15 bytes)
DATA_tira_8A94:
	defb 0feh,000h,020h,005h,022h,001h,070h,040h,020h,005h,022h,001h,080h,030h,0ffh	; 8a94  .. .".p@ ."..0.

; ----------------------------------------------------------------------
; DATOS tira_8AA3: partitura de sonido (voz del sonido 0x7E) que lee
;   pide_un_efecto; lo cargan 0x873A[125] (33 bytes)
;   0x8aa3..0x8ac4  (33 bytes)
DATA_tira_8AA3:
	defb 0feh,000h,022h,001h,060h,030h,060h,02fh,060h,02eh,060h,02dh,060h,02ch,060h,02bh	; 8aa3  ..".`0`/`.`-`,`+
	defb 060h,02ah,060h,029h,060h,028h,040h,02ch,040h,02bh,040h,02ah,040h,029h,040h,028h	; 8ab3  `*`)`(@,@+@*@)@(
	defb 0ffh	; 8ac3

; ----------------------------------------------------------------------
; DATOS tira_8AC4: partitura de sonido (voz del sonido 0x7F; voz del sonido
;   0x80; voz del sonido 0x81) que lee pide_un_efecto; se entra por 0x8AC4,
;   0x8ACB, 0x8AD1; lo cargan 0x873A[126], 0x873A[127], 0x873A[128] (54 bytes)
;   0x8ac4..0x8afa  (54 bytes)
DATA_tira_8AC4:
	defb 0efh,0d1h,0c0h,0feh,002h,040h,08fh,0d8h,0c0h,0feh,002h,0b7h,0b4h,0feh,000h,020h	; 8ac4  .....@.........
	defb 01dh,022h,002h,070h,018h,070h,019h,070h,01ah,070h,01bh,070h,01ch,070h,01dh,070h	; 8ad4  .".p.p.p.p.p.p.p
	defb 01eh,070h,02ch,070h,02bh,022h,003h,070h,02ah,070h,029h,070h,028h,022h,001h,070h	; 8ae4  .p,p+".p*p)p(".p
	defb 027h,070h,026h,070h,025h,0ffh	; 8af4

; ----------------------------------------------------------------------
; DATOS tira_8AFA: partitura de sonido (voz del sonido 0x01; voz del sonido
;   0x57; voz del sonido 0x58) que lee pide_un_efecto; se entra por 0x8AFA,
;   0x8B06, 0x8B1A; lo cargan 0x873A[0], 0x873A[86], 0x873A[87] (55 bytes)
;   0x8afa..0x8b31  (55 bytes)
DATA_tira_8AFA:
	defb 0feh,000h,022h,015h,090h,022h,020h,02ah,0feh,0feh,0fch,08ah,0feh,000h,022h,007h	; 8afa  ..".." *......".
	defb 090h,0a0h,000h,000h,070h,0a0h,000h,000h,050h,0a0h,020h,013h,0feh,0feh,008h,08bh	; 8b0a  ....p...P. .....
	defb 0feh,000h,021h,001h,012h,080h,000h,0a0h,000h,070h,000h,090h,000h,016h,070h,000h	; 8b1a  ..!......p....p.
	defb 090h,000h,060h,000h,080h,000h,0ffh	; 8b2a

; ----------------------------------------------------------------------
; DATOS tira_8B31: partitura de sonido (voz del sonido 0x2D) que lee
;   pide_un_efecto; lo cargan 0x873A[44] (31 bytes)
;   0x8b31..0x8b50  (31 bytes)
DATA_tira_8B31:
	defb 0feh,000h,022h,001h,0b0h,020h,0c0h,021h,0a0h,020h,0b0h,021h,0c0h,060h,0b0h,030h	; 8b31  ..".. .!. .!.`.0
	defb 0a0h,062h,080h,031h,090h,060h,070h,030h,080h,062h,060h,031h,070h,02fh,0ffh	; 8b41  .b.1.`p0.b`1p/.

; ----------------------------------------------------------------------
; DATOS tira_8B50: partitura de sonido (voz del sonido 0x02; voz del sonido
;   0x2E) que lee pide_un_efecto; se entra por 0x8B50, 0x8B60; lo cargan
;   0x873A[1], 0x873A[45] (43 bytes)
;   0x8b50..0x8b7b  (43 bytes)
DATA_tira_8B50:
	defb 0feh,000h,022h,001h,0a0h,060h,0a0h,03ah,0a0h,02ch,0a0h,065h,0feh,002h,03bh,08bh	; 8b50  .."..`.:.,.e..;.
	defb 0feh,000h,021h,001h,010h,0b0h,000h,015h,0a0h,000h,019h,080h,000h,020h,001h,021h	; 8b60  ..!.......... .!
	defb 001h,013h,0a0h,000h,019h,080h,000h,01fh,060h,000h,0ffh	; 8b70  ........`..

; ----------------------------------------------------------------------
; DATOS tira_8B7B: partitura de sonido (voz del sonido 0xA7; voz del sonido
;   0xA9) que lee pide_un_efecto; se entra por 0x8B7B, 0x8B7D; lo cargan
;   0x873A[166], 0x873A[168] (24 bytes)
;   0x8b7b..0x8b93  (24 bytes)
DATA_tira_8B7B:
	defb 0dah,0c0h,0d8h,0eah,043h,073h,095h,073h,043h,021h,005h,013h,003h,021h,095h,073h	; 8b7b  ....Cs.sC!...!.s
	defb 041h,073h,010h,000h,040h,091h,095h,0ffh	; 8b8b  As..@...

; ----------------------------------------------------------------------
; DATOS tira_8B93: partitura de sonido (voz del sonido 0xA8) que lee
;   pide_un_efecto; lo cargan 0x873A[167] (26 bytes)
;   0x8b93..0x8bad  (26 bytes)
DATA_tira_8B93:
	defb 0d8h,0c7h,0ebh,001h,001h,0eah,001h,0c3h,0ebh,0a3h,045h,005h,003h,0a1h,0efh,0d2h	; 8b93  ..........E.....
	defb 0c0h,0d8h,0eah,005h,0c3h,0ebh,0a1h,0eah,0c3h,0ffh	; 8ba3  ..........

; ----------------------------------------------------------------------
; DATOS tira_8BAD: partitura de sonido (voz del sonido 0x33) que lee
;   pide_un_efecto; lo cargan 0x873A[50] (15 bytes)
;   0x8bad..0x8bbc  (15 bytes)
DATA_tira_8BAD:
	defb 0feh,000h,022h,001h,0a0h,030h,0b0h,034h,0b0h,038h,0b0h,03bh,0a0h,040h,0ffh	; 8bad  .."..0.4.8.;.@.

; ----------------------------------------------------------------------
; DATOS tira_8BBC: partitura de sonido (voz del sonido 0x34) que lee
;   pide_un_efecto; lo cargan 0x873A[51] (15 bytes)
;   0x8bbc..0x8bcb  (15 bytes)
DATA_tira_8BBC:
	defb 0feh,000h,022h,001h,0a0h,04ah,0b0h,047h,0b0h,045h,0b0h,040h,0a0h,03eh,0ffh	; 8bbc  .."..J.G.E.@.>.

; ----------------------------------------------------------------------
; DATOS tira_8BCB: partitura de sonido (voz del sonido 0x35) que lee
;   pide_un_efecto; lo cargan 0x873A[52] (15 bytes)
;   0x8bcb..0x8bda  (15 bytes)
DATA_tira_8BCB:
	defb 0feh,000h,022h,001h,0a0h,05ah,0b0h,055h,0b0h,050h,0b0h,04ah,0a0h,045h,0ffh	; 8bcb  .."..Z.U.P.J.E.

; ----------------------------------------------------------------------
; DATOS tira_8BDA: partitura de sonido (voz del sonido 0x36) que lee
;   pide_un_efecto; lo cargan 0x873A[53] (15 bytes)
;   0x8bda..0x8be9  (15 bytes)
DATA_tira_8BDA:
	defb 0feh,000h,022h,001h,0a0h,020h,0b0h,022h,0b0h,025h,0b0h,028h,0a0h,02ch,0ffh	; 8bda  ..".. .".%.(.,.

; ----------------------------------------------------------------------
; DATOS tira_8BE9: partitura de sonido (voz del sonido 0x38) que lee
;   pide_un_efecto; lo cargan 0x873A[55] (135 bytes)
;   0x8be9..0x8c70  (135 bytes)
DATA_tira_8BE9:
	defb 0feh,000h,022h,001h,0e0h,056h,0d0h,055h,0c0h,056h,0b0h,056h,0a0h,056h,0e0h,06eh	; 8be9  .."..V.U.V.V.V.n
	defb 0d0h,06dh,0c0h,06eh,0d0h,06fh,0a0h,070h,0e0h,049h,0d0h,048h,0c0h,049h,0b0h,049h	; 8bf9  .m.n.o.p.I.H.I.I
	defb 080h,049h,060h,049h,040h,049h,020h,004h,022h,001h,0b0h,058h,0a0h,057h,090h,058h	; 8c09  .I`I@I ."..X.W.X
	defb 090h,057h,080h,058h,0b0h,070h,0a0h,06fh,0b0h,070h,0b0h,071h,0b0h,072h,0a0h,04bh	; 8c19  .W.X.p.o.p.q.r.K
	defb 090h,04bh,080h,04bh,070h,04bh,050h,04bh,020h,006h,022h,001h,090h,059h,090h,05ah	; 8c29  .K.KpKPK ."..Y.Z
	defb 090h,059h,090h,05ah,090h,05bh,090h,072h,090h,073h,090h,074h,090h,073h,070h,04eh	; 8c39  .Y.Z.[.r.s.t.spN
	defb 060h,04eh,050h,04eh,040h,04eh,030h,04eh,020h,007h,022h,001h,070h,05dh,070h,05eh	; 8c49  `NPN@N0N .".p]p^
	defb 070h,05dh,070h,05eh,070h,05dh,070h,05eh,060h,077h,060h,076h,060h,077h,070h,053h	; 8c59  p]p^p]p^`w`v`wpS
	defb 060h,054h,050h,033h,050h,054h,0ffh	; 8c69

; ----------------------------------------------------------------------
; DATOS tira_8C70: partitura de sonido (voz del sonido 0x21; voz del sonido
;   0x86) que lee pide_un_efecto; se entra por 0x8C70, 0x8C86; lo cargan
;   0x873A[133], 0x873A[32] (65 bytes)
;   0x8c70..0x8cb1  (65 bytes)
DATA_tira_8C70:
	defb 0feh,000h,022h,001h,0a0h,02ch,0a0h,040h,020h,005h,022h,001h,090h,040h,080h,050h	; 8c70  .."..,.@ ."..@.P
	defb 020h,006h,0feh,0feh,072h,08ch,0feh,000h,021h,002h,01ah,0c0h,000h,020h,003h,023h	; 8c80   ...r...!.... .#
	defb 003h,017h,0c0h,022h,0a0h,021h,0c0h,022h,020h,003h,023h,002h,0a0h,022h,020h,004h	; 8c90  ...".!." .#.." .
	defb 023h,002h,080h,022h,020h,005h,023h,002h,060h,022h,020h,006h,023h,002h,050h,022h	; 8ca0  #.." .#.`" .#.P"
	defb 0ffh	; 8cb0

; ----------------------------------------------------------------------
; DATOS tira_8CB1: partitura de sonido (voz del sonido 0x1F) que lee
;   pide_un_efecto; lo cargan 0x873A[30] (63 bytes)
;   0x8cb1..0x8cf0  (63 bytes)
DATA_tira_8CB1:
	defb 0feh,000h,022h,001h,0c0h,040h,0c0h,041h,0c0h,042h,0c0h,043h,0c0h,044h,0c0h,045h	; 8cb1  .."..@.A.B.C.D.E
	defb 0c0h,046h,0c0h,047h,0c0h,048h,0c0h,049h,0c0h,04ah,0c0h,04bh,0c0h,04ch,0c0h,04dh	; 8cc1  .F.G.H.I.J.K.L.M
	defb 0c0h,04eh,0c0h,04fh,0c0h,050h,0c0h,051h,0c0h,052h,0c0h,053h,0b0h,054h,0b0h,055h	; 8cd1  .N.O.P.Q.R.S.T.U
	defb 0a0h,056h,090h,057h,080h,058h,070h,059h,060h,05ah,050h,05bh,040h,05ch,0ffh	; 8ce1  .V.W.XpY`ZP[@\.

; ----------------------------------------------------------------------
; DATOS tira_8CF0: partitura de sonido (voz del sonido 0x20) que lee
;   pide_un_efecto; lo cargan 0x873A[31] (15 bytes)
;   0x8cf0..0x8cff  (15 bytes)
DATA_tira_8CF0:
	defb 0feh,000h,023h,001h,010h,0d3h,000h,020h,003h,023h,001h,014h,0e2h,000h,0ffh	; 8cf0  ..#.... .#.....

; ----------------------------------------------------------------------
; DATOS tira_8CFF: partitura de sonido (voz del sonido 0x12) que lee
;   pide_un_efecto; lo cargan 0x873A[17] (63 bytes)
;   0x8cff..0x8d3e  (63 bytes)
DATA_tira_8CFF:
	defb 0feh,000h,022h,001h,0d0h,0a0h,080h,0f0h,0b0h,0a0h,080h,0f4h,0b0h,0a0h,080h,0f8h	; 8cff  ..".............
	defb 0b0h,0a0h,0c0h,080h,0c0h,087h,0c0h,080h,0c0h,087h,0c0h,084h,0c0h,08bh,0c0h,085h	; 8d0f  ................
	defb 0c0h,08bh,0c0h,088h,0c0h,090h,0c0h,088h,0c0h,090h,0c0h,08bh,0c0h,093h,0c0h,08bh	; 8d1f  ................
	defb 0c0h,093h,0c0h,08fh,0c0h,097h,0c0h,08fh,0c0h,097h,0c0h,093h,0c0h,09ch,0ffh	; 8d2f  ...............

; ----------------------------------------------------------------------
; DATOS tira_8D3E: partitura de sonido (voz del sonido 0x13) que lee
;   pide_un_efecto; lo cargan 0x873A[18] (30 bytes)
;   0x8d3e..0x8d5c  (30 bytes)
DATA_tira_8D3E:
	defb 0feh,000h,023h,001h,014h,0f9h,000h,0ech,000h,0d8h,000h,0dah,000h,0cbh,000h,0cdh	; 8d3e  ..#.............
	defb 000h,0d7h,000h,0d4h,000h,0d1h,000h,0e2h,000h,0f1h,000h,0f1h,0a0h,0ffh	; 8d4e  ..............

; ----------------------------------------------------------------------
; DATOS tira_8D5C: partitura de sonido (voz del sonido 0x17) que lee
;   pide_un_efecto; lo cargan 0x873A[22] (35 bytes)
;   0x8d5c..0x8d7f  (35 bytes)
DATA_tira_8D5C:
	defb 0feh,000h,022h,001h,0d0h,04ah,0d0h,03ah,020h,001h,022h,001h,0d0h,04ah,0d0h,03dh	; 8d5c  .."..J.: ."..J.=
	defb 0d0h,030h,020h,002h,022h,001h,0d0h,040h,0d0h,046h,0d0h,04ch,0d0h,054h,0d0h,060h	; 8d6c  .0 ."..@.F.L.T.`
	defb 0d0h,06ah,0ffh	; 8d7c

; ----------------------------------------------------------------------
; DATOS tira_8D7F: partitura de sonido (voz del sonido 0x14) que lee
;   pide_un_efecto; lo cargan 0x873A[19] (40 bytes)
;   0x8d7f..0x8da7  (40 bytes)
DATA_tira_8D7F:
	defb 0feh,000h,023h,002h,018h,0a3h,008h,01dh,0b1h,0fah,01eh,0b2h,0dah,01ch,0e1h,070h	; 8d7f  ..#............p
	defb 01fh,0d2h,0d7h,0d1h,0a0h,0e1h,090h,0f2h,040h,0c1h,067h,0b2h,010h,0a2h,03ah,023h	; 8d8f  ........@.g...:#
	defb 005h,091h,0c0h,082h,04ah,073h,03ah,0ffh	; 8d9f  ....Js:.

; ----------------------------------------------------------------------
; DATOS tira_8DA7: partitura de sonido (voz del sonido 0x1E) que lee
;   pide_un_efecto; lo cargan 0x873A[29] (37 bytes)
;   0x8da7..0x8dcc  (37 bytes)
DATA_tira_8DA7:
	defb 0feh,000h,022h,002h,0f6h,000h,0e5h,000h,0e4h,000h,0d3h,000h,0d2h,000h,0c1h,000h	; 8da7  ..".............
	defb 0c1h,010h,020h,001h,022h,002h,0b6h,000h,0a5h,000h,0a4h,000h,093h,000h,092h,000h	; 8db7  .. ."...........
	defb 081h,000h,091h,010h,0ffh	; 8dc7

; ----------------------------------------------------------------------
; DATOS tira_8DCC: partitura de sonido (voz del sonido 0x83) que lee
;   pide_un_efecto; lo cargan 0x873A[130] (87 bytes)
;   0x8dcc..0x8e23  (87 bytes)
DATA_tira_8DCC:
	defb 0feh,000h,022h,001h,0c0h,06ah,0d0h,0d4h,0c0h,06bh,0d0h,0d6h,0feh,003h,0d0h,08dh	; 8dcc  .."..j...k......
	defb 0d0h,0f0h,0d1h,0e0h,0d1h,000h,0d2h,000h,0d1h,010h,0d2h,020h,0d1h,020h,0d2h,040h	; 8ddc  ........... . .@
	defb 0d1h,030h,0d2h,060h,0d1h,040h,0d2h,080h,0d1h,050h,0d2h,0a0h,0d1h,060h,0d2h,0c0h	; 8dec  .0.`.@...P...`..
	defb 0d1h,070h,0d2h,0e0h,0d3h,080h,0d7h,000h,0d3h,04eh,0d6h,09ch,0d3h,04eh,0d6h,09ch	; 8dfc  .p.......N...N..
	defb 0d3h,080h,0d7h,000h,0feh,003h,008h,08eh,0d3h,030h,0d6h,060h,0d3h,013h,0d3h,010h	; 8e0c  .........0.`....
	defb 0d6h,020h,0d3h,079h,0d6h,000h,0ffh	; 8e1c

; ----------------------------------------------------------------------
; DATOS tira_8E23: partitura de sonido (voz del sonido 0x37) que lee
;   pide_un_efecto; lo cargan 0x873A[54] (39 bytes)
;   0x8e23..0x8e4a  (39 bytes)
DATA_tira_8E23:
	defb 0feh,000h,022h,001h,0e0h,056h,0d0h,055h,0c0h,056h,0b0h,056h,0a0h,056h,0e0h,06eh	; 8e23  .."..V.U.V.V.V.n
	defb 0d0h,06dh,0c0h,06eh,0d0h,06dh,0a0h,06eh,0e0h,049h,0d0h,048h,0c0h,049h,0b0h,049h	; 8e33  .m.n.m.n.I.H.I.I
	defb 080h,049h,060h,049h,040h,049h,0ffh	; 8e43

; ----------------------------------------------------------------------
; DATOS tira_8E4A: partitura de sonido (voz del sonido 0x11) que lee
;   pide_un_efecto; lo cargan 0x873A[16] (81 bytes)
;   0x8e4a..0x8e9b  (81 bytes)
DATA_tira_8E4A:
	defb 0feh,000h,023h,002h,010h,0b0h,000h,01fh,0e0h,000h,015h,0a0h,000h,01ah,080h,000h	; 8e4a  ..#.............
	defb 021h,001h,010h,0e0h,000h,013h,0d0h,000h,022h,001h,0e0h,085h,0c0h,07ah,023h,001h	; 8e5a  !......."....z#.
	defb 010h,0a0h,075h,011h,080h,070h,021h,003h,010h,090h,000h,021h,001h,011h,090h,000h	; 8e6a  ..u..p!....!....
	defb 012h,090h,000h,013h,090h,000h,014h,080h,000h,015h,080h,000h,016h,070h,000h,017h	; 8e7a  .............p..
	defb 070h,000h,019h,060h,000h,01bh,060h,000h,01dh,050h,000h,021h,007h,01fh,050h,000h	; 8e8a  p..`..`..P.!..P.
	defb 0ffh	; 8e9a

; ----------------------------------------------------------------------
; DATOS tira_8E9B: partitura de sonido (voz del sonido 0x0E) que lee
;   pide_un_efecto; lo cargan 0x873A[13] (77 bytes)
;   0x8e9b..0x8ee8  (77 bytes)
DATA_tira_8E9B:
	defb 0feh,000h,022h,001h,0c0h,0e2h,0d0h,0beh,0c0h,0aah,0b0h,099h,0c0h,088h,0b0h,077h	; 8e9b  .."............w
	defb 0a0h,066h,090h,055h,020h,005h,022h,001h,0a0h,0e5h,0b0h,0c1h,0a0h,0adh,090h,09ch	; 8eab  .f.U .".........
	defb 0a0h,08bh,090h,07ah,080h,069h,070h,058h,020h,005h,022h,001h,080h,0e9h,090h,0c5h	; 8ebb  ...z.ipX .".....
	defb 080h,0b1h,070h,0a0h,080h,08fh,070h,07eh,060h,06dh,050h,05ch,020h,005h,022h,001h	; 8ecb  ..p...p~`mP\ .".
	defb 060h,0eeh,070h,0cah,060h,0b6h,050h,0a5h,060h,094h,050h,083h,0ffh	; 8edb  `.p.`.P.`.P..

; ----------------------------------------------------------------------
; DATOS tira_8EE8: partitura de sonido (voz del sonido 0x27) que lee
;   pide_un_efecto; lo cargan 0x873A[38] (53 bytes)
;   0x8ee8..0x8f1d  (53 bytes)
DATA_tira_8EE8:
	defb 0feh,000h,022h,001h,0c0h,080h,0c0h,071h,0c0h,05fh,0c0h,040h,0feh,003h,0ech,08eh	; 8ee8  .."....q._.@....
	defb 020h,003h,022h,001h,090h,080h,090h,071h,090h,05fh,090h,040h,020h,004h,022h,001h	; 8ef8   ."....q._.@ .".
	defb 060h,080h,060h,071h,060h,05fh,060h,040h,020h,005h,022h,001h,040h,080h,040h,071h	; 8f08  `.`q`_`@ .".@.@q
	defb 040h,05fh,040h,040h,0ffh	; 8f18

; ----------------------------------------------------------------------
; DATOS tira_8F1D: partitura de sonido (voz del sonido 0x26) que lee
;   pide_un_efecto; lo cargan 0x873A[37] (35 bytes)
;   0x8f1d..0x8f40  (35 bytes)
DATA_tira_8F1D:
	defb 0feh,000h,022h,002h,0d0h,0c0h,0b0h,030h,0d0h,080h,0d0h,040h,0b0h,030h,0d0h,020h	; 8f1d  .."....0...@.0.
	defb 022h,002h,0d0h,060h,0c0h,030h,0b0h,060h,0a0h,030h,090h,060h,080h,030h,070h,060h	; 8f2d  "..`.0.`.0.`.0p`
	defb 060h,030h,0ffh	; 8f3d

; ----------------------------------------------------------------------
; DATOS tira_8F40: partitura de sonido (voz del sonido 0x0D) que lee
;   pide_un_efecto; lo cargan 0x873A[12] (15 bytes)
;   0x8f40..0x8f4f  (15 bytes)
DATA_tira_8F40:
	defb 0feh,000h,02ah,006h,000h,070h,090h,040h,02ah,006h,000h,0a0h,090h,030h,0ffh	; 8f40  ..*..p.@*....0.

; ----------------------------------------------------------------------
; DATOS tira_8F4F: partitura de sonido (voz del sonido 0x29) que lee
;   pide_un_efecto; lo cargan 0x873A[40] (58 bytes)
;   0x8f4f..0x8f89  (58 bytes)
DATA_tira_8F4F:
	defb 0feh,000h,023h,001h,015h,0e1h,053h,0e0h,0fdh,0e2h,0a7h,0e1h,0fch,000h,000h,000h	; 8f4f  ..#...S.........
	defb 000h,0f0h,020h,0e0h,020h,0d0h,020h,0c0h,020h,0b0h,020h,0a0h,020h,090h,020h,080h	; 8f5f  .. . . . . . . .
	defb 020h,022h,001h,0a0h,040h,0a0h,036h,0a0h,040h,0a0h,030h,0a0h,040h,0a0h,028h,0a0h	; 8f6f   "..@.6.@.0.@.(.
	defb 040h,0a0h,023h,0a0h,040h,0feh,0feh,070h,08fh,0ffh	; 8f7f  @.#.@..p..

; ----------------------------------------------------------------------
; DATOS tira_8F89: partitura de sonido (voz del sonido 0x2A; voz del sonido
;   0x2B) que lee pide_un_efecto; se entra por 0x8F89, 0x8FA4; lo cargan
;   0x873A[41], 0x873A[42] (105 bytes)
;   0x8f89..0x8ff2  (105 bytes)
DATA_tira_8F89:
	defb 0feh,000h,023h,001h,015h,0f0h,0fdh,0d0h,0beh,0e1h,0ach,0c3h,000h,0d0h,040h,0c0h	; 8f89  ..#...........@.
	defb 020h,0b0h,040h,0a0h,020h,090h,040h,0feh,002h,070h,08fh,0feh,000h,023h,001h,015h	; 8f99   .@. .@..p...#..
	defb 0f0h,0fdh,0d0h,0beh,0e1h,0ach,0c3h,000h,0d0h,040h,0c0h,020h,0b0h,040h,0a0h,020h	; 8fa9  .........@. .@.
	defb 090h,040h,000h,000h,000h,000h,080h,020h,070h,040h,000h,000h,000h,000h,060h,020h	; 8fb9  .@..... p@....`
	defb 050h,040h,020h,019h,023h,001h,01ah,0f3h,050h,0c0h,020h,01fh,0b0h,040h,0a0h,020h	; 8fc9  P@ .#...P. ..@.
	defb 090h,021h,080h,023h,020h,00ah,023h,001h,01ah,0f3h,050h,0c0h,080h,01fh,0b0h,020h	; 8fd9  .!.# .#...P....
	defb 0a0h,040h,090h,020h,080h,021h,070h,023h,0ffh	; 8fe9  .@. .!p#.

; ----------------------------------------------------------------------
; DATOS tira_8FF2: partitura de sonido (voz del sonido 0x59) que lee
;   pide_un_efecto; lo cargan 0x873A[88] (49 bytes)
;   0x8ff2..0x9023  (49 bytes)
DATA_tira_8FF2:
	defb 0feh,000h,022h,001h,0d0h,0a0h,0d0h,098h,0d0h,090h,0d0h,088h,0d0h,080h,0d0h,078h	; 8ff2  .."............x
	defb 0d0h,070h,022h,003h,0e0h,040h,0d0h,080h,0d0h,040h,0a0h,080h,0c0h,040h,090h,080h	; 9002  .p"..@...@...@..
	defb 0b0h,040h,080h,080h,0a0h,040h,070h,080h,090h,040h,060h,080h,080h,040h,050h,080h	; 9012  .@...@p..@`..@P.
	defb 0ffh	; 9022

; ----------------------------------------------------------------------
; DATOS tira_9023: partitura de sonido (voz del sonido 0x5A) que lee
;   pide_un_efecto; lo cargan 0x873A[89] (49 bytes)
;   0x9023..0x9054  (49 bytes)
DATA_tira_9023:
	defb 0feh,000h,022h,001h,0d0h,050h,0d0h,04ch,0d0h,048h,0d0h,044h,0d0h,040h,0d0h,03ch	; 9023  .."..P.L.H.D.@.<
	defb 0d0h,038h,022h,003h,0e0h,020h,0b0h,040h,0d0h,020h,0a0h,040h,0c0h,020h,090h,040h	; 9033  .8".. .@. .@. .@
	defb 0b0h,020h,080h,040h,0a0h,020h,070h,040h,090h,020h,060h,040h,080h,020h,050h,040h	; 9043  . .@. p@. `@. P@
	defb 0ffh	; 9053

; ----------------------------------------------------------------------
; DATOS tira_9054: partitura de sonido (voz del sonido 0x2C) que lee
;   pide_un_efecto; lo cargan 0x873A[43] (11 bytes)
;   0x9054..0x905f  (11 bytes)
DATA_tira_9054:
	defb 0feh,000h,022h,001h,0c0h,078h,0b0h,058h,0a0h,048h,0ffh	; 9054  .."..x.X.H.

; ----------------------------------------------------------------------
; DATOS tira_905F: partitura de sonido (voz del sonido 0x2F) que lee
;   pide_un_efecto; lo cargan 0x873A[46] (163 bytes)
;   0x905f..0x9102  (163 bytes)
DATA_tira_905F:
	defb 0feh,000h,022h,001h,0b5h,000h,0b4h,080h,0b4h,000h,0b3h,080h,0b3h,000h,0b2h,080h	; 905f  ..".............
	defb 0b2h,000h,0b1h,0a0h,0b8h,000h,0b7h,000h,0b6h,000h,0b5h,080h,0b5h,000h,0b4h,080h	; 906f  ................
	defb 0b4h,000h,0b3h,080h,0b3h,000h,0bch,000h,0bbh,000h,0bah,000h,0b9h,000h,0b8h,000h	; 907f  ................
	defb 0b7h,000h,0b6h,000h,0b5h,080h,0b5h,000h,0b4h,080h,0b4h,000h,0b3h,080h,0b3h,000h	; 908f  ................
	defb 0b6h,000h,0b5h,080h,0b5h,000h,0b4h,080h,0b4h,000h,0b3h,080h,0b3h,000h,0b2h,080h	; 909f  ................
	defb 0b9h,000h,0b8h,000h,0b7h,000h,0b6h,000h,0b5h,080h,0b5h,000h,0a4h,080h,0a4h,000h	; 90af  ................
	defb 0a3h,080h,0a3h,000h,0a2h,080h,0a2h,000h,0ach,000h,0aah,000h,0aah,000h,0a9h,000h	; 90bf  ................
	defb 098h,000h,097h,000h,096h,000h,095h,080h,095h,000h,094h,080h,094h,000h,093h,080h	; 90cf  ................
	defb 093h,000h,098h,000h,087h,000h,086h,000h,085h,080h,085h,000h,084h,080h,084h,000h	; 90df  ................
	defb 083h,080h,083h,000h,082h,080h,082h,000h,071h,0a0h,077h,000h,077h,000h,076h,000h	; 90ef  ........q.w.w.v.
	defb 075h,070h,0ffh	; 90ff

; ----------------------------------------------------------------------
; DATOS tira_9102: partitura de sonido (voz del sonido 0x30) que lee
;   pide_un_efecto; lo cargan 0x873A[47] (35 bytes)
;   0x9102..0x9125  (35 bytes)
DATA_tira_9102:
	defb 0feh,000h,022h,001h,090h,02eh,0a0h,02ah,0b0h,026h,0c0h,023h,0d0h,024h,0d0h,025h	; 9102  .."....*.&.#.$.%
	defb 0d0h,026h,0d0h,02ah,0d0h,02ch,0d0h,02eh,0d0h,030h,0c0h,032h,0b0h,034h,0a0h,036h	; 9112  .&.*.,...0.2.4.6
	defb 090h,038h,0ffh	; 9122

; ----------------------------------------------------------------------
; DATOS tira_9125: partitura de sonido (voz del sonido 0x18) que lee
;   pide_un_efecto; lo cargan 0x873A[23] (9 bytes)
;   0x9125..0x912e  (9 bytes)
DATA_tira_9125:
	defb 0feh,000h,02ah,008h,004h,000h,090h,01eh,0ffh	; 9125  ..*......

; ----------------------------------------------------------------------
; DATOS tira_912E: partitura de sonido (voz del sonido 0x1A) que lee
;   pide_un_efecto; lo cargan 0x873A[25] (73 bytes)
;   0x912e..0x9177  (73 bytes)
DATA_tira_912E:
	defb 0feh,000h,022h,001h,0f1h,0c0h,0f2h,000h,0f2h,080h,0f6h,000h,0f2h,0e0h,0f3h,050h	; 912e  .."............P
	defb 0f4h,000h,0f2h,000h,0f3h,050h,000h,000h,0f6h,000h,000h,000h,000h,000h,0fbh,000h	; 913e  .....P..........
	defb 000h,000h,0fch,000h,000h,000h,000h,000h,0f9h,000h,000h,000h,000h,000h,0fdh,0fdh	; 914e  ................
	defb 000h,000h,0fah,0b0h,000h,000h,000h,000h,0fch,000h,000h,000h,0fah,000h,000h,000h	; 915e  ................
	defb 0fdh,0d6h,000h,000h,000h,000h,0fbh,000h,0ffh	; 916e  .........

; ----------------------------------------------------------------------
; DATOS tira_9177: partitura de sonido (voz del sonido 0x16) que lee
;   pide_un_efecto; lo cargan 0x873A[21] (63 bytes)
;   0x9177..0x91b6  (63 bytes)
DATA_tira_9177:
	defb 0feh,000h,022h,004h,070h,035h,080h,02ch,080h,02fh,090h,02ah,090h,01ch,090h,021h	; 9177  ..".p5.,./.*...!
	defb 0a0h,032h,0a0h,023h,0a0h,01eh,0feh,002h,079h,091h,0a0h,02fh,022h,003h,0b0h,035h	; 9187  .2.#....y../"..5
	defb 0c0h,02ch,0c0h,025h,0feh,002h,091h,091h,0c0h,02ah,0c0h,01ch,0c0h,021h,0c0h,032h	; 9197  .,.%.....*...!.2
	defb 0c0h,023h,0c0h,01eh,0c0h,02fh,0c0h,02ah,0b0h,01ch,0a0h,028h,090h,02ah,0ffh	; 91a7  .#.../.*...(.*.

; ----------------------------------------------------------------------
; DATOS tira_91B6: partitura de sonido (voz del sonido 0x31) que lee
;   pide_un_efecto; lo cargan 0x873A[48] (33 bytes)
;   0x91b6..0x91d7  (33 bytes)
DATA_tira_91B6:
	defb 0feh,000h,022h,003h,0f0h,03fh,0e0h,056h,0b0h,03fh,0a0h,056h,022h,002h,070h,01ch	; 91b6  .."..?.V.?.V".p.
	defb 080h,03fh,070h,056h,060h,01ch,060h,03fh,050h,056h,050h,01ch,0feh,003h,0b8h,091h	; 91c6  .?pV`.`?PVP.....
	defb 0ffh	; 91d6

; ----------------------------------------------------------------------
; DATOS tira_91D7: partitura de sonido (voz del sonido 0x0F) que lee
;   pide_un_efecto; lo cargan 0x873A[14] (17 bytes)
;   0x91d7..0x91e8  (17 bytes)
DATA_tira_91D7:
	defb 0feh,000h,022h,001h,0d0h,040h,0d0h,060h,0d0h,05ah,0d0h,055h,0d0h,050h,0d0h,04ah	; 91d7  .."..@.`.Z.U.P.J
	defb 0ffh	; 91e7

; ----------------------------------------------------------------------
; DATOS tira_91E8: partitura de sonido (voz del sonido 0x10) que lee
;   pide_un_efecto; lo cargan 0x873A[15] (64 bytes)
;   0x91e8..0x9228  (64 bytes)
DATA_tira_91E8:
	defb 0feh,000h,021h,001h,010h,0c0h,000h,01fh,0e0h,000h,01eh,0d0h,000h,01dh,0c0h,000h	; 91e8  ..!.............
	defb 01ch,0b0h,000h,01bh,0b0h,000h,01ah,0b0h,000h,019h,0b0h,000h,018h,0b0h,000h,017h	; 91f8  ................
	defb 0b0h,000h,016h,0b0h,000h,015h,0b0h,000h,014h,0b0h,000h,013h,0b0h,000h,012h,0b0h	; 9208  ................
	defb 000h,011h,0b0h,000h,010h,0b0h,000h,0a0h,000h,090h,000h,080h,000h,070h,000h,0ffh	; 9218  .............p..

; ----------------------------------------------------------------------
; DATOS tira_9228: partitura de sonido (voz del sonido 0x03) que lee
;   pide_un_efecto; lo cargan 0x873A[2] (29 bytes)
;   0x9228..0x9245  (29 bytes)
DATA_tira_9228:
	defb 0feh,000h,022h,002h,0d0h,07fh,0b0h,070h,0b0h,077h,0a0h,062h,090h,050h,080h,043h	; 9228  .."....p.w.b.P.C
	defb 020h,003h,022h,001h,070h,043h,020h,004h,022h,001h,060h,043h,0ffh	; 9238   .".pC .".`C.

; ----------------------------------------------------------------------
; DATOS tira_9245: partitura de sonido (voz del sonido 0x05) que lee
;   pide_un_efecto; lo cargan 0x873A[4] (85 bytes)
;   0x9245..0x929a  (85 bytes)
DATA_tira_9245:
	defb 0feh,000h,021h,001h,01fh,0d0h,000h,010h,0b0h,000h,013h,0a0h,000h,016h,090h,000h	; 9245  ..!.............
	defb 01ah,080h,000h,021h,002h,010h,0e0h,000h,013h,0c0h,000h,016h,0b0h,000h,01ch,0a0h	; 9255  ...!............
	defb 000h,01fh,090h,000h,020h,001h,021h,002h,010h,0a0h,000h,013h,0b0h,000h,017h,0a0h	; 9265  .... .!.........
	defb 000h,01fh,090h,000h,020h,002h,021h,002h,010h,080h,000h,013h,090h,000h,01bh,080h	; 9275  .... .!.........
	defb 000h,01fh,070h,000h,020h,003h,021h,002h,010h,060h,000h,013h,070h,000h,01bh,060h	; 9285  ..p. .!..`..p..`
	defb 000h,01fh,050h,000h,0ffh	; 9295

; ----------------------------------------------------------------------
; DATOS tira_929A: partitura de sonido (voz del sonido 0x0C) que lee
;   pide_un_efecto; lo cargan 0x873A[11] (21 bytes)
;   0x929a..0x92af  (21 bytes)
DATA_tira_929A:
	defb 0feh,000h,022h,001h,0c0h,0e2h,0d0h,0beh,0c0h,0aah,0b0h,099h,0c0h,088h,0b0h,077h	; 929a  .."............w
	defb 0a0h,066h,090h,055h,0ffh	; 92aa

; ----------------------------------------------------------------------
; DATOS tira_92AF: partitura de sonido (voz del sonido 0x07) que lee
;   pide_un_efecto; lo cargan 0x873A[6] (27 bytes)
;   0x92af..0x92ca  (27 bytes)
DATA_tira_92AF:
	defb 0feh,000h,022h,002h,0d1h,0eeh,0d1h,0cch,0c1h,0eeh,0b1h,0ffh,0a1h,099h,091h,088h	; 92af  ..".............
	defb 081h,077h,071h,066h,061h,077h,051h,088h,041h,099h,0ffh	; 92bf  .wqfawQ.A..

; ----------------------------------------------------------------------
; DATOS tira_92CA: partitura de sonido (voz del sonido 0x08) que lee
;   pide_un_efecto; lo cargan 0x873A[7] (11 bytes)
;   0x92ca..0x92d5  (11 bytes)
DATA_tira_92CA:
	defb 0feh,000h,022h,001h,0d1h,003h,0c1h,00dh,0c1h,006h,0ffh	; 92ca  .."........

; ----------------------------------------------------------------------
; DATOS tira_92D5: partitura de sonido (voz del sonido 0x09) que lee
;   pide_un_efecto; lo cargan 0x873A[8] (11 bytes)
;   0x92d5..0x92e0  (11 bytes)
DATA_tira_92D5:
	defb 0feh,000h,022h,001h,0d1h,043h,0c1h,04dh,0c1h,046h,0ffh	; 92d5  .."..C.M.F.

; ----------------------------------------------------------------------
; DATOS tira_92E0: partitura de sonido (voz del sonido 0x0A) que lee
;   pide_un_efecto; lo cargan 0x873A[9] (54 bytes)
;   0x92e0..0x9316  (54 bytes)
DATA_tira_92E0:
	defb 0feh,000h,023h,001h,016h,0d0h,045h,022h,001h,0b0h,040h,020h,003h,023h,001h,010h	; 92e0  ..#...E"..@ .#..
	defb 0b0h,080h,012h,0b0h,088h,014h,0a0h,090h,016h,0a0h,098h,018h,0a0h,0a0h,01ah,090h	; 92f0  ................
	defb 0a8h,01ch,090h,0b0h,01fh,090h,0b1h,080h,0b2h,080h,0b3h,080h,0b5h,070h,0b9h,070h	; 9300  .............p.p
	defb 0bdh,070h,0c1h,070h,0c8h,0ffh	; 9310

; ----------------------------------------------------------------------
; DATOS tira_9316: partitura de sonido (voz del sonido 0x0B) que lee
;   pide_un_efecto; lo cargan 0x873A[10] (27 bytes)
;   0x9316..0x9331  (27 bytes)
DATA_tira_9316:
	defb 0feh,000h,022h,001h,0e0h,0a5h,0d0h,0adh,0c0h,0b5h,0a0h,0c5h,090h,0d5h,080h,0e5h	; 9316  ..".............
	defb 022h,002h,070h,0e5h,061h,005h,051h,025h,051h,045h,0ffh	; 9326  ".p.a.Q%QE.

; ----------------------------------------------------------------------
; DATOS tira_9331: partitura de sonido (voz del sonido 0x15) que lee
;   pide_un_efecto; lo cargan 0x873A[20] (57 bytes)
;   0x9331..0x936a  (57 bytes)
DATA_tira_9331:
	defb 0feh,000h,022h,002h,0e3h,000h,0f5h,000h,020h,001h,023h,001h,010h,0e0h,030h,0e0h	; 9331  .."..... .#...0.
	defb 031h,0d0h,02fh,0d0h,02eh,013h,0c0h,02dh,023h,002h,0c0h,02eh,016h,0b0h,02fh,0b0h	; 9341  1./....-#...../.
	defb 030h,0a0h,031h,0a0h,032h,023h,003h,01ah,090h,033h,080h,034h,070h,035h,060h,036h	; 9351  0.1.2#...3.4p5`6
	defb 060h,037h,060h,038h,060h,039h,050h,03ah,0ffh	; 9361  `7`8`9P:.

; ----------------------------------------------------------------------
; DATOS tira_936A: partitura de sonido (voz del sonido 0x1D) que lee
;   pide_un_efecto; lo cargan 0x873A[28] (36 bytes)
;   0x936a..0x938e  (36 bytes)
DATA_tira_936A:
	defb 0feh,000h,023h,001h,01fh,0f0h,080h,0d0h,040h,0b0h,080h,090h,020h,022h,001h,0e2h	; 936a  ..#.....@... "..
	defb 000h,0d4h,000h,0d5h,000h,0d6h,000h,0d7h,000h,0d8h,000h,0d9h,000h,0dah,000h,0cbh	; 937a  ................
	defb 000h,0cch,000h,0ffh	; 938a

; ----------------------------------------------------------------------
; DATOS tira_938E: partitura de sonido (voz del sonido 0x1C) que lee
;   pide_un_efecto; lo cargan 0x873A[27] (57 bytes)
;   0x938e..0x93c7  (57 bytes)
DATA_tira_938E:
	defb 0feh,000h,022h,001h,0f3h,000h,0e5h,000h,0e7h,000h,0e8h,000h,0fah,000h,0ech,000h	; 938e  ..".............
	defb 0e7h,000h,0d8h,000h,000h,000h,0f8h,000h,0ech,000h,000h,000h,0f4h,000h,0e7h,000h	; 939e  ................
	defb 0dch,000h,020h,001h,022h,001h,0f6h,000h,0e8h,000h,0eah,000h,0dch,000h,000h,000h	; 93ae  .. ."...........
	defb 0fah,000h,0ech,000h,0edh,000h,0deh,000h,0ffh	; 93be  .........

; ----------------------------------------------------------------------
; DATOS tira_93C7: partitura de sonido (voz del sonido 0x23) que lee
;   pide_un_efecto; lo cargan 0x873A[34] (13 bytes)
;   0x93c7..0x93d4  (13 bytes)
DATA_tira_93C7:
	defb 0feh,000h,020h,001h,022h,001h,0e0h,050h,0b0h,050h,070h,050h,0ffh	; 93c7  .. ."..P.PpP.

; ----------------------------------------------------------------------
; DATOS tira_93D4: partitura de sonido (voz del sonido 0x28) que lee
;   pide_un_efecto; lo cargan 0x873A[39] (119 bytes)
;   0x93d4..0x944b  (119 bytes)
DATA_tira_93D4:
	defb 0efh,0d1h,0fbh,000h,0e2h,000h,0b0h,0e3h,090h,0e2h,080h,0e3h,060h,0e2h,050h,0e3h	; 93d4  ............`.P.
	defb 030h,0e2h,020h,0e3h,000h,0e2h,000h,0e3h,010h,0e2h,010h,0e3h,020h,0e2h,020h,0e3h	; 93e4  0. ......... . .
	defb 030h,0e2h,030h,0e3h,040h,0e2h,040h,0e3h,050h,0e2h,050h,0e3h,060h,0e2h,060h,0e3h	; 93f4  0.0.@.@.P.P.`.`.
	defb 070h,0e2h,070h,0e3h,080h,0e2h,080h,0e3h,090h,0e2h,090h,0e3h,0a0h,0e2h,0a0h,0e3h	; 9404  p.p.............
	defb 0b0h,0e2h,0b0h,000h,0e1h,000h,0e2h,010h,0e1h,010h,0e2h,020h,0e1h,020h,0e2h,030h	; 9414  ........... . .0
	defb 0e1h,030h,0e2h,040h,0e1h,040h,0e2h,050h,0e1h,050h,0e2h,060h,0e1h,060h,0f9h,000h	; 9424  .0.@.@.P.P.`.`..
	defb 0e2h,060h,0e1h,060h,0f7h,000h,0e2h,060h,0e1h,060h,0f5h,000h,0e2h,060h,0e1h,060h	; 9434  .`.`...`.`...`.`
	defb 0f3h,000h,0e2h,060h,0e1h,060h,0ffh	; 9444

; ----------------------------------------------------------------------
; DATOS tira_944B: partitura de sonido (voz del sonido 0x25) que lee
;   pide_un_efecto; lo cargan 0x873A[36] (9 bytes)
;   0x944b..0x9454  (9 bytes)
DATA_tira_944B:
	defb 0feh,000h,02ah,01bh,000h,013h,0a0h,070h,0ffh	; 944b  ..*....p.

; ----------------------------------------------------------------------
; DATOS tira_9454: partitura de sonido (voz del sonido 0x24) que lee
;   pide_un_efecto; lo cargan 0x873A[35] (53 bytes)
;   0x9454..0x9489  (53 bytes)
DATA_tira_9454:
	defb 0feh,000h,022h,001h,0c0h,080h,0c0h,071h,0c0h,05fh,0c0h,040h,0c0h,07bh,0c0h,06ch	; 9454  .."....q._.@.{.l
	defb 0c0h,05bh,0c0h,03ch,0c0h,077h,0c0h,067h,0c0h,056h,0c0h,038h,020h,002h,022h,003h	; 9464  .[.<.w.g.V.8 .".
	defb 0c0h,030h,0b0h,02fh,0a0h,030h,090h,02fh,080h,030h,070h,02fh,060h,030h,050h,02fh	; 9474  .0./.0./.0p/`0P/
	defb 040h,030h,030h,02fh,0ffh	; 9484

; ----------------------------------------------------------------------
; DATOS tira_9489: partitura de sonido (voz del sonido 0x1B) que lee
;   pide_un_efecto; lo cargan 0x873A[26] (23 bytes)
;   0x9489..0x94a0  (23 bytes)
DATA_tira_9489:
	defb 0feh,000h,022h,002h,0d0h,035h,0c0h,055h,0c0h,054h,0c0h,053h,0c0h,052h,0b0h,051h	; 9489  .."..5.U.T.S.R.Q
	defb 0b0h,050h,0a0h,04fh,0a0h,04eh,0ffh	; 9499

; ----------------------------------------------------------------------
; DATOS tira_94A0: partitura de sonido (voz del sonido 0x19) que lee
;   pide_un_efecto; lo cargan 0x873A[24] (15 bytes)
;   0x94a0..0x94af  (15 bytes)
DATA_tira_94A0:
	defb 0feh,000h,022h,001h,0b0h,080h,090h,040h,020h,003h,0feh,005h,0a2h,094h,0ffh	; 94a0  .."....@ ......

; ----------------------------------------------------------------------
; DATOS tira_94AF: partitura de sonido (voz del sonido 0x39) que lee
;   pide_un_efecto; lo cargan 0x873A[56] (11 bytes)
;   0x94af..0x94ba  (11 bytes)
DATA_tira_94AF:
	defb 0feh,000h,022h,001h,0c0h,040h,0b0h,020h,020h,002h,0ffh	; 94af  .."..@.  ..

; ----------------------------------------------------------------------
; DATOS tira_94BA: partitura de sonido (voz del sonido 0x04) que lee
;   pide_un_efecto; lo cargan 0x873A[3] (51 bytes)
;   0x94ba..0x94ed  (51 bytes)
DATA_tira_94BA:
	defb 0feh,000h,022h,001h,0c0h,043h,0d0h,058h,0e0h,046h,0d0h,04ah,0d0h,04fh,0c0h,055h	; 94ba  .."..C.X.F.J.O.U
	defb 0c0h,05ch,020h,005h,022h,001h,090h,044h,0b0h,047h,0a0h,04bh,0a0h,050h,090h,056h	; 94ca  .\ ."..D.G.K.P.V
	defb 090h,05dh,020h,003h,022h,001h,060h,045h,080h,048h,070h,04ch,070h,051h,060h,057h	; 94da  .] .".`E.HpLpQ`W
	defb 060h,05eh,0ffh	; 94ea

; ----------------------------------------------------------------------
; DATOS tira_94ED: partitura de sonido (voz del sonido 0x06) que lee
;   pide_un_efecto; lo cargan 0x873A[5] (85 bytes)
;   0x94ed..0x9542  (85 bytes)
DATA_tira_94ED:
	defb 0feh,000h,023h,001h,010h,0f2h,060h,021h,001h,012h,0b0h,000h,014h,090h,000h,016h	; 94ed  ..#...`!........
	defb 0a0h,000h,01ah,080h,000h,023h,002h,010h,0f3h,000h,021h,002h,013h,090h,000h,016h	; 94fd  .....#....!.....
	defb 0c0h,000h,01ch,0b0h,000h,01fh,0a0h,000h,090h,000h,020h,001h,021h,002h,010h,0b0h	; 950d  .......... .!...
	defb 000h,013h,080h,000h,016h,0a0h,000h,01ch,090h,000h,01fh,080h,000h,070h,000h,020h	; 951d  .............p.
	defb 002h,021h,002h,010h,090h,000h,013h,060h,000h,016h,080h,000h,01ch,070h,000h,01fh	; 952d  .!.....`.....p..
	defb 060h,000h,050h,000h,0ffh	; 953d

; ----------------------------------------------------------------------
; DATOS tira_9542: partitura de sonido (voz del sonido 0x22) que lee
;   pide_un_efecto; lo cargan 0x873A[33] (113 bytes)
;   0x9542..0x95b3  (113 bytes)
DATA_tira_9542:
	defb 0feh,000h,022h,003h,0d0h,055h,022h,001h,0d0h,053h,0d0h,051h,0d0h,04eh,0d0h,04bh	; 9542  .."..U"..S.Q.N.K
	defb 0d0h,048h,0d0h,044h,0d0h,040h,0d0h,03ch,0d0h,039h,0d0h,035h,0a0h,055h,0a0h,053h	; 9552  .H.D.@.<.9.5.U.S
	defb 0a0h,051h,0a0h,04eh,0a0h,04bh,0a0h,048h,0a0h,044h,0a0h,040h,0a0h,03ch,0a0h,039h	; 9562  .Q.N.K.H.D.@.<.9
	defb 0a0h,035h,070h,055h,070h,053h,070h,051h,070h,04eh,070h,04bh,070h,048h,070h,044h	; 9572  .5pUpSpQpNpKpHpD
	defb 070h,040h,070h,03ch,070h,039h,070h,035h,040h,055h,040h,053h,040h,051h,040h,04eh	; 9582  p@p<p9p5@U@S@Q@N
	defb 040h,04bh,040h,048h,040h,044h,040h,040h,040h,03ch,040h,039h,040h,035h,030h,055h	; 9592  @K@H@D@@@<@9@50U
	defb 030h,053h,030h,051h,030h,04eh,030h,04bh,030h,048h,030h,044h,030h,040h,030h,039h	; 95a2  0S0Q0N0K0H0D0@09
	defb 0ffh	; 95b2

; ----------------------------------------------------------------------
; DATOS tira_95B3: partitura de sonido (voz del sonido 0x3A) que lee
;   pide_un_efecto; lo cargan 0x873A[57] (14 bytes)
;   0x95b3..0x95c1  (14 bytes)
DATA_tira_95B3:
	defb 0efh,0d1h,0fch,088h,0e1h,004h,074h,044h,074h,0fch,023h,0e0h,009h,0ffh	; 95b3  ......tDt.#...

; ----------------------------------------------------------------------
; DATOS tira_95C1: partitura de sonido (voz del sonido 0x3B; voz del sonido
;   0x3C; voz del sonido 0x3D; voz del sonido 0x3E; ...) que lee
;   pide_un_efecto; se entra por 0x95C1, 0x965D, 0x972D, 0x9823, 0x9976,
;   0x9A83, 0x9B69, 0x9C02, 0x9CB3, 0x9CFD, 0x9E40, 0x9F11; lo cargan
;   0x873A[58], 0x873A[59], 0x873A[60], 0x873A[61], 0x873A[62], 0x873A[63] y 6
;   sitios mas; sigue en el banco 15, en la ranura de al lado (2623 bytes)
;   0x95c1..0xa000  (2623 bytes)
DATA_tira_95C1:
	defb 0efh,0d7h,0f9h,014h,0e2h,0a0h,080h,0a0h,0e1h,011h,0e2h,0a0h,080h,0a0h,0e1h,013h	; 95c1  ................
	defb 003h,0feh,002h,0c3h,095h,0e2h,0a0h,080h,0a0h,0e1h,012h,0e2h,0a0h,080h,0a0h,0e1h	; 95d1  ................
	defb 032h,0e2h,0a0h,080h,0a0h,080h,0feh,002h,0d6h,095h,0e2h,0c0h,060h,080h,0a0h,0c0h	; 95e1  2...........`...
	defb 060h,085h,080h,0a0h,0e1h,010h,030h,0c0h,060h,080h,0a0h,0c0h,060h,085h,080h,060h	; 95f1  `.....0.`...`..`
	defb 050h,010h,0e2h,0a0h,080h,0a0h,0e1h,012h,0e2h,0a0h,080h,0a0h,0e1h,032h,0e2h,0a0h	; 9601  P............2..
	defb 080h,0a0h,080h,0feh,002h,003h,096h,0e2h,0c0h,060h,080h,0a0h,0c0h,060h,085h,080h	; 9611  .........`...`..
	defb 0a0h,0e1h,010h,030h,0c0h,060h,080h,0a0h,0c0h,060h,085h,080h,060h,050h,010h,0e2h	; 9621  ...0.`...`..`P..
	defb 093h,042h,090h,0e1h,043h,042h,060h,04bh,022h,010h,022h,010h,0f9h,000h,0e2h,09ah	; 9631  .B..CB`K".".....
	defb 0d1h,0a0h,0b0h,0e1h,000h,010h,020h,030h,040h,050h,060h,070h,080h,092h,0d7h,0f9h	; 9641  ...... 0@P`p....
	defb 013h,098h,071h,050h,030h,010h,0e2h,0a0h,0feh,0feh,0c3h,095h,0efh,0d7h,0fah,013h	; 9651  ..qP0...........
	defb 0e3h,031h,0e2h,030h,030h,0e3h,031h,0e2h,030h,030h,0e3h,061h,0e2h,060h,060h,0e3h	; 9661  .1.00.1.00.a.``.
	defb 081h,0e2h,080h,080h,0feh,002h,061h,096h,0e3h,031h,0e2h,030h,030h,0e3h,031h,0e2h	; 9671  ......a..1.00.1.
	defb 030h,030h,0e3h,061h,0e2h,060h,060h,0e3h,051h,0e2h,050h,050h,0feh,002h,079h,096h	; 9681  00.a.``.Q.PP..y.
	defb 0e3h,011h,0e2h,010h,010h,0e3h,011h,0e2h,010h,010h,0e3h,061h,0e2h,060h,060h,0e3h	; 9691  ...........a.``.
	defb 051h,0e2h,050h,050h,0feh,002h,091h,096h,0e3h,031h,0e2h,030h,030h,0e3h,031h,0e2h	; 96a1  Q.PP.....1.00.1.
	defb 030h,030h,0e3h,061h,0e2h,060h,060h,0e3h,051h,0e2h,050h,050h,0feh,002h,0a9h,096h	; 96b1  00.a.``.Q.PP....
	defb 0e3h,011h,0e2h,010h,010h,0e3h,011h,0e2h,010h,010h,0e3h,061h,0e2h,060h,060h,0e3h	; 96c1  ...........a.``.
	defb 051h,0e2h,050h,050h,0feh,002h,0c1h,096h,0e3h,091h,0e2h,040h,040h,0e3h,091h,0e2h	; 96d1  Q.PP.......@@...
	defb 010h,010h,0e3h,091h,0e2h,090h,090h,0e3h,091h,0e2h,040h,040h,0e3h,071h,0e2h,070h	; 96e1  ..........@@.q.p
	defb 070h,0e3h,071h,0e2h,020h,020h,0e3h,071h,0e2h,070h,070h,0e3h,071h,0e2h,020h,020h	; 96f1  p.q.  .q.pp.q.
	defb 0e3h,061h,0e2h,060h,060h,0e3h,061h,0e2h,020h,020h,0e3h,061h,0e2h,060h,060h,0e3h	; 9701  .a.``.a.  .a.``.
	defb 061h,0e2h,020h,020h,0e3h,051h,0e2h,050h,050h,0e3h,051h,0e2h,000h,000h,0e3h,071h	; 9711  a.  .Q.PP.Q....q
	defb 0e2h,070h,070h,0e3h,081h,0e2h,080h,080h,0feh,0feh,061h,096h,0efh,0d7h,0f9h,014h	; 9721  .pp.......a.....
	defb 0e4h,031h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,030h,030h,061h,0e9h,000h	; 9731  .1...@.....00a..
	defb 000h,040h,000h,0efh,0f9h,014h,0e4h,080h,080h,0feh,002h,031h,097h,0e4h,031h,0e9h	; 9741  .@.........1..1.
	defb 000h,000h,040h,000h,0efh,0f9h,014h,0e4h,030h,030h,061h,0e9h,000h,000h,040h,000h	; 9751  ..@.....00a...@.
	defb 0efh,0f9h,014h,0e4h,050h,050h,0feh,002h,04eh,097h,0e4h,011h,0e9h,000h,000h,040h	; 9761  ....PP..N......@
	defb 000h,0efh,0f9h,014h,0e4h,010h,010h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h	; 9771  .......a...@....
	defb 0e4h,050h,050h,0feh,002h,06bh,097h,0e4h,031h,0e9h,000h,000h,040h,000h,0efh,0f9h	; 9781  .PP..k..1...@...
	defb 014h,0e4h,030h,030h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,050h,050h	; 9791  ..00a...@.....PP
	defb 0feh,002h,088h,097h,0e4h,011h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,010h	; 97a1  .........@......
	defb 010h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,050h,050h,0feh,002h,0a5h	; 97b1  .a...@.....PP...
	defb 097h,0e4h,091h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,090h,090h,091h,0e9h	; 97c1  ......@.........
	defb 000h,000h,040h,000h,0efh,0f9h,014h,0e4h,090h,090h,071h,0e9h,000h,000h,040h,000h	; 97d1  ..@.......q...@.
	defb 0efh,0f9h,014h,0e4h,070h,070h,071h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,070h	; 97e1  ....ppq...@....p
	defb 070h,061h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,0e4h,060h,060h,061h,0e9h,000h	; 97f1  pa...@.....``a..
	defb 000h,040h,000h,0efh,0f9h,014h,060h,060h,051h,0e9h,000h,000h,040h,000h,0efh,0f9h	; 9801  .@....``Q...@...
	defb 014h,050h,050h,071h,0e9h,000h,000h,040h,000h,0efh,0f9h,014h,080h,080h,0feh,0feh	; 9811  .PPq...@........
	defb 031h,097h,0efh,0d8h,0fah,022h,0e2h,050h,0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,050h	; 9821  1....".P.....0.P
	defb 0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,030h,0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,030h	; 9831  .....0.0.....0.0
	defb 0e1h,000h,0e2h,0a0h,0e1h,030h,010h,0e2h,080h,0e1h,010h,050h,030h,0e2h,0a0h,0e1h	; 9841  .....0.....P0...
	defb 030h,070h,057h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h,0a1h,081h	; 9851  0pW.Q.....1.....
	defb 0e1h,001h,0e2h,0a0h,080h,071h,051h,081h,070h,050h,070h,080h,0a0h,080h,070h,000h	; 9861  .....qQ.pPp...p.
	defb 0feh,002h,054h,098h,0e2h,081h,0e1h,031h,031h,010h,000h,0e2h,0a1h,0e1h,011h,003h	; 9871  ..T....11.......
	defb 0e2h,051h,0e1h,001h,001h,0e2h,0a0h,0e1h,000h,010h,000h,0e2h,0a0h,080h,071h,0e1h	; 9881  .Q............q.
	defb 001h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h,0a1h,0e1h,001h,0e2h	; 9891  ..Q.....1.......
	defb 081h,0e1h,051h,0e2h,081h,0e1h,031h,071h,057h,0e2h,050h,0e1h,000h,0e2h,0a0h,0e1h	; 98a1  ..Q...1qW.P.....
	defb 030h,0e2h,050h,0e1h,000h,0e2h,0a0h,0e1h,030h,0e2h,030h,0e1h,000h,0e2h,0a0h,0e1h	; 98b1  0.P.....0.0.....
	defb 030h,0e2h,030h,0e1h,000h,0e2h,0a0h,0e1h,030h,010h,0e2h,080h,0e1h,010h,050h,030h	; 98c1  0.0.....0.....P0
	defb 0e2h,0a0h,0e1h,030h,070h,057h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h	; 98d1  ...0pW.Q.....1..
	defb 0e2h,0a1h,081h,0e1h,001h,0e2h,0a0h,080h,071h,051h,081h,070h,050h,070h,080h,0a0h	; 98e1  ........qQ.pPp..
	defb 080h,070h,000h,0feh,002h,0d7h,098h,0e2h,081h,0e1h,031h,031h,010h,000h,0e2h,0a1h	; 98f1  .p........11....
	defb 0e1h,011h,003h,0e2h,051h,0e1h,001h,001h,0e2h,0a0h,0e1h,000h,010h,000h,0e2h,0a0h	; 9901  ....Q...........
	defb 080h,071h,0e1h,001h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h,0a1h	; 9911  .q...Q.....1....
	defb 0e1h,001h,0e2h,081h,0e1h,051h,0e2h,081h,0e1h,031h,071h,057h,0f9h,013h,0e2h,051h	; 9921  .....Q...1qW...Q
	defb 0e1h,001h,0e2h,0a1h,0e1h,031h,010h,000h,0e2h,0a1h,081h,0e1h,001h,0e2h,080h,000h	; 9931  .....1..........
	defb 0a0h,030h,0e1h,000h,0e2h,050h,0e1h,030h,0e2h,080h,0e1h,010h,000h,0e2h,030h,0e1h	; 9941  .0...P.0......0.
	defb 010h,000h,0e2h,0a0h,040h,0e1h,000h,0fah,022h,0e2h,051h,0e1h,001h,0e2h,0a1h,0e1h	; 9951  ....@...".Q.....
	defb 031h,010h,000h,0e2h,0a1h,0e1h,001h,0e2h,081h,0e1h,051h,0e2h,081h,0e1h,031h,071h	; 9961  1.........Q...1q
	defb 057h,0feh,0feh,027h,098h,0efh,0d8h,0fbh,021h,0e4h,051h,081h,0a1h,071h,081h,0e3h	; 9971  W..'....!.Q..q..
	defb 001h,0e4h,0a1h,0e3h,011h,0e4h,0a1h,0e3h,011h,001h,031h,050h,000h,0e4h,0a0h,0e3h	; 9981  ..........1P....
	defb 010h,000h,0e4h,0a0h,080h,070h,0fbh,016h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h	; 9991  .....p...Q..q...
	defb 0e4h,0a1h,0e3h,031h,011h,0e4h,0a1h,0e3h,001h,0e4h,081h,071h,051h,071h,001h,0feh	; 99a1  ...1.......qQq..
	defb 002h,097h,099h,0e4h,081h,0e3h,001h,011h,0e4h,0a1h,071h,0a1h,0e3h,001h,0e4h,081h	; 99b1  ..........q.....
	defb 051h,081h,0a1h,071h,051h,081h,0a1h,071h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h	; 99c1  Q..qQ..q.Q..q...
	defb 0e4h,0a1h,0e3h,031h,011h,0e4h,081h,0e3h,031h,0e4h,0a1h,0e3h,051h,001h,0e4h,081h	; 99d1  ...1....1...Q...
	defb 001h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h,011h,0e4h,0a1h,0e3h	; 99e1  ..Q..q..........
	defb 011h,001h,031h,050h,000h,0e4h,0a0h,0e3h,010h,000h,0e4h,0a0h,080h,070h,0fbh,016h	; 99f1  ..1P.........p..
	defb 0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h,031h,011h,0e4h,0a1h,0e3h	; 9a01  .Q..q......1....
	defb 001h,0e4h,081h,071h,051h,071h,001h,0feh,002h,0ffh,099h,0e4h,081h,0e3h,001h,011h	; 9a11  ...qQq..........
	defb 0e4h,0a1h,071h,0a1h,0e3h,001h,0e4h,081h,051h,081h,0a1h,071h,051h,081h,0a1h,071h	; 9a21  ..q.....Q..qQ..q
	defb 0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h,031h,011h,0e4h,081h,0e3h	; 9a31  .Q..q......1....
	defb 031h,0e4h,0a1h,0e3h,051h,001h,0e4h,081h,001h,0f9h,012h,0e2h,081h,0e1h,031h,031h	; 9a41  1...Q.........11
	defb 010h,000h,0e2h,0a1h,0e1h,011h,001h,0e2h,031h,051h,071h,081h,0e1h,001h,0e3h,071h	; 9a51  ........1Qq....q
	defb 051h,041h,001h,0fbh,016h,0e4h,051h,081h,0a1h,071h,081h,0e3h,001h,0e4h,0a1h,0e3h	; 9a61  QA....Q..q......
	defb 031h,011h,0e4h,081h,0e3h,031h,0e4h,0a1h,0e3h,051h,001h,0e4h,081h,001h,0feh,0feh	; 9a71  1....1...Q......
	defb 07ah,099h,0efh,0d8h,0f9h,035h,0e0h,050h,001h,000h,000h,001h,000h,030h,001h,000h	; 9a81  z....5.P.....0..
	defb 000h,001h,000h,0e0h,050h,010h,050h,080h,070h,030h,070h,0a0h,0e9h,070h,071h,070h	; 9a91  ....P.P.p0p..pqp
	defb 080h,080h,080h,080h,000h,000h,000h,000h,040h,000h,000h,000h,000h,000h,000h,000h	; 9aa1  ........@.......
	defb 040h,000h,081h,0feh,006h,0a5h,09ah,000h,000h,000h,000h,040h,000h,000h,000h,000h	; 9ab1  @..........@....
	defb 000h,000h,000h,030h,000h,081h,000h,000h,000h,000h,040h,000h,000h,000h,070h,070h	; 9ac1  ...0......@...pp
	defb 070h,070h,080h,080h,080h,080h,000h,000h,000h,000h,040h,000h,000h,000h,000h,000h	; 9ad1  pp........@.....
	defb 000h,000h,030h,000h,081h,000h,000h,000h,000h,040h,000h,000h,000h,070h,071h,070h	; 9ae1  ..0......@...pqp
	defb 080h,080h,080h,080h,000h,000h,000h,000h,040h,000h,000h,000h,000h,000h,000h,000h	; 9af1  ........@.......
	defb 040h,000h,081h,0feh,006h,0f5h,09ah,000h,000h,000h,000h,040h,000h,000h,000h,000h	; 9b01  @..........@....
	defb 000h,000h,000h,030h,000h,081h,000h,000h,000h,000h,040h,000h,000h,000h,070h,070h	; 9b11  ...0......@...pp
	defb 070h,070h,080h,080h,080h,080h,0efh,0d8h,0f9h,012h,0e3h,051h,0e2h,001h,001h,0e3h	; 9b21  pp.........Q....
	defb 0a0h,080h,071h,0a1h,081h,001h,011h,031h,051h,081h,0e9h,070h,071h,070h,080h,080h	; 9b31  ..q....1Q..pqp..
	defb 080h,080h,000h,000h,000h,000h,040h,000h,000h,000h,000h,000h,000h,000h,030h,000h	; 9b41  ......@.......0.
	defb 081h,000h,000h,000h,000h,040h,000h,000h,000h,070h,071h,070h,080h,080h,080h,080h	; 9b51  .....@...pqp....
	defb 0feh,002h,043h,09bh,0feh,0feh,0a5h,09ah,0efh,0d7h,0fah,023h,0e2h,041h,040h,040h	; 9b61  ..C........#.A@@
	defb 020h,000h,0feh,003h,06bh,09bh,070h,053h,050h,042h,040h,020h,000h,0e1h,002h,000h	; 9b71   ...k.pSPB@ ....
	defb 0e2h,070h,0e1h,000h,002h,030h,020h,000h,041h,000h,0e2h,070h,0e1h,000h,040h,070h	; 9b81  .p...0 .A..p..@p
	defb 001h,002h,001h,040h,051h,040h,070h,001h,002h,001h,040h,051h,040h,040h,020h,000h	; 9b91  ...@Q@p...@Q@@ .
	defb 071h,000h,040h,020h,000h,070h,000h,000h,080h,070h,050h,030h,020h,000h,041h,000h	; 9ba1  q.@ .p...pP0 .A.
	defb 0e2h,070h,0e1h,000h,040h,031h,070h,081h,070h,0a2h,0a0h,080h,070h,081h,070h,034h	; 9bb1  .p..@1p.p...p.p4
	defb 030h,030h,0e2h,0a0h,0e1h,030h,032h,030h,0e2h,0a0h,0e1h,030h,031h,030h,030h,0e2h	; 9bc1  00...020...0100.
	defb 0a0h,0e1h,030h,032h,060h,050h,030h,081h,060h,051h,070h,041h,040h,040h,020h,000h	; 9bd1  ..02`P0.`QpA@@ .
	defb 0feh,003h,0dch,09bh,070h,053h,050h,042h,040h,020h,000h,082h,080h,030h,080h,0a2h	; 9be1  ....pSPB@ ...0..
	defb 0e0h,020h,000h,0e1h,0a0h,0e0h,001h,0e1h,070h,040h,000h,0e2h,070h,0feh,0feh,06bh	; 9bf1  . ......p@..p..k
	defb 09bh,0efh,0d7h,0fbh,015h,0e3h,001h,000h,000h,000h,000h,0e4h,0a1h,0a0h,0a0h,0a0h	; 9c01  ................
	defb 0a0h,091h,090h,090h,090h,090h,0a1h,0a0h,0a0h,0a0h,0a0h,0e3h,001h,000h,000h,000h	; 9c11  ................
	defb 000h,0e4h,0a1h,0a0h,0a0h,0a0h,0a0h,081h,080h,0a1h,0a0h,0e3h,001h,000h,000h,000h	; 9c21  ................
	defb 000h,001h,000h,000h,000h,000h,0e4h,0a1h,0a0h,0a0h,0a0h,0a0h,091h,090h,090h,090h	; 9c31  ................
	defb 090h,081h,080h,080h,080h,080h,0e3h,001h,000h,000h,000h,000h,0e4h,0a1h,0a0h,0a0h	; 9c41  ................
	defb 0a0h,0a0h,081h,080h,0a1h,0a0h,0e3h,001h,000h,000h,000h,000h,0e3h,031h,030h,030h	; 9c51  .............100
	defb 030h,030h,0feh,002h,05dh,09ch,011h,010h,010h,010h,010h,0feh,002h,067h,09ch,001h	; 9c61  00..]........g..
	defb 000h,000h,000h,000h,0feh,002h,070h,09ch,0e4h,0b1h,0b0h,0b0h,0b0h,0b0h,0b1h,0b0h	; 9c71  ......p.........
	defb 0e3h,010h,011h,001h,000h,000h,000h,000h,0e4h,0a1h,0a0h,0a0h,0a0h,0a0h,091h,090h	; 9c81  ................
	defb 090h,090h,090h,081h,080h,0a1h,0a0h,0e3h,001h,000h,000h,000h,000h,0e4h,081h,080h	; 9c91  ................
	defb 080h,080h,080h,0a1h,0a0h,0a0h,0a0h,0a0h,0e3h,001h,000h,000h,000h,000h,0feh,0feh	; 9ca1  ................
	defb 004h,09ch,0d7h,0e9h,001h,000h,041h,000h,0feh,007h,0b5h,09ch,001h,000h,040h,081h	; 9cb1  ......A.......@.
	defb 001h,000h,041h,000h,0feh,004h,0c1h,09ch,001h,000h,040h,020h,000h,0feh,002h,0c9h	; 9cc1  ..A.......@ ....
	defb 09ch,070h,070h,070h,070h,070h,070h,080h,080h,080h,080h,080h,080h,001h,000h,041h	; 9cd1  .pppppp........A
	defb 000h,0feh,007h,0deh,09ch,001h,000h,040h,040h,040h,001h,000h,041h,000h,0feh,007h	; 9ce1  .......@@@..A...
	defb 0ebh,09ch,070h,070h,070h,080h,080h,080h,0feh,0feh,0b5h,09ch,0efh,0d7h,0fah,023h	; 9cf1  ..ppp..........#
	defb 0e2h,000h,070h,0e1h,000h,0e2h,070h,0e1h,020h,040h,000h,0e2h,001h,050h,0a0h,050h	; 9d01  ..p...p. @...P.P
	defb 0e1h,000h,020h,0e2h,0a1h,0e3h,080h,0e2h,030h,080h,030h,0a0h,0e1h,000h,0e2h,080h	; 9d11  .. .....0.0.....
	defb 0e3h,0a1h,0e2h,050h,0a0h,050h,0a0h,090h,0a0h,0b0h,0f9h,013h,0e2h,000h,070h,0e1h	; 9d21  ...P.P........p.
	defb 000h,0e2h,070h,0e1h,020h,040h,000h,0e2h,001h,050h,0a0h,050h,0e1h,000h,020h,0e2h	; 9d31  ..p. @...P.P.. .
	defb 0a1h,0e3h,080h,0e2h,030h,080h,030h,0a0h,0e1h,000h,0e2h,080h,0e3h,0a1h,0e2h,050h	; 9d41  ....0.0........P
	defb 0a0h,050h,0a0h,090h,0a0h,0b0h,0d7h,0fah,023h,0e2h,051h,071h,050h,040h,000h,0e1h	; 9d51  .P......#.QqP@..
	defb 00ah,0e2h,0a0h,0a2h,070h,0a0h,081h,071h,080h,070h,050h,040h,0e2h,051h,041h,050h	; 9d61  ....p..q.pP@.QAP
	defb 040h,050h,070h,0e1h,00dh,0e2h,0a0h,077h,050h,0e2h,051h,041h,050h,040h,000h,0e1h	; 9d71  @Pp....wP.QAP@..
	defb 00ah,0e2h,0a0h,0a1h,000h,070h,0a0h,081h,071h,080h,070h,050h,040h,0e2h,051h,041h	; 9d81  .....p..q.pP@.QA
	defb 050h,0e1h,000h,070h,0e0h,00eh,0e1h,0a0h,078h,0feh,002h,02bh,09dh,0f9h,013h,0e2h	; 9d91  P..p....x..+....
	defb 000h,070h,0e1h,000h,0e2h,070h,0e1h,020h,040h,000h,0e2h,001h,050h,0a0h,050h,0e1h	; 9da1  .p...p. @...P.P.
	defb 000h,020h,0e2h,0a1h,0e3h,080h,0e2h,030h,080h,030h,0a0h,0e1h,000h,0e2h,080h,0e3h	; 9db1  . .....0.0......
	defb 0a1h,0e2h,050h,0a0h,050h,0a0h,090h,0a0h,0b0h,0feh,002h,0a0h,09dh,0e2h,020h,090h	; 9dc1  ..P.P......... .
	defb 0e1h,020h,0e2h,090h,0e1h,040h,060h,020h,0e2h,001h,070h,0e1h,000h,0e2h,070h,0e1h	; 9dd1  . ...@` ..p...p.
	defb 020h,040h,001h,0e3h,0a0h,0e2h,050h,0a0h,050h,0e1h,000h,020h,0e2h,0a0h,001h,070h	; 9de1   @....P.P.. ...p
	defb 0e1h,000h,0e2h,070h,0e1h,000h,0e2h,0b0h,0e1h,000h,010h,0e2h,020h,090h,0e1h,020h	; 9df1  ...p........ ..
	defb 0e2h,090h,0e1h,040h,060h,020h,0e2h,001h,070h,0e1h,000h,0e2h,070h,0e1h,020h,040h	; 9e01  ...@` ..p...p. @
	defb 001h,0e3h,0a0h,0e2h,050h,0a0h,050h,0e1h,000h,020h,0e2h,0a0h,001h,070h,0e1h,000h	; 9e11  ....P.P.. ...p..
	defb 0e2h,070h,0d5h,0e1h,040h,050h,060h,0e0h,000h,070h,0c1h,0f7h,013h,070h,0c1h,0f6h	; 9e21  .p..@P`..p...p..
	defb 013h,070h,0c1h,0f5h,013h,070h,0c1h,0f3h,013h,070h,0c0h,0feh,0feh,057h,09dh,0efh	; 9e31  .p...p...p...W..
	defb 0d7h,0fbh,024h,0e3h,001h,001h,001h,0e4h,000h,000h,0a2h,0a0h,030h,030h,080h,030h	; 9e41  ..$.........00.0
	defb 0e4h,081h,081h,081h,0e5h,080h,080h,0e4h,0a2h,0a0h,0fbh,015h,050h,040h,050h,0b0h	; 9e51  ............P@P.
	defb 0fbh,025h,0e3h,001h,001h,001h,0e4h,000h,000h,0a2h,0a0h,0fah,026h,030h,030h,080h	; 9e61  .%..........&00.
	defb 030h,0fbh,025h,0e4h,081h,081h,081h,0e5h,080h,080h,0e4h,0a2h,0a0h,0fah,016h,050h	; 9e71  0.%............P
	defb 040h,050h,0b0h,0d7h,0fbh,025h,0e3h,001h,001h,001h,0e4h,000h,000h,0a2h,0a0h,0fah	; 9e81  @P...%..........
	defb 026h,030h,030h,080h,030h,0fbh,025h,0e4h,081h,081h,081h,0e5h,080h,080h,0e4h,0a2h	; 9e91  &00.0.%.........
	defb 0a0h,0fah,026h,050h,040h,050h,0b0h,0feh,00bh,084h,09eh,0fbh,025h,0e3h,021h,021h	; 9ea1  ..&P@P......%.!!
	defb 021h,0e4h,020h,020h,0e3h,002h,000h,0fah,026h,0e4h,050h,050h,0a0h,050h,0fbh,025h	; 9eb1  !.  ....&.PP.P.%
	defb 0e4h,0a1h,0a1h,0a1h,0e5h,0a0h,0a0h,0e3h,002h,000h,0fah,026h,0e4h,070h,060h,070h	; 9ec1  ...........&.p`p
	defb 0e3h,000h,0fbh,025h,0e3h,021h,021h,021h,0e4h,020h,020h,0e3h,002h,000h,0fah,026h	; 9ed1  ...%.!!!.  ....&
	defb 0e4h,050h,050h,0a0h,050h,0fbh,025h,0e4h,0a1h,0a1h,0a1h,0e5h,0a0h,0a0h,0e3h,002h	; 9ee1  .PP.P.%.........
	defb 000h,0d5h,0fbh,026h,0e4h,070h,090h,0a0h,0e3h,000h,050h,0c1h,0f9h,025h,050h,0c1h	; 9ef1  ...&.p....P..%P.
	defb 0f7h,025h,050h,0c1h,0f5h,025h,050h,0c1h,0f3h,025h,050h,0c0h,0feh,0feh,084h,09eh	; 9f01  .%P..%P..%P.....
	defb 0feh,000h,022h,002h,090h,024h,080h,024h,070h,024h,020h,001h,0feh,000h,0d7h,0ebh	; 9f11  .."..$.$p$ .....
	defb 060h,0feh,000h,022h,002h,090h,028h,080h,028h,070h,028h,020h,001h,0feh,000h,0d7h	; 9f21  `.."..(.(p( ....
	defb 0ebh,050h,0feh,000h,022h,002h,090h,02dh,080h,02dh,070h,02dh,020h,001h,0feh,000h	; 9f31  .P.."..-.-p- ...
	defb 0d7h,0ebh,030h,010h,0feh,000h,022h,002h,090h,036h,080h,036h,070h,036h,020h,001h	; 9f41  ..0..."..6.6p6 .
	defb 022h,002h,090h,039h,080h,039h,070h,039h,020h,001h,022h,002h,090h,03ch,080h,03ch	; 9f51  "..9.9p9 ."..<.<
	defb 070h,03ch,020h,001h,022h,002h,090h,040h,080h,040h,070h,040h,020h,001h,022h,002h	; 9f61  p< ."..@.@p@ .".
	defb 090h,043h,080h,043h,070h,043h,020h,001h,022h,002h,090h,047h,080h,047h,070h,047h	; 9f71  .C.CpC ."..G.GpG
	defb 020h,001h,022h,002h,090h,04ch,080h,04ch,070h,04ch,020h,001h,022h,002h,090h,050h	; 9f81   ."..L.LpL ."..P
	defb 080h,050h,070h,050h,020h,001h,022h,002h,090h,055h,080h,055h,070h,055h,020h,001h	; 9f91  .PpP ."..U.UpU .
	defb 0feh,000h,0d3h,0e9h,070h,070h,070h,073h,0d7h,060h,060h,060h,060h,060h,080h,080h	; 9fa1  ....ppps.`````..
	defb 080h,080h,090h,090h,090h,090h,000h,000h,000h,000h,040h,000h,080h,081h,000h,000h	; 9fb1  ..........@.....
	defb 000h,040h,000h,000h,000h,0feh,002h,0b7h,09fh,0d7h,0e9h,071h,051h,061h,050h,051h	; 9fc1  .@.........qQaPQ
	defb 000h,000h,000h,040h,000h,000h,000h,000h,000h,000h,000h,040h,000h,080h,081h,000h	; 9fd1  ...@.......@....
	defb 000h,000h,040h,000h,000h,000h,0feh,009h,0d8h,09fh,071h,051h,061h,050h,051h,000h	; 9fe1  ..@.......qQaPQ.
	defb 000h,000h,040h,000h,000h,000h,000h,000h,000h,000h,040h,000h,080h,081h,000h	; 9ff1  ..@.......@....
