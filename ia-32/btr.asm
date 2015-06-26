; # btr

    ; BT + reset.

%include "lib/asm_io.inc"

ENTRY
    mov ax, 0x0A
    btr ax, 1
    ASSERT_EQ ax, 8
    ASSERT_FLAG jc
    EXIT
