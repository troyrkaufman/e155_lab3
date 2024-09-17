

module keypad_decoder(input logic [3:0] row_d,
                      output logic row_bit);

  //  logic [1:0] encoded_row_q;
	always_comb
	if (row_d[0] ^ 1'b1 == 1'b1)
		row_bit = row_d[0];
	else if (row_d[1] ^ 1'b1 == 1'b1)
		row_bit = row_d[0];
	else if (row_d[2] ^ 1'b1 == 1'b1)
		row_bit = row_d[0];
	else if (row_d[3] ^ 1'b1 == 1'b1)
		row_bit = row_d[0];
	else row_bit = 1'b0;
/*
    always_comb begin
        case(col_d)
            4'b0001: case (row_d)
                    4'b0001: begin key_pushed = 'ha; encoded_row_q = 2'b00; end
                    4'b0010: begin key_pushed = 'h7; encoded_row_q = 2'b01; end
                    4'b0100: begin key_pushed = 'h4; encoded_row_q = 2'b10; end
                    4'b1000: begin key_pushed = 'h1; encoded_row_q = 2'b11; end
                    default: begin key_pushed = 'h0; encoded_row_q = 2'b00; end
                  endcase
            4'b0010: case (row_d)
                    4'b0001: begin key_pushed = 'h0; encoded_row_q = 2'b00; end
                    4'b0010: begin key_pushed = 'h8; encoded_row_q = 2'b01; end
                    4'b0100: begin key_pushed = 'h5; encoded_row_q = 2'b10; end
                    4'b1000: begin key_pushed = 'h2; encoded_row_q = 2'b11; end
                     default: begin key_pushed = 'h0; encoded_row_q = 2'b00; end
                  endcase
            4'b0100: case (row_d)
                    4'b0001: begin key_pushed = 'hb; encoded_row_q = 2'b00; end
                    4'b0010: begin key_pushed = 'h9; encoded_row_q = 2'b01; end
                    4'b0100: begin key_pushed = 'h6; encoded_row_q = 2'b10; end
                    4'b1000: begin key_pushed = 'h3; encoded_row_q = 2'b11; end
                     default: begin key_pushed = 'h0; encoded_row_q = 2'b00; end
                  endcase
            4'b1000: case (row_d)
                    4'b0001: begin key_pushed = 'hf; encoded_row_q = 2'b00; end
                    4'b0010: begin key_pushed = 'he; encoded_row_q = 2'b01; end
                    4'b0100: begin key_pushed = 'hd; encoded_row_q = 2'b10; end
                    4'b1000: begin key_pushed = 'hc; encoded_row_q = 2'b11; end
                     default: begin key_pushed = 'h0; encoded_row_q = 2'b00; end
                  endcase
            default: begin key_pushed = 'h0; encoded_row_q = 2'b00; end
        endcase
*/

/*
        if (encoded_row_q == 2'b00) row_bit = row_d[0];
        else if (encoded_row_q == 2'b01) row_bit = row_d[1];
        else if (encoded_row_q == 2'b10) row_bit = row_d[2];
        else if (encoded_row_q == 2'b11) row_bit = row_d[3];
        else row_bit = row_d[0];

    end
*/
endmodule