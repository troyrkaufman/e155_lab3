

module slide_state(input logic clk, nrst,
        input logic pulse_en;
        input logic [3:0] key_pushed,
        output logic [3:0] current_num, prev_num);

    always_ff@(posedge clk)
        begin 
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
        end

endmodule