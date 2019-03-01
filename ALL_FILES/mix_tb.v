

module tb_mix_op;

    reg  [31:0] in_word;
    wire [31:0] out_word;

    // DUT
    mix_op dut (
        .in_word (in_word),
        .out_word(out_word)
    );

    initial begin
        $display("======================================");
        $display(" AES MIXCOLUMNS TESTBENCH ");
        $display("======================================");

        // Test vector from AES spec (FIPS-197)
        in_word = 32'hD4BF5D30;
        #10;

        $display("Input  = %h", in_word);
        $display("Output = %h (expected 046681E5)", out_word);

        if (out_word == 32'h046681E5)
            $display("TEST PASSED ?");
        else
            $display("TEST FAILED ?");

        // Optional second test (simple sanity)
        in_word = 32'h00000000;
        #10;
        $display("Input  = %h", in_word);
        $display("Output = %h (expected 00000000)", out_word);

        $display("======================================");
        $finish;
    end

endmodule

