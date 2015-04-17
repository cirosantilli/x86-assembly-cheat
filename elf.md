# ELF

<https://en.wikipedia.org/wiki/Executable_and_Linkable_Format>

Specifies format for object files (`.o`), shared object files (`.so`), executable files (no standard Linux extension) and core dumps.

Has versions for all major architectures.

Required by the LSB for all architectures, e.g. IA32 and AMD64: <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-IA32/LSB-Core-IA32/elf-ia32.html> <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-AMD64/LSB-Core-AMD64/elf-amd64.html>.

The LSB basically extends other standards, e.g. [System V ABI AMD64][] for x86-64.

Supersedes `.coff`, which supersedes `a.out`.

Its structure can be examined in a human readable way via utilities like `readelf` and `objdump`.

## C ABI

### _start

### Entry point

[System V ABI AMD64][] says that `main` is the entry point of a C program, and it calls `_start` [System V ABI AMD64][] which is the ELF entry point. `main` is not special in pure assembly.

<http://dbp-consulting.com/tutorials/debugging/linuxProgramStartup.html> describes the call sequence that actually happens on Linux.

## C++ ABI

The [System V ABI AMD64][] links to the [Itanium C++ ABI][].
