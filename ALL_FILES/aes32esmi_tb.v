

module tb_aes32esmi;

    reg  [31:0] rs1;
    reg  [31:0] rs2;
    reg         byte_sel;
    reg  [1:0]  bytes;
    wire [31:0] aes32esmi_out;

    aes32esmi dut (
        .rs1(rs1),
        .rs2(rs2),
        .byte_sel(byte_sel),
        .bytes(bytes),
        .aes32esmi_out(aes32esmi_out)
    );

    initial begin
        $display("====================================");
        $display(" AES32ESMI TESTBENCH ");
        $display("====================================");

        byte_sel = 1'b1;
        rs1  = 32'h00000000;
        rs2  = 32'h000000BA;
        bytes = 2'b00;

        #10;

        $display("rs1   = %h", rs1);
        $display("rs2   = %h", rs2);
        $display("bytes = %b", bytes);
        $display("OUT   = %h (expected F3F4F407)", aes32esmi_out);

        if (aes32esmi_out == 32'hF3F4F407)
            $display("TEST PASSED ?");
        else
            $display("TEST FAILED ?");

        $display("====================================");
        $finish;
    end

endmodule

