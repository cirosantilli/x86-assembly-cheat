# Compiler generated

Let's see what our compilers are compiling to.

1.  General compiler remarks
    1. [GCC](gcc.md)
1.  C
    1.  [hello_world.c](hello_world.c)
    1.  Functions
        1.  [function_int_int_int.c](function_int_int_int.c)
    1.  [return_struct.c](return_struct.c)
    1.  switch
        1.  [switch3.c](switch3.c)
        1.  [switch6.c](switch6.c)
        1.  [switch6_spread.c](switch6_spread.c)
        1.  [switch6_very_spread.c](switch16_very_spread.c)
    1.  [Cast int to long](cast_int_long.c)
    1.  Floating point
        [float_sum.c](float_sum.c)
        [float2int.c](float2int.c)
        [sqrt.c](sqrt.c)
    1.  Optimization
        1.  [for_empty.c](for_empty.c)
        1.  [while_infinite.c](while_infinite.c)
        1.  [use_rax_return.c](use_rax_return.c)
        1.  [restrict.c](restrict.c)
        1.  [builtin_no_side_effect.c](builtin_no_side_effect.c)
        1.  [builtin_inline.c](builtin_inline.c)
        1.  [CSE](cse.c)
        1.  [CSE function](cse_function.c)
        1.  [CSE large function](cse_large_function.c)
        1.  Branch prediction
            1.   [__builtin_expect](gcc/builtin_expect.c)
            1.   [__builtin_expect off](gcc/builtin_expect_off.c)
        1.  [Precalculate loop](precalculate_loop.c)
        1.  [Precalculate loop without init](precalculate_loop_without_init.c)
        1.  [Bound simplficiation](bound_simplification.c)
1.  C++
    1. [class](class.cpp)
    1. [template](template.cpp)
    1. [constexpr.cpp](constexpr.cpp)
    1. [atomic.cpp](atomic.cpp)
    1. [this_method.cpp](this_method.cpp)
    1. [virtual.cpp](virtual.cpp)
1.  libc
    1. [memcmp.c](memcmp.c)
1.  ELF sections
    1. [bss.c](bss.c)
    1. [bss_static.c ](bss_static.c)
    1. [common.c](common.c)
    1. [data.c](data.c)

TODO

1.  Optimizations
    1.  Strength reduction, like multiplication to lea <https://en.wikipedia.org/wiki/Strength_reduction>
