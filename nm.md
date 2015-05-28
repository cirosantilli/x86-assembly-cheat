# nm TODO

High level disassembly of the ELF's symtable, which is one of the ELF sections:

    nm a.o

Sample output:

                     U __printf_chk
    0000000000000000 T main
    0000000000000000 T my_function
    0000000000000004 C my_var

`man nm` explains the output in detail.

Note that this is all high level:

- some symbol types are omitted
- the symbol types like `T` and `C` do not map 1-to-1 to elf data: instead they there are a summary which combine different fields of the actual ELF data: Type, Bind, Visibility and Section index.

## V vs W

TODO.

V is for real ELF weak symbols.

What is `W` then?
