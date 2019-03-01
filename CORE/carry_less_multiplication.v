/*module carry_less_mul#
(
    parameter WIDTH_IN  = 128,
    parameter WIDTH_OUT = 256
)
(
    input wire clk,
    input wire rst,
    input wire [WIDTH_IN-1:0] x,
    input wire  [WIDTH_IN-1:0] y,
    output wire [WIDTH_OUT-1:0] carry_less_out
);

    reg [WIDTH_OUT-1:0] temp;
    reg [WIDTH_OUT-1:0] seq_temp;
    integer i;

   
    always@(posedge clk or posedge rst)
	begin
		if(rst)
			begin
			seq_temp <= {WIDTH_OUT{1'b0}} ;
			end
		else
			begin
			seq_temp <= temp;
			end
	end
	

    always @(x or y or seq_temp ) begin
        temp = {WIDTH_OUT{1'b0}};

        // Polynomial multiply: for each set bit in y (LSB index 0),
        // XOR a shifted copy of x into the 256-bit accumulator.
        for (i = 0; i < WIDTH_IN; i = i + 1) begin
            if (y[i]) begin
                // shift x left by i bits, and XOR into temp
                temp = seq_temp ^ ( { {WIDTH_IN{1'b0}}, x } << i );
            end
        end
    end

    assign carry_less_out = temp;

endmodule*/

/*module carry_less_mul #(
    parameter WIDTH_IN  = 128,
    parameter WIDTH_OUT = 256
)(
    input  wire [WIDTH_IN-1:0]  x,
    input  wire [WIDTH_IN-1:0]  y,
    output reg  [WIDTH_OUT-1:0] carry_less_out
);

    reg [WIDTH_OUT-1:0] acc;
    integer i;

    always @(x or y) begin
        // local accumulator
        acc = {WIDTH_OUT{1'b0}};

        // GF(2) carry-less multiplication
        for (i = 0; i < WIDTH_IN; i = i + 1) begin
            if (y[i]) begin
                acc[i +: WIDTH_IN] = acc[i +: WIDTH_IN] ^ x;
            end
        end

        carry_less_out = acc;
    end

endmodule*/

module carry_less_mul
#(
    parameter WIDTH_IN  = 128,
    parameter WIDTH_OUT = 256
)
(
    input  [WIDTH_IN-1:0]   x,
    input  [WIDTH_IN-1:0]   y,
    output reg [WIDTH_OUT-1:0] carry_less_out
);

    reg [WIDTH_OUT-1:0] acc;
    integer i;
    integer j;

    always @(x or y) begin
        // initialize accumulator
        acc = {WIDTH_OUT{1'b0}};

        // carry-less multiplication
        for (i = 0; i < WIDTH_IN; i = i + 1) begin
            if (y[i]) begin
                for (j = 0; j < WIDTH_IN; j = j + 1) begin
                    acc[i + j] = acc[i + j] ^ x[j];
                end
            end
        end

        carry_less_out = acc;
    end

endmodule



