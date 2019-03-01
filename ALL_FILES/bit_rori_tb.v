module bit_rol_tb;
	reg [31:0] rs1;
	reg [31:0] imm;
	wire [31:0] result;

bit_rori rol(.rs1(rs1),
	    .imm(imm),
	    .result(result));


initial begin
        // Monitor values
        $monitor("Time=%0t | rs1=%h imm=%h | result=%h",
                  $time, rs1, imm, result);

        // ----------------------------
        // Test case 1: Rotate by 4
        // ----------------------------
        rs1 = 32'h12345678;
        imm = 32'h00000004;
        #10;

        // Expected: 0x23456781

        // ----------------------------
        // Test case 2: Rotate by 0
        // ----------------------------
        rs1 = 32'hA5A5A5A5;
        imm = 32'h00000000;
        #10;

        // Expected: same as rs1

        // ----------------------------
        // Test case 3: Rotate by 8
        // ----------------------------
        rs1 = 32'hDEADBEEF;
        imm = 32'h00000008;
        #10;

        // ----------------------------
        // Test case 4: Rotate by 31
        // ----------------------------
        rs1 = 32'h80000001;
        imm = 32'h0000001F; // 31
        #10;

        // End simulation
        $finish;
    end


endmodule
