# Bare metal

# Bare bones

1. [min-printf](min-printf)
1. [min](min.S)

Running programs without an operating system.

<http://stackoverflow.com/questions/22054578/run-a-program-without-an-operating-system>

This requires you to create:

- a hard disk that the BIOS / UEFI can read like a boot sector
- some higher level format that gets called by a tool that talks for the BIOS for you. E.g.: a Multiboot ELF for GRUB. Use `grub-mkrescue` to make a multiboot file into a bootable disk.

You cannot of course use any libraries when doing so, so you will have to face the problem of how to deal with low-level IO. Some ways that this can be done:

- BIOS functions: <http://wiki.osdev.org/BIOS>. Not well standardized like it's successor UEFI.
- <https://en.wikipedia.org/wiki/VGA-compatible_text_mode>
- VBE <https://en.wikipedia.org/wiki/VESA_BIOS_Extensions>

Interesting projects:

-   <http://wiki.osdev.org/C%2B%2B_Bare_Bones> Minimal assembly bootstrap into a C kernel, 

    For the UI:

    - <http://wiki.osdev.org/Text_UI>
    - <http://wiki.osdev.org/GUI>

-   <https://github.com/programble/bare-metal-tetris> tested on Ubuntu 14.04. Just works.

    Has Multiboot and El Torito. Uses custom linker script.

    Almost entirely in C `-nostdlib`, with very few inline `asm` commands, and a small assembly entry point. So a good tutorial in how to do the bridge.

-   <https://github.com/scanlime/metalkit> A more automated / general bare metal compilation system.

Did not work well:

- <https://github.com/apparentlymart/ToyOS>
- <https://github.com/rde1024/toyos>
