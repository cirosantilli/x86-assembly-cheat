.PHONY: clean run

main.out: main.asm
	nasm -f elf32 -w+all -o main.o main.asm
	gcc -o main.out main.o

clean:
	rm -f *.o *.out

run: main.out
	./main.out
