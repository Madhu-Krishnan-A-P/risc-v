`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 02:21:54
// Design Name: 
// Module Name: decodectrl
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


module ControlUnit (
    input  logic [6:0]  opcode,      // 7-bit opcode
    input  logic [2:0]  funct3,      // 3-bit funct3
    input  logic [6:0]  funct7,      // 7-bit funct7
    input  logic        Zero,        // ALU Zero signal
    output logic        Branch,      // Branch signal
    output logic        MemWrite,    // Memory write signal
    output logic        ALUSrc,      // ALU source selection
    output logic [1:0]  ImmSrc,      // Immediate source selection
    output logic        RegWrite,    // Register write enable
    output logic [1:0]  ResultSrc,   // Result source selection
    output logic [2:0]  ALUControl,  // ALU control signal
    output logic        PCSrc        // PC source for branching
);

    // Internal signal for ALUOp from Main Decoder to ALU Decoder
    logic [1:0] ALUOp;

    // Main Decoder
    always_comb begin
        // Default values
        Branch     = 0;
        MemWrite   = 0;
        ALUSrc     = 0;
        RegWrite   = 0;
        ImmSrc     = 2'b00;
        ResultSrc  = 2'b00;
        ALUOp      = 2'b00;

        case (opcode)
            7'b0110011: begin // R-type
                RegWrite  = 1;
                ALUOp     = 2'b10;
            end
            7'b0010011: begin // I-type (ALU Immediate)
                RegWrite  = 1;
                ALUSrc    = 1;
                ALUOp     = 2'b10;
            end
            7'b0000011: begin // Load
                RegWrite  = 1;
                ALUSrc    = 1;
                ResultSrc = 2'b01;
            end
            7'b0100011: begin // Store
                MemWrite  = 1;
                ALUSrc    = 1;
                ImmSrc    = 2'b01;
            end
            7'b1100011: begin // Branch
                Branch    = 1;
                ALUOp     = 2'b01;
                ImmSrc    = 2'b10;
            end
            default: ; // Default case does nothing
        endcase
    end

    // ALU Decoder
    always_comb begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // Default: Add (e.g., for load/store)
            2'b01: ALUControl = 3'b001; // Subtract (for branches)
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl = (funct7[5]) ? 3'b001 : 3'b000; // SUB if funct7[5]=1, ADD otherwise
                    3'b111: ALUControl = 3'b111; // AND
                    3'b110: ALUControl = 3'b110; // OR
                    3'b100: ALUControl = 3'b100; // XOR
                    3'b001: ALUControl = 3'b010; // SLL (Shift Left Logical)
                    3'b101: ALUControl = (funct7[5]) ? 3'b011 : 3'b101; // SRL/SRA
                    default: ALUControl = 3'b000; // Default to ADD
                endcase
            end
            default: ALUControl = 3'b000; // Default to ADD
        endcase
    end

    // PCSrc logic (Branch AND Zero)
    assign PCSrc = Branch & Zero;

endmodule