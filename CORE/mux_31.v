module mux31(input[31:0] bit_mani_in,
             input[31:0] carry_less_in,
             input[31:0] aes_in,
             input[31:0] sha_in,
             input[1:0] mux_sel_alu,
             output [31:0] alu_out);

         assign alu_out = (mux_sel_alu == 2'b00) ? bit_mani_in : 
                          (mux_sel_alu == 2'b01) ? carry_less_in : 
                          (mux_sel_alu == 2'b10) ? aes_in :
                          (mux_sel_alu == 2'b11) ? sha_in : 
                          32'b0;

                           endmodule
