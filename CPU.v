`timescale 1ns / 1ps
`include "ALU.v"

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
reg [3:0] ALU_A, ALU_B;
wire [3:0] ALU_out;
reg [1:0] ALU_Sel;
reg ALU_clk;
reg [5:0] addr, addr_bkp;
reg RW_reg;
reg [3:0] OP1, OP2;
reg [5:0] OP1_addr, OP2_addr;
reg [3:0] inter1, inter2, inter3;

assign address = addr;
assign RW = RW_reg;
assign data_out = ALU_out;

ALU A1(ALU_out, ALU_Sel, ALU_A, ALU_B, ALU_clk);

initial
  begin
    flag = 0;
    addr = 0;
    RW_reg = 0;
    ALU_clk = 0;
  end

always @ (posedge clk)
  begin
    
    //Getting Instruction From Memory
    if(flag == 0)
    begin
      flag = 1;
      RW_reg = 0;
      case(data_in)
        4'b0000 : begin
                    do_this_flag = 0;
                    ALU_Sel = 0;
                  end
        4'b0001 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                    ALU_Sel = 0;
                  end
        4'b0010 : begin
                    do_this_flag = 0;
                    ALU_Sel = 1;
                  end
        4'b0011 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                    ALU_Sel = 1;
                  end
        4'b0100 : begin
                    do_this_flag = 0;
                    ALU_Sel = 2;
                  end
        4'b0101 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                    ALU_Sel = 2;
                  end
        4'b0110 : begin
                    do_this_flag = 0;
                    ALU_Sel = 3;
                  end
        4'b0111 : begin
                    do_this_flag = 0;
                    mem_operand_flag = 1;
                    ALU_Sel = 3;
                  end
      endcase
      addr = addr + 1;
    end
    
    //Getting Operand 1 From Memory
    if(flag == 1)
    begin
      flag = 2;
      RW_reg = 0;
      if(mem_operand_flag == 1)
      begin
        inter1 = data_in;
        addr = addr + 1;
        inter2 = data_in;
        OP1_addr = {inter1, inter2[3],inter2[2]};
        addr_bkp = addr;
        addr = OP1_addr;
        OP1 = data_in;
        addr = addr_bkp;
      end
      else
      begin
        OP1 = data_in;
      end
      addr = addr + 1;
    end
    
    //Getting Operand 2 From Memory
    if(flag == 2)
    begin
      flag = 3;
      RW_reg = 0;
      if(mem_operand_flag == 1)
      begin
        inter3 = data_in;
        OP2_addr = {inter2[1], inter2[0], inter3};
        addr_bkp = addr;
        addr = OP2_addr;
        OP2 = data_in;
        addr = addr_bkp;
      end
      else
      begin
        OP2 = data_in;
      end
      addr = addr + 1;
    end
    
    //Sending to ALU (Execute Operation)
    if(flag == 3)
    begin
      RW_reg = 0;
      ALU_A = OP1;
      ALU_B = OP2;
      #2 ALU_clk = 1;
      #1 ALU_clk = 0;
      flag = 0;
      
      addr_bkp = addr;
      addr = 63;
      RW_reg = 1;
      #1 RW_reg = 0;
      addr = addr_bkp;
    end

  end

endmodule
