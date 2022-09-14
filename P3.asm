
;todo     █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   █▀▄▀█ █▄█   █▀▀ ▄▀█ █▀▄▀█ █▀▀
;todo     ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   █░▀░█ ░█░   █▄█ █▀█ █░▀░█ ██▄
;todo ---------------------------------------------------------------------------------------------------
.MODEL LARGE
.386
.STACK 64
.DATA
;*--------------------------  MIS_DATOS -----------------------------
tb1             DB   38,'BIENVENIDO AL JUEGO BATTLESHIPS !!!!!!'
tb2             DB   38,'Universidad de San Carlos de Guatemala'
tb3             DB   22,'Facultad de Ingenieria'
tb4             DB   30,'Escuela de Ciencias y Sistemas'
tb5             DB   9,'Seccion A'
tb6             DB   27,'ALVARO EMMANUEL SOCOP PEREZ'
tb7             DB   9,'202000194'
pressenter      DB   24,'ENTER: Para continuar...'

;*--------------------------     MENU    -----------------------------
tm1             DB   29,'------- MENU PRINCIPAL ------'
tm2             DB   16,'1. Iniciar Juego'
tm3             DB   15,'2. Cargar Juego'
tm4             DB   8,'3. Salir'
keypress          DB ?
keypresstempY          DB ?
keypresstempX          DB ?
tm1c             DB   '------- MENU PRINCIPAL ------',10, 13, "$"
tm2c             DB   '         1. Iniciar Juego',10, 13, "$"
tm3c             DB   '         2. Cargar Juego',10, 13, "$"
tm4c             DB   '         3. Salir',10, 13, "$"
;*--------------------------  COLORES -----------------------------
BLACK               EQU  00H

;*---------------- COORDENADAS ----------
POSX            DB  ?
POSY            DB  ?

;*--------------------------  PARAMETROS DIBUJAR -----------------------------
X1              DW  ?
X2              DW  ?
Y1              DW  ?
Y2              DW  ?
;*--------------------------  DRAWING THE TABLES -----------------------------
ship          DB "[",254,"] ", "$";██
shoot          DB "[X] ", "$"
dshoot          DB "[O] ", "$"
noship          DB "[ ] ", "$"
saltolinea      DB " ",10, 13, "$"

;* --------------------------  JUGADOR -----------------------------
iniciaunotext db "---EL JUGADOR 1 INICIA LA PARTIDA---", 10, 13, "$"
iniciadostext db "---EL JUGADOR 2 INICIA LA PARTIDA---", 10, 13, "$"
textiniciandojuego db "--- INICIANDO JUEGO ---", "$"
jugandojugador2 db "JUGANDO: JUGADOR 2", 10, 13, "$"
jugandojugador1 db "JUGANDO: JUGADOR 2", 10, 13, "$"
titledisparos db "DISPAROS", "$"
titlebarcos db "BARCOS", "$"
titleingresebarcos db "INGRESO DE BARCOS", "$"
titlebarcosdisponibles db "*** BARCOS DISPONIBLES ***", "$"
titleseleccionebarco db "Seleccione barco a posicionar", "$"

;*  ---------------------------------- BARCOS --------------------------
textoBoteneumatico          db "1. Bote Neumatico", "$"
textoDestructoramericano    db "2. Destructor Americano", "$"
textoDestructorjapones      db "3. Destructor Japones", "$"
textoAcorazado              db "4. Acorazado", "$"
textoPortaviones            db "5. Portaviones", "$"
limpiarbarcos               db "                     ","$"
decorotexto1                db 219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,219,"$"
dt2                         db 219,"$"
borrarlinea             DB "                                        ",13
textvertical            db "1-Vertical", "$"
texthorizontal          db "2-Horizontal", "$"
textekisigual           db "X=", "$"
textyeigual             db "Y=", "$"
ereigual                db "R=", "$"
textuno                 DB "1","$"
textdos                 DB "2","$"
texttres                DB "3","$"
textcuatro              DB "4","$"
textcinco               DB "5","$"
textyahaybarcoalli               DB "YA HAY BARCO ALLI","$"

BARCOSELECCIONADO       DB ?
POSXBARCOSELECCIONADO   DB ?
POSYBARCOSELECCIONADO   DB ?
ROTACIONBARCOSELECCIONADO   DB ?            ;! 1 vertical    2 horizontal

FLAGPUEDOPONERBARCO     DB "1"
;* --------------------------  MATRICES DE LOS JUGADORES -----------------------------
matriz1 DB 100 dup("0")  ;! PUEDE TENER  0   X   O
matriz2 DB 100 dup('0')  ;! PUEDE TENER  0   X   O
INDEX         Dw ?
INDEXtemp                Dw ?
;* --------------------------  DISPAROS -----------------------------
shootjug1x      DB ?
shootjug1y      DB ?
shootjug2x      DB ?
shootjug2y      DB ?
;* --------------------------  MATRICES DE LOS BARCOS -----------------------------
barcos1 DB 100 dup("0") ;! PUEDE TENER 0   1
barcos2 DB 100 dup('0') ;! PUEDE TENER 0   1
INDEXBARCOS         Dw ?
INDEXtempBARCOS                Dw ?

;* --------------------------  ERRORES TEXTS -----------------------------
NUMERONOVALIDO            db "Posicion mala", "$"
;* --------------------------  MIS_DATOS -----------------------------
;* --------------------------  MIS_DATOS -----------------------------
;* --------------------------  MIS_DATOS -----------------------------
temp DW  ?
KEY_PRESSED                     DB  ?


