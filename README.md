# 🧠 RISC-V Core Components – RTL Modules in SystemVerilog

This repository contains individual modules forming the building blocks of a basic 32-bit single-cycle RISC-V processor. Each component is implemented in SystemVerilog and verified using simple testbenches.

---

## 📁 Modules

### 1. 🔁 Register File

A 32-element, 32-bit register file implementing registers `x0` to `x31`.  
- Register `x0` is hardwired to zero.  
- Two read ports (A1 and A2) output values on RD1 and RD2.  
- One write port (A3) writes `WD3` on the rising edge of `clk` if `WE3` is asserted.

**Ports:**
- `input  logic clk`
- `input  logic WE3`
- `input  logic [4:0] A1, A2, A3`
- `input  logic [31:0] WD3`
- `output logic [31:0] RD1, RD2`

---

### 2. 📦 Instruction Memory

- 32-bit word-addressable instruction memory.  
- On each clock edge, read a word from address `A[31:2]` and output it on `read_data`.  
- Memory is initialized with example values for simulation.

**Ports:**
- `input  logic clk`
- `input  logic reset`
- `input  logic [31:0] A`
- `output logic [31:0] read_data`

---

### 3. 🧮 Arithmetic and Logic Unit (ALU)

Performs standard ALU operations based on the `ALUControl` input.

**Supported Operations:**

| ALUControl | Operation | Description                    |
|------------|-----------|--------------------------------|
| `000`      | ADD       | A + B                          |
| `001`      | SUB       | A - B                          |
| `010`      | AND       | Bitwise AND                    |
| `011`      | OR        | Bitwise OR                     |
| `101`      | SLT       | Set if A < B (signed compare)  |

**Ports:**
- `input  logic [31:0] A, B`
- `input  logic [2:0] ALUControl`
- `output logic [31:0] Result`
- `output logic Zero`

---

### 4. 🎯 Control Unit (Main Decoder + ALU Decoder)

Decodes a 32-bit instruction into control signals required for datapath operation.

**Functionality:**
- Extracts opcode, funct3, and funct7 fields.
- Generates control signals for register write, memory access, ALU source, branching, and result selection.
- ALU operation selection via 3-bit `ALUControl`.

**Key Outputs:**
- `RegWrite`, `ALUSrc`, `MemWrite`, `ResultSrc`, `Branch`, `PCSrc`
- `ImmSrc`, `ALUControl`

---

### 5. 💾 Data Memory

Synchronous 32-bit word-addressable memory with read and write capability.
- If `WE` is asserted, write `WD` to address `A` on the clock edge.
- If `WE` is de-asserted, outputs the word at address `A` on `RD`.

**Ports:**
- `input  logic clk`
- `input  logic WE`
- `input  logic [31:0] A, WD`
- `output logic [31:0] RD`

---

## ✅ Testbenches

Each module has an associated testbench to verify:
- Functional correctness
- Timing behaviour
- Proper initialization and signal response

Simulation is performed with `initial` blocks and proper `always` clock generation logic.

---

## 🧪 Simulation Environment

- Language: SystemVerilog
- Time Scale: `1ns / 1ps`
- Tool: Vivado, ModelSim, or any IEEE 1800-compliant simulator

---

## 👨‍💻 Author

**Madhu Krishnan A P**  
M.Tech in VLSI and Embedded Systems  
Cochin University of Science and Technology  
