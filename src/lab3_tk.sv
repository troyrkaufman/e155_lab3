// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 

module lab3_tk(input logic nrst,
               input logic [3:0] row_d,
               output logic [3:0] toggle_col,
               output logic en_right, en_left,
               output logic [6:0] seg);
			  // output logic debug_led);
    
    logic int_osc;
    
    logic [3:0] column_signals;
    logic [3:0] row_signals;
    logic row_pressed;
	logic [3:0] key_pushed;
	logic sync_data0, sync_data1, sync_data2, sync_data3;
	logic pulse_en;
	logic [3:0] current_num, prev_num;
	logic current_hex;
	//logic en_right, en_left;
	logic [3:0] sync_data;
	
    // Bit swizzling
    assign sync_data = {sync_data3, sync_data2, sync_data1, sync_data0};
	 
    // High-speed oscillator
    HSOSC #(.CLKHF_DIV(2'b10)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    synchronizer sync0(.clk(int_osc), .nrst(nrst), .data_d(row_d[0]), .data_q(sync_data0));
    synchronizer sync1(.clk(int_osc), .nrst(nrst), .data_d(row_d[1]), .data_q(sync_data1));
    synchronizer sync2(.clk(int_osc), .nrst(nrst), .data_d(row_d[2]), .data_q(sync_data2));
    synchronizer sync3(.clk(int_osc), .nrst(nrst), .data_d(row_d[3]), .data_q(sync_data3));

    scanner_fsm scan(.clk(int_osc), .nrst(nrst), .row_d(sync_data), .col_q_out(toggle_col), .col_q(column_signals), .row_q(row_signals)); //.debug_led(debug_led));
    keypad_decoder keydec(.col_d(column_signals), .row_d(row_signals), .row_q(row_pressed), .key_pushed(key_pushed));
    debouncer_fsm dbnc(.clk(int_osc), .nrst(nrst), .row_d(row_pressed), .pulse_en(pulse_en));
    slide_state slide(.clk(int_osc), .nrst(nrst), .pulse_en(pulse_en), .key_pushed(key_pushed), .current_num(current_num), .prev_num(prev_num));
    display_controller dcon(.clk(int_osc), .nrst(nrst), .current_hex(current_hex), .hex1_num(en_right), .hex2_num(en_left));
    segment_decoder segdec(.current_hex(current_hex), .s1(current_num), .s2(prev_num), .seg(seg));
	
endmodule

