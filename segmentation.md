# Segmentation

Described on the AMD64 manual vol. 2 Chapter 4 - Segmentation.

Makes the transition from logical to linear addresses. Linear addresses are then converted to physical addresses (those that go to RAM wires) by the paging circuits:

    (logical) ------------------> (linear) ------------> (physical)
                 segmentation                 paging

Segmentation does not exist anymore in x86-64 64-bit mode: only in compatibility mode.

This feature was initially meant to be used to implement process virtual memory spaces, but this usage has been mostly supplanted by a later implemented feature called paging. This is probably why it was dropped in x86-64.

The main difference between paging and segmentation is that the size of pages if fixed, while the size of segments can vary and is indicated inside the segment descriptor.

Besides address translation, the segmentation system also manages of other features, such as the privilege level of execution (ring) functionality which is still widely used, and compatibility mode.

In Linux 32-bit for example, only two segments are used at all times: one at ring 0 for the kernel, and one another at privilege 3 for all user processes. TODO draw.

## Hardware implementation

Like paging, the segmentation transformation needs to happen on every memory read and write. For this reason, it is implemented *by the hardware*.

The processor manual says something like:

- when segmentation is turned on
- I will look for segmentation information (local and global descriptor tables) at the RAM physical address at my register X, which can be read and set by the `gdtr`, `ldtr`, `lgdt` and `lldt` instructions.
- the local and global descriptor tables must have to have the following format
- using that information on RAM, I will decide how to do the address translation and every other function of the segmentation system

It is then OS to set up and manage those RAM data structures and CPU registers to make the CPU do what it wants.

## Global descriptor table

RAM data structure that holds segment information.

The segment information data structure is called a *segment descriptor*.

Each segment descriptor is identified and retrieved via a *segment selector* structure.

### Local descriptor table

TODO vs global?

## Segment selector

A segment selector is a 16 bit structure that identifies the current segment descriptor and the current privilege level.

It has the following fields:

-   index: 13 bits to identify the Segment descriptor within the current table.

    There can therefore be up to 2^13 segment descriptors on a table.

    The current table is determined by the values of `gdtr` and `ldtr` registers and by the TI bit of the segment selector.

-   `RPL`: Request privilege level.

    The privilege level of the code that will execute a Code segment.

-   `TI`: 1 bit table indicator. If set, indicates that this is a local descriptor table.

    Otherwise, it is a global descriptor table.

## Segment descriptor

Segment descriptors are kept in RAM, and are used by the hardware to translate logic to linear addresses.

It is up to the OS to set up and maintain segment descriptors on the RAM, and to inform the hardware of its location via the `gdtr` and `ldtr` registers The OS can modify those registers via the `lgdt` and `lldt` instructions.

Segment descriptors are kept inside tables which contain many contiguous segment descriptors called either global descriptor table or local descriptor table.

Each segment descriptor is 8 bytes long, and contains information such as the following.

-   BASE: 32 bit start address and end address of the segment

-   LIMIT: 20 bit segment length. This is multiplied by $2^12$ if G is set so the maximum length is 4GB ($2^32$).

    Minimum length is 4 Kb.

-   G: granularity flat. If set, LIMIT is in multiples of $2^12$ bytes, else multiples of 1 byte.

-   DPL: 2 bit privilege level.

    Compared to the privilege level of the Segment Selector to determine if users have or not permission to take certain actions ( the rings are based on this )

-   Type: 4 bit type field. Some of the types are:

    - Code: indicates a code segment. It is on this case the permissions to take actions are checked.

    - Data:

    - TSSD: task state segment descriptor. The segment contains saved register values (between process sleeps)

    - LDTD: the segment contains a local descriptor table

-   S: system

    If set, indicates that the RAM of that segment contains important structures such as Local descriptor table.

The current segment descriptor is determined by the current segment selector and the values of the `gdtr` and `ldtr` registers.

## Segment registers

Segment registers contain segment selectors

There are 6 segment registers.

3 have special meanings:

- CS: code segment
- SS: TODO
- DS: data segment

And the other three don't and are free for programmer use.

- ES
- FG
- GS

Segment selectors can be put into those segment registers via `mov` instructions.

Each segment selector has an associated read only register which contains the corresponding segment descriptor to that selector.

Segment descriptors are pulled into dedicated processor registers automatically when a segment register changes value.

This allows to read segment descriptors from RAM only once when segments change, and access them directly from the CPU the following times.

TODO which of those segments are used at each time?

## Segment descriptor types

TODO what is the difference between types?

## Example of address translation

TODO very important. One example, two programs running. Logical to linear address translation.

## Linux

TODO How Linux uses segments.
