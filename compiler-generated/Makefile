.POSIX:

ASM_EXT ?= .s
O ?= 0
CCC ?= gcc -pedantic-errors -std=c99 -Wextra -ggdb -O$(O) #-mfpmath=387
CCC_CPP ?= g++ -pedantic-errors -std=c++11 -Wextra
IN_EXT ?= .c
IN_EXT_CPP ?= .cpp
LIBS ?= -lm
OBJ_EXT ?= .o
OUT_EXT ?= .out
OBJ_READELF_EXT ?= $(OBJ_EXT).readelf
OUT_READELF_EXT ?= $(OUT_EXT).readelf
OBJ_OBJDUMP_EXT ?= $(OBJ_EXT).objdump
OUT_OBJDUMP_EXT ?= $(OUT_EXT).objdump
RUN ?= hello_world

INS := $(wildcard *$(IN_EXT))
OUTS := $(addsuffix $(OUT_EXT), $(basename $(INS)))

INS_CPP := $(wildcard *$(IN_EXT_CPP))
OUTS_CPP := $(addsuffix $(OUT_EXT), $(basename $(INS_CPP)))

.PHONY: all clean run

all: $(OUTS) $(OUTS_CPP)

%$(OUT_EXT): %$(IN_EXT)
	$(CCC) -S '$<' -o '$(basename $@)$(ASM_EXT)' $(LIBS)
	$(CCC) -c '$(basename $@)$(ASM_EXT)' -o '$(basename $@)$(OBJ_EXT)' $(LIBS)
	readelf -W -a '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_READELF_EXT)'
	objdump -Sr   '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_OBJDUMP_EXT)'
	$(CCC) '$(basename $@)$(OBJ_EXT)' -o '$@' $(LIBS)
	readelf -W -a '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_READELF_EXT)'
	objdump -Sr   '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_OBJDUMP_EXT)'

%$(OUT_EXT): %$(IN_EXT_CPP)
	$(CCC_CPP) -S '$<' -o '$(basename $@)$(ASM_EXT)'
	$(CCC_CPP) -c '$(basename $@)$(ASM_EXT)' -o '$(basename $@)$(OBJ_EXT)'
	readelf -W -a '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_READELF_EXT)'
	objdump -Sr   '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_OBJDUMP_EXT)'
	$(CCC_CPP) '$(basename $@)$(OBJ_EXT)' -o '$@'
	readelf -W -a '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_READELF_EXT)'
	objdump -Sr   '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_OBJDUMP_EXT)'

clean:
	rm -f  *'$(ASM_EXT)' *'$(OBJ_EXT)' *'$(OUT_EXT)' *'$(OBJ_OBJDUMP_EXT)' *'$(OUT_OBJDUMP_EXT)' *'$(OBJ_READELF_EXT)' *'$(OUT_READELF_EXT)'

run: all
	./'$(RUN)$(OUT_EXT)'
