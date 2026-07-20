onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib dp_conv_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {dp_conv.udo}

run 1000ns

quit -force
