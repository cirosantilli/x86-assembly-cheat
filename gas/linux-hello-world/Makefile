.PHONY: clean run

main.out: main.S
	as --32 -o main.o main.S
	ld -m elf_i386 -o main.out main.o

clean:
	rm -f *.o *.out

run: main.out
test: main.out
	./main.out
