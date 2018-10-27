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
	tens resb 1
	ones resb 1

section .text

	global _start

_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, input_prompt
	mov edx, ip_len
		int 80h
	
	push given_num
	sub esp, 4
	call get_num

	mov ax, [given_num]
	mov bl, 10
	div byte bl
	mov [tens], al 
	mov [ones], ah

	add byte[tens], 30h
	add byte[ones], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

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

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

exit:

	mov eax, 1
	mov ebx, 0
		int 80h

get_num:

	mov ebp, esp

	mov eax, 3
	mov ebx, 0
	lea ecx, [ebp + 6]
	mov edx, 1
		int 80h

	sub word[ebp + 6], 30h

	mov eax, 3
	mov ebx, 0
	lea ecx, [ebp + 4]
	mov edx, 2
		int 80h

	sub word[ebp + 4], 30h

	mov ax, [ebp + 6]					; convert the tens digit
	mov bx, 10
	mul word bx
	add ax, [ebp + 4]					; add the value of [ebp + 4] to ax

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, factor_announcement
	mov edx, fa_len
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov ebx, [ebp + 8]
	mov [ebx], ax

	ret 8