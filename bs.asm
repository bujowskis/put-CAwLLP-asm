bits	64
default	rel

extern	scanf
extern	printf

global	main

section	.data
	format_in	db '%d', 0
	format_out	db '%d ', 0

section	.bss
	array		resd 100
	array_ptr	resq 1				; Points to the position of a current number
	array_prev	resq 1				; Points to the position of a number prior to that of array_ptr

section	.text
main:
	; Read the numbers and store them in the array
	mov	rcx, -1					; stores number of elements in the array (n)
	lea	rdi, [array]
	mov	[array_ptr], rdi
	scan_loop:
		push	rcx

		mov	rsi, [array_ptr]
		lea	rdi, [format_in]
		mov	al, 0
		call	scanf wrt ..plt

		pop	rcx

		inc	rcx
		add	qword [array_ptr], 4
		cmp	rax, 1				; if scanf resulted in 1
		je	scan_loop

	; Perform bubblesort
	mov	r8, -1					; outer loop iterator (i)
	loop_r8:
		inc	r8				; 'i' increment and breaking condition
		cmp	r8, rcx
		je	exit_r8

		mov	r9, rcx				; inner loop iterator (j)

		lea	rdx, [array]			; set up pointer to the last element
		mov	[array_ptr], rdx
		mov	rsi, 1
		find_last:
			cmp	rsi, rcx
			je	set_prev
			add	qword [array_ptr], 4
			inc	rsi
			jmp	find_last
		set_prev:
			mov	rsi, [array_ptr]
			mov	[array_prev], rsi	; set up pointer to the element just before array_ptr
			sub	qword [array_prev], 4

		loop_r9:
			dec	r9			; 'j' decrement and breaking condition
			cmp	r9, r8
			je	loop_r8

			mov	rsi, [array_ptr]	; get &array[j]
			mov	r11d, [rsi]		; get  array[j]

			mov	rdi, [array_prev]	; get &array[j - 1]
			mov	r10d, [rdi]		; get  array[j - 1]

			cmp	r11d, r10d		; compare the numbers
		; if (array[j] >= array[j - 1])
			jge	skip
		; else
			mov	[rsi], r10d
			mov	[rdi], r11d

			skip:
			sub	qword [array_ptr], 4
			sub	qword [array_prev], 4
			jmp	loop_r9

	exit_r8:

	; Print the sorted array
	lea	rdi, [array]
	mov	[array_ptr], rdi
	mov	r8, 0
	print_loop:
		; Save needed content
		push	r8
		push	rcx

		mov	rsi, [array_ptr]
		mov	rsi, [rsi]
		lea	rdi, [format_out]
		mov	al, 0
		call	printf wrt ..plt

		pop	rcx
		pop	r8

		add	qword [array_ptr], 4		; Move to the next element
		inc	r8

		cmp	r8, rcx
		jne	print_loop

	; Cleanup
	sub	rax, rax
	ret