;!████████████████████████████ SEGMENTO DE CODIGO ████████████████████████████
.CODE
;!                ░█▀▄▀█ ─█▀▀█ ░█▀▀█ ░█▀▀█ ░█▀▀▀█ ░█▀▀▀█ 
;!                ░█░█░█ ░█▄▄█ ░█─── ░█▄▄▀ ░█──░█ ─▀▀▀▄▄ 
;!                ░█──░█ ░█─░█ ░█▄▄█ ░█─░█ ░█▄▄▄█ ░█▄▄▄█
    PAINTTEXT MACRO MYMESSAGE , LOCATION,COLOR                            ;? ▬▬▬▬▬ IMPRIMIR
        PUSHA
        MOV DX,LOCATION
        MOV BP, OFFSET MYMESSAGE
        MOV SI, COLOR
        CALL  PAINTTEXT_
        POPA
    ENDM PAINTTEXT

    misdatos MACRO                                                     ;? ▬▬▬▬▬ DATOS
        PUSHA
        CALL misdatos_
        POPA
    ENDM misdatos

    ;*========================= VIDEO ===================================
    esperatecla MACRO
        PUSHA
        CALL esperatecla_
        POPA
    ENDM  esperatecla

    paint	MACRO	CORNER1X, CORNER1Y, CORNER2X, CORNER2Y, COLOR ;? ▬▬▬▬▬ MENU DIBUJAR EN PANTALLA 
        PUSHA
        PUSH AX
        MOV AX, CORNER1X
        MOV X1, AX
        MOV AX, CORNER1Y
        MOV Y1, AX
        MOV AX, CORNER2X
        MOV X2, AX
        MOV AX, CORNER2Y
        MOV Y2, AX
        POP AX
        MOV AL, COLOR
        CALL paint_
        POPA
    ENDM	paint
    esperaenter MACRO                                                  ;? ▬▬▬▬▬ ENTER
        PUSHA
        mov ax, 00
        mov ah, 01h
        int 21h
        POPA
    ENDM esperaenter

    enterclick MACRO                                                  ;? ▬▬▬ ENTER
        PUSHA
        CALL enterclick_
        POPA
    ENDM enterclick

    ;*========================= MENU PRINCIPAL ===================================
    menu MACRO                                                     ;? ▬▬▬▬▬ MENU
        PUSHA
        CALL menu_
        POPA
    ENDM menu

    ;* ========================= CONSOLA ===================================
    limpiar MACRO                                                     ;? ▬▬▬▬▬ LIMPIAR
        mov ah, 00h
        mov al, 03h
        int 10h
    ENDM limpiar

    readtext MACRO                                            ;? ▬▬▬▬▬ LEER DE CONSOLA
        PUSHA
        CALL readtext_
        POPA
    ENDM readtext

    print macro texto
        mov ah, 09
        mov dx, offset texto
        int 21h
    ENDM print
    println macro texto
        mov ah, 09
        mov dx, offset texto
        int 21h
        print saltolinea
    ENDM println

                    ;! ▀▀▀▀▀▀▀▀▀▀   ▜▛ ▞▚ ▙ ▙▄ █☰ 🆁 ██ ▟▛ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀
    PAINTTABLEROSHOOTS1 MACRO
        PUSHA
        CALL PAINTTABLEROSHOOTS1_
        POPA
    ENDM PAINTTABLEROSHOOTS1
    PAINTTABLEROBARCOS1 MACRO
        PUSHA
        CALL PAINTTABLEROBARCOS1_
        POPA
    ENDM PAINTTABLEROBARCOS1

    PAINTTABLEROSHOOTS2 MACRO
        PUSHA
        CALL PAINTTABLEROSHOOTS2_
        POPA
    ENDM PAINTTABLEROSHOOTS2
    PAINTTABLEROBARCOS2 MACRO
        PUSHA
        CALL PAINTTABLEROBARCOS2_
        POPA
    ENDM PAINTTABLEROBARCOS2

    ; * ---------------------IMPRIMIR TIROS JUG 1-----------------------
    PRINTSHOOTS1 MACRO
        STARTING:
            CMP matriz1[si], "X"
            JNE NOHAYTIRO
            JE SIHAYTIRO
        NOHAYTIRO:
            CMP matriz1[si], "O"
            JNE NOHATIRADO
            JE TIROPERONODIO
        TIROPERONODIO:
            print dshoot
            JMP SALIR
        NOHATIRADO:
            print noship
            JMP SALIR
        SIHAYTIRO:
            print shoot
            JMP SALIR
        SALIR:
    ENDM PRINTSHOOTS1

    ; * --------------------- IMPRIMIR BARCOS JUG 1---------------------
    PRINTSHIPS1 MACRO
        STARTING:
            CMP barcos1[si], "1"
            JNE printvacio
            JE printlleno
        printvacio:
            print noship
            JMP SALIR
        printlleno:
            print ship
            JMP SALIR
        SALIR:
    ENDM PRINTSHIPS1


    ; * ---------------------IMPRIMIR TIROS JUG 2-----------------------
    PRINTSHOOTS2 MACRO
        STARTING:
            CMP matriz2[si], "X"
            JNE NOHAYTIRO
            JE SIHAYTIRO
        NOHAYTIRO:
            CMP matriz2[si], "O"
            JNE NOHATIRADO
            JE TIROPERONODIO
        TIROPERONODIO:
            print dshoot
            JMP SALIR
        NOHATIRADO:
            print noship
            JMP SALIR
        SIHAYTIRO:
            print shoot
            JMP SALIR
        SALIR:
    ENDM PRINTSHOOTS2

    ; * --------------------- IMPRIMIR BARCOS JUG 2---------------------
    PRINTSHIPS2 MACRO
        STARTING:
            CMP barcos2[si], "1"
            JNE printvacio
            JE printlleno
        printvacio:
            print noship
            JMP SALIR
        printlleno:
            print ship
            JMP SALIR
        SALIR:
    ENDM PRINTSHIPS2

    VALIDARESPACIO MACRO
        PUSHA
        CALL VALIDARESPACIO_
        POPA
    ENDM VALIDARESPACIO
    VALIDARESPACIO2 MACRO
        PUSHA
        CALL VALIDARESPACIO2_
        POPA
    ENDM VALIDARESPACIO2
    ; * --------------------- POSICIONAR BARCOS JUGADOR 1---------------------
    COLOCARBARCO1 MACRO
        PUSHA
        CALL COLOCARBARCO1_
        POPA
    ENDM COLOCARBARCO1
    COLOCARBARCO2 MACRO
        PUSHA
        CALL COLOCARBARCO2_
        POPA
    ENDM COLOCARBARCO2
    COLOCARBARCO3 MACRO
        PUSHA
        CALL COLOCARBARCO3_
        POPA
    ENDM COLOCARBARCO3
    COLOCARBARCO4 MACRO
        PUSHA
        CALL COLOCARBARCO4_
        POPA
    ENDM COLOCARBARCO4
    COLOCARBARCO5 MACRO
        PUSHA
        CALL COLOCARBARCO5_
        POPA
    ENDM COLOCARBARCO5
    
     ; * --------------------- POSICIONAR BARCOS JUGADOR 1---------------------
    COLOCARBARCO1JUG2 MACRO
        PUSHA
        CALL COLOCARBARCO1JUG2_
        POPA
    ENDM COLOCARBARCO1JUG2
    COLOCARBARCO2JUG2 MACRO
        PUSHA
        CALL COLOCARBARCO2JUG2_
        POPA
    ENDM COLOCARBARCO2JUG2
    COLOCARBARCO3JUG2 MACRO
        PUSHA
        CALL COLOCARBARCO3JUG2_
        POPA
    ENDM COLOCARBARCO3JUG2
    COLOCARBARCO4JUG2 MACRO
        PUSHA
        CALL COLOCARBARCO4JUG2_
        POPA
    ENDM COLOCARBARCO4JUG2
    COLOCARBARCO5JUG2 MACRO
        PUSHA
        CALL COLOCARBARCO5JUG2_
        POPA
    ENDM COLOCARBARCO5JUG2
    
                    ;! ▀▀▀▀▀▀▀▀▀▀  MENU  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀
    OPCIONDEMENU MACRO
        PUSHA
        CALL OPCIONDEMENU_
        POPA
    ENDM OPCIONDEMENU

    INICIODEJUEGOM MACRO
        PUSHA
        CALL INICIODEJUEGOM_
        POPA
    ENDM INICIODEJUEGOM

    CARGADEJUEGOM MACRO
        PUSHA
        CALL CARGADEJUEGOM_
        POPA
    ENDM CARGADEJUEGOM
    ; POSICIONAR CURSOR
    poscursor MACRO POSXTEMP, POSYTEMP
        ; PUSHA
        MOV AL, POSXTEMP
        MOV POSX, AL
        MOV AL, POSYTEMP
        MOV POSY, AL
        CALL poscursor_
        ; POPA
    ENDM poscursor

    decorobarra MACRO
        CALL decorobarra_
    ENDM decorobarra

    recorrerm1 MACRO
        PUSHA
        CALL recorrerm1_
        POPA
    ENDM recorrerm1

                    ;! ▀▀▀▀▀▀▀▀▀▀  DISPAROS  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀
    DISPARAR MACRO
        PUSHA
        CALL DISPARAR_
        POPA
    ENDM DISPARAR

    shoot1 MACRO POSXTEMP, POSYTEMP
        ; PUSHA
        MOV AL, POSXTEMP
        MOV shootjug1x, AL
        MOV AL, POSYTEMP
        MOV shootjug1y, AL
        CALL shoot1_
        ; POPA
    ENDM shoot1

    shoot2 MACRO  POSXTEMP, POSYTEMP
        ; PUSHA
        MOV AL, POSXTEMP
        MOV shootjug2x, AL
        MOV AL, POSYTEMP
        MOV shootjug2y, AL
        CALL shoot2_
        ; POPA
    ENDM shoot2

    pasarreadtextanumeroY MACRO
        PUSHA
        CALL pasarreadtextanumeroY_
        POPA
    ENDM pasarreadtextanumeroY

    pasarreadtextanumeroX MACRO
        PUSHA
        CALL pasarreadtextanumeroX_
        POPA
    ENDM pasarreadtextanumeroX

    BARCOQUEELIGIO MACRO
        PUSHA
        CALL BARCOQUEELIGIO_
        POPA
    ENDM BARCOQUEELIGIO


    ; * ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻ VISTA DE ENTRADA BARCOS ☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻☻
    PRINTVIEWSHIPS MACRO
        poscursor 1, 49
        print titlebarcosdisponibles
        poscursor 13,44
        print titleseleccionebarco
        ;* texto decoracion
        poscursor 0,43
        print decorotexto1
        poscursor 10,43
        print decorotexto1
        poscursor 24,43
        print decorotexto1
        decorobarra
        ; ? *********  imprimo barcos disponibles
        poscursor 3,50                  ;* BARCO 1
        print textoBoteneumatico
        poscursor 4,50                  ;* BARCO 2
        print textoDestructoramericano
        poscursor 5,50                  ;* BARCO 3
        print textoDestructorjapones
        poscursor 6,50                  ;* BARCO 4
        print textoAcorazado
        poscursor 7,50                  ;* BARCO 5
        print textoPortaviones

        poscursor 12, 49
        print titleingresebarcos
        poscursor 15, 63                ;* posiciono textos
        print textvertical
        poscursor 16, 63
        print textvertical
        
        poscursor 18, 50                ;* IMPRIMO COORDENADAS XY
        print textuno
        poscursor 18, 55
        print textdos
        poscursor 18, 60
        print texttres
        poscursor 18, 65
        print textcuatro
        poscursor 18, 70
        print textcinco

        poscursor 19, 49            ;!     X
        print textekisigual
        poscursor 20, 49            ;!     Y
        print textyeigual
        poscursor 21, 49
        print ereigual

        poscursor 19, 54
        print textekisigual
        poscursor 20, 54
        print textyeigual
        poscursor 21, 54
        print ereigual

        poscursor 19, 59
        print textekisigual
        poscursor 20, 59
        print textyeigual
        poscursor 21, 59
        print ereigual

        poscursor 19, 64
        print textekisigual
        poscursor 20, 64
        print textyeigual
        poscursor 21, 64
        print ereigual

        poscursor 19, 69
        print textekisigual
        poscursor 20, 69
        print textyeigual
        poscursor 21, 69
        print ereigual

    ENDM PRINTVIEWSHIPS


;! ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █▀▄▀█ ▄▀█ █ █▄░█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
;! ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █░▀░█ █▀█ █ █░▀█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
main PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    ;misdatos
    ;esperaenter
    ;paint  0, 0, 800, 600, BLACK ;*LIMPIA TODO MODO VIDEO:V
    ;menu
    ;esperaenter
    
    limpiar  ;* limpio la pantalla
    poscursor 6,22
    print tm1c
    poscursor 8,22
    print tm2c
    poscursor 10,22
    print tm3c
    poscursor 12,22
    print tm4c
    poscursor 16,29
    limpiar
    readtext

    readtext
    recorrerm1
    readtext
    OPCIONDEMENU
    mov ax, 4c00h
    int 21h
    HLT ; para decirle al CPU que se estara ejecutando varias veces (detiene CPU hasta sig interrupcion)
    RET
main    ENDP
;! ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ 
;! ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
;? ☻ ===================== METODO MOSTRAR DATOS ======================= ☻
misdatos_     PROC NEAR
    MOV AX,4F02H           ;SETEAMOS EL MODO VIDEO INT 10   800*600
    MOV BX,103H
    INT 10H
    ; imprimo el texto de inicio
    PAINTTEXT tb1 , 0820H , 0FF22H
    PAINTTEXT tb2 , 0F10h , 0FF0FH
    PAINTTEXT tb3 , 1210H , 0FF0FH
    PAINTTEXT tb4 , 1410H , 0FF0FH
    PAINTTEXT tb5 , 1610H , 0FF0FH
    PAINTTEXT tb6 , 1810H , 0FF0FH
    PAINTTEXT tb7 , 1A10H , 0FF0FH
    PAINTTEXT pressenter , 2125H , 0FF30H
    RET
