`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2021 04:35:18 PM
// Design Name: 
// Module Name: testbench_ALU
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


module testbench_ALU;
     reg [1:0] Sel;
     reg [3:0] A, B;
     reg clk;
     wire [15:0] out;
     wire cout;
  integer i;
  MUX_2_to_1 DUT(.A(A),.B(B),.Sel(Sel),.out(out), .cout(cout), .clk(clk));
  
  initial 
  begin

    #2 clk<=0;
    Sel<=2'b00;
    A<=0; B<=0;

  end

  always
  begin
    #5 clk = ~clk;
  end

  initial 
  begin

    #20 A = 4'd1; B = 4'd2; Sel = 2'b00;
    $display("A = %d, B = %d, Sel = %d, out = %d, cout = %d\n", A, B, Sel, out, cout);

    #20 A = 4'd3; B = 4'd4; Sel = 2'b01;
    $display("A = %d, B = %d, Sel = %d, out = %d, cout = %d\n", A, B, Sel, out, cout);

    #20 A = 4'd6; B = 4'd5; Sel = 2'b10;
    $display("A = %d, B = %d, Sel = %d, out = %d, cout = %d\n", A, B, Sel, out, cout);

    #20 A = 4'd8; B = 4'd7; Sel = 2'b11;
    $display("A = %d, B = %d, Sel = %d, out = %d, cout = %d\n", A, B, Sel, out, cout);

    #20 A = 4'd9; B = 4'd10; Sel = 2'b11;
    $display("A = %d, B = %d, Sel = %d, out = %d, cout = %d\n", A, B, Sel, out, cout);

  $finish;
 
 end
    
    
endmodule
