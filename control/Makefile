ASM=nasm
LD=ld
OBJCOPY=objcopy

# Flags
ASMFLAGS=-f elf32
# boot for mbr and kernel
BOOT_LDFLAGS=-m elf_i386 -Ttext 0x7C00
KERN_LDFLAGS=-m elf_i386 -Ttext 0x1000

SRC=../src
BUILD=../src/build
BOOT_DIR=boot


all: $(BUILD)/os_img.bin

$(BOOT_DIR) $(BUILD):
	mkdir -p $@

# Bootloader (sector 1)
$(BUILD)/boot.o: $(SRC)/boot.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) -I$(SRC) $< -o $@

$(BUILD)/boot.elf: $(BUILD)/boot.o
	$(LD) $(BOOT_LDFLAGS) -o $@ $<

$(BUILD)/boot.bin: $(BUILD)/boot.elf | $(BOOT_DIR)
	$(OBJCOPY) -O binary $< $@

# Kernel (sector 2+)
$(BUILD)/kernel.o: $(SRC)/kernel.asm | $(BUILD)
	$(ASM) $(ASMFLAGS) -I$(SRC) $< -o $@

$(BUILD)/kernel.elf: $(BUILD)/kernel.o
	$(LD) $(KERN_LDFLAGS) -o $@ $<

$(BUILD)/kernel.bin: $(BUILD)/kernel.elf | $(BOOT_DIR)
	$(OBJCOPY) -O binary $< $@

# os_img
$(BUILD)/os_img.bin: $(BUILD)/boot.bin $(BUILD)/kernel.bin
	cat $^ > $@

run: all
	qemu-system-i386 -drive format=raw,file=$(BUILD)/os_img.bin

clean:
	rm -rf $(BUILD) $(BOOT_DIR)
