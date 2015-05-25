#include <stdio.h>

/* Goes to .rodata. */
const int my_var = 1;

int main() {
    /* Gets inlined. */
    printf("%d\n", my_var);
    return 0;
}
