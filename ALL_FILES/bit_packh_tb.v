module bit_rol_tb;
	reg [31:0] rs1;
	reg [31:0] rs2;
	wire [31:0] result;

bit_packh rol(.rs1(rs1),
	    .rs2(rs2),
	    .result(result));

initial begin
	$shm_open("bit_rol.shm");
	$shm_probe("ACTMF");
end 

initial begin
        // Monitor values
        $monitor("Time=%0t | rs1=%h rs2=%h | result=%h",
                  $time, rs1, rs2, result);

        // ----------------------------
        // Test case 1: Rotate by 4
        // ----------------------------
        rs1 = 32'h12345678;
        rs2 = 32'h00000004;
        #10;

        // Expected: 0x23456781

        // ----------------------------
        // Test case 2: Rotate by 0
        // ----------------------------
        rs1 = 32'hA5A5A5A5;
        rs2 = 32'h00000000;
        #10;

        // Expected: same as rs1

        // ----------------------------
        // Test case 3: Rotate by 8
        // ----------------------------
        rs1 = 32'hDEADBEEF;
        rs2 = 32'h00000008;
        #10;

        // ----------------------------
        // Test case 4: Rotate by 31
        // ----------------------------
        rs1 = 32'h80000001;
        rs2 = 32'h0000001F; // 31
        #10;

        // End simulation
        $finish;
    end


endmodule
