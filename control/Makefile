ASM=nasm
LD=ld
OBJCOPY=objcopy

ASMFLAGS=-f elf32
LDFLAGS=-m elf_i386 -Ttext 0x7C00 -e _start

SRC=../src
BUILD=../src/build

all: $(BUILD)/kernel.bin

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/kernel.o: $(SRC)/kernel.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) -I$(SRC) $(SRC)/kernel.asm -o $(BUILD)/kernel.o

$(BUILD)/kernel.elf: $(BUILD)/kernel.o
	$(LD) $(LDFLAGS) -o $(BUILD)/kernel.elf $(BUILD)/kernel.o

$(BUILD)/kernel.bin: $(BUILD)/kernel.elf
	$(OBJCOPY) -O binary $(BUILD)/kernel.elf $(BUILD)/kernel.bin

run: all
	qemu-system-i386 -drive format=raw,file=$(BUILD)/kernel.bin

debug: all
	qemu-system-i386 -drive format=raw,file=$(BUILD)/kernel.bin -S -s

gdb:
	gdb $(BUILD)/kernel.elf

dump: $(BUILD)/kernel.elf
	objdump -D $(BUILD)/kernel.elf

clean:
	rm -rf $(BUILD)
