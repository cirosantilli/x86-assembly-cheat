; # Current address

; # $

%include "lib/common_nasm.inc"

ENTRY

    PRINT_INT $
    PRINT_INT $
    mov eax, $ + 1

    ; Infinite loop.
    ;jmp $

EXIT
