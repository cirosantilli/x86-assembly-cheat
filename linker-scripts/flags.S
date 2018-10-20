/*
This is also minimal as it uses the fact that
the default section is `.text`.
*/

#include "common.h"
.section .mytext, "a"
GLOBAL(_start)
EXIT($0)
