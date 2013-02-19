%include "lib/asm_io.inc"
    ;#include

;default args
;%macro assert_eq 1-2 eax
    ;pushf
    ;cmp %2, %1
    ;je %%ok
        ;call assert_fail
    ;%%ok:
    ;popf
;%endmacro

;asserts eax eq %1
;eflags and registers are put on stack and restored afterwards
    ;as a consequence, stack pointer comparisons such as ``assert_eq [ESP], 1`` will fail!
    ;workaround: ``mov eax, [ESP]``, ``assert_eq 1``
%macro assert_eq 3       ;multiline macro
    pushf
    cmp %3 %1, %2
    je %%ok             ;inner label, visible only from the inside
        call assert_fail
    %%ok:
    popf
%endmacro

%macro assert_eq 2
    assert_eq %1, %2, %3
%endmacro

;macro overload
;assert_eq eax
%macro assert_eq 1
    assert_eq eax, %1
%endmacro

;asserts eax neq %1
%macro assert_dif 2
    pushfd
    pusha
    cmp %1, %2
    jne %%ok
        call assert_fail
    %%ok:
    popa
    popfd
%endmacro

;assert jX or jnX jumps
%macro assert_flag 1
    %1 %%ok
        call assert_fail
    %%ok:
%endmacro

section .data
    ;initialized data

    b0 db 0        ;byte labeled b0 with initial value 0
    b1: db 110101b ;byte initialized to binary 110101 (53 in decimal)
    b2 db 12h      ;byte initialized to hex 12 (18 in decimal)
    b3 db 17o      ;byte initialized to octal 17 (15 in decimal)
    b4 db "A"      ;byte initialized to ASCII code for A (65)

    ;b5 db A0h     ;ERROR: num cannot start with letter
    b5 db 0A0h     

    w0 dw 1000     ;word labeled w0 with initial value 1000
    d0 dd 1A92h    ;double word initialized to hex 1A92
    d1 dd 1A92h    ;double word initialized to hex 1A92

;float

    f0    dd 0.0       ;float
    ;f0    dd 0.0b
        ;ERROR
        ;no binary float notation
    f1    dd 1.0       ;float
    fm1   dd -1.0      ;float
    f1d1  dd 1.5       ;float
    f1d01 dd 1.25      ;float
    f10   dd 2.0       ;float
    f100  dd 4.0       ;float
    do0   dq 1.0       ;double

    ;some integer conts on memory for convenience
    i0    dd 0
    i1    dd 1

;arrays

    bs4  db 0, 1, 2, 3
    bs4_2  db 0, 0, 0, 0
        ; defines 4 bytes
    bs10 times 10 db 0
    
    bs20 times 10 db 0
         times 10 db 1
         ; equivalent to 10 (db 0)’s
         ; and 10 db 1

;strings

    bs5 db "a", "b", "c", 'd', 10
        ; "abcd\n"
		bs5l  equ $ - bs5
	  	  ;strlen(s)
	  	  ;MUST FOLLOW bs5 immediately
	  	  ;$ is the cur adress
    bs5_2 db 'abcd', 10
        ;same
    bs4n db 'abc', 0
        ;null terminated

    prompt_int db "enter int: ", 0
    all_asserts_passed_str db "ALL ASSERTS PASSED", 10, 0

section .bss
    ;unitialized data

    bu resb 1           ;1 uninitialized byte
    ws10 resw 10        ;10 uninitialized words

    input resd 1

    fx    resd 1        ;float
    ix    resd 1        ;int

section .text
    ;instructions

    ;global _start
    global asm_main
        ;allows simbols to be seen by linker
        ;not possible by default
        ;at least the first symbol must be visible to the linker

    extern external_label, external_label2
        ;same as c extern: label is defined outside this file

