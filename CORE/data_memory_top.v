module data_memory_top (input [7:0] addr,
			input clk,
			input rst,
			input [31:0] write_data,
                        input data_write_en,
                        output [31:0] data_out);

 wire[7:0] b0,b1,b2,b3;
 

 data_memory d1(.addr(addr[7:0]),
		.clk(clk),
		.rst(rst),
		.write_data(write_data[7:0]),
                .dout(b0));

data_memory d2(.addr(addr[7:0]),
		.clk(clk),
		.rst(rst),
		.write_data(write_data[15:8]),
                .dout(b1));

data_memory d3(.addr(addr[7:0]),
		.clk(clk),
		.rst(rst),
		.write_data(write_data[23:16]),

                .dout(b2));

data_memory d4(.addr(addr[7:0]),
		.clk(clk),
		.rst(rst),
		.write_data(write_data[31:24]),
                .dout(b3));


wire [31:0] mem_word = {b3,b2,b1,b0};

assign data_out = (data_write_en)?mem_word : 32'b0;

endmodule
