/*module mix_op (
    input  wire [31:0] in_word,
    output wire [31:0] out_word
);

wire [7:0] b0 = in_word[31:24];
wire [7:0] b1 = in_word[23:16];
wire [7:0] b2 = in_word[15:8];
wire [7:0] b3 = in_word[7:0];

wire [7:0] sb0, sb1, sb2, sb3;  
    
wire [7:0] temp;
wire [7:0] t0, t1, t2, t3;
wire [7:0] u0, u1, u2, u3;

assign temp = b0 ^ b1 ^ b2 ^ b3;

assign t0 = b0 ^ b1;
assign t1 = b1 ^ b2;
assign t2 = b2 ^ b3;
assign t3 = b3 ^ b0;

assign u0 = (t0[7] == 1'b0) ? (t0 << 1) : ((t0 << 1) ^ 8'h1b);
assign u1 = (t1[7] == 1'b0) ? (t1 << 1) : ((t1 << 1) ^ 8'h1b);
assign u2 = (t2[7] == 1'b0) ? (t2 << 1) : ((t2 << 1) ^ 8'h1b);
assign u3 = (t3[7] == 1'b0) ? (t3 << 1) : ((t3 << 1) ^ 8'h1b);


wire [8:0] t0_sh, t1_sh, t2_sh, t3_sh;

assign t0_sh = (t0 << 1) ^ (t0[7] ? 9'h11b : 9'h000);
assign t1_sh = (t1 << 1) ^ (t1[7] ? 9'h11b : 9'h000);
assign t2_sh = (t2 << 1) ^ (t2[7] ? 9'h11b : 9'h000);
assign t3_sh = (t3 << 1) ^ (t3[7] ? 9'h11b : 9'h000);



wire [8:0] t0_sh, t1_sh, t2_sh, t3_sh;

assign t0_sh = ({1'b0, t0} << 1) ^ (t0[7] ? 9'h11b : 9'h000);
assign t1_sh = ({1'b0, t1} << 1) ^ (t1[7] ? 9'h11b : 9'h000);
assign t2_sh = ({1'b0, t2} << 1) ^ (t2[7] ? 9'h11b : 9'h000);
assign t3_sh = ({1'b0, t3} << 1) ^ (t3[7] ? 9'h11b : 9'h000);


assign u0 = t0_sh[7:0];
assign u1 = t1_sh[7:0];
assign u2 = t2_sh[7:0];
assign u3 = t3_sh[7:0];


assign sb0 = b0 ^ u0 ^ temp;
assign sb1 = b1 ^ u1 ^ temp;
assign sb2 = b2 ^ u2 ^ temp;
assign sb3 = b3 ^ u3 ^ temp;

assign out_word = {sb0, sb1, sb2, sb3};

endmodule*/

module mix_op (
    input  wire [31:0] in_word,
    output wire [31:0] out_word
);

    // One AES column (4 bytes)
    assign out_word[31:24] = mixcolumn32(in_word[31:24], in_word[23:16], in_word[15:8],  in_word[7:0]);
    assign out_word[23:16] = mixcolumn32(in_word[23:16], in_word[15:8],  in_word[7:0],   in_word[31:24]);
    assign out_word[15:8]  = mixcolumn32(in_word[15:8],  in_word[7:0],   in_word[31:24], in_word[23:16]);
    assign out_word[7:0]   = mixcolumn32(in_word[7:0],   in_word[31:24], in_word[23:16], in_word[15:8]);

    // --------------------------------------------------
    // SAME FUNCTION AS YOUR 128-BIT IMPLEMENTATION
    // --------------------------------------------------
    function [7:0] mixcolumn32;
        input [7:0] i1, i2, i3, i4;
        begin
            mixcolumn32[7] = i1[6] ^ i2[6] ^ i2[7] ^ i3[7] ^ i4[7];
            mixcolumn32[6] = i1[5] ^ i2[5] ^ i2[6] ^ i3[6] ^ i4[6];
            mixcolumn32[5] = i1[4] ^ i2[4] ^ i2[5] ^ i3[5] ^ i4[5];
            mixcolumn32[4] = i1[3] ^ i1[7] ^ i2[3] ^ i2[4] ^ i2[7] ^ i3[4] ^ i4[4];
            mixcolumn32[3] = i1[2] ^ i1[7] ^ i2[2] ^ i2[3] ^ i2[7] ^ i3[3] ^ i4[3];
            mixcolumn32[2] = i1[1] ^ i2[1] ^ i2[2] ^ i3[2] ^ i4[2];
            mixcolumn32[1] = i1[0] ^ i1[7] ^ i2[0] ^ i2[1] ^ i2[7] ^ i3[1] ^ i4[1];
            mixcolumn32[0] = i1[7] ^ i2[7] ^ i2[0] ^ i3[0] ^ i4[0];
        end
    endfunction

endmodule



