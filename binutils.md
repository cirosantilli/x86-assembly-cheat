# binutils

GNU set of utilities to compile and view and modify compiled code.

Official site: <http://sourceware.org/binutils/>.

As stated there, the two main utilities are `ld`, the GNU linker, and `as` the gnu assembler.

Binutils is a dependency of GCC: GCC deals with the high level to assembler source translation, and Binutils does the rest.

Also contains GDB.

## Makefile

    sudo apt-get build-dep gdb
    mkdir binutils-gdb
    cd binutils-gdb
    git clone git://sourceware.org/git/binutils-gdb.git src
    cd src
    git checkout binutils-2_25
    cd ..
    mkdir build
    cd build
    ../src/configure --with-sysroot=/ --prefix="$(pwd)/../install"
    time make -j5
    make install

Try it out on Linux:

    cd ../install/bin

    cat <<EOF >main.S
    .data
        s:
            .ascii "Hello world!\n"
            len = . - s
    .text
        .global _start
        _start:
            movl $4, %eax
            movl $1, %ebx
            movl $s, %ecx
            movl $len, %edx
            int $0x80
            movl $1, %eax
            movl $0, %ebx
            int $0x80
    EOF
    ./as -o main.o main.S
    ./ld -o main.out main.o
    ./main.out

Took 3 minutes in a 2013 computer.

Why `--with-sysroot` is needed <https://sourceware.org/ml/binutils/2007-02/msg00274.html>. Why not make it the default?!

## Source tree

-   `gas`: assembler

-   `ld`: linker

-   `gold`: new faster linker by Google

-   `gdb`: GDB

-   `bfd`: Binary File Descriptor?

    Contains a generic model that supports multiple output formats: ELF, Mach-O, PE, etc.

    Used by most utilities.

-   `opcodes`: low-level CPU instruction descriptions.

    Key to assembly and disassembly, used by many utilities.

### GAS

Source tree:

- `read.c`: the main parser

Vocabulary:

-   `po`: Pseudo-op, same as assembly directive, e.g. `.macro`.

-   `poc`: Pseudo-op Code

-   `TC`: TODO? Tool Chain? E.g. `TC_START_LABEL` in `read.c`, `config/tc-XXX` for different architectures.

-   `md`: Machine Description. Each one is encoded in a files under `config/` that encode the binary representation of structures.

    Many identifiers also get this prefix.

GAS compiles for many targets (arch + container), which have many (often unstandardized) syntaxes. The parsing is well-factored however. For this reason, make sure to specify your target whenever considering a concept. E.g., even things like the line-comment character, and the case sensitivity directives may change across architectures, 
