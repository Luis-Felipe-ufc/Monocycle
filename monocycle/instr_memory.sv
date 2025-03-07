module instr_memory(
    input  logic [31:0] address,      // Address of the instruction (PC)
    output logic [31:0] instruction   // Instruction output
);

    // Memory array with 256 words, each 32-bit wide
    logic [31:0] memory [0:255];

    // Initialization of memory with predefined instructions
    initial begin
        memory[0] = 32'b100011_00000_00001_0000000000000000;   // 0x8c010000    LW R1, 0(R0)
        memory[1] = 32'b100011_00000_00010_0000000000000100;   // 0x8c020004    LW R2, 4(R0)
        memory[2] = 32'b000000_00001_00010_00011_00000_100000; // 0x00221820   ADD R3, R1, R2
        memory[3] = 32'b101011_00001_00011_0000000000001000;   // 0xac230008    SW R3, 8(R1)
        memory[4] = 32'b100011_00001_00100_0000000000000100;   // 0x8c240004    LW R4, 4(R1)
        memory[5] = 32'b100011_00001_00101_0000000000001000;   // 0x8c250008    LW R5, 8(R1)
        memory[6] = 32'b000000_00100_00101_00110_00000_100010; // 0x00853022   SUB R6, R4, R5
        memory[7] = 32'b100011_00001_00111_0000000000001100;   // 0x8c27000c    LW R7, 12(R1)
        memory[8] = 32'b000100_00110_00111_1111111111111101;   // 0x10c7fffd   BEQ R6, R7, -3 (branch back)
        memory[9] = 32'b101011_00001_00001_0000000000010000;   // 0xac210010    SW R1, 16(R1)
        memory[10] = 32'b101011_00001_00110_0000000000010000;  // 0xac260010    SW R6, 16(R1)
        // Additional instructions can be added as needed
    end

    // Read operation: Fetch instruction (word-aligned, 4-byte offset)
    assign instruction = memory[address[9:2]];

endmodule
