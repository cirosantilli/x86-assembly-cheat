ASM_EXT ?= .s
CCC ?= gcc -pedantic-errors -std=c89 -Wall -O3
IN_EXT ?= .c
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN ?= main

INS := $(wildcard *$(IN_EXT))
OUTS_NOEXT := $(basename $(INS))
OUTS := $(addsuffix $(OUT_EXT), $(OUTS_NOEXT))

.PHONY: all clean run

all: $(OUTS)

%$(OUT_EXT): %$(IN_EXT)
	$(CCC) -S '$<' -o '$(basename $@)$(ASM_EXT)'
	$(CCC) -c '$<' -o '$(basename $@)$(OBJ_EXT)'
	$(CCC) '$<' -o '$@'

clean:
	rm -f  *'$(ASM_EXT)' *'$(OBJ_EXT)' *'$(OUT_EXT)'

run: all
	./'$(RUN)$(OUT_EXT)'
