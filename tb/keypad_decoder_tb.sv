`timescale 1ns/1ns

module keypad_decoder_tb();
    logic [3:0] col_dec, row_dec, col_q;
    logic row_bit;
    logic [3:0] key_pushed;

    keypad_decoder dut(row_dec, col_dec, col_q, row_bit, key_pushed);

    initial begin
        // Tests all 16 cases
        /*col_d = 4'b0001; row_d = 4'b0001; #5;
        col_d = 4'b0001; row_d = 4'b0010; #5;
        col_d = 4'b0001; row_d = 4'b0100; #5;
        col_d = 4'b0001; row_d = 4'b1000; #5;
        col_d = 4'b0010; row_d = 4'b0001; #5;
        col_d = 4'b0010; row_d = 4'b0010; #5;
        col_d = 4'b0010; row_d = 4'b0100; #5;
        col_d = 4'b0010; row_d = 4'b1000; #5;
        col_d = 4'b0100; row_d = 4'b0001; #5;
        col_d = 4'b0100; row_d = 4'b0010; #5;
        col_d = 4'b0100; row_d = 4'b0100; #5;
        col_d = 4'b0100; row_d = 4'b1000; #5;
        col_d = 4'b1000; row_d = 4'b0001; #5;
        col_d = 4'b1000; row_d = 4'b0010; #5;
        col_d = 4'b1000; row_d = 4'b0100; #5;
        col_d = 4'b1000; row_d = 4'b1000; #5; */

	// Mixing up testcases
	  col_dec = 4'b0001; row_dec = 0000; #5; col_q = 4'b1111;
	  col_dec = 4'b0100; row_dec = 4'b0010; col_q = 4'b0100; #5; 
	  col_dec = 4'b0001; row_dec = 4'b0000; col_q = 4'b1111; #5; 
	  col_dec = 4'b1000; row_dec = 4'b0100; #5;
          col_dec = 4'b0001; row_dec = 4'b0001; #5; col_q = 4'b1111;

        //Tests cases for when no button is pressed
        col_dec = 4'b0001; row_dec = 0000; #5;
        col_dec = 4'b1000; row_dec = 0000; #5;
        col_dec = 4'b0100; row_dec = 0000; #5;
        col_dec = 4'b1000; row_dec = 0000; #5;
        col_dec = 4'b1000; row_dec = 4'b0010; #5;  col_q = 4'b1111;

    end

endmodule