misdatos_     ENDP

;?☻ ===================== METODO MOSTRAR DATOS ======================= ☻
menu_     PROC NEAR
    PAINTTEXT tm1 , 0820H , 0FF26H
    PAINTTEXT tm2 , 0F10h , 0FF0FH
    PAINTTEXT tm3 , 1210H , 0FF0FH
    PAINTTEXT tm4 , 1410H , 0FF0FH
    RET
menu_     ENDP


;?☻ ===================== METODO IMPRIMIR ======================= ☻
PAINTTEXT_    PROC NEAR
    MOV AX,1301H
    MOV BX,BP
    MOV CL,[BX]
    MOV CH,00H
    ADD BP,1H
    MOV BX,SI
    INT 10H
    RET
PAINTTEXT_    ENDP

;?☻ ===================== PRESIONAR TECLAS ======================= ☻
enterclick_    PROC    NEAR
    esperar:
        esperatecla
        MOV AH , keypress
        CMP AH, 1CH
    JNE esperar
    RET
enterclick_    ENDP

esperatecla_  PROC   NEAR
    MOV keypress, AH
    RET
esperatecla_ ENDP



;?☻ ===================== DIBUJAR EN PANTALLA ======================= ☻
paint_   PROC  NEAR
    ;PARAMETERS
    ; X1, Y1, X2, Y2, AL = COLOR
    INC X2
    INC Y2  ;TO STOP AT X2 + 1, Y2 + 1
    MOV DX, Y1
    MOV AH, 0CH   ;AH = 0C FOR INT, AL = COLOR
    DRAW_ALL_RECTANGLE_ROWS:
    MOV CX, X1
        DRAW_RECTANGE_ROW:
            INT 10H
            INC CX
            CMP CX, X2
        JNZ DRAW_RECTANGE_ROW
    INC DX
    CMP DX, Y2
    JNZ DRAW_ALL_RECTANGLE_ROWS
    RET
paint_ ENDP

;?☻ ===================== CONCATENAR TEXTO ENTRADA ======================= ☻
readtext_ PROC NEAR
    xor si , si
    Leer:
        mov ax, 00
        mov ah, 01h
        int 21h
        cmp al, 13
        jne Concatenar
        je Salir
    Concatenar:
        mov keypress[si], al
        mov keypress[si + 1], "$"
        inc si
        jmp Leer
    Salir:
    RET
readtext_ ENDP

;?☻ ===================== PINTAR TABLERO SHOOTS 1======================= ☻
PAINTTABLEROSHOOTS1_ PROC NEAR
    mov si, 00
    mov di, 00
    MOV INDEX, 0
    paintfila:
        cmp si, 10
        jne printelcuadro
        je imprimirsaltolinea

    printelcuadro:
        mov INDEXtemp, si
        mov si, INDEX           ;* mostrar lo que hay en la matriz
        PRINTSHOOTS1
        mov si, INDEXtemp
        INC INDEX
        INC si
        JMP paintfila

    imprimirsaltolinea:
        mov si, 00
        INC di
        print saltolinea
        cmp di, 10
        jne printelcuadro
        je exit
    exit:
    RET
PAINTTABLEROSHOOTS1_ ENDP

;?☻ ===================== PINTAR TABLERO BARCOS 1======================= ☻
PAINTTABLEROBARCOS1_ PROC NEAR
    mov si, 00
    mov di, 00
    MOV INDEX, 0
    paintfila:
        cmp si, 10
        jne printelcuadro
        je imprimirsaltolinea

    printelcuadro:
        mov INDEXtemp, si
        mov si, INDEX           ;* mostrar lo que hay en la matriz
        PRINTSHIPS1
        mov si, INDEXtemp
        INC INDEX
        INC si
        JMP paintfila

    imprimirsaltolinea:
        mov si, 00
        INC di
        print saltolinea
        cmp di, 10
        jne printelcuadro
        je exit
    exit:
    RET
