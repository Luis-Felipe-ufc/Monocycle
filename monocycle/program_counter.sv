module program_counter(
    input  logic        clk,         // Clock signal
    input  logic        reset,       // Reset signal
    input  logic        pc_write,    // Controls the updating of the PC
    input  logic [31:0] pc_in,       // Next PC address (input to be loaded)
    output logic [31:0] pc_out      // Current PC address (output)
);

    // Always block triggered on rising edge of clock or reset signal
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            pc_out <= 32'b0; // When reset is active, PC is set to zero
        else if (pc_write) 
            pc_out <= pc_in; // If pc_write is enabled, update PC with pc_in
    end

endmodule
