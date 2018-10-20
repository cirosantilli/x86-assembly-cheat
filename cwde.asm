; - cwde: convert word to double sign extend. Cast int16_t to int32_t.
; - cbw: convert word to double sign extend. Cast int8_t to int16_t.
;
; https://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310

%include "lib/common_nasm.inc"

ENTRY
    ; cwde negative sign extend.
    mov eax, 0x12345678
    mov ax,      0x8000
    cwde
    ASSERT_EQ eax, 0xFFFF8000

    ; cwde positive sign extend.
    mov eax, 0x12345678
    mov ax,      0x4000
    cwde
    ASSERT_EQ eax, 0x00004000

    ; cbw negative sign extend.
    mov eax, 0x12345678
    mov al,       0x80
    cbw
    ASSERT_EQ eax, 0x1234FF80

    ; cbw positive sign extend.
    mov eax, 0x12345678
    mov al,        0x40
    cbw
    ASSERT_EQ eax, 0x12340040

EXIT
