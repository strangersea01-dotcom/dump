module PerformanceCounter (
    input clk,
    input rst,
    input enable,                  // Instruction completed signal
    output reg [31:0] cycle_count,
    output reg [31:0] instr_count
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cycle_count <= 32'd0;
        instr_count <= 32'd0;
    end
    else begin
        cycle_count <= cycle_count + 1;

        if (enable)
            instr_count <= instr_count + 1;
    end
end

endmodule
