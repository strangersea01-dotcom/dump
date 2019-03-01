module instruction_memory_top#(parameter XLEN = 8, parameter OUT_XLEN = 32)
			      (input [XLEN-1:0] pc_addr,
				input clk,
				input rst,
				input [31:0] write_data,
			        output [31:0] inst_out_c
			      /* output reg[4:0] rs2_addr,
			       output reg[4:0] rs1_addr,
			       output reg [4:0] rd_addr,
			       output reg [6:0] func7,
				output reg [2:0] func3,
				output reg [6:0] opcode,
				output reg[11:0] imm*/);


wire[7:0] b0,b1,b2,b3;
//wire [31:0] inst_out;


im_mem0 im_memo0(.pc_addr(pc_addr),
		 .clk(clk),
		 .rst(rst),
		 .write_data(write_data[7:0]),
		 .byte_0_out(b0));


im_mem1  im_memo1(.pc_addr(pc_addr),
		   .clk(clk),
		 .rst(rst),
		 .write_data(write_data[15:8]),
		  .byte_1_out(b1));


im_mem2 im_memo2(.pc_addr(pc_addr),
		 .clk(clk),
		 .rst(rst),
		 .write_data(write_data[23:16]),
		 .byte_2_out(b2));



im_mem3  im_memo3(.pc_addr(pc_addr),
		.clk(clk),
		 .rst(rst),
		 .write_data(write_data[31:24]),
		  .byte_3_out(b3));


assign inst_out_c = {b3,b2,b1,b0};

/*always@( inst_out)
		begin
			if(inst_out == 32'b0)
				begin
				imm = 12'b0;
				func7 = 7'b0;
				rs2_addr = 5'b0;
				rs1_addr = 5'b0;
				func3 = 3'b0;
				rd_addr = 5'b0;
				opcode = 7'b0;
				end

			else if(inst_out[31:20] == 12'b011010000111 && inst_out[6:0] == 7'b0010011)
			begin
				func7 = 7'b0;
				imm = inst_out[31:20];
				rs2_addr = 5'b0;
				rs1_addr = inst_out[19:15];
				func3 = inst_out[14:12];
				rd_addr = inst_out[11:7];
				opcode  = inst_out[6:0];
			end
			else if (inst_out[31:20] == 12'b011010011000 && inst_out[6:0] == 7'b0010011)
			begin
				imm = inst_out[31:20];
				func7 = 7'b0;
				rs2_addr = 5'b0;
				rs1_addr = inst_out[19:15];
				func3 = inst_out[14:12];
				rd_addr = inst_out[11:7];
				opcode = inst_out[6:0];
			end
			else 
			begin
				imm = 12'b0;
				func7 = inst_out[31:25];
				rs2_addr = inst_out[24:20];
				rs1_addr = inst_out[19:15];
				func3 = inst_out[14:12];
				rd_addr = inst_out[11:7];
				opcode = inst_out[6:0];
			end
		end

assign  inst_out_c = inst_out;*/
endmodule

