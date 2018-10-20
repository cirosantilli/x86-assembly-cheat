; Subtract with borrow:
;
;     edx:eax -= ebx:ecx

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 0
    mov ebx, 0
    mov ecx, 0x80000000
    mov edx, 1

    sub eax, ecx
    sbb edx, ebx

    ASSERT_EQ eax, 0x80000000
    ASSERT_EQ edx, 0

EXIT
