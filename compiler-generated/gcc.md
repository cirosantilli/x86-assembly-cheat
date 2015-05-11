# GCC

## Optimizations

Without any flags, GCC will do several minor optimizations that make the code hard to read for beginners. Don't be afraid :-)

Common ones:

- `lea`: `add` and `mov`
- `xor eax, eax`: `mov $0`
- function inlining
- RIP addressing as it is shorter

## Label names

### .L

GCC uses the `.L` for all local labels.

Those labels will not be made visible symbols on the compiled output by default as mentioned at: <https://sourceware.org/binutils/docs-2.18/as/Symbol-Names.html>

> A local symbol is any symbol beginning with certain local label prefixes. By default, the local label prefix is `.L' for ELF systems

> Local symbols are defined and used within the assembler, but they are normally not saved in object files. Thus, they are not visible when debugging. You may use the `-L' option (see Include Local Symbols: -L) to retain the local symbols in the object files. 

This seems to be a GCC toolchain convention, not an ELF ABI.

There are also options that manage it like:

- `man as` `--keep-locals`
- `man ld` `--discard-all`

### Suffixes

- `C`: Constant or `.comm` for [common symbol](https://sourceware.org/binutils/docs-2.18/as/Comm.html#Comm)? Used for data and BSS strings.
- `FB`: Function Begin. TODO why do we need this since we already have the function label that points to the same address?
- `FE`: Function End. TODO why is this ever needed?
- `BB`:
- `BE`:
