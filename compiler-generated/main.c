/*
One example pre function so that it is easy to find on the outputs.

Each function must have a side effect
*/

#include <stdio.h>
#include <string.h>

int memcmp_test(char* s, char* t, int n) {
    return memcmp(s, t, n);
}

int memcmp_test_fixed(char* s, char* t) {
    return memcmp(s, t, 2);
}

int main() {
    return 0;
}