PAINTTABLEROBARCOS1_ ENDP

;?☻ ===================== PINTAR TABLERO SHOOTS 2======================= ☻
PAINTTABLEROSHOOTS2_ PROC NEAR
    mov si, 00
    mov di, 00
    MOV INDEX, 0
    paintfila:
        cmp si, 10
        jne printelcuadro
        je imprimirsaltolinea

    printelcuadro:
        mov INDEXtemp, si
        mov si, INDEX           ;* mostrar lo que hay en la matriz
        PRINTSHOOTS2
        mov si, INDEXtemp
        INC INDEX
        INC si
        JMP paintfila

    imprimirsaltolinea:
        mov si, 00
        INC di
        print saltolinea
        cmp di, 10
        jne printelcuadro
        je exit
    exit:
    RET
PAINTTABLEROSHOOTS2_ ENDP

;?☻ ===================== PINTAR TABLERO BARCOS 2======================= ☻
PAINTTABLEROBARCOS2_ PROC NEAR
    mov si, 00
    mov di, 00
    MOV INDEX, 0
    paintfila:
        cmp si, 10
        jne printelcuadro
        je imprimirsaltolinea

    printelcuadro:
        mov INDEXtemp, si
        mov si, INDEX           ;* mostrar lo que hay en la matriz
        PRINTSHIPS2
        mov si, INDEXtemp
        INC INDEX
        INC si
        JMP paintfila

    imprimirsaltolinea:
        mov si, 00
        INC di
        print saltolinea
        cmp di, 10
        jne printelcuadro
        je exit
    exit:
    RET
PAINTTABLEROBARCOS2_ ENDP



decorobarra_ PROC NEAR
    PR:
    print dt2
    RET
decorobarra_ ENDP


;?☻ ===================== OPCIONES DEL MENU ======================= ☻
OPCIONDEMENU_ PROC NEAR
    CMP keypress,'1'     ; si tecla es 1
    JNE CARGARJUEGOTEMP     ; sino es 1 se va a cargar
    JE INICIARJUEGO     ; SI SI ES SE VA A INICIARJUEGO

    CARGARJUEGOTEMP:
        CMP keypress,'2'  ; si tecla es 2
        JNE SALIR ; sino es 2 se va a SALIR
        JE CARGARJUEGO ; SI SI ES SE VA A CARGARJUEGO

    CARGARJUEGO:
        CARGADEJUEGOM
    INICIARJUEGO:
        INICIODEJUEGOM
    SALIR:
    RET
OPCIONDEMENU_ ENDP

;?☻ ===================== POSICIONAR EL CURSOR ======================= ☻
poscursor_ PROC NEAR
    ; FUNCION COLOCAR CURSOR

    mov ah, 02h ; FUNCION PARA COLOCAR EL CURSOR
    mov dh, POSX ; 12 FILA
    mov dl, POSY ; 12 COLUMNA
    INT 10h
    RET
poscursor_ ENDP

;?☻ =====================INICIO DEL JUEGO ================== ===== ☻
INICIODEJUEGOM_ PROC NEAR
    limpiar
    JUGADORINICIAL:
        RANDSTART:; OBTENGO QUIEN VA A SER EL PRIMERO EN JUGAR:
            MOV AH, 00h  ; interrupcion para jalar el tiempo en el sistema
            INT 1AH      ; CX:DX  toma numeros del reloj desde medianoche
            mov  ax, dx
            xor  dx, dx
            mov  cx, 2
            div  cx       ;DX tiene la divicion en mi caso - de 1 a 2
            add  dl, '1'  ; DL TIENE EL VALOR ENTRE 1 Y 2
            mov ah,2h
            int 21h

        CMP dl, '1'
        JNE INICIAELJUGADORUNO ; sino es 1 se va a JUGADOR 2
        JE INICIAELJUGADORUNO ; SI SI ES se va a JUGADOR 1
    INICIAELJUGADORUNO:
        poscursor 10, 20  ;* MUESTRO TEXTO INICIO
        print iniciaunotext
        readtext

        limpiar
        poscursor 0,0
        print jugandojugador1
        poscursor 0, 33
        print titledisparos
        poscursor 11, 33
        print titlebarcos

        poscursor 12, 0
        painttablero

        PRINTVIEWSHIPS      ;* MOSTRAR VISTA PA PEDIR SHIPS

        ;? ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░ PIDO BARCOS ░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        poscursor 15,51     ;! PIDO BARCO 1 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 2 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 3 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 4 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 5 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        ;? ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░ INICIO TURNO ░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        limpiar
        poscursor 10, 25
        print textiniciandojuego
        readtext
        JMP TURNOJUGADORDOS

    
    INICIAELJUGADORDOS:
        poscursor 10, 20
        print iniciadostext
        readtext

        limpiar
        poscursor 0,0
        print jugandojugador2
        poscursor 0, 33
        print titledisparos
        poscursor 11, 33
        print titlebarcos

        poscursor 12, 0
        painttablero

        PRINTVIEWSHIPS      ;* MOSTRAR VISTA PA PEDIR SHIPS

        ;? ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░ PIDO BARCOS ░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        poscursor 15,51     ;! PIDO BARCO 1 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 2 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 3 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 4 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        poscursor 15,51     ;! PIDO BARCO 5 A POSICIONAR
        ; EL USUARIO ESCRIBE SU BARCO
        readtext                ;? barco elegido guardado en keypress

        BARCOQUEELIGIO

        ;? ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░ INICIO TURNO ░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        limpiar
        poscursor 10, 25
        print textiniciandojuego
        readtext
        JMP TURNOJUGADORDOS
    TURNOJUGADORDOS:

    TURNOJUGADORUNO:

    RET
INICIODEJUEGOM_ ENDP

;?☻ ===================== CARGA DEL JUEGO ======================= ☻
CARGADEJUEGOM_ PROC NEAR
    RET
CARGADEJUEGOM_ ENDP



