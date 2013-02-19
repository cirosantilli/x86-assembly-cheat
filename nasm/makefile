override DEFINES?=-DLINUX
override GAS?=as
override GCC?=gcc -Wall -ansi -pedantic
override LIB_DIR?=lib/
override LN?=ld -s
override IN_DIR?=
override NASM?=nasm -w+all -f elf
override OUT_DIR?=_out/
override OUT_EXT?=
override OUT_BASENAME_NOEXT?=nasm_cheat

EXT:=.asm
INS:=$(wildcard $(IN_DIR)*$(EXT))
INS_NODIR:=$(notdir $(INS))
OUTS_NODIR:=$(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
ASM_OUTS:=$(addprefix $(OUT_DIR),$(OUTS_NODIR))

OUT_PATH:=$(OUT_DIR)$(OUT_BASENAME_NOEXT)$(OUT_EXT)

.PHONY: all mkdir clean driver

all: mkdir driver $(S_OUTS) $(ASM_OUTS)

run: all
	./$(OUT_PATH)

driver:
	#gcc -o $(OUT_DIR)driver.o driver.c
	$(NASM) -dELF_TYPE -o $(OUT_DIR)asm_io.o $(LIB_DIR)asm_io.asm
	$(GCC) -o $(OUT_DIR)driver.o -c $(LIB_DIR)driver.c 

$(OUT_DIR)%$(OUT_EXT): $(OUT_DIR)%.o
	$(GCC) -o "$@" "$<" $(OUT_DIR)driver.o $(OUT_DIR)asm_io.o
	#$(LN) -o "$@" "$<" 

$(OUT_DIR)%.o: $(IN_DIR)%.asm
	$(NASM) $(DEFINES) -o "$@" "$<"

mkdir:
	mkdir -p "$(OUT_DIR)"

clean:
	rm -rf "$(OUT_DIR)"
