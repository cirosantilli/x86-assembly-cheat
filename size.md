# size

Shows size of each memory part of a executable:

    gcc -c a.c
    gcc a.o
    size a.out a.o

- text: instructions
- data: init and `uinit` data
- `dec` and `hex`: size of executable in decimal and hexadecimal
