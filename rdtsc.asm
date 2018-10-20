; # RDTSC

; # RDTSCP

    ; Read Time Stamp Counter

    ; Stores the output to EDX:EAX

    ; Counts the number of CPU cycles run.

    ; `RDTSCP` is the serialized version. TODO what does that mean?

    ; Used to be a very good time measure, until SMP came into play.

    ; It is normal that the outputs below differ by much more than 1:
    ; I get differences between 10 / 100.

    ; # Number of cycles for each instruction

        ; A single instruction can take many cycles,
        ; so the number of instructions alone is not a good measure of speed.

        ; The deltas are not predictable because of optimizations
        ; like branch prediction and pipelining.

        ; - http://stackoverflow.com/questions/692718/how-to-find-cpu-cycle-for-an-assembly-instruction
        ; - http://stackoverflow.com/questions/12065721/why-isnt-rdtsc-a-serializing-instruction


%include "lib/common_nasm.inc"

ENTRY
    rdtsc
    mov ebx, eax
    rdtsc
    call print_int
    PRINT_INT ebx

    rdtscp
    mov ebx, eax
    rdtscp
    call print_int
    PRINT_INT ebx

EXIT
