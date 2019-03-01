

module tb_sha256_round_sum;

    reg  [31:0] a;
    wire [31:0] sum0;
    wire [31:0] sum1;

    // Instantiate DUT
    sha256_round dut (
        .a(a),
        .b(32'b0),
        .c(32'b0),
        .d(32'b0),
        .e(32'b0),
        .f(32'b0),
        .g(32'b0),
        .h(32'b0),
        .w(32'b0),
        .k(32'b0),

        .ao(),
        .bo(),
        .co(),
        .do(),
        .eo(),
        .fo(),
        .go(),
        .ho(),

        .sum0(sum0),
        .sum1(sum1)
    );

    initial begin
        // Test vector from SHA-256 spec
        a = 32'h6a09e667;   // Initial SHA-256 A constant
        #10;

        $display("Input a   = %h", a);
        $display("SUM0(a)   = %h", sum0);
        $display("SUM1(a)   = %h", sum1);

        // Another test
        a = 32'h12345678;
        #10;

        $display("Input a   = %h", a);
        $display("SUM0(a)   = %h", sum0);
        $display("SUM1(a)   = %h", sum1);

        $finish;
    end

endmodule

