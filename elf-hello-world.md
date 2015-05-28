# ELF hello world

## Minimal ELF file

It is non-trivial to determine what is the smallest legal ELF file, or the smaller one that will do something trivial in Linux.

Have a look at for some cool attempts: <http://www.muppetlabs.com/~breadbox/software/tiny/> The guy managed a hello world in 0xA0 bytes, pretty impressive.

In this example we will consider a saner `hello world` example that will better capture real life cases.

## Hello world example analysis

### Generate the example

Let's break down a minimal runnable Linux x86-64 example:

    section .data
        hello_world db "Hello world!", 10
        hello_world_len  equ $ - hello_world
    section .text
        global _start
        _start:
            mov rax, 1
            mov rdi, 1
            mov rsi, hello_world
            mov rdx, hello_world_len
            syscall
            mov rax, 60
            mov rdi, 0
            syscall

compiled with:

    nasm -w+all -f elf64 -o 'hello_world.o' 'hello_world.asm'
    ld -o 'hello_world.out' 'hello_world.o'

and NASM version 2.10.09.

We don't use a C program as that would complicate the analysis, that will be level 2 :-)

### Object hd

    hd hello_world.o

Gives:

    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
    00000010  01 00 3e 00 01 00 00 00  00 00 00 00 00 00 00 00  |..>.............|
    00000020  00 00 00 00 00 00 00 00  40 00 00 00 00 00 00 00  |........@.......|
    00000030  00 00 00 00 40 00 00 00  00 00 40 00 07 00 03 00  |....@.....@.....|
    00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    *
    00000080  01 00 00 00 01 00 00 00  03 00 00 00 00 00 00 00  |................|
    00000090  00 00 00 00 00 00 00 00  00 02 00 00 00 00 00 00  |................|
    000000a0  0d 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000000b0  04 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000000c0  07 00 00 00 01 00 00 00  06 00 00 00 00 00 00 00  |................|
    000000d0  00 00 00 00 00 00 00 00  10 02 00 00 00 00 00 00  |................|
    000000e0  27 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |'...............|
    000000f0  10 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000100  0d 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000110  00 00 00 00 00 00 00 00  40 02 00 00 00 00 00 00  |........@.......|
    00000120  32 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |2...............|
    00000130  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000140  17 00 00 00 02 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000150  00 00 00 00 00 00 00 00  80 02 00 00 00 00 00 00  |................|
    00000160  a8 00 00 00 00 00 00 00  05 00 00 00 06 00 00 00  |................|
    00000170  04 00 00 00 00 00 00 00  18 00 00 00 00 00 00 00  |................|
    00000180  1f 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000190  00 00 00 00 00 00 00 00  30 03 00 00 00 00 00 00  |........0.......|
    000001a0  34 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |4...............|
    000001b0  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000001c0  27 00 00 00 04 00 00 00  00 00 00 00 00 00 00 00  |'...............|
    000001d0  00 00 00 00 00 00 00 00  70 03 00 00 00 00 00 00  |........p.......|
    000001e0  18 00 00 00 00 00 00 00  04 00 00 00 02 00 00 00  |................|
    000001f0  04 00 00 00 00 00 00 00  18 00 00 00 00 00 00 00  |................|
    00000200  48 65 6c 6c 6f 20 77 6f  72 6c 64 21 0a 00 00 00  |Hello world!....|
    00000210  b8 01 00 00 00 bf 01 00  00 00 48 be 00 00 00 00  |..........H.....|
    00000220  00 00 00 00 ba 0d 00 00  00 0f 05 b8 3c 00 00 00  |............<...|
    00000230  bf 00 00 00 00 0f 05 00  00 00 00 00 00 00 00 00  |................|
    00000240  00 2e 64 61 74 61 00 2e  74 65 78 74 00 2e 73 68  |..data..text..sh|
    00000250  73 74 72 74 61 62 00 2e  73 79 6d 74 61 62 00 2e  |strtab..symtab..|
    00000260  73 74 72 74 61 62 00 2e  72 65 6c 61 2e 74 65 78  |strtab..rela.tex|
    00000270  74 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |t...............|
    00000280  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000290  00 00 00 00 00 00 00 00  01 00 00 00 04 00 f1 ff  |................|
    000002a0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000002b0  00 00 00 00 03 00 01 00  00 00 00 00 00 00 00 00  |................|
    000002c0  00 00 00 00 00 00 00 00  00 00 00 00 03 00 02 00  |................|
    000002d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000002e0  11 00 00 00 00 00 01 00  00 00 00 00 00 00 00 00  |................|
    000002f0  00 00 00 00 00 00 00 00  1d 00 00 00 00 00 f1 ff  |................|
    00000300  0d 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000310  2d 00 00 00 10 00 02 00  00 00 00 00 00 00 00 00  |-...............|
    00000320  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000330  00 68 65 6c 6c 6f 5f 77  6f 72 6c 64 2e 61 73 6d  |.hello_world.asm|
    00000340  00 68 65 6c 6c 6f 5f 77  6f 72 6c 64 00 68 65 6c  |.hello_world.hel|
    00000350  6c 6f 5f 77 6f 72 6c 64  5f 6c 65 6e 00 5f 73 74  |lo_world_len._st|
    00000360  61 72 74 00 00 00 00 00  00 00 00 00 00 00 00 00  |art.............|
    00000370  0c 00 00 00 00 00 00 00  01 00 00 00 02 00 00 00  |................|
    00000380  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000390

