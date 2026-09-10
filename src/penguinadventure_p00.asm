; ==========================================================================
; PENGUIN ADVENTURE / YUME TAIRIKU ADVENTURE - Konami (1986) - MSX1 - MegaROM RC-743 de 128 KB (Konami4) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS cabecera: Cabecera de cartucho de MSX: "AB", INIT = 0x406A, y las
;   otras tres entradas (STATEMENT, DEVICE, TEXT) a cero, mas seis bytes
;   reservados. Sin STATEMENT no hay ninguna orden nueva de BASIC: este
;   cartucho arranca y ya esta.
;   0x4000..0x4010  (16 bytes)

; ----------------------------------------------------------------------
; LAS DOS CABECERAS DEL CARTUCHO
; ----------------------------------------------------------------------
DATA_cabecera:
	defb 041h,042h	; 4000
	defw 0406ah	; 4002  -> init
	defw 00000h	; 4004
	defw 00000h	; 4006
	defw 00000h	; 4008
	defb 000h,000h,000h,000h,000h,000h	; 400a

; ----------------------------------------------------------------------
; DATOS gm_marca: La marca del formato: "CD" en ASCII (43 44). Es lo que el
;   Game Master busca para saber que este cartucho trae la cabecera larga; los
;   de 1985 traen "AB", que son 19 bytes y sin banderas.
;   0x4010..0x4012  (2 bytes)
DATA_gm_marca:
	defb 043h,044h	; 4010

; ----------------------------------------------------------------------
; DATOS gm_catalogo: El numero de catalogo en BCD y por la cifra alta primero:
;   07 43, o sea RC-743. Es la SEGUNDA vez que el cartucho dice su numero: la
;   otra esta escondida al final del banco 3.
;   0x4012..0x4014  (2 bytes)
DATA_gm_catalogo:
	defb 007h,043h	; 4012

; ----------------------------------------------------------------------
; DATOS gm_banderas: 0x60: que campos vienen detras. Se leen del bit 0 al 7
;   con `rra` y el bit CLARO significa "este campo viene en el flujo"; el
;   puesto deja el valor por defecto que el Game Master trae en su 0x6034. Los
;   bits 5 y 6 estan a uno.
;   0x4014..0x4015  (1 bytes)
DATA_gm_banderas:
	defb 060h	; 4014

; ----------------------------------------------------------------------
; DATOS gm_campos: Los seis campos que anuncia el byte de banderas, en el
;   orden de los bits: 0xE000 (la variable de fase, que el Game Master guarda
;   en su 0xD304) y el 0x04 que va con ella; 0xE092 (0xD30A) y el 0x0D de
;   detras, que es lo que el cartucho le DICE al Game Master que tiene: trece
;   fases (0xD313, de donde saca entre cuanto dividir). El juego tiene
;   veinticuatro, asi que o el Game Master solo sabe llegar a la trece o esa
;   cifra esta puesta a la ligera; 0xE090 (0xD308); 0xE083 (0xD30C, los datos
;   del juego); 0xE086 (0xD30E, el marcador); y el ultimo, 0x40F7, que NO es
;   una variable sino la RUTINA de este mismo banco a la que el Game Master
;   salta por CALSLT.
;   0x4015..0x4023  (14 bytes)
DATA_gm_campos:
	defw 0e000h	; 4015
	defb 004h	; 4017
	defw 0e092h	; 4018
	defb 00dh	; 401a
	defw 0e090h	; 401b
	defw 0e083h	; 401d
	defw 0e086h	; 401f
	defw 040f7h	; 4021  -> arranca_en_la_fase_pedida

