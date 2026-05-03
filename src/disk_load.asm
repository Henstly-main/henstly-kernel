; disk_load.asm
disk_load:
    pusha
    
    push dx
    
    mov ah, 0x02
    mov al,dh
    mov ch,0x00
    mov dh,0x00
    mov cl, 0x02
    
    int 0x13
    jc disk_error
    
    pop dx
    cmp al,dh
    jne sectors_error
    
    mov si, SUCCESS
    call print_string
    popa
    ret
    
disk_error:
    mov si, DISK_ERROR
    call print_string
    
    mov dl,ah
    xor dh,dh
    call print_hex
    jmp $

    
sectors_error:
    mov si, SECTORS_ERROR
    call print_string
    
    jmp $

    
DISK_ERROR: db "Disk read error", 0x0d, 0xa, 0
SECTORS_ERROR: db "Invalid number of sectors read",0x0d, 0xa, 0
SUCCESS: db "Disk read successful!",0x0d, 0xa, 0
