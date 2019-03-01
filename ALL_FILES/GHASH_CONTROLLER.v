/*module ghash_controller(
        input clk,
        input rst,
        input start,
        input aad_empty,
        input cipher_empty,
        input length_empty,

        output reg h_reg_en,
        output reg [1:0] mux_sel,
        output reg ac_reg_en,
        output reg ac_clr,
        output reg s_reg_en,
        output reg done       
);

            parameter IDLE = 3'b000;
            parameter LOAD_H = 3'b001;
            parameter AAD = 3'b010;
            parameter CIPHER = 3'b011;
            parameter LENGTH = 3'b100;
            parameter DONE_S = 3'b101;
          
            reg[2:0] state, next_state;

	    reg        h_reg_en_c;
    	    reg [1:0]  mux_sel_c;
            reg        ac_reg_en_c;
            reg        ac_clr_c;
            reg        s_reg_en_c;
            reg        done_c;
		

            always@(posedge clk or posedge rst ) begin
                if(rst)begin
                    state <= IDLE;
                end
                else begin
                    state <= next_state;
                end
          end

           always@(start or aad_empty or cipher_empty or length_empty or state )begin
                
                case(state)
                    IDLE : begin
			    	   h_reg_en_c= 1'b0;
                                   ac_reg_en_c = 1'b0;
                                   ac_clr_c = 1'b0;
                                   s_reg_en_c = 1'b0;
                                   done_c     = 1'b0;

                            if(start)begin
                                next_state = LOAD_H;
                            end
                            else begin
                                next_state = IDLE;
                               end
                          end

                    LOAD_H : begin
				     h_reg_en_c =1'b1;
                                     ac_reg_en_c =1'b0;
                                     ac_clr_c = 1'b1;
                                     s_reg_en_c = 1'b0;
                                     done_c = 1'b0;

                                   if(!aad_empty)begin
                                       next_state = AAD;
                                   end
                                   else if(aad_empty && !cipher_empty)begin
                                       next_state = CIPHER;
                                   end
                                   else begin                                                                   
                                       next_state = LENGTH;
                                      end
                             end

                   AAD :    begin
                                   mux_sel_c = 2'b00;
                                   h_reg_en_c =1'b0;
                                   ac_reg_en_c =1'b1;
                                   ac_clr_c = 1'b0;
                                   s_reg_en_c = 1'b1;
                                   done_c = 1'b0; 

                                if(aad_empty && !cipher_empty)begin
                                    next_state = CIPHER;
                                 end
                                 else if(!aad_empty) begin
                                     next_state = AAD;                                                                     
                                 end

                                 else begin
                                     next_state = LENGTH;
                                 end
                             end

                   CIPHER : begin
                                   mux_sel_c = 2'b01;
                                   h_reg_en_c =1'b0;
                                   ac_reg_en_c =1'b1;
                                   ac_clr_c = 1'b0;
                                   s_reg_en_c = 1'b1;
                                   done_c = 1'b0;

                                if(aad_empty && !cipher_empty)begin
                                    next_state = CIPHER;
                                end
                                else begin
                                    next_state = LENGTH;                                     
                                end
                            end

                   LENGTH : begin

                                   mux_sel_c = 2'b10;
                                   h_reg_en_c =1'b0;
                                   ac_reg_en_c =1'b1;
                                   ac_clr_c = 1'b0;
                                   s_reg_en_c = 1'b1;
                                   done_c = 1'b0;

                               if(!length_empty)begin
                                   next_state = LENGTH;
                               end
                               else begin
                                   next_state = DONE_S ; 
                               end
                            end

                                    
                   DONE_S : begin
                                done_c = 1'b1;

                            if(!start)begin
                                next_state = IDLE;
                            end
                            else begin
                                next_state = DONE_S;
                            end
                          end
                          default : begin
				    next_state = IDLE; 
				    end

                     endcase
                 end

		always@(posedge clk or posedge rst)
			begin
			    if(rst)
				begin
				    h_reg_en   <= 1'b0;
            			    mux_sel    <= 2'b00;
         			    ac_reg_en  <= 1'b0;
           			    ac_clr     <= 1'b0;
           			    s_reg_en   <= 1'b0;
           			    done       <= 1'b0;
				end
			   else begin
				    h_reg_en   <= h_reg_en_c;
            			    mux_sel    <= mux_sel_c;
                                    ac_reg_en  <= ac_reg_en_c;
                                    ac_clr     <= ac_clr_c;
          			    s_reg_en   <= s_reg_en_c;
            			    done       <= done_c;
				end
			end
		
 endmodule*/


