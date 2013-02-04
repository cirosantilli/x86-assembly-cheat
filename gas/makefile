override GAS?=as
override LIB_DIR?=lib/
override LN?=ld -s
override IN_DIR?=
override OUT_DIR?=_out/
override OUT_EXT?=
override OUT_BASENAME_NOEXT?=nasm_cheat

EXT:=.s
INS:=$(wildcard $(IN_DIR)*$(EXT))
INS_NODIR:=$(notdir $(INS))
OUTS_NODIR:=$(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
S_OUTS:=$(addprefix $(OUT_DIR),$(OUTS_NODIR))

OUT_PATH:=$(OUT_DIR)$(OUT_BASENAME_NOEXT)$(OUT_EXT)

.PHONY: all mkdir clean driver

all: mkdir driver $(S_OUTS)

run: all
	./$(OUT_PATH)

$(OUT_DIR)%$(OUT_EXT): $(OUT_DIR)%.o
	$(LN) -o "$@" "$<" 

$(OUT_DIR)%.o: $(IN_DIR)%.s
	$(GAS) -o "$@" "$<"

mkdir:
	mkdir -p "$(OUT_DIR)"

clean:
	rm -rf "$(OUT_DIR)"
