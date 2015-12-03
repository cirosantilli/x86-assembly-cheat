; Hand made encoding tests to see what the CPU will accept.

%include "lib/asm_io.inc"

ENTRY
    ; TODO: make work?
    ;mov eax, 0
    ;db 0x66
    ;db 0x66
    ;db 0x66
    ;db 0x66
    ;db 0x66
    ;db 0x66
    ;db 0x66
    ;db 0x66
    mov eax, 1
    ASSERT_EQ 1
    EXIT
