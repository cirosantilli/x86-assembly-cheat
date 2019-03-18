/* https://stackoverflow.com/questions/310974/what-is-tail-call-optimization/55230417#55230417 */

#include <stdio.h>
#include <stdlib.h>

unsigned factorial(unsigned n) {
    if (n == 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

int main(int argc, char **argv) {
    int input;
    if (argc > 1) {
        input = strtoul(argv[1], NULL, 0);
    } else {
        input = 5;
    }
    printf("%u\n", factorial(input));
    return EXIT_SUCCESS;
}
