/* # type

https://sourceware.org/binutils/docs/as/Type.html#Type

Observe the generated object file with `readelf -s`.
*/

#include "lib/common_gas.h"

ENTRY
EXIT

/*
In ELF, adds the STT_FUNC type to the symbol.
GCC emmits those automatically for C functions, even in `-g0`.

The at sign `@` is mandatory and has no meaning.
*/
.type myfunc, @function
.global myfunc
myfunc:

.global myfunc_notype
myfunc_notype:
