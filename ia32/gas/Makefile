GAS ?= as
GCC ?= gcc -Wall -std=c99 -pedantic-errors
LIB_DIR ?= lib/
LN ?= ld -s
IN_DIR ?= ./
OUT_EXT ?=
RUN ?= main

EXT := .s
INS := $(wildcard $(IN_DIR)*$(EXT))
INS_NODIR := $(notdir $(INS))
OUTS := $(patsubst %$(EXT),%$(OUT_EXT),$(INS_NODIR))

.PHONY: all clean driver

all: driver $(OUTS)

%$(OUT_EXT): %.o
	$(GCC) -o "$@" "$<" driver.o

%.o: $(IN_DIR)%.s
	$(GAS) -o "$@" "$<"

clean:
	rm -f *.o *.out

driver:
	$(GCC) -o driver.o -c driver.c

run: all
	./$(RUN)$(OUT_EXT)
