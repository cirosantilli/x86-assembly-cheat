/* Simple function that takes two ints and returns a third. */

#include <stdio.h>

/*
GCC 4.8 -O3 reduces this to a single lea.
*/
int my_function(int i, int j) {
    int k;
    k = i + j;
    return k;
}

int main() {
    /*
    GCC 4.8 -O3 resolves the function call into a constant.
    */
    printf("%d\n", my_function(1, 2));
    return 0;
}
