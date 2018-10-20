/*
# size

https://sourceware.org/binutils/docs/as/Size.html#Size

Observe the generated object file with `readelf -s`.
*/

#include "lib/common_gas.h"

ENTRY
EXIT

/*
In ELF, adds st_size attribute of a symbol.
GCC emmits those automatically for C functions, even in `-g0`, as: .size main, .-main
*/
.type myfunc, @function
.global myfunc
myfunc:
    nop
.size myfunc, . - myfunc

/*
Without it, it just gets set to 0, it means unknown size.
*/
.type myfunc_nosize, @function
.global myfunc_nosize
myfunc_nosize:
    nop

.global myfunc_nosize2
myfunc_nosize2:
    nop
