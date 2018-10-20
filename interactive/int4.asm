; # int 4

    ; Mostly to compare with int 3.

    ; Segfaults. TODO why?

%include "lib/common_nasm.inc"

ENTRY
    int 4
EXIT
