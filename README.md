# mips-ce1920
Repository containing MIPS assembly code for university course (uniroma2, CE)

 * [Calcolatori Elettronici AA 19/20](http://www.ce.uniroma2.it/courses/ce1920/)
 * [SPIM MIPS Simulator (sourceforge)](http://spimsimulator.sourceforge.net/)
 
### SPIM
SPIM is most likely available on distro's repositories, just look for it.

 * Ubuntu: [spim](https://packages.ubuntu.com/search?keywords=spim) (APT)
 * Debian: [spim](https://packages.debian.org/search?keywords=spim) (APT)
 * Fedora: [spim](https://rpmfind.net/linux/rpm2html/search.php?query=spim) (RPM/?DNF?)
 * Arch Linux: [qtspim](https://www.archlinux.org/packages/community/x86_64/qtspim/) (Pacman)
 * ...
 
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

### Brief instruction set reference

 ```sw REG, REG/IMM``` (store word to addr in REG/IMM)
 
 ```lw REG, REG/IMM``` (load word from addr in REG/IMM)
 
 ```lb REG, REG/IMM``` (load byte from addr in REG/IMM)
 
 ```sb REG, REG/IMM``` (store byte to addr in REG/IMM)
 
 ```jr REG``` (jump to addr in REG)

 ```jal REG/IMM``` (jump to addr REG/IMM, **update** REG = ra)
 
 ```j IMM``` (jump to IMM)

 ```la REG, IMM``` (load IMM (address) in REG)

 ```li REG, IMM``` (load IMM (integer) in REG)

 ```beq REG, REG/IMM, *IMM``` (branch to *IMM if REG is equal to REG/IMM)
 
 ```addi REG, *REG, IMM``` (add integer *REG to IMM and store result to REG, **NOTE**: there is no subi, IMM will be a negative)
 
 ```move REG, *REG``` (move from *REG to REG)
 
 ```syscall``` (request the operating system to execute a service)

 ```add REG, *REG, #REG``` (add integer *REG to #REG and store result in REG)

 ```sub REG, *REG, #REG``` (sub integer *REG to #REG and store result in REG)

 ```bne REG, REG/IMM, *IMM``` (branch to *IMM if REG is NOT equal to REG/IMM)

 ```bgt REG, REG/IMM, *IMM``` (branch to *IMM if REG is GREATER than REG/IMM)

 ```mul REG, *REG, #REG``` (multiply *REG with #REG and store result in REG)

 ```mult REG, $REG``` (multiply REG with $REG and store least-upper 32 bit in lo-hi registers)

 ```div REG, $REG``` (divide REG by $REG and store result in lo 32 bit reg, hi )

 ```lui REG, IMM``` (load upper 16 bit IMM to REG, zero the least 16's)

 ```ori REG, IMM``` (load least 16 bit IMM to REG)

 ```mflo REG``` (load content of LO register to REG)

 ```mfhi REG``` (load content of HI register to REG)

 Instructions not listed are **VERY** similar to the ones listed above.
### SPIM syscall table
[here](http://students.cs.tamu.edu/tanzir/csce350/reference/syscalls.html)
