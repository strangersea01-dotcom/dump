module fetch_cycle(input clk,
		   input rst,
		   input[31:0] inst_in,
		   output reg[31:0] inst_out);
		   
	always@(posedge clk or posedge rst)
		begin
			if(rst)
				begin
				inst_out <= 32'b0;
				end
			else
				begin
				inst_out <= inst_in;
				end
		end
		       
endmodule
 
