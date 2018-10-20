# FPU

Used to be a separate optional processor called the Floating Point Unit, later integrated into the CPU.

Has 8 registers: `st0` to `st7`, which for m a stack.

`st0` is always the top of the stack.

You can only communicate with `stX` from memory, not directly from registers.
