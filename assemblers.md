# Assemblers

Programs that transform text in computer code.

See also: [NASM](NASM).

## GAS

GNU assembler.

Executable name: `as`.

GCC backend. Point up to learning its syntax: allows you to to understand GCC generated code!

AT&T based syntax.

Outputs to lots of different architectures:

- i386
- SPARC
- ARM

and more.

NASM manual says it is inconvenient to write by hand, maybe because is is meant to be a GCC backend.

### GCC

GCC can be used as a frontend for GAS:

    gcc -S a.c -o a.s
    gcc -masm=att -S a.c -o a.s
    gcc -masm=intel -S a.c -o a.s

## MASM

Microsoft.

x86.

## TASM

Borland.

Stands for "turbo assembler". LOL, why not "BASM" instead?

Windows only.
