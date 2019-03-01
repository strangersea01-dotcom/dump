module riscv_scalar_cryptography_tb;
	reg clk;
	reg rst;
    reg [31:0] inst_write_en;
				//	wire [31:0] write_out;

                                       
                                                                              			    

	riscv_scalar_cryptography_proscessor dut(.clk(clk),
			      .rst(rst),
                  .inst_write_en(inst_write_en)
                 // .write_out(write_out)
			                        
                  );
    
                               

	initial begin
	$shm_open("riscv_wave_form.shm");
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