;?☻ ===================== HACER DISPARO JUG 1 ======================= ☻
shoot1_ PROC NEAR
    ;! HACER EL DISPARO EN POSICION AL = Y     AX = X
    ; mov dh, shootjug1y
    ; mov dl, shootjug1x
    mov al, shootjug1y   ; indice externo a accesar
    mov bl, 10  ; tamaño de cada arreglo almacenado en el primer nivel de la matriz
    mul bl      ; nos deja la respuesta en el ax.  Ocupamos que la dirección sea en 16 bits

    movzx bx, shootjug1x
    add ax, bx   ; sumamos el indice interno a la cantidad de celdas acumulada
    mov si, ax  ; Movemos la dirección al puntero SI
    ; mov dl, si
    ; mov ah, 2h
    ; int 21h
    Mov byte ptr matriz1[si], "1" ; finalmente movemos el dato.  Es importante lo de word ptr para indicar el tamaño

    RET
shoot1_ ENDP

;?☻ ===================== HACER DISPARO JUG 2 ======================= ☻
shoot2_ PROC NEAR
    ;! HACER EL DISPARO EN POSICION AL = Y     AX = X
    mov al, 2   ; indice externo a accesar
    mov bl, shootjug2y  ; tamaño de cada arreglo almacenado en el primer nivel de la matriz
    mul bl      ; nos deja la respuesta en el ax.  Ocupamos que la dirección sea en 16 bits
    movzx bx, shootjug2x
    add ax, bx   ; sumamos el indice interno a la cantidad de celdas acumulada
    ;shl ax, 1   ; Multiplicamos por 2 que es el tamaño del dato de cada celda
    mov si, ax  ; Movemos la dirección al puntero SI
    Mov byte ptr matriz2[si], "1" ; finalmente movemos el dato.  Es importante lo de word ptr para indicar el tamaño

    RET
shoot2_ ENDP

;?☻ ===================== READTEXT A NUMERO ======================= ☻
pasarreadtextanumeroY_ PROC NEAR
    INICIO:
        CMP keypress, "a"
        JNE NOESUNO
        JE SIESUNO
    SIESUNO:
        mov keypresstempY,0
        JMP SALIR
    NOESUNO:
        CMP keypress, "2"
        JNE NOESDOS
        JE SIESDOS
    SIESDOS:
        mov keypresstempY,1
        JMP SALIR
    NOESDOS:
        CMP keypress, "c"
        JNE NOESTRES
        JE SIESTRES
    SIESTRES:
        mov keypresstempY,2
        JMP SALIR
    NOESTRES:
        CMP keypress, "4"
        JNE NOESCUATRO
        JE SIESCUATRO
    SIESCUATRO:
        mov keypresstempY,3
        JMP SALIR
    NOESCUATRO:
        CMP keypress, "e"
        JNE NOESCINCO
        JE SIESCINCO
    SIESCINCO:
        mov keypresstempY,4
        JMP SALIR
    NOESCINCO:
        CMP keypress, "6"
        JNE NOESSEIS
        JE SIESSEIS
    SIESSEIS:
        mov keypresstempY,5
        JMP SALIR
    NOESSEIS:
        CMP keypress, "g"
        JNE NOESSIETE
        JE SIESSIETE
    SIESSIETE:
        mov keypresstempY,6
        JMP SALIR
    NOESSIETE:
        CMP keypress, "8"
        JNE NOESOCHO
        JE SIESOCHO
    SIESOCHO:
        mov keypresstempY,7
        JMP SALIR
    NOESOCHO:
        CMP keypress, "i"
        JNE NOESNUEVE
        JE SIESNUEVE
    SIESNUEVE:
        mov keypresstempY,8
        JMP SALIR
    NOESNUEVE:
        CMP keypress[0], "1"
        JNE NOESDIEZ
        JE ESDIEZTEMP
        ESDIEZTEMP:
            CMP keypress[0], "0"
            JNE NOESDIEZ
            JE SIESDIEZ
    SIESDIEZ:
        mov keypresstempY,9
        JMP SALIR
    NOESDIEZ:
        print NUMERONOVALIDO
        readtext
        JMP INICIO
    SALIR:
    RET
pasarreadtextanumeroY_ ENDP

pasarreadtextanumeroX_ PROC NEAR
    INICIO:
        CMP keypress, "1"
        JNE NOESUNO
        JE SIESUNO
    SIESUNO:
        mov keypresstempX,0
        JMP SALIR
    NOESUNO:
        CMP keypress, "b"
        JNE NOESDOS
        JE SIESDOS
    SIESDOS:
        mov keypresstempX,1
        JMP SALIR
    NOESDOS:
        CMP keypress, "3"
        JNE NOESTRES
        JE SIESTRES
    SIESTRES:
        mov keypresstempX,2
        JMP SALIR
    NOESTRES:
        CMP keypress, "d"
        JNE NOESCUATRO
        JE SIESCUATRO
    SIESCUATRO:
        mov keypresstempX,3
        JMP SALIR
    NOESCUATRO:
        CMP keypress, "5"
        JNE NOESCINCO
        JE SIESCINCO
    SIESCINCO:
        mov keypresstempX,4
        JMP SALIR
    NOESCINCO:
        CMP keypress, "f"
        JNE NOESSEIS
        JE SIESSEIS
    SIESSEIS:
        mov keypresstempX,5
        JMP SALIR
    NOESSEIS:
        CMP keypress, "7"
        JNE NOESSIETE
        JE SIESSIETE
    SIESSIETE:
        mov keypresstempX,6
        JMP SALIR
    NOESSIETE:
        CMP keypress, "h"
        JNE NOESOCHO
        JE SIESOCHO
    SIESOCHO:
        mov keypresstempX,7
        JMP SALIR
    NOESOCHO:
        CMP keypress, "9"
        JNE NOESNUEVE
        JE SIESNUEVE
    SIESNUEVE:
        mov keypresstempX,8
        JMP SALIR
    NOESNUEVE:
        CMP keypress, "j"
        JNE NOESDIEZ
        JE SIESDIEZ
    SIESDIEZ:
        mov keypresstempX,9
        JMP SALIR
    NOESDIEZ:
        print NUMERONOVALIDO
        readtext
        JMP INICIO
    SALIR:
    RET
