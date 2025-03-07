module control(
    input  logic Op5,                   // Opcode BIT 5
    input  logic Op4,                   // Opcode BIT 4
    input  logic Op3,                   // Opcode BIT 3
    input  logic Op2,                   // Opcode BIT 2
    input  logic Op1,                   // Opcode BIT 1
    input  logic Op0,                   // Opcode BIT 0
    input  logic F5,                    // Funct field for R-type instructions Bit 5
    input  logic F4,                    // Funct field for R-type instructions Bit 4
    input  logic F3,                    // Funct field for R-type instructions Bit 3
    input  logic F2,                    // Funct field for R-type instructions Bit 2
    input  logic F1,                    // Funct field for R-type instructions Bit 1
    input  logic F0,                    // Funct field for R-type instructions Bit 0
    output logic reg_dst,               // Select destination register (1 = rd, 0 = rt)
    output logic branch,                // Enable branching
    output logic mem_read,              // Enable memory read
    output logic mem_to_reg,            // Write memory data to register
    output logic mem_write,             // Enable memory write
    output logic alu_src,               // Select ALU source (1 = immediate, 0 = register)
    output logic reg_write,             // Enable register writing
    output logic [3:0] alu_control      // ALU control signal
);

wire ALUOp1, ALUOp0; // ALU operation control signals

// Instantiate the main control unit, which generates control signals based on the opcode
main_control M_CTR (
    .Op5(Op5), .Op4(Op4), .Op3(Op3), .Op2(Op2), .Op1(Op1), .Op0(Op0),
    .reg_dst(reg_dst), .branch(branch), .mem_read(mem_read), .mem_to_reg(mem_to_reg),
    .alu_op_1(ALUOp1), .alu_op_0(ALUOp0), .mem_write(mem_write), .alu_src(alu_src),
    .reg_write(reg_write)
);

// Instantiate the ALU control unit, which generates the ALU control signal based on the funct field and ALUOp
ALU_control ALU_CTR (
    .F5(F5), .F4(F4), .F3(F3), .F2(F2), .F1(F1), .F0(F0),
    .ALUOp1(ALUOp1), .ALUOp0(ALUOp0), .alu_control(alu_control)
);

endmodule
