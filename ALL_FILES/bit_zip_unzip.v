

module tb_zip_unzip;

    reg  [31:0] rs1;
    wire [31:0] zip_out;
    wire [31:0] unzip_out;

    // DUTs
    bit_zip u_zip (
        .rs1(rs1),
        .result(zip_out)
    );

    bit_unzip u_unzip (
        .rs1(zip_out),
        .result(unzip_out)
    );

    initial begin
        $display(" time |    rs1        zip_out     unzip_out");
        $display("------------------------------------------------");

        // Test case 1
        rs1 = 32'h12345678;
        #10;
        $display("%4t | %h  %h  %h", $time, rs1, zip_out, unzip_out);

        // Test case 2
        rs1 = 32'hA5A5A5A5;
        #10;
        $display("%4t | %h  %h  %h", $time, rs1, zip_out, unzip_out);

        // Test case 3
        rs1 = 32'h0000FFFF;
        #10;
        $display("%4t | %h  %h  %h", $time, rs1, zip_out, unzip_out);

        // Test case 4
        rs1 = 32'hFFFFFFFF;
        #10;
        $display("%4t | %h  %h  %h", $time, rs1, zip_out, unzip_out);

        $finish;
    end

endmodule

