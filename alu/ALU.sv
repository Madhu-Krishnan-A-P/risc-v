`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:25:47
// Design Name: 
// Module Name: ALU
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


module ALU (
    input  reg [31:0] A,            // Operand A
    input  reg [31:0] B,            // Operand B
    input  reg [2:0] ALUControl,    // ALU control signals (2:0)
    output reg [31:0] Result,       // ALU result
    output reg Zero                 // Zero flag (Result == 0)
);

    always @(A, B, ALUControl) begin
    // Perform ALU operations based on ALUControl
    if (ALUControl == 3'b000) begin
        Result = A + B;  // Add
    end else if (ALUControl == 3'b001) begin
        Result = A - B;  // Subtract
    end else if (ALUControl == 3'b010) begin
        Result = A & B;  // AND
    end else if (ALUControl == 3'b011) begin
        Result = A | B;  // OR
    end else if (ALUControl == 3'b101) begin
        Result = (A < B) ? 1 : 0;  // Set Less Than (SLT)
    end else begin
        Result = 32'b0;  // Default case to handle undefined operations
    end

    // Zero flag is set if the result is zero
    Zero = (Result == 0);
end

endmodule
