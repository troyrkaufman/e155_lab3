`timescale 1ns/1ns

module lab3_tk_tb();
    logic nrst;
    logic [3:0] row_d, toggle_col;
    logic en_right, en_left;
    logic [6:0] seg;

    lab3_tk dut(nrst, row_d, toggle_col,en_right, en_left, seg);

    initial begin
        nrst = 0; #22; nrst = 1; #5;

        row_d = 'b0001; #10;
        row_d = 'b0010; #10;
        row_d = 'b0000; #10;
        row_d = 'b0000; #10;
        row_d = 'b0100; #1500;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0001; #10;
        row_d = 'b1000; #1000;
        row_d = 'b1000; #10;
        row_d = 'b1000; #10;
        row_d = 'b1000; #10;
        row_d = 'b1000; #10;
        row_d = 'b0001; #10;
        row_d = 'b0010; #1000;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #2000;
        row_d = 'b0100; #10;

    end
endmodule