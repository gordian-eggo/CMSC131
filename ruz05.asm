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
	n_val resw 1

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

	call checking_process

exit:

	mov eax, 1
	mov ebx, 0
		int 80h

checking_process:							; where the program will check for prime numbers

	mov ebp, esp
	sub esp, 8								; reserve space for 4 variables (explained later)

; i (located at [ebp - 2]) = counter, stops when i == n_val
; divisor (located at [ebp - 4]) = also goes from 2 to n_val, for dividing
;	> kasi prime numbers are considered prime if they are not divisible by anything other than 1 or itself,
;     so if it's divisible by any number that isn't equal to itself, it's prime. Save time checking for prime.
; factor_count (located at [ebp - 6]) = if the value of this is more than 2
; 				 						the number is not prime and won't be printed
; temp (located at [ebp - 8]) = basta gagamitin ko to for something

	mov [ebp - 2], 1						; set value of i to 1	
	mov [ebp - 4], 2						; set value of divisor to 2		
	mov [ebp - 6], 0						; set factor_count to 0
	mov [ebp - 8], 0						; set temp to 0 para sure na wala siyang laman

	call check_if_prime

check_if_prime:

	mov ax, [ebp - 2]
	mov bx, [ebp + 4]
	cmp ax, bx
	je exit
	
	mov ax, [ebp - 2]						; divide
	mov bx, [ebp - 4]
	div word bx

	cmp dx, 0
	je add_a_factor							; if remainder is 0, increment factor_count

	inc word[ebp - 2]						; increment i and divisor
	inc word[ebp - 4]

	mov ax, [ebp - 6]
	cmp ax, 2
	jne check_if_prime
	
	mov [ebp + 6], 1						; returns 1 if the number is prime


add_a_factor:

	add word[ebp - 6], 1

	inc word[ebp - 2]						; increment i and divisor
	inc word[ebp - 4]
	jmp check_if_prime

print_number:

	mov ax, [ebp + 6]
	cmp ax, 1
	jne check_if_prime

	mov ax, [ebp - ]