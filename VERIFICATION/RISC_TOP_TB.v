/*module riscv_scalar_cryptography_tb;
	reg clk;
	reg rst;
    reg [31:0] inst_write_en;
					wire [31:0] write_out;
wire [31:0] cycle_count;
wire [31:0] instr_count;
                                       
                                                                              			    

	riscv_scalar_cryptography_proscessor dut(.clk(clk),
			      .rst(rst),
                  .inst_write_en(inst_write_en),
                  .write_out(write_out),
                  .cycle_count(cycle_count),
                  .instr_count(instr_count)
			                        
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
	end

always @(posedge clk) begin
    if (dut.pc_inst_wire == 32'h00000040) begin

        $display("====================================");
        $display("Total Cycles       = %d", cycle_count);
        $display("Total Instructions = %d", instr_count);

        if (instr_count != 0)
            $display("CPI = %f", cycle_count * 1.0 / instr_count);
        else
            $display("CPI = Undefined");

        $display("====================================");

        $finish;
    end
end

//=========================================
// Timeout Safety
//=========================================
initial begin
    #5000;   // Stop if stuck
    $display("Simulation Timeout!");
    $finish;
end

endmodule*/

module riscv_scalar_cryptography_tb;

reg clk;
reg rst;
reg [31:0] inst_write_en;

wire [31:0] write_out;

//=====================================
// DUT
//=====================================
riscv_scalar_cryptography_proscessor dut(
    .clk(clk),
    .rst(rst),
    .inst_write_en(inst_write_en),
    .write_out(write_out));

//=====================================
// Waveform
//=====================================
initial begin
    $shm_open("riscv_wave_form.shm");
    $shm_probe("ACTMF");
end

//=====================================
// Clock (Correct)
//=====================================
initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 100MHz
end

//=====================================
// Reset
//=====================================
initial begin
    rst = 1'b1;
    inst_write_en = 32'b0;

    #20;
    rst = 1'b0;
#2000;
$finish();
end  // Run enough cycles

   endmodule















