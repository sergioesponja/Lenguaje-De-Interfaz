  section .data
    msg1 db "Conjetura de Collatz:",10,13
    len1 equ $-msg1


  section .bss
	num1 resb 4
    aux resb 2
section  .text
	global _start  ;must be declared for using gcc

_start:  ;tell linker entry point

    mov eax, 4 
	mov ebx, 1 
	mov ecx, msg1 
	mov edx, len1 
	int 0x80
    

    mov eax, 3 ;lee los valores desde el teclado
	mov ebx, 2
	mov ecx, num1
	mov edx, 1
	int 0x80

    
    mov ax, [num1]
    sub ax, 48
    mov [aux], ax



    imprimir:
    mov ax, [aux]
    add ax, 48
    mov [num1], ax

    mov eax, 4 
	mov ebx, 1 
	mov ecx, num1
	mov edx, 4
	int 0x80
    
    loop ciclo

  ciclo:
  mov ax, [aux]
   cmp ax, 1

   je salir


   operacion:
   mov ax, [aux]

   mov bx, 2
   mov dx, 0
   div bx
   cmp dx, 0

   je par


impar:
   mov ax, [aux]
   mov bx, 3
   mul bx
   add ax, 1
   mov [aux], ax

   jmp imprimir


   par:
   mov ax, [aux]
   mov bx, 2
   div bx
   mov [aux], ax

   jmp imprimir



   salir:
    mov eax, 1
    xor ebx, ebx
    int 0x80