# jmp can take a memory location, dereference it, and jump to that location.
#
# Using tables of such jump destinations can be used to implement switch in constant time.

#include <lkmc.h>

RODATA

    table dd label, label2

LKMC_PROLOGUE

    jmp *table
    ASSERT_FAIL
    label: 
    jmp [table + 4]
    ASSERT_FAIL
    label2: 

LKMC_EPILOGUE
