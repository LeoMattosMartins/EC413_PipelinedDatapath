`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 03:03:03 PM
// Design Name: 
// Module Name: pipeline_tb
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


module pipeline_tb;

    // Inputs
	reg [31:0] InstrIn;
	reg Reset;
	reg Clk;

	// Outputs
	wire [31:0] ALUOut;
//	wire			DataSrc;
	
	// Instantiate the Unit Under Test (UUT)
	pipeline uut (
		.InstrIn(InstrIn), 
		.rst(Reset), 
		.clk(Clk), 
		.out(ALUOut)
	);

	always #5
	Clk = ~Clk;

	initial begin
		// Initialize Inputs
		InstrIn = 0;
		Reset = 1;
		Clk = 0;
 

		// Wait 100 ns for global reset to finish
		#10;
      
		Reset = 0;
		
		
//		---- I type ---
		#30
		InstrIn= 32'b011010_00000_00000_0000000000000101;		// I, add r0 with 00000005               =>  r0 = 00000005

		#10
		InstrIn= 32'b011010_00001_00001_0000000000001010;		// I, add r1 with 0000000A               =>  r1 = 0000000A

		#10
		InstrIn= 32'b011010_00010_00010_1111111111111000;		// I, add r2 with 0000FFF8               =>  r2 = 0000FFF8

		#10
		InstrIn= 32'b011001_00011_00011_1111111111111000;		// I, not r3     		                 =>  r3 = FFFFFFFF
		
		#10
		InstrIn= 32'b011100_00100_00100_1010101010101010;		// I, or r4 with 0000AAAA                =>  r4 = 00000AAAA
		
		#10
		InstrIn= 32'b011101_00101_00101_1111111111111111;		// I, and r5 with 0000FFFF               =>  r5 = 00000000
		
		#10
		InstrIn= 32'b011110_00110_00110_1111111111111000;		// I, slt r6 with 0000FFFF8              =>  r6 = 00000001

//		---- R type ---
		#10
		InstrIn= 32'b010001_00111_00001_00000_00000000000;		// R, not r1(0000000A)                   =>  r7 = FFFFFFF5

		#10
		InstrIn= 32'b010010_01000_00001_00010_00000000000;		// R, add r1(0000000A) with r2(0000FFF8) =>  r8 = 00010002
		
		#10
		InstrIn= 32'b010010_01001_00001_00011_00000000000;		// R, add r1(0000000A) with r3(FFFFFFFF) =>  r9 = 00000009
		
		#10
		InstrIn= 32'b010010_01010_00001_00100_00000000000;		// R, add r1(0000000A) with r4(0000AAAA) =>  r10 = 0000AAB4
		
		#10
		InstrIn= 32'b010010_01011_00001_00101_00000000000;		// R, add r1(0000000A) with r5(00000000) =>  r11 = 0000000A  
		
		#10
		InstrIn= 32'b010010_01100_00001_00110_00000000000;		// R, add r1(0000000A) wtih r6(00000001) =>  r12 = 0000000B  
				
		
		// Add stimulus here

	end
      
endmodule