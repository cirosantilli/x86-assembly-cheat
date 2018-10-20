; # CPUID

    ; Fills EAX, EBX, ECX and EDX with CPU information.

    ; The exact data do show depends on the value of EAX, and for a few cases instructions ECX.
    ; When it depends on ECX, it is called a sub-leaf.

    ; Information available includes:

    ; - vendor
    ; - version
    ; - features (mmx, simd, rdrand, etc.) <http://en.wikipedia.org/wiki/CPUID# EAX.3D1:_Processor_Info_and_Feature_Bits>
    ; - caches
    ; - tlbs <http://en.wikipedia.org/wiki/Translation_lookaside_buffer>

    ; The cool thing about this instruction is that it allows you to check the CPU specs
    ; and take alternative actions based on that inside your program.


    ; On Linux, capacity part of this information is parsed and made available at `cat /proc/cpuinfo`.
    ; See: http://unix.stackexchange.com/questions/43539/what-do-the-flags-in-proc-cpuinfo-mean

    ; There is also the `cpuinfo` command line tool that parses the CPUID instruction from the command line.
    ; Source: http://www.etallen.com/cpuid.html

%include "lib/common_nasm.inc"

ENTRY
    mov eax, 0
    cpuid

    ; "Genu", shorthand for "genuine"
    ; 1970169159 == 0x 75 6e 65 47 == 'u', 'n', 'e', 'G' in ASCII
    PRINT_INT ebx

    ; 'inte', shorthand for "Intel
    ; 1818588270 == 0x 6c 65 74 6e == 'l', 'e', 't', 'n'
    PRINT_INT ecx

EXIT
