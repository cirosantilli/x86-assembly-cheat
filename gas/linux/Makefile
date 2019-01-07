.PHONY: clean run

hello_world.out: hello_world.S
	as --32 -o hello_world.o hello_world.S
	ld -m elf_i386 -o hello_world.out hello_world.o

clean:
	rm -f *.o *.out

run: hello_world.out
test: hello_world.out
	./hello_world.out
