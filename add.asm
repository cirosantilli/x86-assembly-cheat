%include "lib/asm_io.inc"

ENTRY
    ; Immediate.
    mov eax, 1
    add eax, 2
    ASSERT_EQ 3

    ; Register.
    mov eax, 1
    mov ebx, 2
    add eax, ebx
    ASSERT_EQ 3

    ; ERROR: second register must be same size
    ;add ax,al
    ;add ax,eax

    EXIT
