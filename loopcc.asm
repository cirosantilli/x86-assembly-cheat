# LOOPcc

%include "lib/common_nasm.inc"

RODATA

    bs4 db 0, 0, 1, 0

ENTRY

    ; # LOOP

        ; ecx--;
        ; if (ecx != 0) goto lbl

                mov ecx, 3
            loop_lbl:
                ; 3, 2, 1
                PRINT_INT ecx
            loop loop_lbl

                mov ecx, 3
                mov ebx, ecx
            loop_lbl_2:
                mov eax, ebx
                sub eax, ecx
                ; 0, 1, 2
                call print_int
            loop loop_lbl_2

    ; # LOOPE

        ; ecx--; if (ecx != 0 && ZF == 1) goto lbl

        ; # Search for first non-zero elem in range

            ; bx will contain its index afterwards.
            ; If not found, bx is the length + 1.

                mov ecx, 4
                mov ebx, -1
                loope_lbl:
                    inc ebx
                    cmp byte [bs4 + ebx], 0
                loope loope_lbl
                ASSERT_EQ ebx, 2

    ; # LOOPNE

        ; ecx--; if (ecx != 0 && ZF == 0) goto lbl

EXIT
