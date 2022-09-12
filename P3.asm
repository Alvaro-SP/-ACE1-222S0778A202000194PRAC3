
;     █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   █▀▄▀█ █▄█   █▀▀ ▄▀█ █▀▄▀█ █▀▀
;     ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   █░▀░█ ░█░   █▄█ █▀█ █░▀░█ ██▄
; ---------------------------------------------------------------------------------------------------
.MODEL LARGE
.386
.STACK 64
.DATA

;--------------------------  MIS_DATOS -----------------------------
tb1             DB   38,'BIENVENIDO AL JUEGO BATTLESHIPS !!!!!!'
tb2             DB   38,'Universidad de San Carlos de Guatemala'
tb3             DB   22,'Facultad de Ingenieria'
tb4             DB   30,'Escuela de Ciencias y Sistemas'
tb5             DB   9,'Seccion A'
tb6             DB   27,'ALVARO EMMANUEL SOCOP PEREZ'
tb7             DB   9,'202000194'
pressenter      DB   24,'ENTER: Para continuar...'

;--------------------------     MENU    -----------------------------
tm1             DB   29,'------- MENU PRINCIPAL ------'
tm2             DB   16,'1. Iniciar Juego'
tm3             DB   15,'2. Cargar Juego'
tm4             DB   8,'3. Salir'
keypress          DB ?, "$"
tm1c             DB   '------- MENU PRINCIPAL ------',10, 13, "$"
tm2c             DB   '1. Iniciar Juego',10, 13, "$"
tm3c             DB   '2. Cargar Juego',10, 13, "$"
tm4c             DB   '3. Salir',10, 13, "$"
;--------------------------  COLORES -----------------------------
BLACK               EQU  00H
BLUE                EQU  01H
GREEN               EQU  02H
CYAN                EQU  03H
RED                 EQU  04H
MAGENTA             EQU  05H
BROWN               EQU  06H
LIGHT_GRAY          EQU  07H
DARK_GRAY           EQU  08H
LIGHT_BLUE          EQU  09H
LIGHT_GREEN         EQU  0AH
LIGHT_CYAN          EQU  0BH
LIGHT_RED           EQU  0CH
LIGHT_MAGENTA       EQU  0DH
YELLOW              EQU  0EH
WHITE               EQU  0FH

;---------------- COORDENADAS ----------
GRID1_X            DW  ?
GRID2_X            DW  ?
GRID1_Y            DW  ?
GRID2_Y            DW  ?
PIXELS1_X          DW  ?
PIXELS2_X          DW  ?
PIXELS1_Y          DW  ?
PIXELS2_Y          DW  ?

;--------------------------  PARAMETROS DIBUJAR -----------------------------
X1              DW  ?
X2              DW  ?
Y1              DW  ?
Y2              DW  ?
;--------------------------  DRAWING THE TABLES -----------------------------
square          DB "[",219,"]  ", "$";██
shoot           DB "X", 10, "$"
dshoot          DB "O", 10, 13, "$"
;square          DB "Ingrese su nombre: ", 10, 13, "$"
saltolinea      DB " ",10, 13, "$"

;--------------------------  JUGADOR -----------------------------
iniciaunotext db "---EL JUGADOR 1 INICIA LA PARTIDA---", 10, 13, "$"
borrarlinea     DB "                                        ",13
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
temp DW  ?
KEY_PRESSED                     DB  ?


;████████████████████████████ SEGMENTO DE CODIGO ████████████████████████████
.CODE
;                ░█▀▄▀█ ─█▀▀█ ░█▀▀█ ░█▀▀█ ░█▀▀▀█ ░█▀▀▀█ 
;                ░█░█░█ ░█▄▄█ ░█─── ░█▄▄▀ ░█──░█ ─▀▀▀▄▄ 
;                ░█──░█ ░█─░█ ░█▄▄█ ░█─░█ ░█▄▄▄█ ░█▄▄▄█
    PAINTTEXT MACRO MYMESSAGE , LOCATION,COLOR                            ; ▬▬▬▬▬ IMPRIMIR
        PUSHA
        MOV DX,LOCATION
        MOV BP, OFFSET MYMESSAGE
        MOV SI, COLOR
        CALL  PAINTTEXT_
        POPA
    ENDM PAINTTEXT

    misdatos MACRO                                                     ; ▬▬▬▬▬ DATOS
        PUSHA
        CALL misdatos_
        POPA
    ENDM misdatos

    ;========================= VIDEO ===================================
    esperatecla MACRO
        PUSHA
        CALL esperatecla_
        POPA
    ENDM  esperatecla

    paint	MACRO	CORNER1X, CORNER1Y, CORNER2X, CORNER2Y, COLOR ; ▬▬▬▬▬ MENU DIBUJAR EN PANTALLA 
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
    esperaenter MACRO                                                  ; ▬▬▬▬▬ ENTER
        PUSHA
        mov ax, 00
        mov ah, 01h
        int 21h
        POPA
    ENDM esperaenter

    enterclick MACRO                                                  ; ▬▬▬ ENTER
        PUSHA
        CALL enterclick_
        POPA
    ENDM enterclick

    ;========================= MENU PRINCIPAL ===================================
    menu MACRO                                                     ; ▬▬▬▬▬ MENU
        PUSHA
        CALL menu_
        POPA
    ENDM menu

    ;========================= CONSOLA ===================================
    limpiar MACRO                                                     ; ▬▬▬▬▬ LIMPIAR
        mov ah, 00h
        mov al, 03h
        int 10h
    ENDM limpiar

    readtext MACRO                                            ; ▬▬▬▬▬ LEER DE CONSOLA
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

                    ;   ▜▛ ▞▚ ▙ ▙▄ █☰ 🆁 ██ ▟▛ 
    painttablero MACRO
        PUSHA
        CALL painttablero_
        POPA
    ENDM painttablero

    obtainrandom MACRO
        PUSHA
        CALL obtainrandom_
        POPA
    ENDM obtainrandom
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
; ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █▀▄▀█ ▄▀█ █ █▄░█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
; ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █░▀░█ █▀█ █ █░▀█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
main PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    ;misdatos
    ;esperaenter
    ;paint  0, 0, 800, 600, BLACK ;LIMPIA TODO :V
    ;menu
    ;esperaenter
    limpiar

    print tm1c
    print tm2c
    print tm3c
    print tm4c
    readtext

    OPCIONDEMENU

    ;limpiar
    mov ax, 4c00h
    int 21h
    HLT ; para decirle al CPU que se estara ejecutando varias veces (detiene CPU hasta sig interrupcion)
    RET
