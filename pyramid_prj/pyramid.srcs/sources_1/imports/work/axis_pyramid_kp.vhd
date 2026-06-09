----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2015 15:41:00
-- Design Name: 
-- Module Name: axis_pyramid_kp - IMP
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- axis_kp.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          axis_kp.vhd
-- Version:           1.00.b
-- Description:       Top level design, instantiates library components and user logic.
-- Date:              Tue Mar 26 14:01:10 2013 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.user_logic;



entity axis_pyramid_kp is
  generic
  (
    
	MAX_SIZE_LIST                  : positive             := 32
  );
  port
  (
--------------------------------------------------------------------------------
-- Global Reset
--------------------------------------------------------------------------------
		resetn							: in std_logic;
--------------------------------------------------------------------------------
-- AXIS Clock
--------------------------------------------------------------------------------
		aclk : in std_logic;
--------------------------------------------------------------------------------
-- AXIS Slave 0 side
--------------------------------------------------------------------------------
		S00_AXIS_TVALID : in std_logic;
		S00_AXIS_TUSER : in std_logic;
		S00_AXIS_TLAST : in std_logic;
		S00_AXIS_TREADY : out std_logic;
		S00_AXIS_TDATA : in std_logic_vector(7 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master 0 side
--------------------------------------------------------------------------------
		M00_AXIS_TVALID : out std_logic;
		M00_AXIS_TUSER : out std_logic;
		M00_AXIS_TLAST : out std_logic;
		M00_AXIS_TREADY : in std_logic;
        M00_AXIS_TDATA : out std_logic_vector(7 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master 1 side
--------------------------------------------------------------------------------
		M01_AXIS_TVALID : out std_logic;
		M01_AXIS_TUSER : out std_logic;
		M01_AXIS_TLAST : out std_logic;
		M01_AXIS_TREADY : in std_logic;
        M01_AXIS_TDATA : out std_logic_vector(7 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master 2 side
--------------------------------------------------------------------------------
		M02_AXIS_TVALID : out std_logic;
		M02_AXIS_TUSER : out std_logic;
		M02_AXIS_TLAST : out std_logic;
		M02_AXIS_TREADY : in std_logic;
        M02_AXIS_TDATA : out std_logic_vector(7 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master 3 side
--------------------------------------------------------------------------------
		M03_AXIS_TVALID : out std_logic;
		M03_AXIS_TUSER : out std_logic;
		M03_AXIS_TLAST : out std_logic;
		M03_AXIS_TREADY : in std_logic;
        M03_AXIS_TDATA : out std_logic_vector(7 downto 0)
  );

    
end entity axis_pyramid_kp;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axis_pyramid_kp is

  
  signal GND16                          : std_logic_vector(15 downto 0) := (others=>'0');
  signal GND24                          : std_logic_vector(23 downto 0) := (others=>'0');
  
begin

  
 
  ------------------------------------------
  -- instantiate User Logic
  ------------------------------------------
  --USER_LOGIC_I : entity axis_pyramid_kp_v1_00_a.user_logic
  USER_LOGIC_I : entity work.user_logic
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      MAX_SIZE_LIST                  => MAX_SIZE_LIST
    )
    port map
    (
--------------------------------------------------------------------------------
-- Global Reset
--------------------------------------------------------------------------------
		resetn => resetn,
--------------------------------------------------------------------------------
-- AXIS Clock
--------------------------------------------------------------------------------
		aclk => aclk,
--------------------------------------------------------------------------------
-- AXIS Slave 0 side
--------------------------------------------------------------------------------
		S00_AXIS_TVALID => S00_AXIS_TVALID,
		S00_AXIS_TUSER => S00_AXIS_TUSER,
		S00_AXIS_TLAST => S00_AXIS_TLAST,
		S00_AXIS_TREADY => S00_AXIS_TREADY,
		S00_AXIS_TDATA => S00_AXIS_TDATA,
--------------------------------------------------------------------------------
-- AXIS Master 0 side
--------------------------------------------------------------------------------
		M00_AXIS_TVALID => M00_AXIS_TVALID,
		M00_AXIS_TUSER => M00_AXIS_TUSER,
		M00_AXIS_TLAST => M00_AXIS_TLAST,
		M00_AXIS_TREADY => M00_AXIS_TREADY,
		M00_AXIS_TDATA => M00_AXIS_TDATA,
--------------------------------------------------------------------------------
-- AXIS Master 1 side
--------------------------------------------------------------------------------
		M01_AXIS_TVALID => M01_AXIS_TVALID,
		M01_AXIS_TUSER => M01_AXIS_TUSER,
		M01_AXIS_TLAST => M01_AXIS_TLAST,
		M01_AXIS_TREADY => M01_AXIS_TREADY,
		M01_AXIS_TDATA => M01_AXIS_TDATA,
--------------------------------------------------------------------------------
-- AXIS Master 2 side
--------------------------------------------------------------------------------
		M02_AXIS_TVALID => M02_AXIS_TVALID,
		M02_AXIS_TUSER => M02_AXIS_TUSER,
		M02_AXIS_TLAST => M02_AXIS_TLAST,
		M02_AXIS_TREADY => M02_AXIS_TREADY,
		M02_AXIS_TDATA => M02_AXIS_TDATA,
--------------------------------------------------------------------------------
-- AXIS Master 3 side
--------------------------------------------------------------------------------
		M03_AXIS_TVALID => M03_AXIS_TVALID,
		M03_AXIS_TUSER => M03_AXIS_TUSER,
		M03_AXIS_TLAST => M03_AXIS_TLAST,
		M03_AXIS_TREADY => M03_AXIS_TREADY,
		M03_AXIS_TDATA => M03_AXIS_TDATA
    );

 
end IMP;