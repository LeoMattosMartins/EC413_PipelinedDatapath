`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 09:02:29 PM
// Design Name: 
// Module Name: register_file_tb
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


module register_file_tb;

// Register select line size (number of registers is 2 to the power of this number).
parameter REG_SELECT_WIDTH = 5;
// Register size in bits.
parameter DATA_WIDTH = 32;

//-------------Input Ports-----------------------------
reg [DATA_WIDTH-1:0]       WriteData;
reg [REG_SELECT_WIDTH-1:0] ReadSelect1;
reg [REG_SELECT_WIDTH-1:0] ReadSelect2;
reg [REG_SELECT_WIDTH-1:0] WriteSelect;
reg WriteEnable;
reg Reset;
reg Clk;
//-------------Output Ports----------------------------
wire [DATA_WIDTH-1:0] ReadData1;
wire [DATA_WIDTH-1:0] ReadData2;
//-------------Wires-----------------------------------
//-------------Other-----------------------------------
//------------Code Starts Here-------------------------

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
        .clk(Clk),
        .S1_ReadSelect1(ReadSelect1),
        .S1_ReadSelect2(ReadSelect2),
        .S3_WriteData(WriteData),
        .S3_WriteSelect(WriteSelect),
        .S3_WriteEnable(WriteEnable),
        .RF_ReadData1(ReadData1),
        .RF_ReadData2(ReadData2)
	);
 
	// Test vectors
	always begin

		
		// Initial Reset, should only occur on rising edge
		     WriteData= 32'h00000000; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 1; Clk= 0;
		#20  WriteData= 32'h00000000; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 1; Clk= 1;
		
		// Write a value into register 0
		#20  WriteData= 32'hDEADBEEF; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 1; Reset= 0; Clk= 0;
		#20  WriteData= 32'hDEADBEEF; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 1; Reset= 0; Clk= 1;
		
		// Write a value into register 0
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 0;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 1;
		
		// Try a different read select and see that contents are 0
		#20  WriteData= 32'hBADF000D; ReadSelect1= 5; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 0;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 5; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 1;
		
		// Set a value into register 0 but do not assert WriteEnable, should not write
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 0;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 1;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 0;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 1;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 0;
		#20  WriteData= 32'hBADF000D; ReadSelect1= 0; ReadSelect2= 1; WriteSelect= 0; WriteEnable= 0; Reset= 0; Clk= 1;		
		#20  $finish;      // Terminate simulation
	end
      
endmodule