main    ENDP



;☻ ===================== METODO MOSTRAR DATOS ======================= ☻
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

;☻ ===================== METODO MOSTRAR DATOS ======================= ☻
menu_     PROC NEAR
    PAINTTEXT tm1 , 0820H , 0FF26H
    PAINTTEXT tm2 , 0F10h , 0FF0FH
    PAINTTEXT tm3 , 1210H , 0FF0FH
    PAINTTEXT tm4 , 1410H , 0FF0FH
    RET
menu_     ENDP


;☻ ===================== METODO IMPRIMIR ======================= ☻
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

;☻ ===================== PRESIONAR TECLAS ======================= ☻
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



;☻ ===================== DIBUJAR EN PANTALLA ======================= ☻
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

;☻ ===================== DIBUJAR EN PANTALLA ======================= ☻
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

;☻ ===================== DIBUJAR EN PANTALLA ======================= ☻
painttablero_ PROC NEAR
    mov si, 00
    mov di, 00
    paintfila:
        cmp si, 10
        jne printelcuadro
        je imprimirsaltolinea

    printelcuadro:
        print square
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
painttablero_ ENDP

;☻ ===================== SORTEO DEL JUGADOR QUE INICIA ======================= ☻
obtainrandom_ PROC NEAR
    RANDGEN:         ; generate a rand no using the system time
    RANDSTART:
    MOV AH, 00h  ; interrupts to get system time
    INT 1AH      ; CX:DX now hold number of clock ticks since midnight

    mov  ax, dx
    xor  dx, dx
    mov  cx, 2
    div  cx       ; here dx contains the remainder of the division - from 1 to 2

    add  dl, '1'  ; DL TIENE EL VALOR ENTRE 1 Y 2
    RET
obtainrandom_ ENDP


;☻ ===================== OPCIONES DEL MENU ======================= ☻
OPCIONDEMENU_ PROC NEAR
    CMP keypress,1      ; si tecla es 1
    JNE CARGARJUEGOTEMP     ; sino es 1 se va a cargar
    JE INICIARJUEGO     ; SI SI ES SE VA A INICIARJUEGO

    CARGARJUEGOTEMP:
        CMP keypress,2  ; si tecla es 2
        JNE SALIR ; sino es 2 se va a SALIR
        JE CARGARJUEGO ; SI SI ES SE VA A CARGARJUEGO

    CARGARJUEGO:
        CARGADEJUEGOM
    INICIARJUEGO:
        obtainrandom ; OBTENGO QUIEN VA A SER EL PRIMERO EN JUGAR:
        INICIODEJUEGOM
    SALIR:
    RET
OPCIONDEMENU_ ENDP

;☻ =====================INICIO DEL JUEGO ================== ===== ☻
INICIODEJUEGOM_ PROC NEAR
    JUGADORINICIAL:
        CMP dl, 1
        JNE INICIAELJUGADORDOS ; sino es 1 se va a JUGADOR 2
        JE INICIAELJUGADORUNO ; SI SI ES se va a JUGADOR 1
    INICIAELJUGADORUNO:
        print iniciaunotext
    INICIAELJUGADORDOS:
        print iniciadostext

    RET
INICIODEJUEGOM_ ENDP

;☻ ===================== CARGA DEL JUEGO ======================= ☻
CARGADEJUEGOM_ PROC NEAR
    RET
CARGADEJUEGOM_ ENDP

end     MAIN

;  ░█████╗░██╗░░░░░██╗░░░██╗░█████╗░██████╗░░█████╗░    ░██████╗░█████╗░░█████╗░░█████╗░██████╗░
;  ██╔══██╗██║░░░░░██║░░░██║██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗
;  ███████║██║░░░░░╚██╗░██╔╝███████║██████╔╝██║░░██║    ╚█████╗░██║░░██║██║░░╚═╝██║░░██║██████╔╝
;  ██╔══██║██║░░░░░░╚████╔╝░██╔══██║██╔══██╗██║░░██║    ░╚═══██╗██║░░██║██║░░██╗██║░░██║██╔═══╝░
;  ██║░░██║███████╗░░╚██╔╝░░██║░░██║██║░░██║╚█████╔╝    ██████╔╝╚█████╔╝╚█████╔╝╚█████╔╝██║░░░░░
;  ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░    ╚═════╝░░╚════╝░░╚════╝░░╚════╝░╚═╝░░░░░

