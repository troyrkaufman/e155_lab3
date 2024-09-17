// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/14/24

/*
    This FSM scans the keyboard for a key press and key release. This FSM also toggles column values to begin the scanning process.
    This FSM will output the key's coordinates
*/
module scanner_fsm (input logic clk, nrst,
                    input logic [3:0] row_d,
                    output logic [3:0] col_q_out, col_q, row_q);
					//output logic debug_led);
					
	//assign debug_led = counter[20];

    typedef enum logic [3:0] {row0_base = 4'd0, row0_pressed = 4'd1, row0_released = 4'd2, row1_base = 4'd3, row1_pressed = 4'd4, row1_released = 4'd5, row2_base = 4'd6, row2_pressed = 4'd7, row2_released = 4'd8, row3_base = 4'd9, row3_pressed = 4'd10, row3_released = 4'd11} statetype;
    statetype current_state, next_state;

    //Counter to toggle the columns at 10 kHz
    logic [20:0] counter;

    //State Register
    always_ff @(posedge clk)
        if(~nrst) begin
            current_state <= row0_base;
            counter <= 0;
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
            row0_base: //row0
                if (row_d[0] == 1'b1)
                    next_state = row0_pressed;
                else 
                    next_state = row1_base;
            row0_pressed:
                if (row_d[0] == 1'b1)
                    next_state = current_state;
                else
                    next_state = row0_released;
            row0_released:
                    next_state = row0_base;
            row1_base: //row1
                if (row_d[1] == 1'b1)
                    next_state = row1_pressed;
                else 
                    next_state = row2_base;
            row1_pressed:
                if (row_d[1] == 1'b1)
                    next_state = current_state;
                else
                    next_state = row1_released;
            row1_released:
                    next_state = row1_base;
            row2_base: //row2
                if (row_d[2] == 1'b1)
                    next_state = row2_pressed;
                else 
                    next_state = row3_base;
            row2_pressed:
                if (row_d[2] == 1'b1)
                    next_state = current_state;
                else
                    next_state = row2_released;
            row2_released:
                    next_state = row2_base;
            row3_base: //row3
                if (row_d[3] == 1'b1)
                    next_state = row3_pressed;
                else 
                    next_state = row0_base;
            row3_pressed:
                if (row_d[3] == 1'b1)
                    next_state = current_state;
                else
                    next_state = row3_released;
            row3_released:
                    next_state = row3_base;
            
            default: next_state = row0_base;
        endcase
            
    end

    //Output logic
    always_comb begin
        case(current_state)
            row0_base: begin col_q_out = 4'b0001; col_q = 4'b0000; end
            row0_pressed: begin col_q_out = 4'b0000; col_q = 4'b0001; end
            row0_released: begin col_q_out = 4'b0000; col_q = 4'b0000; end

            row1_base: begin col_q_out = 4'b0010; col_q = 4'b0000; end
            row1_pressed: begin col_q_out = 4'b0000; col_q = 4'b0010; end
            row1_released: begin col_q_out = 4'b0000; col_q = 4'b0000; end

            row2_base: begin col_q_out = 4'b0100; col_q = 4'b0000; end
            row2_pressed: begin col_q_out = 4'b0000; col_q = 4'b0100; end
            row2_released: begin col_q_out = 4'b0000; col_q = 4'b0000; end

            row3_base: begin col_q_out = 4'b1000; col_q = 4'b0000; end
            row3_pressed: begin col_q_out = 4'b0000; col_q = 4'b1000; end
            row3_released: begin col_q_out = 4'b0000; col_q = 4'b0000; end

            default: begin col_q_out = 4'b0001; col_q = 4'b0001; end
        endcase
        row_q = row_d;
    end    
endmodule