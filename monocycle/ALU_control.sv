module ALU_control(
    input logic ALUOp1,                 // ALU operation control Bit 1
    input logic ALUOp0,                 // ALU operation control Bit 0
    input logic F5,                     // Funct field for R-type instructions Bit 5
    input logic F4,                     // Funct field for R-type instructions Bit 4
    input logic F3,                     // Funct field for R-type instructions Bit 3
    input logic F2,                     // Funct field for R-type instructions Bit 2
    input logic F1,                     // Funct field for R-type instructions Bit 1
    input logic F0,                     // Funct field for R-type instructions Bit 0
    output logic [3:0] alu_control      // Control signal for the ALU
);

    logic [1:0] alu_op;  
    assign alu_op = {ALUOp1, ALUOp0}; // Combine ALUOp bits into a 2-bit signal

    logic [5:0] funct;
    assign funct = {F5, F4, F3, F2, F1, F0}; // Combine funct bits into a 6-bit signal

    always_comb begin
        case (alu_op)
            2'b00: alu_control = 4'b0010; // LW, SW (ADD operation)
            2'b01: alu_control = 4'b0110; // BEQ (SUB operation)
            2'b10: begin // R-type instructions
                case (funct)
                    6'b100000: alu_control = 4'b0010; // ADD operation
                    6'b100010: alu_control = 4'b0110; // SUB operation
                    default:   alu_control = 4'bxxxx; // Undefined operation
                endcase
            end
            default: alu_control = 4'bxxxx; // Invalid case
        endcase
    end

endmodule