pasarreadtextanumeroX_ ENDP

;?☻ ===================== REALIZAR EL DISPARO ======================= ☻
DISPARAR_ PROC NEAR
    ;************* obtengo valores X y Y
    ;TODO: VER QUE POSICION CURSOR
    pasarreadtextanumeroX       ;? OBTENGO X
    readtext
    pasarreadtextanumeroY          ;? OBTENGO Y
    shoot1 keypresstempX, keypresstempY                ;! DISPARO
    RET
DISPARAR_ ENDP

;?☻ ===================== ELECCION DE BARCO JUGADOR 1======================= ☻
BARCOQUEELIGIO_ PROC NEAR
    CUALELIGIO:
        CMP keypress, "1"
        JNE NOUNO
        JE SIUNO
    NOUNO:
        CMP keypress, "2"
        JNE NODOS
        JE SIDOS
    SIUNO:                      ;! SI ES 1
        poscursor 19,51 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,51 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,51 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO1
        JE NOPUEDOPONERBARQUITO1
    NOPUEDOPONERBARQUITO1:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SIUNO
    PUEDOPONERBARQUITO1:
        COLOCARBARCO1
        JMP SALIR
    
    NODOS:
        CMP keypress, "3"
        JNE NOTRES
        JE SITRES
    SIDOS:                      ;! SI ES 2
        poscursor 19,56 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,56 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,56 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO2
        JE NOPUEDOPONERBARQUITO2
    NOPUEDOPONERBARQUITO2:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SIDOS
    PUEDOPONERBARQUITO2:
        COLOCARBARCO2
        JMP SALIR

    NOTRES:
        CMP keypress, "4"
        JNE NOCUATRO
        JE SICUATRO
    SITRES:                      ;! SI ES 3
        poscursor 19,61 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,61 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,61 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO3
        JE NOPUEDOPONERBARQUITO3
    NOPUEDOPONERBARQUITO3:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SITRES
    PUEDOPONERBARQUITO3:
        COLOCARBARCO3
        JMP SALIR

    NOCUATRO:
        CMP keypress, "5"
        JNE NOCINCO
        JE SICINCO
    SICUATRO:                      ;! SI ES 4
        poscursor 19,66 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,66 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,66 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO4
        JE NOPUEDOPONERBARQUITO4
    NOPUEDOPONERBARQUITO4:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SICUATRO
    PUEDOPONERBARQUITO4:
        COLOCARBARCO4
        JMP SALIR
    SICINCO:                      ;! SI ES 5
        poscursor 19,71 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,71 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,71 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO5
        JE NOPUEDOPONERBARQUITO5
    NOPUEDOPONERBARQUITO5:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SICINCO
    PUEDOPONERBARQUITO5:
        COLOCARBARCO5
        JMP SALIR

    NOCINCO:
    SALIR:
    RET
BARCOQUEELIGIO_ ENDP

;?☻ ===================== ELECCION DE BARCO JUGADOR 2======================= ☻
BARCOQUEELIGIO2_ PROC NEAR
    CUALELIGIO:
        CMP keypress, "1"
        JNE NOUNO
        JE SIUNO
    NOUNO:
        CMP keypress, "2"
        JNE NODOS
        JE SIDOS
    SIUNO:                      ;! SI ES 1
        poscursor 19,51 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,51 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,51 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO1
        JE NOPUEDOPONERBARQUITO1
    NOPUEDOPONERBARQUITO1:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SIUNO
    PUEDOPONERBARQUITO1:
        COLOCARBARCO1
        JMP SALIR
    
    NODOS:
        CMP keypress, "3"
        JNE NOTRES
        JE SITRES
    SIDOS:                      ;! SI ES 2
        poscursor 19,56 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,56 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,56 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO2
        JE NOPUEDOPONERBARQUITO2
    NOPUEDOPONERBARQUITO2:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SIDOS
    PUEDOPONERBARQUITO2:
        COLOCARBARCO2
        JMP SALIR

    NOTRES:
        CMP keypress, "4"
        JNE NOCUATRO
        JE SICUATRO
    SITRES:                      ;! SI ES 3
        poscursor 19,61 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,61 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,61 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO3
        JE NOPUEDOPONERBARQUITO3
    NOPUEDOPONERBARQUITO3:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SITRES
    PUEDOPONERBARQUITO3:
        COLOCARBARCO3
        JMP SALIR

    NOCUATRO:
        CMP keypress, "5"
        JNE NOCINCO
        JE SICINCO
    SICUATRO:                      ;! SI ES 4
        poscursor 19,66 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,66 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,66 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO4
        JE NOPUEDOPONERBARQUITO4
    NOPUEDOPONERBARQUITO4:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SICUATRO
    PUEDOPONERBARQUITO4:
        COLOCARBARCO4
        JMP SALIR
    SICINCO:                      ;! SI ES 5
        poscursor 19,71 ;X
        readtext
        MOV AL, keypress
        MOV POSXBARCOSELECCIONADO, AL
        poscursor 20,71 ;Y
        readtext
        MOV AL, keypress
        MOV POSYBARCOSELECCIONADO, AL
        poscursor 21,71 ;R
        readtext
        MOV AL, keypress
        MOV ROTACIONBARCOSELECCIONADO, AL
        VALIDARESPACIO
        CMP FLAGPUEDOPONERBARCO, "0"
        JNE PUEDOPONERBARQUITO5
        JE NOPUEDOPONERBARQUITO5
    NOPUEDOPONERBARQUITO5:
        poscursor 23,47
        print textyahaybarcoalli
        JMP SICINCO
    PUEDOPONERBARQUITO5:
        COLOCARBARCO5
        JMP SALIR

    NOCINCO:
    SALIR:
    RET
