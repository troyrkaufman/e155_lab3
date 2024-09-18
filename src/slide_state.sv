

module slide_state(input logic clk, nrst,
        input logic pulse_en,
        input logic [3:0] key_pushed,
        output logic [3:0] current_num, prev_num);

	//logic key_wait;
	//logic keep_num;
	//logic [3:0] ex;
	//logic [3:0] current_num_reg, prev_num_reg;

	always_ff@ (posedge clk)
		if (~nrst) begin 
		current_num <= 4'b0000;
		prev_num <= 4'b0000;
		end
		else if (pulse_en) begin
		prev_num <= current_num;
		current_num <= key_pushed;
		end
		else prev_num <= prev_num;
		
		

   /* always_ff@(posedge clk)
            if (~nrst) begin
                current_num <= 'b0000;
                prev_num <= 'b0000;
            end
            else if (pulse_en) begin
                current_num <= key_pushed;
                prev_num <= prev_num;
            end
	else 
	prev_num <= current_num;
		
	logic [3:0] next_cur, cur_holder, prev_holder;

	always_ff@(posedge clk)
		if (~nrst) begin
			cur_holder <= 4'b0;
			prev_holder <= 4'b0;
			next_cur <= 4'b0;
			end
		else begin
				
			if(pulse_en) next_cur <= key_pushed;
			else next_cur <= next_cur; begin
			prev_holder <= cur_holder;
			cur_holder <= next_cur;
			end
		end

	assign current_num = cur_holder;
	assign prev_num = prev_holder;
*/
endmodule