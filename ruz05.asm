; RUZ, Julianne Marie
; 2014-04280
; CMSC 131 AB-2L
; Exer 05: Print prime numbers from 1 to N where N is a two-digit number.
;		   Global variables may not be used inside the stack.	

section .data

	prompt db "Enter a number: "
	plen equ $-prompt
	result db "Prime numbers: "
	rlen equ $-result
	space db " space "
	slen equ $-space
	test db "here"
	tlen equ $-test
	newline db 10

section .bss
	tens resw 1
	ones resw 1
	num resw 1
	factors resw 1
	counter resw 1

section .text

	global _start

_start: 

	push tens			;	[ebp + 12] on the stack
	push ones			;	[ebp + 10] on the stack
	push num 			; 	[ebp + 8] on the stack
	push factors 		;	[ebp + 6] on the stack
	push counter 		;	[ebp + 4] on the stack
	call get_num

exit:

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	mov eax, 1
	mov ebx, 0
		int 80h

get_num:

	mov ebp, esp			; put PC on the stack

	mov [ebp + 4], 0			; initializes counter and factors as 0 for later
	mov [ebp + 6], 0			

	
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, plen
		int 80h

	mov eax, 3					; get first digit
	mov ebx, 0
	lea ecx, [ebp + 12]
	mov edx, 1
		int 80h

	sub word[ebp + 12], 30h

	mov ah, 0					; convert the tens digit right away
	mov ax, [ebp + 12]
	mov bx, 12
	mul word bx
	mov [ebp + 8], ax			; move to [ebp + 8]

	mov eax, 3					; get second digit
	mov ebx, 0
	lea ecx, [ebp + 10]
	mov edx, 2
		int 80h

	sub word[ebp + 10], 30h

	mov ah, 0
	mov ax, [ebp + 10]
	add word[ebp + 8], ax		; add ones digit to tens digit. now num at [ebp + 8] = input
	mov ax, [ebp + 8]			; move the value of [ebp + 8] to ax for comparison

	jmp print_primes

print_primes:

check_if_prime:

	sub esp, 4				; to store the possible prime number
	mov [ebp - 2], 1			; sets the prime value as 1 for later
	jmp print_test

	find_factors:

		cmp word[ebp - 2], ax		; compare the number being tested to the value in ax
		je exit						; if equal, exit
		mov [ebp - 4], ax			; move the value in ax here so we can use it for dividing
		inc word[ebp + 4]			; increment the counter

		mov ah, 0
		mov ax, [ebp + 4]			; check if [ebp + 4] is divisible by the value in ax
		div word[ebp - 2], ax
		cmp dx, 0
		je inc_factor

		; inc word[ebp - 2]
		jmp find_factors

			inc_factor:				; increment factor ([ebp + 6] on the stack)


				inc word[ebp + 6]
				cmp word[ebp + 6], 3
				jge inc_prime_check		; if the number has 3 or more factors, increment the number you're prime-checking

				mov bx, word[ebp + 4]
				cmp word[ebp - 2], bx
				je inc_checker
				

				jmp reset

					inc_checker:

						inc word[ebp - 2]		; increment the prime-checker then jmp back to the loop
						jmp find_factors


					reset:

						mov word[ebp + 4], 0		; reset counter and factors to 0		
						mov word[ebp + 6], 0
						mov ax, word[ebp - 4]
						mov bx, 0
						inc word[ebp - 2]
						jmp find_factors

print_test:

	mov eax, 4
	mov ebx, 1
	mov ecx, test
	mov edx, tlen
		int 80h

	jmp find_factors