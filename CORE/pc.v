module pc#(parameter XLEN = 32)
	   (input clk,
	    input rst,
	    input [XLEN-1:0] pc_in,
	    output reg [XLEN-1:0] pc_next);

always@(posedge clk or posedge rst)
	begin
	 	if(rst)
		begin
			pc_next <= 32'b0;
		end
		else
		begin
			pc_next <= pc_in;
		end
	end
endmodule

