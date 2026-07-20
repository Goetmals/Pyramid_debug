transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {/home/demelo/vivado_prjs/testbench_eads/test_orec_cody/test_orec.cache/compile_simlib/riviera}
vlib riviera/xpm
vlib riviera/xil_defaultlib

vlog -work xpm  -incr -l xpm -l xil_defaultlib \
"/home/demelo/Xilinx_2023/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/home/demelo/Xilinx_2023/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../../test_orec.gen/sources_1/ip/dp_conv/dp_conv_sim_netlist.vhdl" \


vlog -work xil_defaultlib \
"glbl.v"

