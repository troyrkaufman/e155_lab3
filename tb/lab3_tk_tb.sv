`timescale 1ns/1ns

module lab3_tk_tb();
    logic int_osc, nrst;
    logic [3:0] row_d, column_signals;
    logic en_right, en_left;
    logic [6:0] seg;

    lab3_tk dut(int_osc, nrst, row_d, column_signals ,en_right, en_left, seg);

	always begin
		int_osc = 1; #5; int_osc = 0; #5;
	end

    initial begin
        nrst = 0; #22; nrst = 1; #5;

        row_d = 4'b1111; #120;
	row_d = 4'b1110; #550;
	row_d = 4'b0111; #524;
	row_d = 4'b1111; #30;
	row_d = 4'b1101; #613;
	row_d = 4'b1100; #613;
	row_d = 4'b1101; #613;
	row_d = 4'b1111; #23;
	row_d = 4'b1011; #650;
	row_d = 4'b1111;

    end
endmodule