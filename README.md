# mips-ce1920
Repository containing MIPS assembly code for university course (uniroma2, CE)

 * [Calcolatori Elettronici AA 19/20](http://www.ce.uniroma2.it/courses/ce1920/)
 * [SPIM MIPS Simulator (sourceforge)](http://spimsimulator.sourceforge.net/)
 * [MIPS Instruction Set](https://stefanobelli.github.io/mips-isa-brief)
 
# SPIM
SPIM is most likely available on distro's repositories, just look for it.

```
 :) ~> spim
Loaded: /usr/share/spim/exceptions.s
(spim) help

SPIM is a MIPS32 simulator.
Its top-level commands are:
exit  -- Exit the simulator
quit  -- Exit the simulator
read "FILE" -- Read FILE containing assembly code into memory
load "FILE" -- Same as read
run <ADDR> -- Start the program at (optional) ADDRESS
step <N> -- Step the program for N instructions (default 1)
continue -- Continue program execution without stepping
print $N -- Print register N
print $fN -- Print floating point register N
print ADDR -- Print contents of memory at ADDRESS
print_symbols -- Print all global symbols
print_all_regs -- Print all MIPS registers
print_all_regs hex -- Print all MIPS registers in hex
reinitialize -- Clear the memory and registers
breakpoint <ADDR> -- Set a breakpoint at address ADDR
delete <ADDR> -- Delete breakpoint at address ADDR
list -- List all breakpoints
dump [ "FILE" ] -- Dump binary code to spim.dump or FILE in network byte order
dumpnative [ "FILE" ] -- Dump binary code to spim.dump or FILE in host byte order
. -- Rest of line is assembly instruction to execute
<cr> -- Newline reexecutes previous command
? -- Print this message

Most commands can be abbreviated to their unique prefix
e.g., ex(it), re(ad), l(oad), ru(n), s(tep), p(rint)

(spim) read "main.s"
(spim) run
(spim) exit
```
