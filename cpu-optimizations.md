# CPU Optimizations

CPU semi-internals that can be used to write more efficient code.

Compilers take most of those into consideration.

## Instruction level parallelism

<https://en.wikipedia.org/wiki/Instruction-level_parallelism>

### Instruction pipelining

<http://en.wikipedia.org/wiki/Instruction_pipeline>

- <http://en.wikipedia.org/wiki/Operand_forwarding>
- <http://en.wikipedia.org/wiki/Bubble_%28computing%29>
- <https://en.wikipedia.org/wiki/Very_long_instruction_word>

### Out of order processing

<http://en.wikipedia.org/wiki/Out-of-order_execution>

- <http://en.wikipedia.org/wiki/Register_renaming>

### Branch prediction

Only makes sense in pipelined processors: at a branch, it tries to guess which side will be taken, and puts those instructions in the pipeline.

- <http://en.wikipedia.org/wiki/Speculative_execution>
- <http://en.wikipedia.org/wiki/Branch_predictor>
- <http://en.wikipedia.org/wiki/Memory_dependence_prediction>

### Superscalar architecture

TODO vs pipeline and instruction level parallelism?

- <http://en.wikipedia.org/wiki/Superscalar>

## Megahertz myth

- <http://en.wikipedia.org/wiki/Megahertz_myth>

## Cache

- <http://stackoverflow.com/questions/16699247/what-is-cache-friendly-code>
- <http://stackoverflow.com/questions/9936132/why-does-the-order-of-the-loops-affect-performance-when-iterating-over-a-2d-arra>
- <http://stackoverflow.com/questions/8469427/how-and-when-to-align-to-cache-line-size>
- <http://stackoverflow.com/questions/763262/how-does-one-write-code-that-best-utilizes-the-cpu-cache-to-improve-performance>
- <http://stackoverflow.com/questions/7905760/matrix-multiplication-small-difference-in-matrix-size-large-difference-in-timi>
- <http://stackoverflow.com/questions/8547778/why-is-one-loop-so-much-slower-than-two-loops>
