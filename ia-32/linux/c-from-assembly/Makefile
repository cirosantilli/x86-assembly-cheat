.PHONY: clean run

main.out: main.asm
	nasm -w+all -f elf32 -o main.o main.asm
	gcc -m32 -std=c89 -pedantic-errors -o main.out main.o

clean:
	rm -f *.o *.out

run: main.out
	./main.out
