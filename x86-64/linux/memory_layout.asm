%include "common.inc"

section .text
    global _start
    _start:
        write64 _start
        sys_exit
