; # int 4

    ; Mostly to compare with int 3.

    ; Segfaults. TODO why?

#include <lkmc.h>

LKMC_PROLOGUE
    int 4
LKMC_EPILOGUE
