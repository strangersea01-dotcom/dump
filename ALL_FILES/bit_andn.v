module bit_andn#(parameter XLEN =32)
		(input [XLEN-1:0] rs1,
		 input [XLEN-1:0] rs2,
		 output[XLEN-1:0] andn_result);
		assign andn_result =( rs1 & (~rs2));
endmodule
