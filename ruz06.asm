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
	; current_factor resw 1

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
	;	addr given_num = [ebp + 4]
	;	local variables for printing = [ebp - 2], [ebp - 4]
	;	temp variable for the given_num = [ebp - 6]
	;	temp variable for the factor = [ebp - 8]
	mov ebp, esp

	sub esp, 8

	mov eax, 4
	mov ebx, 1
	mov ecx, factor_announcement
	mov edx, fa_len
		int 80h

	xor ax, ax				; clearing the registers
	xor dx, dx

	mov word[ebp - 8], 1					; possible factor = 1

	mov ebx, [ebp + 4]						; Bug #1, see end of file for details
	mov ax, [ebx]
	mov [ebp - 6], ax

	; check divisibility, but only up to 11 because pressed for time
	factor_loop:

		mov ax, [ebp - 6]
		cmp word[ebp - 8], ax
		ja end_function

		xor ax, ax					; clear registers
		xor dx, dx

		mov bx, [ebp - 8]
		div word bx

		cmp dx, 0					; if the remainder is 0 then [ebp - 8] is a factor of given_num
		je print_num
		jmp continue_factor_loop

		continue_factor_loop:

			inc word[ebp - 8]
			jmp factor_loop

	end_function:

		add esp, 8

		ret 2

print_num:

	xor ax, ax				; clear registers for printing
	xor bx, bx
	
	mov ax, [ebp - 8]
	mov bx, 10
	div word bx

	mov [ebp - 2], ax
	mov [ebp - 4], dx

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
	mov ecx, comma_and_space
	mov edx, cas_len
		int 80h

	jmp continue_factor_loop

; NOTE: the program runs properly but is buggy

; BUG LIST:

;	#1: I'm having trouble moving the value. [ebp + 4] has the address of given_num,
;		so I'm trying and failing to get at the variable of given_num and put it in [ebp - 6]
;	#2: Because of the wrong value in [ebp - 6], the print_num function prints *way* more 
;		values than expected