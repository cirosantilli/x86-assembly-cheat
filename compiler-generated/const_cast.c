#include <stdio.h>

const int my_var = 1;

int main() {
    int* ip = (int*)&my_var;
    /*
    Segfaults, since my_var is in rodata.

    Fine since this is C undefined behaviour.
    */
    *ip = 2;
    return 0;
}
