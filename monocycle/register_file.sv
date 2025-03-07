module register_file(
    input  logic        clk,           // Clock signal
    input  logic        reset,         // Reset signal
    input  logic        reg_write,     // Control signal for write operation
    input  logic [4:0]  read_reg1,     // Register address for read operation 1
    input  logic [4:0]  read_reg2,     // Register address for read operation 2
    input  logic [4:0]  write_reg,     // Register address for write operation
    input  logic [31:0] write_data,    // Data to be written to register
    output logic [31:0] read_data1,    // Data read from register 1
    output logic [31:0] read_data2     // Data read from register 2
);

    logic [31:0] registers [0:31];     // 32 registers of 32 bits each

    // Initialization: Set register 0 to always be zero
    initial begin
        registers[0] = 32'b0;  // Register 0 is always 0
    end

    // Read operation: Assign data from registers to read outputs
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Write operation and reset logic
    always_ff @(posedge clk) begin
        if (reset) begin
            // On reset, set all registers to zero
            for (int i = 0; i < 32; i++) begin
                registers[i] <= 32'b0;
            end
        end else if (reg_write && write_reg != 5'b0) begin
            // If reg_write is enabled and the write register is not zero, write data
            registers[write_reg] <= write_data;
        end
    end

endmodule
