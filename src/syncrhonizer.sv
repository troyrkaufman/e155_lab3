//Author: Troy Kaufman
// Email: tkaufman@hmc.edu
// Date: 9/15/24

/*

*/

module synchronizer(input logic clk, nrst,
                    input logic data_d,
                    output logic data_q);

    logic n1;

    always_ff@(posedge clk)
        begin
			if (~nrst) begin
				n1 <= 1'b0;
				data_q <= 1'b0;
			end
			else begin
				n1 <= data_d;
				data_q <= n1;
			end
        end

endmodule