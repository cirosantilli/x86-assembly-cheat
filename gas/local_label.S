/*
# Local label

https://sourceware.org/binutils/docs/as/Symbol-Names.html#Symbol-Names

Labels that contain only digits are magic and can be defined multiple times:

You can then write `1b` and `1f` to refer to the latest and next definition of such labels.

Such labels don't appear on the output file.
*/

#include "lib/common_gas.h"

ENTRY
    /* Basic forward local jump. */
    1:
    jmp 1f
    ASSERT_FAIL
    1:

    /* Example with a backwards jump. */
    jmp 2f
    ASSERT_FAIL
    1:
    jmp 3f
    ASSERT_FAIL
    2:
    jmp 1b
    ASSERT_FAIL
    3:

EXIT
