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

section .bss

	given_num resw 1
	current_factor resw 1

section .text

	global _start

_start:


exit:

	mov eax, 1
	mov ebx, 0
		int 80h