; ======================================================================
; CODIGO 0x4023..0x4120  (253 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; LA INTERRUPCION. Cuelga de H.KEYI (0xFD9A), no de H.TIMI: la instala INIT en 0x40A5 escribiendo un 0xC3 en 0xFD9A y esta direccion en 0xFD9B. Ese `ld (0xFD9B),hl` es, ademas, la instruccion por la que el Game Master reconoce a los cartuchos de Konami.
; ----------------------------------------------------------------------
interrupcion:
	call 0013eh		;4023   ; BIOS RDVDP - Reads VDP status register | lo primero, leer el estado del VDP: eso es lo que baja la linea de interrupcion
	di			;4026   ; y a partir de aqui se toca el mapper, asi que nadie mas puede entrar
	ld a,00eh		;4027   ; el banco 14 a 0x8000 y el 15 a 0xA000: los dos del sonido
	ld (08000h),a		;4029   ; SIN tocar la copia en RAM de 0xF0F2/0xF0F3, que es lo que permite devolverlos luego
	inc a			;402c
	ld (0a000h),a		;402d   ; y su pareja en 0xA000, que son los datos del reproductor
	call 08082h		;4030   ; el reproductor de sonido, que vive en el banco 14
	di			;4033   ; al volver, otra vez con el mapper en la mano
	ld a,(0f0f2h)		;4034   ; y se devuelven las ranuras leyendo la copia en RAM: ahi esta lo que hubiera antes
	ld (08000h),a		;4037
	ld a,(0f0f3h)		;403a   ; lo mismo para 0xA000
	ld (0a000h),a		;403d
	ld hl,0e005h		;4040   ; el semaforo de reentrada
	bit 0,(hl)		;4043   ; si el bit 0 esta puesto es que el cuadro anterior sigue dentro
	jr nz,interrupcion_sale		;4045   ; y entonces esta pasada se limita al sonido y se va
	inc (hl)			;4047   ; si no, se marca ocupado
	ei			;4048   ; y desde aqui SI se admiten interrupciones: el sonido no puede quedarse callado por mucho que tarde el cuadro
	call lee_los_mandos		;4049   ; la parte del cuadro que vive en el banco fijo
	call 08000h		;404c   ; y la que vive en el banco que haya en 0x8000, que es el modulo que este mandando ahora
	xor a			;404f   ; ocupado a cero
	ld (0e005h),a		;4050   ; el semaforo de reentrada de la interrupcion
interrupcion_sale:
	ei			;4053
	ret			;4054

; ----------------------------------------------------------------------
; SUMAR UN INDICE A UN PUNTERO. Tres puertas de la misma rutina, y estan aqui, en el banco fijo, porque las usa todo el cartucho. Son la forma de la casa de recorrer una tabla: en vez de `ld c,a / ld b,0 / add hl,bc`, que gasta dos registros, se suma A al byte bajo y se arrastra el acarreo al alto.
; ----------------------------------------------------------------------
dos_por_a_mas_hl:		; Entra doblando A: para tablas de PALABRAS.
	add a,a			;4055   ; A por dos, y sigue de largo a la de abajo
a_mas_hl:		; HL = HL + A, con A sin signo.
	add a,l			;4056   ; suma al byte bajo
	ld l,a			;4057
	ret nc			;4058   ; si no hubo acarreo ya esta
	inc h			;4059   ; y si lo hubo, una al alto
	ret			;405a
a_mas_de:		; Lo mismo para DE.
	add a,e			;405b   ; la misma cuenta sobre DE
	ld e,a			;405c
	ret nc			;405d
	inc d			;405e
	ret			;405f

; ----------------------------------------------------------------------
; EL DESPACHADOR DE LA CASA. El truco de Konami para escribir una maquina de estados sin gastar una tabla con nombre: se llama con el numero de estado en A y la tabla de destinos va pegada JUSTO DETRAS del `call`, de modo que la direccion de vuelta que hay en la pila ES la base de la tabla. Nunca vuelve: salta al destino, y el `ret` de ese destino devuelve a quien llamo al que llamo.
; ----------------------------------------------------------------------
despacha:
	pop hl			;4060   ; la direccion de vuelta, que es donde empieza la tabla
	add a,a			;4061   ; dos bytes por entrada
	call a_mas_hl		;4062   ; HL = base + 2*A
	ld e,(hl)			;4065   ; y se lee la palabra que hay ahi
	inc hl			;4066
	ld d,(hl)			;4067
	ex de,hl			;4068   ; al par que sabe saltar
	jp (hl)			;4069   ; y alla va, sin dejar rastro en la pila

; ----------------------------------------------------------------------
; INIT. La direccion que la BIOS saca de la cabecera "AB" y a la que llama al encender, con la ranura de este cartucho ya conectada en la pagina 1. Hace, por este orden: repartir los bancos, buscar donde hay RAM, colgarse de la interrupcion, borrar la RAM entera y arrancar el juego.
; ----------------------------------------------------------------------
init:
	di			;406a   ; antes de tocar el mapper
	im 1		;406b   ; modo 1 de interrupcion: el vector es 0x0038, que es de la ROM de la BIOS
	di			;406d
	push hl			;406e   ; HL hace de puntero a la copia en RAM mientras se reparte
	ld hl,0f0f1h		;406f   ; 0xF0F1, 0xF0F2 y 0xF0F3: una copia por ranura
	ld a,001h		;4072   ; el trio 1-2-3
	ld (06000h),a		;4074   ; el 1 a 0x6000
	ld (hl),a			;4077   ; y apuntado en 0xF0F1
	inc a			;4078   ; el 2
	ld (08000h),a		;4079   ; a 0x8000
	inc hl			;407c
	ld (hl),a			;407d
	inc a			;407e   ; el 3
	ld (0a000h),a		;407f   ; a 0xA000, y con esto los 24 KB de 0x6000 a 0xBFFF quedan puestos
	inc hl			;4082
	ld (hl),a			;4083
	pop hl			;4084
	ei			;4085
	call 00138h		;4086   ; BIOS RSLREG - Reads the primary slot register | BIOS RSLREG: el registro de ranuras primarias
	rrca			;4089   ; se queda con los dos bits de la pagina 3, que es donde hay RAM seguro
	rrca			;408a
	and 003h		;408b
	ld c,a			;408d
	ld hl,0fcc1h		;408e   ; la tabla de expansion de ranuras de la BIOS
	add a,l			;4091
	ld l,a			;4092
	ld a,(hl)			;4093
	and 080h		;4094   ; el bit 7 dice si esa ranura primaria esta expandida
	or c			;4096
	ld c,a			;4097
	inc l			;4098
	inc l			;4099
	inc l			;409a
	inc l			;409b
	ld a,(hl)			;409c   ; y los dos bits de la subranura de la pagina 3
	and 00ch		;409d
	or c			;409f
	ld h,080h		;40a0   ; H = 0x80: la pagina 2, que es la que se va a conectar
	call 00024h		;40a2   ; BIOS ENASLT - Switches to specified slot and page definitively | BIOS ENASLT: mete en la pagina 2 la misma ranura donde esta la RAM
	ld a,0c3h		;40a5   ; el 0xC3 de un `jp`
	ld (0fd9ah),a		;40a7   ; en H.KEYI, el gancho que la BIOS ejecuta en cada interrupcion
	ld hl,interrupcion		;40aa   ; y detras la direccion del manejador
	ld (0fd9bh),hl		;40ad
	ld hl,0e000h		;40b0   ; borrar la RAM del juego de un tiron
	ld de,0e001h		;40b3
	ld bc,010efh		;40b6   ; 0x10EF bytes: de 0xE000 a 0xF0F0 inclusive
	xor a			;40b9
	ld (hl),a			;40ba
	ldir		;40bb
	ld (0f0f7h),a		;40bd   ; y una bandera mas, ya fuera del bloque
	ex de,hl			;40c0   ; DE quedo apuntando al final del borrado
	ld sp,hl			;40c1   ; y ahi mismo se planta la pila
	ld hl,0f0f1h		;40c2   ; ahora las copias del mapper, que estan por debajo de la pila
	ld de,0f0f2h		;40c5
	ld bc,0000fh		;40c8   ; quince bytes desde 0xF0F1
	ld (hl),a			;40cb
	ldir		;40cc
	inc a			;40ce   ; A = 1
	ld (0e005h),a		;40cf   ; el semaforo a ocupado: mientras dure el arranque, la interrupcion solo hara sonido
	call arranca		;40d2   ; el arranque de verdad
	xor a			;40d5
	ld (0e005h),a		;40d6   ; y se suelta el semaforo
	call 0013eh		;40d9   ; BIOS RDVDP - Reads VDP status register | BIOS RDVDP, para no comerse la interrupcion pendiente
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
; LA RUTINA QUE LLAMA EL OTRO CARTUCHO. No la llama ni una instruccion de este cartucho: es la que anuncia el ultimo campo de la cabecera de 0x4010, y el Konami Game Master salta aqui por CALSLT despues de que el usuario haya pedido empezar en una fase concreta. Que es suya lo dice la primera instruccion: lee 0xD31A, que es RAM del Game Master -donde apunta la fase pedida-, y ahi un dato de este juego no tendria nada que hacer.
; ----------------------------------------------------------------------
arranca_en_la_fase_pedida:
	ld a,(0d31ah)		;40f7   ; la fase que ha pedido el usuario en el MODIFY MODE del Game Master
	and a			;40fa   ; si es cero es que no ha pedido ninguna
	jr nz,L_4101		;40fb
	inc a			;40fd   ; y entonces se empieza por la primera
	ld (0e092h),a		;40fe   ; la FASE, de 1 a 13
L_4101:
	ld a,(0e092h)		;4101   ; y con la fase en la mano se sacan las dos cosas que dependen de ella (OJO: estas dos tablas solo cubren las trece primeras de las veinticuatro)
	dec a			;4104   ; las tablas van desde 1, no desde 0
	ld hl,04120h		;4105   ; la primera tabla
	call a_mas_hl		;4108   ; HL = 0x4120 + fase - 1
	ld a,(hl)			;410b   ; el numero de fase tal como se pinta
	ld (0e091h),a		;410c   ; el numero de fase tal como se pinta
	ld a,(0e092h)		;410f   ; otra vez la fase
	dec a			;4112
	ld hl,0412dh		;4113   ; y la segunda tabla
	call a_mas_hl		;4116
	ld a,(hl)			;4119
	ld (0e093h),a		;411a   ; el decorado que le toca a esa fase
	jp monta_la_fase_desde_el_decorado		;411d   ; y a montar la fase

; ----------------------------------------------------------------------
; DATOS numero_de_fase_pintado: Trece bytes con el numero de fase tal como
;   sale en pantalla: 01..09 y luego 10, 11, 12 y 13, en BCD. Trece es justo
;   lo que la cabecera de 0x4010 le declara al Game Master en su 0xD313... **y
;   el juego tiene VEINTICUATRO**: p02:8328 sube (0xE092) y la compara con
;   0x19, y las tres tablas de guion de fase -0xA8FB en el banco 9, 0x8000 en
;   el 10 y 0xACBA en el 13- tienen veinticuatro entradas justas. O sea que
;   esta tabla, y la de al lado, solo valen para las trece primeras: son las
;   que usa el cartucho de trucos, no el juego.
;   0x4120..0x412d  (13 bytes)
DATA_numero_de_fase_pintado:
	defb 001h,002h,003h,004h,005h,006h,007h,008h,009h,010h,011h,012h,013h	; 4120  .............

; ----------------------------------------------------------------------
; DATOS decorado_de_cada_fase: Trece bytes mas, con los valores 1, 2 y 3 dando
;   vueltas. Es lo que 0x411A guarda en 0xE093, y en el juego lo lleva
;   p02:831D subiendolo de uno en uno y volviendo a 1 al pasar de 3.
;   0x412d..0x413a  (13 bytes)
DATA_decorado_de_cada_fase:
	defb 001h,002h,003h,001h,002h,003h,001h,002h,003h,001h,002h,003h,001h	; 412d  .............

; ======================================================================
; CODIGO 0x413a..0x422f  (245 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; PEDIR SONIDO. La otra puerta del banco 14, la que no es la interrupcion: se llama con el numero de efecto en A. Como puede llegar desde cualquier sitio, con cualquier reparto de bancos puesto, guarda las ranuras en una SEGUNDA copia -0xF0F4 y 0xF0F5- antes de meter el 14 y el 15, y las devuelve al salir. Esa segunda copia no la usa nadie mas en todo el cartucho.
; ----------------------------------------------------------------------
pide_sonido_si_esta_activo:
	di			;413a   ; mientras se toca el mapper no entra nadie
	push hl			;413b
	ld hl,0e002h		;413c   ; las banderas de la partida
	bit 6,(hl)		;413f   ; el bit 6 dice si el sonido esta encendido
	jr z,pide_sonido_sale		;4141   ; y si no lo esta, ni se molesta
	jr L_4147		;4143
pide_sonido:		; La misma rutina saltandose la comprobacion del bit 6.
	di			;4145   ; esta puerta suena pase lo que pase
	push hl			;4146
L_4147:
	push de			;4147   ; se salva todo, que esto entra desde cualquier parte
	push bc			;4148
	push ix		;4149
	push iy		;414b
	push af			;414d
	ld a,(0f0f2h)		;414e   ; la SEGUNDA copia: lo que hubiera en 0x8000...
	ld (0f0f4h),a		;4151   ; la segunda copia del banco de 0x8000, la del sonido
	ld a,(0f0f3h)		;4154   ; ...y en 0xA000
	ld (0f0f5h),a		;4157   ; la segunda copia del banco de 0xA000, la del sonido
	ld a,00eh		;415a   ; el 14, que es el reproductor
	ld (08000h),a		;415c   ; a 0x8000, y ahora si tocando la copia de siempre
	ld (0f0f2h),a		;415f   ; la copia en RAM del banco de 0x8000
	ld a,00fh		;4162   ; el 15, sus datos
	ld (0a000h),a		;4164
	ld (0f0f3h),a		;4167   ; la copia en RAM del banco de 0xA000
	pop af			;416a   ; A vuelve a llevar el numero de efecto
	push af			;416b
	call 086bah		;416c   ; la puerta del reproductor para los efectos
	di			;416f
	ld a,(0f0f4h)		;4170   ; y a devolver las ranuras desde la segunda copia
	ld (08000h),a		;4173
	ld (0f0f2h),a		;4176   ; la copia en RAM del banco de 0x8000
	ld a,(0f0f5h)		;4179   ; la segunda copia del banco de 0xA000, la del sonido
	ld (0a000h),a		;417c
	ld (0f0f3h),a		;417f   ; la copia en RAM del banco de 0xA000
	pop af			;4182
	pop iy		;4183
	pop ix		;4185
	pop bc			;4187
	pop de			;4188
pide_sonido_sale:
	pop hl			;4189
	ei			;418a
	ret			;418b

; ----------------------------------------------------------------------
; EL DESCOMPRESOR. Es el lector al que se le pasa en HL un puntero a los bancos de datos, y el que explica por que los bancos 12 y 13 no llevan ni una instruccion: el patron de todo el cartucho es mapearlos, hacer `ld hl,<direccion suya>` y llamar aqui. El guion trae su propio destino, asi que una sola llamada puede llenar varios sitios de la VRAM o de la RAM.
; EL FORMATO, que sale de las cinco instrucciones de 0x4190: una palabra con el destino y detras una tira de mandos de un byte. 0x00 acaba. 0x80 justo, vuelve a leer otra palabra de destino y sigue. Con el bit 7 PUESTO, los siete de abajo son cuantos bytes van copiados tal cual. Con el bit 7 CLARO, son cuantas veces se repite el byte que viene detras.
; ----------------------------------------------------------------------
descomprime:
	ld e,(hl)			;418c   ; los dos primeros bytes del guion son el destino
	inc hl			;418d
	ld d,(hl)			;418e
	inc hl			;418f
L_4190:
	ld a,(hl)			;4190   ; el mando
	and a			;4191   ; el cero cierra el guion
	ret z			;4192
	inc hl			;4193   ; y si no, se pasa al argumento
	ld b,a			;4194   ; B se queda con el byte entero
	and 07fh		;4195   ; y A sin el bit 7
	cp b			;4197   ; si no ha cambiado nada es que el bit 7 estaba claro
	jr z,descomprime_repite		;4198   ; y eso es una repeticion
	and a			;419a   ; con el bit 7 puesto y el resto a cero -o sea, 0x80- se empieza otro bloque
	jr z,descomprime		;419b
	ld b,000h		;419d   ; los siete bits de abajo son la cuenta
	ld c,a			;419f
	ldir		;41a0   ; y se copian tal cual
	jr L_4190		;41a2   ; a por el mando siguiente
descomprime_repite:
	ld a,(hl)			;41a4   ; el byte que hay que repetir
	inc hl			;41a5
L_41A6:
	ld (de),a			;41a6   ; B veces, que es la cuenta con el bit 7 ya claro
	inc de			;41a7
	djnz L_41A6		;41a8
	jr L_4190		;41aa   ; y vuelta al guion
rellena_de_unos_otro_bloque:
	inc hl			;41ac

; ----------------------------------------------------------------------
; RELLENAR DE UNOS. La misma forma de guion -palabra de destino y tira de bytes-, pero aqui el byte que se lee NO se escribe: sea el que sea, lo que cae en el destino es un 0x01. Lo unico que decide es cuantos. Cierran 0xFF, y 0xFE empieza otro bloque con otro destino.
; ----------------------------------------------------------------------
rellena_de_unos:
	ld e,(hl)			;41ad   ; el destino
	inc hl			;41ae
	ld d,(hl)			;41af
	inc hl			;41b0
L_41B1:
	ld a,(hl)			;41b1   ; el byte del guion
	inc a			;41b2   ; 0xFF acaba
	ret z			;41b3
	inc a			;41b4   ; 0xFE, otro bloque
	jr z,rellena_de_unos_otro_bloque		;41b5
	ld a,001h		;41b7   ; y para todo lo demas, un uno
	ld (de),a			;41b9
	inc de			;41ba
	inc hl			;41bb   ; del guion solo se cuenta la longitud
	jr L_41B1		;41bc
copia_bloques_otro_bloque:
	inc hl			;41be

; ----------------------------------------------------------------------
; COPIAR TAL CUAL. La tercera puerta y la mas sencilla: destino en la palabra de delante y detras los bytes, sin comprimir nada. 0xFF acaba y 0xFE abre otro bloque.
; ----------------------------------------------------------------------
copia_bloques:
	ld e,(hl)			;41bf   ; el destino
	inc hl			;41c0
	ld d,(hl)			;41c1
	inc hl			;41c2
L_41C3:
	ld a,(hl)			;41c3   ; el byte
	inc a			;41c4   ; 0xFF acaba
	ret z			;41c5
	inc a			;41c6   ; 0xFE, otro bloque
	jr z,copia_bloques_otro_bloque		;41c7
	ldi		;41c9   ; y si no, se copia y se sigue
	jr L_41C3		;41cb

; ----------------------------------------------------------------------
; MEDIA VUELTA AL BANCO 4-5-6. Mete el trio 4-5-6, coge de la tabla de 0xBD89 -que cae en el banco 6- ocho bytes de patrones y ocho de colores, los suelta en la VRAM y devuelve el trio 1-2-3. C dice cual de las entradas, y cada una son ocho bytes: por eso el `add a,a` tres veces.
; ----------------------------------------------------------------------
trae_un_caracter_del_banco_6:
	di			;41cd   ; antes del mapper
	push hl			;41ce
	ld hl,0f0f1h		;41cf
	ld a,004h		;41d2   ; el trio 4-5-6 de una vez
	ld (06000h),a		;41d4
	ld (hl),a			;41d7   ; y apuntado en 0xF0F1, 0xF0F2 y 0xF0F3
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
	ld a,c			;41e6   ; C es cual de las entradas
	add a,a			;41e7   ; por ocho, que es lo que mide cada una
	add a,a			;41e8
	add a,a			;41e9
	push af			;41ea
	ld de,0bd89h		;41eb   ; la tabla de patrones, en el banco 6
	call a_mas_de		;41ee   ; DE = 0xBD89 + 8*C
	ld hl,03718h		;41f1   ; 0x3718: la ultima fila de la tabla de patrones
	ld bc,00008h		;41f4
	call copia_a_vram		;41f7   ; y para alla van los ocho bytes
	pop af			;41fa
	ld de,0bda9h		;41fb   ; la tabla de colores, veinte bytes mas abajo
	call a_mas_de		;41fe
	ld hl,01718h		;4201   ; 0x1718, que en este cartucho es zona de sprites
	ld bc,00008h		;4204
	call copia_a_vram		;4207
	di			;420a
	push hl			;420b
	ld hl,0f0f1h		;420c
	ld a,001h		;420f   ; y a devolver el trio 1-2-3
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
	ei			;4222   ; con las ranuras como estaban
	ret			;4223

; ----------------------------------------------------------------------
; BORRAR LA PANTALLA. Dos puertas: la de arriba borra la tabla de nombres entera y la de abajo se deja las dos primeras filas, que son el marcador.
; ----------------------------------------------------------------------
borra_la_pantalla_entera:
	call esconde_los_sprites		;4224
	ld hl,03800h		;4227   ; 0x3800, la tabla de nombres
	ld bc,00300h		;422a   ; las 768 casillas
	jr $+11		;422d

; ----------------------------------------------------------------------
; DATOS sin identificar  0x422f..0x4232  (3 bytes)
DATA_422F:
	defb 0cdh,0edh,042h	; 422f

; ======================================================================
; CODIGO 0x4232..0x44ae  (636 bytes)
; ======================================================================


borra_el_area_de_juego:
	ld hl,03860h		;4232   ; 0x3860 es la fila 3: las dos de arriba, que llevan el marcador, se quedan
	ld bc,002a0h		;4235   ; 672 casillas
borra_vram:
	xor a			;4238   ; con ceros
	jp 00056h		;4239   ; BIOS FILVRM - Fills VRAM with value | BIOS FILVRM
abre_para_escribir_y_da_el_puerto:
	call 00053h		;423c   ; BIOS SETWRT - Enables VDP to write | BIOS SETWRT deja el VDP apuntando donde diga HL
	ld a,(00007h)		;423f   ; el puerto de datos del VDP sale de la tabla de la BIOS, en 0x0007
	ld c,a			;4242   ; y se devuelve en C, listo para un `outi`
	ret			;4243
lee_puntero:
	ex de,hl			;4244   ; HL trae la direccion de un puntero
	ld e,(hl)			;4245   ; se lee la palabra que hay ahi
	inc hl			;4246
	ld d,(hl)			;4247
	ex de,hl			;4248
	inc de			;4249   ; y DE queda apuntando al byte siguiente
	ret			;424a

; ----------------------------------------------------------------------
; LOS TRES VOLCADOS. La pantalla se monta en RAM y se sube de golpe con `outi`, que es la unica forma de llenar la VRAM a la velocidad de un cuadro. Las tres puertas se diferencian solo en tres cosas -donde de la VRAM, de que buffer de RAM y cuantas filas- y caen todas en el mismo bucle de 0x4270.
; OJO CON LA CUENTA DEL BUCLE: `ld b,d` entra con 0x40, pero cada vuelta baja B DOS veces -una el `outi`, que es "saca y decrementa", y otra el `djnz`-, asi que salen 32 bytes por vuelta y no 64. Y 32 es justo el ancho de una fila. Con eso las tres puertas cuadran al byte: la de arriba sube dos filas, la de en medio dieciseis y la de abajo veintiuna.
; DE AHI SALE EL ESPEJO ENTERO. La RAM de 0xEBA0 a 0xEEFF es copia exacta de la VRAM de 0x3820 a 0x3B7F, con 0x4C80 de diferencia: 0xEBA0 es la fila 1 de la pantalla, 0xEBE0 la 3 -donde empieza la zona de juego, y donde el banco 1 descomprime sus 672 bytes de decorado- y 0xEE80 la tabla de atributos de los sprites.
; ----------------------------------------------------------------------
sube_el_marcador:
	ld hl,03820h		;424b   ; 0x3820: la segunda fila de la tabla de nombres
	call abre_para_escribir_y_da_el_puerto		;424e   ; deja el VDP apuntando ahi y devuelve el puerto en C
	ld hl,0eba0h		;4251   ; el buffer de RAM del marcador
	ld a,002h		;4254   ; dos filas: 0x3820 y 0x3840
	jr sube_filas		;4256
sube_la_mitad_de_abajo:
	ld hl,03900h		;4258   ; 0x3900, ya dentro de la pantalla
	call abre_para_escribir_y_da_el_puerto		;425b
	ld hl,0ec80h		;425e   ; su buffer
	ld a,010h		;4261   ; dieciseis filas, de la 8 a la 23
	jr sube_filas		;4263
sube_el_area_de_juego:
	ld hl,03860h		;4265   ; 0x3860, que es la fila 3: el marcador de arriba no se toca
	call abre_para_escribir_y_da_el_puerto		;4268
	ld hl,0ebe0h		;426b   ; el buffer grande
	ld a,015h		;426e   ; veintiuna filas, de la 3 a la 23: la zona de juego entera
sube_filas:
	ld d,040h		;4270   ; 0x40, que con las DOS bajadas de B por vuelta son 32 bytes: una fila
sube_filas_otra:
	ld b,d			;4272   ; y B se recarga en cada fila
L_4273:
	outi		;4273   ; saca un byte y baja B; el `djnz` de abajo lo baja otra vez
	djnz L_4273		;4275
	dec a			;4277   ; una fila menos
	jr nz,sube_filas_otra		;4278
	ret			;427a

; ----------------------------------------------------------------------
; BORRAR EL AREA DE JUEGO EN LA VRAM. La misma geometria que el volcado de 0x4265 pero escribiendo ceros y con el bloque de 0x20: veintiuna filas de treinta y dos casillas desde la fila 3, que son las 672 de la zona de juego.
; ----------------------------------------------------------------------
borra_el_area_de_juego_en_vram:
	ld hl,03860h		;427b   ; la fila 3
	call abre_para_escribir_y_da_el_puerto		;427e
	xor a			;4281   ; con ceros
	ld d,015h		;4282   ; veintiuna filas
L_4284:
	ld b,020h		;4284   ; de treinta y dos casillas
L_4286:
	out (c),a		;4286   ; al puerto de datos del VDP
	nop			;4288   ; el respiro que el VDP necesita entre dos escrituras seguidas
	djnz L_4286		;4289
	dec d			;428b   ; una fila menos
	jr nz,L_4284		;428c
	ret			;428e
copia_a_vram:
	ex de,hl			;428f   ; LDIRVM quiere el origen en HL y el destino en DE, y aqui llegan al reves
	jp 0005ch		;4290   ; BIOS LDIRVM - Block transfers to VRAM from memory | BIOS LDIRVM

; ----------------------------------------------------------------------
; LLENAR LAS TRES TERCERAS PARTES. En modo 2 la pantalla son tres bloques de 2 KB que se pintan por separado, y casi todo lo que se hace hay que hacerlo tres veces. Esta rutina llena el mismo trozo en los tres, saltando de 0x800 en 0x800.
; ----------------------------------------------------------------------
llena_los_tres_tercios:
	ld d,003h		;4293   ; tres bloques
llena_los_tres_tercios_vuelta:
	push bc			;4295
	push de			;4296
	call 00056h		;4297   ; BIOS FILVRM - Fills VRAM with value | BIOS FILVRM llena el trozo de este bloque
	ld de,00800h		;429a   ; y el siguiente esta 2 KB mas arriba
	add hl,de			;429d
	pop de			;429e
	pop bc			;429f
	dec d			;42a0   ; un bloque menos
	jr nz,llena_los_tres_tercios_vuelta		;42a1
	ret			;42a3

; ----------------------------------------------------------------------
; PINTAR EN LOS TRES BLOQUES. Lo mismo pero llamando al pintor de 0x4386, y con C diciendo si se pintan colores o patrones. Entre bloque y bloque se suman 0x800 a H, que es lo que separa un tercio del siguiente.
; ----------------------------------------------------------------------
pinta_en_los_tres_con_color:
	ld c,001h		;42a4   ; C = 1
	jr pinta_en_los_tres_bucle		;42a6
pinta_en_los_tres:
	ld c,000h		;42a8   ; C = 0
pinta_en_los_tres_bucle:
	ld b,003h		;42aa   ; los tres bloques de 2 KB
pinta_en_los_tres_vuelta:
	push bc			;42ac
	push de			;42ad
	push hl			;42ae
	call pinta		;42af   ; el pintor
	pop hl			;42b2
	ld a,008h		;42b3   ; 0x800 al byte alto es saltar al tercio siguiente
	add a,h			;42b5
	ld h,a			;42b6
	pop de			;42b7
	pop bc			;42b8
	djnz pinta_en_los_tres_vuelta		;42b9
	ret			;42bb

; ----------------------------------------------------------------------
; ESCRIBIR UN GUION EN LA VRAM CON MASCARA. Recorre un guion de bytes -destino en la palabra de delante, 0xFF acaba, 0xFE abre otro bloque- y va escribiendo en la VRAM uno a uno. Lo que la hace util dos veces es C: entra a 0xFF y entonces los bytes pasan tal cual, o entra a 0x00 desde otra puerta y entonces todo lo que sale son ceros, o sea que el mismo guion sirve para pintar y para borrar.
; ----------------------------------------------------------------------
pinta_guion_con_mascara:
	ld c,0ffh		;42bc   ; mascara abierta: los bytes pasan como estan
pinta_guion_lee_destino:
	call lee_puntero		;42be   ; la palabra de destino
pinta_guion_bucle:
	ld a,(de)			;42c1   ; el byte del guion
	inc de			;42c2
	ld b,a			;42c3   ; B se queda con el original
	inc b			;42c4   ; 0xFF acaba
	ret z			;42c5
	inc b			;42c6   ; 0xFE, otro bloque
	jr z,pinta_guion_lee_destino		;42c7
	and c			;42c9   ; y aqui la mascara: con C a cero sale un cero
	call 0004dh		;42ca   ; BIOS WRTVRM - Writes data in VRAM | BIOS WRTVRM
	inc hl			;42cd   ; la casilla siguiente
	jr pinta_guion_bucle		;42ce

; ----------------------------------------------------------------------
; ESCONDER SPRITES. La tabla de atributos vive en 0xEE80 de la RAM -treinta y dos sprites de cuatro bytes: Y, X, patron y color- y se sube entera a 0x3B00 de la VRAM. Meter 0xE0 en la Y de un sprite es la forma de la casa de quitarlo de en medio sin borrar nada: el VDP no pinta nada por debajo de esa linea. Las dos puertas se diferencian solo en desde cual empiezan.
; ----------------------------------------------------------------------
esconde_los_sprites_de_arriba:
	ld a,0e0h		;42d0   ; 0xE0 en la Y saca el sprite de la pantalla
	ld hl,0ee90h		;42d2   ; desde el sprite 4
	ld b,01ch		;42d5   ; y los veintiocho que quedan
esconde_los_sprites_vuelta:
	ld (hl),a			;42d7
	inc l			;42d8   ; de cuatro en cuatro, que es lo que mide cada sprite
	inc l			;42d9
	inc l			;42da
	inc l			;42db
	djnz esconde_los_sprites_vuelta		;42dc
	ret			;42de
L_42DF:
	call esconde_los_sprites_de_arriba		;42df
	call 07dd5h		;42e2
	jp sube_los_sprites_desde_arriba		;42e5
L_42E8:
	call esconde_los_sprites_de_arriba		;42e8
	jr sube_los_sprites		;42eb
esconde_los_sprites:
	ld hl,0ee80h		;42ed   ; desde el primero
	ld b,020h		;42f0   ; los treinta y dos
	ld a,0e0h		;42f2   ; con la Y fuera de la pantalla
esconde_todos_vuelta:
	ld (hl),a			;42f4
	inc l			;42f5
	inc l			;42f6
	inc l			;42f7
	inc l			;42f8
	djnz esconde_todos_vuelta		;42f9

; ----------------------------------------------------------------------
; SUBIR LOS SPRITES, ROTANDO CUAL VA PRIMERO. El VDP del MSX1 solo pinta cuatro sprites por linea y descarta los demas por orden de tabla, asi que el que este siempre el ultimo desaparece siempre. La solucion de la casa es no subir la tabla del tiron: se parte en trozos y se sube desplazada, de modo que el que hoy va el primero manana va el ultimo y el parpadeo se reparte. Cuanto se desplaza lo dice (0xE203).
; ----------------------------------------------------------------------
sube_los_sprites:
	ld a,(0e203h)		;42fb   ; por donde va la rotacion
	cp 004h		;42fe   ; en el 4 se reparte de otra manera
	jr z,sube_los_sprites_rotado_4		;4300
	ld hl,03b00h		;4302   ; la tabla de atributos, en la VRAM
	ld de,0ee80h		;4305   ; y su copia en RAM
	ld bc,00080h		;4308   ; los 128 bytes de los treinta y dos sprites
	jp copia_a_vram		;430b
sube_los_sprites_rotado_4:
	ld hl,03b00h		;430e   ; los ocho primeros bytes salen de 0xEE90
	ld de,0ee90h		;4311
	ld bc,00008h		;4314
	call copia_a_vram		;4317
	ld hl,03b08h		;431a   ; y detras van los de 0xEE80
	ld de,0ee80h		;431d
	ld bc,00010h		;4320
	call copia_a_vram		;4323
	ld hl,03b18h		;4326   ; y el resto sigue en orden
	ld de,0ee98h		;4329
	ld bc,00068h		;432c
	jp copia_a_vram		;432f
sube_los_sprites_desde_arriba:
	ld a,(0e203h)		;4332   ; la misma rotacion, pero para la otra mitad de la tabla
	cp 010h		;4335   ; en el 16 se reparte de otra manera
	jr z,sube_los_sprites_rotado_16		;4337
	ld hl,03b00h		;4339   ; los 32 primeros bytes desde 0xEEE0
	ld de,0eee0h		;433c
	ld bc,00020h		;433f
	call copia_a_vram		;4342
	ld hl,03b20h		;4345   ; y los 96 de detras desde 0xEE80
	ld de,0ee80h		;4348
	ld bc,00060h		;434b
	jp copia_a_vram		;434e
sube_los_sprites_rotado_16:
	ld hl,03b00h		;4351   ; igual, pero partido en cuatro trozos
	ld de,0eee0h		;4354
	ld bc,00020h		;4357
	call copia_a_vram		;435a
	ld hl,03b20h		;435d
	ld de,0ee98h		;4360   ; cuatro bytes: un solo sprite
	ld bc,00004h		;4363
	call copia_a_vram		;4366
	ld hl,03b24h		;4369
	ld de,0ee80h		;436c
	ld bc,00018h		;436f   ; seis sprites
	call copia_a_vram		;4372
	ld hl,03b3ch		;4375
	ld de,0ee9ch		;4378
	ld bc,00044h		;437b   ; y los diecisiete que quedan
	jp copia_a_vram		;437e

; ----------------------------------------------------------------------
; EL PINTOR. El mismo formato comprimido que el descompresor de 0x418C -bit 7 puesto son bytes tal cual, bit 7 claro es repetir, 0x00 acaba y 0x80 abre otro bloque-, pero en vez de escribir en la RAM escribe en el puerto del VDP, sin volver a decirle la direccion en cada byte. Y hay un paso mas por medio: cada byte pasa por 0x43F9 antes de salir, que es donde se le mete el color.
; ----------------------------------------------------------------------
pinta_sin_color:
	ld c,000h		;4381   ; sin color
	call lee_puntero		;4383   ; el destino
pinta:
	call 00053h		;4386   ; BIOS SETWRT - Enables VDP to write | BIOS SETWRT: a partir de aqui el VDP escribe solo
	exx			;4389   ; el juego de registros de repuesto se queda con el puerto
	ld a,(00007h)		;438a   ; el puerto de datos, de la tabla de la BIOS
	ld c,a			;438d
	exx			;438e
pinta_bucle:
	ld a,(de)			;438f   ; el mando
	and a			;4390   ; el cero cierra
	ret z			;4391
	inc de			;4392
	ld b,a			;4393   ; B con el original
	and 07fh		;4394   ; y A sin el bit 7
	cp b			;4396   ; iguales quiere decir bit 7 claro
	jr z,pinta_repetido		;4397   ; y eso es repetir
	and a			;4399   ; el 0x80 pelado abre otro bloque
	jr z,pinta_sin_color		;439a
	ld b,a			;439c   ; la cuenta de bytes literales
pinta_literales:
	call prepara_el_byte		;439d   ; el byte, ya con su color
	exx			;43a0
	out (c),a		;43a1   ; y directo al VDP
	exx			;43a3
	djnz pinta_literales		;43a4
	jr pinta_bucle		;43a6
pinta_repetido:
	call prepara_el_byte		;43a8   ; el byte que se repite
pinta_repetido_vuelta:
	exx			;43ab
	out (c),a		;43ac   ; B veces al VDP
	exx			;43ae
	djnz pinta_repetido_vuelta		;43af
	jr pinta_bucle		;43b1

; ----------------------------------------------------------------------
; PINTAR UN BLOQUE, Y OPCIONALMENTE ESPEJADO. El otro pintor: en vez de un guion comprimido lleva bytes sin comprimir y los sube de dieciseis en dieciseis, que es la altura de un caracter doble. El bit 0 de H manda: si esta puesto, cada columna se pinta DOS veces -la segunda dada la vuelta por 0x4402- y asi una figura simetrica se guarda a la mitad de tamano. Es de donde sale que en la ROM haya media nave, medio coche o medio lo que sea.
; ----------------------------------------------------------------------
pinta_bloque:
	call lee_puntero		;43b3   ; el destino
	call 00053h		;43b6   ; BIOS SETWRT - Enables VDP to write | BIOS SETWRT
	ld h,c			;43b9   ; H se queda con las banderas y L con la cuenta de columnas
	ld l,b			;43ba
	ld a,(00007h)		;43bb   ; el puerto de datos
	ld c,a			;43be
pinta_bloque_columna:
	push de			;43bf
	xor a			;43c0   ; sin espejo
	call pinta_columna		;43c1   ; dieciseis bytes: una columna entera
	bit 0,h		;43c4   ; y si el bit 0 de H esta puesto, hay espejo
	jr z,pinta_bloque_segunda_mitad		;43c6
	push de			;43c8   ; la misma columna otra vez
	xor a			;43c9
	call pinta_columna		;43ca
	pop de			;43cd
	ld a,001h		;43ce   ; pero esta con los bits del reves
	call pinta_columna		;43d0
pinta_bloque_segunda_mitad:
	pop de			;43d3
	ld a,001h		;43d4   ; la segunda mitad, espejada
	call pinta_columna		;43d6
	bit 0,h		;43d9   ; con espejo, el origen no avanza igual
	jr z,pinta_bloque_siguiente		;43db
	ld a,010h		;43dd   ; dieciseis bytes de salto
	call a_mas_de		;43df
pinta_bloque_siguiente:
	dec l			;43e2   ; una columna menos
	jr nz,pinta_bloque_columna		;43e3
	ret			;43e5
pinta_columna:
	push hl			;43e6
	ld b,010h		;43e7   ; dieciseis bytes, que es lo que mide una columna de caracter doble
	ld h,a			;43e9   ; H lleva la bandera de espejo de esta pasada
pinta_columna_bucle:
	push hl			;43ea
	ld a,(de)			;43eb   ; el byte
	bit 0,h		;43ec   ; si toca espejo...
	call nz,da_la_vuelta_al_byte		;43ee   ; ...se le da la vuelta a los ocho bits
	inc de			;43f1
	out (c),a		;43f2   ; y al VDP
	pop hl			;43f4
	djnz pinta_columna_bucle		;43f5
	pop hl			;43f7
	ret			;43f8

; ----------------------------------------------------------------------
; EL BYTE, ANTES DE SALIR. Por aqui pasa cada byte que el pintor de 0x4386 manda a la VRAM, y C dice que hacerle: con el bit 7 puesto se le cambian los colores por la tabla de 0x440D, con el bit 0 puesto se le da la vuelta, y sin nada sale tal cual. Que la misma rutina sirva para patrones y para colores es lo que permite que un solo guion pinte las dos cosas.
; ----------------------------------------------------------------------
prepara_el_byte:
	ld a,(de)			;43f9   ; el byte del guion
	inc de			;43fa
	bit 7,c		;43fb   ; bit 7 de C: cambiar colores
	jr nz,cambia_los_colores		;43fd
	bit 0,c		;43ff   ; bit 0 de C: espejo
	ret z			;4401   ; y si no, tal cual

; ----------------------------------------------------------------------
; DAR LA VUELTA A LOS OCHO BITS. Un caracter espejado es el mismo byte leido del reves, y esto es la forma corta de hacerlo: ocho veces sacar el bit de abajo de L y meterlo por arriba de A. B se salva en H porque el bucle lo gasta.
; ----------------------------------------------------------------------
da_la_vuelta_al_byte:
	ld h,b			;4402   ; B a salvo, que el bucle lo usa de cuenta
	ld l,a			;4403   ; el byte que hay que dar la vuelta
	ld b,008h		;4404   ; ocho bits
L_4406:
	rr l		;4406   ; el de abajo sale al acarreo
	rla			;4408   ; y entra por arriba de A
	djnz L_4406		;4409
	ld b,h			;440b   ; B como estaba
	ret			;440c

; ----------------------------------------------------------------------
; CAMBIAR LOS COLORES DE UN BYTE. En modo 2 cada byte de la tabla de colores lleva dos: el de la tinta en el nibble alto y el del fondo en el bajo. Aqui se cambian los dos por separado, cada uno contra su tabla de seis parejas en RAM -0xE4EC para el nibble bajo y 0xE4E0 para el alto-, con la primera de cada pareja de "si es este color" y la segunda de "pon este otro". Seis parejas es el tope, y las comparaciones estan desplegadas una a una, sin bucle, porque esto pasa por cada byte de la pantalla.
; ----------------------------------------------------------------------
cambia_los_colores:
	ld ix,0e4e0h		;440d   ; la tabla del nibble ALTO, la tinta
	ld iy,0e4ech		;4411   ; y la del BAJO, el fondo
	ld h,a			;4415   ; H se queda con el byte entero
	and 00fh		;4416   ; y A con el nibble de abajo
	cp (iy+000h)		;4418   ; primera pareja
	ld l,(iy+001h)		;441b   ; su color de repuesto
	jr z,cambia_el_nibble_bajo		;441e
	cp (iy+002h)		;4420   ; segunda
	ld l,(iy+003h)		;4423
	jr z,cambia_el_nibble_bajo		;4426
	cp (iy+004h)		;4428   ; tercera
	ld l,(iy+005h)		;442b
	jr z,cambia_el_nibble_bajo		;442e
	cp (iy+006h)		;4430   ; cuarta
	ld l,(iy+007h)		;4433
	jr z,cambia_el_nibble_bajo		;4436
	cp (iy+008h)		;4438   ; quinta
	ld l,(iy+009h)		;443b
	jr z,cambia_el_nibble_bajo		;443e
	cp (iy+00ah)		;4440   ; y sexta, que es la ultima
	ld l,(iy+00bh)		;4443
	jr nz,cambia_el_nibble_alto		;4446
cambia_el_nibble_bajo:
	ld a,h			;4448   ; el byte entero
	and 0f0h		;4449   ; se le quita el nibble de abajo
	or l			;444b   ; y se le mete el nuevo
	ld h,a			;444c
cambia_el_nibble_alto:
	ld a,h			;444d   ; ahora el de arriba
	and 0f0h		;444e
	cp (ix+000h)		;4450   ; las seis parejas otra vez, contra la otra tabla
	ld l,(ix+001h)		;4453
	jr z,cambia_el_nibble_alto_hecho		;4456
	cp (ix+002h)		;4458
	ld l,(ix+003h)		;445b
	jr z,cambia_el_nibble_alto_hecho		;445e
	cp (ix+004h)		;4460
	ld l,(ix+005h)		;4463
	jr z,cambia_el_nibble_alto_hecho		;4466
	cp (ix+006h)		;4468
	ld l,(ix+007h)		;446b
	jr z,cambia_el_nibble_alto_hecho		;446e
	cp (ix+008h)		;4470
	ld l,(ix+009h)		;4473
	jr z,cambia_el_nibble_alto_hecho		;4476
	cp (ix+00ah)		;4478
	ld l,(ix+00bh)		;447b
	ld a,h			;447e   ; si ninguna casa, el byte se queda como esta
	ret nz			;447f
cambia_el_nibble_alto_hecho:
	ld a,h			;4480   ; se conserva el nibble de abajo, que ya esta cambiado
	and 00fh		;4481
	or l			;4483   ; y se le mete la tinta nueva
	ret			;4484

; ----------------------------------------------------------------------
; ARRANQUE. Lo llama INIT con el semaforo puesto. Calla el PSG, programa los ocho registros del VDP y borra los 16 KB de VRAM.
; ----------------------------------------------------------------------
arranca:
	ld a,0bfh		;4485   ; 0xBF en el registro 7 del PSG: los tres canales de tono callados y el ruido tambien
	ld (0e079h),a		;4487   ; y apuntado en RAM, que es de donde sale luego
	ld e,a			;448a
	ld a,007h		;448b   ; registro 7 del PSG
	call 00093h		;448d   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,0cbh		;4490   ; el efecto 0xCB
	call pide_sonido		;4492
	xor a			;4495   ; llenar la VRAM de ceros
	ld l,a			;4496
	ld h,a			;4497
	ld c,a			;4498
	ld b,040h		;4499   ; 0x4000 bytes: los 16 KB enteros
	call 00056h		;449b   ; BIOS FILVRM - Fills VRAM with value
programa_el_vdp:
	ld hl,044aeh		;449e   ; la tabla de ocho valores
	ld c,008h		;44a1   ; se recorren del registro 7 al 0
L_44A3:
	ld a,c			;44a3
	and a			;44a4
	ret z			;44a5
	dec c			;44a6   ; C es el numero de registro, y baja antes de escribir
	ld b,(hl)			;44a7   ; el valor
	call 00047h		;44a8   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;44ab
	jr L_44A3		;44ac

; ----------------------------------------------------------------------
; DATOS registros_del_vdp: Los ocho valores del VDP, y van del registro 7 al
;   0, no al reves. De ahi sale el mapa de la VRAM entero, que en este
;   cartucho esta del reves de lo habitual: R7=0xE4 borde, R6=0x03 patrones de
;   sprite en 0x1800, R5=0x76 atributos de sprite en 0x3B00, R4=0x07 tabla de
;   patrones en 0x2000-0x37FF, R3=0x7F tabla de COLORES en 0x0000-0x17FF con
;   la mascara abierta, R2=0x0E tabla de nombres en 0x3800, R1=0xE2 pantalla
;   encendida con interrupcion y sprites de 16x16, R0=0x02 modo 2. Ojo con R3
;   y R4: no son una direccion, son base y mascara.
;   0x44ae..0x44b6  (8 bytes)
DATA_registros_del_vdp:
	defb 0e4h,003h,076h,007h,07fh,00eh,0e2h,002h	; 44ae  ..v.....

; ======================================================================
; CODIGO 0x44b6..0x4a89  (1491 bytes)
; ======================================================================


escribe_el_registro_7:
	ld c,007h		;44b6   ; el registro del color de borde
	jp 00047h		;44b8   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; LEER LOS MANDOS. La llama la interrupcion antes que nada. Junta en un solo byte el joystick del puerto 1 y las teclas que hacen lo mismo, y ademas saca aparte cuales se acaban de pulsar en ESTE cuadro, que es lo que hace falta para que un disparo no se repita solo mientras el boton siga hundido.
; ----------------------------------------------------------------------
lee_los_mandos:
	call lee_el_estado_de_los_mandos		;44bb   ; primero el estado de ahora
guarda_lo_que_se_acaba_de_pulsar:
	ld hl,0e007h		;44be   ; el estado del cuadro anterior
	ld c,(hl)			;44c1   ; C se queda con el viejo
	ld (hl),a			;44c2   ; y en su sitio va el nuevo
	xor c			;44c3   ; los bits que han CAMBIADO
	and (hl)			;44c4   ; y de esos, los que ahora estan puestos: los recien pulsados
	dec hl			;44c5
	ld (hl),a			;44c6   ; que se guardan en 0xE006
	ret			;44c7
lee_el_estado_de_los_mandos:
	ld e,08fh		;44c8   ; 0x8F en el registro 15 del PSG: el puerto 1 a leer y el 2 a escribir
	ld a,00fh		;44ca   ; registro 15
	call 00093h		;44cc   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;44cf   ; registro 14, que es por donde entra el joystick
	di			;44d1   ; leer el PSG no admite que nadie se meta por medio
	call 00096h		;44d2   ; BIOS RDPSG - Reads value from PSG-register | BIOS RDPSG
	ei			;44d5
	cpl			;44d6   ; en el joystick el cero es pulsado, asi que se le da la vuelta
	and 03fh		;44d7   ; y se queda con los seis bits que valen: cuatro direcciones y dos botones
	push af			;44d9   ; a la pila mientras se mira el teclado
	ld a,008h		;44da   ; fila 8 de la matriz: ahi estan las cuatro flechas y la barra
	call 00141h		;44dc   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | BIOS SNSMAT
	cpl			;44df   ; tambien al reves
	rrca			;44e0   ; y a colocar cada tecla en el bit que le toca en el byte del joystick
	rrca			;44e1
	ld b,a			;44e2
	and 004h		;44e3   ; arriba
	ld e,a			;44e5
	ld a,b			;44e6
	rrca			;44e7
	rrca			;44e8
	ld b,a			;44e9
	and 018h		;44ea   ; izquierda y abajo
	or e			;44ec
	ld e,a			;44ed
	ld a,b			;44ee
	rrca			;44ef
	and 003h		;44f0   ; derecha
	or e			;44f2
	ld e,a			;44f3
	ld a,006h		;44f4   ; fila 6: ahi esta la de disparo
	call 00141h		;44f6   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | BIOS SNSMAT
	cpl			;44f9
	rlca			;44fa
	rlca			;44fb
	and 080h		;44fc   ; al bit 7
	or e			;44fe
	ld e,a			;44ff
	ld a,004h		;4500   ; fila 4
	call 00141h		;4502   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4505
	rlca			;4506
	rlca			;4507
	rlca			;4508
	and 020h		;4509   ; al bit 5
	or e			;450b
	ld e,a			;450c
	ld a,007h		;450d   ; fila 7
	call 00141h		;450f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | BIOS SNSMAT
	cpl			;4512
	rrca			;4513
	rrca			;4514
	rrca			;4515
	and 040h		;4516   ; al bit 6
	or e			;4518
	pop bc			;4519   ; y el joystick, que esperaba en la pila
	or b			;451a   ; todo junto: da igual con que se juegue
	ret			;451b

; ----------------------------------------------------------------------
; EL CUADRO. Lo que la interrupcion llama despues de los mandos, y es donde se ve el reparto del cartucho: casi todas las llamadas de aqui se van al banco 1 (0x6xxx), al 2 (0x8xxx-0x9xxx) o al 3 (0xAxxx-0xBxxx), que son los tres que estan puestos mientras se juega. Este banco solo pone el orden.
; ----------------------------------------------------------------------
cuadro:
	call sube_los_sprites		;451c   ; lo primero, subir los sprites: eso tiene que caer dentro del borrado de pantalla
	ld a,(0e0dch)		;451f   ; el contador de la pausa que se hace al perder o al cambiar de fase
	and a			;4522   ; con el a cero se juega normal
	jr nz,cuadro_en_pausa		;4523
	call sube_el_area_de_juego		;4525   ; y se sube el area de juego
	jr cuadro_llama_a_los_modulos		;4528
cuadro_en_pausa:
	dec a			;452a   ; la pausa se acorta un cuadro
	ld (0e0dch),a		;452b   ; la pausa que se hace al perder o al cambiar de fase
	ld a,(0e1f1h)		;452e   ; si esta a cero, hay que retocar dos sprites
	and a			;4531
	jr nz,cuadro_pausa_sprites		;4532
	ld a,004h		;4534   ; el patron 4
	ld hl,03b07h		;4536   ; en el atributo del sprite 1
	call 0004dh		;4539   ; BIOS WRTVRM - Writes data in VRAM
	ld a,004h		;453c
	ld hl,03b0bh		;453e   ; y del 2
	call 0004dh		;4541   ; BIOS WRTVRM - Writes data in VRAM
cuadro_pausa_sprites:
	ld a,005h		;4544   ; el patron 5
	ld hl,03b4bh		;4546   ; en el sprite 18
	call 0004dh		;4549   ; BIOS WRTVRM - Writes data in VRAM
	ld a,005h		;454c
	ld hl,03b4fh		;454e   ; y en el 19
	call 0004dh		;4551   ; BIOS WRTVRM - Writes data in VRAM
	call borra_el_area_de_juego_en_vram		;4554   ; y la zona de juego se borra en vez de subirse
cuadro_llama_a_los_modulos:
	call 066dah		;4557   ; banco 1
	call 091adh		;455a   ; banco 2
	call L_5F77		;455d   ; y una de este mismo banco
	call 064f0h		;4560   ; banco 1
	call 07e47h		;4563   ; banco 1
	ld a,(0e0a2h)		;4566   ; el modo en el que esta el juego
	and a			;4569
	jr nz,L_4578		;456a
	ld a,(0e002h)		;456c   ; las banderas de la partida
	and 040h		;456f   ; el bit 6 es el sonido
	jr z,cuadro_sigue		;4571
	call 09471h		;4573   ; banco 2
	jr cuadro_sigue		;4576
L_4578:
	call 09440h		;4578   ; banco 2, la otra rama
cuadro_sigue:
	call 06799h		;457b   ; banco 1
	call 068cah		;457e   ; banco 1
	call 06aa8h		;4581   ; banco 1
	ld a,(0e096h)		;4584   ; la bandera que corta el cuadro por la mitad
	rra			;4587   ; el bit 0 al acarreo
	ret c			;4588   ; y si esta puesto, hasta aqui llega este cuadro
	call 0921bh		;4589   ; banco 2
	ld a,(0e002h)		;458c
	and 040h		;458f
	jr z,L_4596		;4591
	call 09469h		;4593
L_4596:
	call 0be41h		;4596   ; banco 3
	call 096f9h		;4599   ; banco 2
	call 0929fh		;459c   ; banco 2
	call 0a985h		;459f   ; banco 3
	ld a,(0e0a2h)		;45a2   ; otra vez el modo
	dec a			;45a5
	jr z,cuadro_ultima_tanda		;45a6
	call 0bd8ah		;45a8   ; banco 3
	call 0bdcah		;45ab   ; banco 3
	call 07b44h		;45ae   ; banco 1
cuadro_ultima_tanda:
	call 0baceh		;45b1   ; banco 3
	call 0b4ebh		;45b4   ; banco 3
	call 0b52eh		;45b7   ; banco 3
	call 0bb2bh		;45ba   ; banco 3
	call 0bb75h		;45bd   ; banco 3
	call 0b8abh		;45c0   ; banco 3
	call 0bf32h		;45c3   ; banco 3
	call 0bf72h		;45c6   ; banco 3

; ----------------------------------------------------------------------
; EL SEGUNDO TRIO DEL CUADRO. Aqui esta la prueba de que el banco 9 lleva codigo y no datos: se mete el trio 7-8-9 y se llama derecho a 0xA83F, 0xB616 y 0xBBA1, que caen dentro de el. Es el unico momento del cuadro en que los bancos 1, 2 y 3 no estan puestos, y por eso al acabar se devuelven en 0x4600 antes de seguir.
; ----------------------------------------------------------------------
	di			;45c9   ; y a partir de aqui se cambia de trio
	push hl			;45ca
	ld hl,0f0f1h		;45cb
	ld a,007h		;45ce   ; el trio 7-8-9
	ld (06000h),a		;45d0   ; el 7 a 0x6000
	ld (hl),a			;45d3
	inc a			;45d4
	ld (08000h),a		;45d5   ; el 8 a 0x8000
	inc hl			;45d8
	ld (hl),a			;45d9
	inc a			;45da
	ld (0a000h),a		;45db   ; y el 9 a 0xA000
	inc hl			;45de
	ld (hl),a			;45df
	pop hl			;45e0
	ei			;45e1
	ld a,(0e0a5h)		;45e2   ; el mismo modo que miraba antes
	and a			;45e5
	jr nz,cuadro_banco_9		;45e6
	call 0a83fh		;45e8   ; banco 9
	call 0b616h		;45eb   ; banco 9
	call 0bba1h		;45ee   ; banco 9
cuadro_banco_9:
	call 0a92bh		;45f1   ; banco 9
	call 0aa18h		;45f4   ; banco 9
	call 0a9e9h		;45f7   ; banco 9
	call 0abc3h		;45fa   ; banco 9
	call 0ac52h		;45fd   ; banco 9
	di			;4600
	push hl			;4601
	ld hl,0f0f1h		;4602
	ld a,001h		;4605   ; y de vuelta al trio 1-2-3
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
	call 0bc1bh		;4619   ; banco 3
	call 0bca0h		;461c   ; banco 3
	call 0bd53h		;461f   ; banco 3
	ld a,(0e097h)		;4622   ; la bandera que decide si hay que hacer la ultima tanda
	and a			;4625
	ret z			;4626   ; y si no, se acabo el cuadro
	call 0b2d9h		;4627   ; banco 3
	call 0b3a0h		;462a   ; banco 3
	call 07059h		;462d   ; banco 1
	call 0b3e4h		;4630   ; banco 3
	call 07531h		;4633   ; banco 1
	call 07625h		;4636   ; banco 1
	call 0b36bh		;4639   ; banco 3
	jp 07730h		;463c   ; y la ultima, ya sin volver

; ----------------------------------------------------------------------
; EMPEZAR UNA VIDA. Pone a cero los dos contadores del desplazamiento y saca de la pantalla los seis sprites de las tres parejas de 0xE3A0, 0xE3B0 y 0xE3C0, escribiendoles 0xE0 en la Y.
; ----------------------------------------------------------------------
empieza_una_vida:
	xor a			;463f   ; los contadores del desplazamiento a cero
	ld (0e201h),a		;4640
	ld (0e202h),a		;4643
	ld (0e10eh),a		;4646
	ld a,0e0h		;4649   ; 0xE0 en la Y: fuera de la pantalla
	ld (0e3a3h),a		;464b   ; la primera pareja
	ld (0e3a7h),a		;464e
	ld (0e3b3h),a		;4651   ; la segunda
	ld (0e3b7h),a		;4654
	ld (0e3c3h),a		;4657   ; y la tercera
	ld (0e3c7h),a		;465a
	jp 062a4h		;465d   ; y a montar lo que toque, en el banco 1

; ----------------------------------------------------------------------
; MONTAR UNA FASE. La rutina mas larga del banco, y se entiende de un vistazo: primero borra de un tiron los 2.479 bytes de 0xE1F0 y los 800 de 0xEBE0 -que son las variables de la fase y el buffer de pantalla-, luego apaga una veintena de banderas sueltas, y despues llama en fila a los que montan cada cosa. Es tambien donde acaba el callback del Game Master: cuando el otro cartucho pide empezar en la fase 7, la rutina de 0x40F7 termina saltando a 0x46E3, o sea a la ultima parte de esta.
; ----------------------------------------------------------------------
monta_la_fase:
	xor a			;4660   ; con ceros
	ld hl,0e1f0h		;4661   ; desde 0xE1F0
	ld de,0e1f1h		;4664
	ld bc,009afh		;4667   ; 2.479 bytes: todas las variables de la fase
	ld (hl),a			;466a
	ldir		;466b
	ld hl,0ebe0h		;466d   ; y el buffer grande de pantalla
	ld de,0ebe1h		;4670
	ld bc,00320h		;4673   ; 800 bytes
	ld (hl),a			;4676
	ldir		;4677
	ld (0e0a5h),a		;4679   ; el modo
	ld (0e0b6h),a		;467c   ; bandera
	ld (0e0d4h),a		;467f
	ld (0e166h),a		;4682
	ld (0e16ch),a		;4685
	ld (0e0bdh),a		;4688
	ld (0e0bbh),a		;468b   ; las diez de 0xE0BB a 0xE0C4, seguidas
	ld (0e0bch),a		;468e
	ld (0e0beh),a		;4691
	ld (0e0bfh),a		;4694
	ld (0e0c0h),a		;4697
	ld (0e0c1h),a		;469a
	ld (0e0c2h),a		;469d
	ld (0e0c3h),a		;46a0
	ld (0e0c4h),a		;46a3
	ld (0e0d7h),a		;46a6   ; y las cinco de 0xE0D7 a 0xE0DB
	ld (0e0d8h),a		;46a9
	ld (0e0d9h),a		;46ac
	ld (0e0dah),a		;46af
	ld (0e0dbh),a		;46b2
	ld (0e0a9h),a		;46b5
	ld (0e0dch),a		;46b8   ; la pausa
	ld c,006h		;46bb   ; el objeto 6
	call 0baa3h		;46bd   ; banco 3: soltarlo
	ld c,00ch		;46c0   ; y el 12
	call 0baa3h		;46c2
	ld a,(0e16ah)		;46c5   ; un objeto que se lleva de una fase a la siguiente
	and a			;46c8   ; si no queda ninguno, no hay nada que poner
	jr z,monta_la_fase_segundo_objeto		;46c9
	dec a			;46cb   ; se gasta uno
	ld (0e16ah),a		;46cc
	ld c,00ah		;46cf   ; el objeto 10
	call 0baa3h		;46d1
monta_la_fase_segundo_objeto:
	ld a,(0e16bh)		;46d4   ; y lo mismo con el otro
	and a			;46d7
	jr z,monta_la_fase_desde_el_decorado		;46d8
	dec a			;46da
	ld (0e16bh),a		;46db
	ld c,00bh		;46de   ; el objeto 11
	call 0baa3h		;46e0
monta_la_fase_desde_el_decorado:		; Aqui es donde entra el callback del Game Master (0x411D).
	call 061ffh		;46e3   ; banco 1
	call 0624ch		;46e6   ; banco 1
	call 062bch		;46e9   ; banco 1
	call 06737h		;46ec   ; banco 1
	call 062cbh		;46ef   ; banco 1
	call 06323h		;46f2   ; banco 1
	xor a			;46f5   ; con A a cero
	call 066edh		;46f6   ; banco 1
	call 063fdh		;46f9   ; banco 1
	call 063bch		;46fc   ; banco 1
	call 06370h		;46ff   ; banco 1
	call 0643fh		;4702   ; banco 1
	jp 0be00h		;4705   ; y la ultima, en el banco 3

; ----------------------------------------------------------------------
; REEMPEZAR SIN PERDER LA CUENTA. Casi igual que el borrado de arriba, pero mucho mas corto -527 bytes- y con una diferencia que lo explica todo: las tres cosas de 0xE300 se guardan en la pila antes de borrar y se devuelven despues. Eso es lo que sobrevive de una vida a la siguiente.
; ----------------------------------------------------------------------
reempieza:
	ld hl,(0e301h)		;4708   ; lo que hay que salvar
	ld a,(0e300h)		;470b   ; por que pareja del guion de la fase va
	push hl			;470e   ; a la pila, que ahora se borra por encima
	push af			;470f
	ld hl,0e1f0h		;4710   ; desde 0xE1F0
	ld de,0e1f1h		;4713
	ld bc,0020fh		;4716   ; 527 bytes
	xor a			;4719
	ld (hl),a			;471a
	ldir		;471b
	ld (0e0dch),a		;471d   ; la pausa tambien
	ld hl,0e500h		;4720   ; y quince bytes mas de 0xE500
	ld de,0e501h		;4723
	ld bc,0000fh		;4726
	ld (hl),a			;4729
	ldir		;472a
	pop af			;472c   ; y se devuelve lo salvado
	pop hl			;472d
	ld (0e301h),hl		;472e   ; lo andado en la fase
	ld (0e300h),a		;4731   ; por que pareja del guion de la fase va
	di			;4734
	ld a,00ah		;4735   ; el banco 10 a 0x8000
	ld (08000h),a		;4737
	ld (0f0f2h),a		;473a   ; la copia en RAM del banco de 0x8000
	ei			;473d
	di			;473e
	ld a,00bh		;473f   ; y el 11 a 0xA000
	ld (0a000h),a		;4741
	ld (0f0f3h),a		;4744   ; la copia en RAM del banco de 0xA000
	ei			;4747

; ----------------------------------------------------------------------
; LO QUE SE LLEVA DE UNA FASE A OTRA. Con los bancos 10 y 11 puestos, recorre las cinco ranuras de 0xE440 -dos bytes cada una- y, para las que llevan algo con el segundo byte por encima de 8, saca de las dos tablas encadenadas de 0x8682 el guion que hay que soltar. La rutina que lo suelta es la de rellenar de unos, o sea que lo que se escribe son marcas, no dibujos.
; ----------------------------------------------------------------------
reparte_lo_que_se_lleva:
	ld de,0e440h		;4748   ; las cinco ranuras
	ld c,005h		;474b   ; cinco
reparte_lo_que_se_lleva_vuelta:
	ld a,(de)			;474d   ; la ranura
	and a			;474e   ; vacia no hay nada que hacer
	ld a,010h		;474f   ; y se salta diez bytes
	jr z,reparte_salta		;4751
	inc e			;4753   ; el segundo byte de la ranura
	inc e			;4754
	ld a,(de)			;4755
	cp 008h		;4756   ; por debajo de ocho tampoco
	ld a,00eh		;4758   ; y entonces el salto es de catorce
	jr c,reparte_salta		;475a
	dec e			;475c
	push de			;475d   ; la ranura, a salvo
	ld a,(de)			;475e   ; el primer byte
	dec a			;475f
	ld hl,08682h		;4760   ; la tabla de tablas, en el banco 10
	call dos_por_a_mas_hl		;4763   ; dos bytes por entrada
	ld a,(hl)			;4766   ; y se lee el puntero a la tabla de dentro
	inc hl			;4767
	ld h,(hl)			;4768
	ld l,a			;4769
	inc e			;476a   ; ahora el segundo byte
	ld a,(de)			;476b
	dec a			;476c
	call dos_por_a_mas_hl		;476d   ; otro salto de dos bytes
	ld a,(hl)			;4770   ; y ya se tiene el guion
	inc hl			;4771
	ld h,(hl)			;4772
	ld l,a			;4773
	call rellena_de_unos		;4774   ; que son marcas, no dibujos
	pop de			;4777
	ex de,hl			;4778
	dec l			;4779   ; y detras se limpian dieciseis bytes
	ld b,010h		;477a
reparte_limpia_dieciseis:
	ld (hl),000h		;477c
	inc l			;477e
	djnz reparte_limpia_dieciseis		;477f
	ex de,hl			;4781
	jr reparte_siguiente		;4782
reparte_salta:
	add a,e			;4784   ; a la ranura siguiente
	ld e,a			;4785
reparte_siguiente:
	dec c			;4786   ; una ranura menos
	jr nz,reparte_lo_que_se_lleva_vuelta		;4787
	di			;4789
	ld a,002h		;478a   ; y a devolver el 2 y el 3
	ld (08000h),a		;478c
	ld (0f0f2h),a		;478f   ; la copia en RAM del banco de 0x8000
	ei			;4792
	di			;4793
	ld a,003h		;4794
	ld (0a000h),a		;4796
	ld (0f0f3h),a		;4799   ; la copia en RAM del banco de 0xA000
	ei			;479c

; ----------------------------------------------------------------------
; DE QUE TAMANO ES LA FASE. Mete los bancos 12 y 13 solo para leer cuatro bytes: la tabla de 0xACBA lleva una entrada por fase, indexada por (0xE092), y de ella salen los doce bits que van a 0xE08B. La rutina es un ejemplo limpio de lo que hacen los bancos 12 y 13 en este cartucho: se mapean, se lee y se devuelven, sin ejecutar en ellos ni una instruccion.
; ----------------------------------------------------------------------
lee_los_datos_de_la_fase:
	di			;479d
	ld a,00ch		;479e   ; el banco 12
	ld (08000h),a		;47a0
	ld (0f0f2h),a		;47a3   ; la copia en RAM del banco de 0x8000
	ei			;47a6
	di			;47a7
	ld a,00dh		;47a8   ; y el 13
	ld (0a000h),a		;47aa
	ld (0f0f3h),a		;47ad   ; la copia en RAM del banco de 0xA000
	ei			;47b0
	ld a,(0e092h)		;47b1   ; la FASE, que va de 1 a 13
	dec a			;47b4   ; las tablas empiezan en la 1
	ld l,a			;47b5
	ld h,000h		;47b6
	add hl,hl			;47b8   ; por cuatro, que es lo que mide cada entrada
	add hl,hl			;47b9
	ld de,0acbah		;47ba   ; la tabla, en el banco 13
	add hl,de			;47bd
	ld e,(hl)			;47be   ; el byte bajo
	inc hl			;47bf
	ld a,(hl)			;47c0   ; y del siguiente solo el nibble de abajo: son DOCE bits
	and 00fh		;47c1
	ld d,a			;47c3
	ld (0e08bh),de		;47c4   ; y de ahi sale el largo de la fase
	di			;47c8
	ld a,002h		;47c9   ; el 2 y el 3, de vuelta
	ld (08000h),a		;47cb
	ld (0f0f2h),a		;47ce   ; la copia en RAM del banco de 0x8000
	ei			;47d1
	di			;47d2
	ld a,003h		;47d3
	ld (0a000h),a		;47d5
	ld (0f0f3h),a		;47d8   ; la copia en RAM del banco de 0xA000
	ei			;47db
	call 0624ch		;47dc   ; banco 1
	jp 06323h		;47df   ; y la ultima, tambien en el banco 1

; ----------------------------------------------------------------------
; LOS PUENTES AL BANCO 4-5-6. De aqui al final del banco hay una fila larga de rutinas que se parecen todas: meter un trio, hacer una sola cosa con el, y devolver el 1-2-3. Son los puentes por los que el codigo del juego llega a los datos que no caben en su ventana, y estan aqui, en el banco fijo, porque son el unico sitio desde el que se puede cambiar de banco sin quedarse sin suelo.
; ----------------------------------------------------------------------
pinta_del_banco_6:
	di			;47e2   ; sin interrupciones mientras cambia el mapa
	push hl			;47e3   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;47e4   ; las tres copias, seguidas
	ld a,004h		;47e7   ; el trio 4-5-6
	ld (06000h),a		;47e9   ; el banco 4 a 0x6000
	ld (hl),a			;47ec   ; apuntado en 0xF0F1
	inc a			;47ed
	ld (08000h),a		;47ee   ; el banco 5 a 0x8000
	inc hl			;47f1   ; la copia siguiente
	ld (hl),a			;47f2   ; apuntado en 0xF0F2
	inc a			;47f3
	ld (0a000h),a		;47f4   ; el banco 6 a 0xA000
	inc hl			;47f7   ; la copia siguiente
	ld (hl),a			;47f8   ; apuntado en 0xF0F3
	pop hl			;47f9   ; HL, como estaba
	ei			;47fa   ; el mapa ya esta entero
	ld de,0b5b9h		;47fb   ; un guion del banco 6
	call pinta_sin_color		;47fe   ; al pintor
	di			;4801   ; sin interrupciones mientras cambia el mapa
	push hl			;4802   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4803   ; las tres copias, seguidas
	ld a,001h		;4806   ; y el 1-2-3 de vuelta
	ld (06000h),a		;4808   ; el banco 1 a 0x6000
	ld (hl),a			;480b   ; apuntado en 0xF0F1
	inc a			;480c
	ld (08000h),a		;480d   ; el banco 2 a 0x8000
	inc hl			;4810   ; la copia siguiente
	ld (hl),a			;4811   ; apuntado en 0xF0F2
	inc a			;4812
	ld (0a000h),a		;4813   ; el banco 3 a 0xA000
	inc hl			;4816   ; la copia siguiente
	ld (hl),a			;4817   ; apuntado en 0xF0F3
	pop hl			;4818   ; HL, como estaba
	ei			;4819   ; el mapa ya esta entero
	ret			;481a
L_481B:
	di			;481b   ; sin interrupciones mientras cambia el mapa
	push hl			;481c   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;481d   ; las tres copias, seguidas
	ld a,004h		;4820
	ld (06000h),a		;4822   ; el banco 4 a 0x6000
	ld (hl),a			;4825   ; apuntado en 0xF0F1
	inc a			;4826
	ld (08000h),a		;4827   ; el banco 5 a 0x8000
	inc hl			;482a   ; la copia siguiente
	ld (hl),a			;482b   ; apuntado en 0xF0F2
	inc a			;482c
	ld (0a000h),a		;482d   ; el banco 6 a 0xA000
	inc hl			;4830   ; la copia siguiente
	ld (hl),a			;4831   ; apuntado en 0xF0F3
	pop hl			;4832   ; HL, como estaba
	ei			;4833   ; el mapa ya esta entero
	ld de,0a77ah		;4834
	call pinta_sin_color		;4837   ; el guion 0xA77A del banco 6: 1136 bytes de patrones (0x2A00-0x2E6F)
	ld de,0aabbh		;483a
	ld hl,02e70h		;483d
	ld c,001h		;4840
	call pinta		;4842   ; el guion 0xAABB del banco 6: 40 bytes de patrones (0x2E70-0x2E97)
	ld de,0aba5h		;4845
	call pinta_sin_color		;4848   ; el guion 0xABA5 del banco 6: 1152 bytes de patrones (0x3200-0x367F)
	ld de,0af15h		;484b
	ld hl,03680h		;484e
	ld c,001h		;4851
	call pinta		;4853   ; el guion 0xAF15 del banco 6: 32 bytes de patrones (0x3680-0x369F)
	ld de,0aadbh		;4856
	call pinta_sin_color		;4859   ; el guion 0xAADB del banco 6: 1136 bytes de colores (0x0A00-0x0E6F)
	ld de,0ab93h		;485c
	ld hl,00e70h		;485f
	ld c,000h		;4862
	call pinta		;4864   ; el guion 0xAB93 del banco 6: 40 bytes de colores (0x0E70-0x0E97)
	ld de,0af34h		;4867
	call pinta_sin_color		;486a   ; el guion 0xAF34 del banco 6: 1152 bytes de colores (0x1200-0x167F)
	ld de,0b003h		;486d
	ld hl,01680h		;4870
	ld c,000h		;4873
	call pinta		;4875   ; el guion 0xB003 del banco 6: 32 bytes de colores (0x1680-0x169F)
	ld de,0b006h		;4878
	ld bc,00601h		;487b
	call pinta_bloque		;487e
	di			;4881   ; sin interrupciones mientras cambia el mapa
	push hl			;4882   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4883   ; las tres copias, seguidas
	ld a,001h		;4886
	ld (06000h),a		;4888   ; el banco 1 a 0x6000
	ld (hl),a			;488b   ; apuntado en 0xF0F1
	inc a			;488c
	ld (08000h),a		;488d   ; el banco 2 a 0x8000
	inc hl			;4890   ; la copia siguiente
	ld (hl),a			;4891   ; apuntado en 0xF0F2
	inc a			;4892
	ld (0a000h),a		;4893   ; el banco 3 a 0xA000
	inc hl			;4896   ; la copia siguiente
	ld (hl),a			;4897   ; apuntado en 0xF0F3
	pop hl			;4898   ; HL, como estaba
	ei			;4899   ; el mapa ya esta entero
	ld a,(0e0a0h)		;489a   ; la bandera de PAUSA
	and a			;489d
	ret z			;489e
	di			;489f   ; sin interrupciones mientras cambia el mapa
	push hl			;48a0   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;48a1   ; las tres copias, seguidas
	ld a,004h		;48a4
	ld (06000h),a		;48a6   ; el banco 4 a 0x6000
	ld (hl),a			;48a9   ; apuntado en 0xF0F1
	inc a			;48aa
	ld (08000h),a		;48ab   ; el banco 5 a 0x8000
	inc hl			;48ae   ; la copia siguiente
	ld (hl),a			;48af   ; apuntado en 0xF0F2
	inc a			;48b0
	ld (0a000h),a		;48b1   ; el banco 6 a 0xA000
	inc hl			;48b4   ; la copia siguiente
	ld (hl),a			;48b5   ; apuntado en 0xF0F3
	pop hl			;48b6   ; HL, como estaba
	ei			;48b7   ; el mapa ya esta entero
	ld de,0ba5ah		;48b8
	ld bc,01301h		;48bb
	call pinta_bloque		;48be
	jr L_48E2		;48c1
L_48C3:
	di			;48c3   ; sin interrupciones mientras cambia el mapa
	push hl			;48c4   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;48c5   ; las tres copias, seguidas
	ld a,004h		;48c8
	ld (06000h),a		;48ca   ; el banco 4 a 0x6000
	ld (hl),a			;48cd   ; apuntado en 0xF0F1
	inc a			;48ce
	ld (08000h),a		;48cf   ; el banco 5 a 0x8000
	inc hl			;48d2   ; la copia siguiente
	ld (hl),a			;48d3   ; apuntado en 0xF0F2
	inc a			;48d4
	ld (0a000h),a		;48d5   ; el banco 6 a 0xA000
	inc hl			;48d8   ; la copia siguiente
	ld (hl),a			;48d9   ; apuntado en 0xF0F3
	pop hl			;48da   ; HL, como estaba
	ei			;48db   ; el mapa ya esta entero
	ld de,08afbh		;48dc
	call pinta_sin_color		;48df   ; el guion 0x8AFB del banco 5: 6784 bytes de colores y patrones (0x0200-0x0407 0x0808-0x0C67 0x1008-0x16DF)
L_48E2:
	di			;48e2   ; sin interrupciones mientras cambia el mapa
	push hl			;48e3   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;48e4   ; las tres copias, seguidas
	ld a,001h		;48e7
	ld (06000h),a		;48e9   ; el banco 1 a 0x6000
	ld (hl),a			;48ec   ; apuntado en 0xF0F1
	inc a			;48ed
	ld (08000h),a		;48ee   ; el banco 2 a 0x8000
	inc hl			;48f1   ; la copia siguiente
	ld (hl),a			;48f2   ; apuntado en 0xF0F2
	inc a			;48f3
	ld (0a000h),a		;48f4   ; el banco 3 a 0xA000
	inc hl			;48f7   ; la copia siguiente
	ld (hl),a			;48f8   ; apuntado en 0xF0F3
	pop hl			;48f9   ; HL, como estaba
	ei			;48fa   ; el mapa ya esta entero
	ret			;48fb
L_48FC:
	di			;48fc   ; sin interrupciones mientras cambia el mapa
	push hl			;48fd   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;48fe   ; las tres copias, seguidas
	ld a,004h		;4901
	ld (06000h),a		;4903   ; el banco 4 a 0x6000
	ld (hl),a			;4906   ; apuntado en 0xF0F1
	inc a			;4907
	ld (08000h),a		;4908   ; el banco 5 a 0x8000
	inc hl			;490b   ; la copia siguiente
	ld (hl),a			;490c   ; apuntado en 0xF0F2
	inc a			;490d
	ld (0a000h),a		;490e   ; el banco 6 a 0xA000
	inc hl			;4911   ; la copia siguiente
	ld (hl),a			;4912   ; apuntado en 0xF0F3
	pop hl			;4913   ; HL, como estaba
	ei			;4914   ; el mapa ya esta entero
	ld de,09bb6h		;4915
	call pinta_sin_color		;4918   ; el guion 0x9BB6 del banco 5: 632 bytes de patrones (0x2200-0x2477)
	ld de,09d25h		;491b
	ld hl,02478h		;491e
	ld c,001h		;4921
	call pinta		;4923   ; el guion 0x9D25 del banco 5: 224 bytes de patrones (0x2478-0x2557)
	ld de,09dfah		;4926
	call pinta_sin_color		;4929   ; el guion 0x9DFA del banco 5: 1592 bytes de patrones (0x2808-0x2E3F)
	ld de,0a1e1h		;492c
	ld hl,02e40h		;492f
	ld c,001h		;4932
	call pinta		;4934   ; el guion 0xA1E1 del banco 6: 448 bytes de patrones (0x2E40-0x2FFF)
	ld de,0a52ch		;4937
	call pinta_sin_color		;493a   ; el guion 0xA52C del banco 6: 456 bytes de patrones (0x3008-0x31CF)
	ld de,0a575h		;493d
	ld hl,031d0h		;4940
	ld c,001h		;4943
	call pinta		;4945   ; el guion 0xA575 del banco 6: 368 bytes de patrones (0x31D0-0x333F)
	ld de,09de5h		;4948
	call pinta_sin_color		;494b   ; el guion 0x9DE5 del banco 5: 632 bytes de colores (0x0200-0x0477)
	ld de,09df1h		;494e
	ld hl,00478h		;4951
	ld c,000h		;4954
	call pinta		;4956   ; el guion 0x9DF1 del banco 5: 224 bytes de colores (0x0478-0x0557)
	ld de,0a387h		;4959
	call pinta_sin_color		;495c   ; el guion 0xA387 del banco 6: 1592 bytes de colores (0x0808-0x0E3F)
	ld de,0a4f6h		;495f
	ld hl,00e40h		;4962
	ld c,000h		;4965
	call pinta		;4967   ; el guion 0xA4F6 del banco 6: 448 bytes de colores (0x0E40-0x0FFF)
	ld de,0a6b7h		;496a
	call pinta_sin_color		;496d   ; el guion 0xA6B7 del banco 6: 456 bytes de colores (0x1008-0x11CF)
	ld de,0a6edh		;4970
	ld hl,011d0h		;4973
	ld c,000h		;4976
	call pinta		;4978   ; el guion 0xA6ED del banco 6: 368 bytes de colores (0x11D0-0x133F)
	di			;497b   ; sin interrupciones mientras cambia el mapa
	push hl			;497c   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;497d   ; las tres copias, seguidas
	ld a,001h		;4980
	ld (06000h),a		;4982   ; el banco 1 a 0x6000
	ld (hl),a			;4985   ; apuntado en 0xF0F1
	inc a			;4986
	ld (08000h),a		;4987   ; el banco 2 a 0x8000
	inc hl			;498a   ; la copia siguiente
	ld (hl),a			;498b   ; apuntado en 0xF0F2
	inc a			;498c
	ld (0a000h),a		;498d   ; el banco 3 a 0xA000
	inc hl			;4990   ; la copia siguiente
	ld (hl),a			;4991   ; apuntado en 0xF0F3
	pop hl			;4992   ; HL, como estaba
	ei			;4993   ; el mapa ya esta entero
	ret			;4994
L_4995:
	di			;4995   ; sin interrupciones mientras cambia el mapa
	push hl			;4996   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4997   ; las tres copias, seguidas
	ld a,004h		;499a
	ld (06000h),a		;499c   ; el banco 4 a 0x6000
	ld (hl),a			;499f   ; apuntado en 0xF0F1
	inc a			;49a0
	ld (08000h),a		;49a1   ; el banco 5 a 0x8000
	inc hl			;49a4   ; la copia siguiente
	ld (hl),a			;49a5   ; apuntado en 0xF0F2
	inc a			;49a6
	ld (0a000h),a		;49a7   ; el banco 6 a 0xA000
	inc hl			;49aa   ; la copia siguiente
	ld (hl),a			;49ab   ; apuntado en 0xF0F3
	pop hl			;49ac   ; HL, como estaba
	ei			;49ad   ; el mapa ya esta entero
	ld a,(0e0a1h)		;49ae   ; el DECORADO, de 0 a 9
	ld hl,04a89h		;49b1
	call a_mas_hl		;49b4
	ld a,(hl)			;49b7
	ld hl,00008h		;49b8
	ld bc,00008h		;49bb
	call 00056h		;49be   ; BIOS FILVRM - Fills VRAM with value
	ld hl,02200h		;49c1
	ld (0e4e0h),hl		;49c4   ; la tabla de cambio de color, nibble alto
	ld hl,00200h		;49c7
	ld (0e4e2h),hl		;49ca
	ld hl,04a93h		;49cd
	jr L_4A24		;49d0
L_49D2:
	di			;49d2   ; sin interrupciones mientras cambia el mapa
	push hl			;49d3   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;49d4   ; las tres copias, seguidas
	ld a,004h		;49d7
	ld (06000h),a		;49d9   ; el banco 4 a 0x6000
	ld (hl),a			;49dc   ; apuntado en 0xF0F1
	inc a			;49dd
	ld (08000h),a		;49de   ; el banco 5 a 0x8000
	inc hl			;49e1   ; la copia siguiente
	ld (hl),a			;49e2   ; apuntado en 0xF0F2
	inc a			;49e3
	ld (0a000h),a		;49e4   ; el banco 6 a 0xA000
	inc hl			;49e7   ; la copia siguiente
	ld (hl),a			;49e8   ; apuntado en 0xF0F3
	pop hl			;49e9   ; HL, como estaba
	ei			;49ea   ; el mapa ya esta entero
	ld hl,03008h		;49eb
	ld (0e4e0h),hl		;49ee   ; la tabla de cambio de color, nibble alto
	ld hl,01008h		;49f1
	ld (0e4e2h),hl		;49f4
	ld hl,04b5bh		;49f7
	jr L_4A24		;49fa
L_49FC:
	di			;49fc   ; sin interrupciones mientras cambia el mapa
	push hl			;49fd   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;49fe   ; las tres copias, seguidas
	ld a,004h		;4a01
	ld (06000h),a		;4a03   ; el banco 4 a 0x6000
	ld (hl),a			;4a06   ; apuntado en 0xF0F1
	inc a			;4a07
	ld (08000h),a		;4a08   ; el banco 5 a 0x8000
	inc hl			;4a0b   ; la copia siguiente
	ld (hl),a			;4a0c   ; apuntado en 0xF0F2
	inc a			;4a0d
	ld (0a000h),a		;4a0e   ; el banco 6 a 0xA000
	inc hl			;4a11   ; la copia siguiente
	ld (hl),a			;4a12   ; apuntado en 0xF0F3
	pop hl			;4a13   ; HL, como estaba
	ei			;4a14   ; el mapa ya esta entero
	ld hl,02808h		;4a15
	ld (0e4e0h),hl		;4a18   ; la tabla de cambio de color, nibble alto
	ld hl,00808h		;4a1b
	ld (0e4e2h),hl		;4a1e
	ld hl,04af7h		;4a21
L_4A24:
	ld a,(0e0a1h)		;4a24   ; el DECORADO, de 0 a 9
	add a,a			;4a27
	ld c,a			;4a28
	add a,a			;4a29
	add a,a			;4a2a
	add a,c			;4a2b
	call a_mas_hl		;4a2c
	ld e,(hl)			;4a2f
	inc hl			;4a30
	ld d,(hl)			;4a31
	inc hl			;4a32
	push hl			;4a33
	ld hl,(0e4e0h)		;4a34   ; la tabla de cambio de color, nibble alto
	ld c,000h		;4a37
	call pinta		;4a39
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
	ld (0e4e0h),hl		;4a46   ; la tabla de cambio de color, nibble alto
	ld c,001h		;4a49
	call pinta		;4a4b
	pop hl			;4a4e
	inc hl			;4a4f
	ld e,(hl)			;4a50
	inc hl			;4a51
	ld d,(hl)			;4a52
	inc hl			;4a53
	push hl			;4a54
	ld hl,(0e4e2h)		;4a55
	ld c,000h		;4a58
	call pinta		;4a5a
	pop hl			;4a5d
	ld e,(hl)			;4a5e
	inc hl			;4a5f
	ld d,(hl)			;4a60
	ld hl,(0e4e0h)		;4a61   ; la tabla de cambio de color, nibble alto
	ld bc,02000h		;4a64
	and a			;4a67
	sbc hl,bc		;4a68
	ld c,000h		;4a6a
	call pinta		;4a6c
	di			;4a6f   ; sin interrupciones mientras cambia el mapa
	push hl			;4a70   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4a71   ; las tres copias, seguidas
	ld a,001h		;4a74
	ld (06000h),a		;4a76   ; el banco 1 a 0x6000
	ld (hl),a			;4a79   ; apuntado en 0xF0F1
	inc a			;4a7a
	ld (08000h),a		;4a7b   ; el banco 2 a 0x8000
	inc hl			;4a7e   ; la copia siguiente
	ld (hl),a			;4a7f   ; apuntado en 0xF0F2
	inc a			;4a80
	ld (0a000h),a		;4a81   ; el banco 3 a 0xA000
	inc hl			;4a84   ; la copia siguiente
	ld (hl),a			;4a85   ; apuntado en 0xF0F3
	pop hl			;4a86   ; HL, como estaba
	ei			;4a87   ; el mapa ya esta entero
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
	di			;4bbf   ; sin interrupciones mientras cambia el mapa
	push hl			;4bc0   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4bc1   ; las tres copias, seguidas
	ld a,004h		;4bc4
	ld (06000h),a		;4bc6   ; el banco 4 a 0x6000
	ld (hl),a			;4bc9   ; apuntado en 0xF0F1
	inc a			;4bca
	ld (08000h),a		;4bcb   ; el banco 5 a 0x8000
	inc hl			;4bce   ; la copia siguiente
	ld (hl),a			;4bcf   ; apuntado en 0xF0F2
	inc a			;4bd0
	ld (0a000h),a		;4bd1   ; el banco 6 a 0xA000
	inc hl			;4bd4   ; la copia siguiente
	ld (hl),a			;4bd5   ; apuntado en 0xF0F3
	pop hl			;4bd6   ; HL, como estaba
	ei			;4bd7   ; el mapa ya esta entero
	ld de,088cah		;4bd8
	ld hl,02200h		;4bdb
	call pinta_en_los_tres		;4bde   ; el guion 0x88CA del banco 5: 1080 bytes de patrones (0x2200-0x2367 0x2A00-0x2B67 0x3200-0x3367)
	ld de,0898ah		;4be1
	ld hl,02368h		;4be4
	call pinta_en_los_tres_con_color		;4be7   ; el guion 0x898A del banco 5: 360 bytes de patrones (0x2368-0x23DF 0x2B68-0x2BDF 0x3368-0x33DF)
	ld de,089fdh		;4bea
	ld hl,00200h		;4bed
	call pinta_en_los_tres		;4bf0   ; el guion 0x89FD del banco 5: 1080 bytes de colores (0x0200-0x0367 0x0A00-0x0B67 0x1200-0x1367)
	ld de,08a6ch		;4bf3
	ld hl,00368h		;4bf6
	call pinta_en_los_tres		;4bf9   ; el guion 0x8A6C del banco 5: 360 bytes de colores (0x0368-0x03DF 0x0B68-0x0BDF 0x1368-0x13DF)
	ld a,(0e0a2h)		;4bfc   ; el modo en el que esta el juego
	cp 004h		;4bff
	jr nz,L_4C1E		;4c01
	ld de,08abbh		;4c03
	ld hl,00248h		;4c06
	call pinta_en_los_tres		;4c09   ; el guion 0x8ABB del banco 5: 240 bytes de colores (0x0248-0x0297 0x0A48-0x0A97 0x1248-0x1297)
	ld de,08af0h		;4c0c
	ld hl,00318h		;4c0f
	call pinta_en_los_tres		;4c12   ; el guion 0x8AF0 del banco 5: 48 bytes de colores (0x0318-0x0327 0x0B18-0x0B27 0x1318-0x1327)
	ld de,08af0h		;4c15
	ld hl,00390h		;4c18
	call pinta_en_los_tres		;4c1b   ; el guion 0x8AF0 del banco 5: 48 bytes de colores (0x0390-0x039F 0x0B90-0x0B9F 0x1390-0x139F)
L_4C1E:
	di			;4c1e   ; sin interrupciones mientras cambia el mapa
	push hl			;4c1f   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4c20   ; las tres copias, seguidas
	ld a,001h		;4c23
	ld (06000h),a		;4c25   ; el banco 1 a 0x6000
	ld (hl),a			;4c28   ; apuntado en 0xF0F1
	inc a			;4c29
	ld (08000h),a		;4c2a   ; el banco 2 a 0x8000
	inc hl			;4c2d   ; la copia siguiente
	ld (hl),a			;4c2e   ; apuntado en 0xF0F2
	inc a			;4c2f
	ld (0a000h),a		;4c30   ; el banco 3 a 0xA000
	inc hl			;4c33   ; la copia siguiente
	ld (hl),a			;4c34   ; apuntado en 0xF0F3
	pop hl			;4c35   ; HL, como estaba
	ei			;4c36   ; el mapa ya esta entero
	ret			;4c37
L_4C38:
	di			;4c38   ; sin interrupciones mientras cambia el mapa
	push hl			;4c39   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4c3a   ; las tres copias, seguidas
	ld a,004h		;4c3d
	ld (06000h),a		;4c3f   ; el banco 4 a 0x6000
	ld (hl),a			;4c42   ; apuntado en 0xF0F1
	inc a			;4c43
	ld (08000h),a		;4c44   ; el banco 5 a 0x8000
	inc hl			;4c47   ; la copia siguiente
	ld (hl),a			;4c48   ; apuntado en 0xF0F2
	inc a			;4c49
	ld (0a000h),a		;4c4a   ; el banco 6 a 0xA000
	inc hl			;4c4d   ; la copia siguiente
	ld (hl),a			;4c4e   ; apuntado en 0xF0F3
	pop hl			;4c4f   ; HL, como estaba
	ei			;4c50   ; el mapa ya esta entero
	ld de,0b0c8h		;4c51
	call pinta_sin_color		;4c54   ; el guion 0xB0C8 del banco 6: 96 bytes de patrones (0x23E0-0x243F)
	ld de,0b0feh		;4c57
	ld hl,02440h		;4c5a
	ld c,001h		;4c5d
	call pinta		;4c5f   ; el guion 0xB0FE del banco 6: 32 bytes de patrones (0x2440-0x245F)
	ld de,0b13ch		;4c62
	call pinta_sin_color		;4c65   ; el guion 0xB13C del banco 6: 248 bytes de patrones (0x2BE0-0x2CD7)
	ld de,0b1dch		;4c68
	ld hl,02cd8h		;4c6b
	ld c,001h		;4c6e
	call pinta		;4c70   ; el guion 0xB1DC del banco 6: 56 bytes de patrones (0x2CD8-0x2D0F)
	ld de,0b260h		;4c73
	call pinta_sin_color		;4c76   ; el guion 0xB260 del banco 6: 376 bytes de patrones (0x33E0-0x3557)
	ld de,0b36eh		;4c79
	ld hl,03558h		;4c7c
	ld c,001h		;4c7f
	call pinta		;4c81   ; el guion 0xB36E del banco 6: 48 bytes de patrones (0x3558-0x3587)
	ld de,0b110h		;4c84
	call pinta_sin_color		;4c87   ; el guion 0xB110 del banco 6: 96 bytes de colores (0x03E0-0x043F)
	ld de,0b129h		;4c8a
	ld hl,00440h		;4c8d
	ld c,000h		;4c90
	call pinta		;4c92   ; el guion 0xB129 del banco 6: 32 bytes de colores (0x0440-0x045F)
	ld de,0b200h		;4c95
	call pinta_sin_color		;4c98   ; el guion 0xB200 del banco 6: 248 bytes de colores (0x0BE0-0x0CD7)
	ld de,0b24dh		;4c9b
	ld hl,00cd8h		;4c9e
	ld c,000h		;4ca1
	call pinta		;4ca3   ; el guion 0xB24D del banco 6: 56 bytes de colores (0x0CD8-0x0D0F)
	ld de,0b38fh		;4ca6
	call pinta_sin_color		;4ca9   ; el guion 0xB38F del banco 6: 376 bytes de colores (0x13E0-0x1557)
	ld de,0b407h		;4cac
	ld hl,01558h		;4caf
	ld c,000h		;4cb2
	call pinta		;4cb4   ; el guion 0xB407 del banco 6: 48 bytes de colores (0x1558-0x1587)
	di			;4cb7   ; sin interrupciones mientras cambia el mapa
	push hl			;4cb8   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4cb9   ; las tres copias, seguidas
	ld a,001h		;4cbc
	ld (06000h),a		;4cbe   ; el banco 1 a 0x6000
	ld (hl),a			;4cc1   ; apuntado en 0xF0F1
	inc a			;4cc2
	ld (08000h),a		;4cc3   ; el banco 2 a 0x8000
	inc hl			;4cc6   ; la copia siguiente
	ld (hl),a			;4cc7   ; apuntado en 0xF0F2
	inc a			;4cc8
	ld (0a000h),a		;4cc9   ; el banco 3 a 0xA000
	inc hl			;4ccc   ; la copia siguiente
	ld (hl),a			;4ccd   ; apuntado en 0xF0F3
	pop hl			;4cce   ; HL, como estaba
	ei			;4ccf   ; el mapa ya esta entero
	ret			;4cd0
L_4CD1:
	ld a,(0e0a1h)		;4cd1   ; el DECORADO, de 0 a 9
	cp 008h		;4cd4
	ret z			;4cd6
	di			;4cd7   ; sin interrupciones mientras cambia el mapa
	push hl			;4cd8   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4cd9   ; las tres copias, seguidas
	ld a,007h		;4cdc
	ld (06000h),a		;4cde   ; el banco 7 a 0x6000
	ld (hl),a			;4ce1   ; apuntado en 0xF0F1
	inc a			;4ce2
	ld (08000h),a		;4ce3   ; el banco 8 a 0x8000
	inc hl			;4ce6   ; la copia siguiente
	ld (hl),a			;4ce7   ; apuntado en 0xF0F2
	inc a			;4ce8
	ld (0a000h),a		;4ce9   ; el banco 9 a 0xA000
	inc hl			;4cec   ; la copia siguiente
	ld (hl),a			;4ced   ; apuntado en 0xF0F3
	pop hl			;4cee   ; HL, como estaba
	ei			;4cef   ; el mapa ya esta entero
	ld de,06000h		;4cf0
	call pinta_sin_color		;4cf3   ; el guion 0x6000 del banco 7: 216 bytes de patrones (0x2F00-0x2FD7)
	ld de,06089h		;4cf6
	ld hl,02fd8h		;4cf9
	ld c,001h		;4cfc
	call pinta		;4cfe   ; el guion 0x6089 del banco 7: 24 bytes de patrones (0x2FD8-0x2FEF)
	ld de,060e8h		;4d01
	call pinta_sin_color		;4d04   ; el guion 0x60E8 del banco 7: 384 bytes de patrones (0x3570-0x36EF)
	ld de,06230h		;4d07
	ld hl,036f0h		;4d0a
	ld c,001h		;4d0d
	call pinta		;4d0f   ; el guion 0x6230 del banco 7: 8 bytes de patrones (0x36F0-0x36F7)
	ld a,(0e0a1h)		;4d12   ; el DECORADO, de 0 a 9
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
	call pinta		;4d41   ; el guion 0x6095 del banco 7: 216 bytes de colores (0x0F00-0x0FD7)
	ld de,060e3h		;4d44
	ld hl,00fd8h		;4d47
	ld c,080h		;4d4a
	call pinta		;4d4c   ; el guion 0x60E3 del banco 7: 24 bytes de colores (0x0FD8-0x0FEF)
	ld de,06237h		;4d4f
	ld hl,01570h		;4d52
	ld c,080h		;4d55
	call pinta		;4d57   ; el guion 0x6237 del banco 7: 384 bytes de colores (0x1570-0x16EF)
	ld de,062feh		;4d5a
	ld hl,016f0h		;4d5d
	ld c,080h		;4d60
	call pinta		;4d62   ; el guion 0x62FE del banco 7: 8 bytes de colores (0x16F0-0x16F7)
	di			;4d65   ; sin interrupciones mientras cambia el mapa
	push hl			;4d66   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4d67   ; las tres copias, seguidas
	ld a,001h		;4d6a
	ld (06000h),a		;4d6c   ; el banco 1 a 0x6000
	ld (hl),a			;4d6f   ; apuntado en 0xF0F1
	inc a			;4d70
	ld (08000h),a		;4d71   ; el banco 2 a 0x8000
	inc hl			;4d74   ; la copia siguiente
	ld (hl),a			;4d75   ; apuntado en 0xF0F2
	inc a			;4d76
	ld (0a000h),a		;4d77   ; el banco 3 a 0xA000
	inc hl			;4d7a   ; la copia siguiente
	ld (hl),a			;4d7b   ; apuntado en 0xF0F3
	pop hl			;4d7c   ; HL, como estaba
	ei			;4d7d   ; el mapa ya esta entero
	ret			;4d7e
L_4D7F:
	ld a,(0e0a1h)		;4d7f   ; el DECORADO, de 0 a 9
	cp 008h		;4d82
	ret z			;4d84
	di			;4d85   ; sin interrupciones mientras cambia el mapa
	push hl			;4d86   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4d87   ; las tres copias, seguidas
	ld a,007h		;4d8a
	ld (06000h),a		;4d8c   ; el banco 7 a 0x6000
	ld (hl),a			;4d8f   ; apuntado en 0xF0F1
	inc a			;4d90
	ld (08000h),a		;4d91   ; el banco 8 a 0x8000
	inc hl			;4d94   ; la copia siguiente
	ld (hl),a			;4d95   ; apuntado en 0xF0F2
	inc a			;4d96
	ld (0a000h),a		;4d97   ; el banco 9 a 0xA000
	inc hl			;4d9a   ; la copia siguiente
	ld (hl),a			;4d9b   ; apuntado en 0xF0F3
	pop hl			;4d9c   ; HL, como estaba
	ei			;4d9d   ; el mapa ya esta entero
	ld de,06304h		;4d9e
	call pinta_sin_color		;4da1   ; el guion 0x6304 del banco 7: 152 bytes de patrones (0x2E38-0x2ECF)
	ld de,06360h		;4da4
	ld hl,02ed0h		;4da7
	ld c,001h		;4daa
	call pinta		;4dac   ; el guion 0x6360 del banco 7: 48 bytes de patrones (0x2ED0-0x2EFF)
	ld de,063b9h		;4daf
	call pinta_sin_color		;4db2   ; el guion 0x63B9 del banco 7: 216 bytes de patrones (0x3718-0x37EF)
	ld a,(0e0a1h)		;4db5   ; el DECORADO, de 0 a 9
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
	call pinta		;4de7   ; el guion 0x6386 del banco 7: 152 bytes de colores (0x0E38-0x0ECF)
	ld de,063a0h		;4dea
	ld hl,00ed0h		;4ded
	ld c,080h		;4df0
	call pinta		;4df2   ; el guion 0x63A0 del banco 7: 48 bytes de colores (0x0ED0-0x0EFF)
	ld de,06473h		;4df5
	ld hl,01718h		;4df8
	ld c,080h		;4dfb
	call pinta		;4dfd   ; el guion 0x6473 del banco 7: 216 bytes de colores (0x1718-0x17EF)
	di			;4e00   ; sin interrupciones mientras cambia el mapa
	push hl			;4e01   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4e02   ; las tres copias, seguidas
	ld a,001h		;4e05
	ld (06000h),a		;4e07   ; el banco 1 a 0x6000
	ld (hl),a			;4e0a   ; apuntado en 0xF0F1
	inc a			;4e0b
	ld (08000h),a		;4e0c   ; el banco 2 a 0x8000
	inc hl			;4e0f   ; la copia siguiente
	ld (hl),a			;4e10   ; apuntado en 0xF0F2
	inc a			;4e11
	ld (0a000h),a		;4e12   ; el banco 3 a 0xA000
	inc hl			;4e15   ; la copia siguiente
	ld (hl),a			;4e16   ; apuntado en 0xF0F3
	pop hl			;4e17   ; HL, como estaba
	ei			;4e18   ; el mapa ya esta entero
	ret			;4e19
L_4E1A:
	ld a,(0e0a1h)		;4e1a   ; el DECORADO, de 0 a 9
	cp 004h		;4e1d
	ret nc			;4e1f
	di			;4e20   ; sin interrupciones mientras cambia el mapa
	push hl			;4e21   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4e22   ; las tres copias, seguidas
	ld a,007h		;4e25
	ld (06000h),a		;4e27   ; el banco 7 a 0x6000
	ld (hl),a			;4e2a   ; apuntado en 0xF0F1
	inc a			;4e2b
	ld (08000h),a		;4e2c   ; el banco 8 a 0x8000
	inc hl			;4e2f   ; la copia siguiente
	ld (hl),a			;4e30   ; apuntado en 0xF0F2
	inc a			;4e31
	ld (0a000h),a		;4e32   ; el banco 9 a 0xA000
	inc hl			;4e35   ; la copia siguiente
	ld (hl),a			;4e36   ; apuntado en 0xF0F3
	pop hl			;4e37   ; HL, como estaba
	ei			;4e38   ; el mapa ya esta entero
	ld de,06496h		;4e39
	call pinta_sin_color		;4e3c   ; el guion 0x6496 del banco 7: 120 bytes de patrones (0x2C68-0x2CDF)
	ld de,0649ch		;4e3f
	ld hl,02ce0h		;4e42
	ld c,001h		;4e45
	call pinta		;4e47   ; el guion 0x649C del banco 7: 104 bytes de patrones (0x2CE0-0x2D47)
	ld de,064e4h		;4e4a
	call pinta_sin_color		;4e4d   ; el guion 0x64E4 del banco 7: 192 bytes de patrones (0x32B8-0x3377)
	ld de,06538h		;4e50
	ld hl,03378h		;4e53
	ld c,001h		;4e56
	call pinta		;4e58   ; el guion 0x6538 del banco 7: 56 bytes de patrones (0x3378-0x33AF)
	ld a,(0e0a1h)		;4e5b   ; el DECORADO, de 0 a 9
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
	call pinta		;4e78   ; el guion 0x64D9 del banco 7: 120 bytes de colores (0x0C68-0x0CDF)
	ld de,064deh		;4e7b
	ld hl,00ce0h		;4e7e
	ld c,080h		;4e81
	call pinta		;4e83   ; el guion 0x64DE del banco 7: 104 bytes de colores (0x0CE0-0x0D47)
	ld de,06562h		;4e86
	ld hl,012b8h		;4e89
	ld c,080h		;4e8c
	call pinta		;4e8e   ; el guion 0x6562 del banco 7: 192 bytes de colores (0x12B8-0x1377)
	ld de,06586h		;4e91
	ld hl,01378h		;4e94
	ld c,080h		;4e97
	call pinta		;4e99   ; el guion 0x6586 del banco 7: 56 bytes de colores (0x1378-0x13AF)
	di			;4e9c   ; sin interrupciones mientras cambia el mapa
	push hl			;4e9d   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4e9e   ; las tres copias, seguidas
	ld a,001h		;4ea1
	ld (06000h),a		;4ea3   ; el banco 1 a 0x6000
	ld (hl),a			;4ea6   ; apuntado en 0xF0F1
	inc a			;4ea7
	ld (08000h),a		;4ea8   ; el banco 2 a 0x8000
	inc hl			;4eab   ; la copia siguiente
	ld (hl),a			;4eac   ; apuntado en 0xF0F2
	inc a			;4ead
	ld (0a000h),a		;4eae   ; el banco 3 a 0xA000
	inc hl			;4eb1   ; la copia siguiente
	ld (hl),a			;4eb2   ; apuntado en 0xF0F3
	pop hl			;4eb3   ; HL, como estaba
	ei			;4eb4   ; el mapa ya esta entero
	ret			;4eb5
L_4EB6:
	ld a,(0e0a1h)		;4eb6   ; el DECORADO, de 0 a 9
	cp 004h		;4eb9
	ret z			;4ebb
	cp 005h		;4ebc
	ret z			;4ebe
	cp 007h		;4ebf
	ret z			;4ec1
	cp 008h		;4ec2
	ret z			;4ec4
	di			;4ec5   ; sin interrupciones mientras cambia el mapa
	push hl			;4ec6   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4ec7   ; las tres copias, seguidas
	ld a,007h		;4eca
	ld (06000h),a		;4ecc   ; el banco 7 a 0x6000
	ld (hl),a			;4ecf   ; apuntado en 0xF0F1
	inc a			;4ed0
	ld (08000h),a		;4ed1   ; el banco 8 a 0x8000
	inc hl			;4ed4   ; la copia siguiente
	ld (hl),a			;4ed5   ; apuntado en 0xF0F2
	inc a			;4ed6
	ld (0a000h),a		;4ed7   ; el banco 9 a 0xA000
	inc hl			;4eda   ; la copia siguiente
	ld (hl),a			;4edb   ; apuntado en 0xF0F3
	pop hl			;4edc   ; HL, como estaba
	ei			;4edd   ; el mapa ya esta entero
	ld de,06591h		;4ede
	call pinta_sin_color		;4ee1   ; el guion 0x6591 del banco 7: 136 bytes de patrones (0x2D58-0x2DDF)
	ld de,065b1h		;4ee4
	ld hl,02de0h		;4ee7
	ld c,001h		;4eea
	call pinta		;4eec   ; el guion 0x65B1 del banco 7: 88 bytes de patrones (0x2DE0-0x2E37)
	ld de,06630h		;4eef
	call pinta_sin_color		;4ef2   ; el guion 0x6630 del banco 7: 192 bytes de patrones (0x33B0-0x346F)
	ld de,0665ah		;4ef5
	ld hl,03470h		;4ef8
	ld c,001h		;4efb
	call pinta		;4efd   ; el guion 0x665A del banco 7: 152 bytes de patrones (0x3470-0x3507)
	ld a,(0e0a1h)		;4f00   ; el DECORADO, de 0 a 9
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
	call pinta		;4f1d   ; el guion 0x65F2 del banco 7: 136 bytes de colores (0x0D58-0x0DDF)
	ld de,06606h		;4f20
	ld hl,00de0h		;4f23
	ld c,080h		;4f26
	call pinta		;4f28   ; el guion 0x6606 del banco 7: 88 bytes de colores (0x0DE0-0x0E37)
	ld de,066dah		;4f2b
	ld hl,013b0h		;4f2e
	ld c,080h		;4f31
	call pinta		;4f33   ; el guion 0x66DA del banco 7: 192 bytes de colores (0x13B0-0x146F)
	ld de,066f5h		;4f36
	ld hl,01470h		;4f39
	ld c,080h		;4f3c
	call pinta		;4f3e   ; el guion 0x66F5 del banco 7: 152 bytes de colores (0x1470-0x1507)
	di			;4f41   ; sin interrupciones mientras cambia el mapa
	push hl			;4f42   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4f43   ; las tres copias, seguidas
	ld a,001h		;4f46
	ld (06000h),a		;4f48   ; el banco 1 a 0x6000
	ld (hl),a			;4f4b   ; apuntado en 0xF0F1
	inc a			;4f4c
	ld (08000h),a		;4f4d   ; el banco 2 a 0x8000
	inc hl			;4f50   ; la copia siguiente
	ld (hl),a			;4f51   ; apuntado en 0xF0F2
	inc a			;4f52
	ld (0a000h),a		;4f53   ; el banco 3 a 0xA000
	inc hl			;4f56   ; la copia siguiente
	ld (hl),a			;4f57   ; apuntado en 0xF0F3
	pop hl			;4f58   ; HL, como estaba
	ei			;4f59   ; el mapa ya esta entero
	ret			;4f5a
L_4F5B:
	ld a,(0e0a1h)		;4f5b   ; el DECORADO, de 0 a 9
	cp 007h		;4f5e
	ret nz			;4f60
	di			;4f61   ; sin interrupciones mientras cambia el mapa
	push hl			;4f62   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4f63   ; las tres copias, seguidas
	ld a,007h		;4f66
	ld (06000h),a		;4f68   ; el banco 7 a 0x6000
	ld (hl),a			;4f6b   ; apuntado en 0xF0F1
	inc a			;4f6c
	ld (08000h),a		;4f6d   ; el banco 8 a 0x8000
	inc hl			;4f70   ; la copia siguiente
	ld (hl),a			;4f71   ; apuntado en 0xF0F2
	inc a			;4f72
	ld (0a000h),a		;4f73   ; el banco 9 a 0xA000
	inc hl			;4f76   ; la copia siguiente
	ld (hl),a			;4f77   ; apuntado en 0xF0F3
	pop hl			;4f78   ; HL, como estaba
	ei			;4f79   ; el mapa ya esta entero
	ld de,06714h		;4f7a
	call pinta_sin_color		;4f7d   ; el guion 0x6714 del banco 7: 240 bytes de patrones (0x2C68-0x2D57)
	ld de,0682fh		;4f80
	call pinta_sin_color		;4f83   ; el guion 0x682F del banco 7: 232 bytes de patrones (0x32B8-0x339F)
	ld de,067cbh		;4f86
	call pinta_sin_color		;4f89   ; el guion 0x67CB del banco 7: 240 bytes de colores (0x0C68-0x0D57)
	ld de,068eah		;4f8c
	call pinta_sin_color		;4f8f   ; el guion 0x68EA del banco 7: 232 bytes de colores (0x12B8-0x139F)
	di			;4f92   ; sin interrupciones mientras cambia el mapa
	push hl			;4f93   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4f94   ; las tres copias, seguidas
	ld a,001h		;4f97
	ld (06000h),a		;4f99   ; el banco 1 a 0x6000
	ld (hl),a			;4f9c   ; apuntado en 0xF0F1
	inc a			;4f9d
	ld (08000h),a		;4f9e   ; el banco 2 a 0x8000
	inc hl			;4fa1   ; la copia siguiente
	ld (hl),a			;4fa2   ; apuntado en 0xF0F2
	inc a			;4fa3
	ld (0a000h),a		;4fa4   ; el banco 3 a 0xA000
	inc hl			;4fa7   ; la copia siguiente
	ld (hl),a			;4fa8   ; apuntado en 0xF0F3
	pop hl			;4fa9   ; HL, como estaba
	ei			;4faa   ; el mapa ya esta entero
	ret			;4fab
L_4FAC:
	ld a,(0e0a1h)		;4fac   ; el DECORADO, de 0 a 9
	cp 004h		;4faf
	jr z,L_4FB6		;4fb1
	cp 005h		;4fb3
	ret nz			;4fb5
L_4FB6:
	di			;4fb6   ; sin interrupciones mientras cambia el mapa
	push hl			;4fb7   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;4fb8   ; las tres copias, seguidas
	ld a,007h		;4fbb
	ld (06000h),a		;4fbd   ; el banco 7 a 0x6000
	ld (hl),a			;4fc0   ; apuntado en 0xF0F1
	inc a			;4fc1
	ld (08000h),a		;4fc2   ; el banco 8 a 0x8000
	inc hl			;4fc5   ; la copia siguiente
	ld (hl),a			;4fc6   ; apuntado en 0xF0F2
	inc a			;4fc7
	ld (0a000h),a		;4fc8   ; el banco 9 a 0xA000
	inc hl			;4fcb   ; la copia siguiente
	ld (hl),a			;4fcc   ; apuntado en 0xF0F3
	pop hl			;4fcd   ; HL, como estaba
	ei			;4fce   ; el mapa ya esta entero
	ld de,06932h		;4fcf
	call pinta_sin_color		;4fd2   ; el guion 0x6932 del banco 7: 144 bytes de patrones (0x2D58-0x2DE7)
	ld de,06965h		;4fd5
	ld hl,02de8h		;4fd8
	ld c,001h		;4fdb
	call pinta		;4fdd   ; el guion 0x6965 del banco 7: 80 bytes de patrones (0x2DE8-0x2E37)
	ld de,069f5h		;4fe0
	call pinta_sin_color		;4fe3   ; el guion 0x69F5 del banco 7: 256 bytes de patrones (0x3360-0x345F)
	ld de,06aafh		;4fe6
	ld hl,03460h		;4fe9
	ld c,001h		;4fec
	call pinta		;4fee   ; el guion 0x6AAF del banco 7: 48 bytes de patrones (0x3460-0x348F)
	ld de,069a0h		;4ff1
	call pinta_sin_color		;4ff4   ; el guion 0x69A0 del banco 7: 144 bytes de colores (0x0D58-0x0DE7)
	ld de,069cfh		;4ff7
	ld hl,00de8h		;4ffa
	ld c,000h		;4ffd
	call pinta		;4fff   ; el guion 0x69CF del banco 7: 80 bytes de colores (0x0DE8-0x0E37)
	ld de,06ad6h		;5002
	call pinta_sin_color		;5005   ; el guion 0x6AD6 del banco 7: 256 bytes de colores (0x1360-0x145F)
	ld de,06b48h		;5008
	ld hl,01460h		;500b
	ld c,000h		;500e
	call pinta		;5010   ; el guion 0x6B48 del banco 7: 48 bytes de colores (0x1460-0x148F)
	di			;5013   ; sin interrupciones mientras cambia el mapa
	push hl			;5014   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5015   ; las tres copias, seguidas
	ld a,001h		;5018
	ld (06000h),a		;501a   ; el banco 1 a 0x6000
	ld (hl),a			;501d   ; apuntado en 0xF0F1
	inc a			;501e
	ld (08000h),a		;501f   ; el banco 2 a 0x8000
	inc hl			;5022   ; la copia siguiente
	ld (hl),a			;5023   ; apuntado en 0xF0F2
	inc a			;5024
	ld (0a000h),a		;5025   ; el banco 3 a 0xA000
	inc hl			;5028   ; la copia siguiente
	ld (hl),a			;5029   ; apuntado en 0xF0F3
	pop hl			;502a   ; HL, como estaba
	ei			;502b   ; el mapa ya esta entero
	ret			;502c
L_502D:
	ld a,(0e0a1h)		;502d   ; el DECORADO, de 0 a 9
	cp 007h		;5030
	ret nz			;5032
	di			;5033   ; sin interrupciones mientras cambia el mapa
	push hl			;5034   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5035   ; las tres copias, seguidas
	ld a,007h		;5038
	ld (06000h),a		;503a   ; el banco 7 a 0x6000
	ld (hl),a			;503d   ; apuntado en 0xF0F1
	inc a			;503e
	ld (08000h),a		;503f   ; el banco 8 a 0x8000
	inc hl			;5042   ; la copia siguiente
	ld (hl),a			;5043   ; apuntado en 0xF0F2
	inc a			;5044
	ld (0a000h),a		;5045   ; el banco 9 a 0xA000
	inc hl			;5048   ; la copia siguiente
	ld (hl),a			;5049   ; apuntado en 0xF0F3
	pop hl			;504a   ; HL, como estaba
	ei			;504b   ; el mapa ya esta entero
	ld de,06b64h		;504c
	call pinta_sin_color		;504f   ; el guion 0x6B64 del banco 7: 128 bytes de patrones (0x2D58-0x2DD7)
	ld de,06b82h		;5052
	ld hl,02dd8h		;5055
	ld c,001h		;5058
	call pinta		;505a   ; el guion 0x6B82 del banco 7: 96 bytes de patrones (0x2DD8-0x2E37)
	ld de,06c11h		;505d
	call pinta_sin_color		;5060   ; el guion 0x6C11 del banco 7: 112 bytes de patrones (0x33B0-0x341F)
	ld de,06c13h		;5063
	ld hl,03420h		;5066
	ld c,001h		;5069
	call pinta		;506b   ; el guion 0x6C13 del banco 7: 112 bytes de patrones (0x3420-0x348F)
	ld de,06bdbh		;506e
	call pinta_sin_color		;5071   ; el guion 0x6BDB del banco 7: 128 bytes de colores (0x0D58-0x0DD7)
	ld de,06be9h		;5074
	ld hl,00dd8h		;5077
	ld c,000h		;507a
	call pinta		;507c   ; el guion 0x6BE9 del banco 7: 96 bytes de colores (0x0DD8-0x0E37)
	ld de,06c7ah		;507f
	call pinta_sin_color		;5082   ; el guion 0x6C7A del banco 7: 112 bytes de colores (0x13B0-0x141F)
	ld de,06c7ch		;5085
	ld hl,01420h		;5088
	ld c,000h		;508b
	call pinta		;508d   ; el guion 0x6C7C del banco 7: 112 bytes de colores (0x1420-0x148F)
	di			;5090   ; sin interrupciones mientras cambia el mapa
	push hl			;5091   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5092   ; las tres copias, seguidas
	ld a,001h		;5095
	ld (06000h),a		;5097   ; el banco 1 a 0x6000
	ld (hl),a			;509a   ; apuntado en 0xF0F1
	inc a			;509b
	ld (08000h),a		;509c   ; el banco 2 a 0x8000
	inc hl			;509f   ; la copia siguiente
	ld (hl),a			;50a0   ; apuntado en 0xF0F2
	inc a			;50a1
	ld (0a000h),a		;50a2   ; el banco 3 a 0xA000
	inc hl			;50a5   ; la copia siguiente
	ld (hl),a			;50a6   ; apuntado en 0xF0F3
	pop hl			;50a7   ; HL, como estaba
	ei			;50a8   ; el mapa ya esta entero
	ret			;50a9
L_50AA:
	ld a,(0e0a1h)		;50aa   ; el DECORADO, de 0 a 9
	cp 008h		;50ad
	ret nz			;50af
	di			;50b0   ; sin interrupciones mientras cambia el mapa
	push hl			;50b1   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;50b2   ; las tres copias, seguidas
	ld a,007h		;50b5
	ld (06000h),a		;50b7   ; el banco 7 a 0x6000
	ld (hl),a			;50ba   ; apuntado en 0xF0F1
	inc a			;50bb
	ld (08000h),a		;50bc   ; el banco 8 a 0x8000
	inc hl			;50bf   ; la copia siguiente
	ld (hl),a			;50c0   ; apuntado en 0xF0F2
	inc a			;50c1
	ld (0a000h),a		;50c2   ; el banco 9 a 0xA000
	inc hl			;50c5   ; la copia siguiente
	ld (hl),a			;50c6   ; apuntado en 0xF0F3
	pop hl			;50c7   ; HL, como estaba
	ei			;50c8   ; el mapa ya esta entero
	ld de,06c9ch		;50c9
	call pinta_sin_color		;50cc   ; el guion 0x6C9C del banco 7: 904 bytes de patrones (0x2010-0x2027 0x2200-0x256F)
	ld de,06fb9h		;50cf
	ld hl,02570h		;50d2
	ld c,001h		;50d5
	call pinta		;50d7   ; el guion 0x6FB9 del banco 7: 16 bytes de patrones (0x2570-0x257F)
	ld de,06fdbh		;50da
	call pinta_sin_color		;50dd   ; el guion 0x6FDB del banco 7: 1976 bytes de patrones (0x2810-0x2FC7)
	ld de,07640h		;50e0
	ld hl,02fc8h		;50e3
	ld c,001h		;50e6
	call pinta		;50e8   ; el guion 0x7640 del banco 7: 40 bytes de patrones (0x2FC8-0x2FEF)
	ld de,06fc3h		;50eb
	call pinta_sin_color		;50ee   ; el guion 0x6FC3 del banco 7: 904 bytes de colores (0x0010-0x0027 0x0200-0x056F)
	ld de,06fd8h		;50f1
	ld hl,00570h		;50f4
	ld c,000h		;50f7
	call pinta		;50f9   ; el guion 0x6FD8 del banco 7: 16 bytes de colores (0x0570-0x057F)
	ld de,07655h		;50fc
	call pinta_sin_color		;50ff   ; el guion 0x7655 del banco 7: 1976 bytes de colores (0x0810-0x0FC7)
	ld de,07683h		;5102
	ld hl,00fc8h		;5105
	ld c,000h		;5108
	call pinta		;510a   ; el guion 0x7683 del banco 7: 40 bytes de colores (0x0FC8-0x0FEF)
	di			;510d   ; sin interrupciones mientras cambia el mapa
	push hl			;510e   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;510f   ; las tres copias, seguidas
	ld a,001h		;5112
	ld (06000h),a		;5114   ; el banco 1 a 0x6000
	ld (hl),a			;5117   ; apuntado en 0xF0F1
	inc a			;5118
	ld (08000h),a		;5119   ; el banco 2 a 0x8000
	inc hl			;511c   ; la copia siguiente
	ld (hl),a			;511d   ; apuntado en 0xF0F2
	inc a			;511e
	ld (0a000h),a		;511f   ; el banco 3 a 0xA000
	inc hl			;5122   ; la copia siguiente
	ld (hl),a			;5123   ; apuntado en 0xF0F3
	pop hl			;5124   ; HL, como estaba
	ei			;5125   ; el mapa ya esta entero
	ret			;5126
L_5127:
	ld a,(0e0a1h)		;5127   ; el DECORADO, de 0 a 9
	cp 008h		;512a
	ret nz			;512c
	di			;512d   ; sin interrupciones mientras cambia el mapa
	push hl			;512e   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;512f   ; las tres copias, seguidas
	ld a,007h		;5132
	ld (06000h),a		;5134   ; el banco 7 a 0x6000
	ld (hl),a			;5137   ; apuntado en 0xF0F1
	inc a			;5138
	ld (08000h),a		;5139   ; el banco 8 a 0x8000
	inc hl			;513c   ; la copia siguiente
	ld (hl),a			;513d   ; apuntado en 0xF0F2
	inc a			;513e
	ld (0a000h),a		;513f   ; el banco 9 a 0xA000
	inc hl			;5142   ; la copia siguiente
	ld (hl),a			;5143   ; apuntado en 0xF0F3
	pop hl			;5144   ; HL, como estaba
	ei			;5145   ; el mapa ya esta entero
	ld de,07686h		;5146
	call pinta_sin_color		;5149   ; el guion 0x7686 del banco 7: 608 bytes de patrones de sprite (0x1C20-0x1E7F)
	di			;514c   ; sin interrupciones mientras cambia el mapa
	push hl			;514d   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;514e   ; las tres copias, seguidas
	ld a,001h		;5151
	ld (06000h),a		;5153   ; el banco 1 a 0x6000
	ld (hl),a			;5156   ; apuntado en 0xF0F1
	inc a			;5157
	ld (08000h),a		;5158   ; el banco 2 a 0x8000
	inc hl			;515b   ; la copia siguiente
	ld (hl),a			;515c   ; apuntado en 0xF0F2
	inc a			;515d
	ld (0a000h),a		;515e   ; el banco 3 a 0xA000
	inc hl			;5161   ; la copia siguiente
	ld (hl),a			;5162   ; apuntado en 0xF0F3
	pop hl			;5163   ; HL, como estaba
	ei			;5164   ; el mapa ya esta entero
	ret			;5165
L_5166:
	ld a,(0e0a1h)		;5166   ; el DECORADO, de 0 a 9
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
	di			;5178   ; sin interrupciones mientras cambia el mapa
	push hl			;5179   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;517a   ; las tres copias, seguidas
	ld a,007h		;517d
	ld (06000h),a		;517f   ; el banco 7 a 0x6000
	ld (hl),a			;5182   ; apuntado en 0xF0F1
	inc a			;5183
	ld (08000h),a		;5184   ; el banco 8 a 0x8000
	inc hl			;5187   ; la copia siguiente
	ld (hl),a			;5188   ; apuntado en 0xF0F2
	inc a			;5189
	ld (0a000h),a		;518a   ; el banco 9 a 0xA000
	inc hl			;518d   ; la copia siguiente
	ld (hl),a			;518e   ; apuntado en 0xF0F3
	pop hl			;518f   ; HL, como estaba
	ei			;5190   ; el mapa ya esta entero
	ld de,07806h		;5191
	call pinta_sin_color		;5194   ; el guion 0x7806 del banco 7: 176 bytes de patrones (0x2440-0x24EF)
	ld de,07857h		;5197
	ld hl,024f0h		;519a
	ld c,001h		;519d
	call pinta		;519f   ; el guion 0x7857 del banco 7: 80 bytes de patrones (0x24F0-0x253F)
	ld de,07891h		;51a2
	call pinta_sin_color		;51a5   ; el guion 0x7891 del banco 7: 176 bytes de colores (0x0440-0x04EF)
	ld de,078c8h		;51a8
	ld hl,004f0h		;51ab
	ld c,000h		;51ae
	call pinta		;51b0   ; el guion 0x78C8 del banco 7: 80 bytes de colores (0x04F0-0x053F)
	di			;51b3   ; sin interrupciones mientras cambia el mapa
	push hl			;51b4   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;51b5   ; las tres copias, seguidas
	ld a,001h		;51b8
	ld (06000h),a		;51ba   ; el banco 1 a 0x6000
	ld (hl),a			;51bd   ; apuntado en 0xF0F1
	inc a			;51be
	ld (08000h),a		;51bf   ; el banco 2 a 0x8000
	inc hl			;51c2   ; la copia siguiente
	ld (hl),a			;51c3   ; apuntado en 0xF0F2
	inc a			;51c4
	ld (0a000h),a		;51c5   ; el banco 3 a 0xA000
	inc hl			;51c8   ; la copia siguiente
	ld (hl),a			;51c9   ; apuntado en 0xF0F3
	pop hl			;51ca   ; HL, como estaba
	ei			;51cb   ; el mapa ya esta entero
	ret			;51cc
L_51CD:
	di			;51cd   ; sin interrupciones mientras cambia el mapa
	push hl			;51ce   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;51cf   ; las tres copias, seguidas
	ld a,004h		;51d2
	ld (06000h),a		;51d4   ; el banco 4 a 0x6000
	ld (hl),a			;51d7   ; apuntado en 0xF0F1
	inc a			;51d8
	ld (08000h),a		;51d9   ; el banco 5 a 0x8000
	inc hl			;51dc   ; la copia siguiente
	ld (hl),a			;51dd   ; apuntado en 0xF0F2
	inc a			;51de
	ld (0a000h),a		;51df   ; el banco 6 a 0xA000
	inc hl			;51e2   ; la copia siguiente
	ld (hl),a			;51e3   ; apuntado en 0xF0F3
	pop hl			;51e4   ; HL, como estaba
	ei			;51e5   ; el mapa ya esta entero
	ld de,0b71bh		;51e6
	ld hl,02590h		;51e9
	call pinta_en_los_tres		;51ec   ; el guion 0xB71B del banco 6: 1824 bytes de patrones (0x2590-0x27EF 0x2D90-0x2FEF 0x3590-0x37EF)
	ld de,0b96ah		;51ef
	ld hl,00590h		;51f2
	call pinta_en_los_tres		;51f5   ; el guion 0xB96A del banco 6: 1824 bytes de colores (0x0590-0x07EF 0x0D90-0x0FEF 0x1590-0x17EF)
	di			;51f8   ; sin interrupciones mientras cambia el mapa
	push hl			;51f9   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;51fa   ; las tres copias, seguidas
	ld a,001h		;51fd
	ld (06000h),a		;51ff   ; el banco 1 a 0x6000
	ld (hl),a			;5202   ; apuntado en 0xF0F1
	inc a			;5203
	ld (08000h),a		;5204   ; el banco 2 a 0x8000
	inc hl			;5207   ; la copia siguiente
	ld (hl),a			;5208   ; apuntado en 0xF0F2
	inc a			;5209
	ld (0a000h),a		;520a   ; el banco 3 a 0xA000
	inc hl			;520d   ; la copia siguiente
	ld (hl),a			;520e   ; apuntado en 0xF0F3
	pop hl			;520f   ; HL, como estaba
	ei			;5210   ; el mapa ya esta entero
	ret			;5211
L_5212:
	di			;5212   ; sin interrupciones mientras cambia el mapa
	push hl			;5213   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5214   ; las tres copias, seguidas
	ld a,007h		;5217
	ld (06000h),a		;5219   ; el banco 7 a 0x6000
	ld (hl),a			;521c   ; apuntado en 0xF0F1
	inc a			;521d
	ld (08000h),a		;521e   ; el banco 8 a 0x8000
	inc hl			;5221   ; la copia siguiente
	ld (hl),a			;5222   ; apuntado en 0xF0F2
	inc a			;5223
	ld (0a000h),a		;5224   ; el banco 9 a 0xA000
	inc hl			;5227   ; la copia siguiente
	ld (hl),a			;5228   ; apuntado en 0xF0F3
	pop hl			;5229   ; HL, como estaba
	ei			;522a   ; el mapa ya esta entero
	ld de,09229h		;522b
	call pinta_sin_color		;522e   ; el guion 0x9229 del banco 8: 336 bytes de patrones (0x2D50-0x2E9F)
	ld de,09234h		;5231
	ld hl,02ea0h		;5234
	ld c,001h		;5237
	call pinta		;5239   ; el guion 0x9234 del banco 8: 328 bytes de patrones (0x2EA0-0x2FE7)
	di			;523c   ; sin interrupciones mientras cambia el mapa
	push hl			;523d   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;523e   ; las tres copias, seguidas
	ld a,001h		;5241
	ld (06000h),a		;5243   ; el banco 1 a 0x6000
	ld (hl),a			;5246   ; apuntado en 0xF0F1
	inc a			;5247
	ld (08000h),a		;5248   ; el banco 2 a 0x8000
	inc hl			;524b   ; la copia siguiente
	ld (hl),a			;524c   ; apuntado en 0xF0F2
	inc a			;524d
	ld (0a000h),a		;524e   ; el banco 3 a 0xA000
	inc hl			;5251   ; la copia siguiente
	ld (hl),a			;5252   ; apuntado en 0xF0F3
	pop hl			;5253   ; HL, como estaba
	ei			;5254   ; el mapa ya esta entero
	ret			;5255
L_5256:
	di			;5256   ; sin interrupciones mientras cambia el mapa
	push hl			;5257   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5258   ; las tres copias, seguidas
	ld a,007h		;525b
	ld (06000h),a		;525d   ; el banco 7 a 0x6000
	ld (hl),a			;5260   ; apuntado en 0xF0F1
	inc a			;5261
	ld (08000h),a		;5262   ; el banco 8 a 0x8000
	inc hl			;5265   ; la copia siguiente
	ld (hl),a			;5266   ; apuntado en 0xF0F2
	inc a			;5267
	ld (0a000h),a		;5268   ; el banco 9 a 0xA000
	inc hl			;526b   ; la copia siguiente
	ld (hl),a			;526c   ; apuntado en 0xF0F3
	pop hl			;526d   ; HL, como estaba
	ei			;526e   ; el mapa ya esta entero
	ld de,09457h		;526f
	call pinta_sin_color		;5272   ; el guion 0x9457 del banco 8: 464 bytes de patrones (0x32B8-0x3487)
	ld de,09473h		;5275
	ld hl,03488h		;5278
	ld c,001h		;527b
	call pinta		;527d   ; el guion 0x9473 del banco 8: 424 bytes de patrones (0x3488-0x362F)
	di			;5280   ; sin interrupciones mientras cambia el mapa
	push hl			;5281   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5282   ; las tres copias, seguidas
	ld a,001h		;5285
	ld (06000h),a		;5287   ; el banco 1 a 0x6000
	ld (hl),a			;528a   ; apuntado en 0xF0F1
	inc a			;528b
	ld (08000h),a		;528c   ; el banco 2 a 0x8000
	inc hl			;528f   ; la copia siguiente
	ld (hl),a			;5290   ; apuntado en 0xF0F2
	inc a			;5291
	ld (0a000h),a		;5292   ; el banco 3 a 0xA000
	inc hl			;5295   ; la copia siguiente
	ld (hl),a			;5296   ; apuntado en 0xF0F3
	pop hl			;5297   ; HL, como estaba
	ei			;5298   ; el mapa ya esta entero
	ret			;5299
L_529A:
	di			;529a   ; sin interrupciones mientras cambia el mapa
	push hl			;529b   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;529c   ; las tres copias, seguidas
	ld a,007h		;529f
	ld (06000h),a		;52a1   ; el banco 7 a 0x6000
	ld (hl),a			;52a4   ; apuntado en 0xF0F1
	inc a			;52a5
	ld (08000h),a		;52a6   ; el banco 8 a 0x8000
	inc hl			;52a9   ; la copia siguiente
	ld (hl),a			;52aa   ; apuntado en 0xF0F2
	inc a			;52ab
	ld (0a000h),a		;52ac   ; el banco 9 a 0xA000
	inc hl			;52af   ; la copia siguiente
	ld (hl),a			;52b0   ; apuntado en 0xF0F3
	pop hl			;52b1   ; HL, como estaba
	ei			;52b2   ; el mapa ya esta entero
	ld a,(0e0a1h)		;52b3   ; el DECORADO, de 0 a 9
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
	call pinta		;52e2   ; el guion 0x9373 del banco 8: 336 bytes de colores (0x0D50-0x0E9F)
	ld de,0937ah		;52e5
	ld hl,00ea0h		;52e8
	ld c,080h		;52eb
	call pinta		;52ed   ; el guion 0x937A del banco 8: 328 bytes de colores (0x0EA0-0x0FE7)
	di			;52f0   ; sin interrupciones mientras cambia el mapa
	push hl			;52f1   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;52f2   ; las tres copias, seguidas
	ld a,001h		;52f5
	ld (06000h),a		;52f7   ; el banco 1 a 0x6000
	ld (hl),a			;52fa   ; apuntado en 0xF0F1
	inc a			;52fb
	ld (08000h),a		;52fc   ; el banco 2 a 0x8000
	inc hl			;52ff   ; la copia siguiente
	ld (hl),a			;5300   ; apuntado en 0xF0F2
	inc a			;5301
	ld (0a000h),a		;5302   ; el banco 3 a 0xA000
	inc hl			;5305   ; la copia siguiente
	ld (hl),a			;5306   ; apuntado en 0xF0F3
	pop hl			;5307   ; HL, como estaba
	ei			;5308   ; el mapa ya esta entero
	ret			;5309
L_530A:
	di			;530a   ; sin interrupciones mientras cambia el mapa
	push hl			;530b   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;530c   ; las tres copias, seguidas
	ld a,007h		;530f
	ld (06000h),a		;5311   ; el banco 7 a 0x6000
	ld (hl),a			;5314   ; apuntado en 0xF0F1
	inc a			;5315
	ld (08000h),a		;5316   ; el banco 8 a 0x8000
	inc hl			;5319   ; la copia siguiente
	ld (hl),a			;531a   ; apuntado en 0xF0F2
	inc a			;531b
	ld (0a000h),a		;531c   ; el banco 9 a 0xA000
	inc hl			;531f   ; la copia siguiente
	ld (hl),a			;5320   ; apuntado en 0xF0F3
	pop hl			;5321   ; HL, como estaba
	ei			;5322   ; el mapa ya esta entero
	ld a,(0e0a1h)		;5323   ; el DECORADO, de 0 a 9
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
	call pinta		;5352   ; el guion 0x95FB del banco 8: 464 bytes de colores (0x12B8-0x1487)
	ld de,0960dh		;5355
	ld hl,01488h		;5358
	ld c,080h		;535b
	call pinta		;535d   ; el guion 0x960D del banco 8: 424 bytes de colores (0x1488-0x162F)
	di			;5360   ; sin interrupciones mientras cambia el mapa
	push hl			;5361   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5362   ; las tres copias, seguidas
	ld a,001h		;5365
	ld (06000h),a		;5367   ; el banco 1 a 0x6000
	ld (hl),a			;536a   ; apuntado en 0xF0F1
	inc a			;536b
	ld (08000h),a		;536c   ; el banco 2 a 0x8000
	inc hl			;536f   ; la copia siguiente
	ld (hl),a			;5370   ; apuntado en 0xF0F2
	inc a			;5371
	ld (0a000h),a		;5372   ; el banco 3 a 0xA000
	inc hl			;5375   ; la copia siguiente
	ld (hl),a			;5376   ; apuntado en 0xF0F3
	pop hl			;5377   ; HL, como estaba
	ei			;5378   ; el mapa ya esta entero
	ret			;5379
L_537A:
	di			;537a   ; sin interrupciones mientras cambia el mapa
	push hl			;537b   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;537c   ; las tres copias, seguidas
	ld a,007h		;537f
	ld (06000h),a		;5381   ; el banco 7 a 0x6000
	ld (hl),a			;5384   ; apuntado en 0xF0F1
	inc a			;5385
	ld (08000h),a		;5386   ; el banco 8 a 0x8000
	inc hl			;5389   ; la copia siguiente
	ld (hl),a			;538a   ; apuntado en 0xF0F2
	inc a			;538b
	ld (0a000h),a		;538c   ; el banco 9 a 0xA000
	inc hl			;538f   ; la copia siguiente
	ld (hl),a			;5390   ; apuntado en 0xF0F3
	pop hl			;5391   ; HL, como estaba
	ei			;5392   ; el mapa ya esta entero
	ld de,08b7dh		;5393
	call pinta_sin_color		;5396   ; el guion 0x8B7D del banco 8: 408 bytes de patrones (0x2C68-0x2DFF)
	ld de,08c2ch		;5399
	ld hl,02e00h		;539c
	ld c,001h		;539f
	call pinta		;53a1   ; el guion 0x8C2C del banco 8: 232 bytes de patrones (0x2E00-0x2EE7)
	ld de,08d0eh		;53a4
	call pinta_sin_color		;53a7   ; el guion 0x8D0E del banco 8: 152 bytes de patrones (0x2EE8-0x2F7F)
	ld de,08d31h		;53aa
	ld hl,02f80h		;53ad
	ld c,001h		;53b0
	call pinta		;53b2   ; el guion 0x8D31 del banco 8: 112 bytes de patrones (0x2F80-0x2FEF)
	di			;53b5   ; sin interrupciones mientras cambia el mapa
	push hl			;53b6   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;53b7   ; las tres copias, seguidas
	ld a,001h		;53ba
	ld (06000h),a		;53bc   ; el banco 1 a 0x6000
	ld (hl),a			;53bf   ; apuntado en 0xF0F1
	inc a			;53c0
	ld (08000h),a		;53c1   ; el banco 2 a 0x8000
	inc hl			;53c4   ; la copia siguiente
	ld (hl),a			;53c5   ; apuntado en 0xF0F2
	inc a			;53c6
	ld (0a000h),a		;53c7   ; el banco 3 a 0xA000
	inc hl			;53ca   ; la copia siguiente
	ld (hl),a			;53cb   ; apuntado en 0xF0F3
	pop hl			;53cc   ; HL, como estaba
	ei			;53cd   ; el mapa ya esta entero
	ret			;53ce
L_53CF:
	di			;53cf   ; sin interrupciones mientras cambia el mapa
	push hl			;53d0   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;53d1   ; las tres copias, seguidas
	ld a,007h		;53d4
	ld (06000h),a		;53d6   ; el banco 7 a 0x6000
	ld (hl),a			;53d9   ; apuntado en 0xF0F1
	inc a			;53da
	ld (08000h),a		;53db   ; el banco 8 a 0x8000
	inc hl			;53de   ; la copia siguiente
	ld (hl),a			;53df   ; apuntado en 0xF0F2
	inc a			;53e0
	ld (0a000h),a		;53e1   ; el banco 9 a 0xA000
	inc hl			;53e4   ; la copia siguiente
	ld (hl),a			;53e5   ; apuntado en 0xF0F3
	pop hl			;53e6   ; HL, como estaba
	ei			;53e7   ; el mapa ya esta entero
	ld de,08e52h		;53e8
	call pinta_sin_color		;53eb   ; el guion 0x8E52 del banco 8: 296 bytes de patrones (0x32B8-0x33DF)
	ld de,08ef1h		;53ee
	ld hl,033e0h		;53f1
	ld c,001h		;53f4
	call pinta		;53f6   ; el guion 0x8EF1 del banco 8: 112 bytes de patrones (0x33E0-0x344F)
	ld de,08f56h		;53f9
	call pinta_sin_color		;53fc   ; el guion 0x8F56 del banco 8: 432 bytes de patrones (0x3450-0x35FF)
	ld de,08ffch		;53ff
	ld hl,03600h		;5402
	ld c,001h		;5405
	call pinta		;5407   ; el guion 0x8FFC del banco 8: 248 bytes de patrones (0x3600-0x36F7)
	di			;540a   ; sin interrupciones mientras cambia el mapa
	push hl			;540b   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;540c   ; las tres copias, seguidas
	ld a,001h		;540f
	ld (06000h),a		;5411   ; el banco 1 a 0x6000
	ld (hl),a			;5414   ; apuntado en 0xF0F1
	inc a			;5415
	ld (08000h),a		;5416   ; el banco 2 a 0x8000
	inc hl			;5419   ; la copia siguiente
	ld (hl),a			;541a   ; apuntado en 0xF0F2
	inc a			;541b
	ld (0a000h),a		;541c   ; el banco 3 a 0xA000
	inc hl			;541f   ; la copia siguiente
	ld (hl),a			;5420   ; apuntado en 0xF0F3
	pop hl			;5421   ; HL, como estaba
	ei			;5422   ; el mapa ya esta entero
	ret			;5423
L_5424:
	di			;5424   ; sin interrupciones mientras cambia el mapa
	push hl			;5425   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5426   ; las tres copias, seguidas
	ld a,007h		;5429
	ld (06000h),a		;542b   ; el banco 7 a 0x6000
	ld (hl),a			;542e   ; apuntado en 0xF0F1
	inc a			;542f
	ld (08000h),a		;5430   ; el banco 8 a 0x8000
	inc hl			;5433   ; la copia siguiente
	ld (hl),a			;5434   ; apuntado en 0xF0F2
	inc a			;5435
	ld (0a000h),a		;5436   ; el banco 9 a 0xA000
	inc hl			;5439   ; la copia siguiente
	ld (hl),a			;543a   ; apuntado en 0xF0F3
	pop hl			;543b   ; HL, como estaba
	ei			;543c   ; el mapa ya esta entero
	ld a,(0e0a1h)		;543d   ; el DECORADO, de 0 a 9
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
	call pinta		;545a   ; el guion 0x8DA3 del banco 8: 408 bytes de colores (0x0C68-0x0DFF)
	ld de,08db5h		;545d
	ld hl,00e00h		;5460
	ld c,080h		;5463
	call pinta		;5465   ; el guion 0x8DB5 del banco 8: 232 bytes de colores (0x0E00-0x0EE7)
	ld de,08e13h		;5468
	ld hl,00ee8h		;546b
	ld c,080h		;546e
	call pinta		;5470   ; el guion 0x8E13 del banco 8: 152 bytes de colores (0x0EE8-0x0F7F)
	ld de,08e19h		;5473
	ld hl,00f80h		;5476
	ld c,080h		;5479
	call pinta		;547b   ; el guion 0x8E19 del banco 8: 112 bytes de colores (0x0F80-0x0FEF)
	di			;547e   ; sin interrupciones mientras cambia el mapa
	push hl			;547f   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5480   ; las tres copias, seguidas
	ld a,001h		;5483
	ld (06000h),a		;5485   ; el banco 1 a 0x6000
	ld (hl),a			;5488   ; apuntado en 0xF0F1
	inc a			;5489
	ld (08000h),a		;548a   ; el banco 2 a 0x8000
	inc hl			;548d   ; la copia siguiente
	ld (hl),a			;548e   ; apuntado en 0xF0F2
	inc a			;548f
	ld (0a000h),a		;5490   ; el banco 3 a 0xA000
	inc hl			;5493   ; la copia siguiente
	ld (hl),a			;5494   ; apuntado en 0xF0F3
	pop hl			;5495   ; HL, como estaba
	ei			;5496   ; el mapa ya esta entero
	ret			;5497
L_5498:
	di			;5498   ; sin interrupciones mientras cambia el mapa
	push hl			;5499   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;549a   ; las tres copias, seguidas
	ld a,007h		;549d
	ld (06000h),a		;549f   ; el banco 7 a 0x6000
	ld (hl),a			;54a2   ; apuntado en 0xF0F1
	inc a			;54a3
	ld (08000h),a		;54a4   ; el banco 8 a 0x8000
	inc hl			;54a7   ; la copia siguiente
	ld (hl),a			;54a8   ; apuntado en 0xF0F2
	inc a			;54a9
	ld (0a000h),a		;54aa   ; el banco 9 a 0xA000
	inc hl			;54ad   ; la copia siguiente
	ld (hl),a			;54ae   ; apuntado en 0xF0F3
	pop hl			;54af   ; HL, como estaba
	ei			;54b0   ; el mapa ya esta entero
	ld a,(0e0a1h)		;54b1   ; el DECORADO, de 0 a 9
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
	call pinta		;54ce   ; el guion 0x90E7 del banco 8: 296 bytes de colores (0x12B8-0x13DF)
	ld de,09105h		;54d1
	ld hl,013e0h		;54d4
	ld c,080h		;54d7
	call pinta		;54d9   ; el guion 0x9105 del banco 8: 112 bytes de colores (0x13E0-0x144F)
	ld de,09138h		;54dc
	ld hl,01450h		;54df
	ld c,080h		;54e2
	call pinta		;54e4   ; el guion 0x9138 del banco 8: 432 bytes de colores (0x1450-0x15FF)
	ld de,09150h		;54e7
	ld hl,01600h		;54ea
	ld c,080h		;54ed
	call pinta		;54ef   ; el guion 0x9150 del banco 8: 248 bytes de colores (0x1600-0x16F7)
	di			;54f2   ; sin interrupciones mientras cambia el mapa
	push hl			;54f3   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;54f4   ; las tres copias, seguidas
	ld a,001h		;54f7
	ld (06000h),a		;54f9   ; el banco 1 a 0x6000
	ld (hl),a			;54fc   ; apuntado en 0xF0F1
	inc a			;54fd
	ld (08000h),a		;54fe   ; el banco 2 a 0x8000
	inc hl			;5501   ; la copia siguiente
	ld (hl),a			;5502   ; apuntado en 0xF0F2
	inc a			;5503
	ld (0a000h),a		;5504   ; el banco 3 a 0xA000
	inc hl			;5507   ; la copia siguiente
	ld (hl),a			;5508   ; apuntado en 0xF0F3
	pop hl			;5509   ; HL, como estaba
	ei			;550a   ; el mapa ya esta entero
	ret			;550b
L_550C:
	di			;550c   ; sin interrupciones mientras cambia el mapa
	push hl			;550d   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;550e   ; las tres copias, seguidas
	ld a,004h		;5511
	ld (06000h),a		;5513   ; el banco 4 a 0x6000
	ld (hl),a			;5516   ; apuntado en 0xF0F1
	inc a			;5517
	ld (08000h),a		;5518   ; el banco 5 a 0x8000
	inc hl			;551b   ; la copia siguiente
	ld (hl),a			;551c   ; apuntado en 0xF0F2
	inc a			;551d
	ld (0a000h),a		;551e   ; el banco 6 a 0xA000
	inc hl			;5521   ; la copia siguiente
	ld (hl),a			;5522   ; apuntado en 0xF0F3
	pop hl			;5523   ; HL, como estaba
	ei			;5524   ; el mapa ya esta entero
	ld de,0bcbch		;5525
	call pinta_sin_color		;5528   ; el guion 0xBCBC del banco 6: 144 bytes de patrones (0x3718-0x37A7)
	ld de,0bcfdh		;552b
	ld hl,037a8h		;552e
	ld c,001h		;5531
	call pinta		;5533   ; el guion 0xBCFD del banco 6: 72 bytes de patrones (0x37A8-0x37EF)
	ld de,0bd42h		;5536
	call pinta_sin_color		;5539   ; el guion 0xBD42 del banco 6: 144 bytes de colores (0x1718-0x17A7)
	ld de,0bd70h		;553c
	ld hl,017a8h		;553f
	ld c,000h		;5542
	call pinta		;5544   ; el guion 0xBD70 del banco 6: 72 bytes de colores (0x17A8-0x17EF)
	di			;5547   ; sin interrupciones mientras cambia el mapa
	push hl			;5548   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5549   ; las tres copias, seguidas
	ld a,001h		;554c
	ld (06000h),a		;554e   ; el banco 1 a 0x6000
	ld (hl),a			;5551   ; apuntado en 0xF0F1
	inc a			;5552
	ld (08000h),a		;5553   ; el banco 2 a 0x8000
	inc hl			;5556   ; la copia siguiente
	ld (hl),a			;5557   ; apuntado en 0xF0F2
	inc a			;5558
	ld (0a000h),a		;5559   ; el banco 3 a 0xA000
	inc hl			;555c   ; la copia siguiente
	ld (hl),a			;555d   ; apuntado en 0xF0F3
	pop hl			;555e   ; HL, como estaba
	ei			;555f   ; el mapa ya esta entero
	ret			;5560
L_5561:
	di			;5561   ; sin interrupciones mientras cambia el mapa
	push hl			;5562   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5563   ; las tres copias, seguidas
	ld a,007h		;5566
	ld (06000h),a		;5568   ; el banco 7 a 0x6000
	ld (hl),a			;556b   ; apuntado en 0xF0F1
	inc a			;556c
	ld (08000h),a		;556d   ; el banco 8 a 0x8000
	inc hl			;5570   ; la copia siguiente
	ld (hl),a			;5571   ; apuntado en 0xF0F2
	inc a			;5572
	ld (0a000h),a		;5573   ; el banco 9 a 0xA000
	inc hl			;5576   ; la copia siguiente
	ld (hl),a			;5577   ; apuntado en 0xF0F3
	pop hl			;5578   ; HL, como estaba
	ei			;5579   ; el mapa ya esta entero
	ld de,091a3h		;557a
	call pinta_sin_color		;557d   ; el guion 0x91A3 del banco 8: 88 bytes de patrones (0x2C68-0x2CBF)
	ld de,091bah		;5580
	ld hl,02cc0h		;5583
	ld c,001h		;5586
	call pinta		;5588   ; el guion 0x91BA del banco 8: 56 bytes de patrones (0x2CC0-0x2CF7)
	ld de,09209h		;558b
	call pinta_sin_color		;558e   ; el guion 0x9209 del banco 8: 32 bytes de patrones (0x32B8-0x32D7)
	ld de,0920bh		;5591
	ld hl,032d8h		;5594
	ld c,001h		;5597
	call pinta		;5599   ; el guion 0x920B del banco 8: 32 bytes de patrones (0x32D8-0x32F7)
	ld a,(0e0a1h)		;559c   ; el DECORADO, de 0 a 9
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
	call pinta		;55b9   ; el guion 0x91EE del banco 8: 88 bytes de colores (0x0C68-0x0CBF)
	ld de,091fch		;55bc
	ld hl,00cc0h		;55bf
	ld c,080h		;55c2
	call pinta		;55c4   ; el guion 0x91FC del banco 8: 56 bytes de colores (0x0CC0-0x0CF7)
	ld de,09226h		;55c7
	ld hl,012b8h		;55ca
	ld c,080h		;55cd
	call pinta		;55cf   ; el guion 0x9226 del banco 8: 32 bytes de colores (0x12B8-0x12D7)
	ld de,09226h		;55d2
	ld hl,012d8h		;55d5
	ld c,080h		;55d8
	call pinta		;55da   ; el guion 0x9226 del banco 8: 32 bytes de colores (0x12D8-0x12F7)
	di			;55dd   ; sin interrupciones mientras cambia el mapa
	push hl			;55de   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;55df   ; las tres copias, seguidas
	ld a,001h		;55e2
	ld (06000h),a		;55e4   ; el banco 1 a 0x6000
	ld (hl),a			;55e7   ; apuntado en 0xF0F1
	inc a			;55e8
	ld (08000h),a		;55e9   ; el banco 2 a 0x8000
	inc hl			;55ec   ; la copia siguiente
	ld (hl),a			;55ed   ; apuntado en 0xF0F2
	inc a			;55ee
	ld (0a000h),a		;55ef   ; el banco 3 a 0xA000
	inc hl			;55f2   ; la copia siguiente
	ld (hl),a			;55f3   ; apuntado en 0xF0F3
	pop hl			;55f4   ; HL, como estaba
	ei			;55f5   ; el mapa ya esta entero
	ret			;55f6
L_55F7:
	di			;55f7   ; sin interrupciones mientras cambia el mapa
	push hl			;55f8   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;55f9   ; las tres copias, seguidas
	ld a,007h		;55fc
	ld (06000h),a		;55fe   ; el banco 7 a 0x6000
	ld (hl),a			;5601   ; apuntado en 0xF0F1
	inc a			;5602
	ld (08000h),a		;5603   ; el banco 8 a 0x8000
	inc hl			;5606   ; la copia siguiente
	ld (hl),a			;5607   ; apuntado en 0xF0F2
	inc a			;5608
	ld (0a000h),a		;5609   ; el banco 9 a 0xA000
	inc hl			;560c   ; la copia siguiente
	ld (hl),a			;560d   ; apuntado en 0xF0F3
	pop hl			;560e   ; HL, como estaba
	ei			;560f   ; el mapa ya esta entero
	ld de,07e3ah		;5610
	call pinta_sin_color		;5613   ; el guion 0x7E3A del banco 7: 704 bytes de patrones de sprite (0x19A0-0x1C5F)
	ld de,082ddh		;5616
	call pinta_sin_color		;5619   ; el guion 0x82DD del banco 8: 544 bytes de patrones de sprite (0x1C60-0x1E7F)
	ld a,(0e08bh)		;561c   ; el largo de la fase
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
	call dos_por_a_mas_hl		;563c
	ld e,(hl)			;563f
	inc hl			;5640
	ld d,(hl)			;5641
L_5642:
	call pinta_sin_color		;5642
	di			;5645   ; sin interrupciones mientras cambia el mapa
	push hl			;5646   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5647   ; las tres copias, seguidas
	ld a,001h		;564a
	ld (06000h),a		;564c   ; el banco 1 a 0x6000
	ld (hl),a			;564f   ; apuntado en 0xF0F1
	inc a			;5650
	ld (08000h),a		;5651   ; el banco 2 a 0x8000
	inc hl			;5654   ; la copia siguiente
	ld (hl),a			;5655   ; apuntado en 0xF0F2
	inc a			;5656
	ld (0a000h),a		;5657   ; el banco 3 a 0xA000
	inc hl			;565a   ; la copia siguiente
	ld (hl),a			;565b   ; apuntado en 0xF0F3
	pop hl			;565c   ; HL, como estaba
	ei			;565d   ; el mapa ya esta entero
	ret			;565e

; ----------------------------------------------------------------------
; DATOS sin identificar  0x565f..0x5667  (8 bytes)
DATA_565F:
	defb 052h,084h,092h,084h,0d6h,084h,009h,085h	; 565f  R.......

; ======================================================================
; CODIGO 0x5667..0x5e3a  (2003 bytes)
; ======================================================================


L_5667:
	di			;5667   ; sin interrupciones mientras cambia el mapa
	push hl			;5668   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5669   ; las tres copias, seguidas
	ld a,007h		;566c
	ld (06000h),a		;566e   ; el banco 7 a 0x6000
	ld (hl),a			;5671   ; apuntado en 0xF0F1
	inc a			;5672
	ld (08000h),a		;5673   ; el banco 8 a 0x8000
	inc hl			;5676   ; la copia siguiente
	ld (hl),a			;5677   ; apuntado en 0xF0F2
	inc a			;5678
	ld (0a000h),a		;5679   ; el banco 9 a 0xA000
	inc hl			;567c   ; la copia siguiente
	ld (hl),a			;567d   ; apuntado en 0xF0F3
	pop hl			;567e   ; HL, como estaba
	ei			;567f   ; el mapa ya esta entero
	ld de,07fbch		;5680
	call pinta_sin_color		;5683   ; el guion 0x7FBC del banco 7: 1056 bytes de patrones de sprite (0x19A0-0x1DBF)
	di			;5686   ; sin interrupciones mientras cambia el mapa
	push hl			;5687   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5688   ; las tres copias, seguidas
	ld a,001h		;568b
	ld (06000h),a		;568d   ; el banco 1 a 0x6000
	ld (hl),a			;5690   ; apuntado en 0xF0F1
	inc a			;5691
	ld (08000h),a		;5692   ; el banco 2 a 0x8000
	inc hl			;5695   ; la copia siguiente
	ld (hl),a			;5696   ; apuntado en 0xF0F2
	inc a			;5697
	ld (0a000h),a		;5698   ; el banco 3 a 0xA000
	inc hl			;569b   ; la copia siguiente
	ld (hl),a			;569c   ; apuntado en 0xF0F3
	pop hl			;569d   ; HL, como estaba
	ei			;569e   ; el mapa ya esta entero
	ret			;569f
L_56A0:
	di			;56a0   ; sin interrupciones mientras cambia el mapa
	push hl			;56a1   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;56a2   ; las tres copias, seguidas
	ld a,007h		;56a5
	ld (06000h),a		;56a7   ; el banco 7 a 0x6000
	ld (hl),a			;56aa   ; apuntado en 0xF0F1
	inc a			;56ab
	ld (08000h),a		;56ac   ; el banco 8 a 0x8000
	inc hl			;56af   ; la copia siguiente
	ld (hl),a			;56b0   ; apuntado en 0xF0F2
	inc a			;56b1
	ld (0a000h),a		;56b2   ; el banco 9 a 0xA000
	inc hl			;56b5   ; la copia siguiente
	ld (hl),a			;56b6   ; apuntado en 0xF0F3
	pop hl			;56b7   ; HL, como estaba
	ei			;56b8   ; el mapa ya esta entero
	ld de,081cfh		;56b9
	call pinta_sin_color		;56bc   ; el guion 0x81CF del banco 8: 160 bytes de patrones de sprite (0x19A0-0x1A3F)
	di			;56bf   ; sin interrupciones mientras cambia el mapa
	push hl			;56c0   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;56c1   ; las tres copias, seguidas
	ld a,001h		;56c4
	ld (06000h),a		;56c6   ; el banco 1 a 0x6000
	ld (hl),a			;56c9   ; apuntado en 0xF0F1
	inc a			;56ca
	ld (08000h),a		;56cb   ; el banco 2 a 0x8000
	inc hl			;56ce   ; la copia siguiente
	ld (hl),a			;56cf   ; apuntado en 0xF0F2
	inc a			;56d0
	ld (0a000h),a		;56d1   ; el banco 3 a 0xA000
	inc hl			;56d4   ; la copia siguiente
	ld (hl),a			;56d5   ; apuntado en 0xF0F3
	pop hl			;56d6   ; HL, como estaba
	ei			;56d7   ; el mapa ya esta entero
	ret			;56d8
L_56D9:
	di			;56d9   ; sin interrupciones mientras cambia el mapa
	push hl			;56da   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;56db   ; las tres copias, seguidas
	ld a,007h		;56de
	ld (06000h),a		;56e0   ; el banco 7 a 0x6000
	ld (hl),a			;56e3   ; apuntado en 0xF0F1
	inc a			;56e4
	ld (08000h),a		;56e5   ; el banco 8 a 0x8000
	inc hl			;56e8   ; la copia siguiente
	ld (hl),a			;56e9   ; apuntado en 0xF0F2
	inc a			;56ea
	ld (0a000h),a		;56eb   ; el banco 9 a 0xA000
	inc hl			;56ee   ; la copia siguiente
	ld (hl),a			;56ef   ; apuntado en 0xF0F3
	pop hl			;56f0   ; HL, como estaba
	ei			;56f1   ; el mapa ya esta entero
	ld de,07e3ch		;56f2
	ld hl,01ca0h		;56f5
	ld c,000h		;56f8
	call pinta		;56fa   ; el guion 0x7E3C del banco 7: 704 bytes de patrones de sprite (0x1CA0-0x1F5F)
	di			;56fd   ; sin interrupciones mientras cambia el mapa
	push hl			;56fe   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;56ff   ; las tres copias, seguidas
	ld a,001h		;5702
	ld (06000h),a		;5704   ; el banco 1 a 0x6000
	ld (hl),a			;5707   ; apuntado en 0xF0F1
	inc a			;5708
	ld (08000h),a		;5709   ; el banco 2 a 0x8000
	inc hl			;570c   ; la copia siguiente
	ld (hl),a			;570d   ; apuntado en 0xF0F2
	inc a			;570e
	ld (0a000h),a		;570f   ; el banco 3 a 0xA000
	inc hl			;5712   ; la copia siguiente
	ld (hl),a			;5713   ; apuntado en 0xF0F3
	pop hl			;5714   ; HL, como estaba
	ei			;5715   ; el mapa ya esta entero
	ret			;5716
L_5717:
	di			;5717   ; sin interrupciones mientras cambia el mapa
	push hl			;5718   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5719   ; las tres copias, seguidas
	ld a,007h		;571c
	ld (06000h),a		;571e   ; el banco 7 a 0x6000
	ld (hl),a			;5721   ; apuntado en 0xF0F1
	inc a			;5722
	ld (08000h),a		;5723   ; el banco 8 a 0x8000
	inc hl			;5726   ; la copia siguiente
	ld (hl),a			;5727   ; apuntado en 0xF0F2
	inc a			;5728
	ld (0a000h),a		;5729   ; el banco 9 a 0xA000
	inc hl			;572c   ; la copia siguiente
	ld (hl),a			;572d   ; apuntado en 0xF0F3
	pop hl			;572e   ; HL, como estaba
	ei			;572f   ; el mapa ya esta entero
	ld de,0852ch		;5730
	call pinta_sin_color		;5733   ; el guion 0x852C del banco 8: 384 bytes de patrones de sprite (0x1DC0-0x1F3F)
	di			;5736   ; sin interrupciones mientras cambia el mapa
	push hl			;5737   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5738   ; las tres copias, seguidas
	ld a,001h		;573b
	ld (06000h),a		;573d   ; el banco 1 a 0x6000
	ld (hl),a			;5740   ; apuntado en 0xF0F1
	inc a			;5741
	ld (08000h),a		;5742   ; el banco 2 a 0x8000
	inc hl			;5745   ; la copia siguiente
	ld (hl),a			;5746   ; apuntado en 0xF0F2
	inc a			;5747
	ld (0a000h),a		;5748   ; el banco 3 a 0xA000
	inc hl			;574b   ; la copia siguiente
	ld (hl),a			;574c   ; apuntado en 0xF0F3
	pop hl			;574d   ; HL, como estaba
	ei			;574e   ; el mapa ya esta entero
	ret			;574f
L_5750:
	di			;5750   ; sin interrupciones mientras cambia el mapa
	push hl			;5751   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5752   ; las tres copias, seguidas
	ld a,007h		;5755
	ld (06000h),a		;5757   ; el banco 7 a 0x6000
	ld (hl),a			;575a   ; apuntado en 0xF0F1
	inc a			;575b
	ld (08000h),a		;575c   ; el banco 8 a 0x8000
	inc hl			;575f   ; la copia siguiente
	ld (hl),a			;5760   ; apuntado en 0xF0F2
	inc a			;5761
	ld (0a000h),a		;5762   ; el banco 9 a 0xA000
	inc hl			;5765   ; la copia siguiente
	ld (hl),a			;5766   ; apuntado en 0xF0F3
	pop hl			;5767   ; HL, como estaba
	ei			;5768   ; el mapa ya esta entero
	ld de,07d6fh		;5769
	call pinta_sin_color		;576c   ; el guion 0x7D6F del banco 7: 320 bytes de patrones de sprite (0x1DC0-0x1EFF)
	di			;576f   ; sin interrupciones mientras cambia el mapa
	push hl			;5770   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5771   ; las tres copias, seguidas
	ld a,001h		;5774
	ld (06000h),a		;5776   ; el banco 1 a 0x6000
	ld (hl),a			;5779   ; apuntado en 0xF0F1
	inc a			;577a
	ld (08000h),a		;577b   ; el banco 2 a 0x8000
	inc hl			;577e   ; la copia siguiente
	ld (hl),a			;577f   ; apuntado en 0xF0F2
	inc a			;5780
	ld (0a000h),a		;5781   ; el banco 3 a 0xA000
	inc hl			;5784   ; la copia siguiente
	ld (hl),a			;5785   ; apuntado en 0xF0F3
	pop hl			;5786   ; HL, como estaba
	ei			;5787   ; el mapa ya esta entero
	ret			;5788
L_5789:
	di			;5789   ; sin interrupciones mientras cambia el mapa
	push hl			;578a   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;578b   ; las tres copias, seguidas
	ld a,007h		;578e
	ld (06000h),a		;5790   ; el banco 7 a 0x6000
	ld (hl),a			;5793   ; apuntado en 0xF0F1
	inc a			;5794
	ld (08000h),a		;5795   ; el banco 8 a 0x8000
	inc hl			;5798   ; la copia siguiente
	ld (hl),a			;5799   ; apuntado en 0xF0F2
	inc a			;579a
	ld (0a000h),a		;579b   ; el banco 9 a 0xA000
	inc hl			;579e   ; la copia siguiente
	ld (hl),a			;579f   ; apuntado en 0xF0F3
	pop hl			;57a0   ; HL, como estaba
	ei			;57a1   ; el mapa ya esta entero
	ld de,082adh		;57a2
	call pinta_sin_color		;57a5   ; el guion 0x82AD del banco 8: 121 bytes de patrones de sprite (0x1F80-0x1FF8)
	di			;57a8   ; sin interrupciones mientras cambia el mapa
	push hl			;57a9   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;57aa   ; las tres copias, seguidas
	ld a,001h		;57ad
	ld (06000h),a		;57af   ; el banco 1 a 0x6000
	ld (hl),a			;57b2   ; apuntado en 0xF0F1
	inc a			;57b3
	ld (08000h),a		;57b4   ; el banco 2 a 0x8000
	inc hl			;57b7   ; la copia siguiente
	ld (hl),a			;57b8   ; apuntado en 0xF0F2
	inc a			;57b9
	ld (0a000h),a		;57ba   ; el banco 3 a 0xA000
	inc hl			;57bd   ; la copia siguiente
	ld (hl),a			;57be   ; apuntado en 0xF0F3
	pop hl			;57bf   ; HL, como estaba
	ei			;57c0   ; el mapa ya esta entero
	ret			;57c1
L_57C2:
	di			;57c2   ; sin interrupciones mientras cambia el mapa
	push hl			;57c3   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;57c4   ; las tres copias, seguidas
	ld a,007h		;57c7
	ld (06000h),a		;57c9   ; el banco 7 a 0x6000
	ld (hl),a			;57cc   ; apuntado en 0xF0F1
	inc a			;57cd
	ld (08000h),a		;57ce   ; el banco 8 a 0x8000
	inc hl			;57d1   ; la copia siguiente
	ld (hl),a			;57d2   ; apuntado en 0xF0F2
	inc a			;57d3
	ld (0a000h),a		;57d4   ; el banco 9 a 0xA000
	inc hl			;57d7   ; la copia siguiente
	ld (hl),a			;57d8   ; apuntado en 0xF0F3
	pop hl			;57d9   ; HL, como estaba
	ei			;57da   ; el mapa ya esta entero
	ld de,0823ah		;57db
	call pinta_sin_color		;57de   ; el guion 0x823A del banco 8: 192 bytes de patrones de sprite (0x1D00-0x1DBF)
	di			;57e1   ; sin interrupciones mientras cambia el mapa
	push hl			;57e2   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;57e3   ; las tres copias, seguidas
	ld a,001h		;57e6
	ld (06000h),a		;57e8   ; el banco 1 a 0x6000
	ld (hl),a			;57eb   ; apuntado en 0xF0F1
	inc a			;57ec
	ld (08000h),a		;57ed   ; el banco 2 a 0x8000
	inc hl			;57f0   ; la copia siguiente
	ld (hl),a			;57f1   ; apuntado en 0xF0F2
	inc a			;57f2
	ld (0a000h),a		;57f3   ; el banco 3 a 0xA000
	inc hl			;57f6   ; la copia siguiente
	ld (hl),a			;57f7   ; apuntado en 0xF0F3
	pop hl			;57f8   ; HL, como estaba
	ei			;57f9   ; el mapa ya esta entero
	ret			;57fa
L_57FB:
	di			;57fb   ; sin interrupciones mientras cambia el mapa
	push hl			;57fc   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;57fd   ; las tres copias, seguidas
	ld a,007h		;5800
	ld (06000h),a		;5802   ; el banco 7 a 0x6000
	ld (hl),a			;5805   ; apuntado en 0xF0F1
	inc a			;5806
	ld (08000h),a		;5807   ; el banco 8 a 0x8000
	inc hl			;580a   ; la copia siguiente
	ld (hl),a			;580b   ; apuntado en 0xF0F2
	inc a			;580c
	ld (0a000h),a		;580d   ; el banco 9 a 0xA000
	inc hl			;5810   ; la copia siguiente
	ld (hl),a			;5811   ; apuntado en 0xF0F3
	pop hl			;5812   ; HL, como estaba
	ei			;5813   ; el mapa ya esta entero
	ld a,(0e0a1h)		;5814   ; el DECORADO, de 0 a 9
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
	call pinta_bloque		;5831
	call pinta_sin_color		;5834
	jr L_5845		;5837
L_5839:
	ld de,08600h		;5839
	ld bc,00301h		;583c
	call pinta_bloque		;583f
	call pinta_sin_color		;5842
L_5845:
	ld a,(0e0a1h)		;5845   ; el DECORADO, de 0 a 9
	cp 004h		;5848
	jr z,L_5850		;584a
	cp 005h		;584c
	jr nz,L_586D		;584e
L_5850:
	ld de,07af2h		;5850
	ld bc,00201h		;5853
	call pinta_bloque		;5856
	jr L_586D		;5859
L_585B:
	ld de,079c7h		;585b
	ld bc,00200h		;585e
	call pinta_bloque		;5861
	ld bc,00101h		;5864
	call pinta_bloque		;5867
	call pinta_sin_color		;586a
L_586D:
	ld de,07b34h		;586d
	ld bc,00800h		;5870
	call pinta_bloque		;5873
	ld bc,00301h		;5876
	call pinta_bloque		;5879
	call pinta_sin_color		;587c
	ld a,(0e0a1h)		;587f   ; el DECORADO, de 0 a 9
	cp 002h		;5882
	jr z,L_588E		;5884
	cp 003h		;5886
	jr z,L_588E		;5888
	cp 006h		;588a
	jr nz,L_5897		;588c
L_588E:
	ld de,086d3h		;588e
	ld bc,00101h		;5891
	call pinta_bloque		;5894
L_5897:
	di			;5897   ; sin interrupciones mientras cambia el mapa
	push hl			;5898   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5899   ; las tres copias, seguidas
	ld a,001h		;589c
	ld (06000h),a		;589e   ; el banco 1 a 0x6000
	ld (hl),a			;58a1   ; apuntado en 0xF0F1
	inc a			;58a2
	ld (08000h),a		;58a3   ; el banco 2 a 0x8000
	inc hl			;58a6   ; la copia siguiente
	ld (hl),a			;58a7   ; apuntado en 0xF0F2
	inc a			;58a8
	ld (0a000h),a		;58a9   ; el banco 3 a 0xA000
	inc hl			;58ac   ; la copia siguiente
	ld (hl),a			;58ad   ; apuntado en 0xF0F3
	pop hl			;58ae   ; HL, como estaba
	ei			;58af   ; el mapa ya esta entero
	ret			;58b0
L_58B1:
	di			;58b1   ; sin interrupciones mientras cambia el mapa
	push hl			;58b2   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;58b3   ; las tres copias, seguidas
	ld a,007h		;58b6
	ld (06000h),a		;58b8   ; el banco 7 a 0x6000
	ld (hl),a			;58bb   ; apuntado en 0xF0F1
	inc a			;58bc
	ld (08000h),a		;58bd   ; el banco 8 a 0x8000
	inc hl			;58c0   ; la copia siguiente
	ld (hl),a			;58c1   ; apuntado en 0xF0F2
	inc a			;58c2
	ld (0a000h),a		;58c3   ; el banco 9 a 0xA000
	inc hl			;58c6   ; la copia siguiente
	ld (hl),a			;58c7   ; apuntado en 0xF0F3
	pop hl			;58c8   ; HL, como estaba
	ei			;58c9   ; el mapa ya esta entero
	ld de,078f1h		;58ca
	ld bc,00301h		;58cd
	call pinta_bloque		;58d0
	call pinta_sin_color		;58d3
	di			;58d6   ; sin interrupciones mientras cambia el mapa
	push hl			;58d7   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;58d8   ; las tres copias, seguidas
	ld a,001h		;58db
	ld (06000h),a		;58dd   ; el banco 1 a 0x6000
	ld (hl),a			;58e0   ; apuntado en 0xF0F1
	inc a			;58e1
	ld (08000h),a		;58e2   ; el banco 2 a 0x8000
	inc hl			;58e5   ; la copia siguiente
	ld (hl),a			;58e6   ; apuntado en 0xF0F2
	inc a			;58e7
	ld (0a000h),a		;58e8   ; el banco 3 a 0xA000
	inc hl			;58eb   ; la copia siguiente
	ld (hl),a			;58ec   ; apuntado en 0xF0F3
	pop hl			;58ed   ; HL, como estaba
	ei			;58ee   ; el mapa ya esta entero
	ret			;58ef
L_58F0:
	di			;58f0   ; sin interrupciones mientras cambia el mapa
	push hl			;58f1   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;58f2   ; las tres copias, seguidas
	ld a,007h		;58f5
	ld (06000h),a		;58f7   ; el banco 7 a 0x6000
	ld (hl),a			;58fa   ; apuntado en 0xF0F1
	inc a			;58fb
	ld (08000h),a		;58fc   ; el banco 8 a 0x8000
	inc hl			;58ff   ; la copia siguiente
	ld (hl),a			;5900   ; apuntado en 0xF0F2
	inc a			;5901
	ld (0a000h),a		;5902   ; el banco 9 a 0xA000
	inc hl			;5905   ; la copia siguiente
	ld (hl),a			;5906   ; apuntado en 0xF0F3
	pop hl			;5907   ; HL, como estaba
	ei			;5908   ; el mapa ya esta entero
	ld de,07af2h		;5909
	ld bc,00201h		;590c
	call pinta_bloque		;590f
	di			;5912   ; sin interrupciones mientras cambia el mapa
	push hl			;5913   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5914   ; las tres copias, seguidas
	ld a,001h		;5917
	ld (06000h),a		;5919   ; el banco 1 a 0x6000
	ld (hl),a			;591c   ; apuntado en 0xF0F1
	inc a			;591d
	ld (08000h),a		;591e   ; el banco 2 a 0x8000
	inc hl			;5921   ; la copia siguiente
	ld (hl),a			;5922   ; apuntado en 0xF0F2
	inc a			;5923
	ld (0a000h),a		;5924   ; el banco 3 a 0xA000
	inc hl			;5927   ; la copia siguiente
	ld (hl),a			;5928   ; apuntado en 0xF0F3
	pop hl			;5929   ; HL, como estaba
	ei			;592a   ; el mapa ya esta entero
	ret			;592b
L_592C:
	di			;592c   ; sin interrupciones mientras cambia el mapa
	push hl			;592d   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;592e   ; las tres copias, seguidas
	ld a,007h		;5931
	ld (06000h),a		;5933   ; el banco 7 a 0x6000
	ld (hl),a			;5936   ; apuntado en 0xF0F1
	inc a			;5937
	ld (08000h),a		;5938   ; el banco 8 a 0x8000
	inc hl			;593b   ; la copia siguiente
	ld (hl),a			;593c   ; apuntado en 0xF0F2
	inc a			;593d
	ld (0a000h),a		;593e   ; el banco 9 a 0xA000
	inc hl			;5941   ; la copia siguiente
	ld (hl),a			;5942   ; apuntado en 0xF0F3
	pop hl			;5943   ; HL, como estaba
	ei			;5944   ; el mapa ya esta entero
	ld de,08600h		;5945
	ld bc,00301h		;5948
	call pinta_bloque		;594b
	call pinta_sin_color		;594e
	ld de,086d3h		;5951
	ld bc,00101h		;5954
	call pinta_bloque		;5957
	di			;595a   ; sin interrupciones mientras cambia el mapa
	push hl			;595b   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;595c   ; las tres copias, seguidas
	ld a,001h		;595f
	ld (06000h),a		;5961   ; el banco 1 a 0x6000
	ld (hl),a			;5964   ; apuntado en 0xF0F1
	inc a			;5965
	ld (08000h),a		;5966   ; el banco 2 a 0x8000
	inc hl			;5969   ; la copia siguiente
	ld (hl),a			;596a   ; apuntado en 0xF0F2
	inc a			;596b
	ld (0a000h),a		;596c   ; el banco 3 a 0xA000
	inc hl			;596f   ; la copia siguiente
	ld (hl),a			;5970   ; apuntado en 0xF0F3
	pop hl			;5971   ; HL, como estaba
	ei			;5972   ; el mapa ya esta entero
	ret			;5973
L_5974:
	di			;5974   ; sin interrupciones mientras cambia el mapa
	push hl			;5975   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5976   ; las tres copias, seguidas
	ld a,007h		;5979
	ld (06000h),a		;597b   ; el banco 7 a 0x6000
	ld (hl),a			;597e   ; apuntado en 0xF0F1
	inc a			;597f
	ld (08000h),a		;5980   ; el banco 8 a 0x8000
	inc hl			;5983   ; la copia siguiente
	ld (hl),a			;5984   ; apuntado en 0xF0F2
	inc a			;5985
	ld (0a000h),a		;5986   ; el banco 9 a 0xA000
	inc hl			;5989   ; la copia siguiente
	ld (hl),a			;598a   ; apuntado en 0xF0F3
	pop hl			;598b   ; HL, como estaba
	ei			;598c   ; el mapa ya esta entero
	jp L_586D		;598d
L_5990:
	di			;5990   ; sin interrupciones mientras cambia el mapa
	push hl			;5991   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5992   ; las tres copias, seguidas
	ld a,007h		;5995
	ld (06000h),a		;5997   ; el banco 7 a 0x6000
	ld (hl),a			;599a   ; apuntado en 0xF0F1
	inc a			;599b
	ld (08000h),a		;599c   ; el banco 8 a 0x8000
	inc hl			;599f   ; la copia siguiente
	ld (hl),a			;59a0   ; apuntado en 0xF0F2
	inc a			;59a1
	ld (0a000h),a		;59a2   ; el banco 9 a 0xA000
	inc hl			;59a5   ; la copia siguiente
	ld (hl),a			;59a6   ; apuntado en 0xF0F3
	pop hl			;59a7   ; HL, como estaba
	ei			;59a8   ; el mapa ya esta entero
	ld de,086f5h		;59a9
	call pinta_sin_color		;59ac   ; el guion 0x86F5 del banco 8: 96 bytes de patrones de sprite (0x1D20-0x1D7F)
	di			;59af   ; sin interrupciones mientras cambia el mapa
	push hl			;59b0   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;59b1   ; las tres copias, seguidas
	ld a,001h		;59b4
	ld (06000h),a		;59b6   ; el banco 1 a 0x6000
	ld (hl),a			;59b9   ; apuntado en 0xF0F1
	inc a			;59ba
	ld (08000h),a		;59bb   ; el banco 2 a 0x8000
	inc hl			;59be   ; la copia siguiente
	ld (hl),a			;59bf   ; apuntado en 0xF0F2
	inc a			;59c0
	ld (0a000h),a		;59c1   ; el banco 3 a 0xA000
	inc hl			;59c4   ; la copia siguiente
	ld (hl),a			;59c5   ; apuntado en 0xF0F3
	pop hl			;59c6   ; HL, como estaba
	ei			;59c7   ; el mapa ya esta entero
	ret			;59c8
L_59C9:
	di			;59c9   ; sin interrupciones mientras cambia el mapa
	push hl			;59ca   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;59cb   ; las tres copias, seguidas
	ld a,007h		;59ce
	ld (06000h),a		;59d0   ; el banco 7 a 0x6000
	ld (hl),a			;59d3   ; apuntado en 0xF0F1
	inc a			;59d4
	ld (08000h),a		;59d5   ; el banco 8 a 0x8000
	inc hl			;59d8   ; la copia siguiente
	ld (hl),a			;59d9   ; apuntado en 0xF0F2
	inc a			;59da
	ld (0a000h),a		;59db   ; el banco 9 a 0xA000
	inc hl			;59de   ; la copia siguiente
	ld (hl),a			;59df   ; apuntado en 0xF0F3
	pop hl			;59e0   ; HL, como estaba
	ei			;59e1   ; el mapa ya esta entero
	ld de,08757h		;59e2
	call pinta_sin_color		;59e5   ; el guion 0x8757 del banco 8: 96 bytes de patrones de sprite (0x1D20-0x1D7F)
	di			;59e8   ; sin interrupciones mientras cambia el mapa
	push hl			;59e9   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;59ea   ; las tres copias, seguidas
	ld a,001h		;59ed
	ld (06000h),a		;59ef   ; el banco 1 a 0x6000
	ld (hl),a			;59f2   ; apuntado en 0xF0F1
	inc a			;59f3
	ld (08000h),a		;59f4   ; el banco 2 a 0x8000
	inc hl			;59f7   ; la copia siguiente
	ld (hl),a			;59f8   ; apuntado en 0xF0F2
	inc a			;59f9
	ld (0a000h),a		;59fa   ; el banco 3 a 0xA000
	inc hl			;59fd   ; la copia siguiente
	ld (hl),a			;59fe   ; apuntado en 0xF0F3
	pop hl			;59ff   ; HL, como estaba
	ei			;5a00   ; el mapa ya esta entero
	ret			;5a01
L_5A02:
	di			;5a02   ; sin interrupciones mientras cambia el mapa
	push hl			;5a03   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5a04   ; las tres copias, seguidas
	ld a,007h		;5a07
	ld (06000h),a		;5a09   ; el banco 7 a 0x6000
	ld (hl),a			;5a0c   ; apuntado en 0xF0F1
	inc a			;5a0d
	ld (08000h),a		;5a0e   ; el banco 8 a 0x8000
	inc hl			;5a11   ; la copia siguiente
	ld (hl),a			;5a12   ; apuntado en 0xF0F2
	inc a			;5a13
	ld (0a000h),a		;5a14   ; el banco 9 a 0xA000
	inc hl			;5a17   ; la copia siguiente
	ld (hl),a			;5a18   ; apuntado en 0xF0F3
	pop hl			;5a19   ; HL, como estaba
	ei			;5a1a   ; el mapa ya esta entero
	ld de,087b8h		;5a1b
	call pinta_sin_color		;5a1e   ; el guion 0x87B8 del banco 8: 128 bytes de patrones de sprite (0x1D80-0x1DFF)
	di			;5a21   ; sin interrupciones mientras cambia el mapa
	push hl			;5a22   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5a23   ; las tres copias, seguidas
	ld a,001h		;5a26
	ld (06000h),a		;5a28   ; el banco 1 a 0x6000
	ld (hl),a			;5a2b   ; apuntado en 0xF0F1
	inc a			;5a2c
	ld (08000h),a		;5a2d   ; el banco 2 a 0x8000
	inc hl			;5a30   ; la copia siguiente
	ld (hl),a			;5a31   ; apuntado en 0xF0F2
	inc a			;5a32
	ld (0a000h),a		;5a33   ; el banco 3 a 0xA000
	inc hl			;5a36   ; la copia siguiente
	ld (hl),a			;5a37   ; apuntado en 0xF0F3
	pop hl			;5a38   ; HL, como estaba
	ei			;5a39   ; el mapa ya esta entero
	ret			;5a3a
L_5A3B:
	di			;5a3b   ; sin interrupciones mientras cambia el mapa
	push hl			;5a3c   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5a3d   ; las tres copias, seguidas
	ld a,007h		;5a40
	ld (06000h),a		;5a42   ; el banco 7 a 0x6000
	ld (hl),a			;5a45   ; apuntado en 0xF0F1
	inc a			;5a46
	ld (08000h),a		;5a47   ; el banco 8 a 0x8000
	inc hl			;5a4a   ; la copia siguiente
	ld (hl),a			;5a4b   ; apuntado en 0xF0F2
	inc a			;5a4c
	ld (0a000h),a		;5a4d   ; el banco 9 a 0xA000
	inc hl			;5a50   ; la copia siguiente
	ld (hl),a			;5a51   ; apuntado en 0xF0F3
	pop hl			;5a52   ; HL, como estaba
	ei			;5a53   ; el mapa ya esta entero
	ld de,0882eh		;5a54
	call pinta_sin_color		;5a57   ; el guion 0x882E del banco 8: 128 bytes de patrones de sprite (0x1D80-0x1DFF)
	di			;5a5a   ; sin interrupciones mientras cambia el mapa
	push hl			;5a5b   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5a5c   ; las tres copias, seguidas
	ld a,001h		;5a5f
	ld (06000h),a		;5a61   ; el banco 1 a 0x6000
	ld (hl),a			;5a64   ; apuntado en 0xF0F1
	inc a			;5a65
	ld (08000h),a		;5a66   ; el banco 2 a 0x8000
	inc hl			;5a69   ; la copia siguiente
	ld (hl),a			;5a6a   ; apuntado en 0xF0F2
	inc a			;5a6b
	ld (0a000h),a		;5a6c   ; el banco 3 a 0xA000
	inc hl			;5a6f   ; la copia siguiente
	ld (hl),a			;5a70   ; apuntado en 0xF0F3
	pop hl			;5a71   ; HL, como estaba
	ei			;5a72   ; el mapa ya esta entero
	ret			;5a73
L_5A74:
	di			;5a74   ; sin interrupciones mientras cambia el mapa
	push hl			;5a75   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5a76   ; las tres copias, seguidas
	ld a,007h		;5a79
	ld (06000h),a		;5a7b   ; el banco 7 a 0x6000
	ld (hl),a			;5a7e   ; apuntado en 0xF0F1
	inc a			;5a7f
	ld (08000h),a		;5a80   ; el banco 8 a 0x8000
	inc hl			;5a83   ; la copia siguiente
	ld (hl),a			;5a84   ; apuntado en 0xF0F2
	inc a			;5a85
	ld (0a000h),a		;5a86   ; el banco 9 a 0xA000
	inc hl			;5a89   ; la copia siguiente
	ld (hl),a			;5a8a   ; apuntado en 0xF0F3
	pop hl			;5a8b   ; HL, como estaba
	ei			;5a8c   ; el mapa ya esta entero
	ld de,0888dh		;5a8d
	call pinta_sin_color		;5a90   ; el guion 0x888D del banco 8: 128 bytes de patrones de sprite (0x1D80-0x1DFF)
	di			;5a93   ; sin interrupciones mientras cambia el mapa
	push hl			;5a94   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5a95   ; las tres copias, seguidas
	ld a,001h		;5a98
	ld (06000h),a		;5a9a   ; el banco 1 a 0x6000
	ld (hl),a			;5a9d   ; apuntado en 0xF0F1
	inc a			;5a9e
	ld (08000h),a		;5a9f   ; el banco 2 a 0x8000
	inc hl			;5aa2   ; la copia siguiente
	ld (hl),a			;5aa3   ; apuntado en 0xF0F2
	inc a			;5aa4
	ld (0a000h),a		;5aa5   ; el banco 3 a 0xA000
	inc hl			;5aa8   ; la copia siguiente
	ld (hl),a			;5aa9   ; apuntado en 0xF0F3
	pop hl			;5aaa   ; HL, como estaba
	ei			;5aab   ; el mapa ya esta entero
	ret			;5aac
L_5AAD:
	di			;5aad   ; sin interrupciones mientras cambia el mapa
	push hl			;5aae   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5aaf   ; las tres copias, seguidas
	ld a,007h		;5ab2
	ld (06000h),a		;5ab4   ; el banco 7 a 0x6000
	ld (hl),a			;5ab7   ; apuntado en 0xF0F1
	inc a			;5ab8
	ld (08000h),a		;5ab9   ; el banco 8 a 0x8000
	inc hl			;5abc   ; la copia siguiente
	ld (hl),a			;5abd   ; apuntado en 0xF0F2
	inc a			;5abe
	ld (0a000h),a		;5abf   ; el banco 9 a 0xA000
	inc hl			;5ac2   ; la copia siguiente
	ld (hl),a			;5ac3   ; apuntado en 0xF0F3
	pop hl			;5ac4   ; HL, como estaba
	ei			;5ac5   ; el mapa ya esta entero
	ld de,088e8h		;5ac6
	call pinta_sin_color		;5ac9   ; el guion 0x88E8 del banco 8: 256 bytes de patrones de sprite (0x1E00-0x1EFF)
	di			;5acc   ; sin interrupciones mientras cambia el mapa
	push hl			;5acd   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5ace   ; las tres copias, seguidas
	ld a,001h		;5ad1
	ld (06000h),a		;5ad3   ; el banco 1 a 0x6000
	ld (hl),a			;5ad6   ; apuntado en 0xF0F1
	inc a			;5ad7
	ld (08000h),a		;5ad8   ; el banco 2 a 0x8000
	inc hl			;5adb   ; la copia siguiente
	ld (hl),a			;5adc   ; apuntado en 0xF0F2
	inc a			;5add
	ld (0a000h),a		;5ade   ; el banco 3 a 0xA000
	inc hl			;5ae1   ; la copia siguiente
	ld (hl),a			;5ae2   ; apuntado en 0xF0F3
	pop hl			;5ae3   ; HL, como estaba
	ei			;5ae4   ; el mapa ya esta entero
	ret			;5ae5
L_5AE6:
	di			;5ae6   ; sin interrupciones mientras cambia el mapa
	push hl			;5ae7   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5ae8   ; las tres copias, seguidas
	ld a,007h		;5aeb
	ld (06000h),a		;5aed   ; el banco 7 a 0x6000
	ld (hl),a			;5af0   ; apuntado en 0xF0F1
	inc a			;5af1
	ld (08000h),a		;5af2   ; el banco 8 a 0x8000
	inc hl			;5af5   ; la copia siguiente
	ld (hl),a			;5af6   ; apuntado en 0xF0F2
	inc a			;5af7
	ld (0a000h),a		;5af8   ; el banco 9 a 0xA000
	inc hl			;5afb   ; la copia siguiente
	ld (hl),a			;5afc   ; apuntado en 0xF0F3
	pop hl			;5afd   ; HL, como estaba
	ei			;5afe   ; el mapa ya esta entero
	ld de,089b8h		;5aff
	call pinta_sin_color		;5b02   ; el guion 0x89B8 del banco 8: 256 bytes de patrones de sprite (0x1E00-0x1EFF)
	di			;5b05   ; sin interrupciones mientras cambia el mapa
	push hl			;5b06   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5b07   ; las tres copias, seguidas
	ld a,001h		;5b0a
	ld (06000h),a		;5b0c   ; el banco 1 a 0x6000
	ld (hl),a			;5b0f   ; apuntado en 0xF0F1
	inc a			;5b10
	ld (08000h),a		;5b11   ; el banco 2 a 0x8000
	inc hl			;5b14   ; la copia siguiente
	ld (hl),a			;5b15   ; apuntado en 0xF0F2
	inc a			;5b16
	ld (0a000h),a		;5b17   ; el banco 3 a 0xA000
	inc hl			;5b1a   ; la copia siguiente
	ld (hl),a			;5b1b   ; apuntado en 0xF0F3
	pop hl			;5b1c   ; HL, como estaba
	ei			;5b1d   ; el mapa ya esta entero
	ret			;5b1e
L_5B1F:
	di			;5b1f   ; sin interrupciones mientras cambia el mapa
	push hl			;5b20   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5b21   ; las tres copias, seguidas
	ld a,007h		;5b24
	ld (06000h),a		;5b26   ; el banco 7 a 0x6000
	ld (hl),a			;5b29   ; apuntado en 0xF0F1
	inc a			;5b2a
	ld (08000h),a		;5b2b   ; el banco 8 a 0x8000
	inc hl			;5b2e   ; la copia siguiente
	ld (hl),a			;5b2f   ; apuntado en 0xF0F2
	inc a			;5b30
	ld (0a000h),a		;5b31   ; el banco 9 a 0xA000
	inc hl			;5b34   ; la copia siguiente
	ld (hl),a			;5b35   ; apuntado en 0xF0F3
	pop hl			;5b36   ; HL, como estaba
	ei			;5b37   ; el mapa ya esta entero
	ld de,08a7eh		;5b38
	call pinta_sin_color		;5b3b   ; el guion 0x8A7E del banco 8: 256 bytes de patrones de sprite (0x1F00-0x1FFF)
	di			;5b3e   ; sin interrupciones mientras cambia el mapa
	push hl			;5b3f   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5b40   ; las tres copias, seguidas
	ld a,001h		;5b43
	ld (06000h),a		;5b45   ; el banco 1 a 0x6000
	ld (hl),a			;5b48   ; apuntado en 0xF0F1
	inc a			;5b49
	ld (08000h),a		;5b4a   ; el banco 2 a 0x8000
	inc hl			;5b4d   ; la copia siguiente
	ld (hl),a			;5b4e   ; apuntado en 0xF0F2
	inc a			;5b4f
	ld (0a000h),a		;5b50   ; el banco 3 a 0xA000
	inc hl			;5b53   ; la copia siguiente
	ld (hl),a			;5b54   ; apuntado en 0xF0F3
	pop hl			;5b55   ; HL, como estaba
	ei			;5b56   ; el mapa ya esta entero
	ret			;5b57
L_5B58:
	di			;5b58   ; sin interrupciones mientras cambia el mapa
	push hl			;5b59   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5b5a   ; las tres copias, seguidas
	ld a,007h		;5b5d
	ld (06000h),a		;5b5f   ; el banco 7 a 0x6000
	ld (hl),a			;5b62   ; apuntado en 0xF0F1
	inc a			;5b63
	ld (08000h),a		;5b64   ; el banco 8 a 0x8000
	inc hl			;5b67   ; la copia siguiente
	ld (hl),a			;5b68   ; apuntado en 0xF0F2
	inc a			;5b69
	ld (0a000h),a		;5b6a   ; el banco 9 a 0xA000
	inc hl			;5b6d   ; la copia siguiente
	ld (hl),a			;5b6e   ; apuntado en 0xF0F3
	pop hl			;5b6f   ; HL, como estaba
	ei			;5b70   ; el mapa ya esta entero
	ld de,08b3ah		;5b71
	call pinta_sin_color		;5b74   ; el guion 0x8B3A del banco 8: 64 bytes de patrones de sprite (0x1D20-0x1D5F)
	di			;5b77   ; sin interrupciones mientras cambia el mapa
	push hl			;5b78   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5b79   ; las tres copias, seguidas
	ld a,001h		;5b7c
	ld (06000h),a		;5b7e   ; el banco 1 a 0x6000
	ld (hl),a			;5b81   ; apuntado en 0xF0F1
	inc a			;5b82
	ld (08000h),a		;5b83   ; el banco 2 a 0x8000
	inc hl			;5b86   ; la copia siguiente
	ld (hl),a			;5b87   ; apuntado en 0xF0F2
	inc a			;5b88
	ld (0a000h),a		;5b89   ; el banco 3 a 0xA000
	inc hl			;5b8c   ; la copia siguiente
	ld (hl),a			;5b8d   ; apuntado en 0xF0F3
	pop hl			;5b8e   ; HL, como estaba
	ei			;5b8f   ; el mapa ya esta entero
	ret			;5b90
L_5B91:
	call 09325h		;5b91
	di			;5b94   ; sin interrupciones mientras cambia el mapa
	push hl			;5b95   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5b96   ; las tres copias, seguidas
	ld a,004h		;5b99
	ld (06000h),a		;5b9b   ; el banco 4 a 0x6000
	ld (hl),a			;5b9e   ; apuntado en 0xF0F1
	inc a			;5b9f
	ld (08000h),a		;5ba0   ; el banco 5 a 0x8000
	inc hl			;5ba3   ; la copia siguiente
	ld (hl),a			;5ba4   ; apuntado en 0xF0F2
	inc a			;5ba5
	ld (0a000h),a		;5ba6   ; el banco 6 a 0xA000
	inc hl			;5ba9   ; la copia siguiente
	ld (hl),a			;5baa   ; apuntado en 0xF0F3
	pop hl			;5bab   ; HL, como estaba
	ei			;5bac   ; el mapa ya esta entero
	ld de,0b423h		;5bad
	ld hl,02058h		;5bb0
	call L_5BF3		;5bb3
L_5BB6:
	di			;5bb6   ; sin interrupciones mientras cambia el mapa
	push hl			;5bb7   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5bb8   ; las tres copias, seguidas
	ld a,004h		;5bbb
	ld (06000h),a		;5bbd   ; el banco 4 a 0x6000
	ld (hl),a			;5bc0   ; apuntado en 0xF0F1
	inc a			;5bc1
	ld (08000h),a		;5bc2   ; el banco 5 a 0x8000
	inc hl			;5bc5   ; la copia siguiente
	ld (hl),a			;5bc6   ; apuntado en 0xF0F2
	inc a			;5bc7
	ld (0a000h),a		;5bc8   ; el banco 6 a 0xA000
	inc hl			;5bcb   ; la copia siguiente
	ld (hl),a			;5bcc   ; apuntado en 0xF0F3
	pop hl			;5bcd   ; HL, como estaba
	ei			;5bce   ; el mapa ya esta entero
	ld de,0b597h		;5bcf
	jr L_5BF0		;5bd2
L_5BD4:
	di			;5bd4   ; sin interrupciones mientras cambia el mapa
	push hl			;5bd5   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5bd6   ; las tres copias, seguidas
	ld a,004h		;5bd9
	ld (06000h),a		;5bdb   ; el banco 4 a 0x6000
	ld (hl),a			;5bde   ; apuntado en 0xF0F1
	inc a			;5bdf
	ld (08000h),a		;5be0   ; el banco 5 a 0x8000
	inc hl			;5be3   ; la copia siguiente
	ld (hl),a			;5be4   ; apuntado en 0xF0F2
	inc a			;5be5
	ld (0a000h),a		;5be6   ; el banco 6 a 0xA000
	inc hl			;5be9   ; la copia siguiente
	ld (hl),a			;5bea   ; apuntado en 0xF0F3
	pop hl			;5beb   ; HL, como estaba
	ei			;5bec   ; el mapa ya esta entero
	ld de,0b5a8h		;5bed
L_5BF0:
	ld hl,00058h		;5bf0
L_5BF3:
	call pinta_en_los_tres		;5bf3   ; el guion 0xB5A8 del banco 6: 1272 bytes de colores (0x0058-0x01FF 0x0858-0x09FF 0x1058-0x11FF)
	di			;5bf6   ; sin interrupciones mientras cambia el mapa
	push hl			;5bf7   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5bf8   ; las tres copias, seguidas
	ld a,001h		;5bfb
	ld (06000h),a		;5bfd   ; el banco 1 a 0x6000
	ld (hl),a			;5c00   ; apuntado en 0xF0F1
	inc a			;5c01
	ld (08000h),a		;5c02   ; el banco 2 a 0x8000
	inc hl			;5c05   ; la copia siguiente
	ld (hl),a			;5c06   ; apuntado en 0xF0F2
	inc a			;5c07
	ld (0a000h),a		;5c08   ; el banco 3 a 0xA000
	inc hl			;5c0b   ; la copia siguiente
	ld (hl),a			;5c0c   ; apuntado en 0xF0F3
	pop hl			;5c0d   ; HL, como estaba
	ei			;5c0e   ; el mapa ya esta entero
	ret			;5c0f
L_5C10:
	ld b,0e0h		;5c10
	call escribe_el_registro_7		;5c12
	call borra_la_pantalla_entera		;5c15
	call L_5B91		;5c18
	call L_5BD4		;5c1b
	xor a			;5c1e
	ld (0e14eh),a		;5c1f
	ld (0e150h),a		;5c22
	di			;5c25   ; sin interrupciones mientras cambia el mapa
	push hl			;5c26   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5c27   ; las tres copias, seguidas
	ld a,007h		;5c2a
	ld (06000h),a		;5c2c   ; el banco 7 a 0x6000
	ld (hl),a			;5c2f   ; apuntado en 0xF0F1
	inc a			;5c30
	ld (08000h),a		;5c31   ; el banco 8 a 0x8000
	inc hl			;5c34   ; la copia siguiente
	ld (hl),a			;5c35   ; apuntado en 0xF0F2
	inc a			;5c36
	ld (0a000h),a		;5c37   ; el banco 9 a 0xA000
	inc hl			;5c3a   ; la copia siguiente
	ld (hl),a			;5c3b   ; apuntado en 0xF0F3
	pop hl			;5c3c   ; HL, como estaba
	ei			;5c3d   ; el mapa ya esta entero
	ld de,09846h		;5c3e
	call pinta_sin_color		;5c41   ; el guion 0x9846 del banco 8: 5824 bytes de colores y patrones y patrones de sprite (0x0208-0x0607 0x0A08-0x0E7F 0x1208-0x141F)
	ld a,(0002bh)		;5c44
	and 00fh		;5c47
	jr z,L_5C51		;5c49
	ld de,0a463h		;5c4b
	call pinta_sin_color		;5c4e   ; el guion 0xA463 del banco 9: 2240 bytes de colores y patrones y patrones de sprite (0x0208-0x020F 0x02A0-0x02A7 0x02E8-0x046F)
L_5C51:
	di			;5c51   ; sin interrupciones mientras cambia el mapa
	push hl			;5c52   ; HL va a apuntar a las copias
	ld hl,0f0f1h		;5c53   ; las tres copias, seguidas
	ld a,001h		;5c56
	ld (06000h),a		;5c58   ; el banco 1 a 0x6000
	ld (hl),a			;5c5b   ; apuntado en 0xF0F1
	inc a			;5c5c
	ld (08000h),a		;5c5d   ; el banco 2 a 0x8000
	inc hl			;5c60   ; la copia siguiente
	ld (hl),a			;5c61   ; apuntado en 0xF0F2
	inc a			;5c62
	ld (0a000h),a		;5c63   ; el banco 3 a 0xA000
	inc hl			;5c66   ; la copia siguiente
	ld (hl),a			;5c67   ; apuntado en 0xF0F3
	pop hl			;5c68   ; HL, como estaba
	ei			;5c69   ; el mapa ya esta entero
	ret			;5c6a
L_5C6B:
	di			;5c6b   ; sin interrupciones mientras cambia el mapa
	ld a,00ch		;5c6c
	ld (08000h),a		;5c6e   ; el banco 12 a 0x8000
	ld (0f0f2h),a		;5c71   ; y en su copia de RAM
	ei			;5c74   ; el mapa ya esta entero
	di			;5c75   ; sin interrupciones mientras cambia el mapa
	ld a,00dh		;5c76
	ld (0a000h),a		;5c78   ; el banco 13 a 0xA000
	ld (0f0f3h),a		;5c7b   ; y en su copia de RAM
	ei			;5c7e   ; el mapa ya esta entero
	ld de,0bab2h		;5c7f
	call pinta_sin_color		;5c82   ; el guion 0xBAB2 del banco 13: 768 bytes de la tabla de nombres (0x3800-0x3AFF)
	ld de,0ee80h		;5c85
	ld hl,0ba9eh		;5c88
	ld bc,00014h		;5c8b
	ldir		;5c8e
	call sube_los_sprites		;5c90
	jr L_5C51		;5c93

; ----------------------------------------------------------------------
; MONTAR LA PRESENTACION. Pinta las dos pantallas -la de fondo y la del rotulo-, arranca la musica y coloca a mano los dos sprites que se mueven por ella, que son los huecos 7 y 8 de la tabla de atributos (0xEE9C y 0xEEA0). Todo lo que sigue hasta el final del banco es la maquina de estados de esta pantalla.
; ----------------------------------------------------------------------
monta_la_presentacion:
	call L_5C10		;5c95   ; el fondo, con los caracteres del banco 7-8-9
	call L_5C6B		;5c98   ; y el rotulo, con la tabla de nombres del banco 13
	ld a,0a7h		;5c9b   ; la melodia de la presentacion
	call pide_sonido		;5c9d
	ld hl,05000h		;5ca0   ; los dos contadores que llevan la cuenta de por donde va
	ld (0e00ch),hl		;5ca3
	ld h,001h		;5ca6   ; y el segundo, a 1
	ld (0e00eh),hl		;5ca8
	ld a,017h		;5cab   ; el paso de la animacion
	ld (0e155h),a		;5cad
	ld hl,048e0h		;5cb0   ; la Y y la X del sprite 7
	ld (0ee9ch),hl		;5cb3
	ld h,058h		;5cb6   ; y la del 8
	ld (0eea0h),hl		;5cb8
	ld hl,00a2ch		;5cbb   ; el patron y el color del 7
	ld (0ee9eh),hl		;5cbe
	ld l,028h		;5cc1   ; y los del 8
	ld (0eea2h),hl		;5cc3
	ld hl,00607h		;5cc6   ; dos contadores mas, de un tiron
	ld (0e14ah),hl		;5cc9
	ld a,004h		;5ccc   ; y dos banderas sueltas
	ld (0e14fh),a		;5cce
	ld a,020h		;5cd1
	ld (0e14ch),a		;5cd3
presentacion_cuadro:
	call centellean_las_estrellas		;5cd6   ; lo que hay que hacer en cada cuadro pase lo que pase
	ld a,(0e00ch)		;5cd9   ; el estado
	dec a			;5cdc   ; el 1 es el unico que sigue por aqui
	jp nz,presentacion_estado_2		;5cdd
	ld a,(0e00dh)		;5ce0   ; y dentro de el, el subestado
	dec a			;5ce3
	jr nz,presentacion_subestado_2		;5ce4
	ld a,(0e003h)		;5ce6   ; el contador de cuadros
	and 007h		;5ce9   ; uno de cada ocho
	ret nz			;5ceb
	ld hl,03f73h		;5cec   ; patron nuevo para el sprite 7
	ld (0ee9ch),hl		;5cef
	call posicion_del_sprite		;5cf2   ; y su posicion, que sale de la tabla
	ld (0ee9eh),hl		;5cf5
	call avanza_el_recorrido		;5cf8   ; ¿se acabo el recorrido?
	ret nz			;5cfb
	ld a,008h		;5cfc   ; si se acabo, el paso siguiente
	ld (0e15ah),a		;5cfe
	jr presentacion_siguiente_subestado		;5d01
presentacion_subestado_2:
	dec a			;5d03   ; el subestado 2
	jr nz,presentacion_subestado_3		;5d04
	call baja_el_contador		;5d06   ; avanza y mira si ha llegado
	ret nz			;5d09
	jr presentacion_siguiente_subestado		;5d0a
presentacion_subestado_3:
	dec a			;5d0c   ; el 3
	jr nz,presentacion_subestado_4		;5d0d
	ld a,(0e003h)		;5d0f   ; otra vez uno de cada ocho
	and 007h		;5d12
	ret nz			;5d14
	ld hl,03b73h		;5d15   ; ahora el que cambia es el sprite 8
	ld (0eea0h),hl		;5d18
	call posicion_del_sprite		;5d1b   ; su posicion
	ld (0eea2h),hl		;5d1e
	call avanza_el_recorrido		;5d21   ; ¿ha llegado?
	ret nz			;5d24
	jr presentacion_siguiente_subestado		;5d25
presentacion_subestado_4:
	dec a			;5d27   ; el 4
	jr nz,presentacion_subestado_5		;5d28
	ld a,0e0h		;5d2a   ; 0xE0 en la Y: el sprite 8 se va de la pantalla
	ld (0eea0h),a		;5d2c
	ld hl,0e004h		;5d2f   ; un contador que baja
	dec (hl)			;5d32
	ret nz			;5d33   ; y hasta que no llegue a cero no se toca nada mas
	ld hl,0e00fh		;5d34   ; y cuando llega, baja el otro
	dec (hl)			;5d37
	ret			;5d38
presentacion_subestado_5:
	call baja_el_contador		;5d39   ; avanza y mira si ha llegado
	ret nz			;5d3c
	xor a			;5d3d
	ld (0e14ah),a		;5d3e   ; y a cero el contador de la animacion
	ld a,003h		;5d41
	ld (0e15ah),a		;5d43
presentacion_siguiente_subestado:
	ld a,020h		;5d46   ; se rearma el contador de la animacion
	ld (0e14ch),a		;5d48
	ld hl,0e00dh		;5d4b   ; y se pasa al subestado siguiente
	inc (hl)			;5d4e
	ret			;5d4f
presentacion_estado_2:
	ld a,(0e00eh)		;5d50   ; el tercer contador
	and a			;5d53
	jr nz,presentacion_se_van_volando		;5d54
	call baja_el_contador		;5d56   ; avanza y mira si ha llegado
	ret nz			;5d59
	xor a			;5d5a   ; los dos sprites, a la esquina de arriba
	ld (0ee9ch),a		;5d5b
	ld (0eea0h),a		;5d5e
	jr presentacion_estado_siguiente		;5d61
presentacion_se_van_volando:
	dec a			;5d63   ; el subestado 1
	jr nz,presentacion_dibuja_por_pasos		;5d64
	ld a,(0e003h)		;5d66   ; uno de cada dos cuadros
	and 001h		;5d69
	ret nz			;5d6b
	ld de,(0ee9ch)		;5d6c   ; la Y y la X del sprite 7, de una vez
	ld a,d			;5d70
	add a,005h		;5d71   ; cinco a la derecha
	ld d,a			;5d73
	ld a,e			;5d74
	add a,002h		;5d75   ; y dos hacia abajo
	ld e,a			;5d77
	ld (0ee9ch),de		;5d78
	ld de,(0eea0h)		;5d7c   ; lo mismo con el 8
	ld a,d			;5d80
	add a,005h		;5d81
	ld d,a			;5d83
	ld a,e			;5d84
	add a,002h		;5d85
	ld e,a			;5d87
	ld (0eea0h),de		;5d88
	ld hl,0e155h		;5d8c   ; y un contador que dice cuanto dura el vuelo
	dec (hl)			;5d8f
	ret nz			;5d90   ; mientras no llegue a cero, siguen andando
	ld a,0e0h		;5d91   ; 0xE0 en la Y
	ld hl,0ee9ch		;5d93   ; al sprite 7
	ld (hl),a			;5d96
	inc l			;5d97   ; y de cuatro en cuatro se llega al 8
	inc l			;5d98
	inc l			;5d99
	inc l			;5d9a
	ld (hl),a			;5d9b
	xor a			;5d9c   ; el contador a cero
	ld (0e155h),a		;5d9d
	ld a,020h		;5da0
	ld (0e14ch),a		;5da2
presentacion_estado_siguiente:
	ld hl,0e00eh		;5da5   ; al estado siguiente
	inc (hl)			;5da8
	ret			;5da9

; ----------------------------------------------------------------------
; EL DIBUJO QUE SE MONTA SOLO. Uno cada ocho cuadros, sacando el guion de la tabla de 0x5E3C con el contador de 0xE155 y pasandoselo a p01:7DF7. Son DIEZ pasos, y los cinco ultimos son los cinco primeros al reves: el dibujo aparece y se deshace.
; ----------------------------------------------------------------------
presentacion_dibuja_por_pasos:
	ld a,(0e003h)		;5daa   ; el contador de cuadros
	and 007h		;5dad   ; uno de cada ocho
	ret nz			;5daf
	ld a,(0e155h)		;5db0   ; por que paso va
	ld hl,05e3ch		;5db3   ; la tabla de los diez guiones
	call dos_por_a_mas_hl		;5db6   ; dos bytes por entrada
	ld e,(hl)			;5db9
	inc hl			;5dba
	ld d,(hl)			;5dbb
	call 07df7h		;5dbc   ; p01:7DF7, que mete los bancos 10 y 11 y lo pinta
	ld hl,0e155h		;5dbf   ; y el siguiente
	inc (hl)			;5dc2
	ld a,(hl)			;5dc3
	sub 00ah		;5dc4   ; diez son todos
	ret nz			;5dc6
	ld (0e00dh),a		;5dc7   ; se reinicia el subestado
	ld hl,0e00ch		;5dca   ; y se pasa de estado
	inc (hl)			;5dcd
	ret			;5dce

; ----------------------------------------------------------------------
; EL CENTELLEO DE LAS ESTRELLAS, Y DE DONDE SALE EL AZAR. Uno de cada cuatro cuadros se enciende o se apaga alguna de las estrellas del cielo, y para elegir cual no hay generador de numeros aleatorios: se lee el REGISTRO R del Z80. R es el contador de refresco de la memoria, que va subiendo solo con cada instruccion que se ejecuta, asi que su valor en un instante cualquiera no hay quien lo prevea. Se le dan cuatro vueltas para mezclar los bits de arriba con los de abajo y se cruza con el contador de cuadros.
; ----------------------------------------------------------------------
centellean_las_estrellas:
	ld a,(0e003h)		;5dcf   ; el contador de cuadros
	and 003h		;5dd2   ; uno de cada cuatro
	ret nz			;5dd4
	ld a,(0e14eh)		;5dd5   ; la bandera de si toca encender o apagar
	and a			;5dd8
	jr nz,estrella_paso_a_paso		;5dd9
	ld a,r		;5ddb   ; EL AZAR: el registro de refresco del Z80, que nadie puede predecir
	rrca			;5ddd   ; cuatro vueltas para que los bits de arriba cuenten
	rrca			;5dde
	rrca			;5ddf
	rrca			;5de0
	ld hl,0e003h		;5de1   ; y se cruza con el contador de cuadros
	xor (hl)			;5de4
	and 003h		;5de5   ; que quedan dos bits: una estrella de cuatro
	ld (0e14fh),a		;5de7   ; y esa es la estrella que toca
	ld hl,05e50h		;5dea   ; la tabla de las cuatro estrellas
	add a,a			;5ded   ; cuatro bytes por entrada
	call dos_por_a_mas_hl		;5dee
	ld de,0e151h		;5df1   ; que se copian a la RAM de trabajo
	ld bc,00004h		;5df4
	ldir		;5df7
	ld a,0ffh		;5df9   ; 0xFF: el contador empieza dado la vuelta
	ld (0e150h),a		;5dfb
	ld hl,0e14eh		;5dfe   ; y se pasa a la fase de encender
	inc (hl)			;5e01
	ret			;5e02
estrella_paso_a_paso:
	ld hl,0e150h		;5e03   ; el paso del centelleo
	inc (hl)			;5e06
	ld a,(hl)			;5e07
	cp 003h		;5e08   ; son tres, y al tercero se acaba
	jr z,estrella_acabada		;5e0a
	ld hl,(0e151h)		;5e0c   ; el puntero a los tres caracteres de la estrella
	call a_mas_hl		;5e0f   ; el que toca ahora
	ld a,(hl)			;5e12
	ld hl,(0e153h)		;5e13   ; y donde va en la VRAM, que tambien venia en la entrada
	jp 0004dh		;5e16   ; BIOS WRTVRM - Writes data in VRAM | BIOS WRTVRM
estrella_acabada:
	xor a			;5e19   ; vuelta a elegir estrella
	ld (0e14eh),a		;5e1a
	ret			;5e1d
posicion_del_sprite:
	ld a,(0e14ah)		;5e1e   ; por donde va el recorrido
	ld hl,05e66h		;5e21   ; la tabla de ocho posiciones
	call a_mas_hl		;5e24
	ld l,(hl)			;5e27   ; el byte bajo sale de la tabla
	ld h,007h		;5e28   ; y el alto es siempre 7
	ret			;5e2a
avanza_el_recorrido:
	ld hl,0e14ah		;5e2b   ; el paso del recorrido
	inc (hl)			;5e2e
	ld a,(hl)			;5e2f
	ld hl,0e15ah		;5e30   ; contra el tope, que cambia segun el tramo
	cp (hl)			;5e33   ; y se vuelve con el cero puesto si ha llegado
	ret			;5e34
baja_el_contador:
	ld hl,0e14ch		;5e35   ; el contador de la presentacion, un cuadro menos
	dec (hl)			;5e38
	ret			;5e39

; ----------------------------------------------------------------------
; DATOS tope_de_los_recorridos: Los dos topes que 0x5E2B compara: 4 y 11.
;   0x5e3a..0x5e3c  (2 bytes)
DATA_tope_de_los_recorridos:
	defb 004h,00bh	; 5e3a

; ----------------------------------------------------------------------
; DATOS dibujos_de_la_presentacion: Diez punteros a guiones del BANCO 11, que
;   0x5DB3 recorre con el contador de 0xE155 y le pasa a p01:7DF7 -que es
;   quien mete los bancos 10 y 11 y llama al pintor con mascara-. No son
;   textos: son tiras de numeros de caracter que se sueltan en la tabla de
;   nombres, o sea un dibujo por pasos. El orden es simetrico -0xB3B7, 0xB3C1,
;   0xB3CB, 0xB3D6, 0xB3EA y luego los mismos al reves- porque el dibujo se
;   monta y se desmonta; el decimo, 0xB3FE, es el que cierra.
;   0x5e3c..0x5e50  (20 bytes)
DATA_dibujos_de_la_presentacion:
	defw 0b3b7h	; 5e3c
	defw 0b3c1h	; 5e3e
	defw 0b3cbh	; 5e40
	defw 0b3d6h	; 5e42
	defw 0b3eah	; 5e44
	defw 0b3d6h	; 5e46
	defw 0b3cbh	; 5e48
	defw 0b3c1h	; 5e4a
	defw 0b3b7h	; 5e4c
	defw 0b3feh	; 5e4e

; ----------------------------------------------------------------------
; DATOS las_cuatro_estrellas: Cuatro entradas de cuatro bytes, que 0x5DEA
;   copia enteras a 0xE151: los dos primeros son el puntero a los tres
;   caracteres del centelleo y los dos ultimos la direccion de VRAM donde va.
;   Las dos parejas de punteros se repiten -0x5E60 y 0x5E63- porque lo que
;   cambia entre unas estrellas y otras es DONDE estan, no como parpadean.
;   0x5e50..0x5e60  (16 bytes)
DATA_las_cuatro_estrellas:
	defw 05e60h	; 5e50  -> DATA_caracteres_del_centelleo
	defw 038a3h	; 5e52
	defw 05e63h	; 5e54
	defw 03847h	; 5e56
	defw 05e60h	; 5e58  -> DATA_caracteres_del_centelleo
	defw 0383ah	; 5e5a
	defw 05e63h	; 5e5c
	defw 03833h	; 5e5e

; ----------------------------------------------------------------------
; DATOS caracteres_del_centelleo: Dos tiras de tres caracteres: 0x9E 0x9F 0x51
;   y 0xA1 0x50 0xA0. Son los tres pasos del parpadeo de una estrella.
;   0x5e60..0x5e66  (6 bytes)
DATA_caracteres_del_centelleo:
	defb 09eh,09fh,051h	; 5e60
	defb 0a1h,050h,0a0h	; 5e63

; ----------------------------------------------------------------------
; DATOS recorrido_del_sprite: Ocho posiciones, que son el byte bajo de la
;   direccion de VRAM; el alto lo pone a mano 0x5E28. Van 0x10, 0x14, 0x18,
;   0x1C, 0x20, 0x24, 0x20, 0x1C: sube y baja.
;   0x5e66..0x5e6e  (8 bytes)
DATA_recorrido_del_sprite:
	defb 010h,014h,018h,01ch,020h,024h,020h,01ch	; 5e66  .... $ .

; ======================================================================
; CODIGO 0x5e6e..0x5f35  (199 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL TEXTO QUE SUBE. Es el final de la presentacion, y la forma de hacerlo es la mas directa que hay: el espejo de pantalla que vive en la RAM se copia sobre si mismo 32 bytes mas abajo, que es UNA FILA, y en la fila que queda libre abajo se escribe la siguiente linea de texto. Como el espejo se sube entero a la VRAM en cada cuadro, el resultado es un desplazamiento suave sin tocar el VDP para nada.
; ----------------------------------------------------------------------
rotulos_que_suben:
	ld a,001h		;5e6e   ; la bandera que corta la segunda mitad del cuadro
	ld (0e096h),a		;5e70   ; los avisos que deja el cuadro
	ld a,(0e003h)		;5e73   ; el contador de cuadros
	and 01fh		;5e76   ; uno de cada treinta y dos
	ret nz			;5e78
	ld a,(0e13dh)		;5e79   ; en que tramo va
	ld b,a			;5e7c
	djnz rotulos_otro_tramo		;5e7d
sube_una_fila:
	ld bc,00300h		;5e7f   ; 768 bytes: la pantalla entera
	ld hl,0eba0h		;5e82   ; desde 0xEBA0...
	ld de,0eb80h		;5e85   ; ...a 0xEB80, o sea 32 bytes mas abajo: una fila justa
	ldir		;5e88
	ld hl,0bcf8h		;5e8a   ; el texto que toca
	call 07e2dh		;5e8d   ; el escritor, en el banco 1
	ld hl,0e13eh		;5e90   ; cuantos cuadros dura esta linea
	dec (hl)			;5e93
	ret nz			;5e94   ; y mientras dure, no hay linea nueva
	ld hl,0e140h		;5e95   ; cuantas lineas quedan
	dec (hl)			;5e98
	jp z,L_5F2F		;5e99   ; cuando no queda ninguna, se acabo
	ld a,(hl)			;5e9c
	dec a			;5e9d
	ld hl,(0e147h)		;5e9e   ; la lista de lineas
	call dos_por_a_mas_hl		;5ea1   ; dos bytes por entrada
	ld e,(hl)			;5ea4
	inc hl			;5ea5
	ld d,(hl)			;5ea6
	di			;5ea7   ; sin interrupciones mientras cambia el mapa
	ld a,00ah		;5ea8
	ld (08000h),a		;5eaa   ; el banco 10 a 0x8000
	ld (0f0f2h),a		;5ead   ; y en su copia de RAM
	ei			;5eb0   ; el mapa ya esta entero
	di			;5eb1   ; sin interrupciones mientras cambia el mapa
	ld a,00bh		;5eb2
	ld (0a000h),a		;5eb4   ; el banco 11 a 0xA000
	ld (0f0f3h),a		;5eb7   ; y en su copia de RAM
	ei			;5eba   ; el mapa ya esta entero
	ld a,(de)			;5ebb   ; el primer byte de la linea dice cuanto dura
	ld (0e13eh),a		;5ebc
	inc de			;5ebf
	ex de,hl			;5ec0
	jp 07e2dh		;5ec1   ; y el resto, al escritor
rotulos_otro_tramo:
	djnz L_5EDD		;5ec4
	ld hl,0e13fh		;5ec6   ; un contador de espera
	dec (hl)			;5ec9
	ret nz			;5eca
	ld a,018h		;5ecb   ; veinticuatro lineas
	ld (0e140h),a		;5ecd
	ld a,001h		;5ed0   ; y una de duracion, para que la primera salga ya
	ld (0e13eh),a		;5ed2
	ld hl,(0e149h)		;5ed5   ; la lista de lineas de este tramo
	ld (0e147h),hl		;5ed8
	jr L_5F2F		;5edb
L_5EDD:
	djnz L_5EE1		;5edd
	jr sube_una_fila		;5edf
L_5EE1:
	djnz L_5F01		;5ee1
	ld a,(0e012h)		;5ee3
	and a			;5ee6
	ret nz			;5ee7
	xor a			;5ee8
	ld (0e096h),a		;5ee9   ; los avisos que deja el cuadro
L_5EEC:
	di			;5eec   ; sin interrupciones mientras cambia el mapa
	ld a,002h		;5eed
	ld (08000h),a		;5eef   ; el banco 2 a 0x8000
	ld (0f0f2h),a		;5ef2   ; y en su copia de RAM
	ei			;5ef5   ; el mapa ya esta entero
	di			;5ef6   ; sin interrupciones mientras cambia el mapa
	ld a,003h		;5ef7
	ld (0a000h),a		;5ef9   ; el banco 3 a 0xA000
	ld (0f0f3h),a		;5efc   ; y en su copia de RAM
	ei			;5eff   ; el mapa ya esta entero1098 comentarios
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
	call a_mas_hl		;5f8f
	ld a,(hl)			;5f92
L_5F93:
	call a_mas_de		;5f93
L_5F96:
	jp pinta_guion_con_mascara		;5f96

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
