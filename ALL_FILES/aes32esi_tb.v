

module tb_aes32esi;

    reg  [31:0] rs1;
    reg  [31:0] rs2;
    reg         byte_sel;
    reg  [1:0]  bytes;
    wire [31:0] aes_out;

    // DUT
    aes32esi dut (
        .rs1     (rs1),
        .rs2     (rs2),
        .byte_sel(byte_sel),
        .bytes   (bytes),
        .aes_out (aes_out)
    );

    initial begin
        $display("==============================================");
        $display(" AES32ESI TESTBENCH ");
        $display("==============================================");

        byte_sel = 1'b1;
        rs1 = 32'h0000_ABCD;
        rs2 = 32'h000A_BABA;

        // ---------------------------
        // bs = 0
        // ---------------------------
        bytes = 2'b00;
        #10;
        $display("bs=0 | rs1=%h rs2=%h -> aes_out=%h (expected 0000AB39)", rs1, rs2, aes_out);

        // ---------------------------
        // bs = 1
        // ---------------------------
        bytes = 2'b01;
        #10;
        $display("bs=1 | rs1=%h rs2=%h -> aes_out=%h (expected 00005FCD)", rs1, rs2, aes_out);

        // ---------------------------
        // bs = 2
        // ---------------------------
        bytes = 2'b10;
        #10;
        $display("bs=2 | rs1=%h rs2=%h -> aes_out=%h (expected 0067ABCD)", rs1, rs2, aes_out);

        // ---------------------------
        // bs = 3
        // ---------------------------
        bytes = 2'b11;
        #10;
        $display("bs=3 | rs1=%h rs2=%h -> aes_out=%h (expected 6300ABCD)", rs1, rs2, aes_out);

        $display("==============================================");
        $finish;
    end

endmodule

