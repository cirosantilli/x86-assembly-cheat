#include "lib/common_gas.h"
LKMC_PROLOGUE
    mov $12345678, %eax
    call print_int
LKMC_EPILOGUE
