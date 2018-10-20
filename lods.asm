; # lods

    ; Load data a and move `esi`.

    ; Does not touch edi.

%include "lib/common_nasm.inc"

DATA

    bs4 db 0, 1

ENTRY

    mov esi, bs4
    mov edi, 0

    cld
    ; Increase ESI
    lodsb
    ASSERT_EQ al, 0
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ eax, 1
    ASSERT_EQ edi, 0

    std
    ; Decrease ESI
    lodsb
    ASSERT_EQ al, 1
    mov eax, esi
    sub eax, bs4
    ASSERT_EQ eax, 0
    ASSERT_EQ edi, 0

EXIT
