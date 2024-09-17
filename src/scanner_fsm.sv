// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/14/24

/*
    This FSM scans the keyboard for a key press and key release. This FSM also toggles column values to begin the scanning process.
    This FSM will output the key's coordinates
*/
module scanner_fsm (input logic clk, nrst,
                    input logic [3:0] row_d, prev_num,
                    output logic [3:0] col_q, row_q, key_pushed);
					
					
	//assign debug_led = counter[20];

    typedef enum logic [3:0] {col0_base = 4'd0, col0_pressed = 4'd1, col0_released = 4'd2, col1_base = 4'd3, col1_pressed = 4'd4, col1_released = 4'd5, col2_base = 4'd6, col2_pressed = 4'd7, col2_released = 4'd8, col3_base = 4'd9, col3_pressed = 4'd10, col3_released = 4'd11} statetype;
    statetype current_state, next_state;

    //Counter to toggle the columns at 10 kHz
    //logic [20:0] counter;
	logic col0_avoid = (row_d[1] != 1'b1) & (row_d[2] != 1'b1) & (row_d[3] != 1'b1);
	logic col1_avoid = (row_d[0] != 1'b1) & (row_d[2] != 1'b1) & (row_d[3] != 1'b1);
	logic col2_avoid = (row_d[1] != 1'b1) & (row_d[0] != 1'b1) & (row_d[3] != 1'b1);
	logic col3_avoid = (row_d[1] != 1'b1) & (row_d[2] != 1'b1) & (row_d[0] != 1'b1);

    //State Register
    always_ff @(posedge clk)
        if(~nrst) begin
            current_state <= col0_base;
            //counter <= 0;
        end
        //else if (counter == 20'b10010110000) begin
	/*else if (counter == 20'd20) begin
            current_state <= next_state;
            counter <= 0;
        end */
        else begin
            //counter <= counter + 1;
	    current_state <= next_state;
        end

    //Next State Logic
    always_comb begin
        case(current_state)
            col0_base: //row0
                if (row_d[0] == 1'b1 & row_d[1] != 1'b1 & row_d[2] != 1'b1 & row_d[3] != 1'b1) // might need to be exhaustive in the col#_base to avoid multiple button input mishaps
                    next_state = col0_pressed;
                else 
                    next_state = col1_base;
            col0_pressed:
                if (row_d[0] == 1'b1)
                    next_state = current_state;
                else
                    next_state = col0_released;
            col0_released:
                    next_state = col0_base;
            col1_base: //row1
                if (row_d[1] == 1'b1 & row_d[0] != 1'b1 & row_d[2] != 1'b1 & row_d[3] != 1'b1)
                    next_state = col1_pressed;
                else 
                    next_state = col2_base;
            col1_pressed:
                if (row_d[1] == 1'b1)
                    next_state = current_state;
                else
                    next_state = col1_released;
            col1_released:
                    next_state = col1_base;
            col2_base: //row2
                if (row_d[2] == 1'b1 & row_d[1] != 1'b1 & row_d[0] != 1'b1 & row_d[3] != 1'b1)
                    next_state = col2_pressed;
                else 
                    next_state = col3_base;
            col2_pressed:
                if (row_d[2] == 1'b1)
                    next_state = current_state;
                else
                    next_state = col2_released;
            col2_released:
                    next_state = col2_base;
            col3_base: //row3
                if (row_d[3] == 1'b1 & row_d[1] != 1'b1 & row_d[2] != 1'b1 & row_d[0] != 1'b1)
                    next_state = col3_pressed;
                else 
                    next_state = col0_base;
            col3_pressed:
                if (row_d[3] == 1'b1)
                    next_state = current_state;
                else
                    next_state = col3_released;
            col3_released:
                    next_state = col3_base;
            
            default: next_state = col0_base; 
        endcase
            
    end

    //Output logic
    always_comb begin
        case(current_state)
		/*col0_base: if (row_d[0] == 'b1 & col0_avoid == 'b1) begin key_pushed = 'ha; col_q = 4'b0001; end 
			else if (row_d[1] == 'b1 & col0_avoid == 'b1) begin key_pushed = 'h7; col_q = 4'b0001; end
			else if (row_d[2] == 'b1 & col0_avoid == 'b1) begin key_pushed = 'h4; col_q = 4'b0001; end
			else if (row_d[3] == 'b1 & col0_avoid == 'b1) begin key_pushed = 'h1; col_q = 4'b0001; end
			else col_q = 4'b0001; */
		col0_base: if (row_d[0] == 'b1) begin key_pushed = 'ha; col_q = 4'b0001; end 
			else if (row_d[1] == 'b1) begin key_pushed = 'h7; col_q = 4'b0001; end
			else if (row_d[2] == 'b1 ) begin key_pushed = 'h4; col_q = 4'b0001; end
			else if (row_d[3] == 'b1 ) begin key_pushed = 'h1; col_q = 4'b0001; end
			else begin col_q = 4'b0001; key_pushed = prev_num; end
		col1_base: if (row_d[0] == 'b1) begin key_pushed = 'h0; col_q = 4'b0010; end 
			else if ((row_d[1] == 'b1) & (row_d[0] != 1'b1) & (row_d[2] != 1'b1) & (row_d[3] != 1'b1)) begin key_pushed = 'h8; col_q = 4'b0010; end
			else if (row_d[2] == 'b1 ) begin key_pushed = 'h5; col_q = 4'b0010; end
			else if ((row_d[3] == 'b1) & (row_d[0] != 1'b1) & (row_d[2] != 1'b1) & (row_d[3] != 1'b1) ) begin key_pushed = 'h2; col_q = 4'b0010; end
			else begin col_q = 4'b0010; key_pushed = prev_num; end
		col2_base: if (row_d[0] == 'b1 ) begin key_pushed = 'hb; col_q = 4'b0100; end 
			else if (row_d[1] == 'b1 ) begin key_pushed = 'h9; col_q = 4'b0100; end
			else if (row_d[2] == 'b1 ) begin key_pushed = 'h6; col_q = 4'b0100; end
			else if (row_d[3] == 'b1 ) begin key_pushed = 'h3; col_q = 4'b0100; end
			else begin col_q = 4'b0100; key_pushed = prev_num; end
		col3_base: if (row_d[0] == 'b1 ) begin key_pushed = 'hf; col_q = 4'b0100; end 
			else if (row_d[1] == 'b1 ) begin key_pushed = 'he; col_q = 4'b0100; end
			else if (row_d[2] == 'b1 ) begin key_pushed = 'hd; col_q = 4'b0100; end
			else if (row_d[3] == 'b1 ) begin key_pushed = 'hc; col_q = 4'b0100; end
			else begin col_q = 4'b1000; key_pushed = prev_num; end
		default: begin col_q = 4'b0000; key_pushed = prev_num; end
        endcase
        row_q = row_d;
    end    
endmodule