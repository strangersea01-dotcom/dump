

module tb_carry_less_mul;
  parameter XLEN = 32;
  reg  [XLEN-1:0] rs1, rs2;
  wire [2*XLEN-1:0] carry_less_mul_out;

  // Instantiate DUT
  carry_less_mul #(XLEN) dut (
    .rs1(rs1),
    .rs2(rs2),
    .carry_less_mul_out(carry_less_mul_out)
  );

  // Expected output calculation (reference model)
  reg [2*XLEN-1:0] expected;
  integer i;

  initial begin
    // Test 1
    rs1 = 32'h0000_0003;   // binary: 11
    rs2 = 32'h0000_0005;   // binary: 101
    #1;
    expected = 0;
    for(i=0; i<XLEN; i=i+1) begin
      if(rs2[i]) expected = expected ^ (rs1 << i);
    end
    $display("Test1: rs1=%h rs2=%h", rs1, rs2);
    $display("Expected=%h, Got=%h", expected, carry_less_mul_out);

    // Test 2
    rs1 = 32'h0000_00F0;   // binary: 11110000
    rs2 = 32'h0000_000F;   // binary: 1111
    #1;
    expected = 0;
    for(i=0; i<XLEN; i=i+1) begin
      if(rs2[i]) expected = expected ^ (rs1 << i);
    end
    $display("Test2: rs1=%h rs2=%h", rs1, rs2);
    $display("Expected=%h, Got=%h", expected, carry_less_mul_out);

    // Test 3 (random)
    rs1 = 32'hA5A5_A5A5;
    rs2 = 32'h5A5A_5A5A;
    #1;
    expected = 0;
    for(i=0; i<XLEN; i=i+1) begin
      if(rs2[i]) expected = expected ^ (rs1 << i);
    end
    $display("Test3: rs1=%h rs2=%h", rs1, rs2);
    $display("Expected=%h, Got=%h", expected, carry_less_mul_out);

    $finish;
  end

endmodule

