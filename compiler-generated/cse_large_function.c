/*
# CSE large function
Why can't GCC 4.8 -O3 with vamped up CSE `--param`s not factorize
the expensive `contPrimesLessThan` call?

Origin: http://stackoverflow.com/a/1983492/895245
*/

#include <stdio.h>

/*int isPrime(int) __attribute__((const));*/
int isPrime(int p)  {
    for (int i = 2; i*i <= p; ++i)  {
        if ((p % i) == 0) return 0;
    }
    return 1;
}

/*int countPrimesLessThan(int) __attribute__((const));*/
int countPrimesLessThan(int max)  {
    int count = 0;
    for (int i = 2; i < max; ++i) {
        if (isPrime(i)) ++count;
    }
    return count;
}

int main() {
    for (int i = 0; i < 5; ++i) {
        printf("%d\n", countPrimesLessThan(1000*1000));
    }
}
