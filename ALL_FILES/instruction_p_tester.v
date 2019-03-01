/*module instruction_parser(inst_out, rs2_addr, rs1_addr, rd_addr, func7,
     func3, opcode, imm);
  input [31:0] inst_out;
  output [4:0] rs2_addr, rs1_addr, rd_addr;
  output [6:0] func7, opcode;
  output [2:0] func3;
  output [11:0] imm;
  wire [31:0] inst_out;
  wire [4:0] rs2_addr, rs1_addr, rd_addr;
  wire [6:0] func7, opcode;
  wire [2:0] func3;
  wire [11:0] imm;
  wire n_106, n_227, n_228, n_263, n_265, n_272, n_273, n_274;
  wire n_283, n_284, n_285, n_286, n_291, n_292, n_305, n_306;
  wire n_307, n_308, n_309, n_310, n_363, n_364;
  assign imm[0] = 1'b0;
  assign imm[1] = 1'b0;
  assign imm[2] = 1'b0;
  assign imm[3] = 1'b0;
  assign imm[4] = 1'b0;
  assign imm[5] = 1'b0;
  assign imm[6] = 1'b0;
  assign imm[7] = 1'b0;
  assign imm[8] = 1'b0;
  assign imm[9] = 1'b0;
  assign imm[10] = 1'b0;
  assign imm[11] = 1'b0;
  assign opcode[0] = 1'b0;
  assign opcode[1] = 1'b0;
  assign opcode[2] = 1'b0;
  assign opcode[3] = 1'b0;
  assign opcode[4] = 1'b0;
  assign opcode[5] = 1'b0;
  assign opcode[6] = 1'b0;
  assign func3[0] = 1'b0;
  assign func3[1] = 1'b0;
  assign func3[2] = 1'b0;
  assign func7[0] = 1'b0;
  assign func7[1] = 1'b0;
  assign func7[2] = 1'b0;
  assign func7[3] = 1'b0;
  assign func7[4] = 1'b0;
  assign func7[5] = 1'b0;
  assign func7[6] = 1'b0;
  assign rd_addr[0] = 1'b0;
  assign rd_addr[1] = 1'b0;
  assign rd_addr[2] = 1'b0;
  assign rd_addr[3] = 1'b0;
  assign rd_addr[4] = 1'b0;
  assign rs1_addr[0] = 1'b0;
  assign rs1_addr[1] = 1'b0;
  assign rs1_addr[2] = 1'b0;
  assign rs1_addr[3] = 1'b0;
  assign rs1_addr[4] = 1'b0;
  or g236 (n_106, n_309, n_310);
  or g237 (n_310, n_307, n_308);
  or g238 (n_307, n_228, n_263);
  or g239 (n_228, n_292, wc19023);
  not gc19023 (wc19023, inst_out[30]);
  or g240 (n_292, inst_out[25], n_291);
  or g241 (n_291, wc19024, n_227);
  not gc19024 (wc19024, n_265);
  or g242 (n_227, n_286, wc19025);
  not gc19025 (wc19025, inst_out[27]);
  or g243 (n_263, wc19026, n_274);
  not gc19026 (wc19026, n_273);
  or g244 (n_286, n_285, wc19027);
  not gc19027 (wc19027, inst_out[29]);
  or g245 (n_274, inst_out[31], wc19028);
  not gc19028 (wc19028, n_272);
  nand g246 (n_285, n_283, n_284);
  nand g247 (n_309, n_305, n_306);
  nand g248 (n_273, inst_out[23], inst_out[20]);
  or g249 (n_272, inst_out[23], inst_out[20]);
  or g250 (n_284, wc19029, inst_out[23]);
  not gc19029 (wc19029, inst_out[24]);
  or g251 (n_283, inst_out[24], wc19030);
  not gc19030 (wc19030, inst_out[23]);
  or g252 (n_363, wc19031, inst_out[22]);
  not gc19031 (wc19031, inst_out[23]);
  or g253 (n_364, inst_out[23], wc19032);
  not gc19032 (wc19032, inst_out[22]);
  nand g254 (n_265, n_363, n_364);
  or g255 (n_308, inst_out[28], inst_out[26]);
  nand g256 (n_306, inst_out[23], inst_out[21]);
  or g257 (n_305, inst_out[23], inst_out[21]);
  and g261 (rs2_addr[0], n_106, inst_out[20]);
  and g262 (rs2_addr[1], n_106, inst_out[21]);
  and g264 (rs2_addr[2], n_106, inst_out[22]);
  and g265 (rs2_addr[3], n_106, inst_out[23]);
  and g267 (rs2_addr[4], n_106, inst_out[24]);
endmodule
*/
module instruction_paser_tb;
reg [31:0] inst_out;
  wire [4:0] rs2_addr, rs1_addr, rd_addr;
  wire [6:0] func7, opcode;
  wire [2:0] func3;
  wire [11:0] imm;

instruction_parser dut(.inst_out(inst_out),
			 .rs2_addr(rs2_addr),
			. rs1_addr(rs1_addr),
			. rd_addr(rd_addr), 
			.func7(func7),
     			.func3(func3),
			. opcode(opcode), 
			.imm(imm));
initial begin
$shm_open("instruction.shm");
$shm_probe("ACTMF");
end
	initial begin
			inst_out = 32'h606293B3;
#10
			inst_out = 32'h6062D3B3;
#10
			inst_out = 32'h4062F3B3;
#10
			inst_out = 32'h4062E3B3;
#10
			inst_out = 32'h4062C3B3;
#10
			inst_out = 32'h0862C3B3;
#10
			inst_out = 32'h0862F3B3;
#10
			inst_out = 32'h08F01393;
#10
			inst_out = 32'h08F05393;
#100
			$finish();
	end
				
endmodule
