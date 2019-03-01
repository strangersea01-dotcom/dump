module xor_op#(parameter WIDTH = 128)
        (input [WIDTH-1:0] a,
         input [WIDTH-1:0] b,
         output[WIDTH-1:0] x_out);

     assign x_out = a ^ b;
     endmodule
