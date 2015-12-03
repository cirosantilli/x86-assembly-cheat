; # xchg

%include "lib/asm_io.inc"

ENTRY
    mov eax, 0
    mov ebx, 1

    xchg eax, ebx
    ASSERT_EQ 1
    ASSERT_EQ ebx, 0

    xchg eax, ebx
    ASSERT_EQ 0
    ASSERT_EQ ebx, 1

    EXIT
