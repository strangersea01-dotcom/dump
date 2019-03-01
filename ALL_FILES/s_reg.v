module s_reg#(parameter WIDTH =128)
              (   input clk,
                  input rst,
                  input s_en,
                  input [WIDTH-1:0] s_data,
                  output reg [WIDTH-1:0] s_out);


 always@(posedge clk or posedge rst)begin
     if(rst)begin
         s_out <= {WIDTH{1'b0}};
     end
     else if(s_en) begin
         s_out <= s_data;
                end
    end
 endmodule
