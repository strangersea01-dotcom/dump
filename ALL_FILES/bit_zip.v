/*module bit_zip#(parameter XLEN = 32)
		(input [XLEN-1:0] rs1,
		 output [XLEN-1:0] zip_result);

	genvar i ;

	generate 
		for( i = 0 ; i <16; i = i +1)begin
			assign zip_result[2*i] = rs1[i];
			assign zip_result[2*i+1] = rs1[i +16];
		end
endgenerate


endmodule*/
module bit_zip#(parameter XLEN = 32)
		(input [XLEN-1:0] rs1,
		 output reg [XLEN-1:0] zip_result);

	integer i ;

	always@(rs1)
		begin

		for( i = 0 ; i <16; i = i +1)begin
			zip_result[2*i] = rs1[i];
			zip_result[2*i+1] = rs1[i +16];
		end
end
endmodule
