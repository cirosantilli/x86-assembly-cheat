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

## Implementations

-   compilers, which will generate it.

    Sane compilers should use a separate standalone library. E.g., Binutils uses BFD (in-tree and canonical source).

-   operating systems, which will run it.

    Those obviously cannot link to a library nor use the C stlib, so they are more likely to implement it themselves. This is the case of the Linux kernel.

-   specialized libraries

    - <https://github.com/eliben/pyelftools>. By a hardcore Googler: <https://plus.google.com/+EliBenderskyGplus/posts>
    - <https://sourceforge.net/projects/elftoolchain/files/Documentation/libelf-by-example/>

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

[System V ABI AMD64][] says that `main` is the entry point of a C program, and it calls `_start`  which is the ELF entry point as mentioned in the [System V ABI AMD64][]. `main` is not special in pure assembly 

> The initial state of the process stack, i.e. when _start is called

<http://dbp-consulting.com/tutorials/debugging/linuxProgramStartup.html> describes the call sequence that actually happens on Linux.

TODO where is it mentioned in the arch agnostic standards?

## C++ ABI

The [System V ABI AMD64][] links to the [Itanium C++ ABI][].

## Relocation

<http://stackoverflow.com/questions/12122446/how-does-c-linking-work-in-practice/30507725#30507725>

### R_X86_64_PC32

This is another common relocation method that does:

    S + A - P

on 4 bytes, where `P` is the current position of the Program Counter on the text segment, thus the `PC` on the name, A.K.A. the `RIP` register.

This method is common in x86-64 because `RIP` relative addressing is very popular, and for it to work, the relocation must subtract the position `P`.

Note that `%RIP` points to the *next* instruction: so it is common to use `A = -4` to remove the offset of the 4 byte address which is at the end of the instruction encoding:

    X Y A A A A
    Next insruction <-- RIP

### Value of the relocated memory before relocation

Does the value of the address to be overwritten before linking matter at all?

### R_X86_64_16

### 8 and 16 bit

GNU adds 8 and 16 bit relocations as an extension to the ELF standard, which it calls with names like `R_X86_64_16`.

### Segment vs segment section

TODO: confirm: each program header represents either a segment, or a segment section, which is a subdivision of segments.

For instance, a C hello world contains the lines (order changed):

    LOAD           0x000000 0x0000000000400000 0x0000000000400000 0x0006fc 0x0006fc R E 0x200000
    PHDR           0x000040 0x0000000000400040 0x0000000000400040 0x0001f8 0x0001f8 R E 0x8
    INTERP         0x000238 0x0000000000400238 0x0000000000400238 0x00001c 0x00001c R   0x1
    NOTE           0x000254 0x0000000000400254 0x0000000000400254 0x000044 0x000044 R   0x4
    GNU_EH_FRAME   0x0005d0 0x00000000004005d0 0x00000000004005d0 0x000034 0x000034 R   0x4

so that the `LOAD` segment contains multiple segment sections `PHDR, INTERP, etc.`

## Alignment of global symbols

TODO what are the alignment constraints of global symbols? I observe that 4 byte relocations align at 4 *bits*... what is going on?
