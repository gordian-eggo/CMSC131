; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 02: Get the largest of three two-digit numbers

section .data
	prompt db "Enter a two-digit number: "
	plen equ $-prompt
	largest db "The largest number is "
	llen equ $-largest
	newline db 10

section .bss
	ftens resb 1
	fones resb 1
	num1 resb 1
	stens resb 1
	sones resb 1
	num2 resb 1
	ttens resb 1
	tones resb 1
	num3 resb 1
	greatest resb 1

section .text
	global _start

_start:

	; prompt user for first number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
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

	; prompt user for second number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
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

	; prompt user for third number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
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

	; move into registers and find largest number

	mov al, [num1]			; al == num1
	mov bl, [num2]			; bl == num2
	mov cl, [num3]			; cl == num3

	cmp al, bl				; is al > bl?
	jae compare_1and3		; if al > bl, compare al and cl
	jbe compare_2and3		; else compare bl and cl

	compare_1and3:			; same structure for all comparison functions

		cmp al, cl		
		jae return_num1		; use jae/jbe to catch the instance where two or more numbers are equal


	compare_2and3:

		cmp bl, cl
		jae return_num2
		jbe return_num3

	return_num1:			; return num1 as largest
							; same structure for other return_num functions
		mov eax, 4
		mov ebx, 1
		mov ecx, largest
		mov edx, llen
			int 80h

		mov al, [num1]
		mov bl, 10
		div byte bl
		mov [ftens], al
		mov [fones], ah
	
		add byte [ftens], 30h
		add byte [fones], 30h
	
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

		jmp exit

	return_num2:

		mov eax, 4
		mov ebx, 1
		mov ecx, largest
		mov edx, llen
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

		jmp exit

	return_num3:

		mov eax, 4
		mov ebx, 1
		mov ecx, largest
		mov edx, llen
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

exit:							; exit program
	
	mov eax, 1
	mov ebx, 0
		int 80h