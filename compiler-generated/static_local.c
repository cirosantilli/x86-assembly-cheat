#include <stdio.h>

int f() {
    static int i = 1;
    i++;
    return i;
}

int main() {
    printf("%d\n", f());
    printf("%d\n", f());
    return 0;
}
