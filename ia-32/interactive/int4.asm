; # int 4

    ; Mostly to compare with int 3.

    ; Segfaults. TODO why?

%include "lib/asm_io.inc"

ENTRY
    int 4
    EXIT
