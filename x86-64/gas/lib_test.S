#include "lib/common_gas.h"
LKMC_PROLOGUE
    mov $1234567812345678, %rdi
    call print_long
LKMC_EPILOGUE
