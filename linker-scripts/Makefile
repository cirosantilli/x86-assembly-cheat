.POSIX:

IN_EXT ?= .S
LD_EXT ?= .ld
LD_FLAGS ?= -T $(@:$(OUT_EXT)=.ld)
# Use gcc so that the preprocessor will run first.
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN ?= bios_hello_world

OUTS := $(patsubst %,%$(OUT_EXT),$(basename $(wildcard *$(IN_EXT))))

.PRECIOUS: %$(OBJ_EXT)
.PHONY: all clean run

all: $(OUTS)

%$(OUT_EXT): %$(OBJ_EXT) %$(LD_EXT)
	ld -m elf_i386 -o '$@' -T $(@:$(OUT_EXT)=$(LD_EXT)) '$<'

%$(OBJ_EXT): %$(IN_EXT) common.h
	gcc -c -m32 -o '$@' '$<'

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)

test: all
	# Lazy.

run: all
	qemu-system-i386 '$(RUN)$(OUT_EXT)'
