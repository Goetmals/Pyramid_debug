@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim TEST_PYRAMID_behav -key {Behavioral:sim_1:Functional:TEST_PYRAMID} -tclbatch TEST_PYRAMID.tcl -view C:/Users/frede/OneDrive/Documents/testbench_eads/test_grad_imv/TEST_PYRAMID_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
