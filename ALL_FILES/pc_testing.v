module pc_top(clk, rst, pc_out);
  input clk, rst;
  output [31:0] pc_out;
  wire clk, rst;
  wire [31:0] pc_out;
  wire [31:0] pc_in_w;
  wire [31:0] pc_out_w;
  wire UNCONNECTED38;
  assign pc_out[0] = 1'b0;
  assign pc_out[1] = 1'b0;
  assign pc_out[10] = 1'b0;
  assign pc_out[11] = 1'b0;
  assign pc_out[12] = 1'b0;
  assign pc_out[13] = 1'b0;
  assign pc_out[14] = 1'b0;
  assign pc_out[15] = 1'b0;
  assign pc_out[16] = 1'b0;
  assign pc_out[17] = 1'b0;
  assign pc_out[18] = 1'b0;
  assign pc_out[19] = 1'b0;
  assign pc_out[20] = 1'b0;
  assign pc_out[21] = 1'b0;
  assign pc_out[22] = 1'b0;
  assign pc_out[23] = 1'b0;
  assign pc_out[24] = 1'b0;
  assign pc_out[25] = 1'b0;
  assign pc_out[26] = 1'b0;
  assign pc_out[27] = 1'b0;
  assign pc_out[28] = 1'b0;
  assign pc_out[29] = 1'b0;
  assign pc_out[30] = 1'b0;
  assign pc_out[31] = 1'b0;
  pc_add_XLEN32 pc_adder(.pc_next ({22'b0000000000000000000000,
       pc_out[9:2], 2'b00}), .pc_in ({pc_in_w[31:3], UNCONNECTED38,
       pc_in_w[1:0]}));
  pc_XLEN32 program_counter(.clk (clk), .rst (rst), .pc_in
       ({22'b0000000000000000000000, pc_in_w[9:3], 3'b000}), .pc_next
       ({pc_out_w[31:10], pc_out[9:2], pc_out_w[1:0]}));
endmodule
module pc_add_XLEN32(pc_next, pc_in);
  input [31:0] pc_next;
  output [31:0] pc_in;
  wire [31:0] pc_next;
  wire [31:0] pc_in;
  wire n_77, n_243, n_251, n_519, n_524, n_525, n_532, n_533;
  wire n_534, n_535, n_536, n_537, n_538, n_539, n_540, n_541;
  wire n_542, n_543, n_544, n_545, n_546, n_547, n_548;
  assign pc_in[0] = 1'b0;
  assign pc_in[1] = 1'b0;
  assign pc_in[2] = 1'b0;
  assign pc_in[10] = 1'b0;
  assign pc_in[11] = 1'b0;
  assign pc_in[12] = 1'b0;
  assign pc_in[13] = 1'b0;
  assign pc_in[14] = 1'b0;
  assign pc_in[15] = 1'b0;
  assign pc_in[16] = 1'b0;
  assign pc_in[17] = 1'b0;
  assign pc_in[18] = 1'b0;
  assign pc_in[19] = 1'b0;
  assign pc_in[20] = 1'b0;
  assign pc_in[21] = 1'b0;
  assign pc_in[22] = 1'b0;
  assign pc_in[23] = 1'b0;
  assign pc_in[24] = 1'b0;
  assign pc_in[25] = 1'b0;
  assign pc_in[26] = 1'b0;
  assign pc_in[27] = 1'b0;
  assign pc_in[28] = 1'b0;
  assign pc_in[29] = 1'b0;
  assign pc_in[30] = 1'b0;
  assign pc_in[31] = 1'b0;
  or g582 (n_243, n_519, wc31545);
  not gc31545 (wc31545, pc_next[5]);
  or g603 (n_524, n_251, wc31546);
  not gc31546 (wc31546, pc_next[8]);
  or g606 (n_525, n_243, wc31547);
  not gc31547 (wc31547, pc_next[6]);
  nand g613 (n_535, n_524, pc_next[9]);
  or g614 (n_536, n_524, pc_next[9]);
  nand g615 (pc_in[9], n_535, n_536);
  nand g616 (n_537, n_525, pc_next[7]);
  or g617 (n_538, n_525, pc_next[7]);
  nand g618 (pc_in[7], n_537, n_538);
  nand g619 (n_539, n_243, pc_next[6]);
  or g620 (n_540, n_243, pc_next[6]);
  nand g621 (pc_in[6], n_539, n_540);
  nand g622 (n_541, n_251, pc_next[8]);
  or g623 (n_542, n_251, pc_next[8]);
  nand g624 (pc_in[8], n_541, n_542);
  or g625 (n_251, n_77, n_534);
  nand g626 (n_543, n_519, pc_next[5]);
  or g627 (n_544, n_519, pc_next[5]);
  nand g628 (pc_in[5], n_543, n_544);
  or g629 (n_545, n_77, pc_next[4]);
  nand g630 (n_546, n_77, pc_next[4]);
  nand g631 (pc_in[4], n_545, n_546);
  or g632 (n_519, n_77, wc31548);
  not gc31548 (wc31548, pc_next[4]);
  or g633 (n_534, n_532, n_533);
  nand g634 (n_532, pc_next[7], pc_next[6]);
  nand g635 (n_533, pc_next[5], pc_next[4]);
  or g636 (n_547, wc31549, pc_next[2]);
  not gc31549 (wc31549, pc_next[3]);
  or g637 (n_548, pc_next[3], wc31550);
  not gc31550 (wc31550, pc_next[2]);
  nand g638 (pc_in[3], n_547, n_548);
  nand g639 (n_77, pc_next[3], pc_next[2]);
