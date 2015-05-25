#include <stdio.h>
#include <string.h>

int my_func(char* s, char* t, int n) {
    return memcmp(s, t, n);
}

int main() {
    printf("%d\n", my_func("a", "b", 2));
    return 0;
}
