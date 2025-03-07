# HOW IT WORKS #

### RESET ###
On reset, some spaces in the data memory are initialized with values so that operations can be performed;

The register file is also cleared.

### CONSTRUCTION ###
There is a top module that instantiates the control modules, instruction memory, data memory, and datapath;

The control module contains the main control and ALU control modules;

The datapath contains the register file, ALU, signal extend, program counter, as well as the multiplexers and adders.

### INSTRUCTIONS ###
The first two instructions load registers 1 and 2 with the values present in the first two memory locations;

The third instruction adds the two values and stores the result in register 3;

The fourth instruction stores the value of register 3 into memory at the address `R1 + 8`;

The fifth instruction loads the value from memory at the address `R1 + 4` into register 4;

The sixth instruction loads the value from memory at the address `R1 + 8` into register 5;

The seventh instruction subtracts the value in register 5 from the value in register 4 and stores the result in register 6;

The eighth instruction loads the value from memory at the address `R1 + 12` into register 7;

The ninth instruction checks if the values in registers 6 and 7 are equal. If they are, the program counter branches back by 3 instructions, creating a loop;

The tenth instruction stores the value of register 1 into memory at the address `R1 + 16`;

The eleventh instruction stores the value of register 6 into memory at the address `R1 + 16`;

The tenth and eleventh instructions are never executed due to the BEQ.

# HOW TO RUN IT #

To run the single-cycle processor, simply execute the script run_sim.sh. It will compile all the modules, the testbench, open the graphical interface, and load the necessary signals to confirm the proper operation of the selected instructions.
