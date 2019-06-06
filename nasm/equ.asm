; # equ

    ; http://stackoverflow.com/a/33148242/895245

#include <lkmc.h>

DATA
    global x
    x: equ 1 + 1
    y: dd 1 + 1
LKMC_PROLOGUE
    mov eax, x
    LKMC_ASSERT_EQ_32(%eax, $2)
    mov eax, [y]
    LKMC_ASSERT_EQ_32(%eax, $2)
LKMC_EPILOGUE
