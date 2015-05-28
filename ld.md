# ld TODO

<https://sourceware.org/binutils/docs-2.25/ld/index.html>

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

## Standard library

`ld` does not link to the standard library by default.

<http://stackoverflow.com/questions/3577922/how-to-link-a-gas-assembly-file-as-a-c-program-with-ld-without-using-gcc>

## Library and weak TODOs

- <http://stackoverflow.com/questions/24390267/why-redefinition-of-a-function-which-is-already-present-in-dynamic-or-static-lib>
- <http://stackoverflow.com/questions/13089166/how-to-make-gcc-link-strong-symbol-in-static-library-to-overwittren-weak-symbol>
