/* Stuff that ld might define. */

#include <stdio.h>

#define F(x) extern char x; \
    printf(#x " = %p\n", &x);

int main() {
    F(etext)
    F(edata)
    F(end)
    F(__data_start)
    F(_GLOBAL_OFFSET_TABLE_)
    return 0;
}