BARCOQUEELIGIO2_ ENDP

VALIDARESPACIO_ PROC NEAR
    mov al, POSYBARCOSELECCIONADO   ; indice externo a accesar
    mov bl, 10  ; tamaño de cada arreglo almacenado en el primer nivel de la matriz
    mul bl      ; nos deja la respuesta en el ax.  Ocupamos que la dirección sea en 16 bits

    movzx bx, POSXBARCOSELECCIONADO
    add ax, bx   ; sumamos el indice interno a la cantidad de celdas acumulada
    mov si, ax
    CMP barcos1[si], "1"
    JNE ESTAFREE
    JE NOSEPUEDE
    ESTAFREE:
        MOV FLAGPUEDOPONERBARCO, "1"    ;! PUEDO PONER BARCO
        JMP EXIT
    NOSEPUEDE:
        MOV FLAGPUEDOPONERBARCO, "0"    ;! NO PUEDO PONER BARCO
        JMP EXIT
    EXIT:
    RET
VALIDARESPACIO_ ENDP

VALIDARESPACIO2_ PROC NEAR
    mov al, POSYBARCOSELECCIONADO   ; indice externo a accesar
    mov bl, 10  ; tamaño de cada arreglo almacenado en el primer nivel de la matriz
    mul bl      ; nos deja la respuesta en el ax.  Ocupamos que la dirección sea en 16 bits

    movzx bx, POSXBARCOSELECCIONADO
    add ax, bx   ; sumamos el indice interno a la cantidad de celdas acumulada
    mov si, ax
    CMP barcos2[si], "1"
    JNE ESTAFREE
    JE NOSEPUEDE
    ESTAFREE:
        MOV FLAGPUEDOPONERBARCO, "1"    ;! PUEDO PONER BARCO
        JMP EXIT
    NOSEPUEDE:
        MOV FLAGPUEDOPONERBARCO, "0"    ;! NO PUEDO PONER BARCO
        JMP EXIT
    EXIT:
    RET
VALIDARESPACIO2_ ENDP

;?☻ ===================== COLOCAR BARCOS JUGADOR 1 ======================= ☻
COLOCARBARCO1_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO1_ ENDP

COLOCARBARCO2_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ██████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO2_ ENDP

COLOCARBARCO3_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ██████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        JMP SALIR
    SALIR:
    RET
COLOCARBARCO3_ ENDP

COLOCARBARCO4_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ████████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl                                  ;! ██
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO4_ ENDP


 PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ██████████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl                                  ;! ██
        movzx bx, POSXBARCOSELECCIONADO         ;! ██
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO5_ ENDP

;?☻ ===================== COLOCAR BARCOS JUGADOR 1 ======================= ☻
COLOCARBARCO1JUG2_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO1JUG2_ ENDP

COLOCARBARCO2JUG2_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ██████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO2JUG2_ ENDP

COLOCARBARCO3JUG2_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ██████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        JMP SALIR
    SALIR:
    RET
COLOCARBARCO3JUG2_ ENDP

COLOCARBARCO4JUG2_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ████████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl                                  ;! ██
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO4JUG2_ ENDP

COLOCARBARCO5JUG2_ PROC NEAR
    VERROTACION:
        CMP ROTACIONBARCOSELECCIONADO, "1"
        JNE ESHORIZONTAL
        JE ESVERTICAL
    ESHORIZONTAL:                               ;! ██████████
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSXBARCOSELECCIONADO,1

        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    ESVERTICAL:                                 ;! ██
        mov al, POSYBARCOSELECCIONADO           ;! ██
        mov bl, 10                              ;! ██
        mul bl                                  ;! ██
        movzx bx, POSXBARCOSELECCIONADO         ;! ██
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"

        ;* sumo 1 a la posicion X
        ADD POSYBARCOSELECCIONADO,1
        
        mov al, POSYBARCOSELECCIONADO
        mov bl, 10
        mul bl
        movzx bx, POSXBARCOSELECCIONADO
        add ax, bx
        mov si, ax
        Mov byte ptr barcos1[si], "1"
        JMP SALIR
    SALIR:
    RET
COLOCARBARCO5JUG2_ ENDP

;?☻ ===================== RECORRER MATRIZ 1 ======================= ☻
recorrerm1_ PROC NEAR
    mov si, 00
    mov di, 00
    MOV INDEX, 0
    paintfila:
        cmp si, 10
        jne printelcuadro
        je imprimirsaltolinea

    printelcuadro:
        mov INDEXtemp, si

        mov si, INDEX           ;* mostrar lo que hay en la matriz
        mov dl, matriz1[si]
        mov ah, 2h
        int 21h
        mov si, INDEXtemp

        INC si
        INC index      ;* AUMENTO EL INDICE PRINCIPAL
        JMP paintfila

    imprimirsaltolinea:
        mov si, 00
        INC di
        print saltolinea
        cmp di, 10
        jne printelcuadro
        je exit
    exit:
    RET
recorrerm1_ ENDP

end     MAIN

;*  ░█████╗░██╗░░░░░██╗░░░██╗░█████╗░██████╗░░█████╗░    ░██████╗░█████╗░░█████╗░░█████╗░██████╗░
;*  ██╔══██╗██║░░░░░██║░░░██║██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗
;*  ███████║██║░░░░░╚██╗░██╔╝███████║██████╔╝██║░░██║    ╚█████╗░██║░░██║██║░░╚═╝██║░░██║██████╔╝
;*  ██╔══██║██║░░░░░░╚████╔╝░██╔══██║██╔══██╗██║░░██║    ░╚═══██╗██║░░██║██║░░██╗██║░░██║██╔═══╝░
;*  ██║░░██║███████╗░░╚██╔╝░░██║░░██║██║░░██║╚█████╔╝    ██████╔╝╚█████╔╝╚█████╔╝╚█████╔╝██║░░░░░
;*  ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░    ╚═════╝░░╚════╝░░╚════╝░░╚════╝░╚═╝░░░░░

