// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/14/24

/*
    This FSM scans the keyboard for a key press and key release. This FSM also toggles column values to begin the scanning process.
    This FSM will output the key's coordinates
*/


// Pending on how to perform the keypad_decode
typedef enum [3:0] {row0_base: 0, row0_pressed: 1, row0_released: 2, row1_base: 3, row1_pressed: 4, row1_released: 5, row2_base: 6, row2_pressed: 7, row2_released:8, row3_base: 9, row3_pressed: 10, row3_released: 11} statetype;
statetype current_state, next_state;

module scanner_fsm (input logic clk, nrst,
                    input logic [1:0] row_d,
                    output logic btn_press_q, btn_release_q,
                    output logic [1:0] col_q)

    //State Register
    always_ff@(posedge clk)
        if(~reset)
            current_state <= row0_base;
        else 
            current_state <= next_state;

    //Next State Logic
    always_comb begin
        case(current_state)
            row0_base: //row0
                if (row_d == 1)
                    next_state = row0_pressed;
                else 
                    next_state = row1_base;
            row0_pressed:
                if (row_d == 1)
                    next_state = current_state;
                else
                    next_state = row0_released;
            row0_released:
                    next_state = row0_base;
            row1_base: //row1
                if (row_d == 1)
                    next_state = row1_pressed;
                else 
                    next_state = row2_base;
            row1_pressed:
                if (row_d == 1)
                    next_state = current_state;
                else
                    next_state = row1_released;
            row1_released:
                    next_state = row1_base;
            row2_base: //row2
                if (row_d == 1)
                    next_state = row2_pressed;
                else 
                    next_state = row3_base;
            row2_pressed:
                if (row_d == 1)
                    next_state = current_state;
                else
                    next_state = row2_released;
            row0_released:
                    next_state = row0_base;
            row3_base: //row3
                if (row_d == 1)
                    next_state = row3_pressed;
                else 
                    next_state = row0_base;
            row3_pressed:
                if (row_d == 1)
                    next_state = current_state;
                else
                    next_state = row3_released;
            row3_released:
                    next_state = row3_base;
        endcase
            
    end

    //Output logic
    assign 
endmodule