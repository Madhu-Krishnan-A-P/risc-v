`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 00:20:26
// Design Name: 
// Module Name: datamem
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


module DataMemory #(
    parameter ADDR_WIDTH = 8,  // Address width
    parameter DATA_WIDTH = 16 // Data width
) (
    input  logic                  clk,        // Clock signal
    input  logic                  WE,         // Write Enable
    input  logic [ADDR_WIDTH-1:0] A,          // Address bus
    input  logic [DATA_WIDTH-1:0] WD,         // Write Data bus
    output logic [DATA_WIDTH-1:0] RD          // Read Data bus
);
    // Define the memory array
    logic [DATA_WIDTH-1:0] mem [0:(1 << ADDR_WIDTH)-1]; // Memory array

    // Write operation: Synchronous
    always_ff @(posedge clk) begin
        if (WE) begin
            mem[A] <= WD;  // Write data to address A
        end
    end

    // Read operation: Asynchronous
    always_comb begin
        if (!WE) begin
            RD = mem[A];   // Read data from address A
        end
        
        else begin
            RD = 'z;       // High impedance when writing
        end
    end
endmodule
