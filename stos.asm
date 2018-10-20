; # stos

    ; Store from `a` and move `edi`

%include "lib/common_nasm.inc"

section .data

    bs4 db 0, 1, 2, 3
    bs4_2 db 0, 0, 0, 0

ENTRY

    mov edi, bs4

    cld
    mov bl, 1
    mov al, bl
    stosb
    ASSERT_EQ [bs4], bl
    mov eax, edi
    sub eax, bs4
    ASSERT_EQ eax, 1

    std
    mov bl, 2
    mov al, bl
    stosb
    ASSERT_EQ [bs4 + 1], bl
    mov eax, edi
    sub eax, bs4
    ASSERT_EQ eax, 0

    cld

EXIT
