bits	64
default	rel

extern	printf
extern	scanf

global	main

section	.data
	format_in	db '%s', 0
	format_out	db '%s', 10, 0

section	.bss
	input		resb 1024
	output		resb 1024

section	.text
main:
	sub	rsp, 8

	; Read the incoming string
	lea	rsi, [input]
	lea	rdi, [format_in]
	mov	al, 0
	call	scanf wrt ..plt

	; Copy the contents, byte by byte
	lea	rsi, [input]	; pointer to the input
	lea	rdi, [output]	; pointer to the output
	copy_loop:
		mov	al, [rsi]
		movsb
		cmp	al, 0
		je	print
		jmp	copy_loop

	print:
	; Print the copied string
	lea	rsi, [output]
	lea	rdi, [format_out]
	mov	al, 0
	call	printf wrt ..plt

	add	rsp, 8
	ret
