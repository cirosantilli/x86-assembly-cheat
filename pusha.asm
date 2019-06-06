; # pusha

; # popa

    ; Push and restore the following registers using the stack:
    ; EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI

    ; This is important for example in the C calling convention,
    ; where certain registers must not be changed by functions.

#include <lkmc.h>

LKMC_PROLOGUE

    mov ebx, 0
    mov ecx, 0

    mov eax, esp
    pusha
    sub eax, esp
    ; 8x 4 bytes
    LKMC_ASSERT_EQ_32(%eax, $32)

    mov ebx, 1
    mov ecx, 1
    popa
    LKMC_ASSERT_EQ_32(%ebx, $0)
    LKMC_ASSERT_EQ_32(%ecx, $0)

LKMC_EPILOGUE
