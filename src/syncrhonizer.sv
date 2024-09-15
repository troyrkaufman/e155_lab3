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
            n1 <= data_d;
            data_q <= n1;
        end

endmodule