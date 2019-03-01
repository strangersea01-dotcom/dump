module pc_top_tb;
	reg clk;
	reg rst;
	wire[31:0] pc_out;

pc_top dut(.clk(clk),
	   .rst(rst),
	   .pc_out(pc_out));

initial begin
	$shm_open("pc_top.shm");
	$shm_probe("ACTMF");
end

always begin
	clk = 1'b0;
	forever #5 clk = ~clk;
end
initial begin
		rst = 1'b1;
#20
		rst = 1'b0;
#200
$finish();
end
endmodule
