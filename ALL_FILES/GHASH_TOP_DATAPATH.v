module ghash_top_datapath#(parameter WIDTH = 128)
(
    input                  clk,
    input                  rst,
    input  [WIDTH-1:0]     h_reg_data,
    input                  h_reg_en,
    input  [WIDTH-1:0]     aad_data,
    input  [WIDTH-1:0]     cipher_text,
    input  [WIDTH-1:0]     length_data,
    input  [1:0]           mux_sel,
    input                  ac_reg_en,
    input                  ac_clr,
    input                  s_reg_en,
    output [WIDTH-1:0]     s_reg_out
);

    // wire declarations
    wire [WIDTH-1:0]  mux_out_w;
    wire [WIDTH-1:0]  xor_out;
    wire [WIDTH-1:0]  ac_data_out_w;
    wire [WIDTH-1:0]  h_reg_out;
    wire [WIDTH-1:0]  gf_out_w;
    wire [WIDTH-1:0]  s_reg_out_w;

    // ----------------------------------------------------
    // MUX: select AAD / CIPHER / LENGTH
    // ----------------------------------------------------
    mux #( .WIDTH(WIDTH) ) mux_u (
        .in1(aad_data),
        .in2(cipher_text),
        .in3(length_data),
        .mux_sel(mux_sel),
        .mux_out(mux_out_w)
    );

    // ----------------------------------------------------
    // XOR: xored = AC ^ selected_block
    // (AC is previous accumulator -> ac_data_out_w)
    // ----------------------------------------------------
    xor_op #( .WIDTH(WIDTH) ) xor_u (
        .a(s_reg_out_w),
        .b(mux_out_w),
        .x_out(xor_out)
    );

    // ----------------------------------------------------
    // H register
    // ----------------------------------------------------
    h_reg #( .WIDTH(WIDTH) ) h_reg_u (
        .clk(clk),
        .rst(rst),
        .h_en(h_reg_en),
        .h_data(h_reg_data),
        .h_out(h_reg_out)
    );

    // ----------------------------------------------------
    // GF multiplier (carry-less multiply + reduction wrapper 'top')
    // IMPORTANT: pass X = xor_out, Y = H
    // ----------------------------------------------------
    top #( .WIDTH(WIDTH) ) gf_u (
//	.clk(clk),
//	.rst(rst),
        .x(ac_data_out_w),
        .y(h_reg_out),
        .gf_out(gf_out_w)
    );

    // ----------------------------------------------------
    // AC register: store mult result when ac_reg_en
    // ----------------------------------------------------
    ac_reg #( .WIDTH(WIDTH) ) ac_reg_u (
        .clk(clk),
        .rst(rst),
        .ac_en(ac_reg_en),
        .clr_ac(ac_clr),
        .ac_data_in(xor_out),     // store (AC ^ block) · H
        .ac_data_out(ac_data_out_w)
    );

    // ----------------------------------------------------
    // S register: capture tag (we capture mult_out here)
    // ----------------------------------------------------
    s_reg #( .WIDTH(WIDTH) ) s_reg_u (
        .clk(clk),
        .rst(rst),
        .s_en(s_reg_en),
        .s_data(gf_out_w),         // capture current multiply result
        .s_out(s_reg_out_w)
    );

    assign s_reg_out = s_reg_out_w;

endmodule

