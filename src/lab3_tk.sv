// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 

module lab3_tk(input logic  nrst,
               input logic [3:0] row_d,
               output logic [3:0] column_signals,
               output logic en_right, en_left,
               output logic [6:0] seg,
			   output debug_led, state1, state2);
    
    logic int_osc;
    
    logic [3:0] row_signals;
    logic row_pressed;
	logic [3:0] key_pushed;
	logic sync_data0, sync_data1, sync_data2, sync_data3;
	logic pulse_en;
	logic [3:0] current_num, prev_num;
	logic current_hex;
	logic [3:0] sync_data;
	logic [3:0] sync_data_out;
	logic [3:0] col_q;
	//logic [3:0] row_bar
	 
    // High-speed oscillator
    LSOSC ls_osc (.CLKLFPU(1'b1), .CLKLFEN(1'b1), .CLKLF(int_osc));
	
	logic new_clock;
	logic [11:0] counter;
	
	always_ff @(posedge int_osc)
		if (~nrst) counter <= 0; 
		else if (counter >= 'd20) begin
			new_clock <= ~new_clock;
			counter <= 0;
			end
		else begin
			new_clock <= new_clock;
			counter <= counter + 1; 
		end 
			
    //row_bar = ~row_d;

    synchronizer sync0(.clk(new_clock), .nrst(nrst), .data_d(row_d[0]), .data_q(sync_data0));
    synchronizer sync1(.clk(new_clock), .nrst(nrst), .data_d(row_d[1]), .data_q(sync_data1));
    synchronizer sync2(.clk(new_clock), .nrst(nrst), .data_d(row_d[2]), .data_q(sync_data2));
    synchronizer sync3(.clk(new_clock), .nrst(nrst), .data_d(row_d[3]), .data_q(sync_data3));
	
	//synchronizer sync0_out(.clk(int_osc), .nrst(nrst), .data_d(col_q[0]), .data_q(sync_data0_out));
    //synchronizer sync1_out(.clk(int_osc), .nrst(nrst), .data_d(col_q[1]), .data_q(sync_data1_out));
    //synchronizer sync2_out(.clk(int_osc), .nrst(nrst), .data_d(col_q[2]), .data_q(sync_data2_out));
    //synchronizer sync3_out(.clk(int_osc), .nrst(nrst), .data_d(col_q[3]), .data_q(sync_data3_out));
    
	
	 // Bit swizzling
    assign sync_data = {sync_data3, sync_data2, sync_data1, sync_data0};
	//assign column_signals = {sync_data3_out, sync_data2_out, sync_data1_out, sync_data0_out};

    scanner_fsm scan(.clk(new_clock), .nrst(nrst), .row_d(row_d), .col_q(column_signals), .row_q(row_signals), .key_pushed(key_pushed), .state1(state1), .state2(state2)); 

    keypad_decoder keydec(.row_d(row_signals), .row_bit(row_pressed));
    debouncer_fsm dbnc(.clk(new_clock), .nrst(nrst), .row_d(row_pressed), .pulse_en(pulse_en));
    slide_state slide(.clk(new_clock), .nrst(nrst), .pulse_en(pulse_en), .key_pushed(key_pushed), .current_num(current_num), .prev_num(prev_num));
    display_controller dcon(.clk(new_clock), .nrst(nrst), .current_hex(current_hex), .hex1_num(en_right), .hex2_num(en_left));
    segment_decoder segdec(.current_hex(current_hex), .s1(current_num), .s2(prev_num), .seg(seg));
	
	assign debug_led = row_bar[0];
	
	
	
	
	
	
endmodule

