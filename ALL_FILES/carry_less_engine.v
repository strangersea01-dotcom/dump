module carry_less_mul_top#(parameter XLEN = 32)
			(input [XLEN-1:0] rs1,
			 input [XLEN-1:0] rs2,
			 input[4:0] alu_opcode,
			 output reg [XLEN-1:0] carry_less_mul_out);

wire[2*XLEN-1:0] carry_less_mul_lower;//, carry_less_mul_lower ;

/*carry_less_mul #(.XLEN(XLEN)) carry_less_mul_lower_32 (.rs1(rs1),
							.rs2(rs2),
							.carry_less_mul_out(carry_less_mul_lower_w));


carry_less_mul #(.XLEN(XLEN)) carry_less_mul_higher_32 (.rs1(rs1),
							.rs2(rs2),
							.carry_less_mul_out(carry_less_mul_higher_w));*/

                           
carry_less_mul #(.WIDTH_IN(XLEN),
                 .WIDTH_OUT(2*XLEN))
                            carry_less_mul_lower_32 (.x(rs1),
							.y(rs2),
							.carry_less_out(carry_less_mul_lower ));
 
/*carry_less_mul #(.WIDTH_IN(XLEN),
                 .WIDTH_OUT(2*XLEN))
                            carry_less_mul_higher_32 (.x(rs1),
							.y(rs2),
							.carry_less_out(carry_less_mul_higher));*/

always@(alu_opcode or carry_less_mul_lower )
	begin
		carry_less_mul_out = 32'b0;
		case(alu_opcode)
		    5'b01010 : carry_less_mul_out = carry_less_mul_lower[31:0];
		    5'b01011 : carry_less_mul_out = carry_less_mul_lower[63:32];
		default : carry_less_mul_out = 32'b0;
		endcase		
	end
endmodule
							
				
