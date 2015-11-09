# Linker scripts

1.  [Hello world](hello_world.ld)
1.  [min](min.ld)
1.  [Symbol](symbol.ld)
    1. [edata](edata.ld)
1.  [FLAGS](flags.ld)
1.  [KEEP](keep.ld)

## Introduction

This directory must be run in Linux IA-32.

Linker scripts determine how exactly `ld` is going to transform object files into the executable.

In particular, how the sections are going to me mashed up into segments.

The default linker script operation is determined by the default linker scripts.

Those are hardcoded into the `ld` executable.

`make install` also generates an informational copy of the scripts at:

    x86_64-unknown-linux-gnu/lib/ldscripts

which some distributions provide. But those are only informational. The usual location is:

    /usr/lib/ldscripts

The actual script being used is determined by the `ld` options, and can be viewed with:

    ld --verbose

which spits out the entire script, but not it's name. You can then match this output to the scripts under `/usr/lib/ldscripts`.

Minimal example: <http://stackoverflow.com/questions/7182409/how-to-correctly-use-a-simple-linker-script> TODO make into a repo.

The main case where linker scripts are needed is when building more "exotic" executables, typically boot sectors or a multiboot file. E.g.: <http://wiki.osdev.org/Bare_Bones>

## T

Replace the linker script with a custom one:

    ld -T script a.o

You will often use an existing script as the basis for this.

## Ttext-segment

Change the address of some predefined segments:

    -Ttext-segment=0x80000

The default linker script reads:

    . = SEGMENT_START("text-segment", 0x400000)

which chooses takes the value passed, or 4M by default.

## Directives

### SECTIONS

Most important directive: contains the section o segment mappings.

#### Select by object file

You can select sections by object file.

For example, for a multiboot elf file, we must put the multiboot header before everything else.

So if we had our header in the `.text` section of the `boot.o` file (bad practice, it would be better to have a specially named section), we could write:

    .text 0x100000 :
    {
        boot.o(.text)
        *(.text)
    }

This way, `boot.o(.text)` is guaranteed to put `boot.o` first, and `*(.text)` then matches the others.

### BYTE

### SHORT

### LONG

### QUAD

Used to insert raw bytes directly into the output.

Application: insert boot sector magic bytes: https://github.com/cirosantilli/x86-bare-metal-examples/blob/2b79ac21df801fbf4619d009411be6b9cd10e6e0/a.ld#L14

### SQUAD

Like `QUAD` but sign extends.

### Assignment

#### PROVIDE

<https://sourceware.org/binutils/docs/ld/PROVIDE.html#index-PROVIDE-408>

Make provided symbols weak: if they are defined by the object files, that definition wins.

Without `PROVIDE`, a multiple definition error occurs.

E.g.:

    __symbol_weak = PROVIDE(.);
    __symbol = .;

Note that:

    __symbol = .;

sets the **address** of `__symbol`, relative to the current segment. `.` in this context is also relative to the current segment.

To set the value of the symbol, you'd need:

    __symbol = .;
    DWORD

Used on the default userland script for section position symbols like `etext` and `edata`: <http://stackoverflow.com/questions/1765969/where-are-the-symbols-etext-edata-and-end-defined>

Those symbols are placed on the output right where they are defined, relative to other sections and symbols.

#### ABSOLUTE

TODO

### ALIGN

Returns the address of the next multiple.

Applications:

Extend the output to be a multiple of 512 bytes:

    . = ALIGN(512)

This can be useful to generate boot sectors with multiple stages.

## Segment flags

## Segment permissions

Some segment names are magic: `.text` and `.data`, and will have fixed permissions no matter what.

If you use a non-magic name lie `.blurb`, the permission is the sum of the permissions of all sections that make up the segment.

It is also possible to set the segment permissions with the `FLAGS` option of the `PHDRS` linker script command.
