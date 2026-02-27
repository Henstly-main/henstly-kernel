nasm -f bin program.asm -o file.bin
qemu-system-i386 -drive format=raw,file=file.bin
