`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2024 12:43:10
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


module RegisterFile_tb;

    // Testbench signals
    logic clk;
    logic WE3;
    logic [4:0] A1, A2, A3;
    logic [31:0] WD3;
    logic [31:0] RD1, RD2;

    // Instantiate the RegisterFile module
    RegisterFile dut (
        .clk(clk),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10 time unit clock period

    // Test procedure
    initial begin
        // Initialize inputs
        WE3 = 0;
        A1 = 0;
        A2 = 0;
        A3 = 0;
        WD3 = 0;

        // Write data into 5 specific registers (1 to 5)
        for (int i = 1; i <= 5; i++) begin
            @(posedge clk);
            WE3 = 1;
            A3 = i;             // Target register address
            WD3 = i * 32'h1111; // Example data: multiples of 0x1111
        end
        @(posedge clk);
        WE3 = 0;

        // Read back the data using both read ports
        for (int i = 1; i <= 5; i++) begin
            @(posedge clk);
            A1 = i; // Address for read port 1
            A2 = i; // Address for read port 2
            @(posedge clk);
        end

        $finish;
    end

endmodule