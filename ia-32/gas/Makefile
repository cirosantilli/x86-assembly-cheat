GAS ?= as --32 -g
CCC ?= gcc -ggdb -m32 -std=c89 -pedantic-errors -Wall
IN_EXT := .s
LIB_DIR ?= lib/
LN ?= ld -s
NASM ?= nasm -w+all -f elf32
OUT_EXT ?= .out
RUN ?= main

INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PRECIOUS: %.o
.PHONY: all clean driver

all: driver $(OUTS)

%$(OUT_EXT): %.o
	$(CCC) -o '$@' '$<' driver.o asm_io.o

%.o: %.s
	$(GAS) -o '$@' '$<'

clean:
	rm -f *.o *$(OUT_EXT)

driver:
	$(NASM) -dELF_TYPE -o asm_io.o $(LIB_DIR)asm_io.asm
	$(CCC) -o $(OUT_DIR)driver.o -c $(LIB_DIR)driver.c

run: all
	./'$(RUN)$(OUT_EXT)'
