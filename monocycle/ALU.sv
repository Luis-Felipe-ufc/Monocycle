module ALU(
    input  logic [31:0] operand_a,      // First operand
    input  logic [31:0] operand_b,      // Second operand
    input  logic [3:0]  alu_control,    // Operation code
    output logic [31:0] result,         // Operation result
    output logic        zero            // Indicates if the result is zero
);

    always_comb begin
        case (alu_control)
            4'b0010: result = operand_a + operand_b;                   // ADD operation
            4'b0110: result = operand_a - operand_b;                   // SUB operation
            4'b0000: result = operand_a & operand_b;                   // AND operation
            4'b0001: result = operand_a | operand_b;                   // OR operation
            4'b0111: result = (operand_a < operand_b) ? 32'b1 : 32'b0; // SLT (Set Less Than)
            default: result = 32'b0;    // Undefined operation
        endcase
        zero = (result == 0);   // Set the zero flag
    end

endmodule
