module bit_orn#(parameter XLEN =32)
                (input [XLEN-1:0] rs1,
                 input [XLEN-1:0] rs2,
                 output[XLEN-1:0] orn_result);

	assign orn_result = rs1 | (~rs2);
endmodule
