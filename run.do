vcom -novopt -work system *.vhd
vsim -t ps -novopt system.tb_top

add log -r *
do wave.do
run 100 us

