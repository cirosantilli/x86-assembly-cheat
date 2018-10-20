; # pusha

; # popa

    ; Push and restore the following registers using the stack:
    ; EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI

    ; This is important for example in the C calling convention,
    ; where certain registers must not be changed by functions.

%include "lib/common_nasm.inc"

ENTRY

    mov ebx, 0
    mov ecx, 0

    mov eax, esp
    pusha
    sub eax, esp
    ; 8x 4 bytes
    ASSERT_EQ eax, 32

    mov ebx, 1
    mov ecx, 1
    popa
    ASSERT_EQ ebx, 0
    ASSERT_EQ ecx, 0

EXIT
