# Getting started

## You can run this even if you are on x86-64 Linux

x86-64 Linux is able to run IA-32 code out of the box if compiled with `CONFIG_IA32_EMULATION=y`, which is the default in any sane distro.

You only have to make sure that `gcc -m32 hello_world.c` compiles correctly.

The hard part is ensuring that the linker is able to find the 32-bit version of the glibc used by the driver: any GCC installation can do the compilation correctly. On Ubuntu, all you need to do is:

    sudo apt-get install gcc-multilib

See also:

- <http://stackoverflow.com/questions/22355436/how-to-compile-32-bit-apps-on-64-bit-ubuntu>
- <http://stackoverflow.com/questions/9807581/cannot-find-crtn-o-linking-32-bit-code-on-64-bit-system>

## Portability

Programs in this directory are OS-portable because of the C driver under [lib/](lib/)

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
