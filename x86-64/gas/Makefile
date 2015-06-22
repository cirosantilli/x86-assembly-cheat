.POSIX:

GAS ?= as --64 -g
CCC ?= gcc -ggdb3 -m64 -std=c89 -pedantic-errors -Wall
IN_EXT := .S
LIB_DIR ?= lib/
LN ?= ld -s
NASM ?= nasm -w+all -f elf64
OUT_EXT ?= .out
RUN ?= main
export

INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PRECIOUS: %.o
.PHONY: all clean driver

all: driver $(OUTS)

%$(OUT_EXT): %.o
	$(CCC) -o '$@' '$<' driver.o asm_io.o

%.o: %$(IN_EXT)
	$(GAS) -o '$@' '$<'

clean:
	rm -f *.o *$(OUT_EXT)
	$(MAKE) -C '$(LIB_DIR)' '$@'

driver:
	$(MAKE) -C '$(LIB_DIR)'

run: all
	./'$(RUN)$(OUT_EXT)'
