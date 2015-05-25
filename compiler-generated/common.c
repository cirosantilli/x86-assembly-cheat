#include <stdio.h>

/* Contrast with the Common and Data sections. */
int my_var;

int main() {
    my_var = 0;
    printf("%d\n", my_var + 1);
    return 0;
}
