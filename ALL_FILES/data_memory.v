module data_memory(
                   input [7:0] addr,
		   input clk,
		   input rst,
		   input [7:0] write_data,
                   output [7:0] dout
               );
	//	integer i ;
               reg[7:0] mem[0:255];

               initial begin
                   $readmemh("data_memory.hex",mem);
               end

			always@(posedge clk or posedge rst)
		begin
			if(rst)
				begin
			//	for(i = 0 ; i < 256 ; i = i + 1)
				 mem[addr] <= 8'b0;
				end
			else 
				begin
				mem[addr] <= write_data;
				end
		end	

               assign dout = mem[addr];
 endmodule
