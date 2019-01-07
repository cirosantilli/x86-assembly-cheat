# Linux

## Introduction

Linux-specific IA-32 examples without external libraries like libc.

Use a libc for OS-portable code instead.

You can also compile and run this in Linux x64-64, which is able to run 32-bit. TODO: check that. Seems to work.

This probably works because Linux x86-64 uses compatibility mode to run the instructions, and the old IA-32 `int0x80` system calls work directly on `x86-64`.

When using external libraries like libc, you also have to take care to link to the right version of the library.

## System calls

We mostly use `int 0x80` system calls here for their simplicity.

However, the best way to do system calls in IA-32 Linux is through `sysenter` as it is faster. But user applications don't use `sysenter` directly, but rather `VDSO` should be used.

## VDSO

## vsyscall

The kernel just maps and maintains a magic memory area to every process which contains fast versions of certain functions.

<http://stackoverflow.com/questions/19938324/what-are-vdso-and-vsyscall>
