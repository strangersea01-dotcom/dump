module carry_less_mul#(parameter XLEN = 32)
			(input [XLEN-1:0] rs1,
			input [XLEN-1:0] rs2,
			output reg [2*XLEN-1:0] carry_less_mul_out);

integer i;

	always@(rs1 or rs2)
		begin
			carry_less_mul_out = {2*XLEN{1'b0}};
			for(i = 0 ; i <= XLEN ; i = i +1)
			begin
				if(rs2[i])
				begin
				carry_less_mul_out = carry_less_mul_out ^ ( rs1 << i);
				end
			end
		end

endmodule
