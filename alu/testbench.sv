`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:26:17
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


module ALU_tb;

    // Testbench signals
    reg [31:0] A, B;            // Operand A and Operand B
    reg [2:0] ALUControl;       // ALU control signals
    reg [31:0] Result;          // ALU result
    reg Zero;                   // Zero flag

    // Instantiate the ALU module
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Zero(Zero)
    );

    // Test stimulus
    initial begin
        // Initialize signals to known values
        A = 32'b0;
        B = 32'b0;
        ALUControl = 3'b000;

        // Apply random test cases
        for (int j = 0; j <= 3; j = j + 1) begin
        for (int i = 0; i < 5; i = i + 1) begin
            // Generate random values for A and B
            A = $urandom;  // Random 32-bit operand A
            B = $urandom;  // Random 32-bit operand B
            ALUControl = j;
            #10;
        end
        end
        
        for (int i = 0; i < 5; i = i + 1) begin
            // Generate random values for A and B
            A = $urandom;  // Random 32-bit operand A
            B = $urandom;  // Random 32-bit operand B
            ALUControl = 3'b101;
            #10;
        end

        // End simulation
        $finish;
    end

endmodule


