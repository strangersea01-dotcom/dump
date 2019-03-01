


	module bit_rori #(parameter XLEN =32)
		(input [XLEN-1:0] rs1,
		 input [XLEN-1:0] imm,
		 output[XLEN-1:0] rori_result);

	bit_ror bit_rorim(.rs1(rs1),
			  .rs2(imm),
			  .ror_result(rori_result));

endmodule

/*	module bit_rori #(parameter XLEN =32)
		(input [XLEN-1:0] rs1,
		 input [XLEN-1:0] imm,
		 output[XLEN-1:0] result);

		parameter integer SHAMT = $clog2(XLEN);

		wire [SHAMT-1:0] shamt;

		assign shamt = imm[SHAMT-1:0];

	assign result = ((rs1 >> shamt) | (rs1 << ( XLEN-shamt)));
endmodule*/
