// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 

module lab3_tk(input logic   int_osc, nrst,
               input logic [3:0] row_d,
               output logic [3:0] column_signals,
               output logic en_right, en_left,
               output logic [6:0] seg);
    
   // logic int_osc;
    
    logic row_pressed;
	logic [3:0] key_pushed;
	logic sync_data0, sync_data1, sync_data2, sync_data3;
	logic pulse_en;
	logic [3:0] current_num, prev_num;
	logic current_hex;
	logic [3:0] sync_data;
	logic [3:0] sync_data_out;
	logic [3:0] col_q;
	logic [3:0] row_bar;
	logic [3:0] column_sig;
	logic key_press;
	logic [3:0] col_dec;
	 
    // Low-speed oscillator
    //LSOSC ls_osc (.CLKLFPU(1'b1), .CLKLFEN(1'b1), .CLKLF(int_osc));

    // Synchronizes INPUT row data
    synchronizer sync0(.clk(int_osc), .nrst(nrst), .data_d(row_d[0]), .data_q(sync_data0));
    synchronizer sync1(.clk(int_osc), .nrst(nrst), .data_d(row_d[1]), .data_q(sync_data1));
    synchronizer sync2(.clk(int_osc), .nrst(nrst), .data_d(row_d[2]), .data_q(sync_data2));
    synchronizer sync3(.clk(int_osc), .nrst(nrst), .data_d(row_d[3]), .data_q(sync_data3));
	
    // Synchronizes OUTPUT column data to match the delay from the first set of syncrhonizers
    synchronizer sync0_out(.clk(int_osc), .nrst(nrst), .data_d(column_sig[0]), .data_q(sync_data0_out));
    synchronizer sync1_out(.clk(int_osc), .nrst(nrst), .data_d(column_sig[1]), .data_q(sync_data1_out));
    synchronizer sync2_out(.clk(int_osc), .nrst(nrst), .data_d(column_sig[2]), .data_q(sync_data2_out));
    synchronizer sync3_out(.clk(int_osc), .nrst(nrst), .data_d(column_sig[3]), .data_q(sync_data3_out));
	
	// Bit swizzling and inverting I/O data
    assign sync_data = ~{sync_data3, sync_data2, sync_data1, sync_data0};
	assign column_signals = ~{sync_data3_out, sync_data2_out, sync_data1_out, sync_data0_out};
	
	//assign row_bar = ~row_d;
	//assign column_signals = ~column_sig;

    // Scanner FSM 
    scanner_fsm scan(.clk(int_osc), .nrst(nrst), .row_d(sync_data), .key_press(key_press), .col_q(column_sig), .col_dec(col_dec)); 

    // Decodes the key that was pushed
    keypad_decoder keydec(.row_dec(row_bar), .col_dec(col_dec), .col_q(column_sig), .row_bit(row_pressed), .key_pushed(key_pushed));

    // Debounces the row signal that was pushed
    debouncer_fsm dbnc(.clk(int_osc), .nrst(nrst), .row_d(row_pressed), .pulse_en(pulse_en));

    // Updates the current number and previous number
    slide_state slide(.clk(int_osc), .nrst(nrst), .pulse_en(pulse_en), .key_press(key_press), .key_pushed(key_pushed), .current_num(current_num), .prev_num(prev_num));

    // Time multiplexes system
    display_controller dcon(.clk(int_osc), .nrst(nrst), .current_hex(current_hex), .hex1_num(en_right), .hex2_num(en_left));
    segment_decoder segdec(.current_hex(current_hex), .s1(current_num), .s2(prev_num), .seg(seg));
endmodule

