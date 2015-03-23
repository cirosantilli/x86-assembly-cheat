# IA-32

Major cheat on x86 assembly.

Seems to be the best option for writing assembly nowadays.

Code is OS portable by default: strictly necessary system calls like write and exit are done through a portable C driver.

Beware that the virtual machine may have less features than you actual CPU. Check `cat /proc/cpuinfo`.
