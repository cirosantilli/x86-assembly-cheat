/* https://stackoverflow.com/questions/51008231/how-to-check-the-version-of-binutils-on-gnu-gas-assembly-code-at-compile-time */

#include "lib/common_gas.h"

ENTRY
.if .gasversion. >= 22800 && .gasversion. < 22900
    PRINT_STRING_LITERAL("bug")
.else
    PRINT_STRING_LITERAL("no bug")
.endif
EXIT
