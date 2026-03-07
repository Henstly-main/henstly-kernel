bits 16
;org 0x7c00 - in comment for debug



_start:
	xor ax,ax
	xor cx,cx
	xor bx,bx
	xor dx,dx
	
	mov ss, ax
	mov sp, 0x9000
	
	mov si, greet_print
	call print_string
	
	
main: ; main loop
	mov si, prompt
	call print_string
	call input
	call prompt_check
	jmp main


%include "io.asm"
%include "shell.asm"
%include "stdlib.asm"
%include "data.asm"




times 510-($-$$) db 0

dw 0xAA55
