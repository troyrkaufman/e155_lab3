`timescale 1ns/1ns

module scanner_fsm_tb();
    logic clk, nrst;
    logic [3:0] row_d;
    logic btn_press_q, btn_release_q;
    logic [3:0] col_q, row_q;

    scanner_fsm dut(clk, nrst, row_d, btn_press_q, btn_release_q, col_q, row_q);

    always begin
        clk = 1; #5; clk = 0; # 5;
    end

    initial begin
        nrst = 0; #22; nrst = 1; #5;

        row_d = 'b0001; #10;
	row_d = 'b0010; #10;
	row_d = 'b0000; #10;
	row_d = 'b0000; #10;
        /*row_d = 'b0100; #10;
        row_d = 'b0100; #10;
	row_d = 'b0100; #10;
        row_d = 'b0100; #10;
	row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0001; #10;
        row_d = 'b1000; #10;
	row_d = 'b1000; #10;
	row_d = 'b1000; #10;
	row_d = 'b1000; #10;
	row_d = 'b1000; #10;
	row_d = 'b0001; #10;
	row_d = 'b0010; #10;
        row_d = 'b0100; #10;
	 row_d = 'b0100; #10;
	 row_d = 'b0100; #10;
	 row_d = 'b0100; #10;
	 row_d = 'b0100; #10;
*/
    end

endmodule