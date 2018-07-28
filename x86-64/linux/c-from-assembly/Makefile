.POSIX:

IN_EXT ?= .asm
INC_EXT ?= .inc
OUT_EXT ?= .out
TMP_EXT ?= .o
RUN ?= main

OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(wildcard *$(IN_EXT)))
INCS := $(wildcard *$(INC_EXT))

.PRECIOUS: %$(TMP_EXT)
.PHONY: all clean run test

all: $(OUTS)

%$(OUT_EXT): %$(TMP_EXT)
	gcc -fno-pie -m64 -no-pie -pedantic-errors -o '$@' '$<'

%$(TMP_EXT): %$(IN_EXT) $(INCS)
	nasm -w+all -f elf64 -o '$@' '$<'

clean:
	rm -f *$(TMP_EXT) *$(OUT_EXT)

run: all
	./$(RUN)$(OUT_EXT)

test: all
	for f in *$(OUT_EXT); do echo $$f; ./$$f; done
