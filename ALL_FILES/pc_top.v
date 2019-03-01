module pc_top #(parameter XLEN =32)
		(input clk,
		 input rst,
		output [XLEN-1:0] pc_out);

wire[XLEN-1:0] pc_in_w,pc_out_w;

pc #(.XLEN(XLEN)) program_counter(.clk(clk),
				  .rst(rst),
				  .pc_in(pc_in_w),
				  .pc_next(pc_out_w));

pc_add #(.XLEN(XLEN)) pc_adder(.pc_next(pc_out_w),
				 .pc_in(pc_in_w));

assign pc_out = pc_out_w;
endmodule
