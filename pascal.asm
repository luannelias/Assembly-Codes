;Pascal triangle generator in Assembly
;by luc99a
;the code is not commented, I will make a Python code to explain the algorithm used

section .bss
toprint:	resb	1

section .data
lf:	db 0Ah
space:	db 20h

section .text
global _start
_start:

	mov eax, 0
	mov ebx, 0
	mov ecx, 10
	xor edx, edx
	loop:
	push eax
	push ebx
	push ecx
	push edx
	call pascal
	call printnum
	pop edx
	pop ecx
	pop ebx
	pop eax
	cmp eax, ebx
	je reloop
	cmp ebx, edx
	jne incebx
	incebx:
	inc ebx
	test ecx, ecx
	jnz loop
	reloop:
	push eax
	push ebx
	push ecx
	push edx
	call newline
	pop edx
	pop ecx
	pop ebx
	pop eax
	inc eax
	inc edx
	xor ebx, ebx
	dec ecx
	test ecx, ecx
	jnz loop
	exit:
	mov eax, 1
	mov ebx, 0
	int 80h

;get number at row col in the triangle
;param row in eax
;param col in ebx
;return value in eax
pascal:

	cmp ebx, 0
	je eax1
	cmp eax, ebx
	je eax1

	push eax
	push ebx
	sub eax, 1
	sub ebx, 1
	call pascal
	pop ebx
	pop ecx
	push eax
	mov eax, ecx
	sub eax, 1
	call pascal
	pop ebx
	add eax, ebx
	jmp end

	eax1:
	mov eax, 1
	end:
	ret

;print a number to sdtout
;param number in eax
printnum:
	xor edi, edi
	divide:
	xor edx, edx
	mov ecx, 10
	div ecx
	push edx
	inc edi
	test eax, eax
	jnz divide
	print:
	pop eax
	add eax, '0'
	mov [toprint], eax
	mov eax, 4
	mov ebx, 1
	mov ecx, toprint
	mov edx, 1
	int 80h
	dec edi
	test edi, edi
	jnz print
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 80h
	ret

;print a line feed character
newline:
	mov eax, 4
	mov ebx, 1
	mov ecx, lf
	mov edx, 1
	int 80h
	ret
