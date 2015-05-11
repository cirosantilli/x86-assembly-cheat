GCC ?= gcc -ggdb -m32 -pedantic-errors -std=c89 -Wall
LIB_DIR ?= lib/
NASM ?= nasm -g -w+all -f elf32
OUT_EXT ?= .out
RUN ?= main

IN_EXT := .asm
INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PRECIOUS: %.o
.PHONY: all clean driver run

all: driver $(OUTS)

%$(OUT_EXT): %.o
	$(GCC) -o '$@' '$<' $(LIB_DIR)*.o

%.o: %.asm
	$(NASM) -o '$@' '$<'

clean:
	rm -f *.o *.out $(LIB_DIR)*.o

driver:
	$(NASM) -dELF_TYPE -o $(LIB_DIR)asm_io.o $(LIB_DIR)asm_io.asm
	$(GCC) -o $(LIB_DIR)driver.o -c $(LIB_DIR)driver.c

run: all
	./'$(RUN)$(OUT_EXT)'
