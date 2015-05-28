#include <cstdio>

/* .rodata, not SHN_ABS */
constexpr int my_var = 1;

int main() {
    std::printf("%d\n", my_var);
    return 0;
}
