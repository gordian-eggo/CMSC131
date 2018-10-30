; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Program description: Take a 2-digit input from the user and print its factors.
;					   Use pass by reference.
; Required subroutines: get_num(&n)
;						get_factors(&n)
;						print_num(&num)

section .data

	input_prompt db "Enter a 2-digit number: "
	ip_len equ $-input_prompt
	factor_announcement db "Factors: "
	fa_len equ $-factor_announcement
	comma_and_space db ", "
	cas_len equ $-comma_and_space
	newline db 10

section .bss

	given_num resw 1
	current_factor resw 1

section .text

	global _start

_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, input_prompt
	mov edx, ip_len
		int 80h
	
	push given_num					; get the number from the user
	call get_num

	mov ax, [given_num]
	mov bx, 10
	div word bx
	mov [given_num], ax
	mov [current_factor], dx

	add word[given_num], 30h
	add word[current_factor], 30h

	; mov eax, 4
	; mov ebx, 1
	; mov ecx, given_num
	; mov edx, 1
	; 	int 80h

	; mov eax, 4
	; mov ebx, 1
	; mov ecx, current_factor
	; mov edx, 1
	; 	int 80h

	; mov eax, 4
	; mov ebx, 1
	; mov ecx, newline
	; mov edx, 1
	; 	int 80h

	push current_factor
	push given_num
	call get_factors


exit:

	mov eax, 1
	mov ebx, 0
		int 80h

get_num:

	mov ebp, esp

	sub esp, 4

	mov eax, 3							; get tens
	mov ebx, 0
	lea ecx, [ebp - 2]
	mov edx, 1
		int 80h

	sub word[ebp - 2], 30h

	mov eax, 3							; get ones
	mov ebx, 0
	lea ecx, [ebp - 4]
	mov edx, 2
		int 80h

	sub word[ebp - 4], 30h

	mov ax, [ebp - 2]					; convert the tens digit
	mov bx, 10
	mul word bx
	add ax, [ebp - 4]					; add the value of [ebp + 4] to ax

	mov ebx, [ebp + 4]
	mov [ebx], ax

	add esp, 4

	ret 4

get_factors:

	; STACK LOCATIONS:
	;	given_num = [ebp + 6]
	;	current_factor = [ebp + 4]
	;	*local variables for printing = [ebp - 2], [ebp - 4]

	; * these are test variables
	mov ebp, esp

	sub esp, 4

	mov eax, 4
	mov ebx, 1
	mov ecx, factor_announcement
	mov edx, fa_len
		int 80h

	xor ax, ax
	xor dx, dx

	mov word[ebp + 4], 1

	; here I'll loop through the number and if the
	; value in [ebp - 2] is a factor, that's when
	; we call print_num
	factor_loop:

		mov ax, [ebp + 6]
		cmp word[ebp + 4], ax
		je exit

	; 	mov ah, 0
	; 	mov al, 0

	; 	mov ax, [ebp + 6]
		mov bx, [ebp + 4]
		div word bx

		cmp dx, 0
		jne exit

		inc word[ebp + 4]
		jmp factor_loop

	add esp, 4
	ret 4

; print_num:

; 	mov eax, 4
; 	mov ebx, 1
; 	mov ecx, comma_and_space
; 	mov edx, cas_len
; 		int 80h

	; jmp factor_loop

	; mov ax, [ebp + 4]
	; mov bx, 10
	; div word bx

	; mov word[ebp - 2], ax		; tens
	; mov word[ebp - 4], dx       ; ones

	; add word[ebp - 2], 30h
	; add word[ebp - 4], 30h

	; mov eax, 4
	; mov ebx, 1
	; lea ecx, [ebp - 2]
	; mov edx, 1
	; 	int 80h

	; mov eax, 4
	; mov ebx, 1
	; lea ecx, [ebp - 4]
	; mov edx, 1
	; 	int 80h

	; jmp print_comma
	; jmp factor_loop

; print_comma:

; 	mov eax, 4
; 	mov ebx, 1
; 	mov ecx, comma_and_space
; 	mov edx, cas_len
; 		int 80h

; 	inc word[ebp + 4]
; 	jmp factor_loop