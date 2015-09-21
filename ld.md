# ld

<https://sourceware.org/binutils/docs-2.25/ld/index.html>

Does the linking process, which converts object files into executables.

Basic usage:

    nasm -o hello_world.o hello_world.asm
    ld -o hello_world.out hello_world.o
    ./hello_world

## Order of libraries passed

The order matters for static libraries:

- <http://stackoverflow.com/questions/45135/why-does-the-order-in-which-libraries-are-linked-sometimes-cause-errors-in-gcc>

References undefined references of later libraries can only be resolved by the earlier ones.

### start-group

### end-group

Those weird options act on the `-l` libraries that appear in between them, e.g.:

    ld --start-group lib1 lib2 lib3 --end-group

With them, `ld` loops between the given libraries until all references have been resolved.

This has a performance impact.

## Standard library

If you program is compiled with `gcc`, it expects a few things from the linker which `ld` does not do by default: <http://stackoverflow.com/questions/3577922/how-to-link-a-gas-assembly-file-as-a-c-program-with-ld-without-using-gcc>

    ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
      /usr/lib/x86_64-linux-gnu/crt1.o \
      /usr/lib/x86_64-linux-gnu/crti.o \
      -lc hello_world.o \
      /usr/lib/x86_64-linux-gnu/crtn.o

## m

## Cross compile

<http://stackoverflow.com/questions/16004206/force-gnu-linker-to-generate-32-bit-elf-executables>

`-m <arch>`, where `<arch>` can be found with `ld -V`, sample output:

    elf_x86_64
    elf32_x86_64
    elf_i386
    i386linux
    elf_l1om
    elf_k1om
    i386pep
    i386pe

TODO meaning of each type?

## verbose

Print `ld` information, including the linker script used:

    ld --verbose

## e

Sets the ELF entry point to a given symbol or address.

This determines `e_entry` of the ELF header.

You can set it to any address, but keep in mind that sections have alignment constraints.

So for example if you something like:

    . = 0x4FFFFF;
    .text :
    {
        *(*)
    }

and the page size is 2M, then your executable will be about 2M in size:

- `.text` segment will go to `0x4FFFFF`
- all bytes up to `0x4FFFFE` will be filled with zeroes
- `e_entry` is set to `0x4FFFFF`

## Library and weak TODOs

- <http://stackoverflow.com/questions/24390267/why-redefinition-of-a-function-which-is-already-present-in-dynamic-or-static-lib>
- <http://stackoverflow.com/questions/13089166/how-to-make-gcc-link-strong-symbol-in-static-library-to-overwittren-weak-symbol>
