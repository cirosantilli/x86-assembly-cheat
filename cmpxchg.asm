; # CMPXCHG

    ; Synchronization primitive.

        ; cmpxchg x, y

    ; Can have the LOCK prefix, but that is useless as it has lock semantics by default.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 0
    mov ebx, 1
    mov ecx, 2
    cmpxchg ebx, ecx
    ASSERT_FLAG jnz
    ; TODO
    ;ASSERT_EQ eax, 0
    ASSERT_EQ ebx, 1
    ASSERT_EQ ecx, 2

    mov eax, 0
    mov ebx, 0
    mov ecx, 2
    cmpxchg ebx, ecx
    ASSERT_FLAG jz
    ASSERT_EQ eax, 0
    ASSERT_EQ ebx, 2
    ASSERT_EQ ecx, 2

EXIT
