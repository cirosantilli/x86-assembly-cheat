override GAS=as
override LN=ld -s
override IN_DIR?=./
override NASM=nasm -f elf
override OUT_DIR?=_out/
override OUT_EXT?=
override OUT_BASENAME_NOEXT?=nasm_cheat

EXT:=.asm
INS:=$(wildcard $(IN_DIR)*$(EXT))
INS_NODIR:=$(notdir $(INS))
OUTS_NODIR:=$(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
ASM_OUTS:=$(addprefix $(OUT_DIR),$(OUTS_NODIR))

EXT:=.s
INS:=$(wildcard $(IN_DIR)*$(EXT))
INS_NODIR:=$(notdir $(INS))
OUTS_NODIR:=$(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
S_OUTS:=$(addprefix $(OUT_DIR),$(OUTS_NODIR))

OUT_PATH:=$(OUT_DIR)$(OUT_BASENAME_NOEXT)$(OUT_EXT)

.PHONY: all mkdir clean

all: mkdir $(S_OUTS) $(ASM_OUTS)

run: all
	./$(OUT_PATH)

$(OUT_DIR)%$(OUT_EXT): $(OUT_DIR)%.o
	$(LN) -o "$@" "$<" 

$(OUT_DIR)%.o: $(IN_DIR)%.asm
	$(NASM) -o "$@" "$<"

$(OUT_DIR)%.o: $(IN_DIR)%.s
	$(GAS) -o "$@" "$<"

mkdir:
	mkdir -p "$(OUT_DIR)"

clean:
	rm -rf "$(OUT_DIR)"
