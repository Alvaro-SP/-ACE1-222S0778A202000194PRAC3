
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
keypress        DB ?
;--------------------------  COLORES -----------------------------
BLACK               EQU  00H
VARIABLE_COLOR      DB  ?
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
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------

KEY_PRESSED                     DB  ?


;████████████████████████████ SEGMENTO DE CODIGO ████████████████████████████
.CODE
;                ░█▀▄▀█ ─█▀▀█ ░█▀▀█ ░█▀▀█ ░█▀▀▀█ ░█▀▀▀█ 
;                ░█░█░█ ░█▄▄█ ░█─── ░█▄▄▀ ░█──░█ ─▀▀▀▄▄ 
;                ░█──░█ ░█─░█ ░█▄▄█ ░█─░█ ░█▄▄▄█ ░█▄▄▄█
    print MACRO MYMESSAGE , LOCATION,COLOR                            ; ▬▬▬▬▬ IMPRIMIR
        PUSHA
        MOV DX,LOCATION
        MOV BP, OFFSET MYMESSAGE
        MOV SI, COLOR
        CALL  print_
        POPA
    ENDM print

    misdatos MACRO                                                     ; ▬▬▬▬▬ DATOS
        PUSHA
        CALL misdatos_
        POPA
    ENDM misdatos

    limpiar MACRO                                                     ; ▬▬▬▬▬ LIMPIAR
        PUSHA
        mov ah, 00h
        mov ah, 03h
        int 10h
        POPA
    ENDM limpiar

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

    ; ======================== DIBUJAR EN PANTALLA ============================
    paint	MACRO	CORNER1X, CORNER1Y, CORNER2X, CORNER2Y, COLOR
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
    ;========================= ESPERAR TECLA ===================================
    esperatecla MACRO
        PUSHA
        CALL esperatecla_
        POPA
    ENDM  esperatecla

    ;========================= MENU PRINCIPAL ===================================
    menu MACRO                                                     ; ▬▬▬▬▬ MENU
        PUSHA
        CALL menu_
        POPA
    ENDM menu
    leermenu    MACRO
        PUSHA
        CALL leermenu_
        POPA
    ENDM    leermenu



; ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █▀▄▀█ ▄▀█ █ █▄░█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
; ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █░▀░█ █▀█ █ █░▀█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
main PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    misdatos
    esperaenter
    paint  0, 0, 800, 600, BLACK ;LIMPIA TODO :V
    menu


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
        print keypress , 1A10H , 0FF30H
        inc si
        jmp Leer
    Salir:
        print keypress , 1A10H , 0FF30H
        ; PONER MENSAJE ... print keypress , 2125H , 0FF30H


    esperaenter
    ;pintarTABLERO1

    limpiar
    HLT ; para decirle al CPU que se estara ejecutando varias veces (detiene CPU hasta sig interrupcion)
    RET
main    ENDP




;☻ ===================== METODO MOSTRAR DATOS ======================= ☻
misdatos_     PROC NEAR
    MOV AX,4F02H           ;SETEAMOS EL MODO VIDEO INT 10   800*600
    MOV BX,103H
    INT 10H
    ; imprimo el texto de inicio
    print tb1 , 0820H , 0FF28H
    print tb2 , 0F10h , 0FF0FH
    print tb3 , 1210H , 0FF0FH
    print tb4 , 1410H , 0FF0FH
    print tb5 , 1610H , 0FF0FH
    print tb6 , 1810H , 0FF0FH
    print tb7 , 1A10H , 0FF0FH
    print pressenter , 2125H , 0FF30H
    RET
misdatos_     ENDP

;☻ ===================== METODO MOSTRAR DATOS ======================= ☻
menu_     PROC NEAR
    ;MOV AX,4F02H           ;SETEAMOS EL MODO VIDEO INT 10   800*600
    ;MOV BX,103H
    ;INT 10H
    ; imprimo el texto de inicio
    print tm1 , 0820H , 0FF26H
    print tm2 , 0F10h , 0FF0FH
    print tm3 , 1210H , 0FF0FH
    print tm4 , 1410H , 0FF0FH

    RET
menu_     ENDP


;☻ ===================== METODO IMPRIMIR ======================= ☻
print_    PROC NEAR
    MOV AX,1301H
    MOV BX,BP
    MOV CL,[BX]
    MOV CH,00H
    ADD BP,1H
    MOV BX,SI
    INT 10H
    RET
print_    ENDP

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


leermenu_   PROC  NEAR
    
    RET
leermenu_ ENDP

end     MAIN

;  ░█████╗░██╗░░░░░██╗░░░██╗░█████╗░██████╗░░█████╗░    ░██████╗░█████╗░░█████╗░░█████╗░██████╗░
;  ██╔══██╗██║░░░░░██║░░░██║██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗
;  ███████║██║░░░░░╚██╗░██╔╝███████║██████╔╝██║░░██║    ╚█████╗░██║░░██║██║░░╚═╝██║░░██║██████╔╝
;  ██╔══██║██║░░░░░░╚████╔╝░██╔══██║██╔══██╗██║░░██║    ░╚═══██╗██║░░██║██║░░██╗██║░░██║██╔═══╝░
;  ██║░░██║███████╗░░╚██╔╝░░██║░░██║██║░░██║╚█████╔╝    ██████╔╝╚█████╔╝╚█████╔╝╚█████╔╝██║░░░░░
;  ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░    ╚═════╝░░╚════╝░░╚════╝░░╚════╝░╚═╝░░░░░