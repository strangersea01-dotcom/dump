module bit_packh #(parameter XLEN =32)
                (input [XLEN-1:0] rs1,
                 input [XLEN-1:0] rs2,
                 output[XLEN-1:0] packh_result);


	
		assign packh_result = {{16{1'b0}},rs2[7:0],rs1[7:0]};
endmodule
