; Subtraction.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 1
    sub eax, 1
    ASSERT_EQ eax, 0
EXIT
