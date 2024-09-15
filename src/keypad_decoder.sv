

module keypad_decoder(input logic [3:0] col_d, row_d,
                      output logic row_q, // needed for debouncer_dsm
                      output logic [3:0] key_pushed)

    logic [1:0] encoded_row_row_q;

    always_comb begin
        case(col_d)
            0001: case (row_d)
                    0001: begin key_pushed = 'ha; encoded_row_row_q = 'd1; end
                    0010: begin key_pushed = 'h7; encoded_row_row_q = 'd2; end
                    0100: begin key_pushed = 'h4; encoded_row_row_q = 'd3; end
                    1000: begin key_pushed = 'h1; encoded_row_row_q = 'd4; end
                    default: key_pushed = 'h0;
                  endcase
            0010: case (row_d)
                    0001: begin key_pushed = 'h0; encoded_row_row_q = 'd1; end
                    0010: begin key_pushed = 'h8; encoded_row_row_q = 'd2; end
                    0100: begin key_pushed = 'h5; encoded_row_row_q = 'd3; end
                    1000: begin key_pushed = 'h2; encoded_row_row_q = 'd4; end
                     default: key_pushed = 'h0;
                  endcase
            0100: case (row_d)
                    0001: begin key_pushed = 'hb; encoded_row_row_q = 'd1; end
                    0010: begin key_pushed = 'h9; encoded_row_row_q = 'd2; end
                    0100: begin key_pushed = 'h6; encoded_row_row_q = 'd3; end
                    1000: begin key_pushed = 'h3; encoded_row_row_q = 'd4; end
                     default: key_pushed = 'h0;
                  endcase
            1000: case (row_d)
                    0001: begin key_pushed = 'hf; encoded_row_row_q = 'd1; end
                    0010: begin key_pushed = 'he; encoded_row_row_q = 'd2; end
                    0100: begin key_pushed = 'hd; encoded_row_row_q = 'd3; end
                    1000: begin key_pushed = 'hc; encoded_row_row_q = 'd4; end
                     default: key_pushed = 'h0;
                  endcase
            default: key_pushed = 'h0;
        endcase

        if (encoded_row_row_q == 'd1) row_q = row_d[0];
        else if (encoded_row_row_q == 'd2) row_q = row_d[1];
        else if (encoded_row_row_q == 'd3) row_q = row_d[2];
        else if (encoded_row_row_q == 'd4) row_q = row_d[3];
        else row_q = row_d[0];
    end

endmodule