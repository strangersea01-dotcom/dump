module im_mem0#(parameter XLEN = 8)
	
		(input [XLEN-1:0] pc_addr,
		 input clk,
		 input rst,
		 input [XLEN-1:0] write_data,
		 output[XLEN-1:0] byte_0_out);


//integer i ;
reg[7:0] mem [0:255];

	always@(posedge clk or posedge rst )
		begin
			if(rst)
				begin
			//	for(i = 0 ; i < 256 ; i = i + 1)
				 mem[pc_addr] <= 8'b0;
				end
			else 
				begin
				mem[pc_addr] <= write_data;
				end
		end	

	assign byte_0_out = mem[pc_addr];
	
	initial begin
		$readmemh("../MEMORY/byte_0.hex",mem);
	end
endmodule




