# Getting started

## Ubuntu 14.04 quick start

    sudo apt-get install build-essential gcc-multilib nasm

    # Run all programs in the current directory.
    make test

    # Run cmp.asm.
    make run RUN=cmp

    # Run a default program, usually a main file or a hello world.
    make run

## Pre-requisites

-   an x86 processor or emulator, 32 or 64-bit. We provide a [Vagrantfile](Vagrantfile).

    Beware that the virtual machine provided by [Vagrantfile](Vagrantfile) may have less features than your own CPU. Check `cat /proc/cpuinfo` inside the VM.

-   common GNU/Linux build tools: `make`, `gcc`, `nasm`, Binutils (`as`, `ld`).

-   OS: most programs will work on Linux, Windows and Mac if you install the Linux build tools on them, because we use C instead of direct system calls for IO via [lib/](lib/).

    The main test environment is the latest 64-bit Ubuntu LTS, but maximum portability is intended.

    Architecture and OS specifics are clearly separated in sub-directories. E.g., Linux-only programs will be put into the [linux](linux/) directory.

## Assertions

One distinctive feature of this tutorial is that we have assertions.

So edit a test to make it fail and see it blow up. E.g., modify [add.asm](add.asm) to contain:

    mov eax, 0
    add eax, 1
    ASSERT_EQ 2

and run:

    make test

It will now say that a test failed, because usually:

    0 + 1 != 2

## 64-bit CPUs can run this

x86-64 is a backwards compatible extension of IA-32, and has a mode which emulates IA-32.

x86-64 Linux is able to run IA-32 code out of the box using the hardware backwards compatibility if compiled with `CONFIG_IA32_EMULATION=y`, which is the default in any sane distro.

You only have to make sure that `gcc -m32 hello_world.c` compiles correctly.

The hard part is ensuring that the linker is able to find the 32-bit version of the glibc used by the driver: any GCC installation can do the compilation correctly. On Ubuntu, all you need to do is:

    sudo apt-get install gcc-multilib

See also:

- <http://stackoverflow.com/questions/22355436/how-to-compile-32-bit-apps-on-64-bit-ubuntu>
- <http://stackoverflow.com/questions/9807581/cannot-find-crtn-o-linking-32-bit-code-on-64-bit-system>

If you don't have a compatible CPU, use the `Vagrantfile`s provided in each directory or your favorite virtualization method.
