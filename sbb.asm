; Subtract with borrow:
;
;     edx:eax -= ebx:ecx

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 0
    mov ebx, 0
    mov ecx, 0x80000000
    mov edx, 1

    sub eax, ecx
    sbb edx, ebx

    LKMC_ASSERT_EQ_32(%eax, $0x80000000)
    LKMC_ASSERT_EQ_32(%edx, $0)

LKMC_EPILOGUE
