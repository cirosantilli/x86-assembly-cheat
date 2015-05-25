CC := gcc -pedantic-errors -std=c89 -Wall

.PHONY: all clean run

all: maina.out mainso.out mainso_fullpath.out libab.so

run: maina.out mainso.out mainso_fullpath.out
	./maina.out
	./mainso.out
	./mainso_fullpath.out

install:
	#sudo mv libabso /some/where/in/ld/path/
		#load path can be found with:
		#ldconfig -v 2>/dev/null | grep -v $'^\t'
	#sudo ldconfig

# Main to link to .so
#
# readout -d shows that the ouptut stores the relative path
#
mainso.out: main.o libab.so
	@# Will look for lib with basename *exactly* `libab.so`,
	@# `libab.so.1` will not do!
	$(CC) -L'.' main.o -o mainso.out -lab
	@# With ':' uses full basename.
	@# Application: select an specific version such as `libab.so.1`
	@#$(CC) -L"." main.o -o mainso.out -l:libab.so
	@#env LIBRARY_PATH=$LIBRARY_PATH:. $(CC) main.c -o mainso.out -lab

# This is not recommended.
#
# Better use linker path as in mainso.out.
#
# readout -d shows that the ouptut stores the full path.
#
mainso_fullpath.out: main.o libab.so
	$(CC) main.o '$(shell printf "`pwd`/libab.so")' -o mainso_fullpath.out
	@# Does not work
	@#$(CC) main.o -o mainso_fullpath.out -l"$(shell realpath libab.so)"

maina.out: main.o ab.a
	$(CC) main.o ab.a -o maina.out

libab.so: a.o b.o
	$(CC) -shared a.o b.o -o libab.so
	@#$(CC) -shared -Wl,-soname,libab.so a.o b.o -o libab.so

ab.a: a.o b.o
	ar rcs ab.a a.o b.o

%.o: %.c
	$(CC) -fPIC -c '$<' -o '$@'

clean:
	rm -rf *.o *.a *.so *.out
