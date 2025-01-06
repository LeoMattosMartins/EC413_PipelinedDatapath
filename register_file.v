`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 02:22:12 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
        input clk,
        input [4:0] S1_ReadSelect1,
        input [4:0] S1_ReadSelect2,
        input [31:0] S3_WriteData,
        input [4:0] S3_WriteSelect,
        input S3_WriteEnable,
        output [31:0] RF_ReadData1,
        output [31:0] RF_ReadData2
);
    reg [31:0] register [31:0];
    
    integer ii;
    initial /* setting all the registers to 0 at the beginning */
    begin
        for(ii = 0; ii < 32; ii = ii + 1)
        begin
            register[ii] = 0;
        end
    end
    
    assign RF_ReadData1 = register[S1_ReadSelect1];
    assign RF_ReadData2 = register[S1_ReadSelect2];
    
    always @(posedge clk)
    begin /* WriteEnable is hardwired to 1, so there is no need to check for it */
            register[S3_WriteSelect] <= S3_WriteData;
    end

endmodule
