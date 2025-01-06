`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 01:10:38 PM
// Design Name: 
// Module Name: S2_Register
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

/* take from S1, output from S2 */
module S2_Register(
        input clk,
        input rst,
        input [31:0] RF_ReadData1,
        input [31:0] RF_ReadData2,
        input [15:0] S1_Immediate,
        input S1_DataSource,
        input [2:0] S1_ALUop,
        input [4:0] S1_WriteSelect,
        input S1_WriteEnable,
        output reg [31:0] S2_ReadData1,
        output reg [31:0] S2_ReadData2,
        output reg [15:0] S2_Immediate,
        output reg S2_DataSource,
        output reg [2:0] S2_ALUop,
        output reg [4:0] S2_WriteSelect,
        output reg S2_WriteEnable
    );
    
    always @(posedge clk)
    begin
        if (rst)
        begin /* if rst is on, everything is reset */ 
            S2_ReadData1   <= 31'd0;
            S2_ReadData2   <= 31'd0;
            S2_Immediate   <= 16'd0;
            S2_DataSource  <= 1'b0;
            S2_ALUop       <= 3'd0;
            S2_WriteSelect <= 5'd0;
            S2_WriteEnable <= 5'd0;
        end
        else
        begin    
            S2_ReadData1   <= RF_ReadData1;
            S2_ReadData2   <= RF_ReadData2;
            S2_Immediate   <= S1_Immediate;
            S2_DataSource  <= S1_DataSource;
            S2_ALUop       <= S1_ALUop;
            S2_WriteSelect <= S1_WriteSelect;
            S2_WriteEnable <= S1_WriteEnable;
        end
    end
endmodule
