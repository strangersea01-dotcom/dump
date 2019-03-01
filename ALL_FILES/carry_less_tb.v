module tb_carry_engine;

    reg  [31:0] rs1;
    reg  [31:0] rs2;
    reg  [4:0]  alu_opcode;
    wire [31:0] carry_less_mul_out;

    // DUT
   carry_less_mul_top #(.XLEN(32)) dut (
        .rs1(rs1),
        .rs2(rs2),
        .alu_opcode(alu_opcode),
        .carry_less_mul_out(carry_less_mul_out)
    );

	initial begin
		$shm_open("carry_less_mul.shm");
		$shm_probe("ACTMF");
	end

    initial begin
        $display("Time | alu_op | rs1        rs2        -> result");
        $display("------------------------------------------------");

        // -------------------------
        // Test 1: ROL by 4
        // -------------------------
        alu_opcode = 5'b01010;
        rs1 = 32'h12345678;
        rs2 = 32'd4;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, carry_less_mul_out);
        // Expected: 0x23456781

        // -------------------------
        // Test 2: ROL by 0
        // -------------------------
        alu_opcode = 5'b01100;
        rs1 = 32'hA5A5A5A5;
        rs2 = 32'hABABABAB;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, carry_less_mul_out);
        // Expected: same as rs1

        // -------------------------
        // Test 3: ROL by 8
        // -------------------------
       

        $finish;
    end

endmodule

