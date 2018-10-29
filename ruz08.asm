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
	rpt1_len equ $-resultpt1
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

section .bss

	name_ni_ano resb 20
	pangalan_ni_kwan resb 20

section .text

	global _start

_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, first_person
	mov edx, fp_len
		int 80h

	

exit:

	mov eax, 1
	mov ebx, 0
		int 80h