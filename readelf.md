# readelf

Get information stored inside executable files in a human readable way.

See all information:

    readelf -a a.out

TODO understand all the information, and therefore the entire elf format.

To show only specific informations:

## s

Symtable of elf, `.o` or `.so`.

## d

Show only dependencies of an executable (symbols and shared libraries).

- `NEEDED`: direct `.so` dependencies <http://stackoverflow.com/questions/6242761/how-do-i-find-the-direct-shared-object-dependencies-of-a-linux-elf-binary>. `.so` can also depend on other `.so`. To recursively list all dependencies, use `ldd`.

## x

Hexdump section data for given section:

    readelf -x .data hello_world.o

Sample output:

    Hex dump of section '.data':
      0x00000000 48656c6c 6f20776f 726c6421 0a       Hello world!.

## W

Don't limit the output width to 80 columns which is the default, and reduce the amount of `0` padding.

Makes things much more readable is your terminal is wide enough.

Without `-W`:

    Section Headers:
      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
      [ 0]                   NULL             0000000000000000  00000000
           0000000000000000  0000000000000000           0     0     0
      [ 1] .text             PROGBITS         0000000000000000  00000040
           000000000000005c  0000000000000000  AX       0     0     1
      [ 2] .rela.text        RELA             0000000000000000  000002f0
           00000000000000d8  0000000000000018   I      11     1     8
      [ 3] .data             PROGBITS         0000000000000000  0000009c
           0000000000000004  0000000000000000  WA       0     0     4
      [ 4] .bss              NOBITS           0000000000000000  000000a0
           0000000000000000  0000000000000000  WA       0     0     1
      [ 5] .rodata           PROGBITS         0000000000000000  000000a0
           0000000000000004  0000000000000000   A       0     0     1
      [ 6] .comment          PROGBITS         0000000000000000  000000a4
           0000000000000025  0000000000000001  MS       0     0     1
      [ 7] .note.GNU-stack   PROGBITS         0000000000000000  000000c9
           0000000000000000  0000000000000000           0     0     1
      [ 8] .eh_frame         PROGBITS         0000000000000000  000000d0
           0000000000000058  0000000000000000   A       0     0     8
      [ 9] .rela.eh_frame    RELA             0000000000000000  000003c8
           0000000000000030  0000000000000018   I      11     8     8
      [10] .shstrtab         STRTAB           0000000000000000  00000128
           0000000000000061  0000000000000000           0     0     1
      [11] .symtab           SYMTAB           0000000000000000  00000190
           0000000000000138  0000000000000018          12    10     8
      [12] .strtab           STRTAB           0000000000000000  000002c8
           0000000000000025  0000000000000000           0     0     1

With `-W`:

    Section Headers:
      [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
      [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
      [ 1] .text             PROGBITS        0000000000000000 000040 00005c 00  AX  0   0  1
      [ 2] .rela.text        RELA            0000000000000000 0002f0 0000d8 18   I 11   1  8
      [ 3] .data             PROGBITS        0000000000000000 00009c 000004 00  WA  0   0  4
      [ 4] .bss              NOBITS          0000000000000000 0000a0 000000 00  WA  0   0  1
      [ 5] .rodata           PROGBITS        0000000000000000 0000a0 000004 00   A  0   0  1
      [ 6] .comment          PROGBITS        0000000000000000 0000a4 000025 01  MS  0   0  1
      [ 7] .note.GNU-stack   PROGBITS        0000000000000000 0000c9 000000 00      0   0  1
      [ 8] .eh_frame         PROGBITS        0000000000000000 0000d0 000058 00   A  0   0  8
      [ 9] .rela.eh_frame    RELA            0000000000000000 0003c8 000030 18   I 11   8  8
      [10] .shstrtab         STRTAB          0000000000000000 000128 000061 00      0   0  1
      [11] .symtab           SYMTAB          0000000000000000 000190 000138 18     12  10  8
      [12] .strtab           STRTAB          0000000000000000 0002c8 000025 00      0   0  1
