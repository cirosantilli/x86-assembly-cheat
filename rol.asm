; # rol

; # ror

; # Rotate

    ; The bit that exists enters from the other side.

    ; No corresponding C intruction.

%include "lib/common_nasm.inc"

ENTRY
        mov eax, 0x81

        ; axl = 03h, CF = 1
        rol al, 1
        ASSERT_FLAG jc
        ASSERT_EQ al, 3

        ; axl = 04h, CF = 0
        rol al, 1
        ASSERT_EQ al, 6
        ASSERT_FLAG jnc

        ; axl = 03h, CF = 0
        ror al, 2
        ASSERT_FLAG jc
        ASSERT_EQ al, 0x81

        ; axl = 81h, CF = 1
        ror al, 1
        ASSERT_FLAG jc
        ASSERT_EQ al, 0x0C0

    ; Rotate with cf inserted

        mov eax, 0x81
        clc

        rcl al, 1
        ASSERT_EQ al, 2
        ASSERT_FLAG jc

        rcl al, 1
        ASSERT_EQ al, 5
        ASSERT_FLAG jnc

        rcr al, 2
        ASSERT_EQ al, 0x81
        ASSERT_FLAG jnc

        rcr al, 1
        ASSERT_EQ al, 0x40
        ASSERT_FLAG jc

EXIT
