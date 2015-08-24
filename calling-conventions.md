# Calling convention

<https://en.wikipedia.org/wiki/X86_calling_conventions>

The calling convention specifies how exactly function call and return are implemented in assembly.

## C calling conventions

ANSI C does not specify assembly level calling convention to be used by implementations nor means to control actual calling conventions.

Some compilers do however contain extensions that allow to fix a given calling convention.

GCC allows to specify calling convention explicitly as:

    void f (int i) __attribute__ ((cdecl));

where `cdecl` is the name of the calling convention.

In IA32, cdecl is the most popular in Linux, and stdcall the most popular in Windows, but there exist many others.

## Call C function from assembly

To call a C function from assembly you need to:

-   use the correct C calling convention to which the C code compiled to.

    Remember that ANSI C does not specify this.

-   use the correct naming convention of the libraries you want to link to.

    For example, `exit` may be called `_exit` on certain compilers such as GCC elf format.

    This is not specified by ANSI C, so the only portable alternative is via macros.
