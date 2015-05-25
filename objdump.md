# objdump

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

## S

Similar to `-d`, but also intermingle original C code with disassembly if there is debug information available for that: 

    gcc -ggdb3 -o a.o a.c
    objdump -S a.o
