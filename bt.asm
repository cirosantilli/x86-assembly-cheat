; # BT

    ; Bit test.

        ; bt ax, i
        ; CF = ( ax[i] == 1 ) ? 1 : 0

%include "lib/common_nasm.inc"

ENTRY
    mov ax, 0x0A

    bt ax, 0
    ASSERT_FLAG jnc

    bt ax, 1
    ASSERT_FLAG jc

    bt ax, 2
    ASSERT_FLAG jnc

    bt ax, 3
    ASSERT_FLAG jc

    ; Unchanged
    ASSERT_EQ ax, 0x0A

    ; Not for bytes
    ;bt al, 0

EXIT
