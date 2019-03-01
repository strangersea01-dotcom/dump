module bitmanipulation#(parameter XLEN = 32)
			(input [XLEN-1:0] rs1,
			 input [XLEN-1:0] rs2,
			 input[4:0] alu_opcode,
			 output reg [XLEN-1:0] bitmanipulation_out);

wire[XLEN-1:0] rol_result_w, ror_result_w, andn_result_w, orn_result_w, xnor_result_w, pack_result_w, packh_result_w, zip_result_w , unzip_result_w,brev_result_w,rev_result_w;

bit_rol #(.XLEN(XLEN)) bitrol(.rs1(rs1),
			      .rs2(rs2),
			      .rol_result(rol_result_w));

bit_ror #(.XLEN(XLEN)) bitror(.rs1(rs1),
			      .rs2(rs2),
			      .ror_result(ror_result_w));

bit_andn #(.XLEN(XLEN)) bitandn(.rs1(rs1),
			      .rs2(rs2),
			      .andn_result(andn_result_w));

bit_orn #(.XLEN(XLEN)) bitorn(.rs1(rs1),
			      .rs2(rs2),
			      .orn_result(orn_result_w));

bit_xnor #(.XLEN(XLEN)) bitxnor(.rs1(rs1),
			      .rs2(rs2),
			      .xnor_result(xnor_result_w));

bit_pack #(.XLEN(XLEN)) bitpack(.rs1(rs1),
			      .rs2(rs2),
			      .pack_result(pack_result_w));

bit_packh #(.XLEN(XLEN)) bitpackh(.rs1(rs1),
			      .rs2(rs2),
			      .packh_result(packh_result_w));

bit_zip #(.XLEN(XLEN)) bitzip(.rs1(rs1),		
			      .zip_result(zip_result_w));


bit_unzip #(.XLEN(XLEN)) bitunzip(.rs1(rs1),		
			      .unzip_result(unzip_result_w));

bit_brev8 #(.XLEN(XLEN)) bitbrev (.rs1(rs1),
				  .brev_result(brev_result_w));

bit_rev8 #(.XLEN(XLEN)) bitrev8(.rs1(rs1),
				.rev_result(rev_result_w));



always@( alu_opcode or rol_result_w or ror_result_w or andn_result_w or orn_result_w or xnor_result_w or pack_result_w or packh_result_w or zip_result_w or unzip_result_w or brev_result_w or rev_result_w) begin

			bitmanipulation_out = 32'b0;
	case(alu_opcode)

	     5'b00001 : bitmanipulation_out = rol_result_w;
	     5'b00010 : bitmanipulation_out = ror_result_w;
	     5'b00011 : bitmanipulation_out = andn_result_w;
	     5'b00100 : bitmanipulation_out = orn_result_w;
	     5'b00101 : bitmanipulation_out = xnor_result_w;
	     5'b00110 : bitmanipulation_out = pack_result_w;
	     5'b00111 : bitmanipulation_out = packh_result_w;
	     5'b01000 : bitmanipulation_out = zip_result_w;
	     5'b01001 : bitmanipulation_out = unzip_result_w;
	     5'b01100 : bitmanipulation_out = brev_result_w;
	     5'b01101 : bitmanipulation_out = rev_result_w;
	     
	    
		default : bitmanipulation_out = 32'b0;
	endcase
end


endmodule

