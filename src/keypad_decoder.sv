

module keypad_decoder(input logic [3:0] row_d, col_q,
		      output logic row_bit,
		      output logic [3:0] key_pushed);

	always_comb
		case ({col_q, row_d})
			8'b00010001: begin key_pushed = 'h1; row_bit = row_d[0]; end
			8'b00010010: begin key_pushed = 'h4; row_bit = row_d[1]; end
			8'b00010100: begin key_pushed = 'h7; row_bit = row_d[2]; end
			8'b00011000: begin key_pushed = 'hE; row_bit = row_d[3]; end
			8'b00100001: begin key_pushed = 'h2; row_bit = row_d[0]; end
			8'b00100010: begin key_pushed = 'h5; row_bit = row_d[1]; end
			8'b00100100: begin key_pushed = 'h8; row_bit = row_d[2]; end
			8'b00101000: begin key_pushed = 'h0; row_bit = row_d[3]; end
			8'b01000001: begin key_pushed = 'h3; row_bit = row_d[0]; end
			8'b01000010: begin key_pushed = 'h6; row_bit = row_d[1]; end
			8'b01000100: begin key_pushed = 'h9; row_bit = row_d[2]; end
			8'b01001000: begin key_pushed = 'hF; row_bit = row_d[3]; end
			8'b10000001: begin key_pushed = 'hA; row_bit = row_d[0]; end
			8'b10000010: begin key_pushed = 'hB; row_bit = row_d[1]; end
			8'b10000100: begin key_pushed = 'hC; row_bit = row_d[2]; end
			8'b10001000: begin key_pushed = 'hD; row_bit = row_d[3]; end
			default: begin key_pushed = 'hx; row_bit = 1'b0; end
		endcase
endmodule
