# objdump

See assembler instructions of object file or executable:

    objdump -d a.o

Intermingle original C code with disassembly more or less where they coincide:

    gcc -ggdb3 -o a.o a.c
    objdump -S a.o

Binary files must be compiled with debugging information.
