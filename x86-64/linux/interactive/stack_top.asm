; See what `rsp` is worth at initialization.
;
; Similar to IA-32, except that this time we are at around 2^48 = 256 TiB.
;
; Should be piped into hd.

%include "common.inc"

section .text

    global _start
    _start:

        write64 rsp
        push 1
        write64 rsp

        sys_exit
