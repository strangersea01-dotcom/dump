module gpr ( input clk,
             input rst,
             input [4:0] rs1_addr,
             input [4:0] rs2_addr,
             input [4:0] rd_addr,
             input reg_write,
             input [31:0] write_data,
             output [31:0] rs1_data,
             output [31:0] rs2_data);
		
//	integer i;
         reg[31:0] mem[0:31];

        initial begin
             $readmemh("gpr.hex",mem);
         end

         assign rs1_data = mem[rs1_addr];
         assign rs2_data = mem[rs2_addr];

        // always@(posedge clk or posedge rst)
       /*  begin
             if(rst)
                    begin
                           for(i = 0 ; i <= 31 ; i = i +1)
                           begin
                               mem[i] <= 32'b0;
                           end
                    end
             else
                    begin
                        if(reg_write && rd_addr != 5'd0)
                        begin
                            mem[rd_addr] = write_data;
                        end
                    end
                end*/

               always@(posedge clk or posedge rst)
               begin
                    if(rst)
                            begin
			//	for(i = 0 ; i < 32 ; i = i + 1)
                                mem[rd_addr] <= 32'b0;
                            end
                     else 
                     begin
                            if(reg_write)
                                    begin
                                        mem[rd_addr ] <= write_data;
                                    end
                            
                     end
               end
         endmodule

