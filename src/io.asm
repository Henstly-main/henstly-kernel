input:
.start_input: ; save registers
	push ax
	push cx
	push bx
	mov si, input_buffer
	xor cx,cx
	
.enter_input: ; input
	mov ah, 0
	int 0x16
	
	cmp cx, 63 ; check buffer
	jnb .enter_input
	
	cmp al, 0x0d ; Enter -> done
	je .done_input
	
	cmp al, 0x08 ; Backspace
	je .call_backspace
	
	inc cx
	mov [si], al
	inc si
	
	mov ah, 0x0e
	int 0x10
	jmp .enter_input

.call_backspace:
	call .backspace
	jmp .enter_input

.backspace:
	cmp cx, 0
	je .return
	
	dec cx      ; dec cx and buffer
	mov byte [si], 0
	dec si
	
	mov ah,0x0e ; video backspace
	mov al, 0x08
	int 0x10
	mov al, ' '
	int 0x10
	mov al, 0x08
	int 0x10
	jmp .return
	
.return:
	ret
	
.done_input:
	mov byte [si], 0 ; end buffer
	
	mov al, 0x0d ; video Enter
	mov ah,0x0e
	int 0x10
	mov al, 0x0a
	int 0x10
	pop bx
	pop cx
	pop ax
	ret
	
print_string:
.print_start: ; push registers, cmp bx for favorite print
	push ax
	
	mov ah, 0x0e
	call .print_line
	
	pop ax
	ret
	
	

.print_line: ; print 
	lodsb
	cmp al, 0
	je .done_print
	
	mov ah, 0x0e
	int 0x10
	jmp .print_line
	
.done_print:
	ret
	
input_buffer: times 64 db 0
