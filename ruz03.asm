; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 03: Sort three 2-digit number inputs in descending order.

section .data

	prompt db "Enter signed number: "
	plen equ $-prompt
	output db "Inputs sorted in descending order: "
	olen equ $-output
	tester db "hi"
	tlen equ $-tester
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
	temp resb 1

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

	; check for negation
	cmp byte [fsign], "-"
	jne get_second_input
	neg byte [num1]

get_second_input:

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

	; check for negation
	cmp byte [ssign], "-"
	jne get_third_number
	neg byte [num2]

get_third_number:

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

	; check for negation before comparing
	cmp byte [tsign], "-"
	jne shortcut
	neg byte [num3]

shortcut:

	; this supposed to order the numbers using less work
	; if (3 positive inputs) || (3 negative inputs): compare using the usual method
	; if (1 positive input): move the positive input to the 1st slot, then compare the two negative inputs
	; if (1 negative input): move the negative input to the last slot, then compare the two positive inputs

	cmp byte [fsign], "+"			
	je move_first_1st				

	cmp byte [ssign], "+"			
	je move_second_1st				

	cmp byte [tsign], "+"			
	je move_third_1st

move_first_1st:							

	mov al, [num1]
	cmp byte [ssign], "+"
	je move_second_2nd

	cmp byte [tsign], "+"
	je move_third_2nd

move_second_1st:

	mov al, [num2]
	jmp exit

move_third_1st:

	mov al, [num3]

	mov eax, 4
	mov ebx, 1
	mov ecx, "0"
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	jmp exit

move_second_2nd:

	mov bl, [num2]
	mov cl, [num3]

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	jmp exit

move_third_2nd:

	mov bl, [num3]
	mov cl, [num2]
	
	mov eax, 4
	mov ebx, 1
	mov ecx, tester
	mov edx, tlen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	jmp exit

print_1st_result:

	mov eax, 4
	mov ebx, 1
	mov ecx, output
	mov edx, olen
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