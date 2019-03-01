module bit_xnor #(parameter XLEN =32)
                (input [XLEN-1:0] rs1,
                 input [XLEN-1:0] rs2,
                 output[XLEN-1:0] xnor_result);

	assign xnor_result = ~(rs1 ^ rs2);
endmodule


