.PHONY: clean run

hello_world.out: hello_world.S
	as -o hello_world.o hello_world.S
	ld -o hello_world.out hello_world.o

clean:
	rm -f *.o *.out

run: hello_world.out
test: hello_world.out
	./hello_world.out
