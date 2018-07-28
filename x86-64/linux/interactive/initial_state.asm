; Initial register state.

; Pass output through hd.

%include "common.inc"

section .text

    global _start
    _start:

        write64 rax
        write64 rbp
        write64 rbx
        write64 rcx
        write64 rdi
        write64 rdx
        write64 rsi
        write64 rsp
        write64 r8
        write64 r9
        write64 r10
        write64 r11
        write64 r12
        write64 r13
        write64 r14
        write64 r15

        sys_exit
