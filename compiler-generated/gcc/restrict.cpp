void f(int *a, int *b, int *x) {
    *a += *x;
    *b += *x;
}

void fr(int *__restrict__ a, int *__restrict__ b, int *__restrict__ x) {
    *a += *x;
    *b += *x;
}

int main() {}
