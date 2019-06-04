; Add with carry.
;
; edx:eax += ebx:ecx

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 0x80000000
    mov ecx, 0x80000000
    mov ebx, 0
    mov edx, 0
    add eax, ecx
    adc edx, ebx
    LKMC_ASSERT_EQ(%eax, $0)
    LKMC_ASSERT_EQ(%edx, $1)
LKMC_EPILOGUE
