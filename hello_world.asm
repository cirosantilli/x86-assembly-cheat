; A hello world using printf from the C standard library
; via our helper macros.

#include <lkmc.h>

LKMC_PROLOGUE
    PRINT_STRING_LITERAL 'hello world'
LKMC_EPILOGUE
