AS=nasm -f elf
#assembler

LN=ld -s
#linker

EXE_NOEXT=nasm_cheat
EXE_EXT=.out
EXE=$(EXE_NOEXT)$(EXE_EXT)

all: $(EXE)

$(EXE): $(EXE_NOEXT).o
	$(LN) -o $(EXE) nasm_cheat.o 

$(EXE_NOEXT).o: $(EXE_NOEXT).asm
	$(AS) $(EXE_NOEXT).asm

clean:
	#find . -iname "*$(OUT_EXT)" -delete 
	rm -rf *$(OUT_EXT)
