; # MOVSX

    ; mov and sign extend

    ; In 2s complement, just extend sign bit.
    ; There are many anterior commands that do this
    ; for specific sizes, created before 32 bit registers.

%include "lib/common_nasm.inc"

ENTRY

    mov eax, 0
    mov ax, -1
    movsx eax, ax
    ASSERT_EQ eax, -1

EXIT
