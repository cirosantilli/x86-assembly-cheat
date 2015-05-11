# Calling convention

<https://en.wikipedia.org/wiki/X86_calling_conventions>

The calling convention specifies how exactly function call and return are implemented in assembly.

## C calling conventions

ANSI C does not specify assembly level calling convention to be used by implementations nor means to control actual calling conventions.

Some compilers do however contain extensions that allow to fix a given calling convention.

GCC allows to specify calling convention explicitly as:

    void f (int i) __attribute__ ((cdecl));

where `cdecl` is the name of the calling convention.

In IA32, [cdecl](cdecl.md) is the most popular in Linux, and stdcall the most popular in Windows, but there exist many others.

## x86-64 calling conventions

In x86-64, the number of calling conventions was greatly reduced.

### System V AMD64 ABI

[System V AMD64 ABI][] dominating in Linux and other UNIX systems.

Uses CPU registers for the first 6 parameters, XMM if floating point, and the following on stack, thus much faster! This was made possible by the large amount of CPU registers added.

XMM passing is possible because SSE and SSE2 are part of the x86-64 core.

Register order is: RDI, RSI, RDX, RCX, R8, and R9

For system calls, R10 is used instead of RCX.

### Microsoft x64

Obviously they could not be compatible with the rest.

Microsoft x64 calling convention and its 2013 extension `__vectorcall` for Windows,

## Call C function form assembly

TODO link to example code.

To call a C function from assembly you need to:

-   use the correct C calling convention to which the C code compiled to.

    Remember that ANSI C does not specify this.

-   use the correct naming convention of the libraries you want to link to.

    For example, `exit` may be called `_exit` on certain compilers such as GCC elf format.

    This is not specified by ANSI C, so the only portable alternative is via macros.

-   declare the function you want to call as extern.

    NASM for example has the `extern` directive.

-   compile into an object file and then compile that object file with the C object files.

    For example with nasm:

        nasm -o a.o a.asm
        gcc -c c.c -o c.o
        gcc -o main a.o c.o

    You can also call stdlib functions if you want, since GCC links to them for you.
