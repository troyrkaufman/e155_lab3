

module slide_state(input logic clk, nrst,
        input logic pulse_en, 
        input logic [3:0] key_pushed,
        output logic [3:0] current_num, prev_num);

	always_ff@ (posedge clk)
		if (~nrst) begin 
			current_num <= 4'b0000;
			prev_num <= 4'b0000;
		end
		else if (pulse_en == 1'b1) begin
			prev_num <= current_num;
			current_num <= key_pushed;
		end
		else prev_num <= prev_num;
endmodule