; # btr

    ; BT + reset.

%include "lib/common_nasm.inc"

ENTRY
    mov ax, 0x0A
    btr ax, 1
    ASSERT_EQ ax, 8
    ASSERT_FLAG jc
EXIT
