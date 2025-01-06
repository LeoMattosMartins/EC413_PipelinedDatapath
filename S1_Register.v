`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 01:10:38 PM
// Design Name: 
// Module Name: S1_Register
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


module S1_Register(
        input clk,
        input rst,
        input [31:0] InstrIn,
        output reg [4:0] S1_ReadSelect1,
        output reg [4:0] S1_ReadSelect2,
        output reg [15:0] S1_Immediate,
        output reg S1_DataSource,
        output reg [2:0] S1_ALUop,
        output reg [4:0] S1_WriteSelect,
        output reg S1_WriteEnable    
    );
    
    always @(posedge clk)
    begin
        if (rst) /* If the rst is enabled, this register file is wiperd */
        begin
            S1_ReadSelect1 <= 5'd0;
            S1_ReadSelect2 <= 5'd0;
            S1_Immediate   <= 5'd0;
            S1_DataSource  <= 1'b0;
            S1_ALUop       <= 3'd0;
            S1_WriteSelect <= 5'd0;
            S1_WriteEnable <= 1'b0;
        end
        else
        begin /* decode the instruction in InstrIn */
            S1_ReadSelect1 <= InstrIn[20:16];
            S1_ReadSelect2 <= InstrIn[15:11];
            S1_Immediate   <= InstrIn[15:0];
            S1_DataSource  <= InstrIn[29];
            S1_ALUop       <= InstrIn[28:26];
            S1_WriteSelect <= InstrIn[25:21];
            S1_WriteEnable <= 1'b1;            
        end
    end
    
endmodule
