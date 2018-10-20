%include "lib/common_nasm.inc"

ENTRY

    ; # syscall

        ; Custom system call instruction added.

        ; Preferred way over int, may be faster.

        ; Used by Linux.

        ; Will not be further commented here as OS specific.

    ; # Registers

        ; General purpose registers got longer versions,
        ; and 8 new ones were extended: r8 through r15.

            mov rax, 0xFFFFFFFFFFFFFFFF
            mov rbx, 0xFFFFFFFFFFFFFFFF
            mov rcx, 0xFFFFFFFFFFFFFFFF
            mov rdx, 0xFFFFFFFFFFFFFFFF
            mov rsi, 0xFFFFFFFFFFFFFFFF
            mov rdi, 0xFFFFFFFFFFFFFFFF
            ;mov rbp, 0xFFFFFFFFFFFFFFFF
            ;mov rsp, 0xFFFFFFFFFFFFFFFF
            mov r8,  0xFFFFFFFFFFFFFFFF
            mov r9,  0xFFFFFFFFFFFFFFFF
            mov r15, 0xFFFFFFFFFFFFFFFF

    ; # RIP

        ; EIP in x86-64.

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

    ; # PUSHA

    ; # POPA

        ; `PUSHA` and `POPA` were removed from x86-64:
        ; http://stackoverflow.com/questions/6837392/how-to-save-the-registers-on-x86-64-for-an-interrupt-service-routine

            ; ERROR
            ;pusha
            ;popa

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
