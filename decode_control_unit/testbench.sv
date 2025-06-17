`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 02:25:46
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlUnit_tb;

    // Testbench signals
    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [6:0]  funct7;
    logic        Zero;
    logic        Branch;
    logic        MemWrite;
    logic        ALUSrc;
    logic [1:0]  ImmSrc;
    logic        RegWrite;
    logic [1:0]  ResultSrc;
    logic [2:0]  ALUControl;
    logic        PCSrc;

    // Instantiate the ControlUnit
    ControlUnit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .Zero(Zero),
        .Branch(Branch),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .ALUControl(ALUControl),
        .PCSrc(PCSrc)
    );

    // Test procedure
    initial begin
 
        // Test 1: R-type instruction (ADD)
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000; Zero = 0;
        #10;

        // Test 2: R-type instruction (SUB)
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000; Zero = 0;
        #10;
        
        // Test 3: I-type ALU immediate (ADDI)
        opcode = 7'b0010011; funct3 = 3'b000; funct7 = 7'b0000000; Zero = 0;
        #10;

        // Test 4: Load instruction (LW)
        opcode = 7'b0000011; funct3 = 3'b010; funct7 = 7'b0000000; Zero = 0;
        #10;

        // Test 5: Store instruction (SW)
        opcode = 7'b0100011; funct3 = 3'b010; funct7 = 7'b0000000; Zero = 0;
        #10;

        // Test 6: Branch instruction (BEQ) with Zero=1
        opcode = 7'b1100011; funct3 = 3'b000; funct7 = 7'b0000000; Zero = 1;
        #10;
        
        // Test 7: Branch instruction (BEQ) with Zero=0
        opcode = 7'b1100011; funct3 = 3'b000; funct7 = 7'b0000000; Zero = 0;
        #10;

        $finish;
    end

endmodule
