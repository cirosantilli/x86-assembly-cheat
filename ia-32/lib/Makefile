.PHONY: all clean

all:
	$(NASM) -dELF_TYPE -o asm_io$(OBJ_EXT) asm_io.asm
	$(CCC) -o driver$(OBJ_EXT) -c driver.c

clean:
	rm -f *$(OBJ_EXT) *$(OUT_EXT)
