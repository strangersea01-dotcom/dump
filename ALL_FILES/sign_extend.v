module sign_extend( input [11:0] imm,
		    input imm_extend,
                    output  [31:0] imm_out);
		

		assign imm_out = imm_extend ? {{20{imm[11]}},imm} :32'b0 ;	
                endmodule
