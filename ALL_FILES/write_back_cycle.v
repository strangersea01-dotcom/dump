module write_back_cycle( input clk,
                         input rst,
                         input data_sel_mux_wb,
                         input[4:0] rd_addr_in,
                         input  reg_write_en,
                         input [31:0] alu_in,
                         input [31:0] data_write,
                         output reg [31:0] alu_out,
                         output reg [31:0] data_write_out,
                        // output reg mux_sel_out,
                          output reg[4:0] rd_addr_out,
                         output reg reg_write_en_out,
                        output reg data_sel_mux_out_wb);

                     always@(posedge clk or posedge rst)
                     begin
                            if(rst)
                            begin
                                alu_out <= 32'b0;
                                data_write_out <= 32'b0;
                               // mux_sel <= 1'b0;
                                rd_addr_out <= 5'b0;
                                reg_write_en_out <= 1'b0;
                                data_sel_mux_out_wb <= 1'b0;
                            end
                            else
                            begin
                                alu_out <= alu_in;
                                data_write_out <= data_write;
                              //  mux_sel_out <= mux_sel;
                                rd_addr_out <=rd_addr_in;
                                reg_write_en_out <=reg_write_en ;
                                data_sel_mux_out_wb <=data_sel_mux_wb; 

                            end

                     end
                     endmodule



