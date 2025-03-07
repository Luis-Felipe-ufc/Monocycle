module signal_extend(
    input  logic [15:0] immediate, // 16-bit immediate value
    output logic [31:0] extended    // 32-bit extended value
);

    // Sign-extend the 16-bit immediate to 32 bits
    // The sign bit (bit 15) is replicated to extend the value
    assign extended = {{16{immediate[15]}}, immediate};  // Concatenate the sign-extended bits with the original immediate value

endmodule
