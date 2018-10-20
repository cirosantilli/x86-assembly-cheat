; cmp (and most other instructions) cannot encode 64-bit immediates.
;
; mov however can.
;
; This can be seen on the Intel manual: cmp has not imm64 encoding.
; So in general, we have to move values to registers before we can operate on them.

%include "lib/common_nasm.inc"

ENTRY
    ; Sanity check: mov can encode imm64, and cmp r64, r64 works as expected.
    mov rax, 0x12345678_80000000
    mov rbx, 0x00000001_00000000
    add rax, rbx
    mov rbx, 0x12345679_80000000
    cmp rax, rbx
    je reg_reg
    ASSERT_FAIL
reg_reg:

    ; The r64 imm32 encoding sign extends the immediate.
    ;
    ; This works, but it is kind of a lie:
    ; the actual encoded immediate is just 0x80000000.
    ;
    ; NASM does not give warnings however, so we prefer this syntax.
    mov rax, 0xFFFFFFFF_80000000
    cmp rax, 0xFFFFFFFF_80000000
    je reg_imm_sign_1
    ASSERT_FAIL
reg_imm_sign_1:

    ; Positive sign extend.
    mov rax, 0x00000000_40000000
    cmp rax,         0x40000000
    je reg_imm_sign_0
    ASSERT_FAIL
reg_imm_sign_0:

    ; Negative sign extend without leading 1's.
    ; Works but NASM warns, so we don't use this form.
    ; even though I think it is saner.
    ;mov rax, 0xFFFFFFFF_80000000
    ;cmp rax,          0x80000000
    ;je reg_imm_sign_1
    ;ASSERT_FAIL
;reg_imm_sign_1:

    ; Impossible negative sign extend.
    ; NASM warns and that is good, but it assembles to the same as above
    ; and I'd rather have an error!
    ;mov rax, 0xFFFFFFFF_80000000
    ;cmp rax,        0x1_80000000
    ;je reg_imm_sign_nasm
    ;ASSERT_FAIL
;reg_imm_sign_nasm:

    ; Don't forget that our macro ASSERT_EQ uses cmp, and won't work as expected
    ; if the immediate cannot be encoded by sign extension.
    ; So juts move to a register before comparing.
    mov rax, 0x12345678_80000000
    mov rbx, 0x00000001_00000000
    add rax, rbx
    mov rbx, 0x12345679_80000000
    ASSERT_EQ rax, rbx

EXIT
