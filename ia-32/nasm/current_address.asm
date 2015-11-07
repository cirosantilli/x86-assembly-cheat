; # Current address

; # $

%include "lib/asm_io.inc"

ENTRY

    PRINT_INT $
    PRINT_INT $
    mov eax, $ + 1

    ; Infinite loop.
    ;jmp $

    EXIT
