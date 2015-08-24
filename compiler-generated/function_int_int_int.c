/*
Simple function that takes two ints and returns a third.
*/

#include <stdio.h>

/*
GCC 4.8 -O3 reduces this to a single lea.

At `-O0`, when there is no function call inside this function, `rsp` is not changed.
Such function is called a leaf function.

TODO why does the first variable go to `rbp - 0x14` instead of `rbp - 0x4`?
*/
int func0(int i, int j) {
    int k;
    k = i + j;
    return k;
}

int main() {
    /*
    GCC 4.8 -O3 resolves the function call into a constant.
    */
    printf("%d\n", func0(1, 2));
    return 0;
}
