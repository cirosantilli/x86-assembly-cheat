#compiles all asm files in current dir
#with nasm into separate executables

DEFINES?=#-DNAME -DNAME2=VALUE
GAS?=as
GCC?=gcc -Wall -ansi -pedantic
LIB_DIR?=lib/
LN?=ld -s
IN_DIR?=
IN_EXT?=.asm
NASM?=nasm -w+all -f elf
OUT_DIR?=_out/
OUT_EXT?=.elf
OUT_BASENAME_NOEXT?=main

INS:=$(wildcard $(IN_DIR)*$(IN_EXT))
INS_NODIR:=$(notdir $(INS))
OUTS_NODIR:=$(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS_NODIR))
OUTS:=$(addprefix $(OUT_DIR),$(OUTS_NODIR))

.PHONY: all clean mkdir run

all: mkdir $(OUTS)

$(OUT_DIR)%$(OUT_EXT): $(IN_DIR)%$(IN_EXT)
	$(eval OBJ := "$(OUT_DIR)$*".o)
	$(NASM) $(DEFINES) -o "$(OBJ)" "$<"
	$(LN) -o "$@" "$(OBJ)"

clean:
	rm -rf "$(OUT_DIR)"

mkdir:
	mkdir -p "$(OUT_DIR)"

run: all
	cd $(OUT_DIR) && ./$(OUT_BASENAME_NOEXT)$(OUT_EXT)
