.PHONY: clean test

main.out: main.asm
	nasm -w+all -f elf32 -o main.o main.asm
	gcc -m32 -o main.out main.o

clean:
	rm -f *.o *.out

test: main.out
	./main.out
