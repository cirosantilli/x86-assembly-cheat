; Signed multiply.
;
; Has many more forms than the unsigned version,
; including immediate and up to three arguments.

#include <lkmc.h>

LKMC_PROLOGUE
    ; eax = ebx * 3
    mov eax, 0
    mov ebx, 2
    imul eax, ebx, 3
    LKMC_ASSERT_EQ_32(%eax, $6)

    ; eax = eax * eax
    mov eax, 2
    mov ebx, 3
    imul ebx
    LKMC_ASSERT_EQ_32(%eax, $6)
    LKMC_ASSERT_EQ_32(%ebx, $3)

    ; eax = eax * eax
    mov eax, -2
    imul eax
    LKMC_ASSERT_EQ_32(%eax, $4)

    ; eax = eax * 3
    mov eax, 2
    imul eax, 3
    LKMC_ASSERT_EQ_32(%eax, $6)

LKMC_EPILOGUE
