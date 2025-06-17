`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2024 18:38:09
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


module tb_instru_file;

    // Testbench signals
    logic [31:0] A;         // 32-bit instruction address input
    logic [31:0] read_data; // 32-bit read data output
    logic clk;              // Clock signal
    logic reset;            // Reset signal

    // Instantiate the unit under test (UUT)
    instru_file uut (
        .A(A),
        .read_data(read_data),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units (100 MHz clock)
    end

    // Stimulus process
    initial begin
        // Initialize signals
        clk = 1;
        reset = 0;
        A = 32'h0;

        // Apply reset
        reset = 1;
        #10 reset = 0; // Deassert reset after 10 time units

        // Test 1: Access memory at address 0
        A = 32'h0;
        #10;

        // Test 2: Access memory at address 4 (aligned address, i.e., A[31:2] = 0)
        A = 32'h4;
        #10;

        // Test 3: Access memory at address 8 (another aligned address)
        A = 32'h8;
        #10;

        // Test 4: Access memory at address 255 (last location)
        A = 32'h03FC; // 32-bit address for memory[255]
        #10;

        // Test 5: Access an invalid address (out of bounds)
        A = 32'h1000; // Invalid address (out of range)
        #10;

        // End simulation
        $finish;
    end

endmodule
