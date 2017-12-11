onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/rst
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/enable
add wave -noupdate /tb_top/data_in
add wave -noupdate /tb_top/dataout
add wave -noupdate /tb_top/dataval
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60162162 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {105 us}