asm_main:
    ;simply executes the first label found in text

    enter 0,0
    pusha

    ;registers
        inc eax
        inc ax
        inc al
        inc ah
        inc ebx
        inc ecx
        inc edx

    ;flags
        ;single 32 bit register
        ;each bit is a bool
        ;those bools are set by other operations

        ;main flags are:
            ;SF sign
            ;ZF zero
              ;1 if result == 0
            ;PF parity
              ;0 lower 8 bits of result
            ;CF cary
            ;OF overflow
            ;AF adjust

        ;flage usage
            ;not all flags have direct clear/set methods
            stc
            assert_flag jc
            clc
            assert_flag jnc
            cmc
            assert_flag jc
            cmc
            assert_flag jnc

            jc jclabel
            jclabel:

            jnc jnclabel
            jnclabel:

    ;instructions

        ;mov

            ;mov assign
                mov eax, 0
                mov eax, 1
                assert_eq 1

                mov eax, 0
                mov ebx, 1
                mov eax, ebx
                assert_eq 1

            ;movzx
                ;mov and zero extend
                ;works for unsigned numbers

                mov eax, 0
                mov ax, 1000h
                movzx eax, ax
                assert_eq 1000h

                mov ebx, 0
                mov al, 10h
                movzx ebx, al
                mov eax, ebx
                assert_eq 10h
                
                mov eax, 0
                mov ax, -1
                movzx eax, ax
                assert_dif eax, -1

                ;movzx al, al
                    ;ERROR
                    ;same size
                    ;first register must be larger

                ;movzx eax, 0
                    ;ERROR
                    ;must be a register

            ;movsx

                ;mov and sign extend
                ;in 2s complement, just extend sign bit
                ;there are many anterior commands that do this
                ;for specific sizes, created before 32 bit registers

                mov eax, 0
                mov ax, -1
                movsx eax, ax
                assert_eq -1

            ;cmovXX

                ;flag

                    ;cmovXX a, b
                    ;if( flag ) a = b

                    clc
                    mov eax, 0
                    mov ebx, 1
                    cmovc eax, ebx
                    assert_eq 0

                    clc
                    mov eax, 0
                    mov ebx, 1
                    cmovnc eax, ebx
                    assert_eq 1

                    stc
                    mov eax, 0
                    mov ebx, 1
                    cmovc eax, ebx
                    assert_eq 1

                    ;cmovc eax, 1
                        ;ERROR
                        ;must be adress

            ;exchange

                ;xchg
                    
                    mov eax, 0
                    mov ebx, 1

                    xchg eax, ebx
                    assert_eq 1
                    assert_eq ebx, 0

                    xchg eax, ebx
                    assert_eq 0
                    assert_eq ebx, 1

                ;bswap

                    ;little endian <=> big endian

                    mov eax, 11223344h
                    bswap eax
                    assert_eq 44332211h

                ;xadd
                
                    mov eax, 1
                    mov ebx, 2
                    xadd eax, ebx
                    assert_eq 3
                    assert_eq ebx, 1
        
        ;arithmetic

            ;add

                mov eax, 0
                add eax, 1
                assert_eq 1

                mov eax, 0
                mov ebx, 1
                add eax, ebx
                assert_eq 1

                mov eax, 0
                add eax, "a"
                assert_eq "a"
                    ;ascii

                ;add ax,al
                ;add ax,eax
                    ;ERROR
                    ;second register must be same size

                ;add eax, "ab"
                    ;ERROR

                ;add 0, 0
                    ;ERROR
                    ;and do what with the result?

                ;adc extended sum
                    mov eax, 80000000h
                    mov ecx, 80000000h
                    mov ebx, 0
                    mov edx, 0
                    add eax, ecx
                    adc edx, ebx
                        ;edx:eax += ebx:ecx

                    assert_eq 0
                    assert_eq edx, 1

                ;inc eax++
                    mov eax, 0
                    inc eax
                    assert_eq 1

            ;subtract

                ;sub subtract
                    mov eax, 1
                    sub eax, 1
                    assert_eq 0

                ;sbb extended subtract
                    mov eax, 0
                    mov ebx, 0
                    mov ecx, 80000000h
                    mov edx, 1

                    sub eax, ecx
                    sbb edx, ebx

                    assert_eq 80000000h
                    assert_eq edx, 0
                        ;edx:eax -= ebx:ecx

                ;dec eax--
                    mov eax, 1
                    dec eax
                    assert_eq 0

            ;mul
                ;unsigned multiply

                mov eax, 2
                mov ebx, 2
                mul ebx
                assert_eq 4
                assert_eq ebx, 2

                ;reg size

                    ;8 bit
                        mov eax, 0

                        mov al, 2
                        mov bl, 80h
                        mov dl, 0
                        mul bl
                        assert_eq 100h

                    ;16 bit
                        mov eax, 0
                        mov edx, 0

                        mov ax, 2
                        mov bx, 8000h
                        mov dx, 0
                        mul bx
                        assert_eq 0
                        mov ax, dx
                        assert_eq 1

                    ;32 bit
                        mov eax, 2
                        mov ebx, 80000000h
                        mov edx, 0
                        mul ebx
                        assert_eq 0
                        assert_eq edx, 1

                ;mul 2
                    ;ERROR
                    ;must be register

            ;imul
                ;signed multiply
                ;edx:eax = 

                mov eax, 2
                mov ebx, 2
                imul ebx
                assert_eq 4
                assert_eq ebx, 2
                
                mov eax, -2
                imul eax
                assert_eq 4
                
                mov eax, 2
                imul eax, 2
                assert_eq 4

                mov eax, 0
                mov ebx, 2
                imul eax, ebx, 2
                assert_eq 4

                ;imul eax, 2, 2
                    ;ERROR
                    ;second must be register
            
            ;neg

                mov eax, 2

                neg eax
                assert_eq -2

                neg eax
                assert_eq 2

            ;div
                ;signed divide
                ;edx:eax /= div

                mov eax, 5
                mov edx, 0
                mov ecx, 2
                div ecx
                assert_eq 2
                assert_eq edx, 1

                ;reg size

                    ;8
                        mov eax, 0

                        mov ax, 101h
                        mov cl, 2
                        div cl
                        assert_eq 180h

                    ;16
                        mov eax, 0
                        mov edx, 0

                        mov ax, 1
                        mov dx, 1
                        mov cx, 2
                        div cx
                        assert_eq 8000h
                        assert_eq edx, 1

                    ;32 
                        mov eax, 1
                        mov edx, 1
                        mov ecx, 2
                        div ecx
                        assert_eq 80000000h
                        assert_eq edx, 1

                        ;mov eax, 1
                        ;mov edx, 2
                        ;mov ecx, 2
                        ;div ecx
                            ;ERROR
                            ;output must fit into dword

            ;cdq

                ;sign extend eax into edx:eax
                ;idiv 32-bit combo

                mov eax, 1
                mov edx, 0
                cdq
                assert_eq edx, 0

                mov eax, -1
                mov edx, 0
                cdq
                assert_eq edx, 0FFFFFFFFh

            ;idiv

                mov eax, -5
                cdq
                    ;dont forget this!
                mov ecx, -2
                idiv ecx
                assert_eq 2
                assert_eq edx, -1

                mov eax, 1
                mov edx, 1
                mov ecx, 4
                idiv ecx
                assert_eq 40000000h
                assert_eq edx, 1

                ;mov eax, 1
                ;mov edx, 1
                ;mov ecx, 2
                ;idiv ecx
                    ;RUNTIME ERROR
                    ;result must fit into signed dword

            ;compare

                ;cmp

                    ;cmp does eax - ebx
                    ;ignores results
                    ;but sets all flags
                    ;
                    ;unsigned
                        ;ZF = ( eax == ebx ) ? 1 : 0
                        ;CF = ( eax < ebx ) ? 1 : 0
                    ;signed
                        ;ZF = ( eax == ebx ) ? 1 : 0
                        ;if( eax < ebx )
                        ;  assert( OF == SF )
                        ;else if( eax > ebx )
                            ;  assert( OF != SF )

                    mov eax, 0
                    cmp eax, 0
                    assert_flag je
                    assert_eq 0

                    mov eax, 2
                    cmp eax, 1
                    assert_flag jne
                    assert_eq 2

                    ;valid operands

                        cmp eax, 0
                        cmp eax, ebx
                        cmp eax, [d0]
                        ;cmp [d1], [d0]
                            ;ERROR
                            ;you can only interact with memory with a register
                            ;not another memory location
                        cmp dword [d0], 0
                            ;OK
                            ;the 0 is part of the instruction

                ;cmpxchg

                    ;cmpxchg x y
                    ;if( x == eax )
                    ;{
                    ;   x = y
                    ;}

                    mov eax, 0
                    mov ebx, 1
                    mov ecx, 2
                    cmpxchg ebx, ecx
                    assert_flag jnz
                    ;assert_eq eax, 0
                        ;TODO
                    assert_eq ebx, 1
                    assert_eq ecx, 2

                    mov eax, 0
                    mov ebx, 0
                    mov ecx, 2
                    cmpxchg ebx, ecx
                    assert_flag jz
                    assert_eq eax, 0
                    assert_eq ebx, 2
                    assert_eq ecx, 2

            ;floating point

                    ;understand IEEE floating point format
                        ;converter: <http://babbage.cs.qc.cuny.edu/IEEE-754.old/Decimal.html>
                    
                    ;st[0-7] is a stack
                        ;st0 is always the top of the stack!

                    ;many operations have a P version that pops stack


                    ;NOTE

                        ;you can only communicate with st. from memory, not registers

                        ;fld eax
                        ;fld __float32__(1.5)
                            ;ERROR
                            ;must load from memory

                    ;mov eax, 1.1
                         ;ERROR
                    mov eax, __float32__(1.5)

                    ;load on stack

                        ;fldz

                            ;st0 = 0

                            fldz
                            fld dword [f0]
                            fcomip st1
                            assert_flag je
                            finit

                        ;fld1

                            ;st0 = 1

                            fld1
                            fld dword [f1]
                            fcomip st1
                            assert_flag je
                            finit

                        ;FLDL2E  ;log_2(e)
                        ;FLDL2T  ;log_2(10)
                        ;FLDLG2  ;log_10(2)
                        ;FLDLN2  ;ln(2)
                        ;FLDPI   ;PI!

                        ;fild

                            ;load integer

                            fldz
                            fild dword [i0]
                            fcomip st1
                            assert_flag je
                            finit

                    ;stack order

                        ;fxch
                        
                            ;change st0 and another register

                            fldz
                            fld1

                            fxch st1
                            fld dword [f0]
                            fcomip st1
                            assert_flag je

                            fxch st1
                            fld dword [f1]
                            fcomip st1
                            assert_flag je

                            finit

                        ;ffree

                            ;removes from stack

                            fldz
                            fld1
                            ffree st0
                            fld dword [f0]
                            fcomip st1
                            assert_flag je
                            finit

                            fldz
                            fld1
                            ffree st1
                            fld dword [f1]
                            fcomip st1
                            assert_flag je
                            
                    ;stack -> memory

                        ;fst(p|)

                            ;load integer

                            fldz
                            fld dword [f0]
                            fstp dword [fx]
                            mov eax, [f0]
                            assert_eq [fx]

                    ;fcomip

                        ;pentium+

                        ;compare and pop
                        ;set integer compare flags

                        fld1
                        fldz
                        fcomip st1
                        assert_flag jb
                        ;assert_flag jl
                            ;BAD
                            ;must use a b with fcomip
                            ;TODO why?
                        finit

                        fldz
                        fld1
                        fcomip st1
                        assert_flag ja
                        finit
                            
                        ;fcomip [f1]
                            ;ERROR
                            ;must compare two registers

                ;operations

                    ;fchs

                        ;st0 *= -1

                        fld dword [f1]
                        fchs
                        fld dword[fm1]
                        fcomip st1
                        assert_flag je
                        fchs
                        fld dword [f1]
                        assert_flag je
                        finit

                    ;fabs

                        ;st0 = |st0|

                        fld dword [fm1]
                        fabs
                        fld dword[f1]
                        fcomip st1
                        assert_flag je
                        fld dword[f1]
                        fcomip st1
                        assert_flag je
                        finit

                    ;fsqrt

                        fld dword [f100]

                        fsqrt
                        fld dword [f10]
                        fcomip st1
                        assert_flag je

                        fsqrt
                        mov dword [fx], __float32__(1.41)
                        fld dword [fx]
                        fcomip st1
                        assert_flag jbe

                        mov dword [fx], __float32__(1.42)
                        fld dword [fx]
                        fcomip st1
                        assert_flag jae

                    ;fscale

                        fld dword [f1]
                        fld dword [f1]

                        fscale
                        fld dword [f10]
                        fcomip st1
                        assert_flag je

                        fscale
                        fld dword [f100]
                        fcomip st1
                        assert_flag je

                    ;FSIN
                    ;FCOS
                    ;FSINCOS    ;calc both sin and cos
                    ;FPATAN
                    ;FPTAN

                    ;FPREM      ;remainder
                    ;FPREM1     ;remainder

                    ;FRNDINT    ;rounds to integer depending on rounding mode

        ;bitwise

            ;shift

                ;shl shr

                    ;applicaition:
                    ;- quick unsigned multiply and divide by powers of 2

                    mov eax, 81h

                    shl al, 1
                    assert_flag jc
                    assert_eq 2

                    shl al, 1
                    assert_eq 4
                    assert_flag jnc

                    shr al, 1
                    assert_eq 2
                    assert_flag jnc

                    mov cl, 2
                    shr al, cl
                    assert_flag jc
                    assert_eq 0

                    ;mov bl, 2
                    ;shr ax, bl
                        ;ERROR:
                        ;shift must be either const or in ``cl``
                
                ;arithmetic

                    ;signed multiply and divide by powers of 2
                    ;keeps correct sign, and carries rest

                    mov eax, -1 ;negative number
                    sal eax, 1  ;ax = -2, CF = 1
                    assert_flag jc
                    assert_eq -2

                    sar eax, 1          ;ax < 0, CF = 0
                    assert_eq -1

                ;rotate

                    ;no corresponding c intruction

                    ;insert 0

                        mov eax, 81h

                        rol al, 1    ;axl = 03h, CF = 1
                        assert_flag jc
                        assert_eq al, 3

                        rol al, 1    ;axl = 04h, CF = 0
                        assert_eq al, 6
                        assert_flag jnc

                        ror al, 2    ;axl = 03h, CF = 0
                        assert_flag jc
                        assert_eq al, 81h

                        ror al, 1    ;axl = 81h, CF = 1
                        assert_flag jc
                        assert_eq al, 0C0h

                    ;rotate with cf inserted

                        mov eax, 81h
                        clc

                        rcl al, 1
                        assert_eq al, 2
                        assert_flag jc

                        rcl al, 1
                        assert_eq al, 5
                        assert_flag jnc

                        rcr al, 2
                        assert_eq al, 81h
                        assert_flag jnc

                        rcr al, 1
                        assert_eq al, 40h
                        assert_flag jc

            ;bool

                ;not

                    mov al, 0F0h
                    not al
                    assert_eq al, 0Fh

                ;and

                    mov ax, 00FFh
                    and ax, 0F0Fh
                    assert_eq ax, 000Fh

                ;test

                    ;ZF = ( al && bl == 0 ) ? 1 : 0

                    mov al, 0F0h
                    test al, 0
                    assert_flag jz
                    assert_eq al, 0F0h

                    mov al, 0F0h
                    assert_eq al, 0F0h
                    test al, 0F0h
                    assert_flag jnz
                    assert_eq al, 0F0h

                ;or

                    mov ax, 00FFh
                    or  ax, 0F0Fh
                    assert_eq ax, 0FFFh

                ;xor

                    mov ax, 00FFh
                    xor ax, 0F0Fh
                    assert_eq ax, 0FF0h

            ;bit

                ;bt

                    ;bt ax, i
                    ;CF = ( ax[i] == 1 ) ? 1 : 0

                    mov ax, 0Ah

                    bt ax, 0
                    assert_flag jnc

                    bt ax, 1
                    assert_flag jc

                    bt ax, 2
                    assert_flag jnc

                    bt ax, 3
                    assert_flag jc

                    assert_eq ax, 0Ah
                        ;unchanged

                    ;bt al, 0
                        ;not for bytes

                ;bts set
                ;btr reset
                ;btc complement

                    ;bt + op

                    ;bts

                        mov ax, 0Ah
                        bts ax, 0
                        assert_eq ax, 0Bh
                        assert_flag jnc

                        mov ax, 0Ah
                        bt ax, 1
                        assert_flag jc
                        assert_eq ax, 0Ah

                    ;btr

                        mov ax, 0Ah
                        btr ax, 1
                        assert_eq ax, 8
                        assert_flag jc

                    ;btc

                        mov ax, 0Ah
                        btc ax, 0
                        assert_eq ax, 0Bh
                        assert_flag jnc

                        mov ax, 0Ah
                        btc ax, 1
                        assert_eq ax, 08h
                        assert_flag jc

    ;labels

        ;adresses in RAM memory

        mov al, [b0]  ;al = b0
        assert_eq al, [b0]

        mov eax, b0   ;eax = &b0
        mov al,  [eax];al = *eax
        assert_eq al, [b0]

        mov byte [b0], 0  ;b0 = 0
        cmp byte [b0], 0
        assert_flag jz

        mov eax, [d0] ;copy double word at d0 into EAX
        add eax, [d0] ;EAX = EAX + double word at d0
        add [d0], eax ;double word at d0 += EAX
        mov al, [d0]  ;copy first byte of double word at d0 into AL

        ;mov [d0], 1
            ;ERROR
            ;should overwrite how many bytes of d0?
        mov dword [d0], 1

        mov byte [bs4], 0
        mov byte [bs4 + 1], 1
        mov ebx, 2
        mov byte [bs4 + ebx], 2
        ;mov al, [bs4 + bx]
            ;WARN
            ;must use 32-bit var

        ;$
            ;adress of cur instruction

            mov eax, $
            call print_int
            call print_nl
            mov eax, $
            call print_int
            call print_nl
            mov eax, $ + 1

            ;instructoin lengths

                mov ebx, $
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;5
                    ;1 byte for the instruction
                    ;4 bytes for the expanded '$' (4 byte adress)

                mov ebx, $
                call print_ebx_call_ret
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl

                mov ebx, $
                mov edx, ecx
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;7
                    ;mov edx, ecx  :  2 bytes

                mov ebx, $
                sub edx, ecx
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;7
                    ;sub edx, ecx : 2 bytes

                mov ebx, $
                mov dl, 0
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;7
                    ;sub edx, 0
                    ;2 bytes
                    ;1 for mov edx
                    ;2 for the 0 (dl contains 2 bytes)

                mov ebx, $
                jmp short jmp_short_len_lbl
                jmp_short_len_lbl:
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;7

                mov ebx, $
                jmp jmp_len_lbl
                jmp_len_lbl:
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;7
                    ;TODO
                    ;why not 8?
                    ;compiler automatically sees this?

                mov ebx, $
                mov dx, 0
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                ;9
                    ;TODO
                    ;why not 8 ?
                    ;1 mov dx + 2 0

                mov ebx, $
                mov edx, 0
                mov eax, $
                sub eax, ebx
                call print_int
                call print_nl
                    ;10
                        ;sub edx, 0
                        ;5 bytes
                            ;1 for mov edx
                            ;4 for the 0 (edx contains 4 bytes)

    ;array

        ;also called string instructions

        ;c insight: this is why memcpy and memcmp may be faster than for loops
        ;it is easier for compiler to use these faster string commands

        mov eax, 0
        mov ebx, 0
        assert_eq [bs10 + eax + 1*ebx + 0], 0, dword
            ;single cycle instruction

            ;called *indirect* addressing

            ;most general form:
            ;ptr + reg + c1*reg + c2
                ;regs are 32 bit registers
                ;c1 \in {1,2,4,8}
                ;c2 is any other constant
        
        ;lea

            ;load effective address
            ;puts the result of indirect address calculation in var
            ;can be used as shortcut to certain operations

            mov ebx, 2
            lea eax, [3*ebx + 1]
            assert_eq 7

        ;lods[bwd]

            ;load into a and move esi

            mov esi, bs4
            mov byte [bs4], 0
            mov byte [bs4 + 1], 1

            cld
                ;increase esi
            lodsb
            assert_eq al, 0
            mov eax, esi
            sub eax, bs4
            assert_eq 1

            std
                ;decrease esi
            lodsb
            assert_eq al, 1
            mov eax, esi
            sub eax, bs4
            assert_eq 0

            cld
                ;shouldn't be necessary, but some badly written func afterwards is not clearing this value?

        ;stos[bwd]

            ;store from a and move edi

            mov edi, bs4

            cld
            mov bl, 1
            mov al, bl
            stosb
            assert_eq [bs4], bl
            mov eax, edi
            sub eax, bs4
            assert_eq 1

            std
            mov bl, 2
            mov al, bl
            stosb
            assert_eq [bs4 + 1], bl
            mov eax, edi
            sub eax, bs4
            assert_eq 0

            cld

        ;movs[bwd]

            ;copy one string into another

            mov edi, bs4_2
            mov esi, bs4
            mov byte [bs4], 0
            mov byte [bs4 + 1], 1

            cld
            movsb
            assert_eq [bs4_2], 0, byte
            mov eax, esi
            sub eax, bs4
            assert_eq 1
            mov eax, edi
            sub eax, bs4_2
            assert_eq 1

            std
            movsb
            assert_eq [bs4_2 + 1], 1, byte
            mov eax, esi
            sub eax, bs4
            assert_eq 0
            mov eax, edi
            sub eax, bs4_2
            assert_eq 0

            cld

        ;compare

            ;scas[bwd]

                ;compare array and a

                mov edi, bs4
                mov byte [bs4], 0
                mov byte [bs4 + 1], 1

                cld
                mov al, 0
                scasb
                assert_flag jz
                mov eax, edi
                sub eax, bs4
                assert_eq 1

                std
                mov al, 2
                scasb
                assert_flag jnz
                mov eax, edi
                sub eax, bs4
                assert_eq 0

                cld

            ;cmps[bwd]

                ;compare two arrays

                mov esi, bs4
                mov byte [bs4], 0
                mov byte [bs4 + 1], 1

                mov edi, bs4_2
                mov byte [bs4_2], 0
                mov byte [bs4_2 + 1], 2

                cld
                cmpsb
                assert_flag jz
                mov eax, esi
                sub eax, bs4
                assert_eq 1
                mov eax, edi
                sub eax, bs4_2
                assert_eq 1
                assert_eq [bs4], 0, byte
                assert_eq [bs4_2], 0, byte

                std
                movsb
                assert_flag jnz
                mov eax, esi
                sub eax, bs4
                assert_eq 0
                mov eax, edi
                sub eax, bs4_2
                assert_eq 0
                assert_eq [bs4 + 1], 1, byte
                ;assert_eq [bs4_2 + 1], 2, byte
                    ;TODO why fail?

                cld

            ;rep

                ;rep

                    ;repeat string instruction ecx times

                    ;application:
                        ;- copy arrays

                        cld
                        mov edi, bs4
                        mov ecx, 2
                        mov eax, 0
                        rep stosb
                        assert_eq [bs4], 0, byte
                        assert_eq [bs4+1], 0, byte
                        mov eax, edi
                        sub eax, bs4
                        assert_eq 2
                        assert_eq ecx, 0

                ;rep(n|)[ze]

                    ;repeat at most ecx times, if jnz break

                    ;application:
                        ;- test arrays equal
                        ;- search for element

                    cld

                    mov esi, bs4
                    mov byte [bs4], 0
                    mov byte [bs4 + 1], 1

                    mov edi, bs4_2
                    mov byte [bs4_2], 0
                    mov byte [bs4_2 + 1], 1

                    mov ecx, 2
                    repz cmpsb
                    assert_flag jz
                    assert_eq ecx, 0

                    mov ecx, 2
                    mov byte [bs4_2 + 1], 2
                    repz cmpsb
                    assert_flag jnz
                    assert_eq ecx, 1

    ;stack

        ;allocate data on execution
        ;useful to pass parameter to function
        ;this is how c variables inside functions are implemented
            ;uses memory only while necessary on cur function

        ;push pop

            ;always dwords (4 bytes)

            mov eax, ss
            call print_int
            call print_nl
                ;start of stack segment

            mov eax, esp
            push dword 1
            sub eax, esp
            assert_eq 4
            mov eax, [esp]
            assert_eq 1

            mov eax, esp
            push byte 2
                ;BAD
                ;still added 1 dword
            sub eax, esp
            call print_int
            assert_eq 4
            mov eax, [esp]
            assert_eq 2

            pop eax
            assert_eq 2

            pop eax
            assert_eq 1

            ;manual equivalent

                sub esp, 8
                mov dword [esp], 2
                mov dword [esp + 4], 1

                mov eax, [esp]
                assert_eq 2
                mov eax, [esp + 4]
                assert_eq 1
                add esp, 8

        ;pusha, popa

            ;push/pop to stack in order EAX, ECX, EDX, EBX, ESP, EBP, ESI, EDI

            mov ebx, 0
            mov ecx, 0

            mov eax, esp
            pusha
            sub eax, esp
            assert_eq 32        ;8x 4bytes

            mov ebx, 1
            mov ecx, 1
            popa
            assert_eq ebx, 0
            assert_eq ecx, 0
        
        ;pushf, popf, pushdf

            ;push /pop  FLAGS
            ;pushd/popd EFLAGS

            clc

            mov eax, esp
            pushf
            sub eax, esp
            assert_eq 4        ;needs 2 bytes, stack min 1 dword

            stc
            popf
            assert_flag jnc

            clc
            pushfd
            stc
            popfd
            assert_flag jnc

        ;enter, leave

            ;usefull for functions
            ;must allow recursion

            ;why push ebp?
            ;- because pushing local memory won't change the location of args

            mov eax, esp
            enter 8, 0
                ;enter A, B
                ;==
                ;push ebp
                ;mov ebp, esp
                ;sub esp, A
                ;==
                ;allocate 2 local dwords
            sub eax, esp
            assert_eq 12

            mov dword [ebp - 4], 1  ;modify 1st local var
            mov dword [ebp - 8], 2  ;modify 2nd local var

            leave
                ;mov esp, ebp
                ;pop ebp
                ;==
                ;delocate 2 dwords

    ;branch
      
        ;unconditional

            ;jmp
                ;short, near and far go for all jumps

                jmp short jmp_short_label
                jmp_short_label:
                    ;max +-128 bytes away
                    ;displacement uses 1 byte only

                ;jmp word jmp_word_label
                ;jmp_word_label:
                    ;segmentation fault?

                jmp jmp_label
                jmp near jmp_label
                    ;SAME
                jmp_label:
                    ;4 bytes displacement

                ;jmp far jmp_far_label
                ;jmp_far_label:
                    ;allows to move outside code segment
                    ;not allowed in ELF

                mov eax, $ + 7
                jmp eax
                    ;jmp to the adress in eax
                    ;mov eax, $ : 5 bytes
                    ;jmp eax    : 2 bytes

                ;mov eax, $ + 8
                ;jmp eax
                    ;RUNTIME ERROR
                    ;seg fault
                    ;stops in the middle of next instruction

        ;functions

            ;like a branch, but in addition must know
                ;1) what adress to return to
                ;2) how to pass arguments to the func

            ;simple calling convention
                ;could use a calling convention like this
                ;but this is too unconvenient

                ;mov ebx, 15
                ;mov ecx, $ + 7
                ;jmp print_ebx_simple_cc

            ;with stack
                ;now you don't destroy ecx anymore

                ;mov ebx, 17
                ;push $ + 7
                ;jmp print_ebx_stack

            ;call ret
                ;best way
                ;now you don't have to manually estimate adress delta!
                ;uses the stack

                mov ebx, 19
                call print_ebx_call_ret
                    ;pushes adress of next instruction to stack
                    ;jumps to lbl

            ;c calling conventions

                ;each lang may have a different one
                ;it is good to learn this because:
                    ;1) it works well
                    ;2) it allows you to interface with c code

                ;cdecl:
                    ;- use call/ret instructions
                    ;- args are passed on stack
                    ;- always pass dword args
                        ;if you want to pass a single byte,
                        ;first convert to dword
                    ;- are not poped before return
                        ;if you want to use their values, use ESP pointer
                        ;why?
                        ;- avoid moving them around for reuse multiple times in func
                        ;- the return value is pushed last, so would have to be poped before args!
                    ;- return value is put in eax
                        ;if 64-bit, put in edx:eax
                    ;- EBX, ESI, EDI, EBP, CS, DS, SS, ES remain unchanged on return
                        ;- they may be temporaly changed inside
                    ;- parameters are put on stack in inverse order from declaration
                        ;this allows for funcs with arbitrary numbers of args such as ``printf``:
                        ;like this the format string will always be on the same position
                    ;- the caller clears the argument heap
                        ;this generates more code (several calls, single def)
                        ;but allows for functions with variable number or arguments (``printf``)
                        ;because then only the caller knows how many args he put on the stack
                        ;PASCAL for example follows a fuction clear argument stack convention
                    ;- some compilers will append underline to func names '_'
                        ;not the case for ELF output
                    ;- watch out for compiler dependant conventions!
                        ;gcc allows to specify caling convention explicitly as:
                        ;``void f ( int ) __attribute__ ((cdecl ));``
                        ;``cdecl`` is the name of the calling convention
                        ;it is widely default across current compilers

                ;stdcall:
                    ;no variable number of args
                    ;slightly smaller code, and potentially faster

                mov  eax, bs4n
                call print_string       ;printf("%s")
                    ;calls for this may be flushed after direct sys_write calls
                call print_nl           ;puts("")

                mov  eax, 13
                call print_int          ;printf("%d")

                ;mov  eax, prompt_int
                ;call print_string
                ;call read_int
                ;mov  [input], eax
                ;call print_int
                ;call print_nl          ;scanf("%d")
                
                ;factorial

                    ;recursive
                        push dword 5
                        call factorial_rec
                        add esp, 4
                        assert_eq 120

                        push dword 1
                        call factorial_rec
                        add esp, 4
                        assert_eq 1

                    ;non recursive
                        push dword 5
                        call factorial_norec
                        add esp, 4
                        assert_eq 120

                        push dword 1
                        call factorial_norec
                        add esp, 4
                        assert_eq 1

        ;conditional

            ;jX and jnX mentioned in ;flags section

            ;signed:
                ;jg, jge, jl, jle
                ;jng, jnge, jnl, jnle
            ;unsigned verions:
                ;ja, jae, jb, jbe
                ;jna, jnae, jnb, jnbe
            ;mnemonics:
                ;g : greater
                ;l : less
                ;a : above
                ;b : below

            mov eax, 0
            cmp eax, 1
            assert_flag jl
            assert_flag jle

            mov eax, 1
            cmp eax, 0
            assert_flag jg
            assert_flag jge

            mov eax, 0
            cmp eax, 0
            assert_flag jle
            assert_flag jge

          ;loops

              ;loop
                  mov ecx, 3
                  loop_lbl:
                      mov eax, ecx
                      call print_int
                      call print_nl
                  loop loop_lbl
                      ;3, 2, 1
                      ;ecx--; if( ecx != 0 ) goto lbl
                      ;single instruction

                  mov ecx, 3
                  mov ebx, ecx
                  loop_lbl_2:
                      mov eax, ebx
                      sub eax, ecx
                      call print_int
                      call print_nl
                  loop loop_lbl_2
                      ;0, 1, 2

              ;loope lbl
                  ;ecx--; if( ecx != 0 && ZF == 0 ), goto lbl
              ;loopne lbl
                  ;ecx--; if( ecx != 0 && ZF == 1 ), goto lbl

                  ;search for first nonzero elem in range
                  ;bx will contain its index afterwards
                    mov cx, 16
                    mov bx, -1
                    loope_lbl:
                        inc ebx
                        ;cmp byte [bs4 + ebx], 0 
                            ;TODO
                            ;seg fault, why?
                    loope loope_lbl
                    je all_zero 
                    all_zero:

    ;SIMD

        ;<http://en.wikibooks.org/wiki/X86_Assembly/SSE>
        ;<http://www.songho.ca/misc/sse/sse.html

        ;MMX, SSE, SSE2, SSE3, SSSE3, SSE4 are the version names

        ;there are 8 128bit registers: xmm[0-7]
        ;in this way you can add, subtract, multiply, etc 4 floats/2 doubles at once
        ;disconsidering overeads you can go up to 4x faster

        ;as all of assembler, you will have a hard time beating modern compiler optimizers
        ;with this, so beawere... still lots of fun though!

        ;you have to try to align data on 16 bytes to make instructions go faster
        ;this is done with the align directive

    ;CPUID

        mov eax, 0
        cpuid
            ;fills eax, ebx, ecx and edx with cpu information
            ;eax in [0,1,2] gives different information
            ;info include:
                ;vendor
                ;version
                ;features (mmx, simd)
                ;caches
                ;tlbs <http://en.wikipedia.org/wiki/Translation_lookaside_buffer>



    ;hlt
        ;halts, until interrupt or reset
        ;giving me seg fault

    ;directives
        ;do not translate directy into cpu

    %define SIZE 10
        ;#define  SIZE 10
        mov eax,SIZE

    ;linux system calls
