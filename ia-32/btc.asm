; # btc

    ; BT + complement.

%include "lib/asm_io.inc"

ENTRY
    mov ax, 0x0A
    btc ax, 0
    ASSERT_EQ ax, 0x0B
    ASSERT_FLAG jnc

    mov ax, 0x0A
    btc ax, 1
    ASSERT_EQ ax, 0x08
    ASSERT_FLAG jc

    EXIT
