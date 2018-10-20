%include "lib/common_nasm.inc"

ENTRY
    ; Immediate.
    mov eax, 1
    add eax, 2
    ASSERT_EQ eax, 3

    ; Register.
    mov eax, 1
    mov ebx, 2
    add eax, ebx
    ASSERT_EQ eax, 3

    ; ERROR: second register must be same size
    ;add ax,al
    ;add ax,eax
EXIT