### Executable hd

We don't use a C program as that would complicate the analysis, that will be level 2 :-)

    hd hello_world.o

Gives:

    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
    00000010  02 00 3e 00 01 00 00 00  b0 00 40 00 00 00 00 00  |..>.......@.....|
    00000020  40 00 00 00 00 00 00 00  10 01 00 00 00 00 00 00  |@...............|
    00000030  00 00 00 00 40 00 38 00  02 00 40 00 06 00 03 00  |....@.8...@.....|
    00000040  01 00 00 00 05 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000050  00 00 40 00 00 00 00 00  00 00 40 00 00 00 00 00  |..@.......@.....|
    00000060  d7 00 00 00 00 00 00 00  d7 00 00 00 00 00 00 00  |................|
    00000070  00 00 20 00 00 00 00 00  01 00 00 00 06 00 00 00  |.. .............|
    00000080  d8 00 00 00 00 00 00 00  d8 00 60 00 00 00 00 00  |..........`.....|
    00000090  d8 00 60 00 00 00 00 00  0d 00 00 00 00 00 00 00  |..`.............|
    000000a0  0d 00 00 00 00 00 00 00  00 00 20 00 00 00 00 00  |.......... .....|
    000000b0  b8 01 00 00 00 bf 01 00  00 00 48 be d8 00 60 00  |..........H...`.|
    000000c0  00 00 00 00 ba 0d 00 00  00 0f 05 b8 3c 00 00 00  |............<...|
    000000d0  bf 00 00 00 00 0f 05 00  48 65 6c 6c 6f 20 77 6f  |........Hello wo|
    000000e0  72 6c 64 21 0a 00 2e 73  79 6d 74 61 62 00 2e 73  |rld!...symtab..s|
    000000f0  74 72 74 61 62 00 2e 73  68 73 74 72 74 61 62 00  |trtab..shstrtab.|
    00000100  2e 74 65 78 74 00 2e 64  61 74 61 00 00 00 00 00  |.text..data.....|
    00000110  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    *
    00000150  1b 00 00 00 01 00 00 00  06 00 00 00 00 00 00 00  |................|
    00000160  b0 00 40 00 00 00 00 00  b0 00 00 00 00 00 00 00  |..@.............|
    00000170  27 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |'...............|
    00000180  10 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000190  21 00 00 00 01 00 00 00  03 00 00 00 00 00 00 00  |!...............|
    000001a0  d8 00 60 00 00 00 00 00  d8 00 00 00 00 00 00 00  |..`.............|
    000001b0  0d 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000001c0  04 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000001d0  11 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00  |................|
    000001e0  00 00 00 00 00 00 00 00  e5 00 00 00 00 00 00 00  |................|
    000001f0  27 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |'...............|
    00000200  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000210  01 00 00 00 02 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000220  00 00 00 00 00 00 00 00  90 02 00 00 00 00 00 00  |................|
    00000230  08 01 00 00 00 00 00 00  05 00 00 00 07 00 00 00  |................|
    00000240  08 00 00 00 00 00 00 00  18 00 00 00 00 00 00 00  |................|
    00000250  09 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000260  00 00 00 00 00 00 00 00  98 03 00 00 00 00 00 00  |................|
    00000270  4c 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |L...............|
    00000280  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000290  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000002a0  00 00 00 00 00 00 00 00  00 00 00 00 03 00 01 00  |................|
    000002b0  b0 00 40 00 00 00 00 00  00 00 00 00 00 00 00 00  |..@.............|
    000002c0  00 00 00 00 03 00 02 00  d8 00 60 00 00 00 00 00  |..........`.....|
    000002d0  00 00 00 00 00 00 00 00  01 00 00 00 04 00 f1 ff  |................|
    000002e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000002f0  11 00 00 00 00 00 02 00  d8 00 60 00 00 00 00 00  |..........`.....|
    00000300  00 00 00 00 00 00 00 00  1d 00 00 00 00 00 f1 ff  |................|
    00000310  0d 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000320  00 00 00 00 04 00 f1 ff  00 00 00 00 00 00 00 00  |................|
    00000330  00 00 00 00 00 00 00 00  2d 00 00 00 10 00 01 00  |........-.......|
    00000340  b0 00 40 00 00 00 00 00  00 00 00 00 00 00 00 00  |..@.............|
    00000350  34 00 00 00 10 00 02 00  e5 00 60 00 00 00 00 00  |4.........`.....|
    00000360  00 00 00 00 00 00 00 00  40 00 00 00 10 00 02 00  |........@.......|
    00000370  e5 00 60 00 00 00 00 00  00 00 00 00 00 00 00 00  |..`.............|
    00000380  47 00 00 00 10 00 02 00  e8 00 60 00 00 00 00 00  |G.........`.....|
    00000390  00 00 00 00 00 00 00 00  00 68 65 6c 6c 6f 5f 77  |.........hello_w|
    000003a0  6f 72 6c 64 2e 61 73 6d  00 68 65 6c 6c 6f 5f 77  |orld.asm.hello_w|
    000003b0  6f 72 6c 64 00 68 65 6c  6c 6f 5f 77 6f 72 6c 64  |orld.hello_world|
    000003c0  5f 6c 65 6e 00 5f 73 74  61 72 74 00 5f 5f 62 73  |_len._start.__bs|
    000003d0  73 5f 73 74 61 72 74 00  5f 65 64 61 74 61 00 5f  |s_start._edata._|
    000003e0  65 6e 64 00                                       |end.|
    000003e4

### Global file structure

- ELF header
- `e_phnum` program headers
- `e_shnum` sections headers
- N sections, with `N <= e_shnum` (TODO check)
- Section header table

### ELF header

`readelf -h hello_world.o`:

    Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
    Class:                             ELF64
    Data:                              2's complement, little endian
    Version:                           1 (current)
    OS/ABI:                            UNIX - System V
    ABI Version:                       0
    Type:                              REL (Relocatable file)
    Machine:                           Advanced Micro Devices X86-64
    Version:                           0x1
    Entry point address:               0x0
    Start of program headers:          0 (bytes into file)
    Start of section headers:          64 (bytes into file)
    Flags:                             0x0
    Size of this header:               64 (bytes)
    Size of program headers:           0 (bytes)
    Number of program headers:         0
    Size of section headers:           64 (bytes)
    Number of section headers:         7
    Section header string table index: 3

`readelf -h hello_world.out`:

    Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
    Class:                             ELF64
    Data:                              2's complement, little endian
    Version:                           1 (current)
    OS/ABI:                            UNIX - System V
    ABI Version:                       0
    Type:                              EXEC (Executable file)
    Machine:                           Advanced Micro Devices X86-64
    Version:                           0x1
    Entry point address:               0x4000b0
    Start of program headers:          64 (bytes into file)
    Start of section headers:          272 (bytes into file)
    Flags:                             0x0
    Size of this header:               64 (bytes)
    Size of program headers:           56 (bytes)
    Number of program headers:         2
    Size of section headers:           64 (bytes)
    Number of section headers:         6
    Section header string table index: 3

Reproducing the headers here for convenience: object file:

    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
    00000010  01 00 3e 00 01 00 00 00  00 00 00 00 00 00 00 00  |..>.............|
    00000020  00 00 00 00 00 00 00 00  40 00 00 00 00 00 00 00  |........@.......|
    00000030  00 00 00 00 40 00 00 00  00 00 40 00 07 00 03 00  |....@.....@.....|

executable:

    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
    00000010  02 00 3e 00 01 00 00 00  b0 00 40 00 00 00 00 00  |..>.......@.....|
    00000020  40 00 00 00 00 00 00 00  10 01 00 00 00 00 00 00  |@...............|
    00000030  00 00 00 00 40 00 38 00  02 00 40 00 06 00 03 00  |....@.8...@.....|

The structure represented:

    typedef struct {
        unsigned char   e_ident[EI_NIDENT];
        Elf64_Half      e_type;
        Elf64_Half      e_machine;
        Elf64_Word      e_version;
        Elf64_Addr      e_entry;
        Elf64_Off       e_phoff;
        Elf64_Off       e_shoff;
        Elf64_Word      e_flags;
        Elf64_Half      e_ehsize;
        Elf64_Half      e_phentsize;
        Elf64_Half      e_phnum;
        Elf64_Half      e_shentsize;
        Elf64_Half      e_shnum;
        Elf64_Half      e_shstrndx;
    } Elf64_Ehdr;

Manual breakdown:

-   0 0: `EI_MAG` = `7f 45 4c 46` = `0x7f 'E', 'L', 'F'`: ELF magic number

-   0 4: `EI_CLASS` = `02` = `ELFCLASS64`: 64 bit elf

-   0 5: `EI_DATA` = `01` = `ELFDATA2LSB`: big endian data

-   0 6: `EI_VERSION` = `01`: format version

-   0 7: `EI_OSABI` (only in 2003 Update) = `00` = `ELFOSABI_NONE`: no extensions.

-   0 8: `EI_PAD` = 8x `00`: reserved bytes. Must be set to 0.

-   1 0: `e_type` = `01 00` = 1 (big endian) = `ET_REl`: relocatable format

    On the executable it is `02 00` for `ET_EXEC`.

-   1 2: `e_machine` = `3e 00` = `62` = `EM_X86_64`: AMD64 architecture

-   1 4: `e_version` = `01 00 00 00`: must be 1

-   1 8: `e_entry` = 8x `00`: execution address entry point, or 0 if not applicable like for the object file since there is no entry point.

    On the executable, it is `b0 00 40 00 00 00 00 00`. TODO: what else can we set this to? The kernel seems to put the IP directly on that value, it is not hardcoded.

-   2 0: `e_phoff` = 8x `00`: program header table offset, 0 if not present.

    `40 00 00 00` on the executable, i.e. it starts immediately after the ELF header.

-   2 8: `e_shoff` = `40` 7x `00`: section header table offset, 0 if not present. TODO

-   3 0: `e_flags` =  `00 00 00 00` TODO. Arch specific.

-   3 4: `e_ehsize` =  `40 00 `: elf header size. We are almost at the end.

-   3 6: `e_phentsize` =  `00 00 `: size of each program header, 0 if not present.

    `38 00` on executable: it is 56 bytes long

-   3 8: `e_phnum` =  `00 00 `: number of program header entries, 0 if not present.

    `02 00` on executable: there are 2 entries.

-   3 A: `e_shentsize` and `e_shnum` = `40 00 07 00`: section header size and number of entries

-   3 E: `e_shstrndx` (`Section Header STRing iNDeX`) = `03 00`: entry of the section header table which corresponds to the string table, which is a magic section for the ELF. This table holds symbol and section names.

### Program header table

Only appears in the executable.

Contains information of how the executable should be put into the process virtual memory.

`readelf -l hello_world.out` gives:

    Elf file type is EXEC (Executable file)
    Entry point 0x4000b0
    There are 2 program headers, starting at offset 64

    Program Headers:
      Type           Offset             VirtAddr           PhysAddr
                     FileSiz            MemSiz              Flags  Align
      LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                     0x00000000000000d7 0x00000000000000d7  R E    200000
      LOAD           0x00000000000000d8 0x00000000006000d8 0x00000000006000d8
                     0x000000000000000d 0x000000000000000d  RW     200000

     Section to Segment mapping:
      Segment Sections...
       00     .text
       01     .data

On the ELF header, `e_phoff`, `e_phnum` and `e_phentsize` told us that there are 2 program headers, which start at `0x40` and are `0x38` bytes long each, so they are:

    00000040  01 00 00 00 05 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000050  00 00 40 00 00 00 00 00  00 00 40 00 00 00 00 00  |..@.......@.....|
    00000060  d7 00 00 00 00 00 00 00  d7 00 00 00 00 00 00 00  |................|
    00000070  00 00 20 00 00 00 00 00                           |.. .....        |

and:

    00000070                           01 00 00 00 06 00 00 00  |        ........|
    00000080  d8 00 00 00 00 00 00 00  d8 00 60 00 00 00 00 00  |..........`.....|
    00000090  d8 00 60 00 00 00 00 00  0d 00 00 00 00 00 00 00  |..`.............|
    000000a0  0d 00 00 00 00 00 00 00  00 00 20 00 00 00 00 00  |.......... .....|

Structure represented <http://www.sco.com/developers/gabi/2003-12-17/ch5.pheader.html>:

    typedef struct {
        Elf64_Word  p_type;
        Elf64_Word  p_flags;
        Elf64_Off   p_offset;
        Elf64_Addr  p_vaddr;
        Elf64_Addr  p_paddr;
        Elf64_Xword p_filesz;
        Elf64_Xword p_memsz;
        Elf64_Xword p_align;
    } Elf64_Phdr;

Breakdown of the first one:

- 40 0: `p_type` = `01 00 00 00` = `PT_LOAD`: TODO
- 40 4: `p_flags` = `05 00 00 00` = `PT_LOAD`: execute and read permissions, no write TODO 
- 40 8: `p_offset` = 8x `00` TODO why 0?
- 50 0: `p_vaddr` = `00 00 40 00 00 00 00 00`: initial virtual memory address to load this segment to
- 50 8: `p_paddr` = `00 00 40 00 00 00 00 00` = initial physical address to load in memory. Only matters for systems in which the program can set it's physical address. Otherwise, as in System V like systems, can be anything. NASM seems to just copy `p_vaddrr`
- 60 0: `p_filesz` = `d7 00 00 00 00 00 00 00`: TODO vs `p_memsz`
- 60 8: `p_memsz` = `d7 00 00 00 00 00 00 00`: TODO
- 70 0: `p_align` =  `00 00 20 00 00 00 00 00`: 0 or 1 mean no alignment required TODO what does that mean? otherwise redundant with other fields

The second is analogous.

Then the:

     Section to Segment mapping:

section of the `readelf` tells us that:

- 0 is the `.text` segment. Aha, so this is why it is executable, and not writable
- 1 is the `.data` segment.

TODO where does this information comes from.

### Section header table

Some section names are reserved for certain section types: <http://www.sco.com/developers/gabi/2003-12-17/ch4.sheader.html#special_sections> e.g. `.text` requires a `SHT_PROGBITS` type and `SHF_ALLOC` + `SHF_EXECINSTR`

`readelf -S hello_world.o`:

    There are 7 section headers, starting at offset 0x40:

    Section Headers:
      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
      [ 0]                   NULL             0000000000000000  00000000
           0000000000000000  0000000000000000           0     0     0
      [ 1] .data             PROGBITS         0000000000000000  00000200
           000000000000000d  0000000000000000  WA       0     0     4
      [ 2] .text             PROGBITS         0000000000000000  00000210
           0000000000000027  0000000000000000  AX       0     0     16
      [ 3] .shstrtab         STRTAB           0000000000000000  00000240
           0000000000000032  0000000000000000           0     0     1
      [ 4] .symtab           SYMTAB           0000000000000000  00000280
           00000000000000a8  0000000000000018           5     6     4
      [ 5] .strtab           STRTAB           0000000000000000  00000330
           0000000000000034  0000000000000000           0     0     1
      [ 6] .rela.text        RELA             0000000000000000  00000370
           0000000000000018  0000000000000018           4     2     4
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings), l (large)
      I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
      O (extra OS processing required) o (OS specific), p (processor specific)

`e_shoff`, `e_shentsize` and `e_shnum` from the ELF header for the object file say that we have 7 entries, each `0x40` bytes long, starting at offset `0x40` (immediately after the elf header).

    000000c0  07 00 00 00 01 00 00 00  06 00 00 00 00 00 00 00  |................|
    000000d0  00 00 00 00 00 00 00 00  10 02 00 00 00 00 00 00  |................|
    000000e0  27 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |'...............|
    000000f0  10 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

    00000100  0d 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000110  00 00 00 00 00 00 00 00  40 02 00 00 00 00 00 00  |........@.......|
    00000120  32 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |2...............|
    00000130  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

    00000140  17 00 00 00 02 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000150  00 00 00 00 00 00 00 00  80 02 00 00 00 00 00 00  |................|
    00000160  a8 00 00 00 00 00 00 00  05 00 00 00 06 00 00 00  |................|
    00000170  04 00 00 00 00 00 00 00  18 00 00 00 00 00 00 00  |................|

    00000180  1f 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00  |................|
    00000190  00 00 00 00 00 00 00 00  30 03 00 00 00 00 00 00  |........0.......|
    000001a0  34 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |4...............|
    000001b0  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

    000001c0  27 00 00 00 04 00 00 00  00 00 00 00 00 00 00 00  |'...............|
    000001d0  00 00 00 00 00 00 00 00  70 03 00 00 00 00 00 00  |........p.......|
    000001e0  18 00 00 00 00 00 00 00  04 00 00 00 02 00 00 00  |................|
    000001f0  04 00 00 00 00 00 00 00  18 00 00 00 00 00 00 00  |................|

`struct` represented:

    typedef struct {
        Elf64_Word  sh_name;
        Elf64_Word  sh_type;
        Elf64_Xword sh_flags;
        Elf64_Addr  sh_addr;
        Elf64_Off   sh_offset;
        Elf64_Xword sh_size;
        Elf64_Word  sh_link;
        Elf64_Word  sh_info;
        Elf64_Xword sh_addralign;
        Elf64_Xword sh_entsize;
    } Elf64_Shdr;

Section 0: `SH_NULLL`:

    00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    *

#### Index 0 section

The first section is magic: <http://www.sco.com/developers/gabi/2003-12-17/ch4.sheader.html> says:

> If the number of sections is greater than or equal to SHN_LORESERVE (0xff00), e_shnum has the value SHN_UNDEF (0) and the actual number of section header table entries is contained in the sh_size field of the section header at index 0 (otherwise, the sh_size member of the initial entry contains 0). 

There are also other magic sections detailed in `Figure 4-7: Special Section Indexes`

##### SHT_NULL

In index 0, `SHT_NULL` is mandatory. Are there any other uses for it: <http://stackoverflow.com/questions/26812142/what-is-the-use-of-the-sht-null-section-in-elf> ?

#### .data section analysis

`.data` is section 1:

    00000080  01 00 00 00 01 00 00 00  03 00 00 00 00 00 00 00  |................|
    00000090  00 00 00 00 00 00 00 00  00 02 00 00 00 00 00 00  |................|
    000000a0  0d 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    000000b0  04 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

-   80 0: `sh_name` = `01 00 00 00`: index 1 in the `.shstrtab` string table

    Here, `1` says the name of this section starts at the first character of that section, and ends at the first NUL character, making up the string `.data`.

    `.data` is one of the section names which has a predefined meaning <http://www.sco.com/developers/gabi/2003-12-17/ch4.strtab.html>

    > These sections hold initialized data that contribute to the program's memory image. 

-   80 4: `sh_type` = `01 00 00 00`: `SHT_PROGBITS`: the section content is not specified by ELF, only by how the program interprets it. Normal since a `.data` section.

-   80 8: `sh_flags` = `03` 7x `00`: `SHF_ALLOC` and `SHF_EXECINSTR`: <http://www.sco.com/developers/gabi/2003-12-17/ch4.sheader.html#sh_flags>, as required from a `.data` section

-   90 0: `sh_addr` = 8x `00`: in what virtual address the section will be placed during execution, `0` if not placed

-   90 8: `sh_offset` = `00 02 00 00 00 00 00 00` = `0x200`: number of bytes from the start of the program to the first byte in this section

-   A0 0: `sh_size` = `0d 00 00 00 00 00 00 00`

    If we take 0xD bytes starting at  `sh_offset` 200, we see:

        00000200  48 65 6c 6c 6f 20 77 6f  72 6c 64 21 0a 00        |Hello world!..  |

    AHA! So our `"Hello world!"` string is in the data section like we told it to be on the NASM.

    Once we graduate from `hd`, we will look this up like:

        readelf -x .data hello_world.o

    which outputs:

        Hex dump of section '.data':
          0x00000000 48656c6c 6f20776f 726c6421 0a       Hello world!.

    NASM sets decent properties for that section because it treats `.data` magically: <http://www.nasm.us/doc/nasmdoc7.html#section-7.9.2>

    Also note that this was a bad section choice: a good C compiler would put the string in `.rodata` instead, because it is read-only and it would allow for further OS optimizations.

-   a0 8: `sh_link` and `sh_info` = 8x 0: do not apply to this section type. <http://www.sco.com/developers/gabi/2003-12-17/ch4.sheader.html#special_sections>

-   b0 0: `sh_addralign` = `04` = TODO: why is this alignment necessary? Is it only for `sh_addr`, or also for symbols inside `sh_addr`?

-   b0 8: `sh_entsize` = `00` = the section does not contain a table. If != 0, it means that the section contains a table of fixed size entries. In this file, we see from the `readelf` output that this is the case for `SYMTAB` and `ENTSIZE` sections.

#### Text section

#### .text

Now that we've done one section manually, let's graduate and use the `readelf -S` of the other sections.

      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
      [ 2] .text             PROGBITS         0000000000000000  00000210
           0000000000000027  0000000000000000  AX       0     0     16

`.text` is executable but not writable: if we try to write to it Linux segfaults. Let's see if we really have some code there:

    objdump -d hello_world.o

gives:

    hello_world.o:     file format elf64-x86-64


    Disassembly of section .text:

    0000000000000000 <_start>:
       0:       b8 01 00 00 00          mov    $0x1,%eax
       5:       bf 01 00 00 00          mov    $0x1,%edi
       a:       48 be 00 00 00 00 00    movabs $0x0,%rsi
      11:       00 00 00
      14:       ba 0d 00 00 00          mov    $0xd,%edx
      19:       0f 05                   syscall
      1b:       b8 3c 00 00 00          mov    $0x3c,%eax
      20:       bf 00 00 00 00          mov    $0x0,%edi
      25:       0f 05                   syscall

If we grep `b8 01 00 00` on the `hd`, we see that this only occurs at `00000210`, which is what the section says. And the Size is 27, which matches as well. So we must be talking about the right section.

This looks like the right code: a `write` followed by an `exit`.

The most interesting part is line `a` which does:

    movabs $0x0,%rsi

to pass the address of the string to the system call. Currently, the `0x0` is just a placeholder. After linking happens, it will be modified to contain:

    4000ba: 48 be d8 00 60 00 00    movabs $0x6000d8,%rsi

This modification is possible because of the data of the `.rela.text` section.

### _start

[System V ABI AMD64][] says that `_start` is the entry point:

> The initial state of the process stack, i.e. when _start is called

so the `_start` symbol is magic.

TODO where is it mentioned in the arch agnostic standards?

### Section header string table

### STRTAB

### .shstrtab

This section name is predefined and the description says:

> This section holds section names.

This section does not have `SHF_ALLOC` marked, so it will not appear on the executing program.

    readelf -x .shstrtab hello_world.o

Gives:

    Hex dump of section '.shstrtab':
      0x00000000 002e6461 7461002e 74657874 002e7368 ..data..text..sh
      0x00000010 73747274 6162002e 73796d74 6162002e strtab..symtab..
      0x00000020 73747274 6162002e 72656c61 2e746578 strtab..rela.tex
      0x00000030 7400                                t.

The data in this section has a fixed format: <http://www.sco.com/developers/gabi/2003-12-17/ch4.strtab.html>

If we look at the names of other sections, we see that they all contain numbers, e.g. the `.text` section is number `7`.

Then each string ends when the first NUL character is found, e.g. character `12` is `\0` just after `.text\0`.

### Symbol table

### SHT_SYMTAB

### .symtab

First the we note that:

- `sh_link` = `5`
- `sh_info` = `6`

For `SHT_SYMTAB` sections, those numbers mean that:

- strings that give symbol names are in section 5, `.strtab`
- the relocation data is in section 6, `.rela.text`

A good high level tool to disassemble that section is:

    nm hello_world.o

which gives:

    0000000000000000 T _start
    0000000000000000 d hello_world
    000000000000000d a hello_world_len

This is however a high level view that omits some types of symbols and in which the symbol types . A more detailed disassembly can be obtained with:

    readelf -s hello_world.o

which gives:

    Symbol table '.symtab' contains 7 entries:
       Num:    Value          Size Type    Bind   Vis      Ndx Name
         0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
         1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS hello_world.asm
         2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1
         3: 0000000000000000     0 SECTION LOCAL  DEFAULT    2
         4: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    1 hello_world
         5: 000000000000000d     0 NOTYPE  LOCAL  DEFAULT  ABS hello_world_len
         6: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    2 _start

The binary format of the table is documented at <http://www.sco.com/developers/gabi/2003-12-17/ch4.symtab.html>

The data is:

    readelf -x .symtab hello_world.o

Which gives:

    Hex dump of section '.symtab':
      0x00000000 00000000 00000000 00000000 00000000 ................
      0x00000010 00000000 00000000 01000000 0400f1ff ................
      0x00000020 00000000 00000000 00000000 00000000 ................
      0x00000030 00000000 03000100 00000000 00000000 ................
      0x00000040 00000000 00000000 00000000 03000200 ................
      0x00000050 00000000 00000000 00000000 00000000 ................
      0x00000060 11000000 00000100 00000000 00000000 ................
      0x00000070 00000000 00000000 1d000000 0000f1ff ................
      0x00000080 0d000000 00000000 00000000 00000000 ................
      0x00000090 2d000000 10000200 00000000 00000000 -...............
      0x000000a0 00000000 00000000                   ........

The entries are of type:

    typedef struct {
        Elf64_Word  st_name;
        unsigned char   st_info;
        unsigned char   st_other;
        Elf64_Half  st_shndx;
        Elf64_Addr  st_value;
        Elf64_Xword st_size;
    } Elf64_Sym;

Like in the section table, the first entry is magical and set to a fixed meaningless values.

### STT_FILE

Entry 1 is as follows:

-   10 8: `st_name` = `01000000` = character 1 in the `.strtab`, which until the following `\0` makes `hello_world.asm`

-   10 12: `st_info` = `04`

    Bits 0-3 = Type = `4` = `STT_FILE`: this entry gives the name of the source file from which it was generated. TODO is really needed, or just for debugging?

    Bits 4-7 = Binding = `0` = `STB_LOCAL`. Required for `STT_FILE`.

-   10 13: `st_shndx` (Symbol Table Section header Index) = `f1ff` = `SHN_ABS`. Required for `STT_FILE`.

-   20 0: `st_value` = 8x `00`: default value for `STT_FILE`

-   20 8: `st_size` = 8x `00`: no allocated size

Now from the readelf, we interpret the others quickly.

#### STT_SECTION

There are two such entries, one pointing to `.data` and the other to `.text` (section indexes `1` and `2`).

    2: 0000000000000000     0 SECTION LOCAL  DEFAULT    1
    3: 0000000000000000     0 SECTION LOCAL  DEFAULT    2

TODO what is their purpose?

#### Other symbols

Then come the most important symbols which `nm` shows us:

    4: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT    1 hello_world
    5: 000000000000000d     0 NOTYPE  LOCAL  DEFAULT  ABS hello_world_len
    6: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    2 _start

`hello_world` string is in the `.data` section (index 1). It's value is 0: it points to the first byte of that section.

`hello_world_len` points to the special section index `SHN_ABS`, which is very high `f1ff` and so as to not conflict with other sections. It holds the literal string length `D` = 13. TODO what does it mean?

`_start` is marked with `GLOBAL` visibility since we wrote:

    global _start

in NASM. This is necessary since it must be seen as the entry point. Unlike in C, by default NASM labels are local.

#### SHT_SYMTAB on the executable

By default, NASM places a `.symtab` on the executable as well. TODO why is that needed outside of dynamic linking?

### .strtab

Holds names for the symbol table.

It was pointed to by `sh_link` = `5` of the `.symtab` section.

    readelf -x .strtab hello_world.o

Gives:

    Hex dump of section '.strtab':
      0x00000000 0068656c 6c6f5f77 6f726c64 2e61736d .hello_world.asm
      0x00000010 0068656c 6c6f5f77 6f726c64 0068656c .hello_world.hel
      0x00000020 6c6f5f77 6f726c64 5f6c656e 005f7374 lo_world_len._st
      0x00000030 61727400                            art.

Is also of type `STRTAB`, so it has the same structure of `.shstrtab`.

This implies that it is an ELF level limitation that global variables cannot contain NUL characters.

## SHT_RELA

### .rela.text

`.rela.text` holds relocation data which says how the address should be modified when the final executable is linked. This points to bytes of the text area that must be modified when linking happens to point to the correct memory locations.

Basically, it translates the object text containing the placeholder 0x0 address:

       a:       48 be 00 00 00 00 00    movabs $0x0,%rsi
      11:       00 00 00

to the actual executable code containing the final 0x6000d8:

    4000ba: 48 be d8 00 60 00 00    movabs $0x6000d8,%rsi
    4000c1: 00 00 00

It was pointed to by `sh_info` = `6` of the `.symtab` section.

`readelf -r hello_world.o` gives:

    Relocation section '.rela.text' at offset 0x3b0 contains 1 entries:
      Offset          Info           Type           Sym. Value    Sym. Name + Addend
    00000000000c  000200000001 R_X86_64_64       0000000000000000 .data + 0

The section does not exist in the executable.

The actual bytes are:

    00000370  0c 00 00 00 00 00 00 00  01 00 00 00 02 00 00 00  |................|
    00000380  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

The `struct` represented is:

    typedef struct {
        Elf64_Addr  r_offset;
        Elf64_Xword r_info;
        Elf64_Sxword    r_addend;
    } Elf64_Rela;

So:

-   370 0: `r_offset` = 0xC: address into the `.text` whose address this relocation will modify

-   370 8: `r_info` = 0x200000001. Contains 2 fields:

    - `ELF64_R_TYPE` = 0x1: meaning depends on the exact architecture.
    - `ELF64_R_SYM` = 0x2: index of the section to which the address points, so `.data` which is at index 2.

    The AMD64 ABI says that type `1` is called `R_X86_64_64` and that it represents the operation `S + A` where:

    - `S` is TODO
    - `A` is the addend, present in field `r_added`

    This relocation operation acts on a total 8 bytes.

-   380 0: `r_addend` = 0: TODO
