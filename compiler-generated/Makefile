.PHONY: clean run

main.out: main.c
	gcc -pedantic-errors -std=c89 -o '$@' -Wall '$<'

clean:
	rm -f main.out

run: main.out
	./'$<'
