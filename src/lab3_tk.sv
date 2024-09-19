// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 

module lab3_tk(input logic int_osc, nrst,
               input logic [3:0] row_d,
               output logic [3:0] column_signals,
               output logic en_right, en_left,
               output logic [6:0] seg);
    
   // logic int_osc;
    
    logic [3:0] row_signals;
    logic row_pressed;
	logic [3:0] key_pushed;
	logic sync_data0, sync_data1, sync_data2, sync_data3;
	logic pulse_en;
	logic [3:0] current_num, prev_num;
	logic current_hex;
	logic [3:0] sync_data;
	 
    // High-speed oscillator
    //LSOSC ls_osc (.CLKLFPU(1'b1), .CLKLFEN(1'b1), .CLKLF(int_osc));

    synchronizer sync0(.clk(int_osc), .nrst(nrst), .data_d(row_d[0]), .data_q(sync_data0));
    synchronizer sync1(.clk(int_osc), .nrst(nrst), .data_d(row_d[1]), .data_q(sync_data1));
    synchronizer sync2(.clk(int_osc), .nrst(nrst), .data_d(row_d[2]), .data_q(sync_data2));
    synchronizer sync3(.clk(int_osc), .nrst(nrst), .data_d(row_d[3]), .data_q(sync_data3));
	
	 // Bit swizzling
    assign sync_data = {sync_data3, sync_data2, sync_data1, sync_data0};

    scanner_fsm scan(.clk(int_osc), .nrst(nrst), .row_d(sync_data), .prev_num(prev_num), .col_q(column_signals), .row_q(row_signals), .key_pushed(key_pushed)); 

    keypad_decoder keydec(.row_d(row_signals), .row_bit(row_pressed));
    debouncer_fsm dbnc(.clk(int_osc), .nrst(nrst), .row_d(row_pressed), .pulse_en(pulse_en));
    slide_state slide(.clk(int_osc), .nrst(nrst), .pulse_en(pulse_en), .key_pushed(key_pushed), .current_num(current_num), .prev_num(prev_num));
    display_controller dcon(.clk(int_osc), .nrst(nrst), .current_hex(current_hex), .hex1_num(en_right), .hex2_num(en_left));
    segment_decoder segdec(.current_hex(current_hex), .s1(current_num), .s2(prev_num), .seg(seg));
	
endmodule

