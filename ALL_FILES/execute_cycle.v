module execute_cycle(input clk,
                     input rst,
		   // input sign_ext_in,
		 //  input [11:0] sign_in,
                     input data_sel_mux_in,
                     input reg_write_en_ex,
                     input [4:0] rd_in,
                     input [31:0] alu_in,
                     input [31:0] rs2_in,
                     input data_write_en,
                     output reg [31:0] alu_out,
                     output reg data_write_en_ex,
                     output reg[31:0] rs2_ex,
                     output reg [4:0] rd_out_addr,
                     output reg reg_write_en,
                     output reg data_sel_mux_ec);
		    // output reg sign_ext_out,
		    // output reg [11:0] sign_out );


                 always@(posedge clk or posedge rst)
                 begin
                        if(rst)
                        begin
                            alu_out <= 32'b0;
                            data_write_en_ex <= 1'b0;
                            rs2_ex <= 32'b0;
                            rd_out_addr <= 5'b0;
                            reg_write_en <= 1'b0;
                            data_sel_mux_ec <= 1'b0;
			   


                        end
                        else
                        begin
                              alu_out <= alu_in;
                              rs2_ex <= rs2_in;
                              data_write_en_ex <= data_write_en;
                              rd_out_addr <= rd_in;
                              reg_write_en <= reg_write_en_ex;
                              data_sel_mux_ec <= data_sel_mux_in;
			     
			      

                        end
                 end
                 endmodule

