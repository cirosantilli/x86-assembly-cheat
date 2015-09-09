.POSIX:

IN_EXT ?= .S
IN_EXT2 ?= .c
# Use gcc so that the preprocessor will run first.
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN ?= bios_hello_world

INS := $(wildcard *$(IN_EXT)) $(wildcard *$(IN_EXT2))
OUTS := $(patsubst %,%$(OUT_EXT),$(basename $(INS)))

.PRECIOUS: %$(OBJ_EXT)
.PHONY: all clean run

all: $(OUTS)

%$(OUT_EXT): %$(OBJ_EXT)
	ld -m elf_i386 -o '$@' -T $(@:$(OUT_EXT)=.ld) '$<'

%$(OBJ_EXT): %$(IN_EXT)
	as --32 -o '$@' '$<'

%$(OBJ_EXT): %$(IN_EXT2)
	gcc -c -m32 -std=c99 -o '$@' '$<'

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)

run: all
	qemu-system-i386 '$(RUN)$(OUT_EXT)'
