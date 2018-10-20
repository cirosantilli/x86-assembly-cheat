; # SETcc

    ; Set version of CMOVcc

%include "lib/common_nasm.inc"

ENTRY

    mov eax, 0

    stc
    setc al
    ASSERT_EQ eax, 1

    clc
    setc al
    ASSERT_EQ eax, 0

    ; ERROR: only for 8 bit registers or memory.
    ;setc eax

EXIT
