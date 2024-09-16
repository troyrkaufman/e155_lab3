`timescale 1ns/1ns

module keypad_decoder_tb();
    logic [3:0] col_d, row_d;
    logic row_q;
    logic [3:0] key_pushed;

    keypad_decoder dut(col_d, row_d, row_q, key_pushed);

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
	  col_d = 4'b0100; row_d = 4'b0010; #5;
	  col_d = 4'b0001; row_d = 4'b1000; #5;
	  col_d = 4'b1000; row_d = 4'b0100; #5;
          col_d = 4'b0001; row_d = 4'b0001; #5;

        //Tests cases for when no button is pressed
        col_d = 4'b0001; row_d = 0000; #5;
        col_d = 4'b1000; row_d = 0000; #5;
        col_d = 4'b0100; row_d = 0000; #5;
        col_d = 4'b1000; row_d = 0000; #5;
        col_d = 4'b1000; row_d = 4'b0010; #5; 

    end

endmodule