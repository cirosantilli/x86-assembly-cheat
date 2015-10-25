; Assembly I/O routines
;
; Linux:
; nasm -f elf -d ELF_TYPE asm_io.asm
;
; DJGPP:
; nasm -f coff -d COFF_TYPE asm_io.asm
;
; Borland C++ 5.x:
; nasm -f obj -d OBJ_TYPE asm_io.asm
;
; Microsoft Visual Studio:
; nasm -f win32 -d COFF_TYPE asm_io.asm
;
; Watcom:
; nasm -f obj -d OBJ_TYPE -d WATCOM asm_io.asm
;
; The Watcom compiler's C library does not use the
; standard C calling convention. For example, the
; putchar() function gets its argument from the
; the value of EAX, not the stack.
;
; We prefer to implement as much routines as possible in here
; instead of macros so that they become less NASM specific
; and may be used through the compiled object file.

; String terminator.
%define TERM 0
; New line character.
%define NL 10
%define CF_MASK 0x00000001
%define PF_MASK 0x00000004
%define AF_MASK 0x00000010
%define ZF_MASK 0x00000040
%define SF_MASK 0x00000080
%define DF_MASK 0x00000400
%define OF_MASK 0x00000800

; for compiler portability, you must use macros
; to decide the actual name of
; stdlib functions inside the object files

;
; Linux C doesn't put underscores on labels
;
%ifdef ELF_TYPE
    %define _scanf scanf
    %define _printf printf
    %define _getchar getchar
    %define _putchar putchar
    %define _exit exit
%endif

;
; Watcom puts underscores at end of label
;
%ifdef WATCOM
    %define _scanf scanf_
    %define _printf printf_
    %define _getchar getchar_
    %define _putchar putchar_
    %define _exit exit_
%endif

%ifdef OBJ_TYPE
segment .data public align=4 class=data use32
%else
segment .data
%endif

    reg_format db "Register Dump # %d", NL
            db "EAX = %.8X EBX = %.8X ECX = %.8X EDX = %.8X", NL
                        db "ESI = %.8X EDI = %.8X EBP = %.8X ESP = %.8X", NL
                        db "EIP = %.8X FLAGS = %.4X %s %s %s %s %s %s %s", NL
                    db 0
    carry_flag db "CF", 0
    zero_flag db "ZF", 0
    sign_flag db "SF", 0
    parity_flag db "PF", 0
    overflow_flag db "OF", 0
    dir_flag db "DF", 0
    aux_carry_flag db "AF", 0
    unset_flag db " ", 0
    mem_format1 db "Memory Dump: Address = %.8X", NL, 0
    mem_format2 db "%.8X ", 0
    mem_format3 db "%.2X ", 0
    stack_format db "Stack Dump # %d", NL
                    db "EBP = %.8X ESP = %.8X", NL, 0
    stack_line_format db "%+4d %.8X %.8X", NL, 0
    math_format1 db "Math Coprocessor Dump # %d Control Word = %.4X"
                        db " Status Word = %.4X", NL, 0
    valid_st_format db "ST%d: %.10g", NL, 0
    invalid_st_format db "ST%d: Invalid ST", NL, 0
    empty_st_format db "ST%d: Empty", NL, 0

extern _scanf, _printf, _getchar, _putchar, _exit

global read_int
read_int:
    enter 4,0
    pusha
    pushf

    lea eax, [ebp-4]
    push eax
    push dword .format
    call _scanf
    pop ecx
    pop ecx

    popf
    popa
    mov eax, [ebp-4]
    leave
    ret

.format db "%i", NL, TERM

global read_char
read_char:
    enter 4,0
    pusha
    pushf

    call _getchar
    mov [ebp-4], eax

    popf
    popa
    mov eax, [ebp-4]
    leave
    ret

global print_char
print_char:
    enter 0,0
    pusha
    pushf

%ifndef WATCOM
    push eax
%endif
    call _putchar
%ifndef WATCOM
    pop ecx
%endif

    popf
    popa
    leave
    ret


global print_nl
print_nl:
    enter 0,0
    pusha
    pushf

%ifdef WATCOM
    mov eax, 10 ; WATCOM doesn't use the stack here
%else
    push dword 10 ; 10 == ASCII code for \n
%endif
    call _putchar
%ifndef WATCOM
    pop ecx
%endif
    popf
    popa
    leave
    ret


global sub_dump_regs
sub_dump_regs:
    enter 4,0
    pusha
    pushf
    mov eax, [esp] ; read FLAGS back off stack
    mov [ebp-4], eax ; save flags

;
; show which FLAGS are set
;
    test eax, CF_MASK
    jz cf_off
    mov eax, carry_flag
    jmp short push_cf
cf_off:
    mov eax, unset_flag
push_cf:
    push eax

    test dword [ebp-4], PF_MASK
    jz pf_off
    mov eax, parity_flag
    jmp short push_pf
pf_off:
    mov eax, unset_flag
push_pf:
    push eax

    test dword [ebp-4], AF_MASK
    jz af_off
    mov eax, aux_carry_flag
    jmp short push_af
af_off:
    mov eax, unset_flag
push_af:
    push eax

    test dword [ebp-4], ZF_MASK
    jz zf_off
    mov eax, zero_flag
    jmp short push_zf
zf_off:
    mov eax, unset_flag
push_zf:
    push eax

    test dword [ebp-4], SF_MASK
    jz sf_off
    mov eax, sign_flag
    jmp short push_sf
sf_off:
    mov eax, unset_flag
push_sf:
    push eax

    test dword [ebp-4], DF_MASK
    jz df_off
    mov eax, dir_flag
    jmp short push_df
df_off:
    mov eax, unset_flag
push_df:
    push eax

    test dword [ebp-4], OF_MASK
    jz of_off
    mov eax, overflow_flag
    jmp short push_of
of_off:
    mov eax, unset_flag
push_of:
    push eax

    push dword [ebp-4] ; FLAGS
    mov eax, [ebp+4]
    sub eax, 10 ; EIP on stack is 10 bytes ahead of orig
    push eax ; EIP
    lea eax, [ebp+12]
    push eax ; original ESP
    push dword [ebp] ; original EBP
        push edi
        push esi
    push edx
    push ecx
    push ebx
    push dword [ebp-8] ; original EAX
    push dword [ebp+8] ; # of dump
    push dword reg_format
    call _printf
    add esp, 76
    popf
    popa
    leave
    ret 4

global sub_dump_stack
sub_dump_stack:
    enter 0,0
    pusha
    pushf

    lea eax, [ebp+20]
    push eax ; original ESP
    push dword [ebp] ; original EBP
    push dword [ebp+8] ; # of dump
    push dword stack_format
    call _printf
    add esp, 16

    mov ebx, [ebp] ; ebx = original ebp
    mov eax, [ebp+16] ; eax = # dwords above ebp
    shl eax, 2 ; eax *= 4
    add ebx, eax ; ebx = & highest dword in stack to display
    mov edx, [ebp+16]
    mov ecx, edx
    add ecx, [ebp+12]
    inc ecx ; ecx = # of dwords to display

global stack_line_loop
stack_line_loop:
    push edx
    push ecx ; save ecx & edx

    push dword [ebx] ; value on stack
    push ebx ; address of value on stack
    mov eax, edx
    sal eax, 2 ; eax = 4*edx
    push eax ; offset from ebp
    push dword stack_line_format
    call _printf
    add esp, 16

    pop ecx
    pop edx

    sub ebx, 4
    dec edx
    loop stack_line_loop

    popf
    popa
    leave
    ret 12

; Make an od-like output of a memory section.
;
;     void (uint32 initial_memory, uint32 length) __attribute__((cdecl))
;
; `length` is in multiples of 16 bytes.
;
; Sample output:
;
;   FFDC2AF0 50 A0 04 08 00 00 00 00 00 00 00 00 83 CA 5B 55 "P?????????????[U"
;   FFDC2B00 01 00 00 00 94 2B DC FF 9C 2B DC FF EA 3C 56 55 "?????+???+???<VU"
;
global sub_dump_mem
sub_dump_mem:
    enter 0,0
    pusha
    pushf

    push dword [ebp+8]
    push dword mem_format1
    call _printf
    add esp, 8

    mov esi, [ebp+8]
    and esi, 0xFFFF_FFF0
    mov ecx, [ebp+12]
    inc ecx
mem_outer_loop:

    push ecx
    push esi
    push dword mem_format2
    call _printf
    add esp, 8

    xor ebx, ebx
mem_hex_loop:
    xor eax, eax
    mov al, [esi + ebx]

    push eax
    push dword mem_format3
    call _printf
    add esp, 8

    inc ebx
    cmp ebx, 16
    jl mem_hex_loop

    mov eax, '"'
    call print_char
    xor ebx, ebx
mem_char_loop:
    xor eax, eax
    mov al, [esi+ebx]
    cmp al, 32
    jl non_printable
    cmp al, 126
    jg non_printable
    jmp short mem_char_loop_continue
non_printable:
    mov eax, '?'
mem_char_loop_continue:
    call print_char

    inc ebx
    cmp ebx, 16
    jl mem_char_loop

    mov eax, '"'
    call print_char
    call print_nl

    add esi, 16
    pop ecx
    loop mem_outer_loop

    popf
    popa
    leave
    ret

; function sub_dump_math
; prints out state of math coprocessor without modifying the coprocessor
; or regular processor state
; Parameters:
; dump number - dword at [ebp+8]
; Local variables:
; ebp-108 start of fsave buffer
; ebp-116 temp double
; Notes: This procedure uses the Pascal convention.
; fsave buffer structure:
; ebp-108 control word
; ebp-104 status word
; ebp-100 tag word
; ebp-80 ST0
; ebp-70 ST1
; ebp-60 ST2 ...
; ebp-10 ST7
;
global sub_dump_math
sub_dump_math:
    enter 116,0
    pusha
    pushf

    fsave [ebp-108] ; save coprocessor state to memory
    mov eax, [ebp-104] ; status word
    and eax, 0x0FFFF
    push eax
    mov eax, [ebp-108] ; control word
    and eax, 0x0FFFF
    push eax
    push dword [ebp+8]
    push dword math_format1
    call _printf
    add esp, 16
;
; rotate tag word so that tags in same order as numbers are
; in the stack
;
    mov cx, [ebp-104] ; ax = status word
    shr cx, 11
    and cx, 7 ; cl = physical state of number on stack top
    mov bx, [ebp-100] ; bx = tag word
    shl cl,1 ; cl *= 2
    ror bx, cl ; move top of stack tag to lowest bits

    mov edi, 0 ; edi = stack number of number
    lea esi, [ebp-80] ; esi = address of ST0
    mov ecx, 8 ; ecx = loop counter
tag_loop:
    push ecx
    mov ax, 3
    and ax, bx ; ax = current tag
    or ax, ax ; 00 -> valid number
    je valid_st
    cmp ax, 1 ; 01 -> zero
    je zero_st
    cmp ax, 2 ; 10 -> invalid number
    je invalid_st
    push edi ; 11 -> empty
    push dword empty_st_format
    call _printf
    add esp, 8
    jmp short cont_tag_loop
zero_st:
    fldz
    jmp short print_real
valid_st:
    fld tword [esi]
print_real:
    fstp qword [ebp-116]
    push dword [ebp-112]
    push dword [ebp-116]
    push edi
    push dword valid_st_format
    call _printf
    add esp, 16
    jmp short cont_tag_loop
invalid_st:
    push edi
    push dword invalid_st_format
    call _printf
    add esp, 8
cont_tag_loop:
    ror bx, 2 ; mov next tag into lowest bits
    inc edi
    add esi, 10 ; mov to next number on stack
    pop ecx
    loop tag_loop

    frstor [ebp-108] ; restore coprocessor state
    popf
    popa
    leave
    ret 4

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
    enter 0,0
    pusha
    pushf

    push eax
    push dword .format
    call _printf
    pop ecx
    pop ecx

    popf
    popa
    leave
    ret

.format db "%i", NL, TERM

; Print 32 bit integer in hexadecimal.
global print_int_hex
print_int_hex:
    enter 0,0
    pusha
    pushf

    push eax
    push dword .format
    call _printf
    pop ecx
    pop ecx

    popf
    popa
    leave
    ret

.format db "%x", NL, TERM

global print_string
print_string:
    enter 0,0
    pusha
    pushf

    push eax
    push dword .format
    call _printf
    pop ecx
    pop ecx

    popf
    popa
    leave
    ret

.format db "%s", NL, TERM
