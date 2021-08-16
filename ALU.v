`timescale 1ns / 1ps


module ALU
(
output [3:0] out,
input [1:0] Sel,
input [3:0] A, B,
input clk
);

reg ou;

assign out = ou;

always @ (posedge clk)
  begin
    case(Sel)
      2'b00 : ou = A + B;
      2'b01 : ou = A - B;
      2'b10 : ou = A * B;
      2'b11 : ou = A / B;
    endcase
  end
endmodule
