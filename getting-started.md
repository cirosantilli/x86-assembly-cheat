# Getting started

    sudo apt-get install build-essential gcc-multilib nasm

    # Run all programs in the current directory.
    make test

    # Run cmp.asm.
    make run RUN=cmp

    # Run a default program, usually a main file or a hello world.
    make run

Since this is assembly, you need a compatible CPU to run most programs.

Tested on the latest Ubuntu LTS, but maximum portability is intended. Arch and OS specifics are clearly separated in sub-directories.

## You can run this even if you are on x86-64 Linux

x86-64 Linux is able to run IA-32 code out of the box if compiled with `CONFIG_IA32_EMULATION=y`, which is the default in any sane distro.

You only have to make sure that `gcc -m32 hello_world.c` compiles correctly.

The hard part is ensuring that the linker is able to find the 32-bit version of the glibc used by the driver: any GCC installation can do the compilation correctly. On Ubuntu, all you need to do is:

    sudo apt-get install gcc-multilib

See also:

- <http://stackoverflow.com/questions/22355436/how-to-compile-32-bit-apps-on-64-bit-ubuntu>
- <http://stackoverflow.com/questions/9807581/cannot-find-crtn-o-linking-32-bit-code-on-64-bit-system>

If you don't have a compatible CPU, use the `Vagrantfile`s provided in each directory or your favorite virtualization method.

## Portability

Whenever possible, programs are made OS-portable by using the C driver under [lib/](lib/)

It uses your C standard library to make the right system calls to whatever OS you use.

If we assume a single OS, then simpler examples can be produced with direct system calls, e.g. [linux/](linux/)

Beware that the virtual machine provided by [Vagrantfile](Vagrantfile) may have less features than you actual CPU. Check `cat /proc/cpuinfo` inside the VM.

## Concepts that require OS privilege

Concepts that require OS privileges (ring 0) will not be explained here.

Those include:

-   instructions like:
    - `cli` and `sti`
    - `hlt`
    - `inb`
    - `outb`
-   special registers like: `ds`, `cs`, `ss`

Those concepts cannot be tried out while an OS is running without disrupting the OS.

They might be explained at: <https://github.com/cirosantilli/x86-bare-metal-examples>
