IN_EXT ?= .asm
OUT_EXT ?= .out
TMP_EXT ?= .o
RUN ?= hello_world

INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PRECIOUS: %$(TMP_EXT)
.PHONY: all clean run test

all: $(OUTS)

%$(OUT_EXT): $(OUT_DIR)%$(TMP_EXT)
	ld -m elf_i386 -o '$@' '$<'

%.o: %.asm
	nasm -w+all -f elf32 -g -o '$@' '$<'

clean:
	rm -f *$(TMP_EXT) *$(OUT_EXT)

run: all
	./$(RUN)$(OUT_EXT)

test: all
	for f in *$(OUT_EXT); do echo $$f; ./$$f; done
