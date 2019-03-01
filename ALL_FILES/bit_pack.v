module bit_pack #(parameter XLEN =32)
                (input [XLEN-1:0] rs1,
                 input [XLEN-1:0] rs2,
                 output[XLEN-1:0] pack_result);

	assign	pack_result = {(rs2[31:16]),(rs1[15:0])};
endmodule


