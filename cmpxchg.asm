; # CMPXCHG

    ; Synchronization primitive.

        ; cmpxchg x, y

    ; Can have the LOCK prefix, but that is useless as it has lock semantics by default.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 0
    mov ebx, 1
    mov ecx, 2
    cmpxchg ebx, ecx
    ASSERT_FLAG jnz
    ; TODO
    ;LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $1)
    LKMC_ASSERT_EQ_32(%ecx, $2)

    mov eax, 0
    mov ebx, 0
    mov ecx, 2
    cmpxchg ebx, ecx
    ASSERT_FLAG jz
    LKMC_ASSERT_EQ_32(%eax, $0)
    LKMC_ASSERT_EQ_32(%ebx, $2)
    LKMC_ASSERT_EQ_32(%ecx, $2)

LKMC_EPILOGUE
