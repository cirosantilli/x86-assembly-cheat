; # BTS

    ; BT + Set.

    ; TODO confirm: synchronization primitive. http://wiki.osdev.org/Spinlock

%include "lib/common_nasm.inc"

ENTRY
    mov ax, 0x0A
    bts ax, 0
    ASSERT_EQ ax, 0x0B
    ASSERT_FLAG jnc

    mov ax, 0x0A
    bt ax, 1
    ASSERT_FLAG jc
    ASSERT_EQ ax, 0x0A

EXIT
