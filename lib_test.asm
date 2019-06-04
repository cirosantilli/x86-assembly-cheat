; Test that we can use compiled functions of our library.
;
; Expected outcome: print 12345678 to stdout.

#include <lkmc.h>

LKMC_PROLOGUE
    mov eax, 12345678
    call print_int
LKMC_EPILOGUE
