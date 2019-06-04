; Integer division.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, -5
    ; Don't forget this!
    cdq
    mov ecx, -2
    idiv ecx
    LKMC_ASSERT_EQ(%eax, $2)
    LKMC_ASSERT_EQ edx, -1

    mov eax, 1
    mov edx, 1
    mov ecx, 4
    idiv ecx
    LKMC_ASSERT_EQ(%eax, $0x40000000)
    LKMC_ASSERT_EQ(%edx, $1)

    ; RUNTIME ERROR: result must fit into signed dword:
    ;mov eax, 1
    ;mov edx, 1
    ;mov ecx, 2
    ;idiv ecx

    ; TODO division by zero

LKMC_EPILOGUE
