.POSIX:

main.out: main.asm link.ld
	nasm -felf64 -o main.o main.asm
	ld -Tlink.ld -o main.out main.o

clean:
	rm -f *.o *.out

test: main.out
	./main.out
