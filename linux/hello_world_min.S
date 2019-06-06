# Minimized hello world.
#
# - put the string directly at the end of the `.text` section. Generates ugly `objdump`, but works fine.
# - remove explicit `section .text` as NASM defaults to it when no section is specified
#
# We could also:
#
# -  remove `_start` as `ld` defaults to `.text` when the `LKMC_PROLOGUE` symbol is not specified
#
#    But that would generate warnings.

.global _start
_start: 
    movl $4,%eax
    movl $1,%ebx
    movl $hello_world, %ecx
    movl $hello_world_len, %edx
    int $0x80
    movl $1,%eax
    movl $0,%ebx
    int $0x80
hello_world db "hello world", 10
hello_world_len  equ $ - hello_world
