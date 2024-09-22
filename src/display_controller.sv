

// Author: Troy Kaufman
// Email: tkaufman@hmc.edu  
// Date: 9/6/24

/*
    This module creates a time multiplexing FSM. It will toggle transistors enabling small or large current flow into 
    the common anode ports of the dual 7-segment display. Simultaneously, an encoded signal is outputted to another module 
    carrying the information of the hex number that should be displayed.
*/

// current_hex encoding: 0 = 1st hex number; 1 = 2nd hex number
// hex1_num: Signal traveling through a PNP transistor to 1st hex number
// hex2_num: Signal traveling through a PNP transistor to 2nd hex number
// S0 is just a reset state that will not display any numbers (transistors will limit the current into the display)

module display_controller(input logic clk, nrst,
                          output logic current_hex,
                          output logic hex1_num, hex2_num);
						  
	typedef enum logic [1:0] {S0 = 0, S1 = 1, S2 = 2} statetype;
	statetype state, nextstate;

    logic [20:0] counter;

    parameter counter_limit = 'd1;

    // Build State Registers
    always_ff@(posedge clk)
		begin
        if (~nrst)
            begin
                state <= S0;
                counter <= 'b0;
            end
		else if (counter >= counter_limit)
			begin
				state <= nextstate;
				counter <= 'b0;
			end
        else 
            begin
                state <= nextstate;
                counter <= counter + 'b1;
            end 
		end
			
    // Next State Logic
    always_comb
            case(state)
                S0: nextstate = S1;
                S1: if (counter == counter_limit) nextstate = S2;
                   else nextstate = S1;
                S2: if (counter == counter_limit) nextstate = S1;
                   else nextstate = S2; 
				default: nextstate = S0; // Weird behavior with this line
            endcase

    //Output Logic
    always_comb
        begin
            case(state)
                S0: 
                    begin
                        current_hex = 'b0; // 1st hex number will be displayed
                        hex1_num = 'b1;    // No current is supplied to the first hex number
                        hex2_num = 'b1;    // No current is supplied to the second hex number
                    end
                S1:
                    begin
                        current_hex = 'b0; // 1st hex number will be displayed
                        hex1_num = 'b0;    // Current is supplied to the first hex number
                        hex2_num = 'b1;    // No current is supplied to the second hex number
                    end
                S2:
                    begin
                        current_hex = 'b1; // 2nd hex number will be displayed
                        hex1_num = 'b1;    // No current is supplied to the first hex number
                        hex2_num = 'b0;    // Current is supplied to the second hex number
                    end
				default: // default to state 0 output logic
					begin
                        current_hex = 'b0;
                        hex1_num = 'b1;
                        hex2_num = 'b1;
                    end 
					
            endcase
        end
endmodule