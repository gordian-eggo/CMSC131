; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 01: Get the computed average of two 3-digit inputs

section .data
	prompt db "Enter a 3-digit number: "
	prompt_len equ $-prompt
	newline db 10

section .bss
	f_huns resb 1
	f_tens resb 1
	f_ones resb 1
	s_huns resb 1
	s_tens resb 1
	s_ones resb 1
	num1 resw 1
	num2 resw 1
	ave_hun resb 1
	ave_tens resb 1
	ave_ones resb 1
	quotient resb 1
	remainder resb 1
	test_value resb 1

section .text
	global _start

_start:
	
	; prompt user for first 3-digit number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
		int 80h

	; get tens and ones digit of first input
	; then convert to integers

	mov eax, 3
	mov ebx, 0
	mov ecx, f_huns
	mov edx, 1
		int 80h

	sub byte [f_huns], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, f_tens
	mov edx, 1
		int 80h

	sub byte [f_tens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, f_ones
	mov edx, 3
		int 80h
	
	sub byte [f_ones], 30h

	; prompt user for second number and convert to integer

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, s_huns
	mov edx, 1
		int 80h

	sub byte [s_huns], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, s_tens
	mov edx, 1

	sub byte [s_tens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, s_ones
	mov edx, 3
		int 80h
	
	sub byte [s_ones], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	; convert the digits into one whole number

	mov al, [f_huns]
	mov bl, 100
	mul byte bl
	mov [f_huns], al 	; value of f_huns is now the hundreds digit * 100

	mov al, [f_tens]
	mov bl, 10
	mul byte bl 
	mov [f_tens], al 	; value of f_tens is now tens digit * 10

	mov al, [f_huns]
	add al, [f_tens]
	add al, [f_ones]
	mov [num1], al

	mov al, [num1]
	mov bl, 100
	div byte bl
	mov [f_huns], al

	mov [f_tens], ah
	mov al, [f_tens]
	mov bl, 10
	div word bl

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	; terminate

	mov eax, 1
	mov ebx, 0
		int 80h