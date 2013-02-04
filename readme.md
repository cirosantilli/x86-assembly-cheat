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
        #understand what the processor really does
    }

    #cons
    {
        no stdlibs

        os/processor dependant and thus importable

        other things are much more likelly to speed up your code
        if that's what you want namely:

        #better algorithms

        #better cache usage

        and only then, using assembly is likely to speed thing up.
    }
}

#instruction set architectures (ISA)
{
    list of operations the processor can do. obvioustly, ultra processor dependant.
    
    <http://en.wikipedia.org/wiki/Comparison_of_CPU_architectures>

    #intel x86
    {
        majority of pcs today

        AMD also has compatible cpus

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
                1985, 32 bit word register
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
                #6 segment registers
                #1 flags register
                {
                    each bit means some boolean

                    ex: 0: CF (carry flag)
                }
                #an instruction pointer
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
    {
        tell your os to do things which program can't such as:

        #write to stdout, stderr, files
        #access devices

        ultra os dependant. to work around, you can inerface with c stdlib.
    }

    #linux
    {
        <http://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.html>

        196 commands total

        ``int	$0x80`` calls

        ``%eax`` holds what command

        ``%ebx``, ``%ecx``, ``%edx``, ``%esx``, ``%edi`` are the params
    }
}

TODO
{

    - interfacing with c
    - protected vs real mode
    - kernel
    - segments/flat memory model TODO ?
}
