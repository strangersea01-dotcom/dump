
/*module sha256_msg_datapath (
  input  [6:0]   t_in,

  input  [31:0]  bufrd_t16_in,
  input  [31:0]  bufrd_t15_in,
  input  [31:0]  bufrd_t14_in,
  input  [31:0]  bufrd_t13_in,
  input  [31:0]  bufrd_t12_in,
  input  [31:0]  bufrd_t7_in,
  input  [31:0]  bufrd_t6_in,
  input  [31:0]  bufrd_t5_in,
  input  [31:0]  bufrd_t4_in,
  input  [31:0]  bufrd_t2_in,
  input  [31:0]  bufrd_t1_in,
  output [31:0]  sigma_0,
  output [31:0]  sigma_1,
  output [31:0]  w0_out,
  output [31:0]  w1_out,
  output [31:0]  w2_out,
  output [31:0]  w3_out
);

  // SHA helpers
  function [31:0] ROTR(input [31:0] x, input [31:0] n);
    ROTR = (x >> n) | (x << (32-n));
  endfunction

  function [31:0] SHR(input [31:0] x, input [31:0] n);
    SHR = x >> n;
  endfunction

  function [31:0] SIG0(input [31:0] x);
    SIG0 = ROTR(x,7) ^ ROTR(x,18) ^ SHR(x,3);
  endfunction

  function [31:0] SIG1(input [31:0] x);
    SIG1 = ROTR(x,17) ^ ROTR(x,19) ^ SHR(x,10);
  endfunction

  assign sigma_0 = SIG0(bufrd_t16_in);
  assign sigma_1 = SIG1(bufrd_t16_in);


  // Message schedule math
  assign w0_out = (t_in < 7'd16) ? bufrd_t16_in : SIG1(bufrd_t2_in) + bufrd_t7_in + SIG0(bufrd_t15_in) + bufrd_t16_in;
  assign w1_out = (t_in < 7'd16) ? bufrd_t15_in : SIG1(bufrd_t1_in) + bufrd_t6_in + SIG0(bufrd_t14_in) + bufrd_t15_in;
  assign w2_out = (t_in < 7'd16) ? bufrd_t14_in : SIG1(w0_out)   + bufrd_t5_in + SIG0(bufrd_t13_in) + bufrd_t14_in;
  assign w3_out = (t_in < 7'd16) ? bufrd_t13_in : SIG1(w1_out)   + bufrd_t4_in + SIG0(bufrd_t12_in) + bufrd_t13_in;

      
endmodule
*/


module sha256_msg_datapath (
    input  [6:0]  t_in,

    input  [31:0] bufrd_t16_in,
    input  [31:0] bufrd_t15_in,
    input  [31:0] bufrd_t14_in,
    input  [31:0] bufrd_t13_in,
    input  [31:0] bufrd_t12_in,
    input  [31:0] bufrd_t7_in,
    input  [31:0] bufrd_t6_in,
    input  [31:0] bufrd_t5_in,
    input  [31:0] bufrd_t4_in,
    input  [31:0] bufrd_t2_in,
    input  [31:0] bufrd_t1_in,

    output [31:0] sigma_0,
    output [31:0] sigma_1,
    output [31:0] w0_out,
    output [31:0] w1_out,
    output [31:0] w2_out,
    output [31:0] w3_out
);

    // ---------------- SHA helpers ----------------
    function [31:0] ROTR(input [31:0] x, input [31:0] n);
        begin
            ROTR = (x >> n) | (x << (32-n));
        end
    endfunction

    function [31:0] SHR(input [31:0] x, input [31:0] n);
        begin
            SHR = x >> n;
        end
    endfunction

    function [31:0] SIG0(input [31:0] x);
        begin
            SIG0 = ROTR(x,7) ^ ROTR(x,18) ^ SHR(x,3);
        end
    endfunction

    function [31:0] SIG1(input [31:0] x);
        begin
            SIG1 = ROTR(x,17) ^ ROTR(x,19) ^ SHR(x,10);
        end
    endfunction

    // ---------------- Sigma outputs ----------------
    assign sigma_0 = SIG0(bufrd_t16_in);
    assign sigma_1 = SIG1(bufrd_t16_in);

    // ---------------- Wide adders (avoid overflow warnings) ----------------
   /* wire [33:0] w0_wide;
    wire [33:0] w1_wide;
    wire [33:0] w2_wide;
    wire [33:0] w3_wide;

    assign w0_wide = SIG1(bufrd_t2_in)  + bufrd_t7_in  +
                     SIG0(bufrd_t15_in) + bufrd_t16_in;

    assign w1_wide = SIG1(bufrd_t1_in)  + bufrd_t6_in  +
                     SIG0(bufrd_t14_in) + bufrd_t15_in;

    assign w2_wide = SIG1(w0_out)       + bufrd_t5_in  +
                     SIG0(bufrd_t13_in) + bufrd_t14_in;

    assign w3_wide = SIG1(w1_out)       + bufrd_t4_in  +
                     SIG0(bufrd_t12_in) + bufrd_t13_in;

    // ---------------- Final outputs (mod 2^32) ----------------
    assign w0_out = (t_in < 7'd16) ? bufrd_t16_in : w0_wide[31:0];
    assign w1_out = (t_in < 7'd16) ? bufrd_t15_in : w1_wide[31:0];
    assign w2_out = (t_in < 7'd16) ? bufrd_t14_in : w2_wide[31:0];
    assign w3_out = (t_in < 7'd16) ? bufrd_t13_in : w3_wide[31:0];*/

wire [33:0] w0_wide;
wire [33:0] w1_wide;
wire [33:0] w2_wide;
wire [33:0] w3_wide;


wire [31:0] w0_int;
wire [31:0] w1_int;
wire [31:0] w2_int;
wire [31:0] w3_int;

assign w0_wide = SIG1(bufrd_t2_in) + bufrd_t7_in +
                 SIG0(bufrd_t15_in) + bufrd_t16_in;

assign w1_wide = SIG1(bufrd_t1_in) + bufrd_t6_in +
                 SIG0(bufrd_t14_in) + bufrd_t15_in;

assign w2_wide = SIG1(w0_int) + bufrd_t5_in +
                 SIG0(bufrd_t13_in) + bufrd_t14_in;

assign w3_wide = SIG1(w1_int) + bufrd_t4_in +
                 SIG0(bufrd_t12_in) + bufrd_t13_in;

assign w0_int = (t_in < 7'd16) ? bufrd_t16_in : w0_wide[31:0];
assign w1_int = (t_in < 7'd16) ? bufrd_t15_in : w1_wide[31:0];
assign w2_int = (t_in < 7'd16) ? bufrd_t14_in : w2_wide[31:0];
assign w3_int = (t_in < 7'd16) ? bufrd_t13_in : w3_wide[31:0];

assign w0_out = w0_int;
assign w1_out = w1_int;
assign w2_out = w2_int;
assign w3_out = w3_int;


endmodule

