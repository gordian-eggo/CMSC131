; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 05: Print prime numbers from 1 to N where N is a two-digit number.
;		   Global variables may not be used inside the stack.	

section .data

	prompt db "Enter a number: "
	plen equ $-prompt
	result db "Prime numbers: "
	rlen equ $-result
	space db " space "
	slen equ $-space
	newline db 10

section .bss

	num resw 1
	is_prime resw 1
	tens resw 1
	ones resw 1

section .text

	global _start

_start: 
	
	mov eax, 4					; is supposed to get 
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	sub esp, 6
	call get_num
	pop word[num]

	mov ax, [num]
	mov bx, 10
	div word bx
	mov [tens], ax
	mov [ones], dx

	add word[tens], 30h
	add word[ones], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, tens
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ones
	mov edx, 1
		int 80h

exit:

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 1
	mov ebx, 0
		int 80h

get_num:

	mov ebp, esp			; put PC on the stack

	mov eax, 3					; get first digit
	mov ebx, 0
	lea ecx, [ebp - 2]
	mov edx, 1
		int 80h

	sub word[ebp - 2], 30h

	xor ax, ax
	mov ax, [ebp - 2]
	mov bx, 10
	mul word bx
	mov [ebp + 4], ax			; move to [ebp + 4]

	mov eax, 3					; get second digit
	mov ebx, 0
	lea ecx, [ebp - 4]
	mov edx, 2
		int 80h

	sub word[ebp - 4], 30h

	xor ax, ax
	mov ax, [ebp - 4]
	add word[ebp + 4], ax		; add ones digit to tens digit. now num at [ebp + 4] = input

	ret 4