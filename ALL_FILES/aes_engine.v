module aes_engine#(parameter XLEN =32)
                   (input [XLEN-1:0] rs1,
                    input [XLEN-1:0] rs2,
                    input [1:0]  bytes,
                    input  byte_sel,
                    input [4:0] alu_opcode,
                    output reg [XLEN-1:0] aes_out);

wire[31:0] aes32esi_w,aes32esmix_w;

  aes32esi aes32sbox(.rs1(rs1),
                     .rs2(rs2),
                     .byte_sel(byte_sel),
                     .bytes(bytes),
                     .aes32esi_out(aes32esi_w));

  aes32esmi aes32smix(.rs1(rs1),
                      .rs2(rs2),
                      .byte_sel(byte_sel),
                      .bytes(bytes),
                      .aes32esmi_out(aes32esmix_w));

  always@(alu_opcode or aes32esi_w or aes32esmix_w )
  begin
        case(alu_opcode)
               5'b01111 : aes_out = aes32esi_w;
               5'b10000 : aes_out = aes32esmix_w;
               default : aes_out = 32'b0;
        endcase
                
  end
  endmodule
