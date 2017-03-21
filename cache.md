# Cache

- <https://en.wikipedia.org/wiki/CPU_cache>
- <http://stackoverflow.com/questions/16699247/what-is-cache-friendly-code>
- <http://stackoverflow.com/questions/9936132/why-does-the-order-of-the-loops-affect-performance-when-iterating-over-a-2d-arra>
- <http://stackoverflow.com/questions/8469427/how-and-when-to-align-to-cache-line-size>
- <http://stackoverflow.com/questions/763262/how-does-one-write-code-that-best-utilizes-the-cpu-cache-to-improve-performance>
- <http://stackoverflow.com/questions/7905760/matrix-multiplication-small-difference-in-matrix-size-large-difference-in-timi>
- <http://stackoverflow.com/questions/8547778/why-is-one-loop-so-much-slower-than-two-loops>

## Example

Shut up and do an ASCII art example, first direct mapped then set.

## Direct mapped

One possible cache location per memory address.

Upside: simple circuit, fast to find which is it, and small area.

Downside: you might invalidate an entry that was recently accessed, even if all other entries are old.

## Fully associative

One cache entry for every memory, so would be perfect because no conflicts.

But of course, requires a cache as large as main memory, thus useless.

## Set associative

Middle ground between direct mapped.

- 2 way associative example <https://www.youtube.com/watch?v=mCF5XNn_xfA>

Now address specifies the set where it might be, and the tag can be anywhere in that set.

Unlike direct mapped, you now have the fun choice of which entry to evict when a set is full: <https://en.wikipedia.org/wiki/Cache_replacement_policies>

## Bits

Forgetting SMP coherency.

### Validity bit

If false, indicates that the given data is invalid, and must be re-fetched.

When it is set to invalid:

- at startup, everything is set invalid, otherwise we wouldn't be able to differentiate between valid data and the noise present at startup. This is the major use case.
- another processor modifies main memory for a cache that we hold https://en.wikipedia.org/wiki/Bus_snooping

### Dirty bit

Set whenever the CPU writes to cache, unset when cache is written to main memory.

## Tag

Part of the original address (MSB), stored in the cache, to disambiguate if a cache line is a hit or not.

## Virtual or physical memory

Four possibilities: virtual or physical addressed or tagged.

TODO: which one is best / most common and why?

## Cache coherency

You have many CPUs modifying memory. How to keep caches up to date.

- <https://en.wikipedia.org/wiki/Cache_coherence>
- <https://en.wikipedia.org/wiki/Snarfing>
- <https://en.wikipedia.org/wiki/Bus_snooping>
- <https://en.wikipedia.org/wiki/Dragon_protocol>
- <https://en.wikipedia.org/wiki/Firefly_(cache_coherence_protocol)>
- <https://en.wikipedia.org/wiki/Write-once_(cache_coherence)>
- <https://en.wikipedia.org/wiki/MESIF_protocol>
- <https://en.wikipedia.org/wiki/MERSI_protocol>
- <https://en.wikipedia.org/wiki/MOESI_protocol>
- <https://en.wikipedia.org/wiki/MOSI_protocol>
- <https://en.wikipedia.org/wiki/MESI_protocol>
- <https://en.wikipedia.org/wiki/MSI_protocol>
- ARM AMBA 4 ACE

## Register vs cache

TODO physically different? Apparently not, both made of flip-flops (SRAM), registers can be seen as an L0 cache.

- <http://stackoverflow.com/questions/3500491/are-cpu-registers-and-cpu-cache-different>
- <http://stackoverflow.com/questions/14504734/cache-or-registers-which-is-faster>
- <http://superuser.com/questions/208932/difference-between-cache-memory-and-register>
- <https://www.quora.com/How-does-a-cache-memory-differ-from-registers>
