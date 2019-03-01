module sha_engine( input[31:0] rs1,
                   input[4:0] alu_opcode,
                   output reg [31:0] sha_engine_out);

 //wire[31:0] 32'b0 = 32'b0;
 //wire[6:0] zero7 = 7'b0;
wire[31:0] unused_a,unused_b,unused_c,unused_d,unused_e,unused_f,unused_g,unused_h;
wire[31:0] unused_i,unused_j,unused_k,unused_l;
wire[31:0] sha_sum0, sha_sum1;
wire[31:0] sha_sigma0, sha_sigma1;

sha256_round  sha_sum0_sum1 (
                              .a(rs1),
                              .b(32'b0),
                              .c(32'b0),
                              .d(32'b0),
                              .e(32'b0),
                              .f(32'b0),
                              .g(32'b0),
                              .h(32'b0),
                              .w(32'b0),
                              .k(32'b0),
                              .sum0(sha_sum0),
                              .sum1(sha_sum1),
			       .ao(unused_a),
				.bo(unused_b),
				.co(unused_c),
				.d0(unused_d),
			        .eo(unused_e),
				.fo(unused_f),
				.go(unused_g),
				.ho(unused_h));


sha256_msg_datapath sha256_sigma0_sigma1 (
                                            .t_in(7'b0),              
                                            .bufrd_t16_in(rs1),
                                            .bufrd_t15_in(32'b0),
                                            .bufrd_t14_in(32'b0),
                                            .bufrd_t13_in(32'b0),
                                            .bufrd_t12_in(32'b0),
                                            .bufrd_t7_in(32'b0),
                                            .bufrd_t6_in(32'b0),
                                            .bufrd_t5_in(32'b0),
                                            .bufrd_t4_in(32'b0),
                                            .bufrd_t2_in(32'b0),
                                            .bufrd_t1_in(32'b0),
                                            .sigma_0(sha_sigma0),
                                            .sigma_1(sha_sigma1),
					    .w0_out(unused_i),
					     .w1_out(unused_j),
					    .w2_out(unused_k),
					    .w3_out(unused_l));

always@(alu_opcode or sha_sigma0 or sha_sigma1 or sha_sum0 or sha_sum1)
begin
        case(alu_opcode)
            5'b10001 : sha_engine_out = sha_sigma0;
            5'b10010 : sha_engine_out = sha_sigma1;
            5'b10011 : sha_engine_out = sha_sum0;
            5'b10100 : sha_engine_out = sha_sum1;
            default  : sha_engine_out = 32'b0;
        endcase
end


  endmodule
