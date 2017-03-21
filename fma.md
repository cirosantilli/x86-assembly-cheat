# FMA

Fused Multiply Add.

Seems very important for some numerical computations. TODO which? Some people mentioned:

-   binary multiplication. But isn't that done in hardware directly already?
-   <https://www.quora.com/Floating-Point-How-does-Fused-Multiply-Add-FMA-work-and-what-is-its-importance-in-computing/answer/Shannon-Barber> mentions that multiply-accumulate-and-shift (TODO who implements the shift part?) is key for the z-transform
-   wikipedia mentions:
    - Dot product
    - Matrix multiplication
    - Polynomial evaluation (e.g., with Horner's rule)
    - Newton's method for evaluating functions.
    - Convolutions and artificial neural networks


So important that IEEE 754 specifies it with single precision drop compared to a separate add and multiply.

Wiki mentions it:



Bibliography

- <https://en.wikipedia.org/wiki/Multiply–accumulate_operation>
- <https://en.wikipedia.org/wiki/FMA_instruction_set>
- <http://stackoverflow.com/questions/28630864/how-is-fma-implemented>
- <https://en.wikipedia.org/wiki/Multiply–accumulate_operation>
