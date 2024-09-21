

module keypad_decoder(input logic clk, nrst,
			input logic [3:0] row_d, key_pushed,
                      output logic row_bit,
			output logic [3:0] remain_key_pushed);

  //  logic [1:0] encoded_row_q;
  	always_ff @(posedge clk)
		if (nrst)
			remain_key_pushed <= 4'b0000;
		else
			remain_key_pushed <= key_pushed;
	always_comb
	if (row_d[0] == 1'b1)
		row_bit = row_d[0];
	else if (row_d[1] == 1'b1)
		row_bit = row_d[1];
	else if (row_d[2] == 1'b1)
		row_bit = row_d[2];
	else if (row_d[3] == 1'b1)
		row_bit = row_d[3];
	else row_bit = 1'b0;
endmodule