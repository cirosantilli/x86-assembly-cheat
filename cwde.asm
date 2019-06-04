; - cwde: convert word to double sign extend. Cast int16_t to int32_t.
; - cbw: convert word to double sign extend. Cast int8_t to int16_t.
;
; https://stackoverflow.com/questions/6555094/what-does-cltq-do-in-assembly/31114310#31114310

#include <lkmc.h>

LKMC_PROLOGUE
    ; cwde negative sign extend.
    mov eax, 0x12345678
    mov ax,      0x8000
    cwde
    LKMC_ASSERT_EQ(%eax, $0xFFFF8000)

    ; cwde positive sign extend.
    mov eax, 0x12345678
    mov ax,      0x4000
    cwde
    LKMC_ASSERT_EQ(%eax, $0x00004000)

    ; cbw negative sign extend.
    mov eax, 0x12345678
    mov al,       0x80
    cbw
    LKMC_ASSERT_EQ(%eax, $0x1234FF80)

    ; cbw positive sign extend.
    mov eax, 0x12345678
    mov al,        0x40
    cbw
    LKMC_ASSERT_EQ(%eax, $0x12340040)

LKMC_EPILOGUE
