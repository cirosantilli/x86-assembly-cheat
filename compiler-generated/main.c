#include <stdio.h>
#include <string.h>

int memcmp_test(char* s, char* t, int n) {
    return memcmp(s, t, n);
}

int main() {
    printf("memcmp %d", memcmp_test("abc", "abc", 3));
    return 0;
}
