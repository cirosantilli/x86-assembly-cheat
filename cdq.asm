; Convert double word to quadword.
;
; Sign extend `eax` into `edx:eax`.
;
; Common combo with idiv 32-bit, which takes the input from `edx:eax`:
; so you need to set up `edx` before calling it.

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 1
    mov edx, 0x01234567
    cdq
    ASSERT_EQ edx, 0

    mov eax, -1
    mov edx, 0x01234567
    cdq
    ASSERT_EQ edx, 0xFFFFFFFF

EXIT
