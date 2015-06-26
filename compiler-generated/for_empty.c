/*
# for empty

GCC 4.8 -O0: stays
GCC 4.8 -O3: optimized away
*/

int main() {
    int i;
    for (i = 0; i < 16; i++)
        ;
    return 0;
}
