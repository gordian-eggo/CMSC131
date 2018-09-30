; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exercise 04: Take two 2-digit inputs N and M and output all numbers from 1 to N
;			   that are divisible by M

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
	space_char db " "
	sclen equ $-space_char
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
	iterator resb 1
	remainder resb 1
	d_ten resb 1
	d_one resb 1
	temp resb 1
	divisible resb 1

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
	mov byte[n_val], al

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
	mov byte[m_val], al

	mov eax, 4
	mov ebx, 1
	mov ecx, f_out
	mov edx, flen
		int 80h

	add byte[n_ten], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, n_ten
	mov edx, 1
		int 80h

	sub byte[n_ten], 30h
	add byte[n_one], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, n_one
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, div_by
	mov edx, dblen
		int 80h

	sub byte[n_one], 30h
	add byte[m_ten], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, m_ten
	mov edx, 1
		int 80h

	sub byte[m_ten], 30h
	add byte[m_one], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, m_one
	mov edx, 1
		int 80h

	sub byte[m_one], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, colon
	mov edx, clen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov byte[iterator], 0
	mov byte[divisible], 1						; go through N numbers starting from 1
	mov byte[temp], 1							; temp is for printing the value because nagaalburuto 
												; yung printed values if you use the divisible variable 
												; to print them with

find_and_print_divisible:						; find and print the numbers that are divisible by M

	mov al, [divisible]
	mov bl, [m_val]
	div byte bl

	mov [remainder], ah
	
	cmp ah, 0
	je print_number

	mov al, 0									; moved 0 into ah and al registers para
	mov ah, 0									; hindi magkaproblema with printing unwanted variables

	inc byte[iterator]							; increment iterator, divisible, and temp
	inc byte[divisible]
	inc byte[temp]

	mov al, [iterator]							; if iterator == n_val:
	cmp al, [n_val]								;	exit program
	je exit										; else: loop back through the find_and_print_divisible label
	jmp find_and_print_divisible

exit:

	mov eax, 4									; print the newline here para mas maayos
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 1
	mov ebx, 0
		int 80h

print_number:

	mov al, [temp]								; print the divisible number
	mov bl, 10
	div byte bl
	mov [d_ten], al
	mov [d_one], ah

	add byte[d_ten], 30h
	add byte[d_one], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, d_ten
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, d_one
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, space_char
	mov edx, 1
		int 80h

	inc byte[iterator]							; increment iterator, divisible, and temp
	inc byte[divisible]
	inc byte[temp]

	mov al, [n_val]								; check if iterator == n_val here too
	cmp byte[iterator], al
	jne find_and_print_divisible
	jmp exit

; BUGS:
;   > medyo pangit siyang magprint kasi di ko na keri pagandahin yung print na di masisira yung program and gusto ko na magmove on