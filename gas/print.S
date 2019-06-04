/*
# print

    Just print a string.

# warn

    Print the warning.

# error

    Print it and stop compilation.

# Expected output

    print
    print.S: Assembler messages:
    print.S:5: Warning: warn
    print.S:6: Error: error
*/

#include "lib/common_gas.h"

LKMC_PROLOGUE
    /*
    .print "print"
    .warning "warn"
    .error "error"
    */
LKMC_EPILOGUE
