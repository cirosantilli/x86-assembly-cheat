%macro save_syscall 0
    push rax
    push rdi
    push rsi
    push rdx
    push r10
    push r8
    push r9
%endmacro

%macro load_syscall 0
    pop rdx
    pop rsi
    pop rdi
    pop rax
    pop r9
    pop r8
    pop r10
%endmacro

; Write 64-bit register or address to stdtout in small endian.
;
; Registers are preserved.
;
; Sample calls:
;
;     write64 rax
;     write64 _start
;
; @param 1 the value to write
;
%macro write64 1
    save_syscall
    ; Must store the value in case it was passed
    ; as one of the registers used in the syscall.
    push rbx
    mov rbx, %1
    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    bswap rsi
    mov [rsp + 1], rsi
    lea rsi, [rsp + 1]
    mov rdx, 8
    syscall
    pop rbx
    load_syscall
%endmacro

%macro sys_exit 1
    mov rax, 60
    mov rdi, %1
    syscall
%endmacro

%macro sys_exit 0
    sys_exit 0
%endmacro
