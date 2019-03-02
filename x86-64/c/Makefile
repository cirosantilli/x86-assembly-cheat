# TODO Dry this out with 32-bit code.

.POSIX:

IN_EXT ?= .c
OUT_EXT ?= .out
TMP_EXT ?= .o
RUN ?= hello_regvar

OUTS := $(patsubst %$(IN_EXT),%$(OUT_EXT),$(wildcard *$(IN_EXT)))

.PHONY: all clean run

all: $(OUTS)

%$(OUT_EXT): %$(IN_EXT)
	$(CC) -O3 -std=c99 -ggdb3 -Wall -Werror -pedantic -o '$@' '$<'

clean:
	rm -f *$(TMP_EXT) *$(OUT_EXT)

run: all
	./$(RUN)$(OUT_EXT)

test: all
	for f in *$(OUT_EXT); do echo $$f; ./$$f; done
