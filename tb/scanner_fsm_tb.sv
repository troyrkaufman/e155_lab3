`timescale 1ns/1ns

module scanner_fsm_tb();
    logic clk, nrst;
    logic [3:0] row_d;
    logic [3:0] col_q, col_dec;

    scanner_fsm dut(clk, nrst, row_d, col_q, col_dec);

    always begin
        clk = 1; #5; clk = 0; # 5;
    end

    initial begin
        nrst = 0; #7; nrst = 1; #5;
	row_d = 4'b0; #28;
	row_d = 4'b0001; #40;
	row_d = 4'b0; #45;
	row_d = 4'b1000; 
	
/*prev_num = 'h6;
	 row_d = 'b1010; #15;
        row_d = 'b0001; #20;

	
        row_d = 'b0100; #15;
        row_d = 'b0010; #20;
	prev_num = 'hc;
       	#16 row_d = 'b0000; #24; 
	 row_d = 'b0010; #5;
        row_d = 'b0010; #100;
        row_d = 'b0100; #50;
        row_d = 'b0100; #20;
        row_d = 'b0100; #20;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0001; #10;
        row_d = 'b1000; #10;
        row_d = 'b1000; #10;
        row_d = 'b0100; #50;
        row_d = 'b1000; #10;
        row_d = 'b1000; #10;
        row_d = 'b0001; #100;
        row_d = 'b0010; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10;
        row_d = 'b0100; #10; */
	
    end
endmodule
