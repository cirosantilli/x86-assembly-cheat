/*
GCC 4.8: jump table

- https://en.wikipedia.org/wiki/Indirect_branch
- http://stackoverflow.com/questions/9223756/what-does-an-asterisk-before-an-address-mean-in-x86-64-att-assembly

Basically becomes something like:

    400661:       83 7d fc 05             cmpl   $0x5,-0x4(%rbp)
    400665:       77 42                   ja     4006a9 <main+0x8c>
    400667:       8b 45 fc                mov    -0x4(%rbp),%eax
    40066a:       48 8b 04 c5 60 07 40    mov    0x400760(,%rax,8),%rax
    400671:       00 
    400672:       ff e0                   jmpq   *%rax
    400674:       c7 45 f8 00 00 00 00    movl   $0x0,-0x8(%rbp)
    40067b:       eb 2c                   jmp    4006a9 <main+0x8c>
    40067d:       c7 45 f8 01 00 00 00    movl   $0x1,-0x8(%rbp)
    400684:       eb 23                   jmp    4006a9 <main+0x8c>

which checks if `i > 5`, and if not uses a jump table stored at
`400760` in the `.rodata`, that contains the address of each case in an array.

The `.rodata` is relocated to contain text addresses.
*/

#include <stdio.h>
#include <time.h>

int main() {
    int i, j;
    i = time(NULL) % 6;
    switch (i) {
        case 0:
            j = 0;
        break;
        case 1:
            j = 1;
        break;
        case 2:
            j = 2;
        break;
        case 3:
            j = 3;
        break;
        case 4:
            j = 4;
        break;
        case 5:
            j = 5;
        break;
    };
    printf("%d\n", j);
    return 0;
}
