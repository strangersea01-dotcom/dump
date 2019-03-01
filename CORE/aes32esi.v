module aes32esi #(parameter XLEN = 32)
                   (input [XLEN-1:0] rs1,
                    input [XLEN-1:0] rs2,
                    input byte_sel,
                    input [1:0] bytes,
                    output reg  [XLEN-1:0] aes32esi_out);

reg [7:0] byte_in ;
wire [7:0] s_out;
wire [31:0] sbox_out;
reg [31:0] roli;
reg [31:0] final_result;

always@(rs2 or byte_sel or bytes )
begin
            if(byte_sel)
            begin
               case(bytes)
                     2'b00 : byte_in = rs2[7:0];
                     2'b01 : byte_in = rs2[15:8];
                     2'b10 : byte_in = rs2[23:16];
                     2'b11 : byte_in = rs2[31:24];
                   //  default : byte_in = 8'b0;
                endcase
            end
            else
            begin
                  byte_in = 8'b0;
            end
       
end

aes_sbox sbox(.in_byte(byte_in),
              .out_byte(s_out));

assign sbox_out = {24'b0,s_out};

always@(rs1 or  bytes or  sbox_out )
begin
            case(bytes)
                2'b00 : roli = sbox_out;
                2'b01 : roli = {sbox_out[23:0],sbox_out[31:24]};
                2'b10 : roli = {sbox_out[15:0],sbox_out[31:16]};
                2'b11 : roli = {sbox_out[7:0],sbox_out[31:8]};
               // default : rol = sbox_out;
            endcase

        ///XOR with rs1
        final_result = rs1 ^ roli ;
        //OUTPUT
        aes32esi_out =  final_result ;
        end


endmodule
