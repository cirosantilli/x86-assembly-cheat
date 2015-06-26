.POSIX:

-include Makefile_params

ASM_EXT ?= .s
O ?= 0
STD ?= c99
CCC     ?= gcc -fdump-tree-all -fdump-rtl-all -fdump-final-insns -ggdb3 -pthread -O$(O) -pedantic-errors -std=$(STD) -Wextra #-mfpmath=387
CCC_CPP ?= g++ -fdump-tree-all -fdump-rtl-all -fdump-final-insns -ggdb3 -pthread -O$(O) -pedantic-errors -std=c++11  -Wextra
IN_EXT ?= .c
IN_EXT_CPP ?= .cpp
LIBS ?= -lm
OBJDUMP = objdump -CSr
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
	$(CCC) -o '$(basename $@)$(ASM_EXT)' $(LIBS) -S '$<'
	$(CCC) -c '$(basename $@)$(ASM_EXT)' -o '$(basename $@)$(OBJ_EXT)' $(LIBS)
	readelf -W -a '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_READELF_EXT)'
	$(OBJDUMP) '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_OBJDUMP_EXT)'
	$(CCC) '$(basename $@)$(OBJ_EXT)' -o '$@' $(LIBS)
	readelf -W -a '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_READELF_EXT)'
	$(OBJDUMP) '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_OBJDUMP_EXT)'

%$(OUT_EXT): %$(IN_EXT_CPP)
	$(CCC_CPP) -o '$(basename $@)$(ASM_EXT)' -S '$<'
	$(CCC_CPP) -c '$(basename $@)$(ASM_EXT)' -o '$(basename $@)$(OBJ_EXT)'
	readelf -W -a '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_READELF_EXT)'
	$(OBJDUMP) '$(basename $@)$(OBJ_EXT)' > '$(basename $@)$(OBJ_OBJDUMP_EXT)'
	$(CCC_CPP) '$(basename $@)$(OBJ_EXT)' -o '$@'
	readelf -W -a '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_READELF_EXT)'
	$(OBJDUMP) '$(basename $@)$(OUT_EXT)' > '$(basename $@)$(OUT_OBJDUMP_EXT)'

clean:
	rm -f \
		*'$(ASM_EXT)' \
		*'$(OBJ_EXT)' \
		*'$(OUT_EXT)' \
		*'$(OBJ_OBJDUMP_EXT)' \
		*'$(OUT_OBJDUMP_EXT)' \
		*'$(OBJ_READELF_EXT)' \
		*'$(OUT_READELF_EXT)' \
		*.alignments \
		*.asmcons \
		*.barriers \
		*.cfg \
		*.class \
		*.cplxlower0 \
		*.dfinish \
		*.dfinit \
		*.dwarf2 \
		*.eh \
		*.eh_ranges \
		*.ehcleanup2 \
		*.ehdisp \
		*.ehopt \
		*.einline \
		*.expand \
		*.final \
		*.gimple \
		*.gkd \
		*.gkd \
		*.inline_param1 \
		*.inline_param2 \
		*.into_cfglayout \
		*.ira \
		*.jump \
		*.jump2 \
		*.lower \
		*.mach \
		*.mode_sw \
		*.nothrow \
		*.omplower \
		*.optimized \
		*.original \
		*.outof_cfglayout \
		*.pro_and_epilogue \
		*.reginfo \
		*.release_ssa \
		*.reload \
		*.resx \
		*.shorten \
		*.split1 \
		*.split2 \
		*.ssa \
		*.stack \
		*.statistics \
		*.tu \
		*.veclower \
		*.vregs


run: all
	./'$(RUN)$(OUT_EXT)'
