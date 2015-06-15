.PHONY: clean run

main.out: main.asm
	nasm -w+all -f elf32 -o main.o main.asm
	# -dynamic-linker is put into the .interp section
	ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -o main.out -lc main.o

clean:
	rm -f *.o *.out

run: main.out
	./main.out
