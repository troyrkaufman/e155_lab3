// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/16/24

module lab3_tk(input logic          nrst,
               input logic [3:0]    row_d,
               output logic [3:0]   column_signals,
               output logic         en_right, en_left,
               output logic [6:0]   seg);
    
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
	logic [3:0] row_bar;
	logic [3:0] column_sig;
	logic key_press;
	logic [3:0] col_dec;

    /*
    Place synchronizers here. Important to note that you would need to use synchronizers on both
    the rows and columns so that they are delayed together thus synching them. In my design, I
    would use the 2-DFF immediately with the row_d bus to stablize an asynchronous signal 
    while the col_dec bus would have to get 2-DFF to match the row_d delay for when the keypad
    is being decoded. 
    */
	
    // Low-speed oscillator at 10 KHz
    LSOSC ls_osc (.CLKLFPU(1'b1), .CLKLFEN(1'b1), .CLKLF(int_osc));
	
	assign row_bar = ~row_d;
	assign column_signals = ~column_sig;

    // Scanner FSM
    scanner_fsm scan(.clk(int_osc), .nrst(nrst), .row_d(row_bar), .col_q(column_sig), .col_dec(col_dec)); 

    // Decodes the key pushed
    keypad_decoder keydec(.row_dec(row_bar), .col_dec(col_dec), .col_q(column_sig), .row_bit(row_pressed), .key_pushed(key_pushed));

    // Debounces the row signal that was pushed
    debouncer_fsm dbnc(.clk(int_osc), .nrst(nrst), .row_d(row_pressed), .pulse_en(pulse_en));

    // Updates the current number and previous number
    slide_state slide(.clk(int_osc), .nrst(nrst), .pulse_en(pulse_en), .key_pushed(key_pushed), .current_num(current_num), .prev_num(prev_num));

    // Time multiplexing system
    display_controller dcon(.clk(int_osc), .nrst(nrst), .current_hex(current_hex), .hex1_num(en_right), .hex2_num(en_left));
    segment_decoder segdec(.current_hex(current_hex), .s1(current_num), .s2(prev_num), .seg(seg));
endmodule

