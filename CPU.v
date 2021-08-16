`timescale 1ns / 1ps


module CPU
(
output [3:0] data_out,
output [5:0] address,
output RW,
input [3:0] data_in,
input clk
);

  //Instruction Set
  //00 - ADD
  //01 - ADDMEM
  //02 - SUB
  //O3 - SUBMEM
  //04 - MUL
  //05 - MULMEM
  //06 - DIV
  //07 - DIVMEM
  
integer flag;
integer do_this_flag;
integer mem_operand_flag;
reg [3:0] ALU_out, ALU_A, ALU_B;
reg [1:0] ALU_Sel;
reg [5:0] addr;
reg RW_reg;

assign address = addr;
assign RW = RW_reg;

ALU A1(ALU_out, ALU_Sel, ALU_A, ALU_B, clk);

initial
  begin
    flag = 0;
    addr = 0;
    RW_reg = 0;
  end

always @ (posedge clk)
  begin
    
    if(flag == 0)
    begin
      flag = 1;
      case(addr)
        4'b0000 : begin
                    do_this_flag = 0;
                  end
        4'b0001 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                  end
        4'b0010 : begin
                    do_this_flag = 0;
                  end
        4'b0011 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                  end
        4'b0100 : begin
                    do_this_flag = 0;
                  end
        4'b0101 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                  end
        4'b0110 : begin
                    do_this_flag = 0;
                  end
        4'b0111 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                  end
      endcase
      addr = addr + 1;
    end
    
    if(flag == 1)
    begin
      flag = 2;
      if()
      begin
      
      end
      addr = addr + 1;
    end
    
    if(flag == 2)
    begin
      flag = 0;
      if()
      begin
      
      end
      addr = addr + 1;
    end
    
  end

endmodule
