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
