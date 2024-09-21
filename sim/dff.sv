

module dff(input logic clk, nrst,
	   input logic [3:0] data_d,
	   output logic [3:0] data_q);

	always_ff @(posedge clk)
		if (~nrst)
			data_q <= 4'b0;
		else 
			data_q <= data_d);
endmodule 
