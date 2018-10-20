; # int3

    ; http://unix.stackexchange.com/questions/131044/dialog-trap-and-sigtrap

%include "lib/common_nasm.inc"

ENTRY
    int3
    ; 2 byte encoding.
    int 3
EXIT
