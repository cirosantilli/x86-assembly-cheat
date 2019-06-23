%include "lib/common_nasm.inc"

ENTRY

    ; # RIP relative addressing

        ; New addressing mode in which addresses are encoded relative to the RIP.

        ; Advantages:

        ; - easier to write RIP code for shared libraries: with RIP you can just dump
            ; the `.text` and `.data` anywhere without rewritting all data accesses beforehand

        ; - genrates shorter instructions, using 4 bytes to encode the address instead of 8.

            ; This seems to be the main reason why GCC 4.8 uses it by default everywhere.

            ; Downside of this: `.data` and `.text` must be withing 4Gb of each other.
            ; But that should be fine.

        ; It does not seem to be possible to use it with Intel syntax directly:

            ;lea rax, [rip]
            ;lea rax, [rip + 4]

        ; Instead, it seems that you must use the `rel` or `abs` keyword,
        ; and possibly set their defaults http://www.nasm.us/doc/nasmdoc6.html#section-6.2.1 :

            ;lea rax, [rel _start]
            ;lea rax, [abs _start]
            ;lea rax, $

    ; # pop only works with quadwords

        ; Some instructions do not work with operand sizes for which they work in 32 bit mode.
        ; E.g., you cannot do `pop eax`, only `pop rax`.

            ; ERROR
            ;pop eax

    ;mov rax, 1
    ;mov rdi, 1
    ;mov rsi, asserts_passed_str
    ;mov rdx, asserts_passed_str_len
    ;syscall

EXIT
