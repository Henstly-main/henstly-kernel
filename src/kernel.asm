;org 0x1000
bits 16

global _start


_start:
	
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

times 5120 db 0
