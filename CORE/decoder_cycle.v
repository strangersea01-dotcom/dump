module decode_cycle(
                    input clk,
                    input rst,
		   // input sign_ext_en,
		    input[31:0] rs1_dc,
                    input[31:0] rs2_dc,
                    input[4:0] rd_addr_c,
                    input[4:0] rs1_addr,
                    input [4:0] rs2_addr,
                    input reg_write_en_dc,
                    input imm_sel_dc,
                    input data_write_en_dc,
                    input data_sel_mux_dc,
                    input [4:0] alu_opcode_dc,
                    input [1:0] alu_sel_mux_dc,
                    input byte_sel_dc,
                    input [1:0] bytes_dc,
                    input [31:0] imm_w,
                    output reg[31:0] rs1_data,
                    output reg[31:0] rs2_data,
                    output reg reg_write,
			output reg imm_sel,
			    	output reg data_write_en,
			    	output reg data_sel_mux,
			    	output reg [4:0] alu_opcode,
			    	output reg [1:0] alu_sel_mux,
                    output reg byte_sel,
                     output reg [1:0] bytes,
                     output reg [31:0] sign_out,
                     output reg [4:0] rd_addr_out,
                     output reg [4:0] rs1_addr_out,
                     output reg [4:0] rs2_addr_out
		 // output reg sign_ext_en_out
                    );

    always@(posedge clk or posedge rst)
    begin
            if(rst)
            begin
                 rs1_data <= 32'b0;
                 rs2_data <= 32'b0;
                 reg_write <= 1'b0;
                 imm_sel <= 1'b0;
                 data_write_en <= 1'b0;
                 data_sel_mux <= 1'b0;
                 alu_opcode <= 5'b0;
                 alu_sel_mux <= 2'b0;
                 byte_sel <= 1'b0;
                 bytes   <= 2'b0;
                 sign_out <= 32'b0;
                 rd_addr_out <= 5'b0;
                 rs1_addr_out <= 5'b0;
                 rs2_addr_out <= 5'b0;
		//	sign_ext_en_out <= 1'b0;
             end
             else
             begin

                 rs1_data <= rs1_dc;
                 rs2_data <= rs2_dc;
                 reg_write <= reg_write_en_dc;
                 imm_sel <= imm_sel_dc;
                 data_write_en <= data_write_en_dc;
                 data_sel_mux <= data_sel_mux_dc;
                 alu_opcode <= alu_opcode_dc;
                 alu_sel_mux <= alu_sel_mux_dc;
                 byte_sel   <= byte_sel_dc;
                 bytes     <= bytes_dc;
                 sign_out <= imm_w;
                 rd_addr_out <= rd_addr_c;
                 rs1_addr_out <= rs1_addr;
                 rs2_addr_out <= rs2_addr;
	//	sign_ext_en_out <= sign_ext_en;

             end 

            
    end
 endmodule           

                    
                    

                    
