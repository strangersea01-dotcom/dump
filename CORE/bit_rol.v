/*module bit_rol#(parameter XLEN = 32,
		parameter integer SHAMT = $clog2(XLEN))

		(input [XLEN-1:0] rs1,
		 input [XLEN-1:0] rs2,
		 output[XLEN-1:0] rol_result);

	

		wire [SHAMT-1:0] shamt;
		
	       assign shamt = rs2[SHAMT-1 :0];

	       assign rol_result = ((rs1 << shamt) | ( rs1 >> (XLEN - shamt)));
		
			
endmodule*/

module bit_rol #(
    parameter XLEN = 32,
    parameter integer SHAMT_W = $clog2(XLEN)
)(
    input  [XLEN-1:0] rs1,
    input  [XLEN-1:0] rs2,
    output [XLEN-1:0] rol_result
);

    wire [SHAMT_W-1:0] shamt;

    wire [XLEN-1:0] lshift_w;
    wire [XLEN-1:0] rshift_w;

    assign shamt    = rs2[SHAMT_W-1:0];
    assign lshift_w = rs1 << shamt;
    assign rshift_w = rs1 >> (XLEN - shamt);

    assign rol_result = lshift_w | rshift_w;

endmodule

		
