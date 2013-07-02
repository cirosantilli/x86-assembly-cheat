GAS		?= as
LIB_DIR	?= lib/
LN		?= ld -s
IN_DIR		?= ./
OUT_DIR	?= _out/
OUT_EXT	?=
RUN		?= main

EXT		:= .s
INS		:= $(wildcard $(IN_DIR)*$(EXT))
INS_NODIR	:= $(notdir $(INS))
OUTS_NODIR	:= $(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
S_OUTS		:= $(addprefix $(OUT_DIR),$(OUTS_NODIR))

.PHONY: all mkdir clean

all: mkdir $(S_OUTS)

run: all
	cd $(OUT_DIR) && ./$(RUN)$(OUT_EXT)

$(OUT_DIR)%$(OUT_EXT): $(OUT_DIR)%.o
	$(LN) -o "$@" "$<"

$(OUT_DIR)%.o: $(IN_DIR)%.s
	$(GAS) -o "$@" "$<"

mkdir:
	mkdir -p "$(OUT_DIR)"

clean:
	rm -rf "$(OUT_DIR)"
