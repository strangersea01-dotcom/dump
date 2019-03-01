module mux#(parameter WIDTH = 128)
            (input [WIDTH-1:0] in1,
             input [WIDTH-1:0] in2,
             input [WIDTH-1:0] in3,
             input [1:0] mux_sel, 
             output reg[WIDTH-1:0] mux_out);

  always@(in1 or in2 or in3 or mux_sel)begin
      case(mux_sel)
          2'b00 : begin mux_out = in1; end
          2'b01 : begin mux_out = in2; end
          2'b10 : begin mux_out = in3; end
		default mux_out = 128'dx;
      endcase
  end
  endmodule

/*module mux #(
    parameter WIDTH = 128
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [WIDTH-1:0] in3,
    input  wire [1:0]       mux_sel,
    output wire [WIDTH-1:0] mux_out
);

assign mux_out =
       (mux_sel == 2'b00) ? in1 :
       (mux_sel == 2'b01) ? in2 :
       (mux_sel == 2'b10) ? in3 :
                            {WIDTH{1'b0}};

endmodule*/



