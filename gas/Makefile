.POSIX:

CCC ?= gcc -ggdb3 -m32 -O0 -std=c89 -pedantic-errors -Wall
GAS ?= as --32 -g
IN_EXT := .S
LIB_DIR ?= lib/
LN ?= ld -s
NASM ?= nasm -w+all -f elf32
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN ?= main
TEST ?= test
export

INS := $(wildcard *$(IN_EXT))
OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(INS))

.PRECIOUS: %$(OBJ_EXT)
.PHONY: all clean driver

all: driver $(OUTS)

%$(OUT_EXT): %$(OBJ_EXT)
	$(CCC) -o '$@' '$<' $(LIB_DIR)*$(OBJ_EXT)

%$(OBJ_EXT): %$(IN_EXT)
	$(CCC) -c '$<'

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)
	$(MAKE) -C $(LIB_DIR) '$@'

driver:
	$(MAKE) -C $(LIB_DIR)

run: all
	./'$(RUN)$(OUT_EXT)'

test: all
	@\
	if [ -x $(TEST)  ]; then \
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
