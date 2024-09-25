

module keypad_decoder(input logic [3:0] row_dec, col_dec, col_q,
		      output logic row_bit,
		      output logic [3:0] key_pushed);

	always_comb
		casex ({col_dec, row_dec})
			8'b00010001: begin key_pushed = 'h1; row_bit = row_dec[0]; end
			8'b00010010: begin key_pushed = 'h4; row_bit = row_dec[1]; end
			8'b00010100: begin key_pushed = 'h7; row_bit = row_dec[2]; end
			8'b00011000: begin key_pushed = 'hE; row_bit = row_dec[3]; end
			8'b00100001: begin key_pushed = 'h2; row_bit = row_dec[0]; end
			8'b00100010: begin key_pushed = 'h5; row_bit = row_dec[1]; end
			8'b00100100: begin key_pushed = 'h8; row_bit = row_dec[2]; end
			8'b00101000: begin key_pushed = 'h0; row_bit = row_dec[3]; end
			8'b01000001: begin key_pushed = 'h3; row_bit = row_dec[0]; end
			8'b01000010: begin key_pushed = 'h6; row_bit = row_dec[1]; end
			8'b01000100: begin key_pushed = 'h9; row_bit = row_dec[2]; end
			8'b01001000: begin key_pushed = 'hF; row_bit = row_dec[3]; end
			8'b10000001: begin key_pushed = 'hA; row_bit = row_dec[0]; end
			8'b10000010: begin key_pushed = 'hB; row_bit = row_dec[1]; end
			8'b10000100: begin key_pushed = 'hC; row_bit = row_dec[2]; end
			8'b10001000: begin key_pushed = 'hD; row_bit = row_dec[3]; end

			default: begin key_pushed = 'hx; if ((col_q == 4'b1111)) row_bit = 1'b1; else row_bit = 1'b0; end
			//8'bxxxxxxxx: begin key_pushed = 'hx; row_bit = 1'b1; end // Added line to keep prev_num <= current_num on multiple button presses with releases
			//default: begin key_pushed = 'hx; row_bit = 1'b0; end
		endcase
endmodule
