#include <stdio.h>

int main() {
    /*
    GCC 4.8 uses __printf_chk by default,
    which is part of the LSB and safer than printf:
    http://refspecs.linuxbase.org/LSB_4.1.0/LSB-Core-generic/LSB-Core-generic/libc---printf-chk-1.html
    */
    puts("Hello world!");
    return 0;
}
