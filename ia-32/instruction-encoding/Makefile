.POSIX:

BIN_EXT ?= .bin
IN_EXT ?= .asm
OBJ_EXT ?= .o
OUT_EXT ?= .hd

INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PHONY: all clean view
.PRECIOUS: %$(BIN_EXT) %$(OBJ_EXT)

all: $(OUTS)

%$(OUT_EXT): %$(BIN_EXT)
	od -An -tx1 '$<' | tail -c+2 > '$@'

%$(BIN_EXT): %$(OBJ_EXT)
	objcopy -O binary --only-section=.text '$<' '$@'

%$(OBJ_EXT): %$(IN_EXT)
	nasm -f elf32 -o '$@' '$<'
	@# For raw 16 bit. Would need to remove the objcopy step.
	@#nasm -f bin -o '$@' '$<'

clean:
	rm -f *$(BIN_EXT) *$(OBJ_EXT) *$(OUT_EXT)

view: all
	tail -n+1 *$(OUT_EXT)
