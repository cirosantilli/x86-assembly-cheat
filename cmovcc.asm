; # CMOVcc

    ; mov if a condition is met.

        ; CMOVcc a, b

    ; Equals:

        ; if(flag) a = b

    ; where `cc` are the same flags as Jcc.

    ; Vs jmp:

    ; - http://stackoverflow.com/questions/14131096/why-is-a-conditional-move-not-vulnerable-for-branch-prediction-failure
    ; - http://stackoverflow.com/questions/27136961/what-is-it-about-cmov-which-improves-cpu-pipeline-performance
    ; - http://stackoverflow.com/questions/26154488/difference-between-conditional-instructions-cmov-and-jump-instructions

    ; Basically why the ternary ? C operator exists.
    ; http://stackoverflow.com/questions/3565368/ternary-operator-vs-if-else

    ; Not necessarily faster because of branch prediction:
    ; http://stackoverflow.com/questions/6754454/speed-difference-between-if-else-and-ternary-operator-in-c?lq=1#comment8007791_6754495

    ; https://software.intel.com/en-us/articles/branch-and-loop-reorganization-to-prevent-mispredicts

    ; SETcc achieves a similar effect.

%include "lib/common_nasm.inc"

ENTRY

    clc
    mov eax, 0
    mov ebx, 1
    cmovc eax, ebx
    ASSERT_EQ eax, 0

    clc
    mov eax, 0
    mov ebx, 1
    cmovnc eax, ebx
    ASSERT_EQ eax, 1

    stc
    mov eax, 0
    mov ebx, 1
    cmovc eax, ebx
    ASSERT_EQ eax, 1

    ; ERROR: must be address
    ; cmovc eax, 1

EXIT
