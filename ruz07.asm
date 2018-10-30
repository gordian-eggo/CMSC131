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
	sorted_array resb 5
	current resb 1
	smallest resb 1
	tens resb 1
	ones resb 1

section .text
	
	global _start

_start:

	mov esi, 0

	get_input:

		cmp esi, 5
		je reset_esi

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

	reset_esi:

		mov esi, 0									; esi = 0 for selection sort
		mov edi, 1									; edi = 1 for iner loop of selection sort

	arrange_inputs:									; arrange inputs using selection sort

		cmp esi, 5
		je print_array

		mov al, [number_array + esi]
		mov [current], al

		mov al, [current]
		mov bl, 10
		div byte bl
		mov [tens], al
		mov [ones], ah

		add byte[tens], 30h
		add byte[ones], 30h

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

		cmp esi, 0
		je find_smallest_in_1_to_4

		cmp esi, 1
		je make_edi_2

		make_edi_2:

			mov edi, 2
			jmp find_smallest_in_2_to_4

		cmp esi, 2
		je make_edi_3

		make_edi_3:

			mov edi, 3
			jmp find_smallest_in_3_to_4

		cmp esi, 3
		je compare_4th_and_5th

		find_smallest_in_1_to_4:

			cmp edi, 4
			je leave_loop

			mov al, [number_array + edi]
			mov [smallest], al

			mov al, [current]

			cmp byte[smallest], al
			jbe switch
			jae continue_smallest_search

			switch:

				mov bl, [smallest]
				mov [smallest], al
				; mov [current], bl

				mov [number_array + esi], bl
				mov [current], bl

				mov al, [number_array + esi]
				mov [current], al

				mov al, [current]
				mov bl, 10
				div byte bl
				mov [tens], al
				mov [ones], ah

				add byte[tens], 30h
				add byte[ones], 30h

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

				inc edi
				jmp find_smallest_in_1_to_4

			continue_smallest_search:

				mov eax, 4
				mov ebx, 1
				mov ecx, first_choice
				mov edx, fc_len
					int 80h

				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				mov [tens], edi
				add byte[tens], 30h
	
				mov eax, 4
				mov ebx, 1
				mov ecx, tens
				mov edx, 1
					int 80h
	
				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				inc edi
				jmp find_smallest_in_1_to_4

		leave_loop:

			mov [tens], esi
			add byte[tens], 30h

			mov eax, 4
			mov ebx, 1
			mov ecx, tens
			mov edx, 1
				int 80h

			mov eax, 4
			mov ebx, 1
			mov ecx, newline
			mov edx, 1
				int 80h

			mov al, [current]
			mov [number_array + esi], al

			mov edi, 1
			inc esi
			jmp arrange_inputs

		; find the smallest number in the range
		; arr[2] to arr[4]

		find_smallest_in_2_to_4:

			cmp edi, 4
			je leave_loop_2

			mov al, [number_array + edi]
			mov [smallest], al

			mov al, [current]

			cmp byte[smallest], al
			jbe switch_2
			jae continue_smallest_search

			switch_2:

				mov bl, [smallest]
				mov [smallest], al
				; mov [current], bl

				mov [number_array + esi], bl
				mov [current], bl

				mov al, [number_array + esi]
				mov [current], al

				mov al, [current]
				mov bl, 10
				div byte bl
				mov [tens], al
				mov [ones], ah

				add byte[tens], 30h
				add byte[ones], 30h

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

				inc edi
				jmp find_smallest_in_2_to_4

			continue_smallest_search_2:

				mov eax, 4
				mov ebx, 1
				mov ecx, second_choice
				mov edx, sc_len
					int 80h

				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				mov [tens], edi
				add byte[tens], 30h
	
				mov eax, 4
				mov ebx, 1
				mov ecx, tens
				mov edx, 1
					int 80h
	
				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				inc edi
				jmp find_smallest_in_2_to_4

		leave_loop_2:

			mov [tens], esi
			add byte[tens], 30h

			mov eax, 4
			mov ebx, 1
			mov ecx, tens
			mov edx, 1
				int 80h

			mov eax, 4
			mov ebx, 1
			mov ecx, newline
			mov edx, 1
				int 80h

			mov al, [current]
			mov [number_array + esi], al

			mov edi, 1
			inc esi
			jmp arrange_inputs

		; find smallest in arr[3] - arr[4]

		find_smallest_in_3_to_4:

			cmp edi, 4
			je leave_loop_3

			mov al, [number_array + edi]
			mov [smallest], al

			mov al, [current]

			cmp byte[smallest], al
			jbe switch_3
			jae continue_smallest_search

			switch_3:

				mov bl, [smallest]
				mov [smallest], al
				; mov [current], bl

				mov [number_array + esi], bl
				mov [current], bl

				mov al, [number_array + esi]
				mov [current], al

				mov al, [current]
				mov bl, 10
				div byte bl
				mov [tens], al
				mov [ones], ah

				add byte[tens], 30h
				add byte[ones], 30h

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

				inc edi
				jmp find_smallest_in_3_to_4

			continue_smallest_search_3:

				mov eax, 4
				mov ebx, 1
				mov ecx, first_choice
				mov edx, fc_len
					int 80h

				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				mov [tens], edi
				add byte[tens], 30h

				mov eax, 4
				mov ebx, 1
				mov ecx, tens
				mov edx, 1
					int 80h

				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				inc edi
				jmp find_smallest_in_3_to_4

		leave_loop_3:

			mov [tens], esi
			add byte[tens], 30h

			mov eax, 4
			mov ebx, 1
			mov ecx, tens
			mov edx, 1
				int 80h

			mov eax, 4
			mov ebx, 1
			mov ecx, newline
			mov edx, 1
				int 80h

			mov al, [current]
			mov [number_array + esi], al

			mov edi, 1
			inc esi
			jmp arrange_inputs

		compare_4th_and_5th:

			mov al, [number_array + 3]
			mov bl, [number_array + 4]

			cmp al, bl
			jae swap
			jbe finish_loop

			swap:

				mov [number_array + 3], bl
				mov [number_array + 4], al

				mov al, [number_array + 3]
				mov [current], al

				mov al, [current]
				mov bl, 10
				div byte bl
				mov [tens], al
				mov [ones], ah

				add byte[tens], 30h
				add byte[ones], 30h

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

				mov al, [number_array + 4]
				mov [current], al

				mov al, [current]
				mov bl, 10
				div byte bl
				mov [tens], al
				mov [ones], ah

				add byte[tens], 30h
				add byte[ones], 30h

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

				jmp finish_loop

			finish_loop:

				mov [tens], esi
				add byte[tens], 30h

				mov eax, 4
				mov ebx, 1
				mov ecx, tens
				mov edx, 1
					int 80h

				mov eax, 4
				mov ebx, 1
				mov ecx, newline
				mov edx, 1
					int 80h

				inc esi
				jmp arrange_inputs

exit: 

	mov eax, 1
	mov ebx, 0
		int 80h

print_array:

	mov esi, 0

	print_loop:

		cmp esi, 5
		je exit

		mov al, [number_array + esi]
		mov bl, 10
		div byte bl

		mov [tens], al
		mov [ones], ah

		add byte[tens], 30h
		add byte[ones], 30h

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

		inc esi
		jmp print_loop