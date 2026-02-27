org 0x7c00


start:
	xor ax, ax
	xor cx, cx
	mov ds, ax
	mov si, buffer
	xor bx, bx
	xor dx, dx
	call input

input:
	mov ah, 0
	int 0x16
	cmp al, 0x0d
	je .done_input
	 
	
	cmp al, 0x08
	je .do_call
	
	mov dl, al
	push dx
	inc bx

	mov ah, 0x0e
	int 0x10
	jmp input



.call_print:
	call print_string

.backspace:
	; buffer condition
	
	
	; clean one last byte of buffer
	cmp bx, 0
	je .return
	pop dx
	dec bx
	
	; video backspace
	mov ah, 0x0e
	mov al, 0x08
	int 0x10
	mov al, ' '
	int 0x10
	mov al, 0x08
	int 0x10
	jmp input

.return:
	ret

.newline:
	mov ah, 0x0e
	mov al, 0x0d
	mov dl, al
	push dx
	inc bx
	
	int 0x10
	mov al, 0x0a
	int 0x10
	jmp .return

.done_input:
	call .newline
	mov al, 0
	mov dl, al
	push dx
	inc bx
	jmp .call_print
; return


; call func
.do_call:
	call .backspace

print_string:
.next:
	pop dx
	mov ax, dx
	cmp al, 0x5a
	je .done_string
	
	mov ah, 0x0e
	int 0x10
	jmp .next

.done_string:
	jmp hang



hang:
	jmp $

variableName:
	db "Input: ",0

buffer:
	times 100 db 0


	
times 510-($-$$) db 0

dw 0xAA55
