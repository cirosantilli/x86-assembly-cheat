;# mov zero extend

; http://stackoverflow.com/questions/11177137/why-do-most-x64-instructions-zero-the-upper-part-of-a-32-bit-register

; 32-bit operations, in particular mov, zero extend to 64 bits!

; This does not happen on 8 and 16 bit operations.

%include "lib/asm_io.inc"

ENTRY
    mov rax, 0x1234567812345678
    mov eax, 1
    ASSERT_EQ 1

    ; Does not happen for 16 and 8 bit.
    mov eax, 0x12345678
    mov ax, 1
    ASSERT_EQ 0x12340001

    mov eax, 0x12345678
    mov al, 1
    ASSERT_EQ 0x12345601

    EXIT
