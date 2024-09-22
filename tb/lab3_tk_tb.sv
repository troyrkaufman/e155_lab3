`timescale 1ns/1ns

module lab3_tk_tb();
    logic new_clock, nrst;
    logic [3:0] row_d, column_signals;
    logic en_right, en_left;
    logic [6:0] seg;

    lab3_tk dut(new_clock, nrst, row_d, column_signals ,en_right, en_left, seg);

	always begin
		new_clock = 1; #5; new_clock = 0; #5;
	end

    initial begin
        nrst = 0; #22; nrst = 1; #5;

        row_d = 4'b1111; #120;
	row_d = 4'b1110; #550;
	row_d = 4'b1111; #30;
	row_d = 4'b1011; #613;
	row_d = 4'b1111; #23;
	row_d = 4'b1101; #650;
	row_d = 4'b1111;

    end
endmodule