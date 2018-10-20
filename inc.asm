; Increment, i++.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 0
    ; eax++
    inc eax
    ASSERT_EQ eax, 1
EXIT
