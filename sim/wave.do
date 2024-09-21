onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab3_tk_tb/int_osc
add wave -noupdate /lab3_tk_tb/nrst
add wave -noupdate /lab3_tk_tb/row_d
add wave -noupdate /lab3_tk_tb/dut/scan/col_q
add wave -noupdate -radix hexadecimal /lab3_tk_tb/dut/scan/key_pushed
add wave -noupdate -color Gold /lab3_tk_tb/dut/scan/current_state
add wave -noupdate /lab3_tk_tb/dut/scan/next_state
add wave -noupdate /lab3_tk_tb/dut/keydec/row_bit
add wave -noupdate -radix unsigned /lab3_tk_tb/dut/dbnc/counter
add wave -noupdate /lab3_tk_tb/dut/dbnc/pulse_en
add wave -noupdate /lab3_tk_tb/dut/dbnc/current_state
add wave -noupdate /lab3_tk_tb/dut/dbnc/next_state
add wave -noupdate -color {Medium Spring Green} -radix hexadecimal /lab3_tk_tb/dut/slide/current_num
add wave -noupdate -color {Sky Blue} -radix hexadecimal /lab3_tk_tb/dut/slide/prev_num
add wave -noupdate -radix hexadecimal /lab3_tk_tb/dut/segdec/s1
add wave -noupdate -radix hexadecimal /lab3_tk_tb/dut/segdec/s2
add wave -noupdate /lab3_tk_tb/dut/segdec/seg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {634 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 255
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {422 ns}
