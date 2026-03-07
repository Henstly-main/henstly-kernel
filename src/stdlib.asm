; stdlib.asm
compare_strs_si_bx: ; cmp strings
.start_cssb:
	push ax
	push bx
	push si

.comp_cssb:
	mov al, [bx] ; for cmp
	cmp [si], al
	jne .not_equal
	
	cmp byte [si], 0 ; first zero
	je .zero_cssb
	
	inc si
	inc bx
	
	jmp .comp_cssb

.zero_cssb:
	cmp byte [bx], 0 ; if not zero -> not equal
	jne .not_equal
	
	mov cx, 1 ; flag
	
	pop si
	pop bx
	pop ax
	ret

.not_equal:
	pop si
	pop bx
	pop ax
	
	mov cx, 0 ; flag
	ret

clear_buffer:
.clear_bytes:
	cmp cx, 0
	je .done_clb
	
	mov byte [bx], 0
	inc bx
	dec cx
	jmp .clear_bytes
.done_clb:
	ret
