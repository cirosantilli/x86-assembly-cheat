; # DEC

; # --

    ; eax--

%include "lib/asm_io.inc"

ENTRY
    mov eax, 1
    dec eax
    ASSERT_EQ 0
    EXIT
