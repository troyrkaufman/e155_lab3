

module slide_state(input logic clk, nrst,
        input logic input_num,
        output logic current_num, prev_num);

    always_ff@(posedge clk)
        begin 
            prev_num <= current_num;

        end

endmodule