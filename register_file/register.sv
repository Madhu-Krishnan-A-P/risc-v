`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2024 12:40:09
// Design Name: 
// Module Name: register
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


module RegisterFile (
    input logic clk,
    input logic WE3,
    input logic [4:0] A1, A2, A3,
    input logic [31:0] WD3,
    output logic [31:0] RD1, RD2
);

    // Define a 32x32 register file
    logic [31:0] regfile [31:0];

    // Initialize register x0 to always be 0
    initial begin
        regfile[0] = 32'b0;
    end

    // Read operations (combinational logic)
    assign RD1 = regfile[A1];
    assign RD2 = regfile[A2];

    // Write operation (sequential logic)
    always_ff @(posedge clk) begin
        if (WE3 && A3 != 5'b0) begin
            regfile[A3] <= WD3; // Write data to register A3
        end
    end

endmodule
