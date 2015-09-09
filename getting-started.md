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

Each directory contains code for a single architecture.

Note that you can run 32-bit code in a 64-bit Linux machine (if it is compiled to allow you, which it is by most distros).

If you don't have a compatible CPU, use the `Vagrantfile`s provied in each directory or your favorit virtualization method.
