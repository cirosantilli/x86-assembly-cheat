# Getting started

    sudo apt-get install build-essential gcc-multilib nasm

    # Choose an interesting directory.
    cd ia-32

    # Run all programs in the current directory.
    make test

    # Run cmp.asm.
    make run RUN=cmp

    # Run a default program, usually a main file or a hello world.
    make run

Since this is assembly, you need a compatible CPU to run most programs.

You can run 32-bit code in a 64-bit Linux machine, if it is compiled with `CONFIG_IA32_EMULATION`, which it is by most distros. Check if that is the case for you: <http://superuser.com/questions/287371/obtain-kernel-config-from-currently-running-linux-system>

If you don't have a compatible CPU, use the `Vagrantfile`s provided in each directory or your favorite virtualization method.

Tested on the latest Ubuntu LTS, but maximum portability is intended. Arch and OS specifics are clearly separated in sub-directories.
