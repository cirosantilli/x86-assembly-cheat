; # RDRAND

    ; True random number generator!

    ; This Intel engineer says its based on quantum effects:
    ; http://stackoverflow.com/a/18004959/895245

    ; Generated some polemic when kernel devs wanted to use it as part of `/dev/random`,
    ; because it could be used as a cryptographic backdoor by Intel since it is a black box.

%include "lib/asm_io.inc"

ENTRY
    rdrand eax
    call print_int

    rdrand eax
    call print_int

    EXIT
