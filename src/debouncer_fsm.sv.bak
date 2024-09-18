// Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/15/24

/*
    This FSM debounces the incoming row signal
*/

module debouncer_fsm(input logic clk, nrst,
                    input logic row_d,
                    output logic pulse_en);
    
    typedef enum logic [1:0] {S0, S1, S2, S3} statetype;
    statetype current_state, next_state;

    logic [16:0] counter; //1110101001100000 == 'd60000

    //State register
    always_ff @(posedge clk)
        if (~nrst) begin
            current_state <= S0;
            counter <= 0;
        end
        else if (counter == 'd50) begin //'d60000
            counter <= 0;
            current_state <= next_state;
        end
        else if (current_state == S1) begin
            current_state <= next_state;
            counter <= counter + 1;
        end
	    else begin
	    current_state <= next_state;
	    counter <= 0;
	end
    
    //Next state logic
    always_comb
        case(current_state)
            S0: if (row_d == 1) next_state = S1; else next_state = current_state;
            S1: if(counter == 'd50) next_state = S2; else if (row_d == 0) next_state = S0; else next_state = current_state; //'d60000
            S2: next_state = S3;
            S3: if (row_d == 0) next_state = S0; else next_state = current_state;
            default: next_state = S0; 
        endcase

    //Output logic
    assign pulse_en = (current_state == S2); 
endmodule