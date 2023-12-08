PATH?=/usr/bin
CROSS_PREFIX?=$(PATH)/aarch64-none-elf-

all: hello_world.elf

hello_world.o: hello_world.c
	$(CROSS_PREFIX)gcc -c $< -o $@

startup64.o: startup64.s
	$(CROSS_PREFIX)as -c $< -o $@

hello_world.elf: hello_world.o startup64.o
	$(CROSS_PREFIX)ld -Thello_world.ld $^ -o $@

hello_world.bin: hello_world.elf
	$(CROSS_PREFIX)objcopy -O binary $< $@

clean:
	rm -f hello_world.bin hello_world.elf startup64.o hello_world.o
