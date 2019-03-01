module crypto_engine #(parameter XLEN = 32 )

		    (input [XLEN-1:0] rs1,
			input [XLEN-1:0] rs2,
			input [4:0] alu_opcode,
            input [1:0] bytes,
            input byte_sel,
			output [XLEN-1:0] bitmanipulation_engine_out,
			output [XLEN-1:0] carry_less_mul_out,
            output [XLEN-1:0] aes_out,
            output [XLEN-1:0] sha_out);

bitmanipulation #(.XLEN(XLEN)) bit_manipulation_engine(.rs1(rs1),
							.rs2(rs2),
							.alu_opcode(alu_opcode),
							.bitmanipulation_out(bitmanipulation_engine_out));



carry_less_mul_top #(.XLEN(XLEN)) carry_less_mul_top (.rs1(rs1),
						      .rs2(rs2),
						      .alu_opcode(alu_opcode),
						      .carry_less_mul_out(carry_less_mul_out));

aes_engine #(.XLEN(XLEN)) aes_engine_top(.rs1(rs1),
                                         .rs2(rs2),
                                         .alu_opcode(alu_opcode),
                                         .bytes(bytes),
                                         .byte_sel(byte_sel),
                                         .aes_out(aes_out));

sha_engine sha_engine_top (.rs1(rs2),
                           .alu_opcode(alu_opcode),
                           .sha_engine_out(sha_out));



endmodule
