/* https://stackoverflow.com/questions/15663280/how-to-make-the-gnu-assembler-use-a-slash-for-comments/51991349#51991349 */

#include "lib/common_gas.h"

ENTRY
    // mycomment
    # mycomment
#if 0
    nop # mycomment
#endif
    nop // mycomment
    EXIT