module ghash_controller_comb (
    input  [2:0] state,
    input        start,
    input        aad_empty,
    input        cipher_empty,
    input        length_empty,

    output reg [2:0] next_state,
    output reg       h_reg_en_c,
    output reg [1:0] mux_sel_c,
    output reg       ac_reg_en_c,
    output reg       ac_clr_c,
    output reg       s_reg_en_c,
    output reg       done_c
);

    // State encoding
    parameter IDLE    = 3'b000;
    parameter LOAD_H  = 3'b001;
    parameter AAD     = 3'b010;
    parameter CIPHER  = 3'b011;
    parameter LENGTH  = 3'b100;
    parameter DONE_S  = 3'b101;

    // NOTE: no always @(*)
    always @(state or start or aad_empty or cipher_empty or length_empty) begin

        // ---------------- DEFAULTS ----------------
        next_state   = state;
        h_reg_en_c   = 1'b0;
        mux_sel_c    = 2'b00;
        ac_reg_en_c  = 1'b0;
        ac_clr_c     = 1'b0;
        s_reg_en_c   = 1'b0;
        done_c       = 1'b0;

        // ---------------- FSM ----------------
        case (state)

            IDLE: begin
                if (start)
                    next_state = LOAD_H;
            end

            LOAD_H: begin
                h_reg_en_c = 1'b1;
                ac_clr_c  = 1'b1;

                if (!aad_empty)
                    next_state = AAD;
                else if (!cipher_empty)
                    next_state = CIPHER;
                else
                    next_state = LENGTH;
            end

            AAD: begin
                mux_sel_c   = 2'b00;
                ac_reg_en_c = 1'b1;
                s_reg_en_c  = 1'b1;

                if (!aad_empty)
                    next_state = AAD;
                else if (!cipher_empty)
                    next_state = CIPHER;
                else
                    next_state = LENGTH;
            end

            CIPHER: begin
                mux_sel_c   = 2'b01;
                ac_reg_en_c = 1'b1;
                s_reg_en_c  = 1'b1;

                if (!cipher_empty)
                    next_state = CIPHER;
                else
                    next_state = LENGTH;
            end

            LENGTH: begin
                mux_sel_c   = 2'b10;
                ac_reg_en_c = 1'b1;
                s_reg_en_c  = 1'b1;

                if (!length_empty)
                    next_state = LENGTH;
                else
                    next_state = DONE_S;
            end

            DONE_S: begin
                done_c = 1'b1;
                if (!start)
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase
    end

endmodule

module ghash_controller (
    input        clk,
    input        rst,
    input        start,
    input        aad_empty,
    input        cipher_empty,
    input        length_empty,

    output reg        h_reg_en,
    output reg [1:0]  mux_sel,
    output reg        ac_reg_en,
    output reg        ac_clr,
    output reg        s_reg_en,
    output reg        done
);

    // State encoding
    parameter IDLE    = 3'b000;
    parameter LOAD_H  = 3'b001;
    parameter AAD     = 3'b010;
    parameter CIPHER  = 3'b011;
    parameter LENGTH  = 3'b100;
    parameter DONE_S  = 3'b101;

    reg  [2:0] state;
    wire [2:0] next_state;

    wire       h_reg_en_c;
    wire [1:0] mux_sel_c;
    wire       ac_reg_en_c;
    wire       ac_clr_c;
    wire       s_reg_en_c;
    wire       done_c;

    // ---------------- COMBINATIONAL DECODER ----------------
    ghash_controller_comb u_comb (
        .state        (state),
        .start        (start),
        .aad_empty    (aad_empty),
        .cipher_empty (cipher_empty),
        .length_empty (length_empty),
        .next_state   (next_state),
        .h_reg_en_c   (h_reg_en_c),
        .mux_sel_c    (mux_sel_c),
        .ac_reg_en_c  (ac_reg_en_c),
        .ac_clr_c     (ac_clr_c),
        .s_reg_en_c   (s_reg_en_c),
        .done_c       (done_c)
    );

    // ---------------- SEQUENTIAL LOGIC ONLY ----------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            h_reg_en  <= 1'b0;
            mux_sel   <= 2'b00;
            ac_reg_en <= 1'b0;
            ac_clr    <= 1'b0;
            s_reg_en  <= 1'b0;
            done      <= 1'b0;
        end
        else begin
            state     <= next_state;
            h_reg_en  <= h_reg_en_c;
            mux_sel   <= mux_sel_c;
            ac_reg_en <= ac_reg_en_c;
            ac_clr    <= ac_clr_c;
            s_reg_en  <= s_reg_en_c;
            done      <= done_c;
        end
    end

endmodule

