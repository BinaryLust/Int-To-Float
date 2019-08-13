onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /intToFloat_tb/dut/clk
add wave -noupdate /intToFloat_tb/dut/reset
add wave -noupdate -radix decimal /intToFloat_tb/dut/a
add wave -noupdate -radix float32 /intToFloat_tb/dut/result
add wave -noupdate /intToFloat_tb/dut/zero
add wave -noupdate /intToFloat_tb/dut/absValue
add wave -noupdate -radix unsigned /intToFloat_tb/dut/immExponent
add wave -noupdate /intToFloat_tb/dut/immFraction
add wave -noupdate -radix unsigned /intToFloat_tb/dut/leadingZeros
add wave -noupdate -radix unsigned /intToFloat_tb/dut/roundedExponent
add wave -noupdate /intToFloat_tb/dut/roundedFraction
add wave -noupdate /intToFloat_tb/dut/fractionLSB
add wave -noupdate /intToFloat_tb/dut/roundBit
add wave -noupdate /intToFloat_tb/dut/stickyBit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1115000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
configure wave -valuecolwidth 209
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
configure wave -timelineunits ps
update
WaveRestoreZoom {8841600 ps} {10182100 ps}
