nasm -f elf32 kernel_debug.asm -o kernel_debug.o
ld -m elf_i386 -o kernel_debug.elf kernel_debug.o
objdump -D kernel_debug.elf

