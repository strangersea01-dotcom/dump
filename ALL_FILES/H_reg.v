module h_reg#(parameter WIDTH =128)
              (   input clk,
                  input rst,
                  input h_en,
                  input [WIDTH-1:0] h_data,
                  output reg [WIDTH-1:0] h_out);


 always@(posedge clk or posedge rst)begin
     if(rst)begin
         h_out <= {WIDTH{1'b0}};
     end
     else if(h_en) begin
         h_out <= h_data;
                end
     end
 endmodule
