#include "common.h"
.section .mydata, "a"
    STRING(s, "hello world\n")
.section .mytext, "ax"
    .global _start
    _start:
        WRITE(s)
    EXIT($0)
