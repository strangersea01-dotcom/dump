module instruction_parser(
			 input [31:0] inst_out,
			 output reg[4:0] rs2_addr,
			       output reg[4:0] rs1_addr,
			       output reg [4:0] rd_addr,
			       output reg [6:0] func7,
				output reg [2:0] func3,
				output reg [6:0] opcode,
				output reg[11:0] imm);


always@( inst_out[31:20])
		begin


			case(inst_out[31:20])
				12'b011010000111 : begin
							func7 = 7'b0;
							imm = inst_out[31:20];
							rs2_addr = 5'b0;
							rs1_addr = inst_out[19:15];
							func3 = inst_out[14:12];
							rd_addr = inst_out[11:7];
							opcode  = inst_out[6:0];	
						   end
				12'b011010011000 : begin
							imm = inst_out[31:20];
							func7 = 7'b0;
							rs2_addr = 5'b0;
							rs1_addr = inst_out[19:15];
							func3 = inst_out[14:12];
							rd_addr = inst_out[11:7];
							opcode = inst_out[6:0];
						   end
				default : begin
						imm = 12'b0;
						func7 = inst_out[31:25];
						rs2_addr = inst_out[24:20];
						rs1_addr = inst_out[19:15];
						func3 = inst_out[14:12];
						rd_addr = inst_out[11:7];
						opcode = inst_out[6:0];
					 end 
			endcase
								
		end

endmodule



