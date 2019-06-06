# # Current address

# # $

#include <lkmc.h>

LKMC_PROLOGUE

    PRINT_INT $
    PRINT_INT $
    mov eax, $ + 1

    # Infinite loop.
    #jmp $

LKMC_EPILOGUE
