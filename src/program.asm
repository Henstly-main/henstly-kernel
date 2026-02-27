org 0x7c00

start:
	xor ax,ax
	xor cx,cx
	xor bx,bx
	xor dx,dx
	
	
main:
	mov si, command
	mov bx, 0
	call print_string
	call input
	jmp main


input:
.start: ; save registers
	pusha 
	pushf
	mov si, buffer
	xor cx,cx
.enter: ; input
	mov ah, 0
	int 0x16
	
	cmp cx, 99 ; check buffer
	jnb .enter
	
	cmp al, 0x0d ; Enter -> done
	je .done_input
	
	cmp al, 0x08 ; Backspace
	je .call_backspace
	
	inc cx
	mov [si], al
	inc si
	
	mov ah, 0x0e
	int 0x10
	jmp .enter

.call_backspace:
	call .backspace
	jmp .enter

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
	mov byte [si], 0
	
	mov al, 0x0d
	mov ah,0x0e
	int 0x10
	mov al, 0x0a
	int 0x10
	popf
	popa
	ret
	

print_string:
.print_start: ; push registers, cmp bx for favorite print
	pusha
	pushf
	cmp bx, 0
	je .print_command

.print_command: ; print prompt
	lodsb
	cmp al, 0
	je .done_print
	
	mov ah, 0x0e
	int 0x10
	jmp .print_command
	
.done_print:
	popf
	popa
	ret
	


buffer:
	times 100 db 0

flag:
	times 3 db 0

command:
	db '\>',0

times 510-($-$$) db 0

dw 0xAA55
