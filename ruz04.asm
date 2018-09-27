section .data
	n_input db "Enter value for N: "
	nlen equ $-n_input
	m_input db "Enter value for M: "
	mlen equ $-m_input
	f_out db "Numbers from 1 to "
	flen equ $-f_out
	div_by db " divisible by "
	dblen equ $-div_by
	colon db ": "
	clen equ $-colon
	test_text db "hi"
	tlen equ $-test_text
	newline db 10

section .bss

	n_ten resb 1
	n_one resb 1
	n_val resb 1
	m_ten resb 1
	m_one resb 1
	m_val resb 1
	print_n resb 1
	print_m resb 1
	d_ten resb 1
	d_one resb 1
	divisible resb 1
	temp resb 1

section .text

	global _start

_start:

	; get the N and M inputs then convert to integers

	mov eax, 4
	mov ebx, 1
	mov ecx, n_input
	mov edx, nlen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, n_ten
	mov edx, 1
		int 80h

	sub byte [n_ten], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, n_one
	mov edx, 2
		int 80h

	sub byte [n_one], 30h

	mov al, [n_ten]
	mov bl, 10
	mul byte bl
	add byte al, [n_one]
	mov [n_val], al

	mov eax, 4
	mov ebx, 1
	mov ecx, m_input
	mov edx, mlen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, m_ten
	mov edx, 1
		int 80h

	sub byte [m_ten], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, m_one
	mov edx, 2
		int 80h

	sub byte [m_one], 30h

	mov al, [m_ten]
	mov bl, 10
	mul byte bl
	add byte al, [m_one]
	mov [m_val], al

	mov al, [n_val]							; copy values int print_n and print_m for printing in the 
	mov [print_n], al 						; output sentence

	mov al, [m_val]
	mov [print_m], al
	mov byte[temp], 0
	mov ecx, 0

	mov ecx, 3

	; print the output sentence

find_and_print_divisible:

	mov [temp], ecx

	mov eax, 4
	mov ebx, 1
	mov ecx, test_text
	mov edx, tlen
		int 80h

	mov ecx, [temp]
	dec ecx
;	cmp ecx, 0
;	je test_print
	loop find_and_print_divisible

; test print values

test_print:

	mov al, [n_val]
	mov bl, 10
	div byte bl
	mov [n_ten], al
	mov [n_one], ah

	add byte[n_ten], 30h
	add byte[n_one], 30h

	mov al, 0
	mov ah, 0

	mov al, [m_val]
	mov bl, 10
	div byte bl
	mov [m_ten], al
	mov [m_one], ah

	add byte[m_ten], 30h
	add byte[m_one], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, n_ten
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, n_one
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, m_ten
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, m_one
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