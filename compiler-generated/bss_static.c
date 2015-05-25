#include <stdio.h>

/*
Since this is not visible from the outside because static,
GCC can just ignore the label and inline it everywhere.
*/
static int my_var = 0;

int main() {
    printf("%d\n", my_var + 1);
    return 0;
}
