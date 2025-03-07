module data_memory(
    input  logic        clk,
    input  logic        reset,
    input  logic        mem_read,   // Signal for read operation
    input  logic        mem_write,  // Signal for write operation
    input  logic [31:0] address,    // Data address
    input  logic [31:0] write_data, // Data to be written
    output logic [31:0] read_data   // Read data
);

    logic [31:0] memory [0:255]; // Memory with 256 words

    // Memory initialization with conditions
    always_ff @(posedge clk) begin
        // Initialize memory on reset during the first clock cycle
        if (reset) begin
            memory[0] <= 32'd4;
            memory[1] <= 32'd5;
            memory[2] <= 32'd10;
            memory[4] <= 32'd1;
            // Add more initializations as needed
        end
        // Write operation
        if (mem_write)
            memory[address[9:2]] <= write_data; // Address aligned
    end

    // Read operation
    always_comb begin
        if (mem_read)
            read_data = memory[address[9:2]]; // Address aligned
        else
            read_data = 32'b0;
    end

endmodule
