# ELF

## Introduction

<https://en.wikipedia.org/wiki/Executable_and_Linkable_Format>

Specifies format for:

- object files (`.o`)
- shared object files (`.so`)
- archive files (`.a`)
- executable files (no standard Linux extension) and core dumps.

Supersedes `.coff`, which supersedes `a.out`.

Dominates in Linux. Competes with Mach-O for OS X and PE for Windows.

There is a common core for common for all architectures, but each architecture also has specific versions of it as well.

## Standards

ELF is specified by the LSB:

- core generic: <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-generic/LSB-Core-generic/elf-generic.html>
- core AMD64: <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-AMD64/LSB-Core-AMD64/book1.html>

The LSB basically links to other standards with minor extensions, in particular:

-   generic (both by SCO):

    - System V ABI 4.1 (1997) <http://www.sco.com/developers/devspecs/gabi41.pdf>, no 64 bit, although a magic number is reserved for it. Same for core files.
    - System V ABI Update DRAFT 17 (2003) <http://www.sco.com/developers/gabi/2003-12-17/contents.html>, adds 64 bit. Only updates chapters 4 and 5 of the previous document: the others remain valid and are still referenced.

-   architecture specific:

    - IA32:  <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-IA32/LSB-Core-IA32/elf-ia32.html>
    - AMD64: <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-AMD64/LSB-Core-AMD64/elf-amd64.html>, points mostly to <http://www.x86-64.org/documentation/abi.pdf>

The LSB basically extends other standards, e.g. [System V ABI AMD64][] for x86-64.

A handy summary can be found at:

    man elf

Its structure can be examined in a human readable way via utilities like `readelf` and `objdump`.

## Implementations

ELF has to be implemented by two types of system:

- compilers, which will generate it
- operating systems, which will run it

### Linux

Interesting files in v4.0:

- `include/uapi/linux/elf.h`: contains most of the format, which is natural since the format is needed from userland to implement compilers, and the most part if not arch dependent
- `include/linux/elf.h`
- `arch/x86/include/asm/elf.h`: x86 specifics described in the AMD64 ABI extension, e.g. the `R_X86_64_64` type
- `fs/binfmt_elf.c`: this is where the real action happens. `do_execve` from the system call calls `load_elf_binary`, which prepares everything and culminates in a call to `start_thread`

For instance under `include/uapi/linux/elf.h` we see the IA-32 ELF header `struct elf32_hdr` and  {
which is a direct copy paste form the System V ABI 4.1, and:

which is from the System V ABI Update DRAFT 17.

### GCC

In 5.1, definitions are under various `config/` files.

## C ABI

### _start

### Entry point

[System V ABI AMD64][] says that `main` is the entry point of a C program, and it calls `_start`  which is the ELF entry point as mentione in the [System V ABI AMD64][]. `main` is not special in pure assembly 

<http://dbp-consulting.com/tutorials/debugging/linuxProgramStartup.html> describes the call sequence that actually happens on Linux.

## C++ ABI

The [System V ABI AMD64][] links to the [Itanium C++ ABI][].
