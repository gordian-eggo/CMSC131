; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Program description: Create a program that can get the maximum, minimum
;					   or median of 5 unsigned 2-digit values. 

section .data

	input_prompt db "Enter a 2-digit number: "
	inp_len equ $-input_prompt

	menu_bar db "======= MENU ======="
	mb_len equ $-menu_bar
	first_choice db "[1] Maximum"
	fc_len equ $-first_choice
	second_choice db "[2] Minimum"
	sc_len equ $-second_choice
	third_choice db "[3] Median"
	tc_len equ $-third_choice
	exit_choice db "[4] Exit"
	ec_len equ $-exit_choice
	choice_prompt db "Choice: "
	cp_len equ $-choice_prompt

	max_output db "Maximum is "
	maxo_len equ $-max_output
	min_output db "Minimum is "
	mino_len equ $-min_output
	med_output db "Median is "
	medo_len equ $-med_output

	newline db 10

section .bss

	number_array resb 5
	tens resb 1
	ones resb 1

section .text
	
	global _start

_start:

	mov esi, 0

	get_input:

		cmp esi, 5
		je arrange_inputs

		mov eax, 4							; prompt user for a number
		mov ebx, 1							; then convert the tens and ones digits
		mov ecx, input_prompt
		mov edx, inp_len
			int 80h

		mov eax, 3						
		mov ebx, 0
		mov ecx, tens
		mov edx, 1
			int 80h

		mov eax, 3
		mov ebx, 0
		mov ecx, ones
		mov edx, 2
			int 80h

		sub byte[tens], 30h
		sub byte[ones], 30h

		mov al, [tens]
		mov bl, 10
		mul byte bl
		add al, [ones]

		mov [number_array + esi], al

		inc esi
		jmp get_input

	arrange_inputs:

		
		

exit:

	mov eax, 1
	mov ebx, 0
		int 80h