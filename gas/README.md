# Introduction

## Why this tutorial uses NASM

I started this tutorial a long time ago, and I made the mistake of using `nasm` for it by default.

`gas` is the GNU assembler, backend to GCC, and used in the Linux kernel and glibc, and therefore the only true assembler.

Oh, also it is cross ISA, in the sense that most of its directives can be used on all ISA, which is awesome.

Just pipe it through GCC's C preprocessor to gain some missing functionality that `nasm` provides natively, and we are golden.

## Actual intro to GAS

GNU assembler syntax cheatsheet.

Part of the GNU Binutils projects, which also includes other lower-level toolchain tools like `ld` (but not `gcc`).

Supposes that you already know IA-32 and NASM.

Documentation: <https://sourceware.org/binutils/docs-2.25/as/> Many questions can be answered directly via the index: <https://sourceware.org/binutils/docs/as/index.html>

Executable name: `as`.

Used by the kernel, GCC default backend and glibc... so just learn it.

Part of Binutils.

## Vs NASM

Advantages over NASM:

-   can handle multiple architectures, not just x86, including:

    - i386
    - SPARC
    - ARM

    and more.

-   NASM is slightly more convenient to write by hand, maybe because it is more focused as a direct input language, rather than a GCC backend.

But given the huge Linux support for GAS, it is my preferred assembler.

### GCC as a GAS front-end

GCC can be used as a frontend for GAS:

    gcc -S a.c -o a.s
    gcc -masm=att -S a.c -o a.s
    gcc -masm=intel -S a.c -o a.s

## Comments

Multiline comments are like C comments.

Single line comments vary with language.

For x86, they are `# ` and **not** `;`!

## Registers

Registers are prefixed by a percent sign `%`. E.g.:

    movl %eax, %ebx

## Integer constants

Constants are prefixed by a dollar sign `$`. E.g.:

    movl $1, %eax

## Order

Operator order is different from Intel syntax.

For example, the following moves `eax` to `ebx`:

    movl %eax %ebx

Which is kind of logical because it is in the order in which we say it: `move eax to ebx` however is different from the usual c `=` operator which would be something like

    ebx = eax

## Instruction lengths

Suffixes are added to instructions to specify length:

- `b` = byte (8 bit)
- `s` = short (16 bit integer) or single (32-bit floating point)
- `w` = word (16 bit)
- `l` = long (32 bit integer or 64-bit floating point)
- `q` = quad (64 bit)
- `dq` = double quad (128 bit)
- `t` = ten bytes (80-bit floating point)

These are separate words in NASM. TODO can those be specified in macros? in NASM yes because they are separate words

If you add two suffixes to an instruction, it means that it should zero extend, e.g.: `movbl`.

In Intel, it is called `MOVSX`.

## Directives

Stuff that starts with a dot `.` and does not specify machine instructions directly but rather gives information to GAS.

- `.text`: text segment
- `.data`: data segment
- `.global`: data segment
- `.globl`: same as global
- `.loc`: debugging source line info, only generated with `-dgdb`
- `.align`:
- `.zero`:
- `.macro`: macros

### cfi directives

Call frame information.

Appear all over GCC generated code for C sources.

<http://stackoverflow.com/questions/2529185/what-are-cfi-directives-in-gnu-assembler-gas-used-for>
