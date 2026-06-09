@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto c7ede66411364787a5a4d40f832260f4 -m64 --debug typical --relax --mt 2 -L blk_mem_gen_v8_3_5 -L xil_defaultlib -L work -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot TEST_PYRAMID_behav work.TEST_PYRAMID work.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
