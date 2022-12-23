GCC=arm-none-eabi-gcc
MACHINE=raspi2b
RAM_SIZE=1000

run: build
	qemu-system-arm -M $(MACHINE) -serial stdio -kernel myos.elf

build:
	$(GCC) -mcpu=cortex-a7 -fpic -ffreestanding -c boot.S -o boot.o
	$(GCC) -mcpu=cortex-a7 -fpic -ffreestanding -std=gnu99 -c kernel.c -o kernel.o -O2 -Wall -Wextra
	$(GCC) -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o kernel.o
	arm-none-eabi-objcopy myos.elf -O binary myos.bin

clean:
	rm *.o
	rm *.bin
	rm *.elf
