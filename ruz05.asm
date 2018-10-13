; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 05: Print prime numbers from 1 to N where N is a two-digit number.
;		   Global variables may not be used inside labels accessing the stack.	

section .data

	prompt db "Enter a number: "
	plen equ $-prompt
	result db "Prime numbers: "
	rlen equ $-result
	space db " "
	slen equ $-space
	newline db 10

section .text

	global _start

_start: 

	sub esp, 2
	call get_num

exit:

	mov eax, 1
	mov ebx, 0
		int 80h

get_num:

	mov ebp, esp			; put PC on the stack
	sub esp, 2				; allocate local variable
	
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3					; get first digit
	mov ebx, 0
	lea ecx, [ebp + 4]
	mov edx, 1
		int 80h

	sub word[ebp + 4], 30h

	mov ah, 0					; convert the tens digit right away
	mov ax, [ebp + 4]
	mov bx, 10
	mul word bx
	mov [ebp - 2], ax			; move to [ebp - 2] on top of PC

	mov eax, 3					; get second digit
	mov ebx, 0
	lea ecx, [ebp + 4]
	mov edx, 2
		int 80h

	sub word[ebp + 4], 30h

	mov ah, 0
	mov ax, [ebp + 4]
	add word[ebp - 2], ax		; add ones digit to tens digit
	mov cx, [ebp - 2]			; move the value into ax

	add esp, 2

	jmp print_num

print_num:

	sub esp, 4

	mov [ebp - 2], cx			; move the value into the local value so you can clear the register

	mov al, 0					; made extra sure to clear the register
	mov ah, 0					

	mov ax, [ebp - 2]			;  move the value back into ax from the local variable
	mov bx, 10
	div word bx
	mov [ebp - 2], al 			; move tens to [ebp - 2]
	mov [ebp - 4], ah			; move ones to [ebp - 4]

	add word[ebp - 2], 30h
	add word[ebp - 4], 30h

	mov eax, 4
	mov ebx, 1
	lea ecx, [ebp - 2]
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	lea ecx, [ebp - 4]
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	add esp, 4

	ret 2