; # INC

; # ++

    ; eax++


%include "lib/asm_io.inc"

ENTRY
    mov eax, 0
    inc eax
    ASSERT_EQ 1
    EXIT
