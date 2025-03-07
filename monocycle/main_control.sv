module main_control(
    input  logic Op5,          // Opcode BIT 5
    input  logic Op4,          // Opcode BIT 4
    input  logic Op3,          // Opcode BIT 3
    input  logic Op2,          // Opcode BIT 2
    input  logic Op1,          // Opcode BIT 1
    input  logic Op0,          // Opcode BIT 0
    output logic reg_dst,      // Select destination register (1 = rd, 0 = rt)
    output logic branch,       // Enable branching
    output logic mem_read,     // Enable memory read
    output logic mem_to_reg,   // Write memory data to register
    output logic alu_op_1,     // ALU operation control BIT 1
    output logic alu_op_0,     // ALU operation control BIT 0
    output logic mem_write,    // Enable memory write
    output logic alu_src,      // Select ALU source (1 = immediate, 0 = register)
    output logic reg_write     // Enable register writing
);

    logic [5:0] opcode;
    assign opcode = {Op5, Op4, Op3, Op2, Op1, Op0};
    // Control signal generation based on opcode
    always_comb begin
        // Default values for control signals
        reg_dst    = 0;
        alu_src    = 0;
        mem_to_reg = 0;
        reg_write  = 0;
        mem_read   = 0;
        mem_write  = 0;
        branch     = 0;
        alu_op_1   = 0;
        alu_op_0   = 0;            

        case (opcode)
            6'b000000: begin // R-type instruction
                reg_dst    = 1;
                reg_write  = 1;
                alu_op_1   = 1; // ALU control decides the operation
            end
            6'b100011: begin // LW (load word)
                alu_src    = 1;
                mem_to_reg = 1;
                reg_write  = 1;
                mem_read   = 1;
            end
            6'b101011: begin // SW (store word)
                alu_src    = 1;
                mem_write  = 1;
            end
            6'b000100: begin // BEQ (branch if equal)
                branch     = 1;
                alu_op_0   = 1; // Subtract for comparison
            end
            default: begin
                // Default case to handle undefined opcodes
                // All signals remain deasserted
            end
        endcase
    end

endmodule

