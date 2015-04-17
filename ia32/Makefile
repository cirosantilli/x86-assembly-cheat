DEFINES ?= #-DNAME -DNAME2=VALUE
GAS ?= as
GCC ?= gcc -Wall -std=c99 -pedantic-errors
LIB_DIR ?= lib/
LN ?= ld -s
IN_DIR ?=
NASM ?= nasm -w+all -f elf32
OUT_EXT ?= .out
RUN ?= main

EXT := .asm
INS := $(wildcard $(IN_DIR)*$(EXT))
INS_NODIR := $(notdir $(INS))
OUTS := $(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
OUT_BNAME := $(RUN)$(OUT_EXT)

.PRECIOUS: %.o
.PHONY: all clean driver run

all: driver $(OUTS)

%$(OUT_EXT): $(OUT_DIR)%.o
	$(GCC) -o "$@" "$<" driver.o asm_io.o

%.o: $(IN_DIR)%.asm
	$(NASM) $(DEFINES) -o '$@' '$<'

clean:
	rm -f *.o *.out

driver:
	$(NASM) -dELF_TYPE -o asm_io.o $(LIB_DIR)asm_io.asm
	$(GCC) -o $(OUT_DIR)driver.o -c $(LIB_DIR)driver.c

run: all
	./$(OUT_BNAME)
