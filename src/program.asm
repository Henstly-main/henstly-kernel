org 0x7c00

mov ah, 0x0e
mov al, -1
int 0x10
mov al, ' '
int 0x10
mov al, -1
neg al
int 0x10
mov al, ' '
int 0x10
cbw
mov dl, ah
mov ah,0x0e
mov al, dl
int 0x10

hang:
	jmp $

times 510-($-$$) db 0

dw 0xAA55
