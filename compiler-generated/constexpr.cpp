#include <iostream>

/* .rodata, not SHN_ABS. */
constexpr int my_var = 1;

int main() {
    std::cout << my_var << std::endl;
}
