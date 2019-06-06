# # NOP

    # No OPeration.

    # Does nothing except take up one processor cycle.

    # Application: http://stackoverflow.com/questions/234906/whats-the-purpose-of-the-nop-opcode

#include <lkmc.h>

LKMC_PROLOGUE
    nop
    nop

    # Other things that do nops:

    # Only in 32-bit! In 64-bit zero extends!
    # http://stackoverflow.com/questions/11910501/why-did-gcc-generate-mov-eax-eax-and-what-does-it-mean
    movl %eax,%eax
    andl %eax,%eax

LKMC_EPILOGUE
