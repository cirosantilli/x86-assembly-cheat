# ldd

Print information about the configuration of the dynamic loader `ld-linux.so`.

List required shared libraries of an executable and if they can be found.

`binutils` package.

    man ldd
    man ld.so

Usage:

    ldd /bin/ls

Sample output:

    linux-vdso.so.1 =>  (0x00007ffd3cbdc000)
    libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007effc013d000)
    libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007effbff35000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007effbfb70000)
    libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007effbf932000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007effbf72e000)
    /lib64/ld-linux-x86-64.so.2 (0x00007effc0360000)
    libattr.so.1 => /lib/x86_64-linux-gnu/libattr.so.1 (0x00007effbf529000)

Quick reminder:

- `linux-vdso`: magically loaded by the kernel to make system calls faster
- `libselinux`, `libacl`: access control stuff
- `libc`: C standard library
- `libpcre`: Perl Compatible Regular expressions.

Possible outputs:

- `Not a dynamic executable`
- `liba.1.so => /lib/liba.1.so`
- `liba.1.so => not found`

## vs readelf -d (NEEDED)

I think `readelf` does not take into account dependencies of dependencies:

- <http://stackoverflow.com/questions/6242761/how-do-i-find-the-direct-shared-object-dependencies-of-a-linux-elf-binary>
- <http://unix.stackexchange.com/questions/120015/how-to-find-out-the-dynamic-libraries-executables-loads-when-run>

For example:

    readelf -d /bin/ls | grep NEEDED

Gives:

    0x0000000000000001 (NEEDED)             Shared library: [libselinux.so.1]
    0x0000000000000001 (NEEDED)             Shared library: [libacl.so.1]
    0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

Then:

    readelf -d /lib/x86_64-linux-gnu/libselinux.so.1 | grep NEEDED

Gives:

    0x0000000000000001 (NEEDED)             Shared library: [libpcre.so.3]
    0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
    0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
    0x0000000000000001 (NEEDED)             Shared library: [ld-linux-x86-64.so.2]

so this is where `libpcre` came from.

## Verbose

## Show linked symbols

    LD_DEBUG=bindings ldd -r /bin/date

Shows a huge amount of debug information! <http://stackoverflow.com/a/5567907/895245>

But also consider `ld -y` and `info symbol &printf` inside GDB: <http://stackoverflow.com/a/5533801/895245>
