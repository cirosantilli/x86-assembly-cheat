/* # equ
 *
 * # set
 *
 *     `.equ` and `.set` are the same.
 *
 *     http://stackoverflow.com/questions/21624155/difference-between-equ-and-word-in-arm-assembly
 *
 *     - https://sourceware.org/binutils/docs/as/Equ.html
 *     - https://sourceware.org/binutils/docs/as/Set.html
 */

#include "lib/common_gas.h"

.data

    .equ asdf, 0x1234567

ENTRY

    .equ x, 0x1234567
    mov $0, %eax
    mov $x, %eax
    ASSERT_EQ($0x1234567, %eax)

    .set y, 0x1234567
    mov $0, %eax
    mov $y, %eax
    ASSERT_EQ($0x1234567, %eax)


    /* TODO: vs macro?
     *
     * One difference is that expressions can be used. Is that the main one?
     */

    .set y, 2 * 1 + 1
    mov $0, %eax
    mov $y, %eax
    ASSERT_EQ($0x3, %eax)

EXIT
