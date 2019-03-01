

module tb_ghash_main_top;

    parameter WIDTH = 128;

    // clock & control
    reg clk;
    reg rst;
    reg start;

    reg aad_empty;
    reg cipher_empty;
    reg length_empty;

    // data inputs
    reg [WIDTH-1:0] h_reg_data;
    reg [WIDTH-1:0] aad_data;
    reg [WIDTH-1:0] cipher_text;
    reg [WIDTH-1:0] length_data;

    // outputs
    wire [WIDTH-1:0] tag;
    wire done;

    // DUT
    ghash_main_top #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .aad_empty(aad_empty),
        .cipher_empty(cipher_empty),
        .length_empty(length_empty),

        .h_reg_data(h_reg_data),
        .aad_data(aad_data),
        .cipher_text(cipher_text),
        .length_data(length_data),

        .tag(tag),
        .done(done)
    );

    // -----------------------------
    // Clock generation (10ns)
    // -----------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // -----------------------------
    // Waveform dump
    // -----------------------------
    initial begin
        $shm_open("ghash_main_top.shm");
        $shm_probe("ACTMF");
    end
    // -----------------------------
    // Monitor (console output)
    // -----------------------------
    initial begin
        $display("TIME | start | AAD_E CIPH_E LEN_E | done | TAG");
        $monitor("%4t |   %b   |   %b      %b      %b   |  %b   | %h",
                 $time, start, aad_empty, cipher_empty, length_empty, done, tag);
    end

    // -----------------------------
    // Test sequence
    // -----------------------------
    initial begin
        // ---------------- RESET ----------------
        rst = 1;
        start = 0;
        aad_empty = 1;
        cipher_empty = 1;
        length_empty = 1;

        h_reg_data   = 128'h0;
        aad_data     = 128'h0;
        cipher_text  = 128'h0;
        length_data  = 128'h0;

        #20;
        rst = 0;

        // ---------------- LOAD H ----------------
        h_reg_data = 128'h0F0E_0D0C_0B0A_0908_0706_0504_0302_0100;

        // ---------------- START ----------------
        #10;
        start = 1;

        // ---------------- AAD BLOCK ----------------
        aad_empty = 0;
        aad_data  = 128'h1111_2222_3333_4444_5555_6666_7777_8888;

        #20;
        aad_empty = 1;   // no more AAD

        // ---------------- CIPHER BLOCK 1 ----------------
        cipher_empty = 0;
        cipher_text  = 128'hAAAA_BBBB_CCCC_DDDD_EEEE_FFFF_0000_1111;

        #20;

        // ---------------- CIPHER BLOCK 2 ----------------
        cipher_text  = 128'h9999_8888_7777_6666_5555_4444_3333_2222;

        #20;
        cipher_empty = 1;  // no more cipher

        // ---------------- LENGTH BLOCK ----------------
        length_empty = 0;
        length_data  = {64'd128, 64'd256};  // AAD bits || Cipher bits

        #20;
        length_empty = 1;

        // ---------------- FINISH ----------------
        #30;
        start = 0;

        #40;
        $display("==== FINAL TAG ====");
        $display("TAG = %h", tag);

        #20;
        $finish;
    end

endmodule

