
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

;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
;--------------------------  MIS_DATOS -----------------------------
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
WAIT_FOR_THE_OTHER_PLAYER_MSG   DB  45,"- Please wait the other player to press ENTER" 
MY_INDEX                        EQU 1
OTHER_PLAYER_INDEX              EQU 2
WAIT_TO_RECEIEVE_ATTACK_COORD   DB  28,"WAIT TO RECEIEVE ATTACK COORD"
WAIT_TO_RECEIEVE_ATTACK_RESULT   DB  29,"WAIT TO RECEIEVE ATTACK RESULT"
ATTACKX_STRING        DB  2,?,?
ATTACKY_STRING        DB  1,?

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

; ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █▀▄▀█ ▄▀█ █ █▄░█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
; ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬      █░▀░█ █▀█ █ █░▀█       ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
main PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    misdatos
    esperaenter
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


end     MAIN

;  ░█████╗░██╗░░░░░██╗░░░██╗░█████╗░██████╗░░█████╗░    ░██████╗░█████╗░░█████╗░░█████╗░██████╗░
;  ██╔══██╗██║░░░░░██║░░░██║██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗
;  ███████║██║░░░░░╚██╗░██╔╝███████║██████╔╝██║░░██║    ╚█████╗░██║░░██║██║░░╚═╝██║░░██║██████╔╝
;  ██╔══██║██║░░░░░░╚████╔╝░██╔══██║██╔══██╗██║░░██║    ░╚═══██╗██║░░██║██║░░██╗██║░░██║██╔═══╝░
;  ██║░░██║███████╗░░╚██╔╝░░██║░░██║██║░░██║╚█████╔╝    ██████╔╝╚█████╔╝╚█████╔╝╚█████╔╝██║░░░░░
;  ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░    ╚═════╝░░╚════╝░░╚════╝░░╚════╝░╚═╝░░░░░