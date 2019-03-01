/*module bit_unzip #(parameter XLEN = 32)
		(input [XLEN-1:0] rs1,
		 output [XLEN-1:0] unzip_result);

	genvar i ;

	generate 
		for( i = 0 ; i <16; i = i +1)begin
			assign unzip_result[i] = rs1[2*i];
			assign unzip_result[i+16] = rs1[2*i+1];
		end
endgenerate


endmodule*/

module bit_unzip #(parameter XLEN = 32)
		(input [XLEN-1:0] rs1,
		 output reg [XLEN-1:0] unzip_result);

	integer i ;

	always@(rs1)
		begin 
		for( i = 0 ; i <16; i = i +1)begin
			 unzip_result[i] = rs1[2*i];
			 unzip_result[i+16] = rs1[2*i+1];
		end
		end
endmodule
