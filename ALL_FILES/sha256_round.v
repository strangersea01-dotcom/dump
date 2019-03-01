
/*module sha256_round (
    input  [31:0] a,b,c,d,e,f,g,h,
    input  [31:0] w,
    input  [31:0] k,
    output [31:0] ao,bo,co,do,eo,fo,go,ho,
    output [31:0] sum0,
    output [31:0] sum1
);
    function [31:0] ROTR(input [31:0] x, input integer n);
        ROTR = (x >> n) | (x << (32-n));
//        ROTR = {x[n:0],x >> n};
    endfunction

    function [31:0] Ch(input [31:0] x,y,z);
        Ch = (x & y) ^ (~x & z);
    endfunction
    
    function [31:0] Maj(input [31:0] x,y,z);
        Maj = (x & y) ^ (x & z) ^ (y & z);
    endfunction

    function [31:0] S0(input [31:0] x);
        S0 = ROTR(x,2) ^ ROTR(x,13) ^ ROTR(x,22);
    endfunction

    function [31:0] S1(input [31:0] x);
        S1 = ROTR(x,6) ^ ROTR(x,11) ^ ROTR(x,25);
    endfunction

    wire [31:0] T1;
    wire [31:0] T2; 
    
    assign T1 = h + S1(e) + Ch(e,f,g) + k + w;

    assign T2 = S0(a) + Maj(a,b,c);

    assign ao = T1 + T2;
    assign bo = a;
    assign co = b;
    assign do = c;
    assign eo = d + T1;
    assign fo = e;
    assign go = f;
    assign ho = g;

    assign sum0 = S0(a);
    assign sum1 = S1(a);
endmodule*/

module sha256_round (
    input  [31:0] a,b,c,d,e,f,g,h,
    input  [31:0] w,
    input  [31:0] k,
    output [31:0] ao,bo,co,d0,eo,fo,go,ho,
    output [31:0] sum0,
    output [31:0] sum1
);

    // ---------------- Functions ----------------
    function [31:0] ROTR(input [31:0] x, input integer n);
        begin
            ROTR = (x >> n) | (x << (32-n));
        end
    endfunction

    function [31:0] Ch(input [31:0] x,y,z);
        begin
            Ch = (x & y) ^ (~x & z);
        end
    endfunction

    function [31:0] Maj(input [31:0] x,y,z);
        begin
            Maj = (x & y) ^ (x & z) ^ (y & z);
        end
    endfunction

    function [31:0] S0(input [31:0] x);
        begin
            S0 = ROTR(x,2) ^ ROTR(x,13) ^ ROTR(x,22);
        end
    endfunction

    function [31:0] S1(input [31:0] x);
        begin
            S1 = ROTR(x,6) ^ ROTR(x,11) ^ ROTR(x,25);
        end
    endfunction

    // ---------------- Wide adders (avoid overflow warnings) ----------------
    wire [34:0] T1_wide;
    wire [33:0] T2_wide;
    wire [32:0] ao_wide;
    wire [32:0] eo_wide;

    wire [31:0] T1;
    wire [31:0] T2;

    assign T1_wide = h + S1(e) + Ch(e,f,g) + k + w;
    assign T2_wide = S0(a) + Maj(a,b,c);

    assign T1 = T1_wide[31:0];
    assign T2 = T2_wide[31:0];

    assign ao_wide = T1 + T2;
    assign eo_wide = d  + T1;

    // ---------------- Outputs ----------------
    assign ao = ao_wide[31:0];
    assign bo = a;
    assign co = b;
    assign d0 = c;
    assign eo = eo_wide[31:0];
    assign fo = e;
    assign go = f;
    assign ho = g;

    assign sum0 = S0(a);
    assign sum1 = S1(a);

endmodule

