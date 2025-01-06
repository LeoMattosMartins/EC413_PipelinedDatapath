`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 01:10:38 PM
// Design Name: 
// Module Name: nbit_ALU
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

/*
  ALUOp   Output
  3'b000  MOV
  3'b001  NOT
  3'b010  ADD
  3'b011  SUB
  3'b100  OR
  3'b101  AND
  3'b110  SLT (signed)
*/

module nbit_ALU # (
  parameter WIDTH = 32 /* these parameters go unused, but are a remnant from the Lab4 implementation */
)(
  input signed [WIDTH-1:0] R2,
  input signed [WIDTH-1:0] R3,
  input [2:0] ALUOp,

  output reg [WIDTH-1:0] R1
);

always @(*)begin
  case(ALUOp)
    3'b000: R1 = R2;
    3'b001: R1 = ~R2;
    3'b010: R1 = R2 + R3;
    3'b011: R1 = R2 - R3;
    3'b100: R1 = R2 | R3;
    3'b101: R1 = R2 & R3;
    3'b110: R1 = R2 > R3; 
  endcase
end

endmodule