%ifdef LINUX

        ;sys_write
            mov eax, 4         ;sys_write
            mov ebx, 1         ;file descriptor 1
            mov ecx, bs5       ;pointer to string
            mov edx, bs5l      ;string len
            int 80h          

            mov eax, 4         
            mov ebx, 2         ;stderr
            mov ecx, bs5       
            mov edx, bs5l      
            int 80h          

        ;sys_exit
            ;mov eax,1        ;sys_exit
            ;mov ebx,0        ;exit status
            ;int 80h

%endif

    mov eax, all_asserts_passed_str
    call print_string

    popa
    mov eax, 0
    leave
    ret

.data:          ;can have multiple data

    assert_fail_str db 'assert failed', 10, 0

.text:

;ends program
assert_fail:
    mov eax, assert_fail_str
    call print_string

    ;exit exit status 1
        mov eax,1        ;sys_exit
        mov ebx,1        ;exit status
        int 80h

;print ebx \n
;eax is destroyed
;ecx contains the adress to return to
print_ebx_simple_cc:
    mov eax, ebx
    call print_int
    call print_nl
    jmp ecx

;print ebx \n
;eax is destroyed
print_ebx_stack:
    mov eax, ebx
    call print_int
    call print_nl
    pop eax
    jmp eax

;print ebx \n
;eax is destroyed
print_ebx_call_ret:
    mov eax, ebx
    call print_int
    call print_nl
    ret
        ;jumps to first adress on the stack

;some algorithms

;recursive factorial
factorial_rec:
    enter 0, 0
    cmp dword [ebp + 8], 1
    je factorial_rec_base
        mov ebx, [ebp + 8]
        dec ebx
        push ebx
        call factorial_rec
        add esp, 4
        mul dword [ebp + 8]
    jmp factorial_rec_return
    factorial_rec_base:
        mov eax, 1
    factorial_rec_return:
    leave
    ret

;non_recursive factorial
factorial_norec:
    enter 0, 0
    mov ecx, [ebp + 8]
    mov eax, 1
    factorial_norec_loop:
        mul ecx
    loop factorial_norec_loop
    leave
    ret
