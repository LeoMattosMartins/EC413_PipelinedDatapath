`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 02:16:13 PM
// Design Name: 
// Module Name: pipeline
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

/* top of the hierarchical design */
module pipeline(
        input [31:0] InstrIn,
        input clk,
        input rst,
        output [31:0] out
    );
    
    wire [4:0] S1_ReadSelect1;
    wire [4:0] S1_ReadSelect2;
    wire [15:0] S1_Immediate;
    wire S1_DataSource;
    wire [2:0] S1_ALUop;
    wire [4:0] S1_WriteSelect;
    wire S1_WriteEnable;
    wire [31:0] RF_ReadData1;
    wire [31:0] RF_ReadData2;
        
    wire [31:0] S2_ReadData1;    
    wire [31:0] S2_ReadData2;
    wire [15:0] S2_Immediate;
    wire S1_DataSource;
    wire [2:0] S2_ALUop;
    wire [4:0] S2_WriteSelect;
    wire S2_WriteEnable;

    wire [31:0] S3_WriteData;
    wire [4:0] S3_WriteSelect;
    wire S3_WriteEnable;
    
    wire [31:0] ALUout;
    wire [31:0] R2;
    wire [31:0] R3;
    
    assign out = S3_WriteData;
    
    assign R3 = (InstrIn[29]) ? (S2_Immediate) : (S2_ReadData2); /*MUX for ALU input R3 */
    
    S1_Register s1 (.clk(clk), /* S1 --> RF */
                    .rst(rst), 
                    .InstrIn(InstrIn),
                    .S1_ReadSelect1(S1_ReadSelect1),
                    .S1_ReadSelect2(S1_ReadSelect2),
                    .S1_Immediate(S1_Immediate),
                    .S1_DataSource(S1_DataSource),
                    .S1_ALUop(S1_ALUop),
                    .S1_WriteSelect(S1_WriteSelect),
                    .S1_WriteEnable(S1_WriteEnable)
                    );
                    
    register_file rf (.clk(clk), /* S1 + S3 --> RF */
                      .S1_ReadSelect1(S1_ReadSelect1),
                      .S1_ReadSelect2(S1_ReadSelect2),
                      .S3_WriteData(S3_WriteData),
                      .S3_WriteSelect(S3_WriteSelect),
                      .S3_WriteEnable(S3_WriteEnable),
                      .RF_ReadData1(RF_ReadData1),
                      .RF_ReadData2(RF_ReadData2)
                      );
    
    nbit_ALU #(32) alu  (.R2(S2_ReadData1), /* S2 --> ALU */
                         .R3(R3),
                         .ALUOp(S2_ALUop),
                         .R1(ALUout)
                         );
                      
    S2_Register s2 (.clk(clk), /* S1 --> S3 */
                    .rst(rst), 
                    .RF_ReadData1(RF_ReadData1),
                    .RF_ReadData2(RF_ReadData2),
                    .S1_Immediate(S1_Immediate),
                    .S1_DataSource(S1_DataSource),
                    .S1_ALUop(S1_ALUop),
                    .S1_WriteSelect(S1_WriteSelect),
                    .S1_WriteEnable(S1_WriteEnable),
                    .S2_ReadData1(S2_ReadData1),
                    .S2_ReadData2(S2_ReadData2),
                    .S2_Immediate(S2_Immediate),
                    .S2_DataSource(S2_DataSource),
                    .S2_ALUop(S2_ALUop),
                    .S2_WriteSelect(S2_WriteSelect),
                    .S2_WriteEnable(S2_WriteEnable)
                    );
    
    S3_Register s3 (.clk(clk), /*ALU --> S3 */
                    .rst(rst),
                    .ALUout(ALUout),
                    .S2_WriteSelect(S2_WriteSelect),
                    .S2_WriteEnable(S2_WriteEnable),
                    .S3_WriteData(S3_WriteData),
                    .S3_WriteSelect(S3_WriteSelect),
                    .S3_WriteEnable(S3_WriteEnable)
                    );
endmodule
