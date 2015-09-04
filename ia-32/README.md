# IA-32

1.  Featured
    1. [main.asm](main.asm)
1.  [Getting started](getting-started.md)
1.  [hello_world.asm](hello_world.asm)
1.  [lib/](lib/)
1.  [linux/](linux/)
1.  [gas/](gas/)
1.  [Instruction encoding](instruction-encoding/)
1.  [Vagrantfile](Vagrantfile)
1.  Instructions
    1.  mov family
        1. [MOV](mov.asm)
        1. [MOVZX](movzx.asm)
        1. [MOVSX](movsx.asm)
        1. [CMOVcc](cmovcc.asm)
        1. [XCHG](xchg.asm)
        1. [LEA](lea.asm)
    1.  Flags
        1. [SETcc](setcc.asm)
    1.  Arithmetic
        1.  Addition
            1. [ADD](add.asm)
            1. [ADC](adc.asm)
            1. [INC](inc.asm)
        1.  Subtraction
            1. [SUB](sub.asm)
            1. [SBB](sbb.asm)
            1. [DEC](dec.asm)
        1.  Multiplication
            1. [MUL](mul.asm)
            1. [IMUL](imul.asm)
            1. [NEG](neg.asm)
        1.  Division
            1. [DIV](div.asm)
            1. [IDIV](idiv.asm)
        1.  [CDQ](cdq.asm)
        1.  Comparison
            1. [CMP](cmp.asm)
    1.  Bit-wise
        1.  Boolean
            1. [NOT](not.asm)
            1. [AND](and.asm)
            1. [OR](or.asm)
            1. [XOR](xor.asm)
            1. [TEST](test_instruction.asm)
        1.  Shifts
            1. [SHL, SHR](shl.asm)
            1. [SAL, SAR](sal.asm)
            1. [ROL, ROR](rol.asm)
        1.  Test
            [BT](bt.asm)
            [BTS](bts.asm)
            [BTR](btr.asm)
            [BTC](btc.asm)
    1.  Branching
        1.  [Jcc](jcc.asm)
        1.  [JMP](jmp.asm)
            1. [JMP indirect](jmp_indirect.asm)
        1.  [LOOPcc](loopcc.asm)
    1.  Synchronization
        1. [XADD](xadd.asm)
        1. [CMPXCHG](cmpxchg)
    1.  Misc
        1. [RDRAND](rdrand.asm)
        1. [POPCNT](popcnt.asm)
        1. [RDTSC](rdtsc.asm)
        1. [NOP](nop.asm)
        1. [CPUID](cpuid.asm)
1.  Calling conventions
    1.  [cdecl](cdecl.md)
    1.  [cdecl examples](cdecl.asm)
    1.  [stdcall](stdcall.asm)

WIP

1. [Debug registers](debug-registers.md)
