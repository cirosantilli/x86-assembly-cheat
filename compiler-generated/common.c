#include <stdio.h>

/*
Goes to `.common` on the `.o`, and `.bss` on the `.out`
if not defined in any other file linked to (the case here).

GCC 4.8 does not use weak symbols by default. TODO why?

`.common` seems to be treated magically by the linker.
*/
int my_var;

int main() {
    my_var = 0;
    printf("%d\n", my_var + 1);
    return 0;
}
