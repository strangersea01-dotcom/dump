

module tb_crypto_engine;

    reg  [31:0] rs1;
    reg  [31:0] rs2;
    reg  [4:0]  alu_opcode;
    wire [31:0] bitmanipulation_out;

    // DUT
   bitmanipulation_XLEN32 dut (
        .rs1(rs1),
        .rs2(rs2),
        .alu_opcode(alu_opcode),
        .bitmanipulation_out(bitmanipulation_out)
    );

	initial begin
		$shm_open("crypto_engine.shm");
		$shm_probe("ACTMF");
	end

    initial begin
        $display("Time | alu_op | rs1        rs2        -> result");
        $display("------------------------------------------------");

        // -------------------------
        // Test 1: ROL by 4
        // -------------------------
        alu_opcode = 5'b00001;
        rs1 = 32'h12345678;
        rs2 = 32'd4;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);
        // Expected: 0x23456781

        // -------------------------
        // Test 2: ROL by 0
        // -------------------------
        alu_opcode = 5'b00010;
        rs1 = 32'hA5A5A5A5;
        rs2 = 32'd0;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);
        // Expected: same as rs1

        // -------------------------
        // Test 3: ROL by 8
        // -------------------------
        alu_opcode = 5'b00011;
        rs1 = 32'hDEADBEEF;
        rs2 = 32'd8;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);
        // Expected: 0xADBEEFDE

        // -------------------------
        // Test 4: ROL by 31
        // -------------------------
        alu_opcode = 5'b00100;
        rs1 = 32'h80000001;
        rs2 = 32'd31;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);
        // Expected: 0xC0000000

        // -------------------------
        // Test 5: Invalid opcode
        // -------------------------
        alu_opcode = 5'b00101;
        rs1 = 32'hFFFFFFFF;
        rs2 = 32'd4;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);
        // Expected: 0x00000000
        //
        // Test 5: Invalid opcode
        // -------------------------
        alu_opcode = 5'b00110;
        rs1 = 32'hFFFFFFFF;
        rs2 = 32'hAAAAAAAA;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);

	alu_opcode = 5'b00111;
        rs1 = 32'hFFFFFFFF;
        rs2 = 32'hAAAAAAAA;
        #10;
        $display("%4t | %b | %h  %h  -> %h",
                 $time, alu_opcode, rs1, rs2, bitmanipulation_out);

	alu_opcode = 5'b01000;
        rs1 = 32'hFFFFAAAA;
               #10;
        $display("%4t | %b | %h   -> %h",
                 $time, alu_opcode, rs1, bitmanipulation_out);

	alu_opcode = 5'b01001;
        rs1 = 32'hEEEEEEEE;
               #10;
        $display("%4t | %b | %h   -> %h",
                 $time, alu_opcode, rs1, bitmanipulation_out);



        $finish;
    end

endmodule

