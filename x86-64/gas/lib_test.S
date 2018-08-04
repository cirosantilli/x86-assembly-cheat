/* Test that we can use compiled functions of our library. */

#include "lib/asm_io_s.h"

ENTRY
    mov $0x12345678, %rdi
    call print_long_hex
    EXIT
