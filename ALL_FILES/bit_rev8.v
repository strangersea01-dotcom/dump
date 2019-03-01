module bit_rev8 #(parameter XLEN =32)
    (input   [XLEN-1:0] rs1,
    output  [XLEN-1:0] rev_result
);

assign rev_result = {rs1[7:0],rs1[15:8],rs1[23:16],rs1[31:24]};

endmodule
