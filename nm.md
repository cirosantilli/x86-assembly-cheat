# nm TODO

Get symbol table for object files:

    nm a.o

Sample output:

                     U __printf_chk
    0000000000000000 T main
    0000000000000000 T my_function
    0000000000000004 C my_var

TODO understand.

Types:

- `U`: TODO undefined?
- `C`: TODO constants? Used for BSS and data variables.
- `T`: TODO ? Used for functions.
