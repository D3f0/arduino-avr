# Makefile mínimo
FREQ=8000000
MCU=atmega328p

all: blink.hex

blink.elf: blink.c
	avr-gcc -mmcu=${MCU} -Wall -Os -g3 -o blink.elf blink.c

blink.hex: blink.elf
	avr-objcopy -j .text -j .data -O ihex blink.elf blink.hex

clean:
	rm -f blink.hex blink.elf

re: clean all

simulate:
	simavr -g -f ${FREQ} -m ${MCU} blink.hex

rungdb:
	echo -e "file blink.elf\ntarget remote localhost:1234\n" > gdb.conf
	ddd --debugger "avr-gdb -x gdb.conf"
