; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 05: Print prime numbers from 1 to N where N is a two-digit number.
;		   Global variables may not be used inside labels accessing the stack.	

section .data

	prompt db "Enter a number: "
	plen equ $-prompt
	result db "Prime numbers: "
	rlen equ $-result

section .bss

	n_ten resb 1
	n_one resb 1
	n_val resb 1

section .text

	global _start

_start: 

	sub esp, 2											; reserve 2 bytes on the stack for check_if_prime

	; get the user input and move the value into n_val
	
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
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

	push word[n_val]

exit:

	mov eax, 1
	mov ebx, 0
		int 80h

check_if_prime:											; returns 1 if prime, 0 if otherwise

	mov ebp, esp
	sub esp, 6											; reserve space for 3 variables (explained later)

	



; i = counter, stops when i == n_val
; divisor = also goes from 1 to n_val, for dividing
; factor_count = if the value of this is more than 2
; 				 the number is not prime and won't be printed

;print_number: