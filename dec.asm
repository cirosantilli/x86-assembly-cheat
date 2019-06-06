; Decrement: i--.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 1
    ; eax--
    dec eax
    LKMC_ASSERT_EQ_32(%eax, $0)
LKMC_EPILOGUE
