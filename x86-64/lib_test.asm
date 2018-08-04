; Test that we can use compiled functions of our library.
%include "lib/asm_io.inc"
ENTRY
    mov rdi, 0x12345678
    call print_long_hex
    EXIT
