.PHONY: clean run

main.out: main.s
	as -o main.o main.s
	ld -o main.out -s main.o

clean:
	rm -f *.o *.out

run: main.out
	./main.out
