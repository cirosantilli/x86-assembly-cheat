.PHONY: clean test

main.out: main.asm
	nasm -w+all -f elf32 -o main.o main.asm
	# -nostartfiles is the key here, or else we will have two _start symbols:
	# one on main.asm, and another on crt1.o.
	gcc -nostartfiles -m32 -o main.out main.o

clean:
	rm -f *.o *.out

test: main.out
	./main.out
