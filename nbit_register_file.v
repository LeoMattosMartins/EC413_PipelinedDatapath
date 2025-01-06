`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 01:10:38 PM
// Design Name: 
// Module Name: nbit_register_file
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


module nbit_register_file(
        input clk,
        input regWrite,
        input [4:0] S1_ReadSelect1,
        input [4:0] S1_ReadSelect2,
        input [31:0] S3_WriteData,
        input [4:0] S3_WriteSelect,
        input S3_WriteEnable,
        output [31:0] RF_ReadData1,
        output [31:0] RF_ReadData2
);
    reg [31:0] register_file [31:0];
    
    integer ii;
    initial 
    begin
        for(ii = 0; ii < 32; ii = ii + 1)
        begin
            register_file[ii] = ii;
        end
    end
    
    assign RF_ReadData1 = register_file[S1_ReadSelect1];
    assign RF_ReadData2 = register_file[S1_ReadSelect2];
    
    always @(posedge clk)
    begin
        if( regWrite )
            register_file[S3_WriteSelect] <= S3_WriteData;
    end

endmodule
