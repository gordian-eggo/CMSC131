; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Program description: LIYAB program that takes two names and outputs a 
;					   result based on the number of matching characters.

section .data

	first_person db "Pangalan ni ano: "
	fp_len equ $-first_person
	second_person db "Pangalan ni kwan: "
	sp_len equ $-second_person

	result_pt1 db "Ang liyab sa pagitan ni "
	rpt1_len equ $-result_pt1
	and_result db " at "
	ar_len equ $-and_result
	ay_result db " ay "
	ay_len equ $-ay_result

	landian db "L- Landian lamang."
	lan_len equ $-landian
	imposible db "I - Imposibleng mangyari."
	impo_len equ $-imposible
	yumao db "Y- Yumao na."
	yum_len equ $-yumao
	abot db "A - Abot-kamay."
	abot_len equ $-abot
	barkadahan db "B - Barkadahan lamang."
	bar_len equ $-barkadahan

	i db 0
	newline db 10

section .bss

	name_ni_ano resb 20
	pangalan_ni_kwan resb 20
	nna_len resb 1
	pnk_len resb 1
	total_length resb 1
	matching_letter_count resb 1
	char resb 1								
	tens resb 1
	ones resb 1

section .text

	global _start

_start:

	mov eax, 4								; prompt user for the first name, repeat to prompt user for the second name
	mov ebx, 1
	mov ecx, first_person
	mov edx, fp_len
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, name_ni_ano
	mov edx, 21
		int 80h

	dec eax									; removes the newline
	mov [nna_len], al

	; mov eax, 4								
	; mov ebx, 1
	; mov ecx, name_ni_ano
	; mov edx, 0
	; mov dl, byte[nna_len]
	; 	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, second_person
	mov edx, sp_len
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, pangalan_ni_kwan
	mov edx, 21
		int 80h	

	dec eax
	mov [pnk_len], al

	mov al, [nna_len]						; get the total number of characters in the people's names
	mov [total_length], al
	mov al, [pnk_len]
	add byte[total_length], al

	mov esi, 0
	mov byte[matching_letter_count], 0

	find_matching_characters:

		cmp esi, [pnk_len]
		je exit

		mov edi, pangalan_ni_kwan			; move the first person's name to edi
		mov al, [name_ni_ano + esi]
		mov ecx, pnk_len

		; repne scasb
		; je iterate_ml_count
		; jne continue_loop

		iterate_ml_count:

			; mov al, [matching_letter_count]
			; inc al
			; mov byte[matching_letter_count], al

			; add byte[matching_letter_count], 1

			jmp continue_loop

		continue_loop:

			inc esi
			jmp find_matching_characters

exit:

	mov eax, 1
	mov ebx, 0
		int 80h

; NOTE: program runs but is buggy
; BUG LIST:

;	#1: program encounters a segfault when scanning the string
;		for the character stored in al, not sure why

;	#2: program also encounters a segfault when incrementing
;		the variable matching_letter_count, don't know why