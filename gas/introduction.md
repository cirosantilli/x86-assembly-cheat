# Introduction

GNU assembler syntax cheatsheet.

Supposes that you already know IA-32 and NASM.

Documentation: <https://sourceware.org/binutils/docs-2.25/as/> Many questions can be answered directly via the index: <https://sourceware.org/binutils/docs/as/index.html>

Used by the kernel, GCC and glibc... so just learn it.

Part of Binutils.

Advantages over NASM:

- can handle multiple architectures, not just x86, including ARM

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
