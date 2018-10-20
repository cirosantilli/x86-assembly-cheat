; Integer division.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, -5
    ; Don't forget this!
    cdq
    mov ecx, -2
    idiv ecx
    ASSERT_EQ eax, 2
    ASSERT_EQ edx, -1

    mov eax, 1
    mov edx, 1
    mov ecx, 4
    idiv ecx
    ASSERT_EQ eax, 0x40000000
    ASSERT_EQ edx, 1

    ; RUNTIME ERROR: result must fit into signed dword:
    ;mov eax, 1
    ;mov edx, 1
    ;mov ecx, 2
    ;idiv ecx

    ; TODO division by zero

EXIT
