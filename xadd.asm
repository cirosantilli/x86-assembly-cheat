; # XADD

    ; Add and swap.

    ; Useful syncrhonization primitive to make an atomc addition,
    ; this is how C++ atomic ++ is implemented in GCC 5.1.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 1
    mov ebx, 2
    xadd eax, ebx
    ASSERT_EQ eax, 3
    ASSERT_EQ ebx, 1
EXIT
