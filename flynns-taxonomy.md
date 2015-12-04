# Flynn's taxonomy

<http://en.wikipedia.org/wiki/Flynn%27s_taxonomy>

- SISD
- SIMD
- MIMD

## SIMD

Out of Flynn's taxonomy, this is the model that promises the greatest advances currently.

Single instruction, multiple data, for example, making 4 multiplications on a single CPU cycle.

More and more, SIMD instructions are being added on different processors.

Intel has been grouping those instructions under the SSE name, but previously used other names like MMX.

GPGPUs are also another hot SIMD implementation.

See also: <http://neilkemp.us/src/sse_tutorial/sse_tutorial.html>

## SIMT

GPUs tend strongly to SIMD systems, but NVIDIA prefers to call them SIMT, because they feel they are more flexible than pure SIMD.

<http://yosefk.com/blog/simd-simt-smt-parallelism-in-nvidia-gpus.html>

It is a flexibility / throughput trade-off.
