; # add
;
; Let's use the venerable add instruction as an intro to
; some important language examples.

#include <lkmc.h>

DATA
    myint dd 0x1234_5678

LKMC_PROLOGUE
    ; Immediate and register.
    ; eax = 1
    mov eax, 1
    ; eax += 2
    add eax, 2
    ; assert(eax == 3)
    LKMC_ASSERT_EQ_32(%eax, $3)

    ; Register and register.
    mov eax, 1
    mov ebx, 2
    add eax, ebx
    LKMC_ASSERT_EQ_32(%eax, $3)

    ; Memory and register.
    mov eax, [myint]
    LKMC_ASSERT_EQ_32(%eax, $0x1234_5678)

    ; Memory and immediate.
    add dword [myint], 1
    LKMC_ASSERT_EQ_32 [myint], 0x1234_5679, dword

    ; ERROR: second register must be same size
    ;add ax,al
    ;add ax,eax
LKMC_EPILOGUE
