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
		*.alias \
		*.alignments \
		*.asmcons \
		*.barriers \
		*.bbro \
		*.bswap \
		*.ccp1 \
		*.ccp2 \
		*.ccp3 \
		*.cdce \
		*.cddce1 \
		*.cddce2 \
		*.ce1 \
		*.ce2 \
		*.ce3 \
		*.cfg \
		*.ch \
		*.class \
		*.combine \
		*.compgotos \
		*.copyprop1 \
		*.copyprop2 \
		*.copyprop3 \
		*.copyprop4 \
		*.copyprop5 \
		*.copyrename1 \
		*.copyrename2 \
		*.copyrename3 \
		*.copyrename4 \
		*.cplxlower0 \
		*.cplxlower1 \
		*.cprop1 \
		*.cprop2 \
		*.cprop3 \
		*.cprop_hardreg \
		*.crited1 \
		*.csa \
		*.cse_local \
		*.cse1 \
		*.cse2 \
		*.cselim \
		*.cunroll \
		*.cunrolli \
		*.dce1 \
		*.dce2 \
		*.dceloop1 \
		*.dceloop3 \
		*.dfinish \
		*.dfinit \
		*.dom1 \
		*.dom2 \
		*.dse1 \
		*.dse2 \
		*.dwarf2 \
		*.ealias \
		*.early_optimizations \
		*.eh \
		*.eh_ranges \
		*.ehcleanup2 \
		*.ehdisp \
		*.ehopt \
		*.einline \
		*.eipa_sra \
		*.esra \
		*.expand \
		*.fab1 \
		*.final \
		*.fnsplit \
		*.forwprop1 \
		*.forwprop2 \
		*.forwprop3 \
		*.forwprop4 \
		*.fre1 \
		*.fre2 \
		*.fwprop1 \
		*.fwprop2 \
		*.gcse2 \
		*.gimple \
		*.gkd \
		*.ifcombine \
		*.ifcvt \
		*.init-regs \
		*.inline_param1 \
		*.inline_param2 \
		*.into_cfglayout \
		*.ira \
		*.ivcanon \
		*.ivopts \
		*.jump \
		*.jump2 \
		*.ldist \
		*.lim1 \
		*.lim3 \
		*.local-pure-const1 \
		*.local-pure-const2 \
		*.loop \
		*.loop2 \
		*.loop2_done \
		*.loop2_init \
		*.loop2_invariant \
		*.loop2_unswitch \
		*.loopdone \
		*.loopinit \
		*.lower \
		*.mach \
		*.mergephi1 \
		*.mergephi2 \
		*.mode_sw \
		*.nothrow \
		*.nrv \
		*.objsz1 \
		*.omplower \
		*.optimized \
		*.original \
		*.outof_cfglayout \
		*.pcom \
		*.peephole2 \
		*.phicprop1 \
		*.phicprop2 \
		*.phiopt1 \
		*.phiopt2 \
		*.phiopt3 \
		*.phiprop \
		*.postreload \
		*.pre \
		*.pro_and_epilogue \
		*.profile_estimate \
		*.reassoc1 \
		*.reassoc2 \
		*.ree \
		*.reginfo \
		*.regmove \
		*.release_ssa \
		*.reload \
		*.resx \
		*.retslot \
		*.rtl_dce \
		*.sccp \
		*.sched2 \
		*.shorten \
		*.sincos \
		*.sink \
		*.slp \
		*.slsr \
		*.split1 \
		*.split2 \
		*.split4 \
		*.sra \
		*.ssa \
		*.stack \
		*.statistics \
		*.strlen \
		*.subreg1 \
		*.subreg2 \
		*.switchconv \
		*.tailc \
		*.tailr1 \
		*.tailr2 \
		*.tu \
		*.ud_dce \
		*.uncprop1 \
		*.uninit1 \
		*.unswitch \
		*.vartrack \
		*.veclower \
		*.veclower21 \
		*.vect \
		*.vregs \
		*.vrp1 \
		*.vrp2 \
		*.widening_mul

run: all
	./'$(RUN)$(OUT_EXT)'
