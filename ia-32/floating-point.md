# Floating point

Before reading this, you should understand IEEE floating point formats.

Modern x86 has two main ways of doing floating point operations:

- FPU
- SSE

<http://stackoverflow.com/questions/1844669/benefits-of-x87-over-sse>

Advantages of FPU:

- present in old CPUs, while SSE2 is only required in x86-64
- contains some instructions no present in SSE, e.g. trigonometric
- higher precision: FPU holds 80 bit Intel extension, while SSE2 only does up to 64 bit operations despite having the 128-bit register

In GCC, you can choose between them with `-mfpmath=`.
