; Negate: i *= -1.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 2
    neg eax
    ASSERT_EQ -2
    neg eax
    ASSERT_EQ 2
    EXIT
