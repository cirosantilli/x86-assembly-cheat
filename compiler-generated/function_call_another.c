/*
A function that calls another.
*/

#include <stdio.h>
#include <time.h>

int func1(int i, int j, int k) {
    int l;
    l = i + j + k;
    return l;
}

/*
This function calls another function.

In rsp must be moved to:

- store all arguments and local variables.
- align to 0x10 in x86-64
*/
int func0(int i, int j, int k) {
    int l;
    l = func1(i, j, k);
    return l;
}

int main() {
    printf("%d\n", func0(1, 2, 3));
    return 0;
}
