#include <stdio.h>

int global = 0;

int my_function() {
    /*
    Is the compiler smart enough to move global into `rax` to increment it,
    to reuse that for the return value?

    For GCC 4.8:

    - without `-O3`: rax used by default, but an extra mov from global to eax is done
    - with `O3`: no extra move. TODO find exact flag that enables this.
    */
    global++;
    return global;
}

int main() {
    printf("%d\n", my_function());
    printf("%d\n", my_function());
    return 0;
}
