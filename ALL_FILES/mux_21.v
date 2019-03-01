module mux( input[31:0] rs1,
            input[31:0] rs2,
            input mux_sel,
            output [31:0] mux_out);

        assign mux_out = (mux_sel) ? rs2 : rs1;
        endmodule
