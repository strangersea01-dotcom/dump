/*	module bit_ror #(parameter XLEN =32,

			parameter integer SHAMT = $clog2(XLEN))
		(input [XLEN-1:0] rs1,
		 input [XLEN-1:0] rs2,
		 output[XLEN-1:0] ror_result);

		
		wire [SHAMT-1:0] shamt;

		assign shamt = rs2[SHAMT-1:0];

	assign ror_result = ((rs1 >> shamt) | (rs1 << ( XLEN-shamt)));
endmodule*/

/*module bit_ror #(
    parameter XLEN = 32,
    parameter integer SHAMT = $clog2(XLEN)
)(
    input  [XLEN-1:0] rs1,
    input  [XLEN-1:0] rs2,
    output [XLEN-1:0] ror_result
);

    wire [SHAMT-1:0] shamt;

    wire [XLEN-1:0] rshift_w;
    wire [XLEN-1:0] lshift_w;

    assign shamt    = rs2[SHAMT-1:0];
    assign rshift_w = rs1 >> shamt;
    assign lshift_w = rs1 << (XLEN - shamt);

    assign ror_result = rshift_w | lshift_w;

endmodule*/

module bit_ror #(
    parameter XLEN = 32,
    parameter integer SHAMT_W = $clog2(XLEN)
)(
    input  [XLEN-1:0] rs1,
    input  [XLEN-1:0] rs2,
    output [XLEN-1:0] ror_result
);

    wire [SHAMT_W-1:0] shamt;

    wire [XLEN-1:0] rshift_w;
    wire [XLEN-1:0] lshift_w;
    wire [XLEN:0]   lshift_wide;   // widened to avoid overflow

    // shift amount
    assign shamt = rs2[SHAMT_W-1:0];

    // right shift (safe)
    assign rshift_w = rs1 >> shamt;

    // left shift with explicit widening (FIX for ASG_NR_POVF)
    assign lshift_wide = {1'b0, rs1} << (XLEN - shamt);
    assign lshift_w    = lshift_wide[XLEN-1:0];

    // rotate right
    assign ror_result = rshift_w | lshift_w;

endmodule


