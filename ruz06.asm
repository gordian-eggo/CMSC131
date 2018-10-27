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
	
	push given_num
	call get_num

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