override DEFINES		?= #-DNAME -DNAME2=VALUE
override GAS			?= as
override GCC			?= gcc -Wall -std=c99 -pedantic-errors
override LIB_DIR		?= lib/
override LN			?= ld -s
override IN_DIR			?=
override NASM			?= nasm -w+all -f elf
override OUT_DIR		?= _out/
override OUT_EXT		?= .elf
override OUT_BASENAME_NOEXT	?= main

EXT		:= .asm
INS		:= $(wildcard $(IN_DIR)*$(EXT))
INS_NODIR	:= $(notdir $(INS))
OUTS_NODIR	:= $(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
OUTS		:= $(addprefix $(OUT_DIR),$(OUTS_NODIR))

OUT_BNAME	:= $(OUT_BASENAME_NOEXT)$(OUT_EXT)

.PHONY: all clean driver mkdir run

all: mkdir driver $(OUTS)

$(OUT_DIR)%$(OUT_EXT): $(OUT_DIR)%.o
	$(GCC) -o "$@" "$<" $(OUT_DIR)driver.o $(OUT_DIR)asm_io.o

$(OUT_DIR)%.o: $(IN_DIR)%.asm
	$(NASM) $(DEFINES) -o "$@" "$<"

clean:
	rm -rf "$(OUT_DIR)"

driver:
	$(NASM) -dELF_TYPE -o $(OUT_DIR)asm_io.o $(LIB_DIR)asm_io.asm
	$(GCC) -o $(OUT_DIR)driver.o -c $(LIB_DIR)driver.c

mkdir:
	mkdir -p "$(OUT_DIR)"

run: all
	cd $(OUT_DIR) && ./$(OUT_BNAME)
