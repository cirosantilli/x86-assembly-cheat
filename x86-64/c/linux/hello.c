#define _XOPEN_SOURCE 700
#include <inttypes.h>
#include <sys/types.h>

ssize_t my_write(int fd, const void *buf, size_t size) {
    ssize_t ret;
    __asm__ __volatile__ (
        "syscall"
        : "=a" ((int64_t)ret)
        : "0"(1), "D"(fd), "S"((int64_t)buf), "d"((uint64_t)size)
        : "cc", "rcx", "r11", "memory"
    );
    return ret;
}

void my_exit(int exit_status) {
    ssize_t ret;
    __asm__ __volatile__ (
        "syscall"
        : "=a" ((int64_t)ret)
        : "0" ((int64_t)60), "D" ((int64_t)exit_status)
        : "cc", "rcx", "r11", "memory"
    );
}

void _start(void) {
    char msg[] = "hello world\n";
    my_exit(my_write(1, msg, sizeof(msg)) != sizeof(msg));
}
