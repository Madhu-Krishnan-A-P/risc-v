🧮 ALU (Arithmetic Logic Unit)
The ALU module is a 32-bit Arithmetic Logic Unit designed to perform fundamental arithmetic and logic operations as part of a RISC-V processor datapath.

✅ Features
32-bit inputs A and B

3-bit ALUControl signal to select operation

Outputs:

Result: 32-bit output of the operation

Zero: flag indicating whether the result is zero

🔧 Supported Operations
ALUControl	Operation	Description
000	Addition	A + B
001	Subtraction	A - B
010	Bitwise AND	A & B
011	Bitwise OR	A | B
101	Set Less Than	Result = (A < B) ? 1 : 0
Others	Default	Result = 0

🧪 Testbench: ALU_tb
Generates randomized test cases for each supported operation.

Exercises the ALU using various control signals and operand combinations.

Validates:

Correct output generation
Functioning of the Zero flag
