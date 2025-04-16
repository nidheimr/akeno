all: prepare bootloader kernel
.PHONY: prepare bootloader kernel clean test

prepare:
	mkdir -p bin/int/

bootloader:
	nasm -f bin -o bin/int/stage_0.bin bootloader/stage_0.asm
	nasm -f bin -o bin/int/stage_1.bin bootloader/stage_1.asm
	cat bin/int/stage_0.bin bin/int/stage_1.bin > bin/bootloader.bin

kernel:
	echo todo

clean:
	rm -rf bin/

test:
	qemu-system-x86_64 -drive format=raw,file=bin/bootloader.bin