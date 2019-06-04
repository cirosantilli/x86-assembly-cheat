# define

#include <lkmc.h>

LKMC_PROLOGUE
    %define SIZE 10
    mov eax, SIZE
    LKMC_ASSERT_EQ(%eax, $10)
LKMC_EPILOGUE
