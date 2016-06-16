# RISC-V

<https://en.wikipedia.org/wiki/RISC-V>

Most promising open ;

They have a full working software toolchain:

- <https://github.com/riscv/riscv-linux> GCC
- <https://github.com/riscv/riscv-tools>
- <http://riscv.org/software-tools/riscv-qemu/>

Created in 2010. BSD license.

Userspace fixed in 2014, but kernel land not yet as of 2016. So the Linux port may have to change.

Google, HP and Oracle recently joined founding members https://www.reddit.com/r/opensource/comments/3ykeuo/google_hp_oracle_and_12_others_join_the_riscv/

UC Berkley.

TODO: any real hardware produced besides FPGA?

Debian port: <https://wiki.debian.org/RISC-V>

## Rocket

<https://github.com/ucb-bar/rocket-chip>

Written in Chisel, which is Scala based: <https://github.com/ucb-bar/chisel>

By Berkley people.

2015 presentation by Yunsup Lee <https://www.youtube.com/watch?v=Ir3h3qWcNlg>

A single source coce + some input parameters can generate:

- C++ simulator code
- FPGA Verilog
- ASIC Verilog

TODO: any plans for silicon production?

http://www.lowrisc.org/docs/untether-v0.2/

2016 thesis on it: <http://www.eecs.berkeley.edu/~waterman/papers/phd-thesis.pdf>

## lowRISC

- http://www.lowrisc.org/
- https://github.com/lowRISC/lowrisc-chip

RISC-V ASIC and FPGA implementation.

RISC-V is only the API.

Mass production planned for 2017: <http://www.lowrisc.org/about/>

By Cambridge people.

Mostly in System Verilog.

Google summer of code projects in 2016: http://www.lowrisc.org/blog/2016/03/apply-now-to-work-with-lowrisc-in-google-summer-of-code/ Gives great insights into what is going on.

Initial implementation reuse part of FPGA hardware: http://www.lowrisc.org/docs/untether-v0.2/ , they are trying to open things up further.

## SiFive

http://sifive.com/

Startup around RISC-V tech by Berkley people, contributors to <https://github.com/riscv/riscv-tools>

More linked to Rocket.

## Kestrel

<https://kestrelcomputer.github.io/kestrel/>

TODO what does it add to other RISC-V projects?

<https://www.reddit.com/r/linux/comments/4ez89a/kestrel_fullstack_open_source_and_open_hardware/>

The project owner works at Rackspace, who is partnering with Google for open source hardware initiatives: https://www.reddit.com/r/programming/comments/4dncvw/google_and_rackspace_codevelop_open_server/ | https://github.com/sam-falvo | https://github.com/KestrelComputer/kestrel/graphs/contributors

## OpenRISC

https://en.wikipedia.org/wiki/OpenRISC

LGPL / GPL. TODO: history?

RISC-V says it is better than them.

## Pulpino

<https://github.com/pulp-platform/pulpino>

ETH Zurich.

Previously closed source custom ISA I think, then opened and front-end hacked for RISC-V.

## News

2016 indiegogo https://www.indiegogo.com/projects/risc-v-microprocessor/x/6766065#/

2016 overview http://www.nextplatform.com/2016/03/08/risc-v-inching-closer-to-reality-at-scale/

2016 India investment: <http://www.eetimes.com/document.asp?doc_id=1328790>

<http://riscv.org/2016/04/risc-v-offers-simple-modular-isa/>

<https://www.quora.com/Would-RISC-V-become-the-dominant-CPU-architecture-in-the-next-5-years-given-that-Google-Oracle-and-HP-are-strongly-rallying-behind-RISC-V>
