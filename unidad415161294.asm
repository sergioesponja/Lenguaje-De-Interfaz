
segment .data
msg1 db "Ingrese un numero entre 10 y 44:",10,13
len equ $-msg1

ln db 10,13
lenln equ $-ln

arre db 0,0,0
la equ $-arre

segment .bss
datos resb 4

segment .text

global _start


_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len
int 0x80

    mov eax, 3 ;lee los valores desde el teclado
	mov ebx, 0
	mov ecx, datos
	mov edx, 4
	int 0x80

ciclo:

mov eax, [datos+0] ;guarda el valor de la direccion con posicion [datos+0]
                   ;en eax
sub eax, 48        ;le resta el caracter '0' a eax para tener el num. real.
mov ebx, [datos+1]
sub ebx, 48
mov edi, 10
mul edi

add eax, ebx
mov [arre+0], eax

mov esi, arre  ;guarda la direccion de arre en esi
mov edi, 0  ;sirve de contador para recorrer "arre"

mov [esi+edi], eax ;guarda lo que esta en la posicion [edi+esi]

operacion:
mov ah, 0
mov al, [esi+edi]
mov dl, 100  ;divisor; el cociente seran las centenas.
div dl  ;dividimos lo que esta en al entre dl.

mov [datos+0], al ;recuperamos el cociente en al
mov [datos+1], ah ;recuperamos el residuo en ah.



mov ah, 0
mov al, [datos+1] ; el residuo de la anterior operacion.
mov dl, 10 ;dividimos entre 10.
div dl

mov [datos+1], al  ;recuperamos el cociente.
mov [datos+2], ah ;recuperamos el residuo.

mov ax, [datos+0] ; almacenamos la centena en ax.
mov bx, ax ;agregamos el valor de ax en bx.
mul bx ; ax = ax * bx
mov cx, ax ; cx = ax

mov ax, [datos+1] ;almacenamos las decenas
mov bx, ax
mul bx
add cx, ax


mov ax, [datos+2];almacenamos las unidades.
mov bx ,ax
mul bx
add cx, ax

mov [esi+edi], cx ;almacenamos la suma de los cuadrados de centenas,
                  ; decenas y unidades.

    mov ah,0
	mov al, [esi+edi]
	mov dl, 100       ;mov dl,100
	div dl
	add al, '0'
	mov [datos+0], al ;centena
	mov [datos+1],ah
	mov ah,0
	mov al,[datos+1]
	mov dl,10
	div dl
	add al,'0'
	mov [datos+1],al  ;decena
	add ah, '0'
	mov [datos+2], ah ;unidad 

imprimir:
mov eax, 4
mov ebx, 1
mov ecx, datos
mov edx, 3
int 0x80

mov ax,[datos+2] ;recupera el valor de nuestro numero
	sub ax,'0'   ;se le resta el caracter '0' para tener el numero real
	cmp ax, 1    ;comparamos el numero en ax.
je salir         ;si ax = 1, se salta a la etiqueta "salir"

jmp operacion    ;si ax != 1, retrocede hacia la etiqueta "operacion"

salir:
mov eax, 1
mov ebx, ebx
int 0x80





;mov al, [esi+edi]      importante
;add al, '0'            importante
;mov [datos], al        importante

;mov eax, 4
;mov ebx, 1
;mov ecx, datos
;mov edx, 1
;int 0x80

;mov eax, 4
;mov ebx, 1
;mov ecx, ln
;mov edx, lenln
;int 0x80


;add edi, 1
;mov al, [esi+edi]
;add al, '0'
;mov [datos], al

;mov eax, 4
;mov ebx, 1
;mov ecx, datos
;mov edx, 1
;int 0x80



