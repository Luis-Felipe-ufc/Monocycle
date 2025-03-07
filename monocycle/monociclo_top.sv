module monociclo_top(
    input logic clk,          // Clock signal
    input logic reset        // Reset signal
);

// Wires for data connections
wire [31:0] instruction;    // Instruction fetched from memory
wire [31:0] pc_out, read_data2, alu_result, memory_data;  // Program counter, read data, ALU result, and memory data

// Control signals
logic reg_dst, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
logic [3:0] alu_control;  // ALU control signal
logic Op5, Op4, Op3, Op2, Op1, Op0;  // Opcode and function code
logic F5, F4, F3, F2, F1, F0;  // Function code from instruction

// Extract opcode and function code from the instruction
assign {Op5, Op4, Op3, Op2, Op1, Op0} = instruction[31:26];  // Opcode (6 bits)
assign {F5, F4, F3, F2, F1, F0} = instruction[5:0];  // Function code (6 bits)

// Instantiate the control unit with the extracted opcodes and function codes
control CTR (
    .Op5(Op5), .Op4(Op4), .Op3(Op3), .Op2(Op2), .Op1(Op1), .Op0(Op0),
    .F5(F5), .F4(F4), .F3(F3), .F2(F2), .F1(F1), .F0(F0),
    .reg_dst(reg_dst), .branch(branch), .mem_read(mem_read), .mem_to_reg(mem_to_reg),
    .mem_write(mem_write), .alu_src(alu_src), .reg_write(reg_write), .alu_control(alu_control)
);

// Instantiate the datapath with control signals and data connections
datapath DTP (
    .clk(clk), 
    .reset(reset),
    .reg_dst(reg_dst),
    .alu_src(alu_src),
    .alu_control(alu_control),
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .pc_out(pc_out),
    .instruction(instruction),
    .read_data2(read_data2),
    .alu_result(alu_result),
    .memory_data(memory_data)
);

// Instruction memory module to fetch instructions based on PC
instr_memory IM(
    .address(pc_out),        // Address from the program counter
    .instruction(instruction) // Instruction fetched from memory
);

// Data memory module for reading and writing data
data_memory DM(
    .clk(clk),               // Clock signal
    .reset(reset),           // Reset signal
    .mem_read(mem_read),     // Memory read signal
    .mem_write(mem_write),   // Memory write signal
    .address(alu_result),    // Address for memory access
    .write_data(read_data2), // Data to write to memory
    .read_data(memory_data)  // Data read from memory
);

endmodule
