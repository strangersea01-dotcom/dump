/*module decoder#(parameter XLEN = 32)
		(input [XLEN-1:0] instr_in,
		 output reg [6:0] func7,
		 output reg[4:0] rs2_addr,
		 output reg[4:0] rs1_addr,
		 output reg[2:0] func3,
		 output reg[4:0] rd_addr,
		 output reg[6:0] opcode,
		 output reg[2:0] byte_select,
		 output reg[11:0] imm,
		 output reg[4:0] func_aes_sha);


always@(instr_in) 
		begin
			case(instr_in[7:0])
					16'hB3 : begin				//rol,ror,andn,orn,xnor,pack,pckh,cmulh,cmull               
						
							func7 =	 instr_in[31:25];
                                                        rs2_addr = instr_in[24:20];
                                                        rs1_addr = instr_in[19:15];
                                                        func3 = instr_in[14:12];
                                                        rd_addr = instr_in[11:7];
                                                        opcode = instr_in[6:0];
                                                        
						end
					 16'h93 : begin			  //zip,unzip
													
						if (instr_in[31:25] == 7'b0000100 ) 
							begin
							func7 =	 instr_in[31:25];
                                                        rs2_addr = instr_in[24:20];
                                                        rs1_addr = instr_in[19:15];
                                                        func3 = instr_in[14:12];
                                                        rd_addr = instr_in[11:7];
                                                        opcode = instr_in[6:0];
							end
						else	
								begin
								imm = instr_in[31:20];
								rs1_addr = instr_in[19:15];
								func3 = instr_in[14:12];
								rd_addr = instr_in[11:7];
								opcode = instr_in[6:0];
							end
						end
					16'h80 : begin	
							func7 = 1'b0;			
							byte_select = instr_in[31:30];
							func_aes_sha = instr_in[29:25];
							rs2_addr = instr_in[24:20];
							rs1_addr = instr_in[19:13];
							func3 = instr_in[14:12];
							rd_addr = instr_in[11:7];
							opcode = instr_in[6:0];
							
								
						 end
					default : begin
							byte_select = 2'b0;
							func_aes_sha = 5'b0;
							rs2_addr = 5'b0;
							rs1_addr = 5'b0;
							func3 = 3'b0;
							rd_addr = 5'b0;
							opcode = 7'b0;
							imm = 12'b0;
							func7 = 7'b0;						
						end
			endcase
		end
endmodule
	*/					
