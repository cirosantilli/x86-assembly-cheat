.PHONY: clean test

main.out: main.asm
	nasm -w+all -f elf32 -o main.o main.asm
	# -dynamic-linker is put into the .interp section
	# so that the stdlib can be found.
	#
	# gcc would fail here because it requires a `main` method
	# which is called from crt1.o
	ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -o main.out -lc main.o

clean:
	rm -f *.o *.out

test: main.out
	./main.out
