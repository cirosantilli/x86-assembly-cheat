# ld-linux.so

TODO what does it do exactly. How is it called? By the kernel?

    man ld.so

`/lib64/ld-linux-x86-64.so.2` is the usual 64-bit version.

`ld-linux.so*` is the executable that does the dynamic loading for every executable.

As such, it cannot have any dependencies.

Its path is specified in the `.interp` section of ELF files, which Linux reads and uses to call `ld-linux`.

The default on Ubuntu 14.04 is `/lib64/ld-linux-x86-64.so.2`.

The program to be run is passed as an argument to `ld-linux`:

    /lib64/ld-linux-x86-64.so.2 a.out

Then:

    man execve

says that the path of the loader is stored in the elf file, and `readelf -a` shows a section devoted to it:

    INTERP         0x0000000000000238 0x0000000000400238 0x0000000000400238
                    0x000000000000001c 0x000000000000001c  R      1
        [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]

On Ubuntu 16.04, provided by the `libc6` package.

## LD_DEBUG

TODO

## LD_LIBRARY_PATH

You can also add to path with environment variables.

Don't rely on this method for production.

    export LD_LIBRARY_PATH='/path/to/link'

## ld.so

TODO what is it?

## ld.so.conf

TODO. E.g. Ubuntu 16.04 mesa:

    /usr/lib/x86_64-linux-gnu/mesa/ld.so.conf

## /etc/ld.so.conf

TODO.

## ldconfig

TODO
