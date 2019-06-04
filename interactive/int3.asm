; # int3

    ; http://unix.stackexchange.com/questions/131044/dialog-trap-and-sigtrap

#include <lkmc.h>

LKMC_PROLOGUE
    int3
    ; 2 byte encoding.
    int 3
LKMC_EPILOGUE
