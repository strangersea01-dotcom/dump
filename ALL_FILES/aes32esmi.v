module aes32esmi  #(parameter XLEN = 32)
                   (input [XLEN-1:0] rs1,
                    input [XLEN-1:0] rs2,
                    input byte_sel,
                    input [1:0] bytes,
                    output reg  [XLEN-1:0] aes32esmi_out);

reg [7:0] byte_in ;
wire [7:0] s_out;
//wire [31:0] sbox_out;
wire [31:0] mix_in ; //expand
wire [31:0] mix_out;
reg [31:0] roli;

always@(rs2 or byte_sel or bytes )
begin
            if(byte_sel)
            begin
               case(bytes)
                     2'b00 : byte_in = rs2[7:0];
                     2'b01 : byte_in = rs2[15:8];
                     2'b10 : byte_in = rs2[23:16];
                     2'b11 : byte_in = rs2[31:24];
                    // default : byte_in = 8'b0;
                endcase
            end
            else
            begin
                  byte_in = 8'b0;
            end
       
end

aes_sbox sbox(.in_byte(byte_in),
              .out_byte(s_out));

 assign mix_in = {s_out,24'b0};



mix_op mixcolumn(.in_word(mix_in),
                 .out_word(mix_out));


always@(rs1 or bytes or mix_out)
begin
             case(bytes)
                2'b00 : roli = mix_out;
                2'b01 : roli = {mix_out[23:0],mix_out[31:24]};
                2'b10 : roli = {mix_out[15:0],mix_out[31:16]};
                2'b11 : roli = {mix_out[7:0],mix_out[31:8]};
               // default : rol = mix_out;
            endcase

                    aes32esmi_out = rs1 ^ roli;

end         
 
endmodule
