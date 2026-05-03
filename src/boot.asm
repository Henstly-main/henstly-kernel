bits 16
;org 0x7c00 - in comment for debug



_start:
	mov [BOOT_DRIVE], dl
	xor ax,ax
	
	mov es, ax
	mov ds, ax
	mov ss, ax
    mov bp, 0x8000
	mov sp, bp
    
	
	mov bx, 0x1000
    mov dh, 4
    mov dl, [BOOT_DRIVE]
    call disk_load
	
	jmp 0x1000
	


%include "io.asm"
%include "disk_load.asm"


BOOT_DRIVE: db 0


times 510-($-$$) db 0
dw 0xAA55
