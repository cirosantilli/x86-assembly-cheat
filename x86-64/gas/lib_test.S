#include "lib/common_gas.h"
ENTRY
    mov $1234567812345678, %rdi
    call print_long
EXIT
