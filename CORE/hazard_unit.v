module forward_unit(rst, regwritem, regwritew, rd_m, rd_w,rs1_d,rs2_d,forwarda,forwardb);
input rst,regwritem,regwritew;
input[4:0] rd_m,rd_w,rs1_d,rs2_d;
output[1:0] forwarda,forwardb;

assign forwarda = (rst == 1'b0) ? 2'b00 : 
                  ((regwritem == 1'b1) & (rd_m != 5'h00) & (rd_m == rs1_d)) ? 2'b10 :
                  ((regwritew == 1'b1) & (rd_w != 5'h00) & (rd_w == rs1_d)) ? 2'b01 : 2'b00;


assign forwardb = (rst == 1'b0) ? 2'b00 : 
                  ((regwritem == 1'b1) & (rd_m != 5'h00) & (rd_m == rs2_d)) ? 2'b10 :
                  ((regwritew == 1'b1) & (rd_w != 5'h00) & (rd_w == rs2_d)) ? 2'b01 : 2'b00;

              endmodule

