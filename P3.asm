.model small

.stack

.data
    var1 db "HELLO WORLD", "$"
.code
; MACRO SIRVE PARA REUTILIZAR CODIGO:
        ; se pueden usar etiquetas y saltos


imprimir macro texto
    mov ah, 09
    mov dx, offset texto
    int 21h
endm



main proc
    mov ax, @data
    mov ds, ax
    ; se usan interrupciones para mostrar cosas
    ; http://arantxa.ii.uam.es/~gdrivera/labetcii/int_dos.htm

    imprimir var1
    mov ah, 09
    mov dx, offset var1
    int 21h

    ;SALIDA DEL PROGRAMA
    MOV AX , 4c000h
    AX = 4C00H ; siempre al finalizar el programa.

main endp
end main

;EJECUTAR DOS BOX
; Se monta el Bin en disco local C

; ML.EXE <== para compilar el programa.
; nl ejemploAux.ASM  