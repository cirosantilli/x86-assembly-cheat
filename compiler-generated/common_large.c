#include <stdio.h>

/*
Does not occupy space on the binaries, only when the program loads:
http://stackoverflow.com/questions/610682/do-bss-section-zero-initialized-variables-occupy-space-in-elf-file
*/
int my_var[1000000];

int main() {
    my_var[0] = 1;
    printf("%d\n", my_var[0]);
    return 0;
}
