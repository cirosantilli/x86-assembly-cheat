/* https://stackoverflow.com/questions/18024672/what-registers-are-preserved-through-a-linux-x86-64-function-call/55207335#55207335 */

#include <inttypes.h>

uint64_t inc(uint64_t i) {
    __asm__ __volatile__(
        ""
        : "+m" (i)
        :
        : "rax",
          "rbx",
          "rcx",
          "rdx",
          "rsi",
          "rdi",
          "rbp",
          "rsp",
          "r8",
          "r9",
          "r10",
          "r11",
          "r12",
          "r13",
          "r14",
          "r15",
          "ymm0",
          "ymm1",
          "ymm2",
          "ymm3",
          "ymm4",
          "ymm5",
          "ymm6",
          "ymm7",
          "ymm8",
          "ymm9",
          "ymm10",
          "ymm11",
          "ymm12",
          "ymm13",
          "ymm14",
          "ymm15"
    );
    return i + 1;
}

int main(int argc, char **argv) {
    (void)argv;
    return inc(argc);
}
