

module tb_sha256_msg_sigma;

    reg  [31:0] rs1;
    wire [31:0] sigma0;
    wire [31:0] sigma1;

    sha256_msg_datapath dut (
        .t_in(7'd0),
        .bufrd_t16_in(rs1),
        .bufrd_t15_in(32'b0),
        .bufrd_t14_in(32'b0),
        .bufrd_t13_in(32'b0),
        .bufrd_t12_in(32'b0),
        .bufrd_t7_in (32'b0),
        .bufrd_t6_in (32'b0),
        .bufrd_t5_in (32'b0),
        .bufrd_t4_in (32'b0),
        .bufrd_t2_in (32'b0),
        .bufrd_t1_in (32'b0),
        .sigma_0(sigma0),
        .sigma_1(sigma1),
        .w0_out(),
        .w1_out(),
        .w2_out(),
        .w3_out()
    );

    initial begin
        rs1 = 32'h6a09e667;
        #10;
        $display("x=%h  SIG0=%h  SIG1=%h", rs1, sigma0, sigma1);

        rs1 = 32'h12345678;
        #10;
        $display("x=%h  SIG0=%h  SIG1=%h", rs1, sigma0, sigma1);

        $finish;
    end
endmodule

