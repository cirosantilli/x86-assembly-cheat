; # TEST

    ; `test X, Y` is like `and` but only sets flags:

        ; ZF = (!(X && Y)) ? 1 : 0

    ; Contrast this with `cmp` which does `sub` instead of `and`.

    ; This file is named `test_instruction`
    ; so as to not conflict with the `test` make target.

%include "lib/common_nasm.inc"

ENTRY
    mov al, 0x0F0
    test al, 0
    ASSERT_FLAG jz
    ASSERT_EQ al, 0x0F0

    mov al, 0x0F0
    ASSERT_EQ al, 0x0F0
    test al, 0x0F0
    ASSERT_FLAG jnz
    ASSERT_EQ al, 0x0F0

    ; # test %eax, %eax vc cmp %eax, 0

        ; http://stackoverflow.com/questions/147173/x86-assembly-testl-eax-against-eax

        ; `test %eax, %eax` is often used instead of `cmp %eax, 0`
        ; as it generates shorter instructions:

EXIT
