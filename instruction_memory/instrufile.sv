`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2024 18:34:28
// Design Name: 
// Module Name: instrufile
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


module instru_file(
    input logic [31:0] A,         // 32-bit instruction address input
    output logic [31:0] read_data, // 32-bit read data output
    input logic clk,               // Clock signal
    input logic reset              // Reset signal
);

    // Memory declaration: 256 32-bit memory locations
    logic [31:0] memory [0:255];

    // Initialize memory with some values
    initial begin
        integer i;
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'h0;  // Initialize all memory locations to 0
        end
        memory[0] = 32'hDEADBEEF; //Example initialization
        memory[1] = 32'hDEAD0000;
        memory[2] = 32'hDEADBEEF;
        memory[3] = 32'h0000BEEF;
        memory[255] = 32'hBEEFBEEF;
    end

    // Read data logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            read_data <= 32'h0; // Reset read data to 0
        end
        
        else begin
            read_data <= memory[A[31:2]]; // Read data from memory (word-aligned address)
        end
    end

endmodule