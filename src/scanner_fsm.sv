// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/14/24

/*
    This FSM scans the keyboard for a key press and key release. This FSM also toggles column values to begin the scanning process.
    This FSM will output the key's coordinates
*/
module scanner_fsm (input logic clk, nrst,
                    input logic [3:0] row_d,
                    output logic btn_press_q, btn_release_q,
                    output logic [3:0] col_q, row_q);

    typedef enum logic [3:0] {row0_base = 0, row0_pressed = 1, row0_released = 2, row1_base = 3, row1_pressed = 4, row1_released = 5, row2_base = 6, row2_pressed = 7, row2_released =8, row3_base = 9, row3_pressed = 10, row3_released = 11} statetype;
    statetype current_state, next_state;

    //State Register
    always_ff@(posedge clk)
        if(~nrst)
            current_state <= row0_base;
        else 
            current_state <= next_state;

    //Next State Logic
    always_comb begin
        case(current_state)
            row0_base: //row0
                if (row_d[0] == 1)
                    next_state = row0_pressed;
                else 
                    next_state = row1_base;
            row0_pressed:
                if (row_d[0] == 1)
                    next_state = current_state;
                else
                    next_state = row0_released;
            row0_released:
                    next_state = row0_base;
            row1_base: //row1
                if (row_d[1] == 1)
                    next_state = row1_pressed;
                else 
                    next_state = row2_base;
            row1_pressed:
                if (row_d[1] == 1)
                    next_state = current_state;
                else
                    next_state = row1_released;
            row1_released:
                    next_state = row1_base;
            row2_base: //row2
                if (row_d[2] == 1)
                    next_state = row2_pressed;
                else 
                    next_state = row3_base;
            row2_pressed:
                if (row_d[2] == 1)
                    next_state = current_state;
                else
                    next_state = row2_released;
            row2_released:
                    next_state = row2_base;
            row3_base: //row3
                if (row_d[3] == 1)
                    next_state = row3_pressed;
                else 
                    next_state = row0_base;
            row3_pressed:
                if (row_d[3] == 1)
                    next_state = current_state;
                else
                    next_state = row3_released;
            row3_released:
                    next_state = row3_base;
            
            default: next_state = current_state;
        endcase
            
    end

    //Output logic
    always_comb begin
        case(current_state)
            row0_base: begin col_q = 4'b0001; btn_press_q = 0; btn_release_q = 0; end
            row0_pressed: begin col_q = 4'b0000; btn_press_q = 1; btn_release_q = 0; end
            row0_released: begin col_q = 4'b0000; btn_press_q = 0; btn_release_q = 1; end

            row1_base: begin col_q = 4'b0010; btn_press_q = 0; btn_release_q = 0; end
            row1_pressed: begin col_q = 4'b0000; btn_press_q = 1; btn_release_q = 0; end
            row1_released: begin col_q = 4'b0000; btn_press_q = 0; btn_release_q = 1; end

            row2_base: begin col_q = 4'b0100; btn_press_q = 0; btn_release_q = 0; end
            row2_pressed: begin col_q = 4'b0000; btn_press_q = 1; btn_release_q = 0; end
            row2_released: begin col_q = 4'b0000; btn_press_q = 0; btn_release_q = 1; end

            row3_base: begin col_q = 4'b0000; btn_press_q = 0; btn_release_q = 0; end
            row3_pressed: begin col_q = 4'b0000; btn_press_q = 1; btn_release_q = 0; end
            row3_released: begin col_q = 4'b1000; btn_press_q = 0; btn_release_q = 1; end

            default: col_q = 4'b0001;
        endcase
        row_q = row_d;
    end    
endmodule