nasm -f bin kernel.asm -o kernel.bin
qemu-system-i386 \
-drive format=raw,file=kernel.bin \
-S -s \
-boot c \
-monitor none

