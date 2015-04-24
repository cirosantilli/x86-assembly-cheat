GCC ?= gcc -m32 -pedantic-errors -std=c89 -Wall
LIB_DIR ?= lib/
NASM ?= nasm -w+all -f elf32
OUT_EXT ?= .out
RUN ?= main

IN_EXT := .asm
INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))
OUT_BNAME := $(RUN)$(OUT_EXT)

.PRECIOUS: %.o
.PHONY: all clean driver run

all: driver $(OUTS)

%$(OUT_EXT): $(OUT_DIR)%.o
	$(GCC) -o '$@' '$<' driver.o asm_io.o

%.o: %.asm
	$(NASM) -o '$@' '$<'

clean:
	rm -f *.o *.out

driver:
	$(NASM) -dELF_TYPE -o asm_io.o $(LIB_DIR)asm_io.asm
	$(GCC) -o $(OUT_DIR)driver.o -c $(LIB_DIR)driver.c

run: all
	./$(OUT_BNAME)
