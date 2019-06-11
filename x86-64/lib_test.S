# Expected outcome: print 1234567812345678 to stdout.
#include <lkmc.h>
LKMC_PROLOGUE
    mov $1234567812345678, %rdi
    call print_long
LKMC_EPILOGUE
