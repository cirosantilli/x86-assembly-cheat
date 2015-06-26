; # CMOVcc

    ; mov if a condition is met.

        ; CMOVxx a, b

    ; Equals:

        ; if(flag) a = b

%include "lib/asm_io.inc"

ENTRY

    clc
    mov eax, 0
    mov ebx, 1
    cmovc eax, ebx
    ASSERT_EQ 0

    clc
    mov eax, 0
    mov ebx, 1
    cmovnc eax, ebx
    ASSERT_EQ 1

    stc
    mov eax, 0
    mov ebx, 1
    cmovc eax, ebx
    ASSERT_EQ 1

    ; ERROR: must be address
    ; cmovc eax, 1

    EXIT
