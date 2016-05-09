# objdump

`objdump` shows a weird view of ELF files: use `readelf` whenever possible:

- <http://stackoverflow.com/questions/22160621/objdump-not-showing-all-sections>
- <http://stackoverflow.com/questions/8979664/readelf-vs-objdump-why-are-both-needed>

Things which it can do that `readelf` cannot:

- disassemble

Most useful command `objdump` command:

    objdump -Sr a.o

## d

See assembler instructions of object file or executable:

    objdump -d a.o

Only disassembles sections which should contain assembly code like `.text`.

Sample output on a x86_64 Linux hello world:

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

For executable files, it still writes `Disassembly of section .text:`, but it means *segment* `.text`, it is purely wrong.

## S

Similar to `-d`, but also intermingle original C code with disassembly if there is debug information available for that: 

    gcc -ggdb3 -o a.o a.c
    objdump -S a.o

## j

Select which section to act on.

## Disassemble a single function

Seems impossible, use GDB instead.

<http://stackoverflow.com/questions/22769246/disassemble-one-function-using-objdump>

## M

Disassemble with Intel syntax:

    objdump -M intel -d main.o
