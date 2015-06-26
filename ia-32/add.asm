; # ADD

%include "lib/asm_io.inc"

ENTRY
    mov eax, 0
    add eax, 1
    ASSERT_EQ 1

    mov eax, 0
    mov ebx, 1
    add eax, ebx
    ASSERT_EQ 1

    ; ERROR: second register must be same size
    ;add ax,al
    ;add ax,eax

    EXIT
