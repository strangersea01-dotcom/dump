module riscv_scalar_cryptography_proscessor (
					input clk,
					input rst,
					input [31:0] inst_write_en,
					output [31:0] write_out
                    				                      );

					


wire[31:0] pc_inst_wire,rs2_data_w,rs1_data_w,mux_out_w,bit_mani_w,carry_less_w,alu_out_w,data_write_w,data_to_reg_w,aes_out_w,sha_out_w,fetch_inst_w,fetch_inst_out_w;
//wire[2:0] func3_w;
//wire[6:0] func7_w;
//wire[6:0] opcode_w;
//wire[31:0] inst_w_c;
//wire[11:0] imm_w;
//wire[31:0] imm_sign_mux_dc;
wire[4:0] rd_addr_w_dc,rd_addr_w_ex;
wire[4:0] alu_opcode_w,alu_opcode_w_dc,rd_addr_w_wb;
wire reg_write_w,imm_sel_w,data_write_en_w,byte_sel_w,data_sel_mux_w,byte_sel_w_dc,reg_write_en_ex,data_sel_mux_ec_w,reg_enable_wb;
wire [1:0] alu_sel_w,bytes_w,alu_sel_w_dc;
wire [31:0] rs1_data_w_dc,rs2_data_w_dc,alu_out_w_dc,rs2_data_w_ex,alu_out_w_wb,data_write_w_wb,sign_out_w,imm_sign_mux;
wire reg_write_w_dc,imm_sel_w_dc,imm_extend_w;//,sign_sel_en_w;
wire data_write_en_w_dc,data_write_en_w_ex,data_sel_mux_w_wb,data_sel_mux_w_dc;
wire[4:0] rs1_addr_out_dc,rs2_addr_out_dc;
wire [1:0] forward_a,foward_b;
wire[31:0] forward_alu_rs1,forward_alu_rs2;
//wire[7:0] zero8 = 8'b0;
//wire[31:0] zero32 = 32'b0;

//////////////////////////////////////////////////////////////////FETCH////////////////////////////////////////////////////////
pc_top  pc_counter(.clk(clk),	
		           .rst(rst),
		           .pc_out(pc_inst_wire));


instruction_memory_top instruction(.pc_addr(pc_inst_wire[9:2]),
				   .clk(clk),
				   .rst(rst),
				   .write_data(inst_write_en),
				   .inst_out_c(fetch_inst_w));

fetch_cycle   fetch_cycle(.clk(clk),
			  .rst(rst),
			  .inst_in(fetch_inst_w),
			  .inst_out(fetch_inst_out_w));
///////////////////////////////////////////////////////DECODE///////////////////////////////////////////////////////
/*instruction_parser instruction_parser(.inst_out(fetch_inst_out_w),				
				                     .rs2_addr(rs2_addr_w),
			                          .rs1_addr(rs1_addr_w),
                                       .rd_addr(rd_addr_w),
                                      .func7(func7_w),
                                       . func3(func3_w),
                                       . opcode(opcode_w),
				                      . imm(imm_w));
                                  // .inst_out_c(inst_w_c));*/


riscv_control_unit riscv_contro_unit(.inst_in(fetch_inst_out_w[31:20]),
                                     .func3(fetch_inst_out_w[14:12]),
                                     //.func7(fetch_inst_out_w[31:25]),
                                     .opcode(fetch_inst_out_w[6:0]),
                                     .reg_write(reg_write_w_dc),
                                     .imm_sel(imm_sel_w_dc),
                                     .data_write_en(data_write_en_w_dc),
                                     .data_sel_mux(data_sel_mux_w_dc),
                                     .alu_opcode(alu_opcode_w_dc),
                                     .alu_sel_mux(alu_sel_w_dc),
                                     .byte_sel(byte_sel_w_dc),
                                    // .bytes(bytes_w_dc),
				     .sign_extend(imm_extend_w) );






gpr register_file(.clk(clk),
                  .rst(rst),
                  .rs1_addr(fetch_inst_out_w[19:15]),
                  .rs2_addr(fetch_inst_out_w[24:20]),
                  .rd_addr(rd_addr_w_wb),
                  .reg_write(reg_enable_wb),
                  .write_data(data_to_reg_w),
                  .rs1_data(rs1_data_w_dc),
                  .rs2_data(rs2_data_w_dc)
                );


sign_extend signextend (.imm(fetch_inst_out_w[31:20]),
			.imm_extend(imm_extend_w),
                        .imm_out(sign_out_w));





