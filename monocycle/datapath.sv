module datapath(
    input  logic        clk,
    input  logic        reset,
    input  logic        reg_dst,       // Select destination register (1 = rd, 0 = rt)
    input  logic        alu_src,       // Select ALU source (1 = immediate, 0 = register)
    input  logic [3:0]  alu_control,   // ALU operation control signal
    input  logic        mem_to_reg,    // Select data source for register write (1 = memory, 0 = ALU)
    input  logic        reg_write,     // Enable register write
    input  logic        mem_read,      // Enable memory read
    input  logic        mem_write,     // Enable memory write
    input  logic        branch,        // Enable branching
    input  logic [31:0] memory_data,   // Data from memory
    input  logic [31:0] instruction,   // Current instruction
    output logic [31:0] read_data2,    // Data read from register 2
    output logic [31:0] alu_result,    // ALU computation result
    output logic [31:0] pc_out         // Program counter output
);

    // Internal signals
    logic [31:0] pc_in, pc_plus_4;
    logic [31:0] read_data1, write_data;
    logic [31:0] sign_extended, alu_input_b;
    logic [4:0]  write_register;

    // Program Counter
    program_counter PC(
        .clk(clk),
        .reset(reset),
        .pc_write(1'b1),     // PC always updates
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // PC incrementer
    assign pc_plus_4 = pc_out + 4;

    // Register File
    register_file RF(
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_reg1(instruction[25:21]), // rs
        .read_reg2(instruction[20:16]), // rt
        .write_reg(write_register),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Sign Extension
    signal_extend SE(
        .immediate(instruction[15:0]),
        .extended(sign_extended)
    );

    // Multiplexer: Select rt or rd for register write
    assign write_register = reg_dst ? instruction[15:11] : instruction[20:16];

    // Multiplexer: Select immediate value or register value for ALU
    assign alu_input_b = alu_src ? sign_extended : read_data2;

    // Arithmetic Logic Unit (ALU)
    ALU ALU(
        .operand_a(read_data1),
        .operand_b(alu_input_b),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero)
    );

    // Multiplexer: Select memory data or ALU result for register write
    assign write_data = mem_to_reg ? memory_data : alu_result;

    // Multiplexer: Select branch address or PC + 4
    assign pc_in = (branch & zero) ? (pc_plus_4 + (sign_extended << 2)) : pc_plus_4;

endmodule
