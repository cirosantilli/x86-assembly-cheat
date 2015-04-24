IN_EXT ?= .asm
OUT_EXT ?= .out
TMP_EXT ?= .o
RUN ?= hello_world

INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PRECIOUS: %$(TMP_EXT)
.PHONY: all clean run

all: $(OUTS)

%$(OUT_EXT): $(OUT_DIR)%$(TMP_EXT)
	ld -o '$@' '$<'

%.o: %.asm
	nasm -w+all -f elf64 -o '$@' '$<'

clean:
	rm -f *$(TMP_EXT) *$(OUT_EXT)

run: all
	./$(RUN)$(OUT_EXT)
