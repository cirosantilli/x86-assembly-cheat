;minimal program for compilation test

;simply returns exit status 0

section .text

    ;export the symbol `_start` to the object file.
    ;this is not done by default

    ;`_start` is the conventional name for the entry point for the linker
    ;so it should just work. If you want another name, you can tell your linker
    ;to use another entry point ( with `-e` on the gnu linker `ld` for example)
    global _start

_start:

    ;call linux exit system call
	mov	ebx, 0	;exit status
    mov eax, 1  ;system call number (sys_exit)
    int 0x80	;call kernel
