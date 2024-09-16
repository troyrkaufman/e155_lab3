`timescale 1ns/1ns

module keypad_decoder_tb();
    logic row_q;
    logic [3:0] row_d, col_d;
    logic [3:0] key_pushed;

    keypad_decoder dut(row_q, row_d, col_d, key_pushed);

    initial begin
        // Tests all 16 cases
        col_d = 0001; row_d = 0001; #5;
        col_d = 0001; row_d = 0010; #5;
        col_d = 0001; row_d = 0100; #5;
        col_d = 0001; row_d = 1000; #5;
        col_d = 0010; row_d = 0001; #5;
        col_d = 0010; row_d = 0010; #5;
        col_d = 0010; row_d = 0100; #5;
        col_d = 0010; row_d = 1000; #5;
        col_d = 0100; row_d = 0001; #5;
        col_d = 0100; row_d = 0010; #5;
        col_d = 0100; row_d = 0100; #5;
        col_d = 0100; row_d = 1000; #5;
        col_d = 1000; row_d = 0001; #5;
        col_d = 1000; row_d = 0010; #5;
        col_d = 1000; row_d = 0100; #5;
        col_d = 1000; row_d = 1000; #5;

        //Tests cases for when no button is pressed
        col_d = 0001; row_d = 0000; #5;
        col_d = 1000; row_d = 0000; #5;
        col_d = 0100; row_d = 0000; #5;
        col_d = 1000; row_d = 0000; #5;
        col_d = 1000; row_d = 0010; #5;

    end

endmodule