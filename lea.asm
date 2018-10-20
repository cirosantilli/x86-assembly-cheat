; # LEA

    ; Load Effective Address

    ; Do an addressing calculation, and store the **address**,
    ; not the value at that memory location as would be done with `mov`.

    ; Often used in an attempt to speed up arithmetic operations.

    ; # LEA vs ADD

    ; # LEA vs MOV

        ; http://stackoverflow.com/questions/6323027/lea-or-add-instruction

        ; http://stackoverflow.com/questions/1699748/what-is-the-difference-between-mov-and-lea

        ; GCC 4.8 uses lea by default.

        ; For immediates, interchangable with mov.

%include "lib/common_nasm.inc"

ENTRY
    ; TODO example
EXIT
