`timescale 1ns/1ns

module debouncer_fsm_tb ();
	logic clk, nrst;
	logic row_d;
	logic pulse_en;

	debouncer_fsm dut(clk, nrst, row_d, pulse_en);

	always begin
		clk = 1; #1; clk = 0; #1;
	end

	initial begin
		nrst = 0; #22; nrst = 1;
		row_d = 0; #10; 
		row_d = 1; #5;
		row_d = 0; #5;
		row_d = 1; #3;
		row_d = 0; #1;
		
		row_d = 1; #150;
		row_d = 0; #32; 
		row_d = 1; #55;
		row_d = 0; 
	end

endmodule
