; Signed multiply.
;
; Has many more forms than the unsigned version,
; including immediate and up to three arguments.

%include "lib/common_nasm.inc"

ENTRY
    ; eax = ebx * 3
    mov eax, 0
    mov ebx, 2
    imul eax, ebx, 3
    ASSERT_EQ eax, 6

    ; eax = eax * eax
    mov eax, 2
    mov ebx, 3
    imul ebx
    ASSERT_EQ eax, 6
    ASSERT_EQ ebx, 3

    ; eax = eax * eax
    mov eax, -2
    imul eax
    ASSERT_EQ eax, 4

    ; eax = eax * 3
    mov eax, 2
    imul eax, 3
    ASSERT_EQ eax, 6

EXIT
