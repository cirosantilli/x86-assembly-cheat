# Getting started

## Ubuntu 18.04 quick start

    sudo apt-get install build-essential gcc-multilib nasm

Build all:

    make

Run one program:

    ./add.out
    echo $?

All programs should return `0`, otherwise it means that they failed.

Build and run just one program:

    make run-add

Build and run all programs and check if any of them failed:

    make test

If all goes well, the last line of stdout will be:

    ALL TESTS PASSED

and the exit status is `0`:

    echo $?

You will see some `ALL TESTS PASSED` before the last one: these are for the subdirectories, e.g. [x86_64/](x86_64/). If `ALL TESTS PASSED` is the last line however, it means that all asserts in all subdirectories also passed as well as the ones in the current directory.

## Assertions

One distinctive feature of this tutorial is that we have assertions.

To try them out, edit a test to make an assertion fail and see it blow up.

E.g., modify [add.asm](add.asm) to contain:

    mov eax, 1
    add eax, 2
    ASSERT_EQ eax, 4

and run:

    make
    ./add.out
    echo $?

It will now say that a test failed:

    ASSERT FAILED AT LINE:
    9

and the exit status will be `1`, because usually `1 + 2` equals `3` and not `4`.

## GDB step debug

Step debug `add.out`:

    make gdb-add

This stops at `asm_main`, which is placed at the beginning of the `ENTRY` macro, which we use on almost all our programs, and shows both the assembly and source code with `layout asm`: https://stackoverflow.com/questions/9970636/view-both-assembly-and-c-code

`asm_main` is not the first instruction of our executable, since we use a C driver under [lib](lib/) to access standard library functions: the true first instruction will be on some glibc wrapper code that enables glibc functionality. But we don't care about those for the most part.

Step the assembly source just like a C program with either of:

    n
    s
    ni
    si

`s` and `si` can be different for example if a line contains a macro:

* `s` would step over all instructions of the macro
* `si` goes inside instructions of the macro

### GDB step debug show src, asm and regs

It is also possible to show a register window inside GDB TUI:

    layout regs

but it replaces either the source or disassembly, whichever is selected. It does not seem possible to view all of source, disassembly and registers.

This can be done however with Python extensions, and I highly recommend [GDB dashboard](https://github.com/cyrus-and/gdb-dashboard) with:

    dashboard -layout source assembly registers stack
    dashboard source -style context 8
    dashboard assembly -style context 8

which also shows which assembly instructions correspond to the current source line, awesome.

`make gdb-*` disables `.gdbinit` by default, to use it do:

    make gdb2-add

Other good alternatives to GDB dashboard are mentioned at:

- https://stackoverflow.com/questions/209534/how-to-highlight-and-color-gdb-output-during-interactive-debugging
- https://stackoverflow.com/questions/10115540/gdb-split-view-with-code/51301717

### GDB step debug freestanding programs

Freestanding programs are those that don't rely on the C standard library.

There aren't many in this repository since they are not OS-portable, but one example is [linux/hello_world.asm](linux/hello_world.asm) which does syscalls directly.

Those examples don't necessarily have the `asm_main` symbol on which `make gdb-X` relies.

Instead, you will want to use `starti` with them to start from the very first executed instruction:

	gdb --nh -ex 'layout src' -ex 'layout regs' -ex 'starti' 'hello_world.out'

Bibliography: https://stackoverflow.com/questions/10483544/stopping-at-the-first-machine-code-instruction-in-gdb

## Pre-requisites

What you need to be able to run examples in this tutorial:

-   an x86 processor or emulator, 32 or 64-bit. We provide a [Vagrantfile](Vagrantfile).

    Beware that the virtual machine provided by [Vagrantfile](Vagrantfile) may have less features than your own CPU. Check `cat /proc/cpuinfo` inside the VM.

-   common GNU/Linux build tools: `make`, `gcc`, `nasm`, Binutils (`as`, `ld`).

-   OS: most programs should work on any OS, including Linux, Windows and Mac, because we use the C standard library libc instead of direct system calls for IO via [lib/](lib/).

    However, I have only tested them on Ubuntu, which likely means that you will need to do a little bit of work to get them working elsewhere.

    If you do to get the examples working on another OS, please send a patch documenting the installation and patching whatever was needed.

    Porting will likely mean:

    - installing the required assemblers / compilers
    - getting make or rewriting our trivial build script into something more portable like Python
    - possibly messing around with a few calling conventions to the stdlib

    Architecture and OS specifics are clearly separated in sub-directories. E.g., Linux-only programs will be put into the [linux](linux/) directory.

### 64-bit CPUs can run this

x86-64 is a backwards compatible extension of IA-32, and has a mode which emulates IA-32.

x86-64 Linux is able to run IA-32 code out of the box using the hardware backwards compatibility if compiled with `CONFIG_IA32_EMULATION=y`, which is the default in any sane distro.

You only have to make sure that `gcc -m32 hello_world.c` compiles correctly.

The hard part is ensuring that the linker is able to find the 32-bit version of the glibc used by the driver: any GCC installation can do the compilation correctly. On Ubuntu, all you need to do is:

    sudo apt-get install gcc-multilib

See also:

- <http://stackoverflow.com/questions/22355436/how-to-compile-32-bit-apps-on-64-bit-ubuntu>
- <http://stackoverflow.com/questions/9807581/cannot-find-crtn-o-linking-32-bit-code-on-64-bit-system>

If you don't have a compatible CPU, use the `Vagrantfile`s provided in each directory or your favorite virtualization method.
