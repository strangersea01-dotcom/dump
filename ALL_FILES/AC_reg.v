module ac_reg#(parameter WIDTH =128)
             
               (input clk,
               input rst,
               input ac_en,
               input clr_ac,
               input [WIDTH-1:0] ac_data_in,
               output reg [ WIDTH-1:0] ac_data_out);

 always@(posedge clk or posedge rst)begin
        
                if(rst)
                begin
                    ac_data_out <= {WIDTH{1'b0}};
                end
                else if(clr_ac) begin
                    ac_data_out <= {WIDTH{1'b0}}; 
                 end
                 else if(ac_en)begin
                     ac_data_out <= ac_data_in;
                 end
                end
 endmodule
