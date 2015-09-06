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

    - IA-32:  <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-IA32/LSB-Core-IA32/elf-ia32.html>, points mostly to <http://www.sco.com/developers/devspecs/abi386-4.pdf>
    - AMD64: <http://refspecs.linuxfoundation.org/LSB_4.1.0/LSB-Core-AMD64/LSB-Core-AMD64/elf-amd64.html>, points mostly to <http://www.x86-64.org/documentation/abi.pdf>

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
- `fs/binfmt_elf.c`: this is where the real action happens. `do_execve` in `src/fs/exec.c` from the system call calls `load_elf_binary`, which prepares everything and culminates in a call to `start_thread`

### GCC

In 5.1, definitions are under various `config/` files.

## C ABI

### _start

### Entry point

[System V ABI AMD64][] says that `main` is the entry point of a C program, and it calls `_start`  which is the ELF entry point as mentione in the [System V ABI AMD64][]. `main` is not special in pure assembly 

<http://dbp-consulting.com/tutorials/debugging/linuxProgramStartup.html> describes the call sequence that actually happens on Linux.

## C++ ABI

The [System V ABI AMD64][] links to the [Itanium C++ ABI][].

## Relocation

<http://stackoverflow.com/questions/12122446/how-does-c-linking-work-in-practice/30507725#30507725>

### R_X86_64_16

### R_X86_64_PC32

This is another common relocation method that does:

    S + A - P

on 4 bytes, where `P` is the current position of the Program Counter on the text segment, thus the `PC` on the name, A.K.A. the `RIP` register.

This method is common in x86-64 because `RIP` relative addressing is very popular, and for it to work, the relocation must subtract the position `P`.

Note that `%RIP` points to the *next* instruction: so it is common to use `A = -4` to remove the offset of the 4 byte address which is at the end of the instruction encoding:

    X Y A A A A
    Next insruction <-- RIP

### Value of the relocated memory before relocation

Does the value of the address to be overwriten before linking matter at all?

### 8 and 16 bit

GNU adds 8 and 16 bit relocations as an extension to the ELF extandard, which it calls with names like `R_X86_64_16`.
