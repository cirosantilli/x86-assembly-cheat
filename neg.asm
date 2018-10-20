; Negate: i *= -1.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 2
    neg eax
    ASSERT_EQ eax, -2
    neg eax
    ASSERT_EQ eax, 2
EXIT
