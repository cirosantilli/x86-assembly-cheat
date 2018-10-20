#include "lib/common_gas.h"
ENTRY
    mov $12345678, %eax
    call print_int
EXIT
