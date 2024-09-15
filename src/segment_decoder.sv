

// Author: Troy Kaufman
// Email: tkaufman@g.hmc.edu
// Date: 9/6/24

/*
    This module sends the current hexadecimal number to the dual 7-segment display based on the hex_num_controller.sv timing FSM
*/

module segment_decoder (input logic current_hex,
                    input logic [3:0] s1, s2,
                    output logic [6:0] seg);
    
    logic [3:0] switch;
    
    //Properly decode the seven segement display
    always_comb
        begin
            if (~current_hex) switch = s1;
            else              switch = s2;
            case (switch)
                0:      seg = 7'b100_0000;
                1:      seg = 7'b111_1001; 
                2:      seg = 7'b010_0100;
                3:      seg = 7'b011_0000;
                4:      seg = 7'b001_1001;
                5:      seg = 7'b001_0010;
                6:      seg = 7'b000_0010;
                7:      seg = 7'b111_1000;
                8:      seg = 7'b000_0000;
                9:      seg = 7'b001_1000;
                10:     seg = 7'b000_1000;
                11:     seg = 7'b000_0011;
                12:     seg = 7'b100_0110;
                13:     seg = 7'b010_0001;
                14:     seg = 7'b000_0110;
                15:     seg = 7'b000_1110;
                default: seg = 7'b100_0000;
            endcase
        end
endmodule