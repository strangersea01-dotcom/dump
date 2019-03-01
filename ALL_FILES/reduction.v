module reduction#
(
    parameter WIDTH_IN  = 256,
    parameter WIDTH_OUT = 128
)
(
    input  [WIDTH_IN-1:0] reduction_in,
    output [WIDTH_OUT-1:0]  reduction_out
);

    // Working copy of product (we will fold high bits down)
    reg [WIDTH_IN-1:0] t;
    integer i;

    always @(reduction_in) begin
        // start with full product
        t = reduction_in;

        // iterate from most-significant bit down to 128
        // whenever a high bit t[i] is 1, fold it:
        // x^{i}  -> x^{i-128} * (x^7 + x^2 + x + 1)
        for (i = WIDTH_IN-1; i >= WIDTH_OUT; i = i - 1) begin
            if (t[i]) begin
                // clear the bit being folded
                t[i] = 1'b0;

                // XOR the reduction polynomial shifted to (i-128)
                // targets: (i-128) + {0,1,2,7}
                t[i - WIDTH_OUT + 0] = t[i - WIDTH_OUT + 0] ^ 1'b1;
                t[i - WIDTH_OUT + 1] = t[i - WIDTH_OUT + 1] ^ 1'b1;
                t[i - WIDTH_OUT + 2] = t[i - WIDTH_OUT + 2] ^ 1'b1;
                t[i - WIDTH_OUT + 7] = t[i - WIDTH_OUT + 7] ^ 1'b1;
            end
        end
    end

    // result is low 128 bits after folding
    assign reduction_out = t[WIDTH_OUT-1:0];

endmodule
