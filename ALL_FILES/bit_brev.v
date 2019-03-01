module bit_brev8 #(parameter XLEN =32)
    (input   [XLEN-1:0] rs1,
    output  [XLEN-1:0] brev_result
);

    
    assign brev_result[7:0]   = { rs1[0], rs1[1], rs1[2], rs1[3],
                             rs1[4], rs1[5], rs1[6], rs1[7] };

   
    assign brev_result[15:8]  = { rs1[8], rs1[9], rs1[10], rs1[11],
                             rs1[12], rs1[13], rs1[14], rs1[15] };

    
    assign brev_result[23:16] = { rs1[16], rs1[17], rs1[18], rs1[19],
                             rs1[20], rs1[21], rs1[22], rs1[23] };

    
    assign brev_result[31:24] = { rs1[24], rs1[25], rs1[26], rs1[27],
                             rs1[28], rs1[29], rs1[30], rs1[31] };

endmodule

