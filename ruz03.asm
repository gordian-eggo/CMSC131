; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 03: Sort three 2-digit number inputs in descending order.

section .data

	prompt db "Enter signed number: "
	plen equ $-prompt
	output db "Inputs sorted in descending order: "
	olen equ $-output
<<<<<<< HEAD
	comma db ", "
	clen equ $-comma
=======
	tester db "hi"
	tlen equ $-tester
>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3
	newline db 10

section .bss

	fsign resb 1
	ftens resb 1
	fones resb 1
	num1 resb 1
	ssign resb 1
	stens resb 1
	sones resb 1
	num2 resb 1
	tsign resb 1
	ttens resb 1
	tones resb 1
	num3 resb 1
<<<<<<< HEAD
	temp resb 1
=======
	g_sign resb 1
	greatest resb 1
	m_sign resb 1
	middle resb 1
	l_sign resb 1
	least resb 1
>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3

section .text

	global _start

_start:
<<<<<<< HEAD
=======

	mov eax, 4
	mov ebx, 1
	mov ebx, tester
	mov edx, tlen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ebx, newline
	mov edx, 1
		int 80h
>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3
	
	; get first number
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, fsign
	mov edx, 1
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, ftens
	mov edx, 1
		int 80h

	sub byte [ftens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, fones
	mov edx, 2
		int 80h

	sub byte [fones], 30h

	; convert to integer
	mov al, [ftens]
	mov bl, 10
	mul byte bl
	add byte al, [fones]
	mov [num1], al

	; check for negation
	cmp byte [fsign], "-"
	jne get_second_input
	neg byte [num1]

get_second_input:

	; get second number
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, ssign
	mov edx, 1
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, stens
	mov edx, 1
		int 80h

	sub byte [stens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, sones
	mov edx, 2
		int 80h

	sub byte [sones], 30h

	; convert to integer
	mov al, [stens]
	mov bl, 10
	mul byte bl
	add byte al, [sones]
	mov [num2], al

	; check for negation
	cmp byte [ssign], "-"
	jne get_third_number
	neg byte [num2]

get_third_number:

<<<<<<< HEAD
=======
	mov eax, 4
	mov ebx, 1
	mov ebx, tester
	mov edx, tlen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ebx, newline
	mov edx, 1
		int 80h

>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3
	; get third number
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, tsign
	mov edx, 1
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, ttens
	mov edx, 1
		int 80h

	sub byte [ttens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, tones
	mov edx, 2
		int 80h

	sub byte [tones], 30h

	; convert to integer
	mov al, [ttens]
	mov bl, 10
	mul byte bl
	add byte al, [tones]
	mov [num3], al

	; check for negation before comparing
	cmp byte [tsign], "+"
	je organize
<<<<<<< HEAD
	neg byte [num3]

organize:

	mov cl, [num1]						; compare num1 and num2
	cmp cl, [num2]
	jle swap_1and2						; if num1 > num2, swap
	jmp comswap_2and3

	loop organize

check_order:

	mov al, [num1]						; if num1 > num2, jump to is_true
	cmp al, [num2]
	jge is_true 
	jmp organize

comswap_2and3:							; compare and swap num2 and num3

	mov cl, [num2]						; if num2 > num3, swap
	cmp cl, [num3]
	jle swap_2and3
	jmp check_order

is_true:

	mov al, [num2]						; if num2 > num3, print organized results
	cmp al, [num3]						; logic here is num1 > num2 and num2 > num3, then num1 > num2 > num3
	jge ready_for_printing				; para di na ulit kailangan mag compare kasi yun din naman yun
	jmp organize


swap_2and3:

	mov al, [num2]						; swap num2 and num3
	mov bl, [num3]
	xchg al, bl							; xchg automatically replaces the values in the al and bl registers
	mov [num2], al 						; yung isang taon na binigay ko para magcode binalik ng xchg sakin
	mov [num3], bl

	mov al, [ssign]
	mov bl, [tsign]
	xchg al, bl
	mov [ssign], al
	mov [tsign], bl

	jmp organize

swap_1and2:

	mov al, [num1]						; swap num1 and num2
	mov bl, [num2]
	xchg al, bl
	mov [num1], al
	mov [num2], bl

	mov al, [fsign]
	mov bl, [ssign]
	xchg al, bl
	mov [fsign], al
	mov [ssign], bl

	jmp organize

neg_num1:								; neg_num labels are for converting the inputs back to positive integers
										; for printing later
	neg byte [num1]
	jmp ready_for_printing

neg_num2:

	neg byte [num2]
	jmp ready_for_printing

neg_num3:

	neg byte [num3]
	jmp ready_for_printing

ready_for_printing:							; get the inputs ready for printing

	mov al, [num1]							; if the input is negative, run it through the respective neg_num label
	cmp al, 0								; if the input is positive, convert it to characters
	jle neg_num1

	mov al, [num1]
	mov bl, 10
	div byte bl
	mov [ftens], al
	mov [fones], ah

	add byte [ftens], 30h
	add byte [fones], 30h

	mov al, 0
	mov ah, 0

	mov al, [num2]
	cmp al, 0
	jle neg_num2

	mov al, [num2]
	mov bl, 10
	div byte bl
	mov [stens], al
	mov [sones], ah

	add byte [stens], 30h
	add byte [sones], 30h

	mov al, 0
	mov ah, 0

	mov al, [num3]
	cmp al, 0
	jle neg_num3

	mov al, [num3]
	mov bl, 10
	div byte bl
	mov [ttens], al
	mov [tones], ah

	add byte [ttens], 30h
	add byte [tones], 30h

	mov al, 0
	mov ah, 0

	jmp print_organized_results

print_organized_results:

	mov eax, 4
	mov ebx, 1
	mov ecx, output
	mov edx, olen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, fsign
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ftens
	mov edx, 1
=======
	jne negate_num3

negate_num3:

	mov eax, 4
	mov ebx, 1
	mov ebx, tester
	mov edx, tlen
>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3
		int 80h

	mov eax, 4
	mov ebx, 1
<<<<<<< HEAD
	mov ecx, fones
	mov edx, 1
		int 80h	

	mov eax, 4
	mov ebx, 1
	mov ecx, comma
	mov edx, clen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ssign
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, stens
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, sones
	mov edx, 1
		int 80h	

	mov eax, 4
	mov ebx, 1
	mov ecx, comma
	mov edx, clen
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, tsign
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ttens
	mov edx, 1
=======
	mov ebx, newline
	mov edx, 1
		int 80h

	neg byte [num3]

organize:

	mov eax, 4
	mov ebx, 1
	mov ebx, tester
	mov edx, tlen
>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3
		int 80h

	mov eax, 4
	mov ebx, 1
<<<<<<< HEAD
	mov ecx, tones
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h	
=======
	mov ebx, newline
	mov edx, 1
		int 80h
;
;	mov al, [num1]					; compare num1 and num2
;	cmp al, [num2]
;	jge move_num1_greatest			; if num1 > num2, move num1 into greatest
;	jle move_num2_greatest
;
;	mov al, [greatest]
;	cmp al, [num3]
;	jle move_num3_greatest
;
;move_num1_greatest:
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, tester
;	mov edx, tlen
;		int 80h
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, newline
;	mov edx, 1
;		int 80h
;
;	mov [greatest], al 				; num1 in greatest
;	mov al, [fsign]					; move num1's sign to g_sign
;	mov [g_sign], al
;
;	mov al, [num2]					; compare num2 and num3
;	cmp al, [num3]
;	jge arrange_num2_num3
;
;move_num2_greatest:
	;
;	mov [num1], al 					; if num1 < num2, mov num2 into greatest
;	mov al, [num2]
;	mov [greatest], al
;
;move_num3_greatest:
;
;	mov al, [greatest] 				; num3 now in greatest
;	mov [num2], al 
;
;	mov al, [num3]
;	mov [greatest], al
;
;arrange_num2_num3:
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, tester
;	mov edx, tlen
;		int 80h
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, newline
;	mov edx, 1
;		int 80h
;
;	mov [middle], al 				; move num2 to middle
;	mov al, [ssign] 				; move ssign to m_sign
;	mov [m_sign], al
;
;	mov al, [num3]					; move num3 to least and tsign to l_sign
;	mov [least], al
;	mov al, [tsign]
;	mov [l_sign], al
;
;print_organized_results:
;
;	; ready greatest for printing
;	mov al, [greatest]
;	mov bl, 10
;	div byte bl
;	mov [ftens], al
;	mov [fones], ah
;
;	add byte [ftens], 30h
;	add byte [fones], 30h
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, g_sign
;	mov edx, 1
;		int 80h
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, ftens
;	mov edx, 1
;		int 80h
;
;	mov eax, 4
;	mov ebx, 1
;	mov ebx, fones
;	mov edx, 1
;		int 80h	
>>>>>>> 82eac84823891e59f5fe661694a189c71dd5a2f3
	
exit:

	mov eax, 1
	mov ebx, 0
		int 80h