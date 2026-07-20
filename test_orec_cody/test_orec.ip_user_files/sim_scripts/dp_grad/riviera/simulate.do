transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+dp_grad  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.dp_grad xil_defaultlib.glbl

do {dp_grad.udo}

run 1000ns

endsim

quit -force
