`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 01:10:38 PM
// Design Name: 
// Module Name: S3_Register
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

/* take from ALU, output from S3 */
module S3_Register(
        input clk,
        input rst,
        input [31:0] ALUout,
        input [4:0] S2_WriteSelect,
        input S2_WriteEnable,
        output reg [31:0] S3_WriteData,
        output reg [4:0] S3_WriteSelect,
        output reg S3_WriteEnable
    );
    
    always @(posedge clk)
    begin
        if (rst) /* is rst is on, everythig is reset */
        begin
            S3_WriteData   <= 31'd0;
            S3_WriteSelect <= 5'd0;
            S3_WriteEnable <= 1'b0;
        end
        else
        begin
            S3_WriteData   <= ALUout;
            S3_WriteSelect <= S2_WriteSelect;
            S3_WriteEnable <= S2_WriteEnable;        
        end
    end

endmodule
