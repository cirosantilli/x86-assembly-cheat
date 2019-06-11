# LOOPcc

#include <lkmc.h>

RODATA

    bs4 db 0, 0, 1, 0

LKMC_PROLOGUE

    # # LOOP

        # ecx--;
        # if (ecx != 0) goto lbl

                mov $3, %ecx
            loop_lbl: 
                # 3, 2, 1
                PRINT_INT ecx
            loop loop_lbl

                mov $3, %ecx
                mov %ecx, %ebx
            loop_lbl_2: 
                mov %ebx, %eax
                subl %ecx, %eax
                # 0, 1, 2
                call print_int
            loop loop_lbl_2

    # # LOOPE

        # ecx--; if (ecx != 0 && ZF == 1) goto lbl

        # # Search for first non-zero elem in range

            # bx will contain its index afterwards.
            # If not found, bx is the length + 1.

                mov $4, %ecx
                mov $-1, %ebx
                loope_lbl: 
                    incl %ebx
                    cmp byte [bs4 + ebx], 0
                loope loope_lbl
                LKMC_ASSERT_EQ_32(%ebx, $2)

    # # LOOPNE

        # ecx--; if (ecx != 0 && ZF == 0) goto lbl

LKMC_EPILOGUE
