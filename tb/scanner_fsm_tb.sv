`timescale 1ns/1ns

module scanner_fsm_tb();
    logic clk, nrst;
    logic [3:0] row_d;
    logic [3:0] col_q_out, col_q, row_q, col_q_out_expected, col_q_expected, row_q_expected;
    logic [65535:0] vectornum, errors;
    logic [15:0] testvectors [10000:0];

    scanner_fsm dut(clk, nrst, row_d, col_q_out, col_q, row_q);

    always begin
        clk = 1; #5; clk = 0; # 5;
    end

    // At the start of the simulation:
 //  - Load the testvectors
 //  - Pulse the reset line (if applicable)
 initial
   begin
     $readmemb("scanner_fsm_tv.tv", testvectors, 0);
     vectornum = 0; errors = 0;
     nrst = 0; #27; nrst = 1;
   end
  // Apply test vector on the rising edge of clk
 always @(posedge clk)
   begin
       #1; {row_d, col_q_out, col_q, row_q, col_q_expected, col_q_expected, row_q_expected} = testvectors[vectornum];
   end
  initial
 begin
   // Create dumpfile for signals
   $dumpfile("scanner_fsm_tb.vcd");
   $dumpvars(0, scanner_fsm_tb);
 end
  // Check results on the falling edge of clk
 always @(negedge clk)
   begin
     if (~nrst) // skip during reset
       begin
         if (col_q_out != col_q_out_expected || col_q != col_q_expected || row_q != row_q_expected)
           begin
             $display("Error: inputs: nrst=%b, row_d=%b", nrst, row_d);
             $display(" outputs: col_q_out=%b (%b expected), col_q=%b (%b expected), row_q=%b (%b expected)", col_q_out, col_q_out_expected, col_q, col_q_expected, row_q, row_q_expected);
             errors = errors + 1;
           end

      
       vectornum = vectornum + 1;
      
       if (testvectors[vectornum] === 11'bx)
         begin
           $display("%d tests completed with %d errors.", vectornum, errors);
           $finish;
         end
     end
   end
endmodule