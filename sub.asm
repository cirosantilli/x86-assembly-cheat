; Subtraction.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 1
    sub eax, 1
    ASSERT_EQ 0
    EXIT
