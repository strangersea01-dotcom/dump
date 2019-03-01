module riscv_control_unit(

				input[2:0] func3,
				input[6:0] func7,
				input[6:0] opcode,
              		        input[31:0] inst_in,
				output reg reg_write,
				output reg imm_sel,
				output reg data_write_en,
				output reg data_sel_mux,
				output reg [4:0] alu_opcode,
				output reg [1:0] alu_sel_mux,
                output reg byte_sel,
                output reg [1:0] bytes,
		output reg sign_extend 


				);


always@(func3 or func7 or opcode or inst_in[31:20])
				begin

				reg_write     = 1'b0;
   				alu_opcode    = 5'b00000;
    				imm_sel       = 1'b0;
   				alu_sel_mux   = 2'b00;
    				data_write_en = 1'b0;
    				data_sel_mux  = 1'b0;
    				byte_sel      = 1'b0;
    				bytes         = 2'b00;
				sign_extend = 1'b0;
	
                           if(func7 == 7'b00110000 && func3 == 3'b001 && opcode == 7'b0110011)  //rol
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00001;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    data_sel_mux = 1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
				    sign_extend = 1'b0;

                                end
                              else  if(func7 == 7'b0110000 && func3 == 3'b101 && opcode == 7'b0110011) //ror
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00010;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
				   sign_extend = 1'b0;



                                end
                              else  if(func7 == 7'b0100000 && func3 == 3'b111 && opcode == 7'b0110011) //andn
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00011;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
				sign_extend = 1'b0;


                                end
                              else if(func7 == 7'b0100000 && func3 == 3'b110 && opcode == 7'b0110011) //orn
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00100;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
				sign_extend = 1'b0;



                                end
                               else if(func7 == 7'b0100000 && func3 == 3'b100 && opcode == 7'b0110011) //xnor
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00101;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;



                                end
                               else if(func7 == 7'b0000100 && func3 == 3'b100 && opcode == 7'b0110011) //pack
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00110;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;



                                end
                               else if(func7 == 7'b0000100 && func3 == 3'b111 && opcode == 7'b0110011) //packh
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b00111;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;



                                end
                               else if(func7 == 7'b0000100 && func3 == 3'b001 && opcode == 7'b0010011) //zip
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01000;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;



                                end
                               else if(func7 == 7'b0000100 && func3 == 3'b101 && opcode == 7'b0010011) //unzip
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01001;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                   bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;



                                end
                                else if(func7 == 7'b0000101 && func3 == 3'b001 && opcode == 7'b0110011) //MINMAX/CLMUL
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01010;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b01;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                   bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;


                                end
                                else if(func7 == 7'b0000101 && func3 == 3'b011 && opcode == 7'b0110011) //INMAX/CLMUL
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01011;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b01;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;


                                end
                                else if(func7 == 7'b0010001 && func3 == 3'b000 && opcode == 7'b0110011) //ASE32ESI
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01111;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b10;
                                    data_write_en=1'b0;
                                    byte_sel=1'b1;
                                   bytes = 2'b00;
                                    data_sel_mux = 1'b0;
						sign_extend = 1'b0;


                                end
                               else if(func7 == 7'b0010011 && func3 == 3'b000 && opcode == 7'b0110011) //ASE32ESMI
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b10000;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b10;
                                    data_write_en=1'b0;
                                    byte_sel=1'b1;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;



                                end
                               else if(func7 == 7'b0001000 && func3 == 3'b001 && opcode == 7'b0010011) //SHA256sig0
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b10001;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b11;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                   bytes = 2'b00;
                                    data_sel_mux = 1'b0;
				sign_extend = 1'b0;


                                end

                                else if(func7 == 7'b0101000 && func3 == 3'b001 && opcode == 7'b0010011) //SHA256sig1
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b10010;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b11;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                   bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;


                                end

                               else if(func7 == 7'b1001000 && func3 == 3'b001 && opcode == 7'b0010011) //SHA256sum0
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b10011;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b11;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                    bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;


                                end
                               else if(func7 == 7'b1101000 && func3 == 3'b001 && opcode == 7'b0010011) //SHA256sum1
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b10100;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b11;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                   bytes = 2'b00;
                                    data_sel_mux = 1'b0;
					sign_extend = 1'b0;


                                end



                               else if(inst_in[31:20] == 12'b011010000111 && func3 == 3'b101 && opcode == 7'b0010011) //brev8
                                  begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01100;
                                    imm_sel= 1'b1;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                  //  bytes = 2'b00;
                                    data_sel_mux = 1'b0;
				   sign_extend = 1'b1;

                                end
                                
                               else if(inst_in[31:20] == 12'b011010011000 && func3 == 3'b101 && opcode == 7'b0010011) //rev8
                                begin
                                    reg_write = 1'b1;
                                    alu_opcode = 5'b01101;
                                    imm_sel= 1'b1;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b0;
                                    byte_sel=1'b0;
                                  //  bytes = 2'b00;
                                    data_sel_mux = 1'b0;
				    sign_extend = 1'b1;

                                end
                                else                                 
                                begin
                                    reg_write = 1'b0;
                                    alu_opcode = 5'b0;
                                    imm_sel= 1'b0;
                                    alu_sel_mux = 2'b00;
                                    data_write_en=1'b1;
                                    byte_sel=1'b0;
                                  //  bytes = 2'b01;
                                    data_sel_mux = 1'b1;
				  	 sign_extend = 1'b0;	

                                end



				end
endmodule
