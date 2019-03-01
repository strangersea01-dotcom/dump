module ghash_main_top#(parameter WIDTH =128)
            
        (  input clk,
           input rst,
           input start,
           input aad_empty,
           input cipher_empty,
           input length_empty,

           input [WIDTH-1:0] h_reg_data,
           input [WIDTH-1:0] aad_data,
           input [WIDTH-1:0] cipher_text,
           input [WIDTH-1:0] length_data,

           output [WIDTH-1:0] tag,
           output done
       );


       wire h_reg_en_w,ac_reg_en_w, ac_clr_w,s_reg_en_w;
       wire[1:0] mux_sel_w;

ghash_controller contoller_path (

       .clk(clk),
       .rst(rst),
        .start(start),
        .aad_empty(aad_empty),
        .cipher_empty(cipher_empty),
        .length_empty(length_empty),
                         
        .h_reg_en(h_reg_en_w),
        .mux_sel(mux_sel_w),
        .ac_reg_en(ac_reg_en_w),
        .ac_clr(ac_clr_w),
        .s_reg_en(s_reg_en_w),
        .done(done)
    );


ghash_top_datapath #(.WIDTH(WIDTH)) data_path (

        .clk(clk),       
        .rst(rst),
        .h_reg_data(h_reg_data),
        .h_reg_en(h_reg_en_w),
        .aad_data(aad_data),
        .cipher_text(cipher_text),
        .length_data(length_data),
        .mux_sel(mux_sel_w),
        .ac_reg_en(ac_reg_en_w),
        .ac_clr(ac_clr_w),
        .s_reg_en(s_reg_en_w),
        .s_reg_out(tag)
    );

    
    endmodule

