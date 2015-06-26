; # IMUL

    ; Signed multiply

        ; edx:eax = TODO

%include "lib/asm_io.inc"

ENTRY
    mov eax, 2
    mov ebx, 2
    imul ebx
    ASSERT_EQ 4
    ASSERT_EQ ebx, 2

    mov eax, -2
    imul eax
    ASSERT_EQ 4

    mov eax, 2
    imul eax, 2
    ASSERT_EQ 4

    mov eax, 0
    mov ebx, 2
    imul eax, ebx, 2
    ASSERT_EQ 4

    EXIT
