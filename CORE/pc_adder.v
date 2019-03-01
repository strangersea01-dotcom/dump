/*module pc_add#(parameter XLEN = 32)
		(input [XLEN-1:0] pc_next,
		 output  [XLEN-1:0] pc_in);


assign pc_in = pc_next + 4;

endmodule*/

module pc_add #(parameter XLEN = 32)
(
    input  [XLEN-1:0] pc_next,
    output [XLEN-1:0] pc_in
);

    wire [XLEN:0] pc_in_wide;

    assign pc_in_wide = pc_next + {{(XLEN-3){1'b0}}, 3'b100}; // +4
    assign pc_in      = pc_in_wide[XLEN-1:0];

endmodule

