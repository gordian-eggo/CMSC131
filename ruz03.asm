; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 03: Sort three 2-digit number inputs in descending order.

section .data

	prompt db "Enter signed number: "
	plen equ $-prompt
	output db "Inputs sorted in descending order: "
	olen equ $-output
	newline db 10

section .bss

	fsign resb 1
	ftens resb 1
	fones resb 1
	num1 resb 1
	ssign resb 1
	stens resb 1
	sones resb 1
	num2 resb 1
	tsign resb 1
	ttens resb 1
	tones resb 1
	num3 resb 1

section .text

	global _start

_start:
	
	; get first number
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, fsign
	mov edx, 1
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, ftens
	mov edx, 1
		int 80h

	sub byte [ftens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, fones
	mov edx, 2
		int 80h

	sub byte [fones], 30h

	; convert to integer
	mov al, [ftens]
	mov bl, 10
	mul byte bl
	add byte al, [fones]
	mov [num1], al

	; get second number
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, ssign
	mov edx, 1
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, stens
	mov edx, 1
		int 80h

	sub byte [stens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, sones
	mov edx, 2
		int 80h

	sub byte [sones], 30h

	; convert to integer
	mov al, [stens]
	mov bl, 10
	mul byte bl
	add byte al, [sones]
	mov [num2], al

	; get third number
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, tsign
	mov edx, 1
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, ttens
	mov edx, 1
		int 80h

	sub byte [ttens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, tones
	mov edx, 2
		int 80h

	sub byte [tones], 30h

	; convert to integer
	mov al, [ttens]
	mov bl, 10
	mul byte bl
	add byte al, [tones]
	mov [num3], al

	; test prints

	mov al, [num1]
	mov bl, 10
	div byte bl
	mov [ftens], al
	mov [fones], ah

	add byte [ftens], 30h
	add byte [fones], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, fsign
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ftens
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, fones
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov al, [num2]
	mov bl, 10
	div byte bl
	mov [stens], al
	mov [sones], ah

	add byte [stens], 30h
	add byte [sones], 30h	

	mov eax, 4
	mov ebx, 1
	mov ecx, ssign
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, stens
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, sones
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov al, [num3]
	mov bl, 10
	div byte bl
	mov [ttens], al
	mov [tones], ah

	add byte [ttens], 30h
	add byte [tones], 30h	

	mov eax, 4
	mov ebx, 1
	mov ecx, tsign
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ttens
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, tones
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	jmp exit

exit:

	mov eax, 1
	mov ebx, 0
		int 80h