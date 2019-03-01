module hazard_unit(rst, regwritem, regwritew , rd_m,rd_w,rs1_e,rs2_e,forwardae, forwardbe);
input rst;
input [4:0] rd_m,rd_w,rs1_e,rs2_e;
output [1:0] forwardae, forwardbe;

assign forwardae = (rst == 1'b0) ? 2'b00 :
                   ((regwritem == 1'b1) & (rd_m != 5'h00) & (rd_m == rs1_e)) ? 2'b10 :
                   ((regwritew == 1'b1) & (rd_w != 5'h00) & (rd_w == rs1_e)) ? 2'b01 : 2'b00 ;

assign forwardbe = (rst == 1'b0) ? 2'b00 :
                   ((regwritem == 1'b1) & (rd_m != 5'h00) & (rd_m == rs2_e)) ? 2'b10 :
                   ((regwritew == 1'b1) & (rd_w != 5'h00) & (rd_w == rs2_e)) ? 2'b01 : 2'b00 ;
               
endmodule

