module top#
(
    parameter WIDTH = 128
)
(
  //  input clk,
  //  input rst,
    input  [WIDTH-1:0] x,   // operand A
    input  [WIDTH-1:0] y,   // operand B
    output [WIDTH-1:0] gf_out  // reduced product (128-bit)
);

    wire [2*WIDTH-1:0] w1;

    carry_less_mul #(.WIDTH_IN(WIDTH), .WIDTH_OUT(2*WIDTH)) cmul
    (
//	.clk(clk),
//	.rst(rst),
        .x(x),
        .y(y),
        .carry_less_out(w1)
    );

    reduction #(.WIDTH_IN(2*WIDTH), .WIDTH_OUT(WIDTH)) reduction_u
    (
        .reduction_in(w1),
        .reduction_out(gf_out)
    );

endmodule

                        
