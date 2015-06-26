; # CDQ

    ; Convert double word to quadword.

    ; Sign extend `eax` into `edx:eax`.

    ; Common combo with idiv 32-bit.

%include "lib/asm_io.inc"

ENTRY
    mov eax, 1
    mov edx, 0
    cdq
    ASSERT_EQ edx, 0

    mov eax, -1
    mov edx, 0
    cdq
    ASSERT_EQ edx, 0x0FFFFFFFF

    EXIT
