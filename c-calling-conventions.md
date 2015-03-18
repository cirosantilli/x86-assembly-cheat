# C calling convention

ANSI C does not specify assembly level calling convention to be used by implementations nor means to control actual calling conventions.

Some compilers do however contain extensions that allow to fix a given calling convention.

GCC allows to specify calling convention explicitly as:

    void f ( int ) __attribute__ ((cdecl ));

where `cdecl` is the name of the calling convention.

As of 2013, [cdecl](cdecl.md) is widely used as default across many compilers.

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
