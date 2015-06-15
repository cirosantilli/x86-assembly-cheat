void f(int *a, int *b, int *x) {
    *a += *x;
    *b += *x;
}

void fr(int *restrict a, int *restrict b, int *restrict x) {
    *a += *x;
    *b += *x;
}

int main() {
    return 0;
}
