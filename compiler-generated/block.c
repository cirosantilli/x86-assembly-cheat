#include <stdio.h>

int main() {
    int i = 0;
    {
        int i = 1;
        printf("%d\n", i);
    }
    return 0;
}
