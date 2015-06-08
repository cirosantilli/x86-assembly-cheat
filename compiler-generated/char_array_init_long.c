#include <stdio.h>

int main() {
    /* Multiple movs to stack. */
    char s[] = "abcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghiabcdefghi";
    printf("%s\n", s);
    return 0;
}
