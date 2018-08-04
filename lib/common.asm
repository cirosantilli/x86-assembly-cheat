; Helper functions. Gets linked with every executable.
;
; Vs macros on included headers:
;
; - less NASM / GAS specific, and helps with portability across assemblers
; - more debug friendly, as you can properly step into the functions and see source

%define STRING_TERMINATOR 0
%define NEWLINE 10

extern printf, exit

; Print error message and exit program with status 1.
;
; Usually called with the `assert_fail` macro,
; which also prepares the line number.
;
; The line number must be set in a macro
; otherwise it would always point to this function.
;
; eax: line of the failure
;
global assert_fail
assert_fail:
    mov ebx, eax
    mov eax, .message
    call print_string
    mov eax, ebx
    call print_int
    ; Call libc exit with exit status 1:
    push dword 1
    call exit
.message db 10, 'ASSERT FAILED AT LINE: ', 0

; Print 32 bit integer in decimal.
global print_int
print_int:
    ; Prologue.
    enter 0,0
    pusha
    pushf
    ; Body.
    push eax
    push dword .format
    call printf
    pop ecx
    pop ecx
    ; Epilogue.
    popf
    popa
    leave
    ret
.format db "%i", NEWLINE, STRING_TERMINATOR

; Print a NUL terminated string.
global print_string
print_string:
    ; Prologue.
    enter 0,0
    pusha
    pushf
    ; Body.
    push eax
    push dword .format
    call printf
    pop ecx
    pop ecx
    ; Epilogue.
    popf
    popa
    leave
    ret
.format db "%s", NEWLINE, STRING_TERMINATOR
