section .data
	prompt db "Enter a 3-digit number: "
	prompt_len equ $-prompt
	show_ave db "Average: "
	sa_len equ $-show_ave
	show_rem db " rem "
	sr_len equ $-show_rem
	newline db 10

section .bss
	f_huns resb 1
	f_tens resb 1
	f_ones resb 1
	num1 resw 1
	s_huns resb 1
	s_tens resb 1
	s_ones resb 1
	num2 resw 1
	ave_huns resb 1
	ave_tens resb 1
	ave_ones resb 1
	quotient resb 1
	rem_huns resb 1
	rem_tens resb 1
	rem_ones resb 1
	remainder resb 1
	test_value resb 1

section .text
	global _start

_start:
	
	; prompt user for first 3-digit number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
		int 80h

	; get first num 
	
	mov eax, 3 
	mov ebx, 0 
	mov ecx, f_huns
	mov edx, 1
		int 80h

	sub byte [f_huns], 30h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, f_tens
	mov edx, 1
		int 80h

	sub byte [f_tens], 30h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, f_ones
	mov edx, 2
		int 80h

	sub byte [f_ones], 30h
	
	; prompt user for second 3-digit number

	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, prompt_len
	int 80h
	
	; get second num 
	
	mov eax, 3 
	mov ebx, 0 
	mov ecx, s_huns
	mov edx, 1
		int 80h
	
	sub byte [s_huns], 30h

	mov eax, 3
	mov ebx, 0
	mov ecx, s_tens
	mov edx, 1
		int 80h

	sub byte [s_tens], 30h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, s_ones
	mov edx, 2
		int 80h
    
    sub byte [s_ones], 30h
    
    ; convert num1 entries to integer
 
    mov al, [f_huns]
    mov bl, 100
    mul byte bl 
    mov [num1], ax
   
    mov al, [f_tens]
    mov bl, 10
    mul byte bl
    
    add byte[num1], al
    mov al, [f_ones]
    add byte[num1], al 
    
    ; convert num2 entries to integer
    mov al, [s_huns]
    mov bl, 100
    mul byte bl 
    mov word[num2], ax
    
    mov al, [s_tens]
    mov bl, 10
    mul byte bl
    
    add byte[num2], al
    mov al, [s_ones]
    add byte[num2], al 
    
    ; add both numbers
    mov ax, [num2]
    add [num1], ax
    
    ; divide by 2 to get average
    mov ax, [num1]
    mov bl, 2
    div byte bl
    
    mov [quotient], al
    mov [remainder], ah
    
    ; convert quotient to characters
    ; and move to the average number's digit variables

    mov ah, 0							; makes sure that the value in ah is 0 before dividing

    mov al, [quotient]
    mov bl, 100
    div byte bl
    
    mov [ave_huns], al
    mov [ave_tens], ah
    
    mov ah, 0
    mov al, [ave_tens]
    mov bl, 10
    div byte bl
    
    mov [ave_tens], al
    mov [ave_ones], ah
    
    add byte[ave_huns], 30h
    add byte[ave_tens], 30h
    add byte[ave_ones], 30h

    ; do the same thing for the remainder

    mov ah, 0						; makes sure that the value in ah is 0 before dividing

    mov al, [remainder]
    mov bl, 100
    div byte bl
    
    mov [rem_huns], al
    mov [rem_tens], ah
    
    mov ah, 0
    mov al, [rem_tens]
    mov bl, 10
    div byte bl
    
    mov [rem_tens], al
    mov [rem_ones], ah
    
    add byte[rem_huns], 30h
    add byte[rem_tens], 30h
    add byte[rem_ones], 30h
    
    ; print the results

    mov eax, 4
    mov ebx, 1
    mov ecx, show_ave
    mov edx, sa_len
    	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ave_huns
	mov edx, 1
		int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, ave_tens
	mov edx, 1
		int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, ave_ones
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, show_rem
	mov edx, sr_len
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, rem_huns
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, rem_tens
	mov edx, 1
		int 80h		

	mov eax, 4
	mov ebx, 1
	mov ecx, rem_ones
	mov edx, 1
		int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
		int 80h

	; terminate

	mov eax, 1
	mov ebx, 0
		int 80h

; ERRORS:
; 	> only works properly up to input value 549. 'di ko na makeri-keri