`timescale 1ns/1ns

module slide_state_tb();
    logic clk, nrst, pulse_en;
    logic [3:0] key_pushed;
    logic [3:0] current_num, prev_num;

    slide_state dut(clk, nrst, pulse_en, key_pushed, current_num, prev_num);

    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        nrst = 0; #22; nrst = 1; 

        key_pushed = 'h4; pulse_en = 0; #10;
        key_pushed = 'ha; #5;
        key_pushed = 'h6; #1; pulse_en = 1; #10;
        key_pushed = 'h0; pulse_en = 0; #20; 
        key_pushed = 'h4; #15; pulse_en = 1; #10; pulse_en = 0;
	key_pushed = 'h8; #50;
	key_pushed = 'h1; pulse_en = 0; 

    end

endmodule