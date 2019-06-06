; # XOR

#include <lkmc.h>

LKMC_PROLOGUE
    mov ax, 0x00FF
    xor ax, 0x0F0F
    LKMC_ASSERT_EQ_32(%ax, $0x0FF0)

    ; # xor to set to zero idiom

        ; http://stackoverflow.com/questions/1135679/does-using-xor-reg-reg-give-advantage-over-mov-reg-0

        ; xor can be used to set a register to 0 instad of mov:

            mov ax, 0x1020
            xor ax, ax
            mov ax, 0x0000

        ; Compileres often do this to generate shorter instrucitons,
        ; but there are also cases where `mov` is better.

LKMC_EPILOGUE
