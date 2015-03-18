DEFINES ?= #-DNAME -DNAME2=VALUE
GAS ?= as
GCC ?= gcc -Wall -std=c99 -pedantic-errors -m32
LIB_DIR ?= lib/
LN ?= ld -s
IN_DIR ?=
NASM ?= nasm -w+all -f elf
OUT_EXT ?= .out
OUT_BASENAME_NOEXT ?= main

EXT := .asm
INS := $(wildcard $(IN_DIR)*$(EXT))
INS_NODIR := $(notdir $(INS))
OUTS := $(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
OUT_BNAME := $(OUT_BASENAME_NOEXT)$(OUT_EXT)

.PRECIOUS: %.o
.PHONY: all clean driver run

all: driver $(OUTS)

%$(OUT_EXT): $(OUT_DIR)%.o
	$(GCC) -o "$@" "$<" $(OUT_DIR)driver.o $(OUT_DIR)asm_io.o

%.o: $(IN_DIR)%.asm
	$(NASM) $(DEFINES) -o "$@" "$<"

clean:
	rm -f *.o *.out

driver:
	$(NASM) -dELF_TYPE -o $(OUT_DIR)asm_io.o $(LIB_DIR)asm_io.asm
	$(GCC) -o $(OUT_DIR)driver.o -c $(LIB_DIR)driver.c

run: all
	./$(OUT_BNAME)
