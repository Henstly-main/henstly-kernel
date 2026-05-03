; shell.asm
prompt_check:
.start_pr_ch: ; base start
	push cx
	push bx
	xor cx,cx
	
	jmp .check_prompt
	
	
.check_prompt:
	mov si, help_command       ;|
	mov bx, input_buffer       ;|
	call compare_strs_si_bx    ;| =help?
	cmp cx, 1                  ;|
	je .entered_help           ;|
	
	mov si, shutdown_command   ;|
	mov bx, input_buffer       ;|
	call compare_strs_si_bx    ;| =shutdown?
	cmp cx, 1                  ;|
	je .entered_shutdown       ;|
    
	jmp .wrong_enter ;| =else

.entered_help: ; help exec
	mov si, help_desc
	call print_string
	
	pop bx
	pop cx
	ret
    
.wrong_enter: ; wrong enter
	mov si, wrong_command_print
	call print_string
	
	pop bx
	pop cx
	ret

.entered_shutdown: ; shutdown exec
	mov si, shutdown_print
	call print_string
	
	pop bx
	pop cx
	jmp $
