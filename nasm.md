# NASM

Netwide assembler. TODO what does Netwide mean?

One of the most popular for Linux.

Open source.

Intel like syntax.

Input formats:

- `.asm`, Intel like syntax

Most useful command line options:

- `-w+all`: enable all warnings

## f

Output format:

    nasm -f elf32 main.asm

List all formats:

    nasm -hf

You should always use this flag.

The default format of a default compilation (and that of Ubuntu 14.04) is `bin`, which generates raw instructions without any ELF metadata.

is not very useful <http://stackoverflow.com/questions/2427011/what-is-the-difference-between-elf-files-and-bin-files>

There seems to be no way to automatically decide a better choice: the default is a compilation option.

The following formats work:

- `elf32`: Linux 32-bit
- `elf64`: Linux 64-bit
