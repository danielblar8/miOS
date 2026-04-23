CC = gcc
ASM = nasm
CFLAGS = -m32 -ffreestanding -fno-pie -nostdlib -nostdinc
ASMFLAGS = -f elf32

SRC = src/kernel.c
ASMSRC = src/kernel_entry.asm
OBJ = kernel_entry.o kernel.o
OUTPUT = boot/kernel.bin
ISO = miOS.iso

all: $(ISO)

kernel_entry.o: $(ASMSRC)
	$(ASM) $(ASMFLAGS) $(ASMSRC) -o kernel_entry.o

kernel.o: $(SRC)
	$(CC) $(CFLAGS) -c $(SRC) -o kernel.o

$(OUTPUT): $(OBJ)
	ld -m elf_i386 -T linker.ld -o $(OUTPUT) $(OBJ)

$(ISO): $(OUTPUT)
	mkdir -p isodir/boot/grub
	cp $(OUTPUT) isodir/boot/kernel.bin
	cp boot/grub/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) isodir

clean:
	rm -f *.o $(OUTPUT) $(ISO)
	rm -rf isodir