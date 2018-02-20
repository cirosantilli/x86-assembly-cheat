# RISC-V

<https://en.wikipedia.org/wiki/RISC-V>

Most promising open ;

Created in 2010. BSD license.

Userspace fixed in 2014, but kernel land not yet as of 2016. So the Linux port may have to change.

Google, HP and Oracle recently joined founding members https://www.reddit.com/r/opensource/comments/3ykeuo/google_hp_oracle_and_12_others_join_the_riscv/

UC Berkley.

TODO: any real hardware produced besides FPGA?

Debian port: <https://wiki.debian.org/RISC-V>

## Software toolchain

- <https://github.com/riscv/riscv-linux> GCC
- <https://github.com/riscv/riscv-tools>
- <http://riscv.org/software-tools/riscv-qemu/>

Emulators: Spike is dedicated for this project:

- <http://stackoverflow.com/questions/32881106/riscv-qemu-scall-versus-spike-ecall>
- <http://52.32.189.224/angel-simulator/> JavaScript!

There are two types of simulation you can do:

- functional: assembly comes in and is emulated. Faster. Does not use the hardware implementation at all, and therefore does not test it: what is does test are software tools like compiler and kernel ports. May or not be cycle accurate as well, with performance hit if yes.
- RTL: the entire hardware is emulated. Slower, but more precise. You need the underlying hardware implementation. Always cycle accurate.

## Hardware implementations

### Rocket

<https://github.com/ucb-bar/rocket-chip>

Reference implementation.

Uses Chisel, which is Scala based: <https://github.com/ucb-bar/chisel>

Used by lowRISC.

By Berkley people. Backed by SiFive.

2015 presentation by Yunsup Lee <https://www.youtube.com/watch?v=Ir3h3qWcNlg>

A single source code + some input parameters can generate:

- C++ simulator code
- FPGA Verilog
- ASIC Verilog

TODO: any plans for silicon production?

<http://www.lowrisc.org/docs/untether-v0.2/>

2016 thesis on it: <http://www.eecs.berkeley.edu/~waterman/papers/phd-thesis.pdf>

Very good documentation: <https://github.com/ccelio/riscv-boom-doc>

### lowRISC

- http://www.lowrisc.org/
- https://github.com/lowRISC/lowrisc-chip

RISC-V ASIC and FPGA implementation.

RISC-V is only the API.

Uses Rocket, but one major innovation is that it includes IO devices, while Rocket needed an ARM IP for that: <https://youtu.be/9BU5yNeyI5k?t=91>

Mass production planned for 2017: <http://www.lowrisc.org/about/>

By Cambridge people.

Mostly in System Verilog.

Google summer of code projects in 2016: http://www.lowrisc.org/blog/2016/03/apply-now-to-work-with-lowrisc-in-google-summer-of-code/ Gives great insights into what is going on.

Initial implementation reuse part of FPGA hardware: http://www.lowrisc.org/docs/untether-v0.2/ , they are trying to open things up further.

Uses Verilator for simulation.

### Pulpino

<https://github.com/pulp-platform/pulpino>

ETH Zurich.

Previously closed source custom ISA I think, then opened and front-end hacked for RISC-V.

Uses ModelSim...

<https://github.com/pulp-platform/ariane> TODO vs pulpino. Has system land.

### Kestrel

<https://kestrelcomputer.github.io/kestrel/>

TODO what does it add to other RISC-V projects?

<https://www.reddit.com/r/linux/comments/4ez89a/kestrel_fullstack_open_source_and_open_hardware/>

The project owner works at Rackspace, who is partnering with Google for open source hardware initiatives: https://www.reddit.com/r/programming/comments/4dncvw/google_and_rackspace_codevelop_open_server/ | https://github.com/sam-falvo | https://github.com/KestrelComputer/kestrel/graphs/contributors

### Other implementations

- <https://github.com/cliffordwolf/picorv32>. Stand-alone Verilog, tiny implementation, easy to setup. No caches: <https://github.com/cliffordwolf/picorv32/issues/55> By Clifford Wolf.
- <https://github.com/sergeykhbr/riscv_vhdl> VHDL
- <https://github.com/ridecore/ridecore> out of core, Verilog
- <https://github.com/watz0n/learn-rv32i-asap> minimal, Chisel

## SiFive

<http://sifive.com/>

Startup around RISC-V tech by Berkley people, contributors to <https://github.com/riscv/riscv-tools>

More linked to Rocket.

## Tethered vs untethered

<https://youtu.be/XSyH9T-Cj4w?t=64> tethered cannot do IO on itself: <https://www.youtube.com/watch?v=XSyH9T-Cj4w>

Rocket it tethered, lowRISC untethered.

## Tapeouts

9 Silicon Prototypes: <https://web.archive.org/web/20160904102006/https://www2.eecs.berkeley.edu/Pubs/TechRpts/2016/EECS-2016-17.pdf>

<https://web.archive.org/web/20160904102554/https://people.eecs.berkeley.edu/%7Eyunsup/papers/riscv-esscirc2014.pdf>

## News

2016 indiegogo https://www.indiegogo.com/projects/risc-v-microprocessor/x/6766065#/

2016 overview http://www.nextplatform.com/2016/03/08/risc-v-inching-closer-to-reality-at-scale/

2016 India investment: <http://www.eetimes.com/document.asp?doc_id=1328790>

<http://riscv.org/2016/04/risc-v-offers-simple-modular-isa/>

<https://www.quora.com/Would-RISC-V-become-the-dominant-CPU-architecture-in-the-next-5-years-given-that-Google-Oracle-and-HP-are-strongly-rallying-behind-RISC-V>

<http://www.design-reuse.com/news/40903/codasip-and-baysand-partnership-makes-risc-v-based-asics-an-ideal-choice-for-iot-designs.html>

<https://www.crowdsupply.com/onchip/open-v>: crowd funded attempt of RV microcontroller, open up to RTL level, on dev board. 50\$  each, delivery in 1.5 years.

## Conferences

- <http://orconf.org/index.html>

## Companies

Good place to search: <http://orconf.org/index.html#sponsors>
