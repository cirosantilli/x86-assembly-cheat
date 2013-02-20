simple assembler scripts and cheatsheets

#sources
{
    #<http://www.tldp.org/HOWTO/Assembly-HOWTO/index.html>
    #<http://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture>

    #programming from the ground up
    {
        <http://download.savannah.gnu.org/releases/pgubook/>

        linux gas, for complete programming beginners
    }

    #pc assembly language
    {
        <http://www.drpaulcarter.com/pcasm/>

        nasm
    }
}

#pros and cons
{
    <www.tldp.org/HOWTO/Assembly-HOWTO/x120.html>

    #pros
    {
        #speed
        {
            it gets harder and harder to make code more efficient using assembler
            because compilers are smarter and smarter

            #{
                use instructions that are so cpu specific and useful for your needs
                that compilers don't implement
            }

            #{
                use instructions in a way that is smarter than any compiler is likely to do
            }
        }

        #do the impossible
        {
            access low level hardware which is so hardware specific it is not implemented in standard c
        }
    }

    #cons
    {
        #os/processor dependant

        #hard to read/write

        {
            other things are much more likelly to speed up your code
            if that's what you want, namely:

            #better algorithms

            #better cache usage

            and only then, using assembly may stand a change to speeding thing up.
        }
    }
}

#instruction set architectures (ISA)
{
    list of operations the processor can do. obvioustly, ultra processor dependant.
    
    <http://en.wikipedia.org/wiki/Comparison_of_CPU_architectures>

    #CISC vs RISC
    {
        #RISC
        {
            a minimum of operations

            performs each one very fast
        }

        #CISC
        {
            lots of operations
        }
    }

    #flynn's taxonomy
    {
        <http://en.wikipedia.org/wiki/Flynn%27s_taxonomy>

        #SISD
        #SIMD
        #MIMD
    }

    #intel IA-32
    {
        commonly known as x86 or x86-32 or x386

        <http://en.wikipedia.org/wiki/X86_instruction_listings>

        majority of pcs today

        AMD also has compatible cpus

        cisc

        backwards compatible to the 1970s !

        #history
        {
            #intel 8080
            {
                1974, 8 bit, 2Mhz, very popular
            }

            #intel 8086
            {
                1976, 16 bit, very popular, base to x86 language
            }

            #intel 80386
            {
                aka i386

                1985, 32 bit word register
            }

            #intel 8087
            {
                1980

                external floating point coprocessor for 8086

                included inside cpus starting from hte 80436

                x87 often used to describe the floating point operations
                inside the processors

                instructions include:

                #FSQRT
                #FPTAN
                #FPATAN
            }

            #intel 8087
            {
                1987
                
                external floating point coprocessor

                added more f point operations:

                #FSIN
                #FSINCOS
            }

            #intel 80486
            {
                1989

                includes floating point unity
            }
        }

        #registers
        {
            #suffixes
            {
                B byte
                W word = 2 bytes
                D double word = 2 words (a c ``int``)
                Q quad word
                T ten bytes
            }

            #acess modes
            {
                #32 bit. extended. eax
                #16 bit. ax
                #8 bit lower. al
                8 bit upper. au
            }

            #list of all
            {
                #8 general-purpose registers (gpr)
                {
                }

                #6 segment registers
                {
                    #SS {start of stack}
                    #DS {start of data}
                    #CS {start of code}
                    #ES, FG, GS {far pointer == god knows what TODO}
                }

                #index and pointers
                {
                    ESI EDI EBP EIP ESP
                }

                #1 flags register
                {
                    each bit means some boolean

                    FLAGS: 16 lower bits
                    EFLAGS: (extended) 16 upper bits, or all of them

                    #0 CF (carry flag)
                }

                #an instruction pointer
                {
                    adress of instruction to execute
                }
            }

            #little endian
        }

        #instructions
        {
            <http://en.wikipedia.org/wiki/X86_instruction_listings>
        }
    }

    #arm
    {
        great majority of mobile phones

        low power consumption
    }
}

#executable formats
{
    #elf
    {
        linux

        superseeds ``.coff`` which superseeds ``a.out``
    }

    #mach-o { macos }
    #pe     { windows. current exes. }
}

#language syntax
{

    #standardization
    {
        there is de facto standard (even if there is an IEEE one)
        even for a given architecture!

        therefore, each assemble has its own language
        
        luckly, this language often based on the manual syntax
    }
    
    directive: not machine language, assembler programming

    #two main branches
    {
        #intel
        {
            used to document intel x86 at first

            more popular on windows
        }

        #at&t
        {
            more popular for linux, since unix was created at bell labs
        }
    }
}

#assemblers
{
    #definition
    { 
        programs that transform text in computer code
    }
    
    #listof
    {
        #nasm
        {
            one of the most popular for linux

            open source

            intel like syntax

            #input formats
            {
                #.asm
            }

            #output formats
            {
                #elf
                #pe
                #mach-o
            }
        }

        #gas
        {
            gnu

            executable name: ``as``

            gcc backend. point up to learning its syntax:
            allows you to to understand gcc generated code!

            at&t based syntax

            outputs to lots of architectures

            nasm manual says it is inconvenient to write by hand,
            because meant to be a gcc. I agree it is uglier to write.
        }

        #masm
        {
            microsoft

            x86
        }

        #tasm
        {
            borland

            stands for ``turbo`` assembler lol, why not ``basm``?

            windows only
        }
    }
}

#gcc
{
    you can generate gcc assembler code via:
    
    ``
        gcc -S a.c -o a.s
        gcc -masm=att -S a.c -o a.s
        gcc -masm=intel -S a.c -o a.s
    ``
}

#memory segments
{
}


#system calls
{
    #what is
    {
        tell your os to do things which program can't such as:

        #write to stdout, stderr, files
        #access devices
        #process/threading
        #exit a program

        ultra os dependant. to work around, you can inerface with c stdlib.
    }

    #linux
    {
        #<http://syscalls.kernelgrok.com/>
        {
            full list
            c manpage links
            register args mnemonic
            likss to online source cde 
        }

        #<http://www.lxhp.in-berlin.de/lhpsysc0.html>
        {
            contains actual binary values of constants!
        }

        196 commands total

        ``int	$0x80`` calls

        ``%eax`` holds what command. each call has a number

        ``%ebx``, ``%ecx``, ``%edx``, ``%esx``, ``%edi`` are the params

        all can be accessed by POSIX c functions.

        #listof
        {
            #reboot {reboots or enables/disables ctrl+alt+del reboot}

            #file descriptors
            {
                #open
                #close
                #write
                #read
                #lseek {reposition read/write}
                #dup
            }

            #dirs
            {
                #getcwd {processes have working info associated}
                #chdir
                #fchdir {using a file descriptor instead of string}
                #chroot
                #creat {create file or device. TODO: what is a device}
                #mknod {create a directory or special or ordinary file}
                #link {create new name for file}
                #unlink {delete link, and possibly file it refers to. TODO when deletes?}
                #mkdir
                #rmdir
                #rename
                #access {check real user's permissions for a file}
                #chmod

                #chown
                #fhown {by file descriptor}
                #lchown {no sym links}
            }
            #sethostname {process have associated hostname info}

            #time
            {
                #time {since January 1, 1970}
                #stime {set system time}
                #times {process and waitee for time}
                #nanosleep
                #utime {change access and modification time of files}
            }

            #process
            {
                #exit
                #fork
                #kill
                #waitpid
                #clone
                #execve
                #priority
                {
                    process have a priority number from -20 to 19

                    lower number means higher priority

                    #nice
                    #getpriority
                    #setpriority
                }
                #ptrace {TODO ?}
            }


            #data segment size
            {
                #brk {set}
                #sbrk {increment. called if heap is not large enough on ``malloc``}
            }

            #getppid {process parent id}
            #getpgid {process group id}

            #getuid, setuid, geteuid, seteuid
            {
                gets/sets user who is running the process

                each process has calling user information associated to it
            }

            #getgroups setgroups
            {
                get/set suplementary group ids of calling process

                each process has group information associated to it
            }

            #mount
            #umount


            #ipc
            {
                #signals
                {
                    #signal
                    #sigaction {handler gets more info than with signal}
                    #sys_pause {wait for signal}
                    #alarm {send alarm signal in n secs}
                }

                #pipe {create pipe}

                #flock {advisory file lock}

                #sockets
                {
                    #accept
                    #bind
                    #socket
                    #socketcall
                    #socketpair
                    #listen
                }
            }

            #memory
            {
                #cacheflush {flush instruction or data cache contents}
                #getpagesize {get memory page size}
            }
        }
    }
}

#signals
{
    simple/fast/limited IPC: send a byte to another process

    part of the core's process model

    signals can be caught by the program and dealt with (except for STOP and KILL)

    to catch a signal, a process has to register a signal handler function with a system call
    which in linux can be done with the ``sys_signal`` family

    #linux
    {
        <http://www.kernel.org/doc/man-pages/online/pages/man7/signal.7.html>
    }
}

#SIMD instructions
{
    more and more, SIMD instructions are being added

    for some time now intel has been grouping those instructions under the ``SSE`` name

    <http://neilkemp.us/src/sse_tutorial/sse_tutorial.html>

    TODO
}

TODO
{
    - interfacing with c
    - protected vs real mode
    - kernel
    - segments/flat memory model TODO ?

    #c integration
    { intrinsics: TODO }
}
