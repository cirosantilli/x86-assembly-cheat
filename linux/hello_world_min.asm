; Minimized hello world.
;
; - put the string directly at the end of the `.text` section. Generates ugly `objdump`, but works fine.
; - remove explicit `section .text` as NASM defaults to it when no section is specified
;
; We could also:
;
; -  remove `_start` as `ld` defaults to `.text` when the `ENTRY` symbol is not specified
;
;    But that would generate warnings.

global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello_world
    mov edx, hello_world_len
    int 0x80
    mov eax, 1
    mov ebx, 0
    int 0x80
hello_world db "hello world", 10
hello_world_len  equ $ - hello_world
