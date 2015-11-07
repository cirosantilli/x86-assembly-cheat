.POSIX:

-include params.makefile

BITS ?= 32
CCC ?= gcc -ggdb3 -m$(BITS) -O0 -pedantic-errors -std=c89 -Wall
CCC_FLAGS ?=
GAS_EXT ?= .S
LIB_DIR ?= lib/
NASM ?= nasm -g -w+all -f elf$(BITS)
NASM_EXT ?= .asm
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN ?= main
TEST ?= test
export

OUTS := $(foreach IN_EXT,$(GAS_EXT) $(NASM_EXT),$(patsubst %$(IN_EXT),%$(OUT_EXT),$(wildcard *$(IN_EXT))))

.PRECIOUS: %$(OBJ_EXT)
.PHONY: all clean driver run

all: driver $(OUTS)

%$(OUT_EXT): %$(OBJ_EXT)
	$(CCC) $(CCC_FLAGS) -o '$@' '$<' $(LIB_DIR)*$(OBJ_EXT)

%$(OBJ_EXT): %$(NASM_EXT)
	$(NASM) -o '$@' '$<'

%$(OBJ_EXT): %$(GAS_EXT)
	$(CCC) $(CCC_FLAGS) -c -o '$@' '$<'

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)
	$(MAKE) -C $(LIB_DIR) '$@'

driver:
	$(MAKE) -C $(LIB_DIR)

run: all
	./'$(RUN)$(OUT_EXT)'

test: all
	@\
	if [ -x $(TEST) ]; then \
	  ./$(TEST) '$(OUT_EXT)' ;\
	else\
	  fail=false ;\
	  for t in *"$(OUT_EXT)"; do\
	    if ! ./"$$t"; then \
	      fail=true ;\
	      break ;\
	    fi ;\
	  done ;\
	  if $$fail; then \
	    echo "TEST FAILED: $$t" ;\
	    exit 1 ;\
	  else \
	    echo 'ALL TESTS PASSED' ;\
	    exit 0 ;\
	  fi ;\
	fi ;\
