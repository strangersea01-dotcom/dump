module pc_tb;
	reg clk;
	reg rst;
	wire[31:0] pc_out;
                                       
                                                                              			    

	pc_top     dut(.clk(clk),
			      .rst(rst),
			.pc_out(pc_out));
    
                               

	initial begin
	$shm_open("pc_testing.shm");
	$shm_probe("ACTMF");
	end

	always begin
	clk = 1'b0;
	forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		#10
		rst = 1'b0;
#300
$finish();
	end
endmodule