endmodule

module pc_XLEN32(clk, rst, pc_in, pc_next);
  input clk, rst;
  input [31:0] pc_in;
  output [31:0] pc_next;
  wire clk, rst;
  wire [31:0] pc_in;
  wire [31:0] pc_next;
  wire n_36;
  assign pc_next[0] = 1'b0;
  assign pc_next[1] = 1'b0;
  assign pc_next[10] = 1'b0;
  assign pc_next[11] = 1'b0;
  assign pc_next[12] = 1'b0;
  assign pc_next[13] = 1'b0;
  assign pc_next[14] = 1'b0;
  assign pc_next[15] = 1'b0;
  assign pc_next[16] = 1'b0;
  assign pc_next[17] = 1'b0;
  assign pc_next[18] = 1'b0;
  assign pc_next[19] = 1'b0;
  assign pc_next[20] = 1'b0;
  assign pc_next[21] = 1'b0;
  assign pc_next[22] = 1'b0;
  assign pc_next[23] = 1'b0;
  assign pc_next[24] = 1'b0;
  assign pc_next[25] = 1'b0;
  assign pc_next[26] = 1'b0;
  assign pc_next[27] = 1'b0;
  assign pc_next[28] = 1'b0;
  assign pc_next[29] = 1'b0;
  assign pc_next[30] = 1'b0;
  assign pc_next[31] = 1'b0;
  not g3 (n_36, pc_next[2]);
  CDN_flop \pc_next_reg[2] (.clk (clk), .d (n_36), .sena (1'b1), .aclr
       (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q (pc_next[2]));
  CDN_flop \pc_next_reg[3] (.clk (clk), .d (pc_in[3]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[3]));
  CDN_flop \pc_next_reg[4] (.clk (clk), .d (pc_in[4]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[4]));
  CDN_flop \pc_next_reg[5] (.clk (clk), .d (pc_in[5]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[5]));
  CDN_flop \pc_next_reg[6] (.clk (clk), .d (pc_in[6]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[6]));
  CDN_flop \pc_next_reg[7] (.clk (clk), .d (pc_in[7]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[7]));
  CDN_flop \pc_next_reg[8] (.clk (clk), .d (pc_in[8]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[8]));
  CDN_flop \pc_next_reg[9] (.clk (clk), .d (pc_in[9]), .sena (1'b1),
       .aclr (rst), .apre (1'b0), .srl (1'b0), .srd (1'b0), .q
       (pc_next[9]));
endmodule
module CDN_flop(clk, d, sena, aclr, apre, srl, srd, q);
  input clk, d, sena, aclr, apre, srl, srd;
  output q;
  wire clk, d, sena, aclr, apre, srl, srd;
  wire q;
  reg  qi;
  assign #1 q = qi;
  always 
    @(posedge clk or posedge apre or posedge aclr) 
      if (aclr) 
        qi <= 0;
      else if (apre) 
          qi <= 1;
        else if (srl) 
            qi <= srd;
          else begin
            if (sena) 
              qi <= d;
          end
  initial 
    qi <= 1'b0;
endmodule

