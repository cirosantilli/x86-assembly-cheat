# # RDRAND

    # True random number generator!

    # This Intel engineer says its based on quantum effects:
    # http://stackoverflow.com/a/18004959/895245

    # Generated some polemic when kernel devs wanted to use it as part of `/dev/random`, 
    # because it could be used as a cryptographic backdoor by Intel since it is a black box.

    # rdrand sets the carry flag when data is ready; one must loop if
    # the carry flag isn't set, but unlike in this example, one should
    # bound the number of attempts.

#include <lkmc.h>

LKMC_PROLOGUE
.loop0: 
    rdrand eax
    jnc .loop0
    call print_int

.loop1: 
    rdrand eax
    jnc .loop1
    call print_int

LKMC_EPILOGUE
