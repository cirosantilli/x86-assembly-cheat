# Bare metal

Running programs without an operating system.

-   <https://github.com/programble/bare-metal-tetris> tested on Ubuntu 14.04. Just works.

    Has Multiboot and ElTorito. Uses custom linker script.

    Almost entirely in C `-nostdlib`, with very few inline `asm` commands, and a small assembly entry point. So a good tutorial in how to do the bridge.

-   <https://github.com/scanlime/metalkit> A more automated / general bare metal compilation system.

Did not work well:

- <https://github.com/apparentlymart/ToyOS>
- <https://github.com/rde1024/toyos>