decode_cycle decoder_cycle(.clk(clk),
                           .rst(rst),
			  // .sign_ext_en(imm_extend_w),
			   //.imm_ext(imm_extend_w),
                           .rs1_addr(fetch_inst_out_w[19:15]),
                           .rs2_addr(fetch_inst_out_w[24:20]),
                           .rs1_dc(rs1_data_w_dc),
                           .rs2_dc(rs2_data_w_dc),
                           .rd_addr_c(fetch_inst_out_w[11:7]),
                           .reg_write_en_dc(reg_write_w_dc),
                           .imm_sel_dc(imm_sel_w_dc),
                           .data_write_en_dc(data_write_en_w_dc),
                           .data_sel_mux_dc(data_sel_mux_w_dc),
                           .alu_opcode_dc(alu_opcode_w_dc),
                           .alu_sel_mux_dc(alu_sel_w_dc),
                           .byte_sel_dc(byte_sel_w_dc),
                           .bytes_dc(fetch_inst_out_w[3:2]),
                           .imm_w(sign_out_w),
                           .rs1_data(rs1_data_w),
                           .rs2_data(rs2_data_w),
                           .reg_write(reg_write_w),
                           .imm_sel(imm_sel_w),     
                           .data_write_en(data_write_en_w),
                           .data_sel_mux(data_sel_mux_w),
                           .alu_opcode(alu_opcode_w),
                           .alu_sel_mux(alu_sel_w),
                           .byte_sel(byte_sel_w),
                           .bytes(bytes_w),
                           .sign_out(imm_sign_mux),
                           .rd_addr_out(rd_addr_w_dc),
                           .rs1_addr_out(rs1_addr_out_dc),
                           .rs2_addr_out(rs2_addr_out_dc));
			   //.sign_ext_en_out(sign_sel_en_w));



////////////////////////////////////////////////////////////////////EXECUTE//////////////////////////////////////////////////




mux mux21(.rs1(forward_alu_rs2),
          .rs2(imm_sign_mux),
          .mux_sel(imm_sel_w),
          .mux_out(mux_out_w));


crypto_engine crypto_alu(.rs1(forward_alu_rs1),
               .rs2(mux_out_w),
               .alu_opcode(alu_opcode_w),
               .bytes(bytes_w),
               .byte_sel(byte_sel_w),
               .bitmanipulation_engine_out(bit_mani_w),
               .carry_less_mul_out(carry_less_w),
               .aes_out(aes_out_w),
               .sha_out(sha_out_w));



mux31 alu_sel_mux(.bit_mani_in(bit_mani_w),
                  .carry_less_in(carry_less_w),
                  .aes_in(aes_out_w),
                  .sha_in(sha_out_w),
                  .mux_sel_alu(alu_sel_w),
                  .alu_out(alu_out_w));

execute_cycle excutecycle(.clk(clk),
                          .rst(rst),
                          .reg_write_en_ex(reg_write_w),
                          .rd_in(rd_addr_w_dc),
                          .alu_in(alu_out_w),
                          .rs2_in(rs2_data_w),
                          .data_write_en(data_write_en_w),
                          .alu_out(alu_out_w_dc),
                          .data_write_en_ex(data_write_en_w_ex),
                          .rs2_ex(rs2_data_w_ex),
                          .rd_out_addr(rd_addr_w_ex),
                          .reg_write_en(reg_write_en_ex),
                          .data_sel_mux_in(data_sel_mux_w),
                          .data_sel_mux_ec(data_sel_mux_ec_w));
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
data_memory_top dm(.addr(alu_out_w_dc[9:2]),
		   .clk(clk),
		   .rst(rst),
		   .write_data(rs2_data_w_ex),
           .data_write_en(data_write_en_w_ex),
          .data_out(data_write_w));

write_back_cycle wb(.clk(clk),
                    .rst(rst),
                    .data_sel_mux_wb(data_sel_mux_ec_w),
                    .rd_addr_in(rd_addr_w_ex),
                    .reg_write_en(reg_write_en_ex),
                    .alu_in(alu_out_w_dc),
                    .data_write(data_write_w),
                     .alu_out(alu_out_w_wb),
                    .data_write_out(data_write_w_wb),
                    .rd_addr_out(rd_addr_w_wb),
                    .reg_write_en_out(reg_enable_wb),
                    .data_sel_mux_out_wb(data_sel_mux_w_wb));


mux data_alu_sel(.rs1(alu_out_w_wb),
                 .rs2(data_write_w_wb),
                 .mux_sel(data_sel_mux_w_wb),
                  .mux_out(data_to_reg_w));
            

              
   //hzard unit 


forward_unit forwardunit(//.rst(rst), 
                         .regwritem(reg_write_en_ex), 
                         .regwritew(reg_enable_wb), 
                         .rd_m(rd_addr_w_ex), 
                         .rd_w(rd_addr_w_wb),
                         .rs1_d(rs1_addr_out_dc),
                         .rs2_d(rs2_addr_out_dc),
                         .forwarda(forward_a),
                         .forwardb(foward_b));

 mux3_1 forwarda(.a(rs1_data_w),
              .b(data_to_reg_w),
              .c(alu_out_w_dc),
              .d(forward_alu_rs1),
              .s(forward_a));


 mux3_1 forwardb(.a(rs2_data_w),
              .b(data_to_reg_w),
              .c(alu_out_w_dc),
              .d(forward_alu_rs2),
              .s(foward_b));

                   

              assign write_out = data_to_reg_w;
                             

      
endmodule

