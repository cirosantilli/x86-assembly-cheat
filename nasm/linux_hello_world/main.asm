;minimal program for compilation test
;simply returns exit status 0

section .data

	;10 = \n in ascii:
    hello_world db "hello world", 10
	;does an address offset:
	hello_world_len  equ $ - hello_world

section .text

    ;export the symbol `_start` to the object file.
    ;this is not done by default

    ;`_start` is the conventional name for the entry point for the linker
    ;so it should just work. If you want another name, you can tell your linker
    ;to use another entry point ( with `-e` on the gnu linker `ld` for example)
    global _start

_start:

    ;call linux write system call
	mov eax, 4         ;sys_write call number
	mov ebx, 1         ;file descriptor 1 = stdout
	mov ecx, hello_world		;string to write
	mov edx, hello_world_len	;number of bytes to write
	int 80h

    ;call linux exit system call
    mov eax, 1  ;sys_exit call number
	mov	ebx, 0	;exit status
    int 0x80	;call kernel
