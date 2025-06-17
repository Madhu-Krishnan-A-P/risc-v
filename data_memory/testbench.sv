`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 00:22:51
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

module tb_DataMemory;

    // Parameters
    parameter ADDR_WIDTH = 8;   // Address width
    parameter DATA_WIDTH = 16;  // Data width

    // Signals
    logic clk;                             // Clock
    logic WE;                              // Write Enable
    logic [ADDR_WIDTH-1:0] A;              // Address bus
    logic [DATA_WIDTH-1:0] WD;             // Write Data bus
    logic [DATA_WIDTH-1:0] RD;             // Read Data bus

    // DUT Instance
    DataMemory #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) dut (
        .clk(clk),
        .WE(WE),
        .A(A),
        .WD(WD),
        .RD(RD)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk; // 10 ns clock period

    // Test Sequence
    initial begin
        // Initialize inputs
        WE = 0; 
        A  = 0; 
        WD = 0;

        // Apply reset values
        #10;

        // Test 1: Write and read from address 0
        write_memory(8'd0, 16'hAAAA);
        read_memory(8'd0);
        assert(RD == 16'hAAAA) else $fatal("Error: Address 0 read mismatch!");

        // Test 2: Write and read from address 1
        write_memory(8'd1, 16'hBBBB);
        read_memory(8'd1);
        assert(RD == 16'hBBBB) else $fatal("Error: Address 1 read mismatch!");

        // Test 3: Write and read from a different address
        write_memory(8'd2, 16'hCCCC);
        read_memory(8'd2);
        assert(RD == 16'hCCCC) else $fatal("Error: Address 2 read mismatch!");

        // Test completed
        #10;
        $finish; // End simulation
    end

    // Task: Write data to memory
    task write_memory(input logic [ADDR_WIDTH-1:0] address, input logic [DATA_WIDTH-1:0] data);
        @(posedge clk);
        WE = 1;
        A  = address;
        WD = data;
        @(posedge clk);
        WE = 0;
    endtask

    // Task: Read data from memory
    task read_memory(input logic [ADDR_WIDTH-1:0] address);
        @(posedge clk);
        WE = 0;
        A  = address;
        @(posedge clk);
    endtask

endmodule
