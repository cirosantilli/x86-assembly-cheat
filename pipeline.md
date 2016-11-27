# Pipeline

Throughput latency tradeoff. Hugely advantageous on throughput side, so always used today.

- <http://en.wikipedia.org/wiki/Instruction_pipeline>
- <http://en.wikipedia.org/wiki/Operand_forwarding> <http://web.cs.iastate.edu/~prabhu/Tutorial/PIPELINE/forward.html>
- <http://en.wikipedia.org/wiki/Bubble_%28computing%29>
- <https://en.wikipedia.org/wiki/Very_long_instruction_word>
- <https://en.wikipedia.org/wiki/Orthogonal_instruction_set>
- <https://en.wikipedia.org/wiki/Bubble_(computing)> (AKA pipeline stall)

Tutorials:

- <https://scalibq.wordpress.com/2012/02/19/cpus-and-pipelines-how-do-they-work/>
- <https://www.cs.uaf.edu/2010/fall/cs441/lecture/09_16_pipelining.html>
- <https://www.youtube.com/watch?v=euhQ_hdDGA8> talks about the classic 5 stage pipeline
- <https://compas.cs.stonybrook.edu/course/cse502-s13/lectures/cse502-L4-pipelining.pdf> good structural diagram

## Hazards

Types:

- data
- structural: same pipeline stage used by two instructions at the same time
- control: branches

- <https://en.wikipedia.org/wiki/Hazard_%28computer_architecture%29>

## Classic RISC pipeline

Most tutorials cover this, so it is likely a good idea to learn this one real well.

Seems to come from MIPS, so basic MIPS assembly will help you.

<https://en.wikipedia.org/wiki/Classic_RISC_pipeline>

## Implementations

Vendors document pipeline length.

Intel: <https://en.wikipedia.org/wiki/List_of_Intel_CPU_microarchitectures>
