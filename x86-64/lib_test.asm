; Expected outcome: print 1234567812345678 to stdout.
#include <lkmc.h>
LKMC_PROLOGUE
    mov rdi, 1234567812345678
    call print_long
LKMC_EPILOGUE
