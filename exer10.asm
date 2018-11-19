; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Program description: This program uses recursion to convert decimal numbers into 
;					   binary numbers.

section .data
	newline db 10
	prompt_msg db "Enter a three-digit number: "
	pm_len equ $-prompt_msg

section .bss

	hundreds resb 1
	tens resb 1
	ones resb 1
	decim_num resw 1

section .text

	global _start

_start:
	
	; get the user input

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt_msg
	mov edx, pm_len	
		int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, hundreds
	mov edx, 1
		int 80h

	sub byte[hundreds], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, tens
	mov edx, 1
		int 80h

	sub byte[tens], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, ones
	mov edx, 2
    	int 80h

	sub byte[ones], 30h

	mov al, [hundreds]
	mov bl, 100
	mul byte bl
	mov byte[hundreds], al

	xor ax, ax

	mov al, [tens]
	mov bl, 10
	mul byte bl
	mov byte[tens], al

    xor ax, ax

	mov al, [hundreds]
	mov byte[decim_num], al
	mov bl, [tens]
	add byte[decim_num], bl
	mov cl, [ones]
	add byte[decim_num], cl

	sub esp, 2					; allocate bytes for the return value
	push word[decim_num]
	call binarize

exit:

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 1
	mov ebx, 0
		int 80h

binarize:

	mov ebp, esp

	cmp word[ebp + 4], 1
	jg recall_binarize

	base_case:

		cmp word[ebp + 4], 0
		je if_zero

		cmp word[ebp + 4], 1
		je if_one

		if_zero:

			mov word[ebp + 6], 0
			add word[ebp + 6], 30h

			mov eax, 4
			mov ebx, 1
			lea ecx, [ebp + 6]
			mov edx, 1
				int 80h

			jmp leave

		if_one:

			mov word[ebp + 6], 1
			add word[ebp + 6], 30h

			mov eax, 4
			mov ebx, 1
			lea ecx, [ebp + 6]
			mov edx, 1
				int 80h

			jmp leave

	recall_binarize:

		sub esp, 2

		mov ax, [ebp + 4]
		mov bl, 2
		div byte bl
		; mov word[ebp + 6], ax
		; push ax
		mov byte[ones], ah		; move ah into ones variable
		mov dx, [ones]			; move the values in ones into dx then move into ebp + 6
		mov word[ebp + 6], dx

		; mov byte[tens], al
		; mov ax, [tens]
		; push ax
		call binarize

		pop ax
		mov ebp, esp			; readjust location of base pointer
		add word[ebp + 6], 30h

		mov eax, 4
		mov ebx, 1
		lea ecx, [ebp + 6]
		mov edx, 1
			int 80h

	leave: 

		ret 2
