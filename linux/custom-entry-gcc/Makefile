.POSIX:
.PHONY: clean run

main.out: main.c
	gcc -nostartfiles -Wl,-etest -o '$@'  '$<'

clean:
	rm -f main.out

test: main.out
	./main.out
