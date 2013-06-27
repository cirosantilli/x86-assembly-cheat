override GAS		?= as
override GCC		?= gcc -Wall -std=c99 -pedantic-errors
override LIB_DIR	?= lib/
override LN		?= ld -s
override IN_DIR		?= ./
override OUT_DIR	?= _out/
override OUT_EXT	?=
override RUN		?= main

EXT			:= .s
INS			:= $(wildcard $(IN_DIR)*$(EXT))
INS_NODIR	:= $(notdir $(INS))
OUTS_NODIR	:= $(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))
OUTS		:= $(addprefix $(OUT_DIR),$(OUTS_NODIR))

.PHONY: all clean driver mkdir

all: mkdir driver $(OUTS)

$(OUT_DIR)%$(OUT_EXT): $(OUT_DIR)%.o
	$(GCC) -o "$@" "$<" $(OUT_DIR)driver.o

$(OUT_DIR)%.o: $(IN_DIR)%.s
	$(GAS) -o "$@" "$<"

clean:
	rm -rf "$(OUT_DIR)"

driver:
	$(GCC) -o $(OUT_DIR)driver.o -c driver.c

mkdir:
	mkdir -p "$(OUT_DIR)"

run: all
	cd $(OUT_DIR) && ./$(RUN)$(OUT_EXT